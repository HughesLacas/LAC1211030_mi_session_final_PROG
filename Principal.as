package {	import flash.display.MovieClip;	import flash.events.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.media.*;
		public class Principal extends MovieClip {		private var nomEcran:String="principal";
		
		//------------- VITESSE ROUTE
		private var _vitesse:int=8;
//---Spawn obstacle--------------------------------------------
	//spawn auto--------------------------
		private var a: Auto;
		private var _nombreAuto:int=2;
		private var _clipAutos:MovieClip;
	//-------lvl --------------------------------------------
		private var _lvl:int;
		private var _pointLvl:int;
	//spawn zombie-------------------
		private var zo: Zombie;
		private var _nombreZombie:uint=2;
		private var _clipZombie:MovieClip;
	//---------- AFFICHAGE -----------------------------------
		private var _point:int;
	//------MUNITION---------------------------------------
		private var _bonusMunition:int;
		private var _bonusAleatoir:int;
	//début de la parti----------------------------
		private var _premiereParti:Boolean=true;
		private var _debutParti:Boolean=false;
		
	//--- MUSIC DE JEUX (MÉTAL// BRING ME THE HORIZON // DEATH BREATH)
		var mySound:Sound = new Sound();
		var myChannel:SoundChannel = new SoundChannel();
		var myTransform = new SoundTransform();		public function Principal() {
			trace(">>> écran",nomEcran,"créé");
			Main(parent).addEventListener("reset", reset);		}
		private function start(e:MouseEvent){ // function pour L'immortaliter de départ
			init();
			_debutParti=true;
			stage.addEventListener(Event.ENTER_FRAME,loop);
			tuto_mc.visible=false;
			removeEventListener(MouseEvent.CLICK,start);
		}				public function goFin():void {			MovieClip(parent).goto("fin", this);		}
		public function activer():void{
			addEventListener(MouseEvent.CLICK,start);
			trace("Écran",nomEcran,"activé");
			visible=true;
			
			//addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function desactiver():void{
			trace("Écran",nomEcran,"desactivé");
			visible=false;
		}
		
		//---MÉTHODE PRIVÉE----------------------------------------
		private function init():void{
			mySound= new music();
			myTransform.volume= 0.1;
			myChannel = mySound.play();
			myChannel.soundTransform=myTransform;
				// affichage de score-----------------
				text_mc.conteur.text = _point.toString();
				// affichage Munition-------------------
				text_mc.munition.text = cycliste_mc.afficheMunition.toString();
				// affichage lvl-----------------------
				text_mc.lvl.text = _lvl.toString();
			
				
			if(_premiereParti==true){
				//-------- AJOUT D'AUTO---------------
					_premiereParti=false;
					_clipAutos=new MovieClip(); // cree un clip pour toute les auto
					addChild(_clipAutos);
					for(var i:int = 0; i<=_nombreAuto; i++){
						a = new Auto();
						_clipAutos.addChild(a);
						a.respawn();
					}
				//-------- AJOUT DE ZOMBIE-------------------
				
					_clipZombie=new MovieClip(); // cree un clip pour toute les Zombie
					addChild(_clipZombie);
					for(var k:uint = 0; k<=_nombreZombie-1; k++){
						zo = new Zombie();
						_clipZombie.addChild(zo);
						zo.respawnZo();
					}
				}
				// place les items dans les profondeur voulu
					setChildIndex(text_mc, 4);
					setChildIndex(tuto_mc, 4);
					setChildIndex(cycliste_mc, 2);
					setChildIndex(_clipZombie, 2);
					setChildIndex(_clipAutos, 2);
		}
		//------------------
		private function loop(e: Event): void {
			
			_bonusMunition=0;// remet le bonus a 0 
		// Déplacer la route--------------------------------------------------------
			if (route1_mc.y >= 565) {
				route1_mc.y = -565;
				route2_mc.y = 565;
				}
				route1_mc.y += _vitesse+_lvl;
				route2_mc.y += _vitesse+_lvl;
		// update des afichages---------------------------------
				updateMunition();
				updateVie();
				

		// s'assure que le nombre de zombie en jeux et TOUJOURS égale au _nombreZombie
				if(_clipZombie.numChildren<_nombreZombie+(_lvl/3)){
				// respawn les zombies---------------------------------------
					for( var i:int=0;i<_nombreZombie-_clipZombie.numChildren+(_lvl/4);i++){
						_bonusAleatoir=Math.floor(Math.random()*11);// donne un % de chance de récolter un certain bonus
						if(_bonusAleatoir<=8){ // 80% de chance d'Avoir 1 balle
							_bonusMunition+=2;
						}else if(_bonusAleatoir>8){ //20% d'en avoir 2
							_bonusMunition+=3;
						}
  						// augment les munition
						cycliste_mc.munition=_bonusMunition;
						// augmente le score
						updatePoint();
						_pointLvl++;
						// création du zombie
						zo = new Zombie();
						_clipZombie.addChild(zo);
						zo.respawnZo();
					}
				}
				
			
			
		// lvl up -----------------------------------------------------
				if (_pointLvl==5){
					lvlUp();
					_pointLvl=0;
					}
					
		// Pouvoir enlever l'ENTER_FRAME loop--------------------------
			if(cycliste_mc.mort==true){
				finPartie();
				}
		}	
		
		// reset
		private function finPartie(){
			removeEventListener(Event.ENTER_FRAME, loop);
			myChannel.stop();
			}
		public function reset(e:Event):void{ // va permetre de redemarer une nouvelle parti
			// remet tout a 0 (les  -1 car dans les function lvlup et update on rajoute 1 point en partent)
			_point=-1;
			_lvl=-1;
			_pointLvl=-1;
			_bonusMunition=-1;
			lvlUp();
			updatePoint();
			gotoAndStop(1);
			addEventListener(Event.ENTER_FRAME, loop);
		}
// -------------GETTER | SETTER ------------------------------
			public function get debutParti():Boolean{
					return _debutParti;
				}
			// Auto
			public function get clipAutos():MovieClip{
					return _clipAutos;
				}
			//Zombie--------------------------------------
			public function get clipZombie():MovieClip{
					return _clipZombie;
				}
			public function get nombreZombie():int{
					return _nombreZombie;
				}
			//----- retour le lvl actuel
			public function get lvl():int{
					return _lvl;
				}

//------------UTILITAIRE----------------------------------------
		private function updatePoint():void{
				_point ++;
				text_mc.conteur.text = _point.toString();
		}
		private function updateMunition():void{
				text_mc.munition.text = cycliste_mc.afficheMunition.toString();
		}
		private function updateVie():void{
				text_mc.vie.text = cycliste_mc.vie.toString();
		}
		private function lvlUp():void{
				_lvl++;
				text_mc.lvl.text = _lvl.toString();
		}
		
		public function rand(a: int, b: int): int {
			return Math.floor(Math.random() * (b - a + 1)) + a;
		}	}//classe}//package