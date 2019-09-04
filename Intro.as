package {	import flash.display.MovieClip;	import flash.events.*;	public class Intro extends MovieClip {		private var nomEcran:String="intro";
		private var _premiereFois:Boolean=true;		public function Intro() {
			trace(">>> écran",nomEcran,"créé");		}		private function goPrincipal(e:MouseEvent):void {			MovieClip(parent).goto("principal",this);
			if(_premiereFois==false){ // permet de recommencer une nouvelle parti 
				Main(parent).recommencer();
				}
			_premiereFois=false // change l'état apres la premiere utilitation		}
		
		public function activer():void{
			trace("Écran",nomEcran,"activé");
			visible=true;
			btPrincipal.addEventListener(MouseEvent.CLICK, goPrincipal);
		}
		
		public function desactiver():void{  // désactive la page
			trace("Écran",nomEcran,"desactivé");
			btPrincipal.removeEventListener(MouseEvent.CLICK, goPrincipal);
			visible=false;
		}	}//classe}//package