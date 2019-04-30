Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A87FD9C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfD3QPp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 12:15:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36568 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD3QPo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 12:15:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so2704641pfa.3;
        Tue, 30 Apr 2019 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=To53eP64nDHV0qyky0yhP+wHrXWci3jOJ+vTaEuHq/0=;
        b=XbQthZPkZqvXjghxbDEcY5YIseGnGzfsKHZyboFhSvRLNdL0xpPhdXwvMicpw/nBpx
         cF/1XauxMpco0kUxuRvEdA9dqA+UFx5QhDElv28iN9u8mb49m5NJ8pEzdZBshrB9lCIK
         GpFeDFaKWbP2HR7IZwv+nEvxMn57Mt3ZwW3smIZXthZb7Pwuu2J46CTaGCksl7RJetBO
         wPnfzt2hrqZHFMkEShir35mzRHTbu5q0JW7+cd8xRtog/JSdGLAPTtpFot3xgQx+IAw7
         jyC4crFr9jt7ojulM+s2jhr6Hg0Q4DY+Wuw3PfLjRnyHbP1yFwFBZSko+sCkq0ggLa4S
         pP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=To53eP64nDHV0qyky0yhP+wHrXWci3jOJ+vTaEuHq/0=;
        b=RZdnx3537WqXnVVlEtQJL9Y3IJSW+GJcljHsFtKdDHKricSX1WcwrskEon+VwO3pcY
         liSqar2BpTnlSzXkEuYqjhLas68cJr1JJ3vwEKQ5eQfXt0LpD3vwB5d4Avjy1qjkuDjJ
         KEozP/gEtoMfbdevBWixNfBUp1ibqGwIfwMW+K5sUmwbWt1qHS+LeB9vmIaM8MrwatcO
         t4nL+I3N2WjODnavHwgT+HDLb5G8HSidgmurGFZwrgqmox2hZjf/cOaeYTrO9NjjkRPC
         npVPEPqJI27VDk/pbMLE/KLxm3+X5jMv169TZP+p5xhF1adiW32gUinyZEla5ug8I5m1
         mR1A==
X-Gm-Message-State: APjAAAXZzNGOzOPDwdw4aiOTSJ4if1WUKqynMl1r78XtRV4ljpSpPjEG
        FHJ41IK98pwuoVAJrrPMcek=
X-Google-Smtp-Source: APXvYqyoF5fxCgwsOl/SkTT9wJUlJSVagV4me5hVlPz9N0VAatBssu6WvukGULT917FSx2PKdRqZTw==
X-Received: by 2002:a63:360c:: with SMTP id d12mr66418796pga.404.1556640944114;
        Tue, 30 Apr 2019 09:15:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g79sm33164193pfd.144.2019.04.30.09.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:15:43 -0700 (PDT)
Date:   Tue, 30 Apr 2019 09:15:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
Message-ID: <20190430161542.GB731@roeck-us.net>
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
 <20190430064557.28469-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430064557.28469-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 11:45:57PM -0700, Andrey Smirnov wrote:
> Add bindings for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> new file mode 100644
> index 000000000000..021fd7aba75e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> @@ -0,0 +1,27 @@
> +Microchip UCS1002 USB Port Power Controller
> +
> +Required properties:
> +- compatible		: Should be "microchip,ucs1002";
> +- reg			: I2C slave address
> +
> +Optional properties:
> +- interrupts-extended	: A list of interrupts lines present (could be either
> +			  corresponding to A_DET# pin, ALERT# pin, or both)
> +- interrupt-names	: A list of interrupt names. Should contain (if
> +			  present):
> +			  - "a_det" for line connected to A_DET# pin
> +			  - "alert" for line connected to ALERT# pin
> +			  Both are expected to be IRQ_TYPE_EDGE_BOTH
> +Example:
> +
> +&i2c3 {
> +	charger@32 {
> +		compatible = "microchip,ucs1002";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ucs1002_pins>;

Document the above ? Or is that optional ?

[ I am not a DT expert, so feel free to ignore. ]

Guenter

> +		reg = <0x32>;
> +		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
> +				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
> +		interrupt-names = "a_det", "alert";
> +	};
> +};
> -- 
> 2.20.1
> 
