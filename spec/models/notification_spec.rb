# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

require 'spec_helper'

describe Notification do
  let(:notification) do 
    query = Query.new
    notification = Notification.new 
    notification.query = query
    notification
  end
  subject { notification }
  describe "Validations" do
    describe "body_template" do
      context "should be valid when" do
        it "body_template is not null" do
          notification.body_template = "MSG"
          notification.should have(0).errors_on :body_template
        end
      end
      context "should have error blank when" do
        it "body_template is null" do
          notification.body_template = nil
          notification.should have_error(:blank).on :body_template
        end
      end
    end

    describe "frequency" do
      context "should be valid when" do
        it "frequency is not null" do
          notification.frequency = I18n.translate("activerecord.attributes.notification.frequencies.annual")
          notification.should have(0).errors_on :frequency
        end
      end
      context "should have error blank when" do
        it "frequency is null" do
          notification.frequency = nil
          notification.should have_error(:blank).on :frequency
        end
      end
      context "should have error inclusion when" do
        it "frequency is not in the list" do
          notification.frequency = "bla"
          notification.should have_error(:inclusion).on :frequency
        end
      end
    end

    describe "notification_offset" do
      context "should be valid when" do
        it "notification_offset is not null" do
          notification.notification_offset = "5"
          notification.should have(0).errors_on :notification_offset
        end
      end
      context "should have error blank when" do
        it "notification_offset is null" do
          notification.notification_offset = nil
          notification.should have_error(:blank).on :notification_offset
        end
      end
    end

    describe "query_offset" do
      context "should be valid when" do
        it "query_offset is not null" do
          notification.query_offset = "5"
          notification.should have(0).errors_on :query_offset
        end
      end
      context "should have error blank when" do
        it "query_offset is null" do
          notification.query_offset = nil
          notification.should have_error(:blank).on :query_offset
        end
      end
    end

    describe "sql_query" do
      context "should be valid when" do
        it "sql_query is not null" do
          notification.sql_query = "SELECT * FROM USERS"
          notification.should have(0).errors_on :sql_query
        end
      end
      context "should have error blank when" do
        it "sql_query is null" do
          notification.sql_query = nil
          notification.should have_error(:blank).on :sql_query
        end
      end
    end

    describe "subject_template" do
      context "should be valid when" do
        it "subject_template is not null" do
          notification.subject_template = "SELECT * FROM USERS"
          notification.should have(0).errors_on :subject_template
        end
      end
      context "should have error blank when" do
        it "subject_template is null" do
          notification.subject_template = nil
          notification.should have_error(:blank).on :subject_template
        end
      end
    end

    describe "to_template" do
      context "should be valid when" do
        it "to_template is not null" do
          notification.to_template = "SELECT * FROM USERS"
          notification.should have(0).errors_on :to_template
        end
      end
      context "should have error blank when" do
        it "to_template is null" do
          notification.to_template = nil
          notification.should have_error(:blank).on :to_template
        end
      end
    end
  end

  describe "Methods" do
    describe "calculate_next_notification_date" do
      describe "for daily frequency" do
        it "should be 01/04 if today is 01/03" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.daily"))
          notification.calculate_next_notification_date(:time => Time.parse("01/03")).should == Time.parse("01/04")
        end
      end

      describe "for weekly frequency" do
        it "should be 2014/01/20(monday) if today is 2014/01/14(tuesday)" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.weekly"))
          notification.calculate_next_notification_date(:time => Time.parse("2014/01/14")).should == Time.parse("2014/01/20")
        end

        it "should be 2014/01/16(thursday) if today is 2014/01/14(tuesday) and offset is 3" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.weekly"), :notification_offset => "3")
          notification.calculate_next_notification_date(:time => Time.parse("2014/01/14")).should == Time.parse("2014/01/16")
        end

        it "should be 2014/01/18(saturday) if today is 2014/01/14(tuesday) and offset is -2" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.weekly"), :notification_offset => "-2")
          notification.calculate_next_notification_date(:time => Time.parse("2014/01/14")).should == Time.parse("2014/01/18")
        end

         it "should be 2014/02/01(saturday) if today is 2014/01/25(saturday) and offset is -2" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.weekly"), :notification_offset => "-2")
          notification.calculate_next_notification_date(:time => Time.parse("2014/01/25")).should == Time.parse("2014/02/01")
        end
      end

      describe "for monthly frequency" do
        it "should be 02/01 if today is 01/17" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.monthly"))
          notification.calculate_next_notification_date(:time => Time.parse("01/17")).should == Time.parse("02/01")
        end

        it "should be 02/15 if today is 01/17 and offset is 14" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.monthly"), :notification_offset => "14")
          notification.calculate_next_notification_date(:time => Time.parse("01/17")).should == Time.parse("02/15")
        end

        it "should be 02/08 if today is 01/17 and offset is 1w" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.monthly"), :notification_offset => "1w")
          notification.calculate_next_notification_date(:time => Time.parse("01/17")).should == Time.parse("02/08")
        end
      end

      describe "for semiannual frequency" do
        it "should be 03/01 of this year if today is 09/01 of last year" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.semiannual"))
          notification.calculate_next_notification_date(:time => Time.parse("09/01") - 1.year).should == Time.parse("03/01")
        end

        it "should be 03/01 of this year if today is 02/01" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.semiannual"))
          notification.calculate_next_notification_date(:time => Time.parse("02/01")).should == Time.parse("03/01")
        end

        it "should be 08/01 if today is 04/01" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.semiannual"))
          notification.calculate_next_notification_date(:time => Time.parse("04/01")).should == Time.parse("08/01")
        end

        it "should be 03/01 of next year if today is 09/01" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.semiannual"))
          notification.calculate_next_notification_date(:time => Time.parse("09/01")).should == (Time.parse("03/01") + 1.year)
        end

        it "should be 07/01 if today is 02/15 and offset is -31" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.semiannual"), :notification_offset => "-31")
          notification.calculate_next_notification_date(:time => Time.parse("02/15")).should == Time.parse("07/01")
        end

      end

      describe "for annual frequency" do
        it "should be 2015/01/01 if today is 2014/06/27" do
          notification = FactoryGirl.create(:notification, :frequency => I18n.translate("activerecord.attributes.notification.frequencies.annual"))
          notification.calculate_next_notification_date(:time => Time.parse("2014/06/27")).should == Time.parse("2015/01/01")
        end
      end
    end

  end

end
