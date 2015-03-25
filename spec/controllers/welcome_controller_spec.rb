require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe 'GET #index' do

    let(:action) { get :index }

    let(:user) { create(:user) }

    context 'when the user is a visitor' do
      before { action }

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_template :index }
      it { is_expected.to render_template partial: "_visitor" }
    end

    context 'when the user is signed in' do
      before { sign_in user }
      before { action }

      it { is_expected.to respond_with :ok }
      it { is_expected.to render_template :index }
      it { is_expected.to render_template partial: "_registered" }
    end
  end
end
