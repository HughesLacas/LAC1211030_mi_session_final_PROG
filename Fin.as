﻿package {
		private var nomEcran:String="fin";
			trace(">>> écran",nomEcran,"créé");
			Main(parent).recommencer(); // permet de recommencer la parti
		public function activer():void{
			trace("Écran",nomEcran,"activé");
			btPrincipal.addEventListener(MouseEvent.CLICK,goPrincipal);
			btIntro.addEventListener(MouseEvent.CLICK,goIntro);
			visible=true;
		}
		
		public function desactiver():void{ // désactive la page
			trace("Écran",nomEcran,"desactivé");
			btPrincipal.removeEventListener(MouseEvent.CLICK,goPrincipal);
			btIntro.removeEventListener(MouseEvent.CLICK,goIntro);
			// cache la page
			visible=false;
		}
	