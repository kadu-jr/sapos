class FormsController < ApplicationController
#  authorize_resource
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

  def consult
    @form = Form.find(params[:id])
    @query = Query.find(@form.query_id)
    @query_result = @query.execute(get_simulation_params)
    render :action => 'execute'
  end

  def generate
	  form = Form.find(params[:id])
    query = Query.find(form.query_id)
    @query_result = query.execute(get_simulation_params)
	  @images = FormImage.where(form_id: params[:id])
    formTemplate = FormTemplate.find(form.template_id)
    @template = formTemplate.code
	  render :action => 'generate'
  end

  def pdf
    kit = PDFKit.new("http://localhost:3000/forms/4/generate", page_size: 'A4')
    pdf = kit.to_pdf
    send_data(pdf,
              filename: 'Relatorio.pdf',
              disposition: 'attachment',
              type: :pdf)

  end

  private
  def get_simulation_params
    return params[:query_params].to_unsafe_h if params[:query_params].is_a?(ActionController::Parameters)
    params[:query_params] || {}
  end

end
