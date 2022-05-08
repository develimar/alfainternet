<?php

require_once('../libraries/Error.php');
require_once('../libraries/Session.php');

$error = new Error();
$session = new Session();

define('ABSOLUTE_PATH', realpath(dirname(__FILE__) . '/../') . '/');

function config_load($name) {
	
	$configuration = array();

	if (file_exists(realpath(dirname(__FILE__) . '/../') . '/config/' . $name . '.php')) {
		
		require(realpath(dirname(__FILE__) . '/../') . '/config/' . $name . '.php');
		
	} else {
	
		die('The file ' . realpath(dirname(__FILE__) . '/../') . '/config/' . $name . '.php does not exist.');
		
	}
	
	if (!isset($config) OR !is_array($config)) {
		
		die('The file ' . realpath(dirname(__FILE__) . '/../') . '/config/' . $name . '.php does not appear to be formatted correctly.');
	
	}
	
	if (isset($config) AND is_array($config)) {
		
		$configuration = array_merge($configuration, $config);
		
	}
	
	return $configuration;

}

function config_item($name, $item) {
	
	static $config_item = array();

	if (!isset($config_item[$item])) {
	
		$config = config_load($name);

		if (!isset($config[$item])) {
			
			return FALSE;
			
		}
		
		$config_item[$item] = $config[$item];
		
	}
	
	return $config_item[$item];

}

function check_settings() {
	
	$error = array();
	
	if (version_compare(PHP_VERSION, '5.2.4', '<=')) {
		
		$error['warning'] = TRUE;
		
	}
	
	if (!extension_loaded('session')) {
		
		$error['warning'] = TRUE;
		
	}
	
	if (!extension_loaded('PDO') || !extension_loaded('pdo_mysql')) {
		
		$error['warning'] = TRUE;
		
	}
	
	if (ini_get('register_globals')) {
		
		$error['warning'] = TRUE;
		
	}
	
	if (ini_get('magic_quotes_gpc')) {
		
		$error['warning'] = TRUE;
		
	}
	
	if (!$error) {
		
		return TRUE;
		
	} else {
	
		return FALSE;
		
	}

}	

if (isset($_POST['submit']) && isset($_POST['disclaimer'])) {

	if (@mysql_connect(config_item('database', 'db_hostname'), config_item('database', 'db_username'), config_item('database', 'db_password')) && mysql_select_db(config_item('database', 'db_name'))) {
		
		if (version_compare(mysql_get_server_info(), '5.0.15', '<=')) {
			
			$error->set_error('The database version ' . mysql_get_server_info() . ' is less than the minimum required version 5.0.15');
			
		} else {

			$connection = mysql_connect(config_item('database', 'db_hostname'), config_item('database', 'db_username'), config_item('database', 'db_password'));

			mysql_select_db(config_item('database', 'db_name'), $connection);
		
			$sql = explode(';', file_get_contents(ABSOLUTE_PATH . 'install/upgrade.sql'));

			$replace = array('__TABLE_PREFIX__' => config_item('database', 'table_prefix'));
			
			$sql = str_replace(array_keys($replace), $replace, $sql);
			
			foreach($sql as $value) {

				mysql_query($value);
				
			}
			
			mysql_close($connection);
		
			$success = TRUE;

		}
		
	} else {
		
		$error->set_error('Problem connecting to the database: ' . mysql_error());	

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
					
					<div class="well">
						
						<?php if ($error->has_errors()): ?>
							<div class="alert alert-block alert-error">
								<p><strong>Ocorreu um erro durante o processamento do pedido:</strong></p>
								<?php foreach ($error->display_errors() as $value): ?>
									<p><?php echo $value; ?></p>
								<?php endforeach; ?>
							</div>
						<?php $error->clear_errors(); endif; ?>

						<?php if (!check_settings()): ?>
							<div class="alert alert-error">
								O servidor n&#227;o conseguiu cumprir os requisitos para executar o sistema. 
								Entre em contato com o administrador do servidor ou empresa de hospedagem para resolver.
							</div>
						<?php endif; ?>

						<?php if (isset($success)): ?>
							<div class="alert alert-success">
								Par&#225;bens,  atualiza&#231;&#227;o completada!
							</div>
						<?php else: ?>
							<div class="alert alert-error">
								Um backup manual &#233; altamente recomendado antes de continuar , por favor verifique seus arquivos de aplicativos existentes e banco de dados de backup.
							</div>
						<?php endif; ?>

						<table class="table">
							<thead>
								<tr>
									<th>Checagem de Sistema</th>
									<th>&nbsp;</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>Vers&#227;o PHP 5.2.4 ou superior</td>
									<td><span class="pull-right"><?php echo PHP_VERSION; ?></span></td>
								</tr>
								<tr>
									<td>Session Support</td>
									<td>
									<?php if (extension_loaded('session')): ?>
										<span class="label label-success pull-right">Sucesso</span>
									<?php else: ?>
										<span class="label label-important pull-right">Falha</span>
									<?php endif; ?>
									</td>
								</tr>
								<tr>
									<td>Register Globals Off</td>
									<td>
									<?php if (!ini_get('register_globals')): ?>
										<span class="label label-success pull-right">Sucesso</span>
									<?php else: ?>
										<span class="label label-important pull-right">Falha</span>
									<?php endif; ?>
									</td>
								</tr>
								<tr>
									<td>Magic Quotes GPC Off</td>
									<td>
									<?php if (!ini_get('magic_quotes_gpc')): ?>
										<span class="label label-success pull-right">Sucesso</span>
									<?php else: ?>
										<span class="label label-important pull-right">Falha</span>
									<?php endif; ?>
									</td>
								</tr>
								<tr>
									<td>PDO Support (MySQL)</td>
									<td>
									<?php if (extension_loaded('PDO') || extension_loaded('pdo_mysql')): ?>
										<span class="label label-success pull-right">Sucesso</span>
									<?php else: ?>
										<span class="label label-important pull-right">Falha</span>
									<?php endif; ?>
									</td>
								</tr>
							</tbody>
						</table>

						<form method="post">
							
							<?php if (check_settings()): ?>
								<label class="checkbox">
									<input type="checkbox" name="disclaimer" value="1">
									Eu assumo toda a responsabilidade por qualquer perda de dados ou danos relacionados com esta atualiza&#231;&#227;o.
								</label>
							<?php endif; ?>
							
							<?php if (check_settings()): ?>
								<button type="submit" class="btn btn-primary" name="submit">Atualizar</button>
							<?php else: ?>
								<a href="index.php" class="btn btn-primary">Tentar Novamente</a>
							<?php endif; ?>
							
						</form>

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
