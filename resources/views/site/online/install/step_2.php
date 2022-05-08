<?php

require_once('../libraries/Error.php');
require_once('../libraries/Session.php');
require_once('../libraries/Validate.php');

$error = new Error();
$session = new Session();
$validate = new Validate();

if (!$session->get('step_2')) {
	
	header("Location: step_1.php");
	
}

define('ABSOLUTE_PATH', realpath(dirname(__FILE__) . '/../') . '/');
define('ABSOLUTE_URL', 'http://' . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), 'install'));

if (isset($_POST['submit'])) {

	$validate->required($_POST['site_title'], 'Please enter a site title.');
	$validate->required($_POST['first_name'], 'Please enter a first name.');
	$validate->email($_POST['user_email'], 'Please enter a email address.');
	$validate->required($_POST['user_password'], 'Please enter a password.');
	$validate->matches($_POST['user_password'], $_POST['confirm_password'], 'The password field does not match the confirm password field.');
	
	if (!$error->has_errors()) {

		$config_database = file_get_contents('../config/database.php');

		$replace = array(
			'__DB_HOSTNAME__' 	=> $session->get('db_hostname'),
			'__DB_USERNAME__' 	=> $session->get('db_username'),
			'__DB_PASSWORD__' 	=> $session->get('db_password'),
			'__DB_NAME__' 		=> $session->get('db_name'),
			'__TABLE_PREFIX__' 	=> $session->get('table_prefix')
		);

		$output	= str_replace(array_keys($replace), $replace, $config_database);

		$file = fopen('../config/database.php', 'w');
		fwrite($file, $output);
		fclose($file);
		
		$connection = mysql_connect($session->get('db_hostname'), $session->get('db_username'), $session->get('db_password'));

		mysql_select_db($session->get('db_name'), $connection);
	
		$sql = file_get_contents(ABSOLUTE_PATH . 'install/database.sql');
		$sql = explode(";\n", $sql);
		
		$replace = array('__TABLE_PREFIX__' => $session->get('table_prefix'));
		
		$sql = str_replace(array_keys($replace), $replace, $sql);
		
		foreach($sql as $value) {

			mysql_query($value);
			
		}
		
		mysql_query("INSERT INTO " . $session->get('table_prefix') . "users VALUES (1, 1, '" . mysql_real_escape_string($_POST['user_email']) . "', SHA1('" . mysql_real_escape_string($_POST['user_password']) . "'), 1, '1', UNIX_TIMESTAMP(), '', '', '', '')");
		mysql_query("INSERT INTO " . $session->get('table_prefix') . "user_profiles VALUES (1, 1, '" . mysql_real_escape_string($_POST['first_name']) . "', '" . mysql_real_escape_string($_POST['last_name']) . "')");
		mysql_query("INSERT INTO " . $session->get('table_prefix') . "operators VALUES (1, 1, '" . mysql_real_escape_string($_POST['first_name']) . "', '" . mysql_real_escape_string($_POST['last_name']) . "', '', '')");
		mysql_query("INSERT INTO " . $session->get('table_prefix') . "user_groups VALUES (1, 'Administrator', '" . serialize(array('Home page', 'Chat history', 'Canned messages', 'Departments', 'Operators', 'Groups', 'Languages', 'Translations', 'Blocked visitors', 'Access logs', 'Settings')) . "')");
		mysql_query("INSERT INTO " . $session->get('table_prefix') . "user_groups VALUES (2, 'Operator', '" . serialize(array('Home page', 'Chat history', 'Blocked visitors')) . "')");
		
		mysql_query("UPDATE " . $session->get('table_prefix') . "options SET option_value = '" . mysql_real_escape_string($_POST['site_title']) . "' WHERE option_name = 'site_title'");
		mysql_query("UPDATE " . $session->get('table_prefix') . "options SET option_value = '" . ABSOLUTE_URL . "' WHERE option_name = 'absolute_url'");
		mysql_query("UPDATE " . $session->get('table_prefix') . "options SET option_value = '" . ABSOLUTE_PATH . "' WHERE option_name = 'absolute_path'");
		mysql_query("UPDATE " . $session->get('table_prefix') . "options SET option_value = '" . mysql_real_escape_string($_POST['user_email']) . "' WHERE option_name = 'admin_email'");
		
		mysql_close($connection);
		
		$session->set('user_email', $_POST['user_email']);
		$session->set('user_password', $_POST['user_password']);
		$session->set('step_3', true);
		
		header("Location: step_3.php");
		
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
									<li><a>Banco de Dados <i class="icon-chevron-right pull-right"></i></a></li>
									<li class="active"><a>Configura&#231;&#245;es <i class="icon-chevron-right pull-right"></i></a></li>
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

									<label for="site_title">Titulo do Site</label>
									<input type="text" class="span4" id="site_title" name="site_title" value="<?php if (!empty($_POST['site_title'])) echo $_POST['site_title']; ?>">

									<label for="first_name">Nome</label>
									<input type="text" class="span4" id="first_name" name="first_name" value="<?php if (!empty($_POST['first_name'])) echo $_POST['first_name']; ?>">

									<label for="last_name">Sobrenome</label>
									<input type="text" class="span4" id="last_name" name="last_name" value="<?php if (!empty($_POST['last_name'])) echo $_POST['last_name']; ?>">
									
									<label for="user_email">Endere&#231;o email</label>
									<input type="text" class="span4" id="user_email" name="user_email" value="<?php if (!empty($_POST['user_email'])) echo $_POST['user_email']; ?>">

									<label for="user_password">Senha</label>
									<input type="password" class="span4" id="user_password" name="user_password">
									
									<label for="confirm_password">Confirmar senha</label>
									<input type="password" class="span4" id="confirm_password" name="confirm_password">
									
									<p><button type="submit" class="btn btn-primary" name="submit">Instalar</button></p>
									
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
