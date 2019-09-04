package {	import flash.display.MovieClip;	import flash.events.*;	public class Fin extends MovieClip {
		private var nomEcran:String="fin";		public function Fin() {
			trace(">>> écran",nomEcran,"créé");		}		private function goPrincipal(e:MouseEvent):void { // retour au jeux			MovieClip(parent).goto("principal", this);
			Main(parent).recommencer(); // permet de recommencer la parti		}				private function goIntro(e:MouseEvent):void { // permet d,aller a la page d'intro			MovieClip(parent).goto("intro",this);		}		
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
		}//classe}//package