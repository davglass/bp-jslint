(function() {
    
    BPJSLint = {
        error: function() {
            //console.log('error: ', arguments);
            return false;
        },
        callback: function(data) {
            if (data && data.status) {
                if (data.errors) {
                    for (var i = 0; i < data.errors.length; i++) {
                        BPJSLint.log(data.errors[i].line + ', ' + data.errors[i].character + ': <pre>' + data.errors[i].data + '\n' + data.errors[i].reason + '</pre>');
                    }
                }
            }
        },
        _getScripts: function() {
            var scripts = [];
            var sc = document.getElementsByTagName('script');
            for (var i = 0; i < sc.length; i++) {
                var data = {};
                if (sc[i].src) {
                    //Ignore code from yahooapis and this file..
                    if ((sc[i].src.indexOf('yahooapis') == -1) && (sc[i].src.indexOf('bp-jslint.js') == -1)) {
                        data.src = sc[i].src;
                    } else {
                        data = null;
                    }
                } else {
                    data.txt = sc[i].innerHTML;
                }
                if (data) {
                    scripts.push(data);
                }
            }
            return scripts;
        },
        _status: null,
        _createStatus: function() {
            BPJSLint._status = document.createElement('div');
            var s = BPJSLint._status.style;
            s.border = '1px solid black';
            s.position = 'absolute';
            //s.height = '50px';
            s.width = '400px';
            s.top = '3px';
            s.left = '3px';
            s.padding = '5px';
            s.fontSize = '10px';
            s.display = 'none';
            s.backgroundColor = 'yellow';
            s.backgroundImage = 'url( http://www.iconlet.com/download_32x32_/tango/32x32/dialog-warning.png )';
            s.backgroundPosition = 'top right';
            s.backgroundRepeat = 'no-repeat';

            BPJSLint._status.innerHTML = '<h2>JSLint Messages</h2>';
            document.body.insertBefore(BPJSLint._status, document.body.firstChild);
        },
        log: function(str) {
            if (str) {
                BPJSLint._status.style.display = 'block';
                BPJSLint._status.innerHTML += str;
            }
        },
        init: function() {
            BPJSLint._createStatus();
            BrowserPlus.init(function(res) {  
                if (res.success) {
                    BrowserPlus.require({
                        services: [
                            {
                                service: "JSLint",
                                version: "0",
                                minversion: "0.0.2"
                            }
                        ]
                    }, function(r) {
                        if (r.success) {
                            var scripts = BPJSLint._getScripts();
                            if (scripts.length) {
                                BrowserPlus.JSLint.jslint({ callback: BPJSLint.callback, scripts: scripts }, function(x){ });
                            }
                        } else {
                            alert('BP-JSLint failed to load..');
                        }
                    });
                } else {
                    alert('Browser Plus failed to load...');
                }
            });
        }
    };

    //Trap errors..
    window.onerror = BPJSLint.error;

    if(window.addEventListener)	{ // Standard
        window.addEventListener('load', BPJSLint.init, false);
    } else if(window.attachEvent) { // IE
        window.attachEvent('onload', BPJSLint.init);
    }

    
})();
