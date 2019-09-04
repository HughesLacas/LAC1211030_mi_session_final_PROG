package  {
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Ball extends MovieClip{
		//----------PROPRIÉTÉ-------------------------
		private var _vitesse:int=30;
		private var _posZomX:int;
		private var _posZomY:int;
		private var velo:Cycliste;
		public function Ball(posX:Number, posY:Number):void {
			x=posX;
			y=posY;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		// MÉTHODES PRIVÉES -------------------------------------------------
		private function init(e:Event):void {
			addEventListener(Event.ENTER_FRAME, loop);
			Main(parent.parent).addEventListener("reset", reset);
		}

		private function loop(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init); // enleve L,écouteur init
			y-=_vitesse; 
				// detection de collision avec les zombie-------------------------------------------------------------
				if( MovieClip(parent).clipZombie!= null){ // entre dans les colision si le clip n'est pas null
					for(var k:uint = 0; k< MovieClip(parent).clipZombie.numChildren; k++){ 
						if( Principal(parent).clipZombie.getChildAt(k).hitTestObject(this)){
							// on détruit le zombie
							Zombie(Principal(parent).clipZombie.getChildAt(k)).zombieMeur();
							//Zombie(Principal(parent).clipZombie.getChildAt(k)).killZombie();
							kill();
							// ajout munition-------------------------------------------
							return void;
						}
					}
				}
				// DETECTION DE COLLISION AVEC AUTO -------------------------------------------------------
				if( MovieClip(parent).clipAutos!= null){ // entre dans les colision si le clip n'est pas null
					for(var j:uint = 0; j<MovieClip(parent).clipAutos.numChildren; j++){ // on va chercher le nombre d'auto en jeux
						if( Principal(parent).clipAutos.getChildAt(j).hitTestObject(this)){ // on va chercher tout les autos individuellement
							kill();
							return void;
						}
					}
				}
			
			// si la ball dépase la scene--------------------------------------------------------------------
			if (y < 0) {
				kill();
			} 
		}// fin loop

		// DESTRUCTEUR -------------------------------------------------------;
		public function kill():void { // détruit le Clip 
			Main(parent.parent).removeEventListener("reset", reset);
			Principal(parent).removeChild(this);
			removeEventListener(Event.ENTER_FRAME, loop);  
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		public function reset(e:Event):void{
			kill();
		}
	//-------------------- GETTER SETTER ------------------------------
		public function get posZomX():Number{
				return _posZomX;
			}
		public function get posZomY():Number{
				return _posZomY;
			}

	}// class
	
}//pakage