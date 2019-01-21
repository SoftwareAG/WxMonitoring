/* --------- init showdown --------- */

// showdown links:
//   syntax   https://github.com/showdownjs/showdown/wiki/Showdown's-Markdown-syntax
//   examples http://demo.showdownjs.com/
//   options  https://github.com/showdownjs/showdown/wiki/Showdown-Options


// set default classes
const classMap = {
    h1: 'ui large header',
    h2: 'ui medium header',
    ul: 'ui list',
    li: 'ui item'
  }
  
const bindings = Object.keys(classMap)
    .map(key => ({
        type: 'output',
        regex: new RegExp(`<${key}(.*)>`, 'g'),
        replace: `<${key} class="${classMap[key]}" $1>`
}));
  
// const conv = new showdown.Converter({
//     extensions: [...bindings]
// });

// global settings
showdown.setFlavor('github');

var myconverter = new showdown.Converter({
    tables: true, 
    strikethrough: true,
    tasklists: true,
    extensions: [...bindings]
})

/* --------- custom script --------- */

/**
 * load md-file into html page
 * example: displayMD('overview.md', 'nl-overview')
 * @param {*} page 
 * @param {*} elementID 
 */
function displayMD(page, elementID) {
    //
    var node = document.getElementById(elementID);

    // using fetch-API: 
    //      https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch
    fetch(page)
    .then(response => response.text())
    .then((data) => {
        html = myconverter.makeHtml(data);
        node.innerHTML = html;
    })
    .catch(error => console.error(error));
}

/**
 * lookup page for tags and fill with md-content 
 * example: buildMDContent('div', 'nl')
 * @param {*} tagname 
 * @param {*} prefix 
 */
function buildMDContent(tagname, prefix) {
    // console.log("buildMDContent (tagname="+tagname+", prefix="+prefix+")"); 
    var prefix2 = prefix+'-'
    document.querySelectorAll(tagname).forEach(function(element) {
        var id1 = element.id
        if (id1 != null && id1.startsWith(prefix2)) {
            var name1 = element.id.slice(prefix2.length)
            // console.log(" found <div id='"+element.id+"' />")
            displayMD(name1+'.md', element.id)
        }
	});
}

// build content from MD files
buildMDContent('div', 'nl')