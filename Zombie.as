package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.transitions.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	public class Zombie extends MovieClip {
		
	//----------PROPRIÉTÉ-------------------------
		private var _vitesse:int;
		private var _xMax:int=6;
		
		//------ SONG  -----------
		private var _meur:Sound;
		// constructor code---------------------------
		public function Zombie() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		// MÉTHODES PRIVÉES -------------------------------------------------
		private function init(e:Event):void {
			_meur=new tuer();
			addEventListener(Event.ENTER_FRAME, loop);
			Main(parent.parent.parent).addEventListener("reset", reset);
		}

		
		private function loop(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_vitesse=10;
			y+=_vitesse+MovieClip(parent.parent).lvl; // on ajoute un bonu de vitesse a la vitesse de base grave au lvl dans PRINCIPAL
			moveAi(10); // appelle la function déplacement
			// hitTest des zombie---------------------------------
			if( MovieClip(parent.parent).clipAutos!= null){ // entre dans les colision si le clip n'est pas null
				for(var j:uint = 0; j<MovieClip(parent.parent).clipAutos.numChildren; j++){ // on va chercher le nombre d'auto en jeux
					if(Principal(parent.parent).clipAutos.getChildAt(j).hitTestObject(this)){ // effectu les hitTest pour être sur que la cible n'embarque pas sur l'objet
						y-=_vitesse;
						return void;
					}
				}
			}
		//-----------------------------------------------------------------
		// zombie meur--------------------------
			if(currentFrame == 38){ // SI L'ANIMATION EST FINI ON TUE LE ZOMBIE
					var myTween:Tween = new Tween(this, "alpha", Strong.easeOut, 0.1, 0, 1, true);
					killZombie();
					return void;
				}
			// recyclage de zombie
			if(y>stage.stageHeight+200){
					respawnZo();
				}
			} // loop
			
		//---------- DÉPLACEMENT AI -------------------
		private function moveAi(vitesse:int){
			if(y+100 <= MovieClip(parent.parent).cycliste_mc.y){ // direction du zombie quand il est dessu le cycliste--------------------
					if(x >= MovieClip(parent.parent).cycliste_mc.x){ 
						x-=rand(0,_xMax); // vitesse su l'axe des x
						//orientation--------------
							if(x >= MovieClip(parent.parent).cycliste_mc.x+50){
								rotation=45;
							}else if(x >= MovieClip(parent.parent).cycliste_mc.x+25){
								rotation=0;
							}
						return void;
					}else if (x <= MovieClip(parent.parent).cycliste_mc.x){
						x+=rand(0,_xMax);// vitesse su l'axe des x
						//orientation--------------
							if(x <= MovieClip(parent.parent).cycliste_mc.x-50){
								rotation=-45;
								}else if(x <= MovieClip(parent.parent).cycliste_mc.x-25){
								rotation=0;
								}
						return void;
					}
			}else if(y-200 <= MovieClip(parent.parent).cycliste_mc.y){  // direction du zombie quand il est dessou le cycliste--------------------
					if(x >= MovieClip(parent.parent).cycliste_mc.x){
						x-=rand(0,_xMax);// vitesse su l'axe des x
						//orientation--------------
							if(x >= MovieClip(parent.parent).cycliste_mc.x+50){
								rotation=135;
							}else if(x >= MovieClip(parent.parent).cycliste_mc.x+25){
								rotation=180;
							}
						return void;
					}else if (x <= MovieClip(parent.parent).cycliste_mc.x){
						x+=rand(0,_xMax);// vitesse su l'axe des x
						//orientation--------------
							if(x <= MovieClip(parent.parent).cycliste_mc.x-50){
								rotation=-135;
								}else if(x <= MovieClip(parent.parent).cycliste_mc.x-25){
								rotation=180;
								}
						return void;
					}
			}
		}
		public function respawnZo(): void { // fonction appeler a chaque foi qu'un zombie meur ou dépasse la limite du Y
				// redémare l'animation
					gotoAndPlay(1);
					// respawn sur un X aléatoire et un Y plus bas que 0
					x= rand(200, stage.stageWidth-(width+150));
					y= -rand(550, 0);
			// empeche qu'un zombie apparaisse sur une autre
			for(var i:int=0; i<MovieClip(parent).numChildren;i++){
				if( MovieClip(parent).getChildAt(i).hitTestObject(this) &&  MovieClip(parent).getChildAt(i)!=this){
					respawnZo();
				}
			}
		}// respawn
		public function zombieMeur(){
				gotoAndPlay(31);
				_meur.play();
			}
			
	//-----------Function public
			public function killZombie():void { // détruit totalement le ZOMBIE ( UNE BALL DANS LA TETE)
			Main(parent.parent.parent).removeEventListener("reset", reset);
			MovieClip(parent).removeChild(this);
			removeEventListener(Event.ENTER_FRAME, loop);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		public function reset(e:Event):void{ // on recycle les zombies en jeux pour le reset 
			respawnZo();
		}
		// ---------------- UTILITAIRE ------------------------
		private function rand(n1:int, n2:int):Number {
			return Math.random()*(n2-n1+1)+n1;
		}
		public function toucher():void{
				removeEventListener(Event.ENTER_FRAME, loop);
				Principal(parent).removeChild(this);
			}
	}// class
	
}// package
