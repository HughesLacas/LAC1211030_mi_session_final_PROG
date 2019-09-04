﻿package {
	
		//-------------ÉCRAN---------------
		private var _princi: Principal;
		
		//---- PROTPIÉTÉ--------------
		
		//**************CONSTRUCTEUR****************************
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			
			
			if(ecranCourant!=null) ecranCourant.desactiver();
			if(destination=="intro"){
				intro_mc.activer();
			}else if(destination=="principal"){
				principal_mc.activer();
			}else if(destination=="fin"){
				fin_mc.activer();
			}
		
		//------MÉTHODES PRIVÉES---------------------------
		
//------------------ CONTROLE CLAVIER --------------------------------------------------------
		private function keyDown(e:KeyboardEvent):void{
			if (e.keyCode == Keyboard.A) {
					principal_mc.cycliste_mc.allerGauche();
			}
			if (e.keyCode == Keyboard.D) {
					principal_mc.cycliste_mc.allerDroite();
			}
			if (e.keyCode == Keyboard.W) {
					principal_mc.cycliste_mc.allerHaut();
			}
			if (e.keyCode == Keyboard.S) {
					principal_mc.cycliste_mc.allerBas();
			}
			if (e.keyCode == Keyboard.UP) {
					principal_mc.cycliste_mc.tirer();
			}
			
		}
		private function keyUp(e: KeyboardEvent): void {
			
			if (e.keyCode == Keyboard.A) {
				principal_mc.cycliste_mc.arretGauche();
			}
			if (e.keyCode == Keyboard.D) {
				principal_mc.cycliste_mc.arretDroite();
			}
			if (e.keyCode == Keyboard.W) {
				principal_mc.cycliste_mc.arretHaut();
			}
			if (e.keyCode == Keyboard.S) {
				principal_mc.cycliste_mc.arretBas();
			}
				 
		}

//------------------ CONTROLE CLAVIER  FIN --------------------------------------------------------
		public function rand(a: int, b: int): int {
			return Math.floor(Math.random() * (b - a + 1)) + a;
		}
		public function recommencer():void{
			dispatchEvent(new Event("reset",true));
		}
		