require 'spec_helper'

RSpec.describe LoginService do

  let(:client) { double() }
  before { allow(TriviaCrack::API::Client).to receive(:new) { client } }

  describe '.perform_login' do

    let(:email) { "user@example.com" }
    let(:password) { "password123" }

    subject { LoginService.perform_login email, password }

    context 'when the API client returns an error' do
      before { allow(client).to receive(:login).and_raise TriviaCrack::Errors::RequestError.new 400, "", {} }

      it { is_expected.to be false }
    end

    context 'when the API client call is succesful' do
      before { allow(client).to receive(:login).and_return user }
      let(:user) { double(TriviaCrack::User) }

      it { is_expected.to be user }
    end
  end
end
