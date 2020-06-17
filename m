Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC4D1FD65F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 22:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFQUvb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 16:51:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33971 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 16:51:30 -0400
Received: by mail-io1-f66.google.com with SMTP id m81so4602225ioa.1;
        Wed, 17 Jun 2020 13:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PUqIc1amV3ysKKM5W4S+0rwIlkHs1OWVj0o1X7NJhus=;
        b=f0uo371ilNSIT/d5nA0fkO0xNCU0ytlWuvQrrO4ckyymMnnWXvDpTj2BpSpw/R4Aor
         gG7WOkRyX400w2Qv53NNrGBENssWQlEqu+TWflNhIihzUsqTsMQftQ3FGzczGJuFo9/+
         uziPrPVx039fxr0grGg6VyrUZL8B9lji78A2tGKj8BRXrimWHAExCsvdb4N1QgVhzYED
         Gchooae0p+zFZdmm39R8vm7GAWD7QTqW8p/9+b5UeV7ELRCsXN1gcK1DChykF+LYdwyh
         I2eCLmqLpmF2jP3eh1NOWpZGmq3MPZxBVazsWEvQSW1zz5iHeC/ffHJgd5BbvzGxtIRX
         qZWQ==
X-Gm-Message-State: AOAM531GEOgfJoQdGQ9IlwhuJ7XR65RavH/M7qURfUhM60KjLq/fyUrr
        +HVAB12BzQP5G1GBJOoPfg==
X-Google-Smtp-Source: ABdhPJwZIV2ss3INJ+tsnBpvrYC2Z4/eH7cHvST4htrIX2MjMYRjwva7DROSce3iqzSeOIIBCpc7gQ==
X-Received: by 2002:a05:6602:228c:: with SMTP id d12mr1349903iod.43.1592427089990;
        Wed, 17 Jun 2020 13:51:29 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p25sm516493iog.47.2020.06.17.13.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:51:29 -0700 (PDT)
Received: (nullmailer pid 2784859 invoked by uid 1000);
        Wed, 17 Jun 2020 20:51:28 -0000
Date:   Wed, 17 Jun 2020 14:51:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindints: power: supply: Document max17040
 extensions
Message-ID: <20200617205128.GA2775414@bogus>
References: <20200608182642.592848-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608182642.592848-1-iskren.chernev@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

typo in the subject

On Mon, Jun 08, 2020 at 09:26:41PM +0300, Iskren Chernev wrote:
> Maxim max17040 is a fuel gauge from a larger family utilising the Model
> Gauge thechnology. Document all different compatible strings that the

typo

> max17040 driver recognizes.
> 
> Some devices in the wild report double the capacity. The
> maxim,double-soc (from State-Of-Charge) property fixes that.
> 
> To compensate for the battery chemistry and operating conditions the
> chips support a compensation value. Specify one or two byte compensation
> via the maxim,rcomp byte array.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  .../power/supply/max17040_battery.txt         | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> index 4e0186b8380fa..be11cab4530b9 100644
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
> @@ -11,6 +13,15 @@ Optional properties :
>  				generated. Can be configured from 1 up to 32
>  				(%). If skipped the power up default value of
>  				4 (%) will be used.
> +- maxim,double-soc : 		Certain devices return double the capacity.
> +				Specify this boolean property to divide the
> +				reported value in 2 and thus normalize it.
> +				SOC == State of Charge == Capacity.
> +- maxim,rcomp :			A value to compensate readings for various
> +				battery chemistries and operating temperatures.
> +				max17040,41 have 2 byte rcomp, default to
> +				0x97 0x00. All other devices have one byte
> +				rcomp, default to 0x97.
>  - interrupts : 			Interrupt line see Documentation/devicetree/
>  				bindings/interrupt-controller/interrupts.txt
>  - wakeup-source :		This device has wakeup capabilities. Use this
> @@ -27,7 +38,16 @@ Example:
>  		compatible = "maxim,max77836-battery";
>  		reg = <0x36>;
>  		maxim,alert-low-soc-level = <10>;
> +		maxim,rcomp = /bits/ 8 <0x97 0x00>;
>  		interrupt-parent = <&gpio7>;
>  		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>  		wakeup-source;
>  	};
> +
> +	battery-fuel-gauge@36 {
> +		compatible = "maxim,max17048";
> +		reg = <0x36>;
> +		maxim,rcomp = /bits/ 8 <0x97>;
> +		maxim,alert-low-soc-level = <10>;
> +		maxim,double-soc;
> +	};
> 
> base-commit: 1713116fa907cc7290020f0d8632ec646d2936f8
> -- 
> 2.27.0
> 
