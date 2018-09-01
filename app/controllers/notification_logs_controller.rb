# encoding utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class NotificationLogsController < ApplicationController
  authorize_resource

  active_scaffold :"notification_log" do |config|
  	config.columns = [:notification_name, :to, :subject, :body, :created_at]
  	config.show.columns = [:notification_name, :to, :subject, :body, :created_at]
  	config.columns[:notification_name].label = I18n.t('activerecord.attributes.notification_log.notification_name')
  	config.list.sorting = {:created_at => 'DESC'}
  	config.actions.exclude :create, :delete, :update
  end
end
