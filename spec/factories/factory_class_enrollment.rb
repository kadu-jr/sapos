# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_enrollment do
    course_class
    enrollment
    situation I18n.translate("activerecord.attributes.class_enrollment.situations.registered")
  end
end
