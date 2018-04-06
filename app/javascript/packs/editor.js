import ace from 'brace';
import 'brace/mode/javascript';
import 'brace/theme/monokai';
import $ from 'jquery';

var editor = ace.edit('editor-stream');
editor.getSession().setMode('ace/mode/javascript');
editor.setTheme('ace/theme/monokai');
editor.setFontSize('14px');

editor.session.on('changeAnnotation', function() {
    const annotations = editor.getSession().getAnnotations();
    if (annotations.some(e => e.type === 'error')) {
        console.log('We have an error!')
    }
    console.log(annotations)
});

editor.session.on('change', function(delta) {
    const value = editor.getValue();
    $('input#stream_code').val(value)
});