module GoogleApi
  class VisionController < ApplicationController
    # Imports the Google Cloud client library
    require 'google/cloud/vision'

    def upload
      images = []
      upload_file = params[:file]
      if upload_file != nil
        images << upload_file.path
      end

      responses = send_images(images)
      results = format_result(responses)

      render json: {results: results, responses: responses.to_s}
    rescue => e
      render status: 500, json: {status: 'ERROR', result: e.to_s}
    end
    def send_images(images)
      image_annotator_client = Google::Cloud::Vision::ImageAnnotator.new
      image_annotator_client.document_text_detection images: images, image_context: {language_hints: [:ja, :en]}
    end

    def format_result
      # 以下略 
    end
end