<?php

require_once('../libraries/Session.php');

$session = new Session();

if (!$session->get('step_3')) {
	
	header("Location: step_2.php");
	
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
									<li><a>Configura&#231;&#245;es <i class="icon-chevron-right pull-right"></i></a></li>
									<li class="active"><a>Fim <i class="icon-chevron-right pull-right"></i></a></li>
								</ul>

							</div>
							
						</div>

						<div class="span8">
							
							<div class="well">

								<p>
									Parab&#233;ns, sua instala&#231;&#227;o est&#225; conclu&#237;da.
								</p>
								
								<p>
									Por favor efetue login no <a href="../admin">Painel Administra&#231;&#227;o</a> com os seguintes detalhes.
								</p>
									
								<p>
									<strong>Endere&#231;o de email:</strong> <?php echo $session->get('user_email'); ?>
									<br>
									<strong>Senha:</strong> <?php echo $session->get('user_password'); ?>
									<?php $session->destroy(); ?>
								</p>
								
								<p>					
                                                                        Finalmente, exclua o instalador do servidor.
								</p>

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
