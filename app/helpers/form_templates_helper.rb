# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

module FormTemplatesHelper

  def code_mirror_text_area(column, id, type, options)
    block = text_area(:record, column, options)
    block += "<script>
    CodeMirror.fromTextArea(document.getElementById('#{id}'),
     {mode: {name: 'handlebars', base: 'text/html'},
      indentWithTabs: true,
      smartIndent: true,
      lineNumbers: true,
      matchBrackets : true,
      autofocus: true
     }
    ).setSize(null, 500);

    </script>".html_safe
  end

  def html_form_column(record, options)
    code_mirror_text_area(:code, "record_code_#{record.id}", "text/x-handlebars-template",
                          options.merge(:rows => 40,
                                        :value => record.code || '<!-- Tabela com todas as linhas retornadas -->
<div class="container geral">
			<div class="container" style="max-width:  800px;">
					<!-- CABEÇALHO -->
					<div class="row" style="padding-bottom:  5px;">
						<div class="col-sm-8" style="display: inline;float: left;width:80%;padding-left: 0px;">
							<div class="painel" style="height:  100px;padding:  0px;margin-bottom: 5px;">
								<h3>
									<strong>SAPOS</strong>
								</h3>
							</div>
							<div class="cabecalho" style="height:  40px;">
								<h3>
									<strong>{{nomeRelatorio}}</strong>
								</h3>
							</div>
						</div>
						<div class="col-sm-4 painel" style="display: inline;float: right;height: 145px;width: 20%">
							<h3>
								<strong>UFF</strong>
							</h3>
						</div>
					</div>
					<!-- MATERIAS -->
					<div class="row painel">
						<div class="col-sm-12 dados">
							{{nomeConsulta}}
						</div>
					</div>
			  		<table class="row tabela" style="width: 800px">
					<thead style="width: 100%">
					<tr class="row" style="width: 100%">
					  {{#each colunas}}
						<th class="col-sm-{{block ../colunas.length}} dados"style="">
							{{this}}
						</th>
					  {{/each}}
					</tr>
					</thead>
					<tbody style="width: 100%">
			  		{{#each data}}
					<tr class="row tabela" style="width: 100%">
						{{#each this}}
						<td class="col-sm-{{block ../../colunas.length}} rodape" style="">
							{{this}}
						</td>
						{{/each}}
					</tr>
					{{/each}}
					</tbody>
				</table>
			</div>
		</div>
<style>

	.container.geral{
	color: rgb(51, 51, 153);
	padding: 0px;
}

.painel{
    border-style: solid;
    border-width: 2px;
	border-color: rgb(51, 51, 153);
}

.cabecalho{
	background-color: rgb(51,51, 153);
	color: white;
	padding: 0px;
}
.dados{
	font-weight: bold;
	margin-bottom: 5px;
}

.tabela{
	font-weight: bold;
	margin-bottom: 5px;
    border-style: solid;
    border-width: 2px;
	border-color: rgb(51, 51, 153);
}
.tabela .dados{
    border-right: solid;
    border-width: 1px;
	border-color: rgb(51, 51, 153);
	height: 100%;
	background: #e5e5ff;
	height: 50px;
	padding: 0px;
	margin: 0px;
}

.tabela .rodape{
    border-right: solid;
    border-width: 1px;
	border-color: rgb(51, 51, 153);
	color: black;
	height: 20px;
	background: #e5e5ff;
}

img {
    width: inherit
}

h3, h5{
	margin-top: 0px;
	margin-bottom: 0px;
    text-align: center
}

.legenda{
    text-align: left
}

.direita{
    text-align: right
}

table th, table td{
    text-align: center
}

</style>
'
                          ))
  end

end
