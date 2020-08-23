Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF58A24EF21
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 20:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgHWSHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 14:07:17 -0400
Received: from mail.v3.sk ([167.172.186.51]:42430 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgHWSHR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Aug 2020 14:07:17 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Aug 2020 14:07:15 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3E84CDF106;
        Sun, 23 Aug 2020 17:59:46 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uzF78zdjqwmD; Sun, 23 Aug 2020 17:59:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 759FDDFA6B;
        Sun, 23 Aug 2020 17:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uf-79zAqGnZt; Sun, 23 Aug 2020 17:59:44 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DC182DF106;
        Sun, 23 Aug 2020 17:59:43 +0000 (UTC)
Date:   Sun, 23 Aug 2020 20:00:41 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] dt-bindings: mfd: ene-kb3930: Document
 power-supplies and monitored-battery properties
Message-ID: <20200823180041.GB209852@demiurge.local>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823140846.19299-6-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Sun, Aug 23, 2020 at 05:08:45PM +0300, Dmitry Osipenko wrote:
> Battery could be connected to the controller and in this case controller
> will provide a battery-monitor function.
> 
> The power-supplies phandle property is needed in order to describe the
> power supply which is used for charging of the battery, this allows to
> determine whither battery is charging or discharging, depending on the
> supply state.
> 
> The monitored-battery phandle provides information about the battery cell
> characteristics.

I believe it would be better if you created a new binding document
instead of reusing this one -- the hardware part iseems to be a
different one and the firmware it runs seems to be behaving totally
differently than the usual ENE firmware [1].

[1] This eneec.c seems to be coming from ENE, so I'm assuming it's a
    good enough description of how their firmware behaves:
    https://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp3-dell-ariel.git/tree/drivers/input/serio/eneec.c

Cheers
Lubo

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ene-kb3930.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
> index 5a1c4a959d9c..435728054f3a 100644
> --- a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
> @@ -29,6 +29,8 @@ properties:
>      description: GPIO used with the shutdown protocol on Ariel
>      maxItems: 2
>  
> +  monitored-battery: true
> +  power-supplies: true
>    system-power-controller: true
>  
>  required:
> @@ -41,6 +43,19 @@ examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
>  
> +    battery: battery-cell {
> +            compatible = "simple-battery";
> +            charge-full-design-microamp-hours = <3260000>;
> +            energy-full-design-microwatt-hours = <24000000>;
> +            operating-range-celsius = <0 40>;
> +    };
> +
> +    mains: ac-adapter {
> +      compatible = "gpio-charger";
> +      charger-type = "mains";
> +      gpios = <&gpio 125 GPIO_ACTIVE_LOW>;
> +    };
> +
>      i2c {
>        #address-cells = <1>;
>        #size-cells = <0>;
> @@ -52,6 +67,9 @@ examples:
>  
>          off-gpios = <&gpio 126 GPIO_ACTIVE_HIGH>,
>                      <&gpio 127 GPIO_ACTIVE_HIGH>;
> +
> +        monitored-battery = <&battery>;
> +        power-supplies = <&mains>;
>        };
>      };
>  
> -- 
> 2.27.0
> 
