require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  let(:user) { create(:user) }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  # TriviaCrack::Session
  let(:session) { double(username: username, user_id: user_id, session_id: session_id, expiration: expiration) }
  let(:username) { Faker::Internet.user_name }
  let(:user_id) { 123 }
  let(:session_id) { Faker::Lorem.characters(20) }
  let(:expiration) { Faker::Time.forward(30) }

  # Account
  let(:account) { create(:account, id: account_id, user: user) }
  let(:account_id) { 12345 }

  before { sign_in user }

  describe 'GET #index' do

    let(:action) { get :index }

    before { action }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :index }
  end

  describe 'GET #show' do

    let(:action) { get :show, id: account_id }

    before { account }

    before { action }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :show }
    it { expect(assigns :account).to eq account }
  end

  describe 'GET #new' do

    let(:action) { get :new }

    before { action }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :new }
    it { expect(assigns :account).to be_a_new Account }
  end

  describe 'GET #edit' do

    let(:action) { get :edit, id: account_id }

    before { account }

    before { action }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :edit }
    it { expect(assigns :account).to eq account }
  end

  describe 'POST #create' do

    let(:action) { post :create, email: email, password: password }

    context 'given that the account info provided allows a successful login' do
      before { allow(LoginService).to receive(:perform_login) { session } }

      it { expect{ action }.to change{ user.accounts.count }.by 1 }
    end

    context 'given that the account info provided is invalid' do
      before { allow(LoginService).to receive(:perform_login) { false } }

      it 'returns ok' do
        action
        is_expected.to respond_with :ok
      end

      it 'renders new' do
        action
        is_expected.to render_template :new
      end

      it { expect{ action }.to change{ Account.all.count }.by 0 }
    end
  end

  describe 'PUT #update' do

    let(:action) { put :update, id: account_id, email: email, password: password }

    let(:account_id) { user_id }

    before { account }

    context 'given that the account info provided allows a successful login' do
      before { allow(LoginService).to receive(:perform_login) { session } }

      it { expect{ action }.to change{ Account.find(account_id).session_id }.to session_id }
    end

    context 'given that the account info provided is invalid' do
      before { allow(LoginService).to receive(:perform_login) { false } }

      before { action }

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_template :edit }
      it { expect{ action }.not_to change{ Account.find(account_id).session_id } }
    end

    context 'given that the session returned does not match the account' do
      before { allow(LoginService).to receive(:perform_login) { session } }

      let(:account_id) { 321 }

      before { action }

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_template :edit }
      it { expect{ action }.not_to change{ Account.find(account_id).session_id } }
    end
  end

  describe 'DELETE #destroy' do

    let(:action) { delete :destroy, id: account_id }

    before { account }

    it { expect{ action }.to change{ Account.all.count }.by -1 }
  end
end
