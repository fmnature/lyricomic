document.querySelectorAll('.scroll').forEach(elm => {

	elm.onscroll = function () {

		if (this.scrollTop + this.clientHeight >= this.scrollHeight) {
      //スクロールが末尾に達した
      
			if (parseInt(this.dataset.lastnum) < parseInt(this.dataset.max)) {

        //未ロードの画像がある場合
        
        this.dataset.lastnum = parseInt(this.dataset.lastnum) + 1;
        
        let img = document.createElement('img');
        
        img.src =  this.dataset.lastnum +'.jpg';
        
        this.appendChild(img);

      }
    }
  };
});