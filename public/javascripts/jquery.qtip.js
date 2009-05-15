/*
 * jquery.qtip. The jQuery tooltip plugin
 *
 * Copyright (c) 2009 Craig Thompson
 * http://craigsworks.com
 *
 * Licensed under MIT
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Launch  : February 2009
 * Version : 1.0.0-rc2
 * Released: Monday 27th April, 2009 - 23:30
 * Debug: jquery.qtip.debug.js
 */
(function(f){f.fn.qtip=function(z,t){var x,s,y,r,w,v,u;if(!t){t=false}if(typeof z=="string"){if(z=="api"){if(typeof f(this).eq(0).data("qtip")=="object"){return f(this).eq(0).data("qtip")}else{f.fn.qtip.log.error.call(self,1,f.fn.qtip.constants.NO_TOOLTIP_PRESENT,false)}}}else{if(!z){z={}}if(typeof z.content!=="object"){z.content={text:z.content}}if(typeof z.content.title!=="object"){z.content.title={text:z.content.title}}if(typeof z.position!=="object"){z.position={corner:z.position}}if(typeof z.position.corner!=="object"){z.position.corner={target:z.position.corner,tooltip:z.position.corner}}if(typeof z.show!=="object"){z.show={when:z.show}}if(typeof z.show.when!=="object"){z.show.when={event:z.show.when}}if(typeof z.show.effect!=="object"){z.show.effect={type:z.show.effect}}if(typeof z.hide!=="object"){z.hide={when:z.hide}}if(typeof z.hide.when!=="object"){z.hide.when={event:z.hide.when}}if(typeof z.hide.effect!=="object"){z.hide.effect={type:z.hide.effect}}if(typeof z.style!=="object"){z.style={name:z.style}}z.style=c(z.style);r=f.extend(true,{},f.fn.qtip.defaults,z);r.style=a.call({options:r},r.style);r.user=f.extend(true,{},z)}return f(this).each(function(){if(typeof z=="string"){v=z.toLowerCase();y=f(this).data("interfaces");if(typeof y=="object"){if(t&&v=="destroy"){while(y.length>0){y[y.length-1].destroy()}}else{if(t===false){y=[y[y.length-1]]}for(x=0;x<y.length;x++){if(v=="destroy"){y[x].destroy()}else{if(y[x].status.rendered===true){if(v=="show"){y[x].show()}else{if(v=="hide"){y[x].hide()}else{if(v=="focus"){y[x].focus()}else{if(v=="disable"){y[x].disable(true)}else{if(v=="enable"){y[x].disable(false)}}}}}}}}}}}else{u=f.extend(true,{},r);u.hide.effect.length=r.hide.effect.length;u.show.effect.length=r.show.effect.length;if(u.position.container===false){u.position.container=f(document.body)}if(u.position.target===false){u.position.target=f(this)}if(u.show.when.target===false){u.show.when.target=f(this)}if(u.hide.when.target===false){u.hide.when.target=f(this)}s=f.fn.qtip.interfaces.length;for(x=0;x<s;x++){if(typeof f.fn.qtip.interfaces[x]=="undefined"){s=x;break}}w=new d(f(this),u,s);f.fn.qtip.interfaces[s]=w;f(this).data("qtip",w);if(f(this).data("interfaces")){f(this).data("interfaces").push(w)}else{f(this).data("interfaces",[w])}}})};function d(t,s,u){var r=this;r.id=u;r.options=s;r.status={rendered:false,disabled:false,focused:false};r.elements={target:t.addClass(r.options.style.classes.target),tooltip:null,wrapper:null,content:null,contentWrapper:null,title:null,tip:null,bgiframe:null};r.cache={mouse:{},position:{}};r.timers={};f.extend(r,r.options.api,{show:function(x){var w,y;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"show");return r}if(r.elements.tooltip.css("display")!=="none"){return r}r.elements.tooltip.stop(true,true);w=r.beforeShow.call(r,x);if(w===false){return r}function v(){if(r.options.position.type!=="static"){r.focus()}r.onShow.call(r,x);if(f.browser.msie){r.elements.tooltip.get(0).style.removeAttribute("filter")}}if(typeof r.options.show.when.target.data("qtip-toggle")=="number"){r.options.show.when.target.data("qtip-toggle",1)}if(r.options.position.type!=="static"){r.updatePosition(x,(r.options.show.effect.length>0))}if(typeof r.options.show.solo=="object"){y=f(r.options.show.solo)}else{if(r.options.show.solo===true){y=f("div.qtip").not(r.elements.tooltip)}}if(y){y.each(function(){if(f(this).qtip("api").status.rendered===true){f(this).qtip("api").hide()}})}if(typeof r.options.show.effect.type=="function"){r.options.show.effect.type.call(r.elements.tooltip,r.options.show.effect.length);r.elements.tooltip.queue(function(){v();f(this).dequeue()})}else{switch(r.options.show.effect.type.toLowerCase()){case"fade":r.elements.tooltip.fadeIn(r.options.show.effect.length,v);break;case"slide":r.elements.tooltip.slideDown(r.options.show.effect.length,function(){v();if(r.options.position.type!=="static"){r.updatePosition(x,true)}});break;case"grow":r.elements.tooltip.show(r.options.show.effect.length,v);break;default:r.elements.tooltip.show(null,v);break}r.elements.tooltip.addClass(r.options.style.classes.active)}r.onShow.call(r,x);f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_SHOWN,"show");return r},hide:function(x){var w;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"hide");return r}if(r.elements.tooltip.css("display")==="none"){return r}clearTimeout(r.timers.show);r.elements.tooltip.stop(true,true);w=r.beforeHide.call(r,x);if(w===false){return r}function v(){r.onHide.call(r,x)}if(typeof r.options.show.when.target.data("qtip-toggle")=="number"){r.options.show.when.target.data("qtip-toggle",0)}if(typeof r.options.hide.effect.type=="function"){r.options.hide.effect.type.call(r.elements.tooltip,r.options.hide.effect.length);r.elements.tooltip.queue(function(){v();f(this).dequeue()})}else{switch(r.options.hide.effect.type.toLowerCase()){case"fade":r.elements.tooltip.fadeOut(r.options.hide.effect.length,v);break;case"slide":r.elements.tooltip.slideUp(r.options.hide.effect.length,v);break;case"grow":r.elements.tooltip.hide(r.options.hide.effect.length,v);break;default:r.elements.tooltip.hide(null,v);break}r.elements.tooltip.removeClass(r.options.style.classes.active)}r.onHide.call(r,x);f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_HIDDEN,"hide");return r},updatePosition:function(v,w){var B,F,K,I,G,D,x,H,A,C,J,z,E,y;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"updatePosition");return r}else{if(r.options.position.type=="static"){f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.CANNOT_POSITION_STATIC,"updatePosition");return r}}F={position:{left:0,top:0},dimensions:{height:0,width:0},corner:r.options.position.corner.target};K={position:r.getPosition(),dimensions:r.getDimensions(),corner:r.options.position.corner.tooltip};if(r.options.position.target!=="mouse"){if(r.options.position.target.get(0).nodeName.toLowerCase()=="area"){I=r.options.position.target.attr("coords").split(",");for(B=0;B<I.length;B++){I[B]=parseInt(I[B])}G=r.options.position.target.parent("map").attr("name");D=f('img[usemap="#'+G+'"]:first').offset();F.position={left:Math.floor(D.left+I[0]),top:Math.floor(D.top+I[1])};switch(r.options.position.target.attr("shape").toLowerCase()){case"rect":F.dimensions={width:Math.floor(Math.abs(I[2]-I[0])),height:Math.floor(Math.abs(I[3]-I[1]))};break;case"circle":F.dimensions={width:I[2],height:I[2]};F.position.left+=I[2];F.position.top+=I[2];break;case"poly":F.dimensions={width:I[0],height:I[1]};for(B=0;B<I.length;B++){if(B%2==0){if(I[B]>F.dimensions.width){F.dimensions.width=I[B]}if(I[B]<I[0]){F.position.left=Math.floor(D.left+I[B])}}else{if(I[B]>F.dimensions.height){F.dimensions.height=I[B]}if(I[B]<I[1]){F.position.top=Math.floor(D.top+I[B])}}}F.dimensions.width=F.dimensions.width-(F.position.left-D.left);F.dimensions.height=F.dimensions.height-(F.position.top-D.top);break;default:f.fn.qtip.log.error.call(r,4,f.fn.qtip.constants.INVALID_AREA_SHAPE,"updatePosition");return r;break}F.dimensions.width-=2;F.dimensions.height-=2}else{if(r.options.position.target.add(document.body).length!==1){F.position=r.options.position.target.offset();F.dimensions={height:r.options.position.target.outerHeight(),width:r.options.position.target.outerWidth()}}else{F.position={left:f(document).scrollLeft(),top:f(document).scrollTop()};F.dimensions={height:f(window).height(),width:f(window).width()}}}x=f.extend({},F.position);if(F.corner.search(/right/i)!==-1){x.left+=F.dimensions.width}if(F.corner.search(/bottom/i)!==-1){x.top+=F.dimensions.height}if(F.corner.search(/((top|bottom)Middle)|center/)!==-1){x.left+=(F.dimensions.width/2)}if(F.corner.search(/((left|right)Middle)|center/)!==-1){x.top+=(F.dimensions.height/2)}}else{F.position=x={left:r.cache.mouse.x,top:r.cache.mouse.y};F.dimensions={height:1,width:1}}if(K.corner.search(/right/i)!==-1){x.left-=K.dimensions.width}if(K.corner.search(/bottom/i)!==-1){x.top-=K.dimensions.height}if(K.corner.search(/((top|bottom)Middle)|center/)!==-1){x.left-=(K.dimensions.width/2)}if(K.corner.search(/((left|right)Middle)|center/)!==-1){x.top-=(K.dimensions.height/2)}H=(f.browser.msie)?1:0;A=(f.browser.msie&&parseInt(f.browser.version.charAt(0))===6)?1:0;if(r.options.style.border.radius>0){if(K.corner.search(/Left/)!==-1){x.left-=r.options.style.border.radius}else{if(K.corner.search(/Right/)!==-1){x.left+=r.options.style.border.radius}}if(K.corner.search(/Top/)!==-1){x.top-=r.options.style.border.radius}else{if(K.corner.search(/Bottom/)!==-1){x.top+=r.options.style.border.radius}}}if(H){if(K.corner.search(/top/)!==-1){x.top-=H}else{if(K.corner.search(/bottom/)!==-1){x.top+=H}}if(K.corner.search(/left/)!==-1){x.left-=H}else{if(K.corner.search(/right/)!==-1){x.left+=H}}if(K.corner.search(/leftMiddle|rightMiddle/)!==-1){x.top-=1}}if(r.options.position.adjust.screen===true){x=n.call(r,x,F,K)}if(r.options.position.target==="mouse"&&r.options.position.adjust.mouse===true){if(r.options.position.adjust.screen===true&&r.elements.tip){J=r.elements.tip.attr("rel")}else{J=r.options.position.corner.tooltip}x.left+=(J.search(/right/i)!==-1)?-6:6;x.top+=(J.search(/bottom/i)!==-1)?-6:6}if(!r.elements.bgiframe&&f.browser.msie&&parseInt(f.browser.version.charAt(0))==6){f("select, object").each(function(){z=f(this).offset();z.bottom=z.top+f(this).height();z.right=z.left+f(this).width();if(x.top+K.dimensions.height>=z.top&&x.left+K.dimensions.width>=z.left){j.call(r)}})}x.left+=r.options.position.adjust.x;x.top+=r.options.position.adjust.y;E=r.getPosition();if(x.left!=E.left||x.top!=E.top){y=r.beforePositionUpdate.call(r,v);if(y===false){return r}if(w===true){r.elements.tooltip.animate(x,200,"swing")}else{r.elements.tooltip.css(x)}r.onPositionUpdate.call(r,v);if(typeof v!=="undefined"&&v.type&&v.type!=="mousemove"){f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_POSITION_UPDATED,"updatePosition")}}return r},updateWidth:function(v){if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"updateWidth");return r}if(v&&typeof v!=="number"){f.fn.qtip.log.error.call(r,2,"newWidth must be of type number","updateWidth");return r}if(!v){if(typeof r.options.style.width.value=="number"){v=r.options.style.width.value}else{r.elements.tooltip.css({width:"auto"});r.elements.contentWrapper.siblings().add(r.elements.tip).hide();if(f.browser.msie){r.elements.wrapper.add(r.elements.contentWrapper.children()).css({zoom:"normal"})}v=r.getDimensions().width+1;if(!r.options.style.width.value){if(v>r.options.style.width.max){v=r.options.style.width.max}if(v<r.options.style.width.min){v=r.options.style.width.min}}}}if(v%2!==0){v-=1}r.elements.tooltip.width(v);r.elements.contentWrapper.siblings().add(r.elements.tip).show();if(r.options.style.border.radius){r.elements.tooltip.find(".qtip-betweenCorners").each(function(w){f(this).width(v-(r.options.style.border.radius*2))})}if(f.browser.msie){r.elements.wrapper.add(r.elements.contentWrapper.children()).css({zoom:"1"});r.elements.wrapper.width(v);if(r.elements.bgiframe){r.elements.bgiframe.width(v).height(r.getDimensions.height)}}f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_WIDTH_UPDATED,"updateWidth");return r},updateStyle:function(v){var y,z,w,x,A;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"updateStyle");return r}if(typeof v!=="string"||!f.fn.qtip.styles[v]){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.STYLE_NOT_DEFINED,"updateStyle");return r}r.options.style=a.call(r,f.fn.qtip.styles[v],r.options.user.style);r.elements.content.css(p(r.options.style));if(r.options.content.title.text!==false){r.elements.title.css(p(r.options.style.title,true))}r.elements.contentWrapper.css({borderColor:r.options.style.border.color});if(r.options.style.tip.corner!==false){if(f("<canvas>").get(0).getContext){y=r.elements.tooltip.find(".qtip-tip canvas:first");w=y.get(0).getContext("2d");w.clearRect(0,0,300,300);x=y.parent("div[rel]:first").attr("rel");A=b(x,r.options.style.tip.size.width,r.options.style.tip.size.height);h.call(r,y,A,r.options.style.tip.color||r.options.style.border.color)}else{if(f.browser.msie){y=r.elements.tooltip.find('.qtip-tip [nodeName="shape"]');y.attr("fillcolor",r.options.style.tip.color||r.options.style.border.color)}}}if(r.options.style.border.radius>0){r.elements.tooltip.find(".qtip-betweenCorners").css({backgroundColor:r.options.style.border.color});if(f("<canvas>").get(0).getContext){z=g(r.options.style.border.radius);r.elements.tooltip.find(".qtip-wrapper canvas").each(function(){w=f(this).get(0).getContext("2d");w.clearRect(0,0,300,300);x=f(this).parent("div[rel]:first").attr("rel");q.call(r,f(this),z[x],r.options.style.border.radius,r.options.style.border.color)})}else{if(f.browser.msie){r.elements.tooltip.find('.qtip-wrapper [nodeName="arc"]').each(function(){f(this).attr("fillcolor",r.options.style.border.color)})}}}f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_STYLE_UPDATED,"updateStyle");return r},updateContent:function(z,x){var y,w,v;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"updateContent");return r}else{if(!z){f.fn.qtip.log.error.call(r,2,"You must specify some content with which to update","updateContent");return false}}y=r.beforeContentUpdate.call(r,z);if(typeof y=="string"){z=y}else{if(y===false){return}}if(f.browser.msie){r.elements.contentWrapper.children().css({zoom:"normal"})}if(z.jquery&&z.length>0){z.clone(true).appendTo(r.elements.content)}else{r.elements.content.html(z)}w=r.elements.content.find("img[complete=false]");if(w.length>0){v=0;w.each(function(B){f('<img src="'+f(this).attr("src")+'" />').load(function(){if(++v==w.length){A()}})})}else{A()}function A(){r.updateWidth();if(x!==false){if(r.options.position.type!=="static"){r.updatePosition(r.elements.tooltip.is(":visible"),true)}if(r.options.style.tip.corner!==false){m.call(r)}}}r.onContentUpdate.call(r);f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_CONTENT_UPDATED,"loadContent");return r},loadContent:function(v,y,z){var x;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"loadContent");return r}x=r.beforeContentLoad.call(r);if(x===false){return r}if(z=="post"){f.post(v,y,w)}else{f.get(v,y,w)}function w(A){r.onContentLoad.call(r);f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_CONTENT_LOADED,"loadContent");r.updateContent(A)}return r},focus:function(y){var w,v,x;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"focus");return r}else{if(r.options.position.type=="static"){f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.CANNOT_FOCUS_STATIC,"focus");return r}}w=parseInt(r.elements.tooltip.css("z-index"));v=6000+f(".qtip").length-1;if(!r.status.focussed&&w!==v){x=r.beforeFocus.call(r,y);if(x===false){return r}f(".qtip").not(r.elements.tooltip).each(function(){if(f(this).qtip("api").status.rendered===true){if(typeof parseInt(f(this).css("z-index"))=="number"){f(this).css({zIndex:parseInt(f(this).css("z-index"))-1})}f(this).qtip("api").status.focused=false}});r.elements.tooltip.css({zIndex:v});r.status.focused=true;r.onFocus.call(r,y);f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_FOCUSED,"focus")}return r},disable:function(v){if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"disable");return r}if(v){if(!r.status.disabled){r.status.disabled=true;f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_DISABLED,"disable")}else{f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.TOOLTIP_ALREADY_DISABLED,"disable")}}else{if(r.status.disabled){r.status.disabled=false;f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_ENABLED,"disable")}else{f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.TOOLTIP_ALREADY_ENABLED,"disable")}}return r},destroy:function(){var v,w,x;w=r.beforeDestroy.call(r);if(w===false){return r}if(r.status.rendered){r.options.show.when.target.unbind("mousemove.qtip",r.updatePosition);r.options.show.when.target.unbind("mouseout.qtip",r.hide);r.options.show.when.target.unbind(r.options.show.when.event+".qtip");r.options.show.when.target.removeData("qtip-toggle");r.options.hide.when.target.unbind(r.options.hide.when.event+".qtip");r.elements.tooltip.unbind(r.options.hide.when.event+".qtip");r.elements.tooltip.unbind("mouseover.qtip",r.focus);r.elements.tooltip.remove()}else{r.options.show.when.target.unbind(r.options.show.when.event+".qtip-create")}x=r.elements.target.data("interfaces");if(typeof x=="object"&&x.length>0){for(v=0;v<x.length-1;v++){if(x[v].id==r.id){x.splice(v,1)}}}delete f.fn.qtip.interfaces[r.id];if(typeof x=="object"&&x.length>0){r.elements.target.data("qtip",x[x.length-1])}else{r.elements.target.removeData("qtip")}r.onDestroy.call(r);f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_DESTROYED,"destroy");return r.elements.target},getPosition:function(){var v,w;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"getPosition");return r}v=(r.elements.tooltip.css("display")!=="none")?false:true;if(v){r.elements.tooltip.css({visiblity:"hidden"}).show()}w=r.elements.tooltip.offset();if(v){r.elements.tooltip.css({visiblity:"visible"}).hide()}return w},getDimensions:function(){var v,w;if(!r.status.rendered){f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.TOOLTIP_NOT_RENDERED,"getDimensions");return r}v=(!r.elements.tooltip.is(":visible"))?true:false;if(v){r.elements.tooltip.css({visiblity:"hidden"}).show()}w={height:r.elements.tooltip.outerHeight(),width:r.elements.tooltip.outerWidth()};if(v){r.elements.tooltip.css({visiblity:"visible"}).hide()}return w}});o.call(r)}function o(){var r,u,s;r=this;if(r.options.content.prerender===false&&r.options.show.when.event!==false&&r.options.show.ready!==true){u=r.options.show.when.target;s=r.options.show.when.event;u.bind(s+".qtip-create",function(v){u.unbind(s+".qtip-create");t();r.cache.mouse={x:v.pageX,y:v.pageY};u.trigger(s)})}else{t()}function t(){var y,w,v,x,A,z;r.status.rendered=true;r.beforeRender.call(r);r.elements.tooltip='<div qtip="'+r.id+'" class="qtip '+(r.options.style.classes.tooltip||r.options.style)+'"style="display:none; -moz-border-radius:0; -webkit-border-radius:0; border-radius:0;position:'+r.options.position.type+';">  <div class="qtip-wrapper" style="position:relative; overflow:hidden; text-align:left;">    <div class="qtip-contentWrapper" style="overflow:hidden;">       <div class="qtip-content '+r.options.style.classes.content+'"></div></div></div></div>';r.elements.tooltip=f(r.elements.tooltip);r.elements.tooltip.appendTo(r.options.position.container).data("qtip",r);r.elements.wrapper=r.elements.tooltip.children("div:first").css({zoom:(f.browser.msie)?1:0});r.elements.contentWrapper=r.elements.wrapper.children("div:first").css({background:r.options.style.background});r.elements.content=r.elements.contentWrapper.children("div:first").css(p(r.options.style)).css({zoom:(f.browser.msie)?1:0});if(typeof r.options.style.width.value=="number"){r.updateWidth()}if(f("<canvas>").get(0).getContext||f.browser.msie){if(r.options.style.border.radius>0){l.call(r)}else{r.elements.contentWrapper.css({border:r.options.style.border.width+"px solid "+r.options.style.border.color})}if(r.options.style.tip.corner!==false){e.call(r)}}else{r.elements.contentWrapper.css({border:r.options.style.border.width+"px solid "+r.options.style.border.color});r.options.style.border.radius=0;r.options.style.tip.corner=false;f.fn.qtip.log.error.call(r,2,f.fn.qtip.constants.CANVAS_VML_NOT_SUPPORTED,"render")}if(typeof r.options.content.text=="string"){w=r.options.content.text}else{if(r.options.content.text.jquery&&r.options.content.text.length>0){w=r.options.content.text}else{if(r.options.content.text===false){w=r.elements.target.attr("title").replace("\\n","<br />");r.elements.target.attr("title","")}else{w="&nbsp;";f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.NO_VALID_CONTENT,"render")}}}if(r.options.content.title.text!==false){i.call(r)}r.updateContent(w);if(r.options.content.url!==false){v=r.options.content.url;x=r.options.content.data;A=r.options.content.method||"get";r.loadContent(v,x,A)}k.call(r);if(r.options.show.ready===true){r.show()}r.onRender.call(r);f.fn.qtip.log.error.call(r,1,f.fn.qtip.constants.EVENT_RENDERED,"render")}}function l(){var E,y,s,A,w,D,t,F,C,x,v,B,z,r,u;E=this;E.elements.wrapper.find(".qtip-borderBottom, .qtip-borderTop").remove();s=E.options.style.border.width;A=E.options.style.border.radius;w=E.options.style.border.color||E.options.style.tip.color;D=g(A);t={};for(y in D){t[y]='<div rel="'+y+'" style="'+((y.search(/Left/)!==-1)?"left":"right")+":0; position:absolute; height:"+A+"px; width:"+A+'px; overflow:hidden; line-height:0.1px; font-size:1px">';if(f("<canvas>").get(0).getContext){t[y]+='<canvas height="'+A+'" width="'+A+'" style="vertical-align: top"></canvas>'}else{if(f.browser.msie){F=A*2+3;t[y]+='<v:arc stroked="false" fillcolor="'+w+'" startangle="'+D[y][0]+'" endangle="'+D[y][1]+'" style="width:'+F+"px; height:"+F+"px; margin-top:"+((y.search(/bottom/)!==-1)?-2:-1)+"px; margin-left:"+((y.search(/Right/)!==-1)?D[y][2]-3.5:-1)+'px; vertical-align:top; display:inline-block; behavior:url(#default#VML)"></v:arc>'}}t[y]+="</div>"}C=E.getDimensions().width-(Math.max(s,A)*2);x='<div class="qtip-betweenCorners" style="height:'+A+"px; width:"+C+"px; overflow:hidden; background-color:"+w+'; line-height:0.1px; font-size:1px;">';v='<div class="qtip-borderTop" dir="ltr" style="height:'+A+"px; margin-left:"+A+'px; line-height:0.1px; font-size:1px; padding:0;">'+t.topLeft+t.topRight+x;E.elements.wrapper.prepend(v);B='<div class="qtip-borderBottom" dir="ltr" style="height:'+A+"px; margin-left:"+A+'px; line-height:0.1px; font-size:1px; padding:0;">'+t.bottomLeft+t.bottomRight+x;E.elements.wrapper.append(B);if(f("<canvas>").get(0).getContext){E.elements.wrapper.find("canvas").each(function(){z=D[f(this).parent("[rel]:first").attr("rel")];q.call(E,f(this),z,A,w)})}else{if(f.browser.msie){E.elements.tooltip.append('<v:image style="behavior:url(#default#VML);"></v:image>')}}r=Math.max(A,(A+(s-A)));u=Math.max(s-A,0);E.elements.contentWrapper.css({border:"0px solid "+w,borderWidth:u+"px "+r+"px"})}function q(t,v,r,s){var u=t.get(0).getContext("2d");u.fillStyle=s;u.beginPath();u.arc(v[0],v[1],r,0,Math.PI*2,false);u.fill()}function e(u){var s,r,w,t,v;s=this;if(s.elements.tip!==null){s.elements.tip.remove()}r=s.options.style.tip.color||s.options.style.border.color;if(s.options.style.tip.corner===false){return}else{if(!u){u=s.options.style.tip.corner}}w=b(u,s.options.style.tip.size.width,s.options.style.tip.size.height);s.elements.tip='<div class="'+s.options.style.classes.tip+'" dir="ltr" rel="'+u+'" style="position:absolute; height:'+s.options.style.tip.size.height+"px; width:"+s.options.style.tip.size.width+'px; margin:0 auto; line-height:0.1px; font-size:1px;">';if(f("<canvas>").get(0).getContext){s.elements.tip+='<canvas height="'+s.options.style.tip.size.height+'" width="'+s.options.style.tip.size.width+'"></canvas>'}else{if(f.browser.msie){t=s.options.style.tip.size.width+","+s.options.style.tip.size.height;v="m"+w[0][0]+","+w[0][1];v+=" l"+w[1][0]+","+w[1][1];v+=" "+w[2][0]+","+w[2][1];v+=" xe";s.elements.tip+='<v:shape fillcolor="'+r+'" stroked="false" filled="true" path="'+v+'" coordsize="'+t+'" style="width:'+s.options.style.tip.size.width+"px; height:"+s.options.style.tip.size.height+"px; line-height:0.1px; display:inline-block; behavior:url(#default#VML); vertical-align:"+((u.search(/top/)!==-1)?"bottom":"top")+'"></v:shape>';s.elements.tip+='<v:image style="behavior:url(#default#VML);"></v:image>';s.elements.contentWrapper.css("position","relative")}}s.elements.tooltip.prepend(s.elements.tip+"</div>");s.elements.tip=s.elements.tooltip.find("."+s.options.style.classes.tip).eq(0);if(f("<canvas>").get(0).getContext){h.call(s,s.elements.tip.find("canvas:first"),w,r)}if(u.search(/top/)!==-1&&f.browser.msie&&parseInt(f.browser.version.charAt(0))===6){s.elements.tip.css({marginTop:-4})}m.call(s,u)}function h(s,u,r){var t=s.get(0).getContext("2d");t.fillStyle=r;t.beginPath();t.moveTo(u[0][0],u[0][1]);t.lineTo(u[1][0],u[1][1]);t.lineTo(u[2][0],u[2][1]);t.fill()}function m(u){var s,w,r,x,t,v;s=this;if(s.options.style.tip.corner===false||!s.elements.tip){return}if(!u){u=s.elements.tip.attr("rel")}w=positionAdjust=(f.browser.msie)?1:0;s.elements.tip.css(u.match(/left|right|top|bottom/)[0],0);if(u.search(/top|bottom/)!==-1){if(f.browser.msie){if(parseInt(f.browser.version.charAt(0))===6){positionAdjust=(u.search(/top/)!==-1)?-3:1}else{positionAdjust=(u.search(/top/)!==-1)?1:2}}if(u.search(/Middle/)!==-1){s.elements.tip.css({left:"50%",marginLeft:-(s.options.style.tip.size.width/2)})}else{if(u.search(/Left/)!==-1){s.elements.tip.css({left:s.options.style.border.radius-w})}else{if(u.search(/Right/)!==-1){s.elements.tip.css({right:s.options.style.border.radius+w})}}}if(u.search(/top/)!==-1){s.elements.tip.css({top:-positionAdjust})}else{s.elements.tip.css({bottom:positionAdjust})}}else{if(u.search(/left|right/)!==-1){if(f.browser.msie){positionAdjust=(parseInt(f.browser.version.charAt(0))===6)?1:((u.search(/left/)!==-1)?1:2)}if(u.search(/Middle/)!==-1){s.elements.tip.css({top:"50%",marginTop:-(s.options.style.tip.size.height/2)})}else{if(u.search(/Top/)!==-1){s.elements.tip.css({top:s.options.style.border.radius-w})}else{if(u.search(/Bottom/)!==-1){s.elements.tip.css({bottom:s.options.style.border.radius+w})}}}if(u.search(/left/)!==-1){s.elements.tip.css({left:-positionAdjust})}else{s.elements.tip.css({right:positionAdjust})}}}r="padding-"+u.match(/left|right|top|bottom/)[0];x=s.options.style.tip.size[(r.search(/left|right/)!==-1)?"width":"height"];s.elements.tooltip.css("padding",0);s.elements.tooltip.css(r,x);if(f.browser.msie&&parseInt(f.browser.version.charAt(0))==6){t=parseInt(s.elements.tip.css("margin-top"));v=t+parseInt(s.elements.content.css("margin-top"));s.elements.tip.css({marginTop:v})}}function i(){var r=this;if(r.elements.title!==null){r.elements.title.remove()}r.elements.title=f("<div>").addClass(r.options.style.classes.title).css(p(r.options.style.title,true)).css({zoom:(f.browser.msie)?1:0}).html(r.options.content.title.text).prependTo(r.elements.contentWrapper);if(r.options.content.title.button!==false&&typeof r.options.content.title.button=="string"){f('<a href="#" style="float:right; position:relative;">').attr("href","#").addClass(r.options.style.classes.button).html(r.options.content.title.button).prependTo(r.elements.title).click(function(){if(!r.status.disabled){r.hide()}})}}function k(){var s,u,t,r;s=this;u=s.options.show.when.target;t=s.options.hide.when.target;if(s.options.hide.fixed){t=t.add(s.elements.tooltip)}if(s.options.hide.when.event=="inactive"){r=["click","dblclick","mousedown","mouseup","mousemove","mouseout","mouseenter","mouseleave","mouseover"];function x(){if(s.status.disabled===true){return}clearTimeout(s.timers.inactive);s.timers.inactive=setTimeout(function(){f(r).each(function(){t.unbind(this+".qtip-inactive");s.elements.content.unbind(this+".qtip-inactive")});s.hide()},s.options.hide.delay)}}else{if(s.options.hide.fixed===true){s.elements.tooltip.bind("mouseover.qtip",function(){if(s.status.disabled===true){return}clearTimeout(s.timers.hide)})}}function w(y){if(s.status.disabled===true){return}if(s.options.hide.when.event=="inactive"){f(r).each(function(){t.bind(this+".qtip-inactive",x);s.elements.content.bind(this+".qtip-inactive",x)});x()}clearTimeout(s.timers.show);clearTimeout(s.timers.hide);s.timers.show=setTimeout(function(){s.show(y)},s.options.show.delay)}function v(y){if(s.status.disabled===true){return}if(s.options.hide.fixed===true&&s.options.hide.when.event.search(/mouse(out|leave)/i)!==-1&&f(y.relatedTarget).parents(".qtip").length>0){y.stopPropagation();y.preventDefault();clearTimeout(s.timers.hide);return false}clearTimeout(s.timers.show);clearTimeout(s.timers.hide);s.timers.hide=setTimeout(function(){s.hide(y)},s.options.hide.delay)}if((s.options.show.when.target.add(s.options.hide.when.target).length===1&&s.options.show.when.event==s.options.hide.when.event&&s.options.hide.when.event!=="inactive")||s.options.hide.when.event=="unfocus"){u.data("qtip-toggle",0);if(s.options.hide.when.event=="unfocus"){s.elements.tooltip.attr("unfocus",true)}u.bind(s.options.show.when.event+".qtip",function(y){if(parseInt(f(this).data("qtip-toggle"))===0){w(y)}else{v(y)}})}else{u.bind(s.options.show.when.event+".qtip",w);if(s.options.hide.when.event!=="inactive"){t.bind(s.options.hide.when.event+".qtip",v)}}if(s.options.position.type.search(/(fixed|absolute)/)!==-1){s.elements.tooltip.bind("mouseover.qtip",s.focus)}if(s.options.position.target==="mouse"&&s.options.position.type!=="static"){u.bind("mousemove.qtip",function(y){s.cache.mouse={x:y.pageX,y:y.pageY};if(s.status.disabled===false&&s.options.position.adjust.mouse===true&&s.options.position.type!=="static"&&s.elements.tooltip.css("display")!=="none"){s.updatePosition(y)}})}}function n(r,w,v){var s,y,u,x,t;s=this;if(v.corner=="center"){return w.position}y=f.extend({},r);u={x:false,y:false};x={left:(y.left<f.fn.qtip.cache.screen.scroll.left),right:(y.left+v.dimensions.width+2>=f.fn.qtip.cache.screen.width+f.fn.qtip.cache.screen.scroll.left),top:(y.top<f.fn.qtip.cache.screen.scroll.top),bottom:(y.top+v.dimensions.height+2>=f.fn.qtip.cache.screen.height+f.fn.qtip.cache.screen.scroll.top)};s.cache.position.adjust={left:(x.left&&(v.corner.search(/right/i)!=-1||(v.corner.search(/right/i)==-1&&!x.right))),right:(x.right&&(v.corner.search(/left/i)!=-1||(v.corner.search(/left/i)==-1&&!x.left))),top:(x.top&&v.corner.search(/top/i)==-1),bottom:(x.bottom&&v.corner.search(/bottom/i)==-1)};if(s.cache.position.adjust.left){if(s.options.position.target!=="mouse"){y.left=w.position.left+w.dimensions.width}else{y.left=s.cache.mouse.x}u.x="Left"}else{if(s.cache.position.adjust.right){if(s.options.position.target!=="mouse"){y.left=w.position.left-v.dimensions.width}else{y.left=s.cache.mouse.x-v.dimensions.width}u.x="Right"}}if(s.cache.position.adjust.top){if(s.options.position.target!=="mouse"){y.top=w.position.top+w.dimensions.height}else{y.top=s.cache.mouse.y}u.y="top"}else{if(s.cache.position.adjust.bottom){if(s.options.position.target!=="mouse"){y.top=w.position.top-v.dimensions.height}else{y.top=s.cache.mouse.y-v.dimensions.height}u.y="bottom"}}if(y.left<0){y.left=r.left;u.x=false}if(y.top<0){y.top=r.top;u.y=false}if(s.options.style.tip.corner!==false){y.corner=new String(v.corner);if(u.x!==false){y.corner=y.corner.replace(/Left|Right|Middle/,u.x)}if(u.y!==false){y.corner=y.corner.replace(/top|bottom/,u.y)}if(y.corner!==s.elements.tip.attr("rel")){e.call(s,y.corner)}}return y}function p(s,u){var t,r;t=f.extend(true,{},s);for(r in t){if(u===true&&r.search(/(tip|classes)/i)!==-1){delete t[r]}else{if(r.search(/(width|border|tip|title|classes|user)/i)!==-1){delete t[r]}}}return t}function c(r){if(typeof r.tip!=="object"){r.tip={corner:r.tip}}if(typeof r.tip.size!=="object"){r.tip.size={width:r.tip.size,height:r.tip.size}}if(typeof r.border!=="object"){r.border={width:r.border}}if(typeof r.width!=="object"){r.width={value:r.width}}if(typeof r.width.max=="string"){r.width.max=parseInt(r.width.max.replace(/([0-9]+)/i,"$1"))}if(typeof r.width.min=="string"){r.width.min=parseInt(r.width.min.replace(/([0-9]+)/i,"$1"))}if(typeof r.tip.size.x=="number"){r.tip.size.width=r.tip.size.x;delete r.tip.size.x}if(typeof r.tip.size.y=="number"){r.tip.size.height=r.tip.size.y;delete r.tip.size.y}return r}function a(){var r,s,t,w,u,v;r=this;t=[true,{}];for(s=0;s<arguments.length;s++){t.push(arguments[s])}w=[f.extend.apply(f,t)];while(typeof w[0].name=="string"){w.unshift(c(f.fn.qtip.styles[w[0].name]))}w.unshift(true,{classes:{tooltip:"qtip-"+(arguments[0].name||"defaults")}},f.fn.qtip.styles.defaults);u=f.extend.apply(f,w);v=(f.browser.msie)?1:0;u.tip.size.width+=v;u.tip.size.height+=v;if(u.tip.size.width%2>0){u.tip.size.width+=1}if(u.tip.size.height%2>0){u.tip.size.height+=1}if(u.tip.corner===true){u.tip.corner=(r.options.position.corner.tooltip==="center")?false:r.options.position.corner.tooltip}return u}function b(u,t,s){var r={bottomRight:[[0,0],[t,s],[t,0]],bottomLeft:[[0,0],[t,0],[0,s]],topRight:[[0,s],[t,0],[t,s]],topLeft:[[0,0],[0,s],[t,s]],topMiddle:[[0,s],[t/2,0],[t,s]],bottomMiddle:[[0,0],[t,0],[t/2,s]],rightMiddle:[[0,0],[t,s/2],[0,s]],leftMiddle:[[t,0],[t,s],[0,s/2]]};r.leftTop=r.bottomRight;r.rightTop=r.bottomLeft;r.leftBottom=r.topRight;r.rightBottom=r.topLeft;return r[u]}function g(r){var s;if(f("<canvas>").get(0).getContext){s={topLeft:[r,r],topRight:[0,r],bottomLeft:[r,0],bottomRight:[0,0]}}else{if(f.browser.msie){s={topLeft:[-90,90,0],topRight:[-90,90,-r],bottomLeft:[90,270,0],bottomRight:[90,270,-r]}}}return s}function j(){var r,s,t;r=this;t=r.getDimensions();s='<iframe class="qtip-bgiframe" frameborder="0" tabindex="-1" src="javascript:false" style="display:block; position:absolute; z-index:-1; filter:alpha(opacity=\'0\'); border: 1px solid red; height:'+t.height+"px; width:"+t.width+'px" />';r.elements.bgiframe=r.elements.wrapper.prepend(s).children(".qtip-bgiframe:first")}f(document).ready(function(){f.fn.qtip.cache={screen:{scroll:{left:f(window).scrollLeft(),top:f(window).scrollTop()},width:f(window).width(),height:f(window).height()}};var r;f(window).bind("resize scroll",function(s){clearTimeout(r);r=setTimeout(function(){if(s.type==="scroll"){f.fn.qtip.cache.screen.scroll={left:f(window).scrollLeft(),top:f(window).scrollTop()}}else{f.fn.qtip.cache.screen.width=f(window).width();f.fn.qtip.cache.screen.height=f(window).height()}f(".qtip").each(function(){var t=f(this).qtip("api");if(t.options.position.type!=="static"||t.options.position.adjust.scroll&&s.type==="scroll"||t.options.position.adjust.resize&&s.type==="resize"){t.updatePosition(s,true)}})},100)});f(document).bind("mousedown.qtip",function(s){if(f(s.target).parents("div.qtip").length===0){f(".qtip[unfocus]").each(function(){var t=f(this).qtip("api");if(f(this).is(":visible")&&!t.status.disabled&&f(s.target).add(t.elements.target).length>1){t.hide()}})}})});f.fn.qtip.interfaces=[];f.fn.qtip.log={error:function(){}};f.fn.qtip.constants={};f.fn.qtip.defaults={content:{prerender:false,text:false,url:false,data:null,title:{text:false,button:false}},position:{target:false,corner:{target:"bottomRight",tooltip:"topLeft"},adjust:{x:0,y:0,mouse:true,screen:false,scroll:true,resize:true},type:"absolute",container:false},show:{when:{target:false,event:"mouseover"},effect:{type:"fade",length:100},delay:140,solo:false,ready:false},hide:{when:{target:false,event:"mouseout"},effect:{type:"fade",length:100},delay:0,fixed:false},api:{beforeRender:function(){},onRender:function(){},beforePositionUpdate:function(){},onPositionUpdate:function(){},beforeShow:function(){},onShow:function(){},beforeHide:function(){},onHide:function(){},beforeContentUpdate:function(){},onContentUpdate:function(){},beforeContentLoad:function(){},onContentLoad:function(){},beforeDestroy:function(){},onDestroy:function(){},beforeFocus:function(){},onFocus:function(){}}};f.fn.qtip.styles={defaults:{background:"white",color:"#111",overflow:"hidden",textAlign:"left",width:{min:0,max:250},padding:"5px 9px",border:{width:1,radius:0,color:"#d3d3d3"},tip:{corner:false,color:false,size:{width:13,height:13},opacity:1},title:{background:"#e1e1e1",fontWeight:"bold",padding:"7px 12px"},classes:{target:"",tip:"qtip-tip",title:"qtip-title",content:"qtip-content",active:"qtip-active"}},cream:{border:{width:3,radius:0,color:"#F9E98E"},title:{background:"#F0DE7D",color:"#A27D35"},background:"#FBF7AA",color:"#A27D35",classes:{tooltip:"qtip-cream"}},light:{border:{width:3,radius:0,color:"#E2E2E2"},title:{background:"#f1f1f1",color:"#454545"},background:"white",color:"#454545",classes:{tooltip:"qtip-light"}},dark:{border:{width:3,radius:0,color:"#303030"},title:{background:"#404040",color:"#f3f3f3"},background:"#505050",color:"#f3f3f3",classes:{tooltip:"qtip-dark"}},red:{border:{width:3,radius:0,color:"#CE6F6F"},title:{background:"#f28279",color:"#9C2F2F"},background:"#F79992",color:"#9C2F2F",classes:{tooltip:"qtip-red"}},green:{border:{width:3,radius:0,color:"#A9DB66"},title:{background:"#b9db8c",color:"#58792E"},background:"#CDE6AC",color:"#58792E",classes:{tooltip:"qtip-green"}},blue:{border:{width:3,radius:0,color:"#ADD9ED"},title:{background:"#D0E9F5",color:"#5E99BD"},background:"#E5F6FE",color:"#4D9FBF",classes:{tooltip:"qtip-blue"}}}})(jQuery);
