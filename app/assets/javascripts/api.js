window.onload = () => {
  

  const getAllLinks = () => {
    $.getJSON(`https://ambassador-code-rails.herokuapp.com/api/v1/links`, function (response) {
      $('#all-links').text(response)
    })
  }





  const addListenerToGetAll = () => {
    $('#get-all-links').click((e) => {
      getAllLinks();
    })
  }
  const addListenerToGetInd = () => {

  }
  const addListenerToCreate = () => {

  }
  const addListenerToDelete = () => {

  }

  addListenerToGetAll();
  addListenerToGetInd();
  addListenerToCreate();
  addListenerToDelete();
}
