package {	import flash.display.MovieClip;	import flash.events.*;	import flash.ui.Keyboard;
		public class Main extends MovieClip {
		//-------------ÉCRAN---------------		private var ecranCourant:MovieClip;
		private var _princi: Principal;
		
		//---- PROTPIÉTÉ--------------
		
		//**************CONSTRUCTEUR****************************		public function Main() {			goto("intro");
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			
					}		//-------CHANGEMENT DE PAGE ------------------------------		public function goto(destination:String, ecranCourant:MovieClip=null):void {
			if(ecranCourant!=null) ecranCourant.desactiver();
			if(destination=="intro"){
				intro_mc.activer();
			}else if(destination=="principal"){
				principal_mc.activer();
			}else if(destination=="fin"){
				fin_mc.activer();
			}		}
		
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
			}//classe}//package