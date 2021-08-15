function post (){
  const priceInput = document.getElementById("item-price")
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;

      //販売手数料の計算
      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = Math.floor(inputValue * 0.10)

      //販売利益の計算
      const addProfit = document.getElementById("profit")
      addProfit.innerHTML = Math.floor(inputValue - (inputValue * 0.10))
  })
};

window.addEventListener('load', post);