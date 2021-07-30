$(document).ready(function($) {
    'use strict';

    showdown.setFlavor('github');
    // Create markdown converter, starting all <h1> tags instead at <h3>
    var converter = new showdown.Converter({headerLevelStart: 3}),
        display_error_msg = function() {
            var downloads = $('#downloads'),
                more_details = $('#more-details');
            
            downloads.html('<h2>Sorry, we appear to be having difficulties fetching our binaries</h2>' + more_details[0].outerHTML);
        };

    $.ajax({
        url:'/github.php',
        success: function(data) {
            try {
                var jdata = JSON.parse(data);
            } catch(err) {
                display_error_msg();
                return;
            };
            var linux_oc = $('#oc-platforms .linux-platform'),
                mac_oc = $('#oc-platforms .mac-platform'),
                windows_oc = $('#oc-platforms .windows-platform'),
                linux_server = $('#server-platforms .linux-platform'),
                asset, index, append_html;
            
            // Ensures we have assets to provide for downloads
            if ('assets' in jdata) {
                // Iterate through GitHub returned asset list from `latest` release
                for (var i = 0; i < jdata['assets'].length; i++) {
                    asset = jdata['assets'][i];
                    // Places client-tools assets under the appropriate #oc-platforms block
                    if ((index = asset['name'].indexOf('client-tools')) >= 0) {
                        // index + 13 encapsulates the "client-tools" length plus an additional character for the trailing "-"
                        append_html = '<a href="' + asset['browser_download_url'] + '">' + asset['name'].substring(index + 13) + '</a><br>';
                        if (asset['name'].indexOf('linux') >= 0) {
                            linux_oc.append(append_html);
                        } else if (asset['name'].indexOf('windows') >= 0) {
                            windows_oc.append(append_html);
                        } else if (asset['name'].indexOf('mac') >= 0) {
                            mac_oc.append(append_html);
                        }
                    // Places origin-server assets under the appropriate #server-platforms block
                    } else if ((index = asset['name'].indexOf('origin-server')) >= 0) {
                        // index + 14 encapsulates the "origin-server" length plus an additional character for the trailing "-"
                        append_html = '<a href="' + asset['browser_download_url'] + '">' + asset['name'].substring(index + 14) + '</a><br>';
                        if (asset['name'].indexOf('linux') >= 0) {
                            linux_server.append(append_html);
                        }
                    }
                }
            } else {
                display_error_msg();
                return;
            }
            // Ensures we have body text to provide for release notes
            if ('body' in jdata) {
                var release_notes = $('#release-notes .release-content');
                release_notes.html('<h2 style="text-align:center;">Release Notes</h2>' + converter.makeHtml(jdata['body']));
            }
        },
        error: function() {
            display_error_msg();
        }
    });
});
