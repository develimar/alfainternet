<?php

require_once('../libraries/Error.php');
require_once('../libraries/Session.php');
require_once('../libraries/Validate.php');

$error = new Error();
$session = new Session();
$validate = new Validate();

if (!$session->get('step_1')) {
	
	header("Location: index.php");
	
}

if (isset($_POST['submit'])) {

	$validate->required($_POST['db_hostname'], 'Please enter a hostname.');
	$validate->required($_POST['db_username'], 'Please enter a database username.');
	$validate->required($_POST['db_password'], 'Please enter a database password.');
	$validate->required($_POST['db_name'], 'Please enter a database name.');
	$validate->required($_POST['table_prefix'], 'Please enter a table prefix.');
	
	if (!$error->has_errors()) {

		$session->set('db_hostname', $_POST['db_hostname']);
		$session->set('db_username', $_POST['db_username']);
		$session->set('db_password', $_POST['db_password']);
		$session->set('db_name', $_POST['db_name']);
		$session->set('table_prefix', $_POST['table_prefix']);

		if (@mysql_connect($_POST['db_hostname'], $_POST['db_username'], $_POST['db_password']) && mysql_select_db($_POST['db_name'])) {
			
			if (version_compare(mysql_get_server_info(), '5.0.15', '<=')) {
				
				$error->set_error('The database version ' . mysql_get_server_info() . ' is less than the minimum required version 5.0.15');
				
			} else {
				
				$session->set('step_2', true);
			
				header("Location: step_2.php");
				
			}
			
		} else {
			
			$error->set_error('Problem connecting to the database: ' . mysql_error());	
		
		}

	}

}

?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<title>D1Sistema - Atendimento | Instalacao</title>

		<link href="css/main.css" rel="stylesheet">
		<link href="css/bootstrap.min.css" rel="stylesheet">
	
	</head>
	<body>

		<div class="container">
			
			<div class="row">
				
				<div class="span12">
					
					<div class="row">
						
						<div class="span4">
							
							<div class="well">
                                                            <img src="images/logo.png"/>
                                                            	&nbsp;&nbsp;								
								<ul class="nav nav-pills nav-stacked">
									<li><a>Requerido <i class="icon-chevron-right pull-right"></i></a></li>
									<li class="active"><a>Banco de Dados <i class="icon-chevron-right pull-right"></i></a></li>
									<li><a>Configura&#231;&#245;es <i class="icon-chevron-right pull-right"></i></a></li>
									<li><a>Fim <i class="icon-chevron-right pull-right"></i></a></li>
								</ul>

							</div>
							
						</div>

						<div class="span8">
							
							<div class="well">

								<?php if ($error->has_errors()): ?>
									<div class="alert alert-block alert-error">
										<p><strong>Ocorreu um erro durante o processamento do pedido:</strong></p>
										<?php foreach ($error->display_errors() as $value): ?>
											<p><?php echo $value; ?></p>
										<?php endforeach; ?>
									</div>
								<?php $error->clear_errors(); endif; ?>

								<form method="post">

									<label for="db_hostname">Hostname</label>
									<input type="text" class="span4" id="db_hostname" name="db_hostname" value="<?php if (!empty($_POST['db_hostname'])) echo $_POST['db_hostname']; ?>">

									<label for="db_username">Usuario</label>
									<input type="text" class="span4" id="db_username" name="db_username" value="<?php if (!empty($_POST['db_username'])) echo $_POST['db_username']; ?>">

									<label for="db_password">Senha</label>
									<input type="password" class="span4" id="db_password" name="db_password">
									
									<label for="db_name">Nome Banco de dados</label>
									<input type="text" class="span4" id="db_name" name="db_name" value="<?php if (!empty($_POST['db_name'])) echo $_POST['db_name']; ?>">

									<label for="table_prefix">Prefixo da Tabela</label>
									<input type="text" class="span4" id="table_prefix" name="table_prefix" value="<?php if (!empty($_POST['table_prefix'])) echo $_POST['table_prefix']; else echo 'lc_'; ?>">
									
									<p><button type="submit" class="btn btn-primary" name="submit">Pr&#243;ximo</button></p>
									
								</form>

							</div>
							
						</div>
				
					</div>
					
				</div>

			</div>
			
		</div>

		<div class="navbar navbar-fixed-bottom">
			
			<div class="container">

				<p><small><a href="http://www.d1sistemas.com.br" target="_blank">D1Sistemas</a></small></p>

			</div>
			
		</div>
		
	</body>
</html>	
