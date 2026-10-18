import Raty from "raty-js"

document.addEventListener("turbo:load", () => {
  const postElem = document.querySelector("#post_raty");
  if (postElem) {

    postElem.innerHTML = "";

    new Raty(postElem, {
      score: Number(postElem.dataset.score) || 0,
      scoreName: "post[rating]",
      starType: "img",
      half: true,
      starOn: postElem.dataset.starOn,
      starOff: postElem.dataset.starOff,
      starHalf: postElem.dataset.starHalf,
    }).init();
  }

  const showElems = document.querySelectorAll(".show_raty");
  if (showElems.length > 0) {
    showElems.forEach((elem) => {
    elem.innerHTML = "";

    const rating = elem.dataset.score;
    new Raty(elem, {
      score: Number(rating),
      readOnly: true,
      starType: "img",
      half: true,
      starOn: elem.dataset.starOn,
      starOff: elem.dataset.starOff,
      starHalf: elem.dataset.starHalf,
    }).init();
  });
  }

});