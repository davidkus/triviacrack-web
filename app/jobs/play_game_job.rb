class PlayGameJob < ActiveJob::Base
  queue_as :default

  after_enqueue :add_to_queued_games

  after_perform :remove_from_queued_games

  rescue_from TriviaCrack::Errors::RequestError do |exception|
    remove_from_queued_games
  end

  def perform(account_id, session, game_id)
    client = TriviaCrack::API::Client.new

    client.set_session session, account_id

    game = client.get_game game_id

    while game.playable? do
      question = game.questions.first
      answer = question.correct_answer
      game, result = client.answer_question game.id, question, answer
    end
  end

  def add_to_queued_games
    account_id = self.arguments.first
    game_id = self.arguments.last

    queued_game = QueuedGame.new account_id: account_id, game_id: game_id

    queued_game.save
  end

  def remove_from_queued_games
    account_id = self.arguments.first
    game_id = self.arguments.last

    QueuedGame.where(account_id: account_id, game_id: game_id).delete_all
  end
end
