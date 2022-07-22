require "rails_helper"

RSpec.describe PlayGameJob, type: :job do
  # Set up game
  let(:game) { double(id: game_id, playable?: true, questions: [question]) }
  let(:question) { double(correct_answer: 1) }

  # Set up client
  let(:client) { double }
  before { allow(TriviaCrack::API::Client).to receive(:new) { client } }
  before { allow(client).to receive(:set_session) }
  before { allow(client).to receive(:get_game).and_return game }

  # Set up job
  let(:account_id) { 1 }
  let(:game_id) { 222 }
  let(:session) { "session" }
  let(:job) { PlayGameJob.new account_id, session, game_id }

  let!(:account) { create(:account, id: account_id) }

  describe "#perform" do
    subject(:perform) { job.perform account_id, session, game_id }

    context "given that any of the requests fail" do
      before { allow(client).to receive(:answer_question).and_raise TriviaCrack::Errors::RequestError.new 400, "", {} }

      specify { expect { perform }.to raise_error TriviaCrack::Errors::RequestError }
    end

    context "given that the requests succeed" do
      let(:next_game_state) { double(id: game_id, playable?: false) }
      before { allow(client).to receive(:answer_question).and_return [next_game_state, true] }

      it "sets the session to the appropriate value" do
        expect(client).to receive(:set_session).with session, account_id
        perform
      end

      it "gets the correct game" do
        expect(client).to receive(:get_game).with game_id
        perform
      end

      it "answers the question with the correct answer" do
        expect(client).to receive(:answer_question).with game_id, question, question.correct_answer
        perform
      end
    end
  end

  describe "#add_to_queued_games" do
    subject(:add_to) { job.add_to_queued_games }

    context "given that this game is not currently queued" do
      specify { expect { add_to }.to change(QueuedGame, :count).by(1) }
    end

    context "given that this game has already been queued" do
      before { create(:queued_game, game_id: game_id, account: account) }

      specify { expect { add_to }.to change(QueuedGame, :count).by(1) }
    end
  end

  describe "#remove_from_queued_games" do
    subject(:remove_from) { job.remove_from_queued_games }

    context "given that this game is no longer queued" do
      specify { expect { remove_from }.to change(QueuedGame, :count).by(0) }
    end

    context "given that this game has been queued" do
      before { create(:queued_game, game_id: game_id, account: account) }

      specify { expect { remove_from }.to change(QueuedGame, :count).by(-1) }
    end

    context "given that this game has been queued multiple times" do
      before { 3.times { create(:queued_game, game_id: game_id, account: account) } }

      specify { expect { remove_from }.to change(QueuedGame, :count).by(-3) }
    end
  end
end
