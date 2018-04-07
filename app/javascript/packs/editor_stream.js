import ace from 'brace';
import 'brace/mode/javascript';
import 'brace/theme/monokai';
import $ from 'jquery';

var editor = ace.edit('editor-stream');
editor.getSession().setMode('ace/mode/javascript');
editor.setTheme('ace/theme/monokai');
editor.setFontSize('14px');

editor.session.on('change', function (delta) {
    const value = editor.getValue();
    $('input#stream_code').val(value);
});

editor.session.on('changeAnnotation', function () {
    isAllValid();
});

$('#submit-file').change(function () {
    isAllValid();
});

function isCodeValid() {
    const annotations = editor.getSession().getAnnotations();
    console.log(annotations);
    return !annotations.some(e => e.type === 'error' || e.type === 'warning' || e.type === 'info');
}

function isFileLoaded() {
    return !($('#submit-file').get(0).files.length === 0);
}

function isAllValid(annotations) {
    if (isCodeValid(annotations) && isFileLoaded()) {
        $("#submit").prop('disabled', false);
    } else {
        $("#submit").prop('disabled', true);
    }
}
