package edu.uoc.pac2
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class PhotoInfoPanel extends Sprite
	{
		// Todas las instancias ya presentes en la timeline
		// deben declararse como públicas
		public var photoTitle_tf:TextField;
		public var authorName_tf:TextField;
		
		public var btInfo_bt:SimpleButton;
		public var photoInfoBg_sp:Sprite;
		
		// Guardaremos los datos de todos los libros de la lista
		//private var _books:Array;
		
		// Private vars
		//private var _galleryData:Array;         	  // Contendrá los datos de nuestra galería
					
		//MEINE
		private var title:String;
		private var autor:String;
		public 	var activado:Boolean = true;

		// Constantes
		const GUTTER:int = 20; // Para obtener separaciones entre elementos
		
		public function PhotoInfoPanel(){
			
			// Recuperamos los datos de la galería
			//_galleryData = galleryData;
			//_numSlides = galleryData.length;
			
			// Nos aseguramos que la clase PhotoInfoPanel 
			// ha sido intanciada
			// y añadida a stage
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(ev:Event):void {
			// Ya no necesitamos este eventListener
			// Nota: recordad que siempre es bueno optimizar una aplicación
			// eliminando los escuchadores que ya no utilizamos.
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			//ETAPA 2 - BOTO btInfo_bt
			btInfo_bt.addEventListener(MouseEvent.CLICK, btInfo_bt_Interactivity);
			//setInfo(); 	
		}

		// ------------------------------------------------------------------------------------------------
		//ETAPA 2 - BOTO btInfo_bt VISIBLE O NO VISIBLE
		public function btInfo_bt_Interactivity(event:MouseEvent):void{
			if(activado= true){
				//NO FUNCIONA POSANT VISIBLE = TRUE O VISIBLE = FALSE; per això feim !photoTitle_TF.visible
				//es el mateix que fer !true o !false
				photoTitle_tf.visible = !photoTitle_tf.visible;
				authorName_tf.visible = !authorName_tf.visible;
				photoInfoBg_sp.visible = !photoInfoBg_sp.visible;	
				activado = false;
			}else if(activado=false){
				photoTitle_tf.visible = true;
				authorName_tf.visible = true;
				photoInfoBg_sp.visible = true;	
				activado = true;
			}
		}
		// ------------------------------------------------------------------------------------------------
		
		//ETAPA 2 - setInfo
		/*public function setInfo()
		{
			photoTitle_tf.text = title;
			authorName_tf.text = autor;
			//trace(_galleryData[0][1]);
			// Modificamos texto en textfield
		}*/
				
		override public function set width(widthValue:Number):void {
			// A veces puede ser interesante modificar un método de la superclase.
			// En este caso nos interesa que se pueda modificar en ancho del elemento
			// pero no escalandolo sin modificando cada elemento en su interior
			// de manera diferente.
			
			// Fondo
			// este si lo ensanchamos
			photoInfoBg_sp.width = widthValue;
			
			// Botón información
			btInfo_bt.x = widthValue - btInfo_bt.width - GUTTER;
			
			// Campos de texto
			photoTitle_tf.width = btInfo_bt.x - GUTTER;
			authorName_tf.width = photoTitle_tf.width;
		}
	}
}