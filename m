Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A92EC9C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 00:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfD2WN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 18:13:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33995 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfD2WN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 18:13:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id v10so9690823oib.1;
        Mon, 29 Apr 2019 15:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4+1WtfCWcUUeWzzaEWxRWw2TZvNITlNmy6F8RQ/rdw=;
        b=KXZyjTZ52r4ijyvmLBB9YxMNoxRodB1tMbFAl2xSR6Rmawc2UhIaiyVNn3h/yy0+eG
         AyQ7hbLDqaTaui8mIdw2gMCulUzTRcge4bOVUiPJzO+RXuqRBUGB46993s3g6Uk7FcRN
         BffSvqjPd+Rv5WhUFUFkZblTJPDZ1M6XdwMYkEZdmMlTeKsVMEFqAQUae5XQG85JenS0
         E7qTcw+4CuB0cftWrtJMp4hnXpGVxJQocIRPFpwV7+qPGDdeaAZ6XW7LialdZ76d67cL
         VS418nwi+v01OIKTmqqTlVbjbaUhld0GYPblSCOXXBZL1KzGAbKCwDQ7F5iKiuJj+jso
         SZ3w==
X-Gm-Message-State: APjAAAVqvDN3PybuGaz9qybxDhKeItCcALx3lUbsqU5daNF14eS0Swvo
        ixbTx6TELJUX4F0Mvp/KKxrlFso=
X-Google-Smtp-Source: APXvYqyHtudepiGHnk8jmspB8YE7X7Z8AuRjDoRWm2vUgAeBzx34BJxAuulUTEO+NLO70TVzjbC5Xw==
X-Received: by 2002:aca:cf8e:: with SMTP id f136mr891742oig.118.1556576035146;
        Mon, 29 Apr 2019 15:13:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n185sm12090613oif.8.2019.04.29.15.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 15:13:54 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:13:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, krzk@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: Max17040: Add low
 level SOC alert threshold
Message-ID: <20190429221353.GA25837@bogus>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
 <20190415012635.6369-3-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415012635.6369-3-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 14, 2019 at 10:26:33PM -0300, Matheus Castello wrote:
> For configure low level state of charge threshold alert signaled from
> max17040 we add "maxim,alert-soc-level" property.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../power/supply/max17040_battery.txt         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> new file mode 100644
> index 000000000000..9b2cc67d556f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -0,0 +1,24 @@
> +max17040_battery
> +~~~~~~~~~~~~~~~~
> +
> +Required properties :
> + - compatible : "maxim,max17040" or "maxim,max77836-battery"

This is really a charger, not a battery.

> +
> +Optional properties :
> +- maxim,alert-soc-level :	The alert threshold that sets the state of
> + 				charge level where an interrupt is generated.
> +                          	Can be configured from 1 up to 32. If skipped
> +				the power up default value of 4 will be used.

Units? This is a low or high alert? Does a common property make sense 
here?

> +- interrupt-parent : 		The GPIO bank from the interrupt line.

Drop this. interrupt-parent is implied.

> +- interrupts : 			Interrupt line see Documentation/devicetree/
> +				bindings/interrupt-controller/interrupts.txt
> +
> +Example:
> +
> +	battery-charger@36 {
> +		compatible = "maxim,max17040";
> +		reg = <0x36>;
> +		maxim,alert-soc-level = <10>;
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;

Usually there are battery properties that need to be described too...

> +	};
> -- 
> 2.17.0
> 
