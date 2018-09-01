# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class Role < ApplicationRecord

  has_many :users, :dependent => :restrict_with_exception

  ROLE_DESCONHECIDO = 1
  ROLE_COORDENACAO = 2
  ROLE_SECRETARIA = 3
  ROLE_PROFESSOR = 4
  ROLE_ALUNO = 5
  ROLE_ADMINISTRADOR = 6
  ROLE_SUPORTE = 7

  ORDER = [
  	ROLE_DESCONHECIDO, 
  	ROLE_ALUNO, 
    ROLE_SUPORTE,
  	ROLE_PROFESSOR,
  	ROLE_SECRETARIA,
  	ROLE_COORDENACAO,
  	ROLE_ADMINISTRADOR
  ]

  has_paper_trail
end
