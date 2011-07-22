package com.rafaelrinaldi.string
{
	
	/**
	* 
	* @author Arthur Debert (stimuli.com.br)
	* 
	* */
	
	public function trim( p_string : String ) : String
	{
		return p_string.replace(LTRIM, "").replace(RTRIM, "");
	}

}

internal const LTRIM : RegExp = /^(\s|\n|\r|\t|\v|\f)*/m;
internal const RTRIM : RegExp = /(\s|\n|\r|\t|\v\|f)*$/;