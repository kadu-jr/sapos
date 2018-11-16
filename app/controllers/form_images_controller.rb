# encoding: utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class FormImagesController < ApplicationController
  require 'rest-client'
  authorize_resource
  include ApplicationHelper
  active_scaffold :form_image do |config|
    config.list.sorting = {:name => 'ASC'}   
    config.list.columns = [
        :name,  
        :text, 
    ]

    columns = [
        :name, 
        :image,
        :text
    ]

    #config.columns[:form].search_ui = :record_select
    #config.columns[:form].form_ui = :record_select
    config.create.label = :create_form_image_label
    config.update.label = :update_form_image_label
    config.create.columns = columns
    config.update.columns = columns
    config.columns = columns

    config.actions.exclude :deleted_records
  end
  record_select :per_page => 10

  def logo
    @base = RestClient.get REMOTE_URL + "form_images/" + params[:id] + "/logo"
    render layout: false
  end

  def create
    rec = params[:record]
    image = {name: rec[:name], image: rec[:image], text: rec[:text]}
    if rec[:image] != nil
      image[:imagebase] = Base64.encode64(rec[:image].read).gsub("\n", '')
    end
    response = RestClient.post "localhost:3001/" + "form_images", image.to_json, {content_type: :json}
    #puts(response.body)
    @image = FormImage.find(Integer(response.body))
    render  layout: false
  end

  def update
    rec = params[:record]
    image = {name: rec[:name], image: "dummy", text: rec[:text]}
    if rec[:remove_image] == "true"
      image[:imagebase] = ""
    else
      if rec[:image] != nil
        image[:imagebase] = Base64.encode64(rec[:image].read).gsub("\n", '')
      end
    end
    response = RestClient.put "localhost:3001/" + "form_images/" + params[:id], image.to_json, {content_type: :json}
    #@image = JSON.parse(response.body, object_class: FormImage)
    #puts(params[:id])
    @image = FormImage.find(params[:id])
    render  layout: false
  end

  def destroy
    response = RestClient.delete REMOTE_URL + "form_images/" + params[:id]
    #puts(response.body)
  end

  private
  def record_params
    params.required(:record).permit(:name, :text, :image)
  end
end
