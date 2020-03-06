
document.addEventListener('click', function(e) {
  // loop parent nodes from the target to the delegation node
  for (var target = e.target; target && target != this; target = target.parentNode) {
    if (target.matches('.close-button')) {
      target.parentNode.classList.add('fade-out-hide');
      target.parentNode.classList.remove('fade-out-show');
    }
  }
}, false);
