export const warnignAlert = (msg) => {
    Swal.fire({
        title: "¡Advertencia!",
        text: msg,
        icon: "warning"
      });
}