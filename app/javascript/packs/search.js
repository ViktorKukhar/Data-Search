$(document).ready(function() {
  $('form').on('submit', function(event) {
    event.preventDefault(); // prevent the default form submission

    $.ajax({
      url: $(this).attr('action'), // get the form action attribute
      method: $(this).attr('method'), // get the form method attribute
      data: $(this).serialize(), // serialize the form data
      success: function(response) {
        $('#table-body').html(response); // replace the table body with the search results
      }
    });
  });
});
