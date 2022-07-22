# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]
  after_action :verify_authorized, except: %i[index new create]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = current_user.accounts
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    authorize @account
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    authorize @account
    @email = @account.email
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new

    @email = account_params[:email]
    password = account_params[:password]

    if (session = LoginService.perform_login @email, password)
      @account.username = session.username
      @account.email = @email
      @account.id = session.user_id
      @account.session_id = session.session_id
      @account.expiration = session.expiration
      @account.user = current_user
    else
      flash.now[:alert] = I18n.t("accounts.invalid_username_password")
    end

    respond_to do |format|
      if session && @account.save
        format.html { redirect_to @account, notice: I18n.t("accounts.account_linked") }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    authorize @account

    @email = account_params[:email]
    password = account_params[:password]

    if (session = LoginService.perform_login @email, password)
      @account.email = @email
      @account.username = session.username
      @account.session_id = session.session_id
      @account.expiration = session.expiration
      correct_account = session.user_id == @account.id
    else
      flash.now[:alert] = I18n.t("accounts.invalid_username_password")
    end

    flash.now[:alert] = I18n.t("accounts.invalid_account") if session && !correct_account

    respond_to do |format|
      if correct_account && session && @account.save
        format.html { redirect_to @account, notice: I18n.t("accounts.account_linked") }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    authorize @account

    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: I18n.t("accounts.account_unlinked") }
      format.json { head :no_content }
    end
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.permit(:password, :email)
    end
end
