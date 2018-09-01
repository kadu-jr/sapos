# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class NotificationsController < ApplicationController
  authorize_resource
  skip_authorization_check :only => [:notify]
  skip_before_action :authenticate_user!, :only => :notify
  before_action :permit_notification_params

  def permit_notification_params
    params[:notification_params].permit! unless params[:notification_params].nil?
  end

  active_scaffold :"notification" do |config|

    config.action_links.add 'simulate',
                            :label => "<i title='#{I18n.t('active_scaffold.notification.simulate')}' class='fa fa-table'></i>".html_safe,
                            :page => true,
                            :inline => true,
                            :position => :after,
                            :type => :member


    form_columns = [:title, :frequency, :notification_offset, :query_offset, :query, :params, :individual, :to_template, :subject_template, :body_template]
    config.columns = form_columns
    config.update.columns = form_columns
    config.create.columns = [:title, :frequency, :notification_offset, :query_offset, :query, :individual, :to_template, :subject_template, :body_template]
    config.show.columns = form_columns + [:next_execution]
    config.list.columns = [:title, :frequency, :notification_offset, :query_offset, :next_execution]


    config.columns[:params].allow_add_existing = false
    config.columns[:query].form_ui = :select
    config.columns[:frequency].form_ui = :select
    config.columns[:frequency].options = {:options => Notification::FREQUENCIES}
    config.columns[:frequency].description = I18n.t('active_scaffold.notification.frequency_description')
    config.columns[:individual].description = I18n.t('active_scaffold.notification.individual_description')
    config.columns[:notification_offset].description = I18n.t('active_scaffold.notification.notification_offset_description')
    config.columns[:query_offset].description = I18n.t('active_scaffold.notification.query_offset_description')
    config.columns[:query].update_columns = [:query, :params]


    config.create.label = :create_notification_label

    config.actions.exclude :deleted_records
  end

  def after_render_field(record, column)
    if column.name == :query
      if params[:id]
        notification = Notification.find(params[:id])
        notification.query_id = record.query_id
        notification.save
      else
        record.save
        record.build_params_for_creation
      end

    end
  end

  def after_update_save(record)
    record.update_next_execution!
  end

  def execute_now
    process_action_link_action do |notification|

      notification_params = params[:notification_params]
      notification_params = notification_params.to_unsafe_h if notification_params.is_a?(ActionController::Parameters)
      query_date = Date.strptime(params[:data_consulta], "%Y-%m-%d") unless params[:data_consulta].nil?
      query_date ||= notification.query_date.to_date
      Notifier.send_emails(notification.execute(override_params: notification_params))
      self.successful = true

      flash[:info] = I18n.t('active_scaffold.notification.execute_now_success')
    end
  end

  def simulate
    @notification = Notification.find(params[:id])


    notification_params = params[:notification_params]
    notification_params = notification_params.to_unsafe_h if notification_params.is_a?(ActionController::Parameters)
    if notification_params

      result = @notification.execute(skip_update: true, override_params: notification_params)
      @messages = result[:notifications]
      @query_sql = result[:query]
    else
      @messages = []
    end
    render :action => 'simulate'
  end

  def notify
    Notifier.asynchronous_emails
    render :inline => 'Ok'
  end

end
