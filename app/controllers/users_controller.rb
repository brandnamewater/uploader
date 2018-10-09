class UsersController < ApplicationController

before_action :authenticate_user!

  def index
      if params[:approved] == "false"
        @users = User.where(approved: false)
      else
        @users = User.all
      end
    end



#    def edit
#      @user = User.find(params[:id])
#    end

  def show

  end 


    def update
     @user = User.find(params[:id])

     if @user.update(user_params) # <- you'll need to define these somewhere as well
       respond_to do |format|
         format.html { redirect_to '/auth' }
         format.json { render json: @user }
       end
     else
       respond_to do |format|
         format.html { render :edit }
         format.json { render json: { errors: @user.errors }, status: :unprocessable_entity }
      end
end
end




     private


     def user_params
       params.require(:user).permit(:name, :approved)
     end

end
