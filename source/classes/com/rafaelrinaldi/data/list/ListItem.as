package com.rafaelrinaldi.data.list
{
	import com.rafaelrinaldi.abstract.IDisposable;

	import flash.display.Bitmap;
	
	/**
	 * List entry manager.
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 8, 2011
	 */
	public class ListItem implements IDisposable
	{
		/** Item id. **/
		public var id : String;
		
		/** Item value.**/
		public var value : *;
		
		/**
		 * @param p_id Item id.
		 * @param p_value Item value.
		 */
		public function ListItem( p_id : String, p_value : * = null )
		{
			id = p_id;
			value = p_value;
		}
		
		/**
		 * Match a value.
		 * @param p_query Query to match (strict equality).
		 * @return "true" if the query matches something, "false" otherwise.
		 */
		public function match( p_query : * ) : Boolean
		{
			return value === p_query;
		}

		/**
		 * Clean value from memory.
		 */
		public function dispose() : void
		{
			if(value != null) {
				
				// Try to clean the value using most common method names for disposing.
				if(value.hasOwnProperty("dispose")) value.dispose();
				if(value.hasOwnProperty("kill")) value.kill();
				if(value.hasOwnProperty("flush")) value.flush();
				if(value.hasOwnProperty("destroy")) value.destroy();
				if(value is Bitmap) Bitmap(value).bitmapData.dispose();
				
				value = null;
				
			}
		}
		
		/** @private **/
		public function toString() : String
		{
			return value;
		}
	}
}
