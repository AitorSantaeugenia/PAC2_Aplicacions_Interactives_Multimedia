package edu.uoc.pac2
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class PreloaderBar extends MovieClip
	{
		
		// Todas las instancias ya presentes en la timeline
		// deben declararse como públicas
		//public var textField:TextField;
		
		public function PreloaderBar()
		{			
			init();
		}
		
		private function init():void {
			// Estado inicial del preloader
			//changeText("---");
			gotoAndStop(0);
		}
		
		public function changeText(txt:String):void {
			// Cambiamos el texto que aparece en el preloader
			//textField.text = txt;
		}
		
		public function percentage(percent:int):void {
			// Si en AnimateCC entráis en progressBar podéis desplazar la cabeza de lectura en la timeline
			// y ver como se utiliza para mostrar gráficamente la descarga.
			gotoAndStop(percent);
			
		}
	}
}

