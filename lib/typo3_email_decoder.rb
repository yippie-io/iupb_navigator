class Typo3EmailDecoder
  def initialize
    @context = ExecJS.compile js
  end
  
  def decode_href(href) # pass in href attribute like "javascript:..."
    if href =~ /'(.*)'/
      decode $1
    else
      ""
    end
  end
  
  def decode(secret)
    @context.eval "decryptLink('#{secret}',-1)"
  end
  
  private 
  
  def js
    <<-JS
    var decryptCharcode = function (n, start, end, offset) {n=n+offset;if(offset>0&&n>end){n=start+(n-end-1);}else if(offset<0&&n<start){n=end-(start-n-1);}
    return String.fromCharCode(n);};
    var decryptLink = function (enc, offset){var dec="";var len=enc.length;for(var i=0;i<len;i++){var n=enc.charCodeAt(i);if(n>=0x2B&&n<=0x3A){dec+=decryptCharcode(n,0x2B,0x3A,offset);}else if(n>=0x40&&n<=0x5A){dec+=decryptCharcode(n,0x40,0x5A,offset);}else if(n>=0x61&&n<=0x7A){dec+=decryptCharcode(n,0x61,0x7A,offset);}else{dec+=enc.charAt(i);}}
    return dec;};
    JS
  end
end
