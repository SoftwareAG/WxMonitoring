function createNodalTree(id, data, nodalTreeWidth, nodalTreeheight)
{   
  
    var dx = 15;
    var width = nodalTreeWidth;
    var height = nodalTreeheight;
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
  var fontSizeMedium="1em";
  var fontSizeSmall="0.75em";
  var fontSizeSmaller=".65em";
  var fontSizeTiny="0.55em";
  root.descendants().forEach((d, i) => {
    d.id = i;
    d._children = d.children;
    if(d.data.name.length<7){
      //alert(d.data.name.length +" "+d.fontSize);
      d.fontSize = fontSizeMedium;
    }else if(d.data.name.length>7&&d.data.name.length<15){
      d.fontSize = fontSizeSmall;
    }else if(d.data.name.length>15&&d.data.name.length<25){
      //alert("hi");
      d.fontSize = fontSizeSmaller;
    }else{
      d.fontSize = fontSizeTiny;
    }
    if (d.id==0)
      { 
        d.fontSize = fontSizeMedium;
      }

    if (d.depth && d.data.name.length !== 7)
      { 
        d.children = null;
        d.fontSize = fontSizeSmall;
      }
      //alert(d.data.name + " " + d.data.name.length + " "+ d.fontSize);
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
        .attr("dy", ".31em")
        .attr("x", d => d._children ? -6 : 6)
        .attr("text-anchor", d => d._children ? "end" : "start")
        .attr("font-size",d => d.fontSize)
        .text(d => d.data.name)
      .clone(true).lower()
        .attr("stroke-linejoin", "round")
        .attr("stroke-width", 3)
        .attr("stroke", "white");
        
        nodeEnter.append("title")
        .text(d => d.data.name);

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


  svg.append("text")
      .text("WxMonitoring Files Tree")
      .attr("dy","25%")
      .attr("x","6")
      .attr("text-anchor", "start")
      .attr("font-size","1em");
  
      svg.append("text")
      .text("Click a black node to view/hide files monitored by WxMonitoring")
      .attr("dy","30%")
      .attr("x","-15")
      .attr("text-anchor", "start")
      .attr("font-size","0.5em");
}