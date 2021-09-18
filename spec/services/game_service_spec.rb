require 'spec_helper'

RSpec.describe GameService do

  let(:account_id) { 123 }
  let(:session_id) { "a12b" }

  let(:client) { double() }
  let(:account) { double(Account, id: account_id, session_id: session_id ) }

  before { allow(TriviaCrack::API::Client).to receive(:new) { client } }
  before { allow(client).to receive(:set_session).with session_id, account_id }

  describe '.get_games' do
    subject { GameService.get_games account }

    context 'when the API client returns an error' do
      before { allow(client).to receive(:get_games).and_raise TriviaCrack::Errors::RequestError.new 400, "", {} }

      it { is_expected.to be false }
    end

    context 'when the API client call is succesful' do
      before { allow(client).to receive(:get_games).and_return game }
      let(:game) { double(TriviaCrack::Game) }

      it { is_expected.to be game }
    end
  end

  describe '.new_game' do
    subject { GameService.new_game account }

    context 'when the API client returns an error' do
      before { allow(client).to receive(:start_new_game).and_raise TriviaCrack::Errors::RequestError.new 400, "", {} }

      it { is_expected.to be false }
    end

    context 'when the API client call is successful' do
      before { allow(client).to receive(:start_new_game).and_return game }
      let(:game) { double(TriviaCrack::Game) }

      it { is_expected.to be game }
    end
  end
end
