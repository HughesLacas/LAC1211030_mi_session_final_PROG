package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Auto extends MovieClip {
		
		
		//--PROPRIÉTÉ---------------------------
		private var _vitesse:uint=8;
		private var _voie:int;
		private var _voiture:int;
		//constructeur-----------------
		public function Auto() {
			addEventListener(Event.ADDED_TO_STAGE, init);
				
		}
		private function init(e:Event):void {
			addEventListener(Event.ENTER_FRAME, loop);
			Main(parent.parent.parent).addEventListener("reset", reset);
		}
		
		private function loop(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			y+=_vitesse+MovieClip(parent.parent).lvl;
			// si l'auto d'épasse la scene
			if(y>stage.stageHeight+100){
					respawn();
				}
		}
		// fait réaparaitre les voiture
		function respawn(): void {
			
			// fait apparaitre l'auto dans une voie aléatoire 
					_voie= Math.floor(Math.random()*4);
					if(_voie==0){
						x=rand(100,105)-155;
					}else if(_voie==1){
						x=rand(310,320)-155;
					}else if(_voie==2){
						x=rand(510,520)-155;
					}else if(_voie==3){
						x=rand(710,720)-155;
					}
					// fait apparaitre l'auto daans un Y aléatoire sau dessu de la scene
					y= -rand(stage.stageHeight,750-(height+50));
			// empeche qu'une auto apparaisse sur une autre
			for(var i:int=0; i<MovieClip(parent).numChildren;i++){
				var c: Auto = Auto(MovieClip(parent).getChildAt(i));
				if(c.Hit_auto.hitTestObject(this.Hit_auto) &&  c.Hit_auto!=this.Hit_auto){
					respawn();
					return void;
				}
			}
			rotation=Math.floor(rand(-5,5));
			_voiture=Math.floor(Math.random()*4+1);
			gotoAndStop(_voiture);
			
		}
		
		public function reset(e:Event):void{
			respawn();
		}
		
		//----GETTER ET SETTER--------------------
		public function get voie():int{
				return _voie;
			}
		// ---------------- UTILITAIRE ------------------------
		private function rand(n1:int, n2:int):Number {
			return Math.random()*(n2-n1+1)+n1;
		}

	}// class
	
}// package

