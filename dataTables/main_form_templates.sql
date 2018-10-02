INSERT INTO form_templates (id, name, description, code, created_at, updated_at) VALUES (1, 'Template UFF', 'Template estilo UFF', '<style>
				.container{
					max-width: 800px

			}

				.container.painel{
				    border-style: solid;
				    border-width: 1px;
				    margin: 5px
				}

				.sapos{

				
                                max-width: 200px;
                                max-height: 200px;
				}

				img {
				    width: inherit
				}

				h3, h5{
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
			<div class="container geral">
				<!-- CABEÇALHO -->
				<div class="container painel">
					<div class="row">
						<div class="col-sm-2" style="display: inline">
							<img class="sapos" id="uff" style="float: left; width: 100px; margin: 5px"/>
						</div>
						<div class="col-sm-8" style="display: inline">
							<h3 style="display: inline"> UNIVERSIDADE FEDERAL FLUMINENSE</h3>
						</div>
						<div class="col-sm-2" style="display: inline">
							<img class="sapos" id="sapos" style="width: 100px;  float: right"/>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<h5> SAPOS - Sistema de Apoio a Pos-Graduacao</h5>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<h5> Instituto de Computacao - UFF</h5>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-sm-12">
							<h3> Lista de Alunos Matriculados</h3>
						</div>
					</div>
				</div>
				<!-- ALUNOS -->
				<div class="container painel">
					<table class="table table-bordered">
						<thead class="row">
							<tr>
								<th class="col-md-3">
									CPF
								</th>
								<th class="col-md-6">
									NOME
								</th>
								<th class="col-md-3">
									MATRICULA
								</th>
							</tr>
						</thead>
						<tbody>
							{{#each data}}
								<tr>
									<td class="col-md-3">
										{{this.cpf}}
									</td>
									<td class="col-md-6">
											{{this.name}}
									</td>
									<td class="col-md-3">
											{{this.enrollment_number}}
									</td>
								</tr>
							{{/each}}
						</tbody>
					</table>
				</div>
				<div class="container painel">
						<div class="row">
							<div class="col-sm-12">
									<h3> Niteroi, 22 de Fevereiro de 2018, as 11:48:35.</h3>
							</div>
						</div>
				</div>
	', '2018-07-28 00:52:47.395790', '2018-09-13 02:26:55.652663');
INSERT INTO form_templates (id, name, description, code, created_at, updated_at) VALUES (2, 'Alunos Regulares', 'Mostra dados de alunos regulares', '<style>
				.container{
					max-width: 800px

			}

				.container.painel{
				    border-style: solid;
				    border-width: 1px;
				    margin: 5px
				}

				.sapos{

				
                                max-width: 200px;
                                max-height: 200px;
				}

				img {
				    width: inherit
				}

				h3, h5{
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
			<script>
			  function mesNome(mes){

				  switch (mes){
					  case 1: return ''janeiro'';
					  case 2: return ''fevereiro'';
					  case 3: return ''março'';
					  case 4: return ''abril'';
					  case 5: return ''maio'';
					  case 6: return ''junho'';
					  case 7: return ''julho'';
					  case 8: return ''agosto'';
					  case 9: return ''setembro'';
					  case 10: return ''outubro'';
					  case 11: return ''novembro'';
					  case 12: return ''dezembro'';	
				  }
			  }
			  function mostraData(data){

				  var date = new Date(data);
				  console.log(date);
				  if (date == "Invalid Date")
					  return "--/--/----";
				  var diaInteiro = 	[date.getDate(), mesNome(date.getMonth() + 1), date.getFullYear()]
				  var horaInteira = 	[date.getHours(), date.getMinutes()]
				  document.getElementById("diaHora").innerHTML = diaInteiro.join('' de '') + " " + horaInteira.join('':'');

			  }
			</script>
			<div class="container geral">
				<!-- CABEÇALHO -->
				<div class="container painel">
					<div class="row">
						<div class="col-sm-2" style="display: inline">
							<img class="sapos" id="uff" style="float: left; width: 100px; margin: 5px"/>
						</div>
						<div class="col-sm-8" style="display: inline">
							<h3 style="display: inline"> UNIVERSIDADE FEDERAL FLUMINENSE</h3>
						</div>
						<div class="col-sm-2" style="display: inline">
							<img class="sapos" id="sapos" style="width: 100px;  float: right"/>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<h5> SAPOS - Sistema de Apoio a Pos-Graduacao</h5>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<h5> Instituto de Computacao - UFF</h5>
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col-sm-12">
							<h3> Lista de Alunos Regulares</h3>
						</div>
					</div>
				</div>
				<!-- ALUNOS -->
				<div class="container painel">
					<table class="table table-bordered">
						<thead class="row">
							<tr>
								<th class="col-md-3">
									NOME
								</th>
								<th class="col-md-6">
									EMAIL
								</th>
								<th class="col-md-3">
									MATRICULA
								</th>
							</tr>
						</thead>
						<tbody>
							{{#each data}}
								<tr>
									<td class="col-md-3">
										{{this.nome}}
									</td>
									<td class="col-md-6">
											{{this.email}}
									</td>
									<td class="col-md-3">
											{{this.matricula}}
									</td>
								</tr>
							{{/each}}
						</tbody>
					</table>
				</div>
				<div class="container painel">
						<div class="row">
							<div class="col-sm-12">
									<h3> Niteroi, <span id="diaHora"></span></h3>
							</div>
						</div>
				</div>
				<script>
				  	mostraData("{{diaHora}}")
				</script>', '2018-09-15 22:20:43.214670', '2018-09-16 00:22:37.449742');
INSERT INTO form_templates (id, name, description, code, created_at, updated_at) VALUES (3, 'tabela padrao', null, '<!-- Tabela com todas as linhas retornadas -->
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
</div>', '2018-09-17 23:40:49.714512', '2018-09-18 01:05:06.796732');
INSERT INTO form_templates (id, name, description, code, created_at, updated_at) VALUES (4, 'Template Sapos', null, '<div class="container geral">
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
', '2018-09-27 17:16:44.584059', '2018-09-28 20:28:15.463429');
INSERT INTO form_templates (id, name, description, code, created_at, updated_at) VALUES (6, 'teste', null, '<!-- Tabela com todas as linhas retornadas -->
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
', '2018-09-28 20:37:43.241894', '2018-09-28 20:37:43.241894');