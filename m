Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1D821E05D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgGMTDN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 15:03:13 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37736 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMTDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 15:03:12 -0400
Received: by mail-il1-f196.google.com with SMTP id r12so12151790ilh.4;
        Mon, 13 Jul 2020 12:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l5rWVgnnCloHt41CFPCxRV5qmnmySbxOsQcq4blbDZU=;
        b=ZMUT17gJPmBGA6zePd0uFpkmKqt59ITqHZGlUtkyL4JtM1vo28ypmBUssz7LhSrHDr
         ohGPxkcUcDziTjb5llGP7U/UP0uBNHjmXJSMeloKbkVCj8OdNDa9x7jxhUugJqi+xMh3
         qE+kJdGuJjyfYQk10LdLf0yYXhrx2Vl5R38CzshG611ol0Q2CNffl9ftDeuIRj1txGpl
         Od1niqW1icvujCGxGFkGk2R2Az9dBzHAsfIgOrmcWwThPnpV0nUJqzGeoVU2jIJHhru3
         wWa2oCVZqlrKqWA3OsOInzDHN0tr/yOU2Qj+51Q1OrP2x96GVmHF5vq6r59SAftj6cya
         4XDw==
X-Gm-Message-State: AOAM530zoQHoTgCEp0NyYrBMdHYz0QLTMkRaSidrFuAr/SvD54Uv5zQJ
        7brQJpTG5VXorvW0cOUES6LuBJ1ueg==
X-Google-Smtp-Source: ABdhPJyFU3OO/ANkI1WfClMonQPuMZQFkzhvvt9yHjYL0J26xn464hZPF3poCvPXO+hMPxbus5uE0g==
X-Received: by 2002:a92:6a02:: with SMTP id f2mr1110656ilc.68.1594666991695;
        Mon, 13 Jul 2020 12:03:11 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x12sm1175218iov.43.2020.07.13.12.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:03:10 -0700 (PDT)
Received: (nullmailer pid 547640 invoked by uid 1000);
        Mon, 13 Jul 2020 19:03:10 -0000
Date:   Mon, 13 Jul 2020 13:03:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: power: supply: Extend max17040
 compatibility
Message-ID: <20200713190310.GA546410@bogus>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
 <20200624155633.3557401-3-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624155633.3557401-3-iskren.chernev@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 06:56:29PM +0300, Iskren Chernev wrote:
> Maxim max17040 is a fuel gauge from a larger family utilising the Model
> Gauge technology. Document all different compatible strings that the
> max17040 driver recognizes.
> 
> Some devices in the wild report double the capacity. The
> maxim,double-soc (from State-Of-Charge) property fixes that.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  .../bindings/power/supply/max17040_battery.txt    | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> index 4e0186b8380fa..554bce82a08e6 100644
> --- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -2,7 +2,9 @@ max17040_battery
>  ~~~~~~~~~~~~~~~~
>  
>  Required properties :
> - - compatible : "maxim,max17040" or "maxim,max77836-battery"
> + - compatible : "maxim,max17040", "maxim,max17041", "maxim,max17043",
> + 		"maxim,max17044", "maxim,max17048", "maxim,max17049",
> +		"maxim,max17058", "maxim,max17059" or "maxim,max77836-battery"
>   - reg: i2c slave address
>  
>  Optional properties :
> @@ -11,6 +13,10 @@ Optional properties :
>  				generated. Can be configured from 1 up to 32
>  				(%). If skipped the power up default value of
>  				4 (%) will be used.
> +- maxim,double-soc : 		Certain devices return double the capacity.
> +				Specify this boolean property to divide the
> +				reported value in 2 and thus normalize it.
> +				SOC == State of Charge == Capacity.

This can't be implied by the compatible string?

>  - interrupts : 			Interrupt line see Documentation/devicetree/
>  				bindings/interrupt-controller/interrupts.txt
>  - wakeup-source :		This device has wakeup capabilities. Use this
> @@ -31,3 +37,10 @@ Example:
>  		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>  		wakeup-source;
>  	};
> +
> +	battery-fuel-gauge@36 {
> +		compatible = "maxim,max17048";
> +		reg = <0x36>;
> +		maxim,alert-low-soc-level = <10>;
> +		maxim,double-soc;
> +	};
> -- 
> 2.27.0
> 
