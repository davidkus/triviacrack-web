require 'spec_helper'

RSpec.describe UserService do

  let(:account_id) { 123 }
  let(:session_id) { "a12b" }

  let(:client) { double() }
  let(:account) { double(Account, id: account_id, session_id: session_id ) }

  before { allow(TriviaCrack::API::Client).to receive(:new) { client } }
  before { allow(client).to receive(:set_session).with session_id, account_id }

  describe '.get_user' do
    subject { UserService.get_user account }

    context 'when the API client returns an error' do
      before { allow(client).to receive(:get_user).and_raise TriviaCrack::Errors::RequestError.new 400, "", {} }

      it { is_expected.to be false }
    end

    context 'when the API client call is succesful' do
      before { allow(client).to receive(:get_user).and_return user }
      let(:user) { double(TriviaCrack::User) }

      it { is_expected.to be user }
    end
  end
end
