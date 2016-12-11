package edu.uoc.pac2
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
		
	public class Gallery extends Sprite
	{
		// Todas las instancias ya presentes en la timeline
		// deben declararse como públicas
		public var arrowL_sp:ArrowBt;
		public var arrowR_sp:ArrowBt;
		public var photoContainer_sp:Sprite;
		public var galleryBg_sp:Sprite;
		
		public var photoInfoPanel_sp:PhotoInfoPanel;
		public var preloader:PreloaderBar;
		
		// Private vars
		private var _galleryData:Array;         	  // Contendrá los datos de nuestra galería
		private var _actualSlideNumber:int;           // Nos permite saber la imagen actualmente visible
		private var _numSlides:int;
		
		//ETAPA 5 - TESTING SWIPE
		import flash.events.TransformGestureEvent;
		import flash.events.GestureEvent;
		import flash.events.PressAndTapGestureEvent;
		import flash.ui.Multitouch;	
		import flash.ui.MultitouchInputMode;		
			
		// Constantes
		const GUTTER:int = 20; // Para obtener separaciones entre elementos
		
		public function Gallery(galleryData:Array)
		{
			// Recuperamos los datos de la galería
			_galleryData = galleryData;
			_numSlides = galleryData.length;
			
			// Nos aseguramos que la clase Gallery
			// ha sido instanciada
			// y añadida a stage
			addEventListener(Event.ADDED_TO_STAGE,init);
			// Instanciación de las variables globales
		}
		
		//var loader:Loader = new Loader();
		//var urlImage:URLRequest = new URLRequest("lanostraImatge.jpg");
		
		private function init(ev:Event):void {
			// Ya no necesitamos este eventListener
			// Nota: recordad que siempre es bueno optimizar una aplicación
			// eliminando los escuchadores que ya no utilizamos.
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			// Siempre es aconsejable gestionar nosotros mismos el escalado de nuestra aplicación.
			// Por ello situaremos siempre nuestra aplicación en la esquina superior izquierda
			stage.align = StageAlign.TOP_LEFT;
			// y inhabilitaremos el escalado automático
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// Eventlisteners
			// Detectar cambios de resolución u orientación
			stage.addEventListener(Event.RESIZE,resizeHandler);
			// Navegación galería
			
			// Empezaremos la galería con la primera imagen
			// Nota: para mayor comodidad 0 indicará la primera imagen
			_actualSlideNumber = 0;
			
			//ETAPA 4 - CONTROL AMB EL KEYBOARD
			stage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			
			loadPhoto();
			
			//AFEGIM ELS BOTONS I ELS LISTENERS PER ELS DIFERENTS CLICKS NEXT o PREV
			arrowR_sp.addEventListener(MouseEvent.CLICK, nextSlide);
			arrowL_sp.addEventListener(MouseEvent.CLICK, prevSlide);
			
			//ETAPA 5 - SWIPE
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			stage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
			
			// AFEGIM EL PRELOADER
			//ETAPA 8
			preloaderStart();
			
		}
		//---------------------------------------------------------------------------------------------
		//ETAPA 8 - PRELOADER
		private function preloaderStart(){
			preloader.x = (stage.stageWidth-preloader.width)/2;
			preloader.y = (stage.stageHeight-preloader.height)/2;
			photoContainer_sp.addChild(preloader);
		}
		//---------------------------------------------------------------------------------------------
		private function loadPhoto():void {
			trace("Càrrega de fotografia nº "+_actualSlideNumber);
			
			// Loader nos permite cargar una imagen y monitorizar su descarga
			var loader:Loader = new Loader();
			
			var url:String;
			
			//image source can be online
			//note: adding random will make flash load image always as a new image, therefore not keeping it on cache
			url = _galleryData[0].imageUrl;
			
			// Creamos el urlRequest para utlizar con loader
			var urlImage:URLRequest = new URLRequest(url);
			
			// Lanzamos la descarga
			loader.load(urlImage);
			//loader.width = photoContainer_sp.width;
			//loader.height = photoContainer_sp.height;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			//photoContainer_sp.addChild(loader);

			
			//INICI DELS BOTONS SI ACTUALSLIDE ES 0 NOMES VEREM EL NEXT
			if(_actualSlideNumber == 0){
				arrowL_sp.visible = false;
				arrowR_sp.visible = true;
			}
			
			// Añadimos el preloader, que situamos en el centro de nuestra aplicación
			//photoContainer_sp.addChild(preloader);
			
			//ETAPA 7
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			//PRELOADER ETAPA 7
			preloader = new PreloaderBar();
		}
		//ETAPA 7 - CARGAS DE LA IMAGEN
		public function progressHandler(e:ProgressEvent):void {
			trace("Percentatge descarregat : " + (e.bytesLoaded/e.bytesTotal)*100 + "%");
			preloader.percentage((e.bytesLoaded/e.bytesTotal)*100);
		}
		private function completeHandler(e:Event):void {
			trace("Descàrrega completada");
		}
		
		//---------------------------------------------------------------------------------------------------------
		//ETAPA 3 - NEXTSLIDE
		private function nextSlide(ev:MouseEvent = null):void {
			trace("Foto següent ");
			
			//trace(_actualSlideNumber);
			//TRACE PER EL SLIDENUMBER
			_actualSlideNumber = _actualSlideNumber+1;

			//ELIMINEM ELS CHILDS ANTERIORS I AFEGIREM ELS SEGUENTS POSTERIORMENT AMB UPDATEPHOTOINFO
			if(_actualSlideNumber == 1){
				photoContainer_sp.removeChildAt(_galleryData[0].imageUrl);
			}else if(_actualSlideNumber == 2){
				photoContainer_sp.removeChildAt(_galleryData[1].imageUrl);
			}else if(_actualSlideNumber == 3){
				photoContainer_sp.removeChildAt(_galleryData[2].imageUrl);
			}
			
			//UPDATE PHOTO INFO
			updatePhotoInfo();
		}
		
		private function prevSlide(ev:MouseEvent = null):void {
			trace("Foto anterior ");
			
			//photoContainer_sp.removeChildAt(_actualSlideNumber);
			//TRACE PER EL SLIDENUMBER
			_actualSlideNumber = _actualSlideNumber-1;
			
			//ELIMINEM ELS CHILDS ANTERIORS I AFEGIREM ELS SEGUENTS POSTERIORMENT AMB UPDATEPHOTOINFO
			if(_actualSlideNumber == 2){
				photoContainer_sp.removeChildAt(_galleryData[3].imageUrl);
			}else if(_actualSlideNumber == 1){
				photoContainer_sp.removeChildAt(_galleryData[2].imageUrl);
			}else if(_actualSlideNumber == 0){
				photoContainer_sp.removeChildAt(_galleryData[1].imageUrl);
			}
			
			//UPDATE PHOTO INFO
			updatePhotoInfo();			
		}
		
		private function updatePhotoInfo(ev:MouseEvent = null):void {		
			// Loader nos permite cargar una imagen y monitorizar su descarga
			var loader:Loader = new Loader();
			
			//VARIABLES RANDOM PER LACTUALITZACIO DE DADES
			var url:String;
			var title:String;
			var autor:String;
			
			//ACTUALITZAM DADES
			url = _galleryData[_actualSlideNumber].imageUrl;
			title = _galleryData[_actualSlideNumber].title;
			autor = _galleryData[_actualSlideNumber].author;
			
			// Creamos el urlRequest para utlizar con loader
			var urlImage:URLRequest = new URLRequest(url);
			loader.load(urlImage);
			//photoContainer_sp.removeChildAt(_actualSlideNumber-1);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);

			
			//TRACTAMENT PER ELS ARROW (prev o next)
			if(_actualSlideNumber != 0 && _actualSlideNumber != 3){
				arrowL_sp.visible = true;
				arrowR_sp.visible = true;
			}else if (_actualSlideNumber == 0){
				arrowL_sp.visible = false;
			}else if(_actualSlideNumber == 3){
				arrowR_sp.visible = false;
			}
			
			//ETAPA 7
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			//PRELOADER ETAPA 7
			preloader = new PreloaderBar();		
			
			// AFEGIM EL PRELOADER
			preloaderStart();
		}
		//---------------------------------------------------------------------------------------------------------
		//---------------------------------------------------------------------------------------------------------
		//ETAPA 4 - CONTROL AMB KEYBOARD
		function myKeyDown(e:KeyboardEvent):void{
			//Afegim un control per no sobrepassar les imatges ja que donaría error, per això
			//direm que NO ha de ser més gran a 3
			if(e.keyCode == 39 && _actualSlideNumber<3){
				nextSlide();
			//Afegim un control per no sobrepassar les imatges ja que donaría error
			//direm que ha de ser DIFERENT a 0
			}else if(e.keyCode ==37 && _actualSlideNumber!=0){
				prevSlide();
			}
		}
		//---------------------------------------------------------------------------------------------------------
		//---------------------------------------------------------------------------------------------------------
		//ETAPA 5 - SWIPE
		function onSwipe (e:TransformGestureEvent):void{
			//trace("AITORRRRRMENTA");
			if (e.offsetX == 1) { 
				//User swiped towards right
				stage.x += 100; 
			}
			if (e.offsetX == -1) { 
				//User swiped towards left
				stage.x -= 100;
			} 
			if (e.offsetY == 1) { 
				//User swiped towards bottom
				stage.y += 100; 
			}
			if (e.offsetY == -1) { 
				//User swiped towards top
				stage.y -= 100;
			} 
		}
		//---------------------------------------------------------------------------------------------------------
		//---------------------------------------------------------------------------------------------------------		
		//ETAPA 9 OPCIONAL -- IMATGE A LA TOTAL GRANDARIA
		public function onComplete(e:Event):void {
			var img:Bitmap = Bitmap(e.target.content);
			photoContainer_sp.addChild(img);
			
			//stage.stageWidth | stage.stageHeight per la mida del stage
			img.width = stage.stageWidth;
			img.height = stage.stageHeight;
		}
		//---------------------------------------------------------------------------------------------------------
		//---------------------------------------------------------------------------------------------------------	
		private function resizeHandler(ev:Event = null):void {
			var stageW:int = stage.stageWidth;
			var stageH:int = stage.stageHeight;
			
			// Flechas
			// Nota: una de las ventajas que ofrece la preparación de asets gráficos vía AnimateCC
			// es poder elegir el punto origen de nuestro símbolo. Si en AnimateCC entráis en arrow_sp
			// veréis que su punto origen está a la derecha de todo y centrado verticalmente.
			// Esto nos simplifica el código para situar las flechas en los extremos izquierdo/derecho
			// y centrados verticalmente
			arrowL_sp.x = 0;
			arrowL_sp.y = stageH/2;
			arrowR_sp.x = stageW;
			arrowR_sp.y = stageH/2;
			
			// Fondo
			galleryBg_sp.x = 0;
			galleryBg_sp.y = 0;
			galleryBg_sp.width = stageW;
			galleryBg_sp.height = stageH;
			
			// Información foto
			photoInfoPanel_sp.x = 0;
			photoInfoPanel_sp.y = 0;
			photoInfoPanel_sp.width = stageW;

		}
		
	}
}