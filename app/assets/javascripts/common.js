$(document).ready(load_modules);
$(document).on('turbolinks:load', load_modules);

function load_modules() {
  $('.ui.dropdown').dropdown();
  $('.ui.dropdown.pointing').dropdown({
    on: 'hover'
  });
  $('select.dropdown').dropdown();
  $('.message .close').on('click', function() {
    console.log('clicked');
    $(this).closest('.message').fadeOut();
  });
  $('.menu .item').tab();
  $('.ui.checkbox').checkbox();
}
