# frozen_string_literal: true

class GamesController < ApplicationController
  after_action :verify_authorized, except: %i[index new]
  before_action :set_account, only: %i[create play_game]

  # GET /games
  # GET /games.json
  def index
    @accounts = current_user.accounts
    @games = []
    @queued_games = []

    @accounts.each do |account|
      if (games = GameService.get_games account)
        games.each do |game|
          @games << { account: account, game: game }
        end
      end

      @queued_games += account.queued_games.map(&:game_id)
    end

    @games.sort_by { |item| item[:game].expiration_date }

    @playable_games   = @games.select { |item| item[:game].playable? }
    @their_turn_games = @games.select { |item| !item[:game].playable? && item[:game].game_status == :active }
    @pending_games    = @games.select { |item| !item[:game].playable? && item[:game].game_status == :pending_approval }
    @finished_games   = @games.select { |item| item[:game].game_status == :ended }
  end

  # GET /games/new
  def new
    @accounts = []

    current_user.accounts.each do |account|
      user = UserService.get_user account
      @accounts << account if user.unlimited_lives || user.lives.positive?
    end
  end

  # POST /games
  # POST /games.json
  def create
    authorize @account

    @game = GameService.new_game @account

    respond_to do |format|
      if @game
        format.html { redirect_to games_url, notice: I18n.t("games.new_game_created", username: @account.username) }
        format.json { head :created }
      else
        format.html do
          redirect_to new_game_url, alert: I18n.t("games.unable_to_create_game", username: @account.username)
        end
        format.json { head :error }
      end
    end
  end

  # PATCH/PUT /accounts/1/games/1
  # PATCH/PUT /accounts/1/games/1.json
  def play_game
    authorize @account

    game_id = game_params[:game_id]

    PlayGameJob.perform_later @account.id, @account.session_id, game_id

    respond_to do |format|
      format.html { redirect_to games_url, notice: I18n.t("games.game_added_to_queue") }
      format.json { head :ok }
    end
  end

  private
    def set_account
      @account = Account.find(params[:account_id])
    end

    def game_params
      params.permit(:account_id, :game_id)
    end
end
