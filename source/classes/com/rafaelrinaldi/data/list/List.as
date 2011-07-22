package com.rafaelrinaldi.data.list
{
	import com.rafaelrinaldi.abstract.IDisposable;

	import flash.utils.Dictionary;
	/**
	 * 
	 * Handy way to manipulate lists.
	 *
	 * @author Rafael Rinaldi (rafaelrinaldi.com)
	 * @since Jul 8, 2011
	 *
	 */
	// TODO: Item id should be an option. User can be able to add an item without adding an id since I have the match by id or type.
	// TODO: Search can be also by index.
	public class List implements IDisposable
	{
		// Single items list.
		public var items : Dictionary;
		
		// Group items list.
		public var groups : Dictionary;
		
		// Restrict values.
		public var restrict : Vector.<Class>;
		
		public var id : String;
		public var allowOverride : Boolean;
		
		/**
		 * @param p_id List id ("null" by default).
		 * @param p_allowOverride Allow override option ("true" by default).
		 */
		public function List( p_id : String = "", p_allowOverride : Boolean = true )
		{
			id = p_id;
			allowOverride = p_allowOverride;
			
			// Enable week keys by default.
			items = new Dictionary(true);
			groups = new Dictionary(true);
			
			restrict = new Vector.<Class>();
		}

		/**
		 * @param p_data Feed the list with XML data.
		 */
		public function from( p_data : XML ) : void
		{
			merge(ListDecoder.decode(p_data));
		}

		/**
		 * @return Create a XML using current <code>List</code> data.
		 */
		public function export() : XML
		{
			return ListEncoder.encode(this);
		}
		
		/**
		 * @return A copy of the current <code>List</code> instance.
		 */
		public function clone() : List
		{
			var list : List = new List(id, allowOverride);
			list.restrict = restrict;
			list.items = items;
			list.groups = groups;
			return list;
		}
		
		/**
		 * Merge a <code>List</code> instance into the current.
		 * @param p_list List to be merged.
		 */
		public function merge( p_list : List ) : void
		{
			var item : ListItem;
			var list : List;
			var dictionary : Dictionary;
			
			allowOverride = p_list.allowOverride;
			
			// Merging restrict list.
			p_list.restrict.forEach(function( p_type : *, ...rest ) : void {
				if(restrict.indexOf(p_type) < 0) restrict.push(p_type);
			});
			
			// Merging single items.
			dictionary = p_list.items;
			
			for each(item in dictionary) {
				add(item.id, item.value);
			}
			
			// Merging groups.
			dictionary = p_list.groups;
			
			for each(list in dictionary) {
				
				group(list.id).allowOverride = list.allowOverride;
				
				for each(item in list.items) {
					group(list.id).add(item.id, item.value);
				}
			}
		}

		/**
		 * @param p_id New item id.
		 * @param p_value New item value.
		 * @return Current scope.
		 */
		public function add( p_id : String, p_value : * ) : List
		{
			if(restrict.length > 0) {
				
				const valid : Boolean = restrict.some(function( p_klass : Class, ...rest ) : Boolean {
					return p_value is p_klass;
				});
				
				if(!valid) return this;
				
			}
			
			if(!allowOverride) {
				if(!items.hasOwnProperty(p_id)) items[p_id] = new ListItem(p_id, p_value);
			} else {
				items[p_id] = new ListItem(p_id, p_value);
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
			return items.hasOwnProperty(p_id) ? printf(ListItem(items[p_id]).value, items) : null;
		}

		/**
		 * @param p_id Group id.
		 * @return Group list.
		 */
		public function group( p_id : String ) : List
		{
			// If there's no group with passed id, create a new one.
			if(!groups.hasOwnProperty(p_id)) groups[p_id] = new List(p_id);
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
			
			restrict.length = 0;
			restrict = null;
			
			items = null;
			groups = null;
		}
	}
}
