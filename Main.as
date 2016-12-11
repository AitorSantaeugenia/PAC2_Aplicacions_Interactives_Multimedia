package edu.uoc.pac2
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Main extends Sprite
	{
		private var _gallery:Gallery;
		private var _galleryData:Array;
		private var _photoTitle:PhotoInfoPanel;
		private var _photoAuthor:PhotoInfoPanel;
		
		//private var _test:PhotoInfoPanel;
		
		public function Main()
		{
			// Nos aseguramos que la clase del documento 
			// ha sido intanciada (creación de root)
			// y añadida a stage
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(ev:Event):void {
			// Ya no necesitamos este eventListener
			// Nota: recordad que siempre es bueno optimizar una aplicación
			// eliminando los escuchadores que ya no utilizamos.
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			//
			_galleryData = [ 
				{
					title:"Doubtful Sound. New Zealand.", 
					author:"Bernard Spragg. NZ", 
					imageUrl:"https://c8.staticflickr.com/8/7106/13630333343_5d32d8a59b_h.jpg"
				},
				{
					title:"Southwood", 
					author:"davidgsteadman", 
					imageUrl:"https://c7.staticflickr.com/8/7348/11465319574_89e214ac36_b.jpg"
				},
				{
					title:"Gnarled Tree", 
					author:"Joe deSousa", 
					imageUrl:"https://c5.staticflickr.com/4/3905/14675770684_afc8f9e171_k.jpg"
				},
				{
					title:"Lighthouse on Campobello", 
					author:"Mark Hathaway", 
					imageUrl:"https://c2.staticflickr.com/3/2835/10070632353_199f28f751_k.jpg"
				}
			];
			
			// INIT
			trace("App init");
			_gallery = new Gallery(_galleryData);
			//_testing = new PhotoInfoPanel(_galleryData);
			addChild(_gallery);
			
			//_test = new PhotoInfoPanel(_galleryData);
			}

		}
	}