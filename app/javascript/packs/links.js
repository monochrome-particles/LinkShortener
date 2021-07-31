$(document).ready(function() {
  $("#link_form").on("ajax:success", (event) => {
    const [data, _status, _xhr] = event.detail;
    $('.error').text('');
    showResult(data.token);
  }).on("ajax:error", (event) => { 
    const [data, _status, _xhr] = event.detail;
    $('.error').text('');
    showErrors(data);
  });
})

function showErrors(json) {
  Object.keys(json).forEach(function(key) {
    $("#error_for_"+key).text(key + " " + json[key].join(', '));
  })
}

function showResult(token) {
  const url = window.location.origin + "/" + token;
  $('#result').text(url);
  $('#result').attr('href', url);
}