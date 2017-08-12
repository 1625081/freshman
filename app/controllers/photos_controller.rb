class PhotosController < ApplicationController

  def images
    @image = Photo.new(image: file_params)
    if @image.save
      render json: { file_path: @image.image.url }
    end
  end


  private

  def file_params
    params[:upload_file]
  end

end
