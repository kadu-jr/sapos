# encoding: utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class FormTemplatesController < ApplicationController
  authorize_resource
  active_scaffold :form_template do |config|
    config.list.sorting = {:name => 'ASC'}
    config.columns = [:name, :description, :form_image, :code]
    config.list.columns = [:name, :description]
    config.create.label = :create_form_template_label
    config.update.label = :update_form_template_label
    config.actions.exclude :deleted_records
    config.columns[:form_image].search_ui = :record_select
    config.columns[:form_image].form_ui = :record_select

  end
  record_select :per_page => 10,:search_on => [:name], :order_by => 'name', :full_text_search => true


  def create
    rec = params[:record]
    template = {name: rec[:name], description: rec[:description], code: rec[:code], form_image: rec[:form_image]}
    response = RestClient.post "localhost:3001/" + "form_templates", template.to_json, {content_type: :json}
    #puts(response.body)
    @template = FormTemplate.find(Integer(response.body))
    render  layout: false
  end

  def update
    template = params[:record]
    codigo = template[:code]
    if (template[:form_image].size == 1) #Vetor de imagens vazio(Vem um elemento sem nada)
      imagens = nome_imagens(codigo)
      ids = []
      imagens.each do |imagem|
        ids.push(FormImage.find_by_name(imagem).id)
      end
      template[:form_image] = ids

    end
    form_template = {name: template[:name], description: template[:description], code: template[:code], form_image: template[:form_image]}
    response = RestClient.put "localhost:3001/" + "form_templates/" + params[:id], form_template.to_json, {content_type: :json}
    @template = FormTemplate.find(params[:id])
  end

  def destroy
    response = RestClient.delete "localhost:3001/" + "form_templates/" + params[:id]
    #puts(response.body)
  end

  private
  def nome_imagens(codigo)
    imagens = []
    imgStart = codigo.index("<img")
    if imgStart != nil
      imgEnd = codigo[imgStart..-1].index(">")
      tagImg = codigo[imgStart..imgStart + imgEnd]
      restoCodigo = codigo[imgStart + imgEnd + 1..-1]
      if tagImg.index("sapos") != nil
        idImg = tagImg.index("id=")
        if idImg != nil
          inicioId = idImg + 4
          fimId = tagImg[inicioId..-1].index(" ")
          id = tagImg[inicioId..inicioId + fimId - 2] #Espaco e caracter "
          return nome_imagens(restoCodigo).push(id)
        end
      end
    end
    return []
  end

end
