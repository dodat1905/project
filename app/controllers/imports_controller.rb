class ImportsController < ApplicationController
  def create
    @imports = User.import_file params[:file]
    if @import
      flash[:success] = "Success import"
    else
        flash[:danger] = @imports.each{|import| import }
    end
    redirect_to users_path
  end
end
