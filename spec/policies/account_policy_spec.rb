require "spec_helper"

RSpec.describe AccountPolicy do
  let(:owning_user) { build(:user) }
  let(:account) { build(:account, user: owning_user) }

  subject { AccountPolicy.new user, account }

  context "for the owner of the account" do
    let(:user) { owning_user }

    it { is_expected.to permit_action :show }
    it { is_expected.to permit_action :edit }
    it { is_expected.to permit_action :create }
    it { is_expected.to permit_action :update }
    it { is_expected.to permit_action :destroy }
    it { is_expected.to permit_action :play_game }
  end

  context "for some different user" do
    let(:user) { build(:user) }

    it { is_expected.to_not permit_action :show }
    it { is_expected.to_not permit_action :edit }
    it { is_expected.to_not permit_action :create }
    it { is_expected.to_not permit_action :update }
    it { is_expected.to_not permit_action :destroy }
    it { is_expected.to_not permit_action :play_game }
  end
end
