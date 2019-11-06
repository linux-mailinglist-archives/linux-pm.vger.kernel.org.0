Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4CF0DB6
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 05:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfKFEVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 23:21:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36597 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFEVJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 23:21:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so19803250oib.3;
        Tue, 05 Nov 2019 20:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GC1/ksdOjIfMA8r88prdxzosO6y9Ard78ftKzJT3YRs=;
        b=tq2sGz1cHZBlYtsVVU+Si2bktDKtjxGp+01cAwlXEQZlEkxa6HvJuxPrOmySqHjimX
         PsMe3A1D3neCtPDh4h4fGkDjPe/bPTmKgA58m5RKYZSse7j9vAJC6M/I6s906mC9rGGV
         2XK6ZQcrRZRtcTWbZRh48sGezn4gb6L9QE3hZlD+E2W3vDE359tUkA/1hc8cl/vyyoiO
         JpPOilRclK9p4OfMzgIPzTFC6nhuquAVvsJDBEr/yy8khVWs+uopPRXjWiNcKY3NCPt+
         +aUGbRNclCG1iY4/DBaSS1GYSIqxDQ3H1JX4usf8VoudX2/3uGQ4CTPolqhFx9aWuN9s
         1faA==
X-Gm-Message-State: APjAAAUzdhdjydj05VIYBi3fdrW8tJzf4MT91w0NKp4O0/c5SOC9ua09
        DQipNvCw5E+oc4oYnLsSXQ==
X-Google-Smtp-Source: APXvYqxb3gJ3FVF2f7SF5xK93QdhFdGOiFF3vebJkIxP4iOZGB1hOKdkRk9PCd9/I6GEDKwfvdOhYg==
X-Received: by 2002:aca:5942:: with SMTP id n63mr481764oib.56.1573014068494;
        Tue, 05 Nov 2019 20:21:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z16sm101924oih.56.2019.11.05.20.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:21:07 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:21:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: Add BCM2711 thermal
Message-ID: <20191106042107.GA27699@bogus>
References: <1572615749-9524-1-git-send-email-wahrenst@gmx.net>
 <1572615749-9524-2-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572615749-9524-2-git-send-email-wahrenst@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 01, 2019 at 02:42:26PM +0100, Stefan Wahren wrote:
> Since the BCM2711 doesn't have a AVS TMON block, the thermal information
> must be retrieved from the AVS ring oscillator block. So add a new
> suitable binding.

Anything else in that block? 
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  .../bindings/thermal/brcm,bcm2711-thermal.txt      | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2711-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2711-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2711-thermal.txt
> new file mode 100644
> index 0000000..5531d3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2711-thermal.txt
> @@ -0,0 +1,39 @@
> +Binding for Thermal Sensor driver for BCM2711 SoCs.
> +
> +Required properties:
> +- compatible:		must be: "brcm,bcm2711-thermal"

If the block is called 'AVS ring oscillator', then the compatible name 
should mirror that.

> +- reg:			Address range of the thermal registers.
> +- clocks:		Phandle of the clock used by the thermal sensor.
> +- #thermal-sensor-cells:	should be 0 (see thermal.txt)
> +
> +Example:
> +
> +thermal-zones {
> +	cpu_thermal: cpu-thermal {
> +		polling-delay-passive = <0>;
> +		polling-delay = <1000>;
> +
> +		thermal-sensors = <&thermal>;
> +
> +		trips {
> +			cpu-crit {
> +				temperature	= <80000>;
> +				hysteresis	= <0>;
> +				type		= "critical";
> +			};
> +		};
> +
> +		coefficients = <(-487)  410040>;
> +
> +		cooling-maps {
> +		};
> +	};
> +};
> +
> +thermal@7d5d2200 {
> +	compatible = "brcm,bcm2711-thermal";
> +	reg = <0x7d5d2200 0x4>;
> +	clocks = <&clocks BCM2835_CLOCK_TSENS>;
> +	#thermal-sensor-cells = <0>;
> +};
> +
> --
> 2.7.4
> 
