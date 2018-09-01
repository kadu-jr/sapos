# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class DismissalReason < ApplicationRecord

  THESIS_JUDGEMENT = [
    I18n.translate("activerecord.attributes.dismissal_reason.thesis_judgements.approved"), 
    I18n.translate("activerecord.attributes.dismissal_reason.thesis_judgements.reproved"), 
    I18n.translate("activerecord.attributes.dismissal_reason.thesis_judgements.invalid")
  ]

   
  validates :name, :presence => true, :uniqueness => true
  validates :thesis_judgement, :presence => true, :inclusion => {:in => THESIS_JUDGEMENT}
  

  has_paper_trail

  def to_label
    "#{self.name}"
  end
end
