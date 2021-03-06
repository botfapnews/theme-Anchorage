{{ if $gimme->article->content_accessible }} 
	<h1 class="page-title">
        {{ $gimme->article->name }}
        {{ if !$gimme->article->is_public }}
        <span class="label label-important"><i class="icon-lock"></i>&nbsp;{{ #premium# }}</span>
        {{ /if }} 
    </h1>

	{{ foreach $gimme->article->slideshows as $slideshow }}
	{{ if $gimme->article->type_name == "news" }}
 	<div class="well well-article">
			<div class="article-info">
		    	<i class="icon-time"></i> <b>{{#published#}}</b> <time datetime="{{$gimme->article->publish_date|date_format:"%Y-%m-%dT%H:%MZ"}}">{{ $gimme->article->publish_date|camp_date_format:"%d %M %Y" }}</time> 
		   		 By {{ list_article_authors }} 
		   		 		{{ if $gimme->author->user->defined}}
		   		 			<a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}" class="link-color">
		   		 		{{/if}}
		   		 			{{ $gimme->author->name }}
		   		 			{{if $gimme->author->user->defined }}
		   		 			</a>
		   		 			{{/if}} 
		   		 			({{ $gimme->author->type|lower }}) 
		   		 			{{ if !$gimme->current_list->at_end }}, {{/if}}
		   		 			{{/list_article_authors}}
			</div>
		{{ if $gimme->article->has_map }}
			<div class="article-info">
				<i class="icon-map-marker"></i> <b>{{ #locations# }}:</b> {{ list_article_locations }}{{ if $gimme->location->enabled }}{{ $gimme->location->name }}{{ if $gimme->current_list->at_end }}{{ else }}, {{ /if }}{{ /if }}{{ /list_article_locations }}
			</div> 
		{{/if}}
		<div class="article-info">
		 		{{ list_article_topics }}
		 		{{ if $gimme->current_list->at_beginning }}
			 	<i class="icon-tag"></i> <b>{{ #topics# }}:</b> {{ /if }}<a class="link-color" href="{{ url options="template topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if $gimme->current_list->at_end }}{{ else }}, {{ /if }}{{ /list_article_topics }}
		</div>
	</div>
	{{/if}}
    <div id="gallery">
        {{ assign var="style" value='true' }}
		{{ assign var="counter" value=0 }}              
		{{ foreach $slideshow->items as $item }}      
			{{ assign var="counter" value=$counter+1 }}
            <a href="http://{{ $gimme->publication->site }}/{{ $item->image->original }}"><img src="{{ $item->image->src }}" data-title="{{if $item->caption}}{{ $item->caption }}{{else}}&nbsp;{{/if}}" data-big="http://{{ $gimme->publication->site }}/{{ $item->image->original }}" /></a>
		{{ /foreach }}
    </div>
  	<!-- Gallery vendor plugin -->
  	<script>
   		Galleria.loadTheme('{{ url static_file='_js/vendor/galleria/themes/classic/galleria.classic.min.js'}}');
    	Galleria.run('#gallery');
		Galleria.configure({
		    imageCrop: true
		});
  	</script>

	{{foreachelse}}

	{{ if $gimme->article->type_name == "news" }}
	<figure class="image">
	    {{ include file="_tpl/img/img_325x190.tpl" }}
	    <figcaption>{{ if $image->caption }}{{ $image->caption }}{{else}}&nbsp;{{/if}}</figcaption>
	</figure>
	{{/if}}

	{{ if $gimme->article->type_name == "news" }}
 	<div class="well well-article">
			<div class="article-info">
		    	<i class="icon-time"></i> <b>{{#published#}}</b> <br><time datetime="{{$gimme->article->publish_date|date_format:"%Y-%m-%dT%H:%MZ"}}">{{ $gimme->article->publish_date|camp_date_format:"%d %M %Y" }}</time> 
		   		 By {{ list_article_authors }} 
		   		 		{{ if $gimme->author->user->defined}}
		   		 			<a href="{{ $view->url(['username' => $gimme->author->user->uname], 'user') }}" class="link-color">
		   		 		{{/if}}
		   		 			{{ $gimme->author->name }}
		   		 			{{if $gimme->author->user->defined }}
		   		 			</a>
		   		 			{{/if}} 
		   		 			({{ $gimme->author->type|lower }}) 
		   		 			{{ if !$gimme->current_list->at_end }}, {{/if}}
		   		 			{{/list_article_authors}}
			</div>
		{{ if $gimme->article->has_map }}
			<div class="article-info">
				<i class="icon-map-marker"></i> <b>{{ #locations# }}:</b> <br> {{ list_article_locations }}{{ if $gimme->location->enabled }}{{ $gimme->location->name }}{{ if $gimme->current_list->at_end }}{{ else }}, {{ /if }}{{ /if }}{{ /list_article_locations }}
			</div> 
		{{/if}}
		<div class="article-info">
		 		{{ list_article_topics }}
		 		{{ if $gimme->current_list->at_beginning }}
			 	<i class="icon-tag"></i> <b>{{ #topics# }}:</b> <br>{{ /if }}<a class="link-color" href="{{ url options="template topic.tpl" }}">{{ $gimme->topic->name }}</a>{{ if $gimme->current_list->at_end }}{{ else }}, {{ /if }}{{ /list_article_topics }}
		</div>
	</div>
	{{/if}}

	{{ /foreach }}
    {{ if $gimme->article->subtitles_count("full_text") > 1}}
    {{ list_subtitles field_name="full_text" }}
        {{ if $gimme->current_list->at_beginning }}
        <div class="clearfix"></div>
        <ul id="subtitle-links" class="nav nav-tabs nav-stacked">
        {{ /if }}
        <li {{ if $gimme->article->current_subtitle_no('full_text') == $gimme->subtitle->number }} class="active" {{/if}} ><a href="{{ url options="article" }}?{{ $gimme->article->subtitle_url_id('full_text') }}={{ $gimme->subtitle->number}}">{{ $gimme->subtitle->name }}</a></li>
        {{ if $gimme->current_list->at_end }}
        </ul>
        {{ /if }}
    {{ /list_subtitles }}
    {{ /if }}

	{{ include file="_tpl/_edit-article.tpl" }}{{ $gimme->article->full_text }}
    
    {{ if $gimme->article->subtitles_count("full_text") > 1}}
    	<div class="pagination pagination-small">
  			<ul>
	    {{ if $gimme->article->full_text->has_previous_subtitles }}     
	    	<li><a href="{{ uri options="previous_subtitle full_text" }}">← {{ #previous# }}</a> </li>
	    {{ /if }} {{ if $gimme->article->full_text->has_next_subtitles }}     
	    	<li><a href="{{ uri options="next_subtitle full_text" }}">{{ #next# }} →</a> </li>
	    {{ /if }} 
	    	</ul>
	    <a class="solid-button pull-right" href="{{ uri options="all_subtitles full_text" }}">{{ #viewFullArticle# }}</a>
	    <div class="clearfix"></div> 
        </div>
    {{ /if }}

	{{ if $gimme->article->type_name == "news" }}

		{{ include file="_tpl/article-attachments.tpl"}}

	    <!-- Social Buttons BEGIN -->
	    <div class="well share-buttons">

	        <!--- Twitter button -->
	        <div id="twitter-button">
	            <a href="https://twitter.com/share" class="twitter-share-button" data-dnt="true">Tweet</a>
	        </div>
	        <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');
	        </script>

	        <!--- Google+ button -->
	        <div id="plus-button">
	            <div class="g-plusone" data-size="medium" data-annotation="inline" data-width="120"></div>
	            <script type="text/javascript">
	              (function() {
	                var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
	                po.src = 'https://apis.google.com/js/plusone.js';
	                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
	              })();
	            </script>
	        </div>

	        <!--- Facebook button -->
	        <div id="facebook-button">
	            <iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2F{{ $gimme->publication->site }}{{ uri }}&amp;send=false&amp;layout=standard&amp;width=285&amp;show_faces=false&amp;colorscheme=light&amp;action=like&amp;height=25&amp;appId=100924830001723" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:285px; height:25px;" allowTransparency="true"></iframe>
	        </div>
	        

	        <div class="clearfix"></div>

	    </div>
	    <!-- Social Buttons END -->

		{{ include file="_tpl/article-rating.tpl" }}

		{{ include "_tpl/comments.tpl" }}

	{{/if}}

{{ else }}
	<br>
    <div class="alert alert-error">{{ #infoOnLockedArticles# }}</div>
{{ /if }}

