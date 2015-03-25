require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  let(:user) { create(:user_with_accounts) }

  before { sign_in user }

  describe 'GET #index' do

    let(:action) { get :index }

    # TriviaCrack::Game
    let(:game) { double(id: game_id, expiration_date: expiration, playable?: playable, game_status: game_status) }
    let(:game_id) { Faker::Number.number(5) }
    let(:expiration) { Faker::Time.forward(20) }
    let(:playable) { true }
    let(:game_status) { :active }

    # TriviaCrack::User - opponent
    let(:opponent) { double(username: username, facebook_id: facebook_id, facebook_name: facebook_name) }
    let(:username) { Faker::Internet.user_name }
    let(:facebook_name) { Faker::Name.name }
    let(:facebook_id) { Faker::Lorem.characters(20) }

    # TriviaCrack::GameStatistics - my statistics
    let(:my_statistics) { double(crowns: my_crowns) }
    let(:my_crowns) { [:arts] }

    # TriviaCrack::GameStatistics - their statistics
    let(:opponent_statistics) { double(crowns: their_crowns) }
    let(:their_crowns) { [:arts, :science] }

    before { allow(game).to receive(:opponent) { opponent } }
    before { allow(game).to receive(:my_statistics) { my_statistics } }
    before { allow(game).to receive(:opponent_statistics) { opponent_statistics } }

    before { allow(GameService).to receive(:get_games) { [game] } }

    before { action }

    context 'when the game is playable' do
      let(:playable) { true }

      it { expect(assigns :playable_games).to_not be_empty }
      it { expect(assigns :their_turn_games).to be_empty }
      it { expect(assigns :pending_games).to be_empty }
      it { expect(assigns :finished_games).to be_empty }
    end

    context 'when the game is not playable' do
      let(:playable) { false }

      context 'when the game status is active' do
        let(:game_status) { :active }

        it { expect(assigns :playable_games).to be_empty }
        it { expect(assigns :their_turn_games).to_not be_empty }
        it { expect(assigns :pending_games).to be_empty }
        it { expect(assigns :finished_games).to be_empty }
      end

      context 'when the game status is pending approval' do
        let(:game_status) { :pending_approval }

        it { expect(assigns :playable_games).to be_empty }
        it { expect(assigns :their_turn_games).to be_empty }
        it { expect(assigns :pending_games).to_not be_empty }
        it { expect(assigns :finished_games).to be_empty }
      end
    end

    context 'when the game status is ended' do
      let(:playable) { false }
      let(:game_status) { :ended }

      it { expect(assigns :playable_games).to be_empty }
      it { expect(assigns :their_turn_games).to be_empty }
      it { expect(assigns :pending_games).to be_empty }
      it { expect(assigns :finished_games).to_not be_empty }
    end

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :index }
  end

  describe 'GET #new' do

    let(:action) { get :new }

    # TriviaCrack::User
    let(:username) { Faker::Internet.user_name }
    let(:unlimited_lives) { false }
    let(:lives) { 3 }
    let(:tc_user) { double(username: username, lives: lives, unlimited_lives: unlimited_lives) }

    before { allow(UserService).to receive(:get_user) { tc_user } }

    before { action }

    context 'given that the account has unlimited lives' do
      let(:unlimited_lives) { true }
      let(:lives) { 0 }

      subject { assigns(:accounts) }

      its(:size) { is_expected.to be 1 }
    end

    context 'given that the account has no lives' do
      let(:unlimited_lives) { false }
      let(:lives) { 0 }

      subject { assigns(:accounts) }

      its(:size) { is_expected.to be 0 }
    end

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :new }
  end

  describe 'POST #create' do

    let(:action) { post :create, account_id: account_id }

    # Account
    before { create(:account, id: account_id, user: user, session_id: session_id) }
    let(:account_id) { 12345 }
    let(:session_id) { Faker::Lorem.characters(20) }

    before { allow(GameService).to receive(:new_game) { game } }

    before { action }

    context 'given that the game cannot be found' do
      let(:game) { false }

      it { is_expected.to redirect_to new_game_url }
    end

    context 'given that the game can be found' do
      let(:game) { double() }

      it { is_expected.to redirect_to games_url }
    end
  end

  describe 'PUT #play_game' do

    let(:action) { put :play_game, account_id: account_id, game_id: game_id }

    # Account
    before { create(:account, id: account_id, user: user, session_id: session_id) }
    let(:account_id) { 12345 }
    let(:session_id) { Faker::Lorem.characters(20) }

    let(:game_id) { Faker::Number.number(4) }

    it { expect{ action }.to enqueue_a(PlayGameJob).with account_id, session_id, game_id }
  end
end
