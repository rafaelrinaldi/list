package com.rafaelrinaldi.data.list
{
	import com.rafaelrinaldi.abstract.IDisposable;

	import flash.utils.Dictionary;
	/**
	 * 
	 * Handy way to manipulate lists.
	 * 
	 * Features:
	 * 
	 * • Single and group items manipulation.
	 * • Overriding control.
	 * • Each entry is mapped with an <code>String</code> id. Nothing is anonymous.
	 * • You can reset a list and start from scratch if needed.
	 * • Chaining for fast adding/removing items.
	 * • Match items by id or value.
	 * 
	 * @example
	 * <pre>
	 * import com.rafaelrinaldi.data.list.List;
	 * import flash.display.Bitmap;
	 * 
	 * // A random bitmap instance.
	 * var bitmapInstance : Bitmap = new Bitmap;
	 *
	 * // Starting the list with the id "generic".
	 * var generic : List = new List("generic");
	 *	
	 * // Adding some stuff.
	 * generic.add("pi", Math.PI);
	 * generic.add("max", int.MAX_VALUE);
	 * generic.add("bitmap", bitmapInstance);
	 *	
	 * // Getting items.
	 * trace(generic.item("pi")); // 3.141592653589793
	 * trace(generic.item("max")); // 2147483647
	 * trace(generic.item("bitmap")); // [object Bitmap]
	 *	
	 * // Matching the id "pi".
	 * trace(generic.match("pi")); // true
	 * // Matching the Bitmap instance.
	 * trace(generic.match(bitmapInstance)); // true
	 * // Matching something invalid.
	 * trace(generic.match("foo")); // false
	 *	
	 * // Using groups.
	 * var locales : List = generic.group("locales");
	 *	
	 * // Using the chain.
	 * locales.add("pt_BR", "Brazilian Portuguese").add("en_US", "American English").add("it", "Italian");
	 *
	 * // Getting items.
	 * trace(locales.item("pt_BR")); // Brazilian Portuguese
	 * trace(locales.item("en_US")); // American English
	 * trace(locales.item("it")); // Italian
	 *
	 * // Removing an item.
	 * locales.remove("it");
	 *
	 * // Trying to get the removed item.
	 * trace(locales.item("it")); // null
	 * 
	 * // Overriding an item and getting him.
	 * locales.add("it", "Pizzalian");
	 * trace(locales.item("it")); // Pizzalian
	 *			
	 * // Disabling override and testing it.
	 * locales.allowOverride = false;
	 * locales.add("en_US", "Baconenglish");
	 * trace(locales.item("en_US")); // American English
	 * </pre>  
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 8, 2011
	 *
	 */
	public class List implements IDisposable
	{
		// Single items list.
		public var items : Dictionary;
		// Group items list.
		public var groups : Dictionary;
		
		public var id : String;
		public var allowOverride : Boolean;
		
		/**
		 * @param p_id List id ("null" by default).
		 * @param p_allowOverride Allow override option ("true" by default).
		 */
		public function List( p_id : String = null, p_allowOverride : Boolean = true )
		{
			if(p_id != null) id = p_id;
				
			allowOverride = p_allowOverride;
			
			// Enable week keys by default.
			items = new Dictionary(true);
			groups = new Dictionary(true);
		}
		
		/**
		 * @param p_id New item id.
		 * @param p_value New item value.
		 * @return Current scope.
		 */
		public function add( p_id : String, p_value : * ) : List
		{
			if(!allowOverride) {
				if(!items.hasOwnProperty(p_id)) items[p_id] = new ListItem(p_value);
			} else {
				items[p_id] = new ListItem(p_value);
			}
			
			return this;
		}
		
		/**
		 * @param p_id Item id.
		 * @return Current scope.
		 */
		public function remove( p_id : String ) : List
		{
			if(items.hasOwnProperty(p_id)) {
				ListItem(items[p_id]).dispose(); // Try to clean the object.
				delete items[p_id]; // Remove Dictionary reference.
			}
			
			return this;
		}

		/**
		 * @param p_id Item id.
		 * @return Item value.
		 */
		public function item( p_id : String ) : *
		{
			return items.hasOwnProperty(p_id) ? ListItem(items[p_id]).value : null;
		}

		/**
		 * @param p_id Group id.
		 * @return Group list.
		 */
		public function group( p_id : String ) : List
		{
			// If there's no group with passed id, create a new one.
			if(!groups.hasOwnProperty(p_id)) groups[p_id] = new List(p_id, allowOverride);
			return groups[p_id];
		}

		/**
		 * @param p_query Query to match. It can be the id or the value, doesn't matter.
		 * @return "true" if the query matches something, "false" otherwise.
		 */
		public function match( p_query : * ) : Boolean
		{
			var hasId : Boolean, hasValue : Boolean;
			
			hasId = items.hasOwnProperty(p_query);
			
			for(var id : String in items) {
				hasValue = ListItem(items[id]).match(p_query);
				if(hasValue) break;
			}
			
			return hasId || hasValue;
		}

		/**
		 * @param p_dictionary Dictionary instance to be cleaned.
		 */
		protected function clearList( p_dictionary : Dictionary ) : void
		{
			for(var id : String in p_dictionary) {
				IDisposable(p_dictionary[id]).dispose();
				delete p_dictionary[id];
			}
		}

		/**
		 * @param p_everything Reset items and groups as well? ("false" by default)
		 */
		public function reset( p_everything : Boolean = false ) : List
		{
			clearList(items);
			
			if(p_everything) clearList(groups);
			
			return this;
		}
		
		/**
		 * @return List length.
		 */
		public function get length() : int
		{
			var count : int = 0;
			var id : String;
			
			for(id in items) ++count;
			
			return count;
		}

		// Destroy all lists and all references.
		public function dispose() : void
		{
			reset(true);
			
			items = null;
			groups = null;
		}
	}
}