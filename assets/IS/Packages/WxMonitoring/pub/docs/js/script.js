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

// add content to html page
// TODO: build menu more dynamically
displayMD('overview.md', 'nl-overview')
displayMD('release-notes.md', 'nl-release-notes')
displayMD('getting-started.md', 'nl-getting-started')
displayMD('users-guide.md', 'nl-users-guide')
displayMD('roadmap.md', 'nl-roadmap')
displayMD('development-guide.md', 'nl-development-guide')
displayMD('about.md', 'nl-about')
