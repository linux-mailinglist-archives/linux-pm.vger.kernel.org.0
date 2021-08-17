Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F283EF283
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 21:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhHQTMg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 15:12:36 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46053 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhHQTMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 15:12:34 -0400
Received: by mail-ot1-f54.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso26099678oth.12;
        Tue, 17 Aug 2021 12:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXzO0y9o8PUx9fCL1+Vgb1TmRusWXk/oMxy31KXHS88=;
        b=JqJHFciRPjWtqGUxgAKs/tyHPoVduJZLC+S1nSA7+ErwfpM8vYq/H8NtbKgk3vk+s9
         tL1ZV0RtaRNN5QD90FvraMdH3lZXZEE8YKburxJacFLfcbYFpHb7l/dYF8rK/6c0SF57
         vDYxRfqoOlIn+jZIfILuKhu4TY664gAgHE3CHsEvoXpxAbv7XZmqAKAMuyTniI6UfnN1
         dQklEzjDgH08XFSU9r9mtjq2xmkratxU7MIWCY3SX01JC0+hA9BjWqRzu/NkhdnW9b6B
         AeYwvR+3pTk/Cnj3jNXgbiM7vr92A/6Q7/YGVsoR/nQf1o0jkhmwdwYIf2Ub7Bl+t3lx
         8Ufg==
X-Gm-Message-State: AOAM532jrrqJT5rvmuX/2VqgLllUGXmrhutYz4ESWoROQ0eKIjCKiBMl
        xRxcSwcEU+6csPoXqWymiA==
X-Google-Smtp-Source: ABdhPJwxMPZIWpFXp2HS41uTczOJje8tNeXb6wBw+I9J9V0Fx8Q0OIrqbLkFuz1cy2yMkusuoy1i9A==
X-Received: by 2002:a9d:19d1:: with SMTP id k75mr3727316otk.355.1629227520380;
        Tue, 17 Aug 2021 12:12:00 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q20sm651386oiw.58.2021.08.17.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:11:59 -0700 (PDT)
Received: (nullmailer pid 681816 invoked by uid 1000);
        Tue, 17 Aug 2021 19:11:58 -0000
Date:   Tue, 17 Aug 2021 14:11:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, maccraft123mc@gmail.com,
        sre@kernel.org, heiko@sntech.de, lee.jones@linaro.org,
        pgwipeout@gmail.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <YRwJ/riSIGfNu64B@robh.at.kernel.org>
References: <20210810025436.23367-1-macroalpha82@gmail.com>
 <20210810025436.23367-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810025436.23367-2-macroalpha82@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 09, 2021 at 09:54:33PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
> 
> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
> 				      sample resistor.
> - rockchip,sleep-enter-current-microamp: The value in microamps of the
> 					 sleep enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
> 				 filter current.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../devicetree/bindings/mfd/rk808.txt         | 36 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Kind of a big change without converting this binding to DT schema first. 

> 
> diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
> index 23a17a6663ec..89b9fa7e10b5 100644
> --- a/Documentation/devicetree/bindings/mfd/rk808.txt
> +++ b/Documentation/devicetree/bindings/mfd/rk808.txt
> @@ -70,13 +70,40 @@ Optional RK817 properties:
>  
>  - vcc8-supply:  The input supply for BOOST
>  - vcc9-supply:  The input supply for OTG_SWITCH
> +
>  - codec:	The child node for the codec to hold additional properties.
>  		If no additional properties are required for the codec, this
>  		node can be omitted.
> -

Unrelated whitespace changes.

>  - rockchip,mic-in-differential: Telling if the microphone uses differential
>  				mode. Should be under the codec child node.
>  
> +- battery:	The child node for the charger to hold additional properties.
> +		If a battery is not in use, this node can be omitted. If a
> +		battery node is used, the following values are required:
> +		rockchip,resistor-sense, rockchip,sleep-enter-current,
> +		rockchip,sleep-filter-current, and a phandle to a

Property names are out of date...

> +		monitored-battery node that contains a valid value for
> +		charge-full-design-microamp-hours,
> +		charge-term-current-microamp,
> +		constant-charge-current-max-microamp,
> +		constant-charge-voltage-max-microvolt,
> +		voltage-max-design-microvolt, voltage-min-design-microvolt,
> +		and a valid ocv-capacity table.

Please list these 1 per line and make it clearer this is the list of 
properties for the battery node.

> +- rockchip,resistor-sense-micro-ohms: Value in microohms of the battery sense
> +				      resistor. The PMIC only supports values
> +				      of either 10000 or 20000. This value is
> +				      used by the driver to set the correct
> +				      divisor value to translate ADC readings
> +				      into the proper units of measure.
> +- rockchip,sleep-enter-current-microamp: Value in microamps of the sleep enter
> +					 current for the charger. Value is used
> +					 by the driver to calibrate the relax
> +					 threshold.
> +- rockchip,sleep-filter-current-microamp: Value in microamps of the sleep
> +					  filter current for the charger.
> +					  Value is used by the driver to derive
> +					  the sleep sample current.
> +
>  Optional RK818 properties:
>  - vcc1-supply:  The input supply for DCDC_REG1
>  - vcc2-supply:  The input supply for DCDC_REG2
> @@ -459,6 +486,13 @@ Example:
>  			};
>  		};
>  
> +		rk817_battery: battery {
> +			monitored-battery = <&battery_cell>;
> +			rockchip,resistor-sense-micro-ohms = <10000>;
> +			rockchip,sleep-enter-current-microamp = <300000>;
> +			rockchip,sleep-filter-current-microamp = <100000>;
> +		};
> +
>  		rk817_codec: codec {
>  			rockchip,mic-in-differential;
>  		};
> -- 
> 2.25.1
> 
> 
