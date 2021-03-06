class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if (!signed_in? || !current_user.admin)
      redirect_to root_path
    end

    set_promos
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :index, status: :created, location: users_path }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    set_success(true, 'Modifications enregistrées !')
    if !@user.update(user_params)
      set_success(false, get_error_message(@user.errors, "User"))
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    set_success(true, 'Utilisateur supprimé !')
    if !@user.destroy
      set_success(false, get_error_message(@user.errors, "Users"))
    else
      set_promos
    end
  end

  def topUp
    current_user.update_attribute('solde', current_user.solde + 2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_promos
      promos = User.get_all_promos
      @users = Hash.new('promos')
      promos.each do |promo|
        @users[promo['promo']] = User.where('promo = ' + promo['promo']).order('lastname')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      allow = [:lastname, :name, :uid, :email, :admin, :solde, :promo]
      params.require(:user).permit(allow)
    end
end
