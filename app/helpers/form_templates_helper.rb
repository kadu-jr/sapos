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
<div style="max-width: 800px">
  <h2 style="text-align: center"> Resultado de consulta </h2>
<table class="table table-striped table-bordered">
  	<thead>
	{{#if data}}
		{{#each data}}
	  		{{#if @first}}
				{{#each this}}
					<td>Coluna {{@index}}</td>
				{{/each}}
	 		{{/if}}
		{{/each}}
	{{/if}}
	</thead>
  	{{#if data}}
        {{#each data}}
        <tr>
                {{#each this}}
                    <td> {{this}}</td>
                {{/each}}
        </tr>
        {{/each}}
  	{{else}}
  		<tr><td>Sem dados retornados</td></tr>
	{{/if}}
</table>
</div>'
                          ))
  end

end
