$ = jQuery

$ ->

  $('.search-submit').on 'click', (e) ->
    e.preventDefault()
    search_term = $('.search-term').val().toLowerCase()
    # Change the following to '/entries.json' to use the real version using your
    # own content.
    $.getJSON '/entries.json', (data) ->
      results = []
      for i in data
        value = 0
        if i.title.toLowerCase().split(search_term).length - 1 isnt 0
          value = 10
        if i.content.toLowerCase().split(search_term).length - 1 isnt 0
          value += (i.content.toLowerCase().split(search_term).length - 1) * 5
        if value isnt 0
          i.value = value
          results.push i
      $('.search-results').html ''
      if results.length > 0
        for result in results
          $( "<h2>Search results:</h2>" ).replaceAll( ".blog-preview" );
          $('.search-results').append '<p class="copy-bg">- <a href="' + result.url+'">' + result.title + '</a></p>'
      else
          $( "<h2>Search results:</h2>" ).replaceAll( ".blog-preview" );
          $('.search-results').append '<p class="copy-bg">No results found. Sorry.</p>'
          return