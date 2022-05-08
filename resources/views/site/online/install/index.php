<?php

require_once('../libraries/Session.php');

$session = new Session();

define('ABSOLUTE_PATH', realpath(dirname(__FILE__) . '/../') . '/');

$writeable_directories = array(
	ABSOLUTE_PATH . 'config'
);

$writeable_files = array(
	ABSOLUTE_PATH . 'config/database.php'
);

function check_settings() {
	
	global $writeable_directories, $writeable_files;
	
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
	
	foreach ($writeable_directories as $value) {
		
		if (!is_writable($value)) {
			
			$error['warning'] = TRUE;
			
		}
		
	}

	foreach ($writeable_files as $value) {
		
		if (!is_writable($value)) {
			
			$error['warning'] = TRUE;
			
		}
		
	}
	
	if (!$error) {
		
		return TRUE;
		
	} else {
	
		return FALSE;
		
	}

}	

if (check_settings()) {
	
	$session->set('step_1', TRUE);
	
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
									<li class="active"><a>Requerido <i class="icon-chevron-right pull-right"></i></a></li>
									<li><a>Banco de Dados <i class="icon-chevron-right pull-right"></i></a></li>
									<li><a>Configura&#231;&#245;es <i class="icon-chevron-right pull-right"></i></a></li>
									<li><a>Fim <i class="icon-chevron-right pull-right"></i></a></li>
								</ul>

							</div>
							
						</div>

						<div class="span8">
							
							<div class="well">

								<?php if (!check_settings()): ?>
									<div class="alert alert-error">
										O servidor n&#227;o conseguiu cumprir os requisitos para executar o sistema. 
										Entre em contato com o administrador do servidor ou empresa de hospedagem para resolver.
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
											<td>Sess&#227;o Suporte</td>
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
								
								<table class="table">
									<thead>
										<tr>
											<th>Permiss&#245;es de grava&#231;&#227;o em arquivos e pastas</th>
											<th>&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><?php echo 'config/'; ?></td>
											<td>
											<?php if (is_writable(ABSOLUTE_PATH . 'config')): ?>
												<span class="label label-success pull-right">Permitido</span>
											<?php else: ?>
												<span class="label label-important pull-right">N&#227;o Permitido</span>
											<?php endif; ?>
											</td>
										</tr>
										<tr>
											<td><?php echo 'config/database.php'; ?></td>
											<td>
											<?php if (is_writable(ABSOLUTE_PATH . 'config/database.php')): ?>
												<span class="label label-success pull-right">Permitido</span>
											<?php else: ?>
												<span class="label label-important pull-right">N&#227;o Permitido</span>
											<?php endif; ?>
											</td>
										</tr>
									</tbody>
								</table>

								<?php if (check_settings()): ?>
									<a href="step_1.php" class="btn btn-primary">Pr&#243;ximo</a>
								<?php else: ?>
									<a href="index.php" class="btn btn-primary">Tentar Novamente</a>
								<?php endif; ?>

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
