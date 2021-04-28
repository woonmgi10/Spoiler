/**
 * @license Copyright (c) 2003-2021, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	
	config.toolbar = [

        ['Font', 'FontSize'],

        ['TextColor','BGColor' ],

        ['Bold', 'Italic', 'Strike', 'Superscript', 'Subscript', 'Underline', 'RemoveFormat'],   

        ['BidiLtr', 'BidiRtl'],

        '/',

        ['Image', 'SpecialChar', 'Smiley'],

        ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],

        ['Blockquote', 'NumberedList', 'BulletedList'],

        ['Link', 'Unlink'],

        ['Source'],

        ['Undo', 'Redo']

];
	
	
	config.enterMode = CKEDITOR.ENTER_BR
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
};