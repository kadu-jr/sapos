class FormsController < ApplicationController
  require 'base64'
  require 'rest-client'
  skip_authorization_check


  active_scaffold :form do |config|

    config.action_links.add 'consult',
      :label => "<i title='Executar' class='fa fa-table'></i>".html_safe,
      :page => true,
      :inline => true,
      :position => :after,
      :type => :member

    config.columns[:query].search_ui = :record_select
    config.columns[:query].form_ui = :record_select
    config.columns[:template].search_ui = :record_select
    config.columns[:template].form_ui = :record_select
    config.update.columns = [:nome, :descricao, :query, :template]
    config.list.columns = [:nome, :descricao, :query, :template]

    config.columns[:descricao].form_ui = :textarea
    config.columns[:descricao].options = {:cols => 124, :rows => 3}



    #config.columns[:params].allow_add_existing = false
    #config.columns[:params].clear_link
    config.create.columns = [:nome, :descricao, :query, :template]
    # config.show.columns = form_columns + [:next_execution]
    # config.list.columns = [:title, :frequency, :notification_offset, :query_offset, :next_execution]

    config.actions.exclude :deleted_records
  end
  record_select :per_page => 10, :search_on => [:nome], :order_by => 'nome', :full_text_search => true

  def create
    rec = params[:record]
    form = {nome: rec[:nome], descricao: rec[:descricao], query: rec[:query], template: rec[:template]}
    response = RestClient.post REMOTE_URL + "forms", form.to_json, {content_type: :json}
    #puts(response.body)
    @form = Form.find(Integer(response.body))
    render  layout: false
  end

  def update
    rec = params[:record]
    form = {nome: rec[:nome], descricao: rec[:descricao], query: rec[:query], template: rec[:template]}
    response = RestClient.put REMOTE_URL + "forms/" + params[:id], form.to_json, {content_type: :json}
    @form = Form.find(params[:id])
  end

  def destroy
    response = RestClient.delete REMOTE_URL + "forms/" + params[:id]
    #puts(response.body)
  end

  def consult
    @form = Form.find(params[:id])
    @query = Query.find(@form.query_id)
    @query_result = @query.execute(get_simulation_params)
  end

  def generate
	  form = Form.find(params[:id])
    query = form.query
    query_result = query.execute(get_simulation_params)
    images = []
    form.template.form_image.each do |image|
      hash = {nome: image.name, base64: image.imagebase}
      images.push(hash)
    end
    formTemplate = form.template
    template = formTemplate.code
    @consulta = {}
    @consulta["relatorio"] = form
    @consulta["template"] = template
    @consulta["resultado"] = query_result
    @consulta["imagens"] = images
    @consulta["nome"] = query.name
    @consulta["hora"] = Time.now.strftime("%m-%d-%Y %H:%M")
    respond_to do |format|
      format.html {render "generate", layout: false}
      format.pdf do
        html = render_to_string :action => 'generate.html', :locals => {:consulta => @consulta}, layout: false
        kit = PDFKit.new(html, page_size: 'A4')
        pdf = kit.to_pdf
        send_data(pdf,          filename: 'Relatorio.pdf',          disposition: 'inline',          type: :pdf,          window_status: 'ready')
      end
    end

  end

  private
  def get_simulation_params
    return params[:query_params].to_unsafe_h if params[:query_params].is_a?(ActionController::Parameters)
    params[:query_params] || {}
  end

end
