window.onload = () => {
  

  const getAllLinks = () => {
    $.getJSON(`/api/v1/links`, function (response) {
      $('#all-links').text(JSON.stringify(response, null, 2));
    })
    $('#all-button').removeClass('hidden');
  }

  const getIndLinkEagle = () => {
    $.getJSON(`/api/v1/links/eagle`, function (response) {
      $('#individual-link').text(JSON.stringify(response, null, 2));
    })
    $('#individual-eagle-button').removeClass('hidden');
  }

  const getInd = (slug) => {
    $.getJSON(`/api/v1/links/${slug}`, function (response) {
      $('#individual-link').text(JSON.stringify(response, null, 2));
    })
    $('#individual-eagle-button').removeClass('hidden');
  }

  const createInd = (slug) => {
    $.post(`/api/v1/links?link=${slug}`, function (response) {
      $('#new-link').text(JSON.stringify(response, null, 2));
    })
    $('#create-button').removeClass('hidden');
  }

  const deleteInd = (slug) => {
    $.ajax({
      url: `/api/v1/links/${slug}`,
      type: "DELETE",
      success: (response) => {
        $('#delete-link').text(JSON.stringify(response, null, 2));
        $('#delete-button').removeClass('hidden');
      }
    })
  }



  // EVENT LISTENERS

  const addListenerToGetAll = () => {
    $('#get-all-links').click((e) => {
      getAllLinks();
    })
    $('#all-button').click((e) => {
      e.preventDefault();
      $('#all-button').addClass('hidden');
      $('#all-links').text('');
    })
  }
  const addListenerToGetEagle = () => {
    $('#get-individual-link-eagle').click((e) => {
      getIndLinkEagle();
    })
    $('#individual-eagle-button').click((e) => {
      e.preventDefault();
      $('#individual-eagle-button').addClass('hidden');
      $('#individual-link').text('');
    })
  }
  const addListenerToGetInd = () => {
    $('#get-ind').click((e) => {
      e.preventDefault();
      getInd(e.target.parentElement.firstElementChild.value);
    })
    $('#individual-eagle-button').click((e) => {
      e.preventDefault();
      $('#individual-eagle-button').addClass('hidden');
      $('#individual-link').text('');
    })
  }
  const addListenerToCreate = () => {
    $('#create').click((e) => {
      e.preventDefault();
      createInd(e.target.parentElement.firstElementChild.value);
    })
    $('#create-button').click((e) => {
      e.preventDefault();
      $('#create-button').addClass('hidden');
      $('#new-link').text('');
    })
  }
  const addListenerToDelete = () => {
    $('#delete').click((e) => {
      e.preventDefault();
      deleteInd(e.target.parentElement.firstElementChild.value);
    })
    $('#delete-button').click((e) => {
      e.preventDefault();
      $('#delete-button').addClass('hidden');
      $('#delete-link').text('');
    })
  }

  addListenerToGetAll();
  addListenerToGetInd();
  addListenerToGetEagle();
  addListenerToCreate();
  addListenerToDelete();
}
