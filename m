Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA55B164F52
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 20:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBST5W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 14:57:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45080 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBST5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 14:57:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so25041611oic.12;
        Wed, 19 Feb 2020 11:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X7Cntp4AOEoOd/QDouJIkpO3jkbcftTYGpmm5Cp5JQk=;
        b=UrFGWGwgEhHQq/tpb0chPcc75O4/SpRHXRjF4rOE0It+dFZJAEOLSAuE5BKw8ca5TS
         gJVIviU/u/7cydAyRMiBSOxqGdJIXn/3HtZ/tiNY/Oq8HTg7OmqhMN225YUycBI4BDmT
         zYWwQhYnZ9Ra2RuiRvzDQuJIM+Ib5Q9ELUX/PPBovbyxYEKJL983kiQ+AfMLgGCkKIjc
         FFWEsLgHMst6+U62PhJbGevqSKa0dYR/dr9tO5J8pWXSX/zt9nWESzDxxMb0+uz2x+Fp
         8GGQYoLAI7LPNRvRULRYojHNYGHaKeq7jrSJHqnefVWXl9NZcMouEwo9G+vY4VnDJsv8
         9Ehw==
X-Gm-Message-State: APjAAAXZmY1xFU5By/7Dkv4bxU4TsVKvs/wUSLSpkAwj7zJtCYSMyILC
        WWgdk16Ip4cI9ZjQfrhOSxsaT+olYA==
X-Google-Smtp-Source: APXvYqyD1fcoT1v/CiA2afjT5AB1aLfNBKse86anVISECPyrP3b78rWCg2sxIHL54q38S6YenlzRPA==
X-Received: by 2002:aca:4789:: with SMTP id u131mr5446385oia.43.1582142241093;
        Wed, 19 Feb 2020 11:57:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t132sm303349oie.8.2020.02.19.11.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:57:20 -0800 (PST)
Received: (nullmailer pid 4616 invoked by uid 1000);
        Wed, 19 Feb 2020 19:57:19 -0000
Date:   Wed, 19 Feb 2020 13:57:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, mikko.mutanen@fi.rohmeurope.com,
        markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: battry: add new battery
 parameters
Message-ID: <20200219195719.GA3096@bogus>
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
 <205c01fe0555fe89226521a89a5b20933578780d.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <205c01fe0555fe89226521a89a5b20933578780d.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 14, 2020 at 09:30:05AM +0200, Matti Vaittinen wrote:
> Add:
> 
>  - tricklecharge-current-microamp:
> 
> Some chargers have 3 charging stages. First one when battery is almost
> empty is often called as trickle-charge. Last state when battery has been
> "woken up" is usually called as fast-charge. In addition to this some
> chargers have a 'middle state' which ROHM BD99954 data-sheet describes as
> pre-charge. Some batteries can benefit from this 3-phase charging
> [citation needed].

For car batteries at least, trickle charge is to keep battery full. But 
maybe in that context, it would be 'charge-term-current-microamp'.

I'm just concerned that we end up with multiple properties that mean the 
same thing. I think you're okay here.

> Introduce tricklecharge-current-microamp so that batteries can give
> charging current limit for all three states.
> 
>  - precharge-upper-limit-microvolt:
> 
> When battery voltage has reached certain limit we change from
> trickle-charge to next charging state (pre-charge for BD99954). Allow
> battery to specify this limit.
> 
>  - re-charge-voltage-microvolt:
> 
> Allow giving a battery specific voltage limit for chargers which can
> automatically re-start charging when battery has discharghed down to
> this limit.
> 
> - over-voltage-threshold-microvolt
> 
> Allow specifying voltage threshold after which the battery is assumed to
> be faulty.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  Documentation/devicetree/bindings/power/supply/battery.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 5c913d4cf36c..7da044273e08 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -11,15 +11,21 @@ different type. This prevents unpredictable, potentially harmful,
>  behavior should a replacement that changes the battery type occur
>  without a corresponding update to the dtb.
>  
> +Please note that not all charger drivers respect all of the properties.
> +
>  Required Properties:
>   - compatible: Must be "simple-battery"
>  
>  Optional Properties:
> + - over-voltage-threshold-microvolt: battery over-voltage limit
> + - re-charge-voltage-microvolt: limit to automatically start charging again
>   - voltage-min-design-microvolt: drained battery voltage
>   - voltage-max-design-microvolt: fully charged battery voltage
>   - energy-full-design-microwatt-hours: battery design energy
>   - charge-full-design-microamp-hours: battery design capacity
> + - tricklecharge-current-microamp: current for trickle-charge phase

trickle-charge-...

>   - precharge-current-microamp: current for pre-charge phase
> + - precharge-upper-limit-microvolt: limit when to change to constant charging
>   - charge-term-current-microamp: current for charge termination phase
>   - constant-charge-current-max-microamp: maximum constant input current
>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
> -- 
> 2.21.0
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 
