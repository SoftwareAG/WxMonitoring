function createNodalTree(id, data)
{   
  
    var dx = 10;
    var width = 500;
    var height = 400;
    var dy= width / 6;
        
    var diagonal = d3version4.linkHorizontal().x(d => d.y).y(d => d.x);
    
    var tree = d3version4.tree().nodeSize([dx, dy]);
    var margin = {top: 10, right: 120, bottom: 10, left: 40};

// var svg = d3version4.select(id).append("svg").attr("width", width).attr("height", height);
    var svg = d3version4.select(id)
              .append("svg").attr("viewBox", [-margin.left, -margin.top, width, height])
              .style("font", "12px sans-serif")
              .style("user-select", "none");

  const root = d3version4.hierarchy(data);
  
  root.x0 = dy / 2;
  root.y0 = 0;
  root.descendants().forEach((d, i) => {
    d.id = i;
    d._children = d.children;
    if (d.depth && d.data.name.length !== 7) d.children = null;
  });
 
   const gLink = svg.append("g")
      .attr("fill", "none")
      .attr("stroke", "#555")
      .attr("stroke-opacity", 0.4)
      .attr("stroke-width", 1.5);

  const gNode = svg.append("g")
      .attr("cursor", "pointer")
      .attr("pointer-events", "all");
      
  function update(source) {
    const duration = d3version4.event && d3version4.event.altKey ? 2500 : 250;
    const nodes = root.descendants().reverse();
    const links = root.links();

    // Compute the new tree layout.
    tree(root);

    let left = root;
    let right = root;
    root.eachBefore(node => {
      if (node.x < left.x) left = node;
      if (node.x > right.x) right = node;
    });

    const height = right.x - left.x + margin.top + margin.bottom +200;

    const transition = svg.transition()
        .duration(duration)
        .attr("viewBox", [-margin.left-50, left.x - margin.top-100, width, height])
        .tween("resize", window.ResizeObserver ? null : () => () => svg.dispatch("toggle"));
        
    // Update the nodes…
    const node = gNode.selectAll("g")
      .data(nodes, d => d.id);

    // Enter any new nodes at the parent's previous position.
    const nodeEnter = node.enter().append("g")
        .attr("transform", d => `translate(${source.y0},${source.x0})`)
        .attr("fill-opacity", 0)
        .attr("stroke-opacity", 0)
        .on("click", d => {
          d.children = d.children ? null : d._children;
          update(d);
        });

    nodeEnter.append("circle")
        .attr("r", 2.5)
        .attr("fill", d => d._children ? "#555" : "#999")
        .attr("stroke-width", 10);

    nodeEnter.append("text")
        .attr("dy", "0.31em")
        .attr("x", d => d._children ? -6 : 6)
        .attr("text-anchor", d => d._children ? "end" : "start")
        .text(d => d.data.name)
      .clone(true).lower()
        .attr("stroke-linejoin", "round")
        .attr("stroke-width", 3)
        .attr("stroke", "white");

    // Transition nodes to their new position.
    const nodeUpdate = node.merge(nodeEnter).transition(transition)
        .attr("transform", d => `translate(${d.y},${d.x})`)
        .attr("fill-opacity", 1)
        .attr("stroke-opacity", 1);

    // Transition exiting nodes to the parent's new position.
    const nodeExit = node.exit().transition(transition).remove()
        .attr("transform", d => `translate(${source.y},${source.x})`)
        .attr("fill-opacity", 0)
        .attr("stroke-opacity", 0);

    // Update the links…
    const link = gLink.selectAll("path")
      .data(links, d => d.target.id);

      
    // Enter any new links at the parent's previous position.
    const linkEnter = link.enter().append("path")
        .attr("d", d => {
          const o = {x: source.x0, y: source.y0};
          return diagonal({source: o, target: o});
        });

    // Transition links to their new position.
    link.merge(linkEnter).transition(transition)
        .attr("d", diagonal);

    // Transition exiting nodes to the parent's new position.
    link.exit().transition(transition).remove()
        .attr("d", d => {
          const o = {x: source.x, y: source.y};
          return diagonal({source: o, target: o});
        });

    // Stash the old positions for transition.
    root.eachBefore(d => {
      d.x0 = d.x;
      d.y0 = d.y;
    });
  }
  update(root);

  var node = document.createElement("h1");                 // Create a <li> node
  var textnode = document.createTextNode("WxMonitoring Files Tree"); // Create a text node

  var node1 = document.createElement("h3");
  var textnode1 = document.createTextNode("Click a black node to view/hide files monitored by WxMonitoring");
  node.appendChild(textnode); 
  node1.appendChild(textnode1);
  
  
  document.getElementById(id.substring(1)).appendChild(node); 
  document.getElementById(id.substring(1)).appendChild(node1);
  document.getElementById(id.substring(1)).style.textAlign="center";
  // element.style.backgroundColor = "red"; 
  // <h1 id="collapsible-tree">Collapsible Tree</h1>
  // <p>Click a black node to expand or collapse <a href="/@mbostock/d3-tidy-tree">the tree</a>.</p>

}