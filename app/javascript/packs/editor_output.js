import ace from 'brace';
import 'brace/mode/javascript';
import 'brace/theme/monokai';

var editor_output = ace.edit('editor-output');
editor_output.getSession().setMode('ace/mode/javascript');
editor_output.setTheme('ace/theme/monokai');
editor_output.setFontSize('14px');

var editor_input = ace.edit('editor-input');
editor_input.getSession().setMode('ace/mode/javascript');
editor_input.setTheme('ace/theme/monokai');
editor_input.setFontSize('14px');