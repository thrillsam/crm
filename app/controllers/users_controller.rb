class UsersController < ApplicationController
	skip_before_action :authenticate_user, only: [:create]
	before_action :set_user, only: [:show, :destroy]

	def show
		render json: @user, status: :ok
	end

	def destroy
		@user.destroy	
	end

	def create
		@user = User.new(user_params)
		if @user.save
			render json: @user, status: :created
		else
			render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
		end
	end

	private
		def user_params
			params.permit(:name, :username, :email, :password)
		end

		def set_user
			@user = User.find_by(id: params[:id])
		end
end
