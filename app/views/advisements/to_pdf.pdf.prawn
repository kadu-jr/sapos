# encoding: utf-8
# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

new_document('relatorio.pdf', I18n.t("pdf_content.advisements.to_pdf.filename"), :pdf_type => :report) do |pdf|
  advisements_table(pdf, advisements: @advisements)
end

