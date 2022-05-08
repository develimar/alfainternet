<?php
function clean_text($text='') {
	$text = trim($text);
	$text = strip_tags($text);
	$text = addslashes($text);
	$text = htmlspecialchars($text);
	return $text;
}
if (!$_POST) {
	die();
}else {
	if (empty($_POST["name"]) && empty($_POST["mail"]) && empty($_POST["message"])) {
		echo "all_empty";
	}else if (empty($_POST["name"])) {
		echo "empty_name";
	}else if (empty($_POST["mail"])) {
		echo "empty_mail";
	}else if (empty($_POST["message"])) {
		echo "empty_message";
	}else {
		// edit this only :)
		$your_email = "morail@msn.com";
		$your_name = "contato";
		
		$name	 = clean_text($_POST["name"]);
		$mail	 = clean_text($_POST["mail"]);
		$message = clean_text($_POST["message"]);
		
		$headers  = "From: $name <$mail>\n";
		$headers  = "To: ".$your_name." <".$your_email.">\n";
		$headers .= 'Content-type: text/html; charset=UTF-8'. "\r\n";
		$headers .= "Reply-To: $mail\n";
		$msg	  = "Nova mensagem site\n<br />";
		$msg	 .= "Nome : \t$name\r\n<br />";
		$msg	 .= "E-mail : \t$mail\r\n<br />";
		$msg	 .= "Mensagem : <br />\t$message\r\n<br /><br />";
		$subject  = "Mensagem vinda de contato\n";
		echo "done";
		$done = mail($your_email,$subject,$msg,$headers);
	}
}
?>