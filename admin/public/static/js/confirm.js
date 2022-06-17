Confirm = {
  show: function (message, callback) {
    Swal.fire({
      title: 'Are you suer ?',
      text: message,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes !'
    }).then((result) => {
      if (result.value) {
        if (callback) {
          callback()
        }
      }
    })



  }
}