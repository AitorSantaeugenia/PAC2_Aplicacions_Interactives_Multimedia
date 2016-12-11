package edu.uoc.pac2
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class ArrowBt extends Sprite
	{
		// Todas las instancias ya presentes en la timeline
		// deben declararse como públicas
		public var normalState_sp:Sprite;
		public var hoverState_sp:Sprite;
		public var clickState_sp:Sprite;
		
		public function ArrowBt()
		{
			// Nos aseguramos que la clase ArrowBt 
			// ha sido intanciada
			// y añadida a stage
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(ev:Event):void {
			// Ya no necesitamos este eventListener
			// Nota: recordad que siempre es bueno optimizar una aplicación
			// eliminando los escuchadores que ya no utilizamos.
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			// AFEGIM EVENTS DEL RATOLI
			addEventListener(MouseEvent.CLICK, mouseClick);
			addEventListener(MouseEvent.MOUSE_OVER, mouseHover);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			
			//ETAPA 4 - CONTROL AMB EL KEYBOARD
			/* La funcionalitat si llevem els comentarios aquests i els de més abaix, está bé
			el problema es que ens mostrará el color tant en el botó de la dreta com el de la esquerra*/
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, mouseClick_keyboard);
			//stage.addEventListener(KeyboardEvent.KEY_UP, mouseClick_keyboard_Out);
			
			// Dado que ArrowBt hereda de Sprite
			// pero queremos tratarlo como un botón, nos interesa:
			// que el cursor cambie su aspecto al pasar por encima
			buttonMode = true;
			// que sus elementos internos queden inhabilitados para interacciones con el ratón
			mouseChildren = false;
		}
		
		private function mouseHover(ev:MouseEvent):void {
			//trace("Mouse a sobre");
			//hoverState_sp:Sprite;
			normalState_sp.visible = false;
			clickState_sp.visible = false;
			hoverState_sp.visible = true;
		}
		
		private function mouseOut(ev:MouseEvent):void {
			//trace("Mouse out");
			normalState_sp.visible = true;
			clickState_sp.visible = false;
			hoverState_sp.visible = false;
		}
		
		private function mouseClick(ev:MouseEvent):void {
			//trace("Mouse click");
			normalState_sp.visible = false;
			clickState_sp.visible = true;
			hoverState_sp.visible = false;
			//clickState_sp:Sprite;
		}
		
		//SI ACTUEM AMB EL TECLAT
		/*private function mouseClick_keyboard(ev:KeyboardEvent):void {
			trace("Teclat click");
				normalState_sp.visible = false;
				clickState_sp.visible = true;
				hoverState_sp.visible = false;
				//clickState_sp:Sprite;
		}
		private function mouseClick_keyboard_Out(ev:KeyboardEvent):void {
			trace("Teclat click");
			normalState_sp.visible = true;
			clickState_sp.visible = false;
			hoverState_sp.visible = false;
			//clickState_sp:Sprite;
		}*/

	}
}