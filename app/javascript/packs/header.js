$(function() {
  $('.navbar-toggler').on('click', function(event) {
    $(this).toggleClass('active');
    $('#navbarNavDropdown').fadeToggle();
    event.preventDefault();
  });
});

