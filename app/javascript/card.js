// const pay = () => {
//   const form = document.getElementById('charge-form')
//   const publicKey = gon.public_key
//   const payjp = Payjp(publicKey)
//   const elements = payjp.elements();
//   const numberElement = elements.create('cardNumber');
//   const expiryElement = elements.create('cardExpiry');
//   const cvcElement = elements.create('cardCvc');

//   numberElement.mount('#number-form');
//   expiryElement.mount('#expiry-form');
//   cvcElement.mount('#cvc-form');




//   form.addEventListener("submit", (e) => {
//     console.log("イベント発火")
//     payjp.createToken(numberElement).then(function (response) {
//       if (response.error) {
//       } else {
//         const token = response.id;
//         console.log("トークン")
//         console.log(token)
//         const renderDom = document.getElementById("charge-form");
//         const tokenObj = `<input value=${token} name='token' type="hidden">`;
//         renderDom.insertAdjacentHTML("beforeend", tokenObj);
//       }
//       numberElement.clear();
//       expiryElement.clear();
//       cvcElement.clear();
//       document.getElementById("charge-form").submit();
//     });
//     e.preventDefault();
//   });
// };

// window.addEventListener("turbo:load", pay);





const pay = () => {
  // const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY);
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey)
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');


  // numberElement.mount('#card-number');
  // expiryElement.mount('#expiry-form');
  // cvcElement.mount('#cvc-form');


  const form = document.getElementById("charge-form");

  form.addEventListener("submit", (e) => {

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);