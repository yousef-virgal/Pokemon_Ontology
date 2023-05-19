window.addEventListener("load", () => {
  const button = document.querySelector("button");

  button.addEventListener("click", (event) => {
    const textArea = document.querySelector("textarea");
    console.log(textArea.value);
    fetch(
      "/query?" +
        new URLSearchParams({
          q: textArea.value,
        })
    )
      .then((response) => {
        return response.json();
      })
      .then((data) => console.log(data))
      .catch((error) => console.log(error));
  });
});
