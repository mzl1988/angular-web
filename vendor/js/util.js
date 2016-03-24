function openMenuState() {
  $(".app").removeClass("small-sidebar");
  $(".toggle-sidebar i").removeClass("fa-angle-right").addClass("fa-angle-left");
}
function closeMenuState() {
  $(".app").addClass("small-sidebar");
  $(".toggle-sidebar  i").removeClass("fa-angle-left").addClass("fa-angle-right");
}
$(document).on("click", ".toggle-sidebar ", function(e) {
  e.preventDefault();
  if ($(".app").hasClass("small-sidebar")) {
    openMenuState();
  } else {
    closeMenuState();
  }
});