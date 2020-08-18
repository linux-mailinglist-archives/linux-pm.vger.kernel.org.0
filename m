Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD2248BCF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHRQnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 12:43:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34025 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgHRQnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 12:43:08 -0400
Received: by mail-io1-f65.google.com with SMTP id q75so21899908iod.1;
        Tue, 18 Aug 2020 09:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vNsX7ym346vZV2IXpFW1+Bm2l4MQVUC5xVcMg+Fr3KA=;
        b=QN5bH4mh4Ai3Z/tLpVQXp0RgJJvT8paBuZH7ycaH7FBDmw2UmKd0QGkgX4FttK51ZS
         TN8ZnVAhvoQiPkPWd1CrKV9tDtnQ3RA7X3CJMVXfT4ax3ug5hu1DVxgve6288yeMzbRQ
         WJHkes4PhIq/599gPQO22Ur+acDFp6poxDac7Isc2hIvBYT8lkMGiE8Q+1WXccPEC0SD
         kZyhYxLFp4lPbS+0dyVNZP8IsWDhBiMqM6JSJR0Yv+EaCiHFzY2foEms0eeJW25KrCig
         c9fhjudwueHmGdpueqvGmwVLqev/RcLl/sXGCn2YMD5D4Yv9NmTed/FzOY27hZgd2Xs1
         Snng==
X-Gm-Message-State: AOAM532wHxNbDMWqp5mc+ysJh5hd2TLBOPoAYcXE8SbABXfGKglqsAbj
        nYB4tvP3sq6DGjmTAZN6WA==
X-Google-Smtp-Source: ABdhPJx385KHb6YSculwonpQTNTGvzgEP6qHocj7X3P7aeGKh6Y0OK69b+vt5KTREtklDkFnoqccsg==
X-Received: by 2002:a05:6638:bd1:: with SMTP id g17mr20187356jad.132.1597768987428;
        Tue, 18 Aug 2020 09:43:07 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p7sm7761353ilj.56.2020.08.18.09.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:43:06 -0700 (PDT)
Received: (nullmailer pid 3595784 invoked by uid 1000);
        Tue, 18 Aug 2020 16:43:05 -0000
Date:   Tue, 18 Aug 2020 10:43:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [PATCH v1 1/2] dt-bindings: power: Add the bq256xx dt bindings
Message-ID: <20200818164305.GB3586878@bogus>
References: <20200817191723.22416-1-r-rivera-matos@ti.com>
 <20200817191723.22416-2-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817191723.22416-2-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 17, 2020 at 02:17:22PM -0500, Ricardo Rivera-Matos wrote:
> Add the bindings for the bq256xx series of battery charging ICs.
> 
> Datasheets:
> - https://www.ti.com/lit/ds/symlink/bq25600.pdf
> - https://www.ti.com/lit/ds/symlink/bq25601.pdf
> - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25618.pdf
> - https://www.ti.com/lit/ds/symlink/bq25619.pdf
> 
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  .../bindings/power/supply/bq256xx.yaml        | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> new file mode 100644
> index 000000000000..67db4ba9fdb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq256xx.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI bq256xx Switch Mode Buck Charger
> +
> +maintainers:
> +  - Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> +
> +description: |
> +  The bq256xx devices are a family of highly-integrated battery charge
> +  management and system power management ICs for single cell Li-ion and Li-
> +  polymer batteries.
> +
> +  Datasheets:
> +    - https://www.ti.com/lit/ds/symlink/bq25600.pdf
> +    - https://www.ti.com/lit/ds/symlink/bq25601.pdf
> +    - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
> +    - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
> +    - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
> +    - https://www.ti.com/lit/ds/symlink/bq25618.pdf
> +    - https://www.ti.com/lit/ds/symlink/bq25619.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq25600
> +      - ti,bq25601
> +      - ti,bq25600d
> +      - ti,bq25601d
> +      - ti,bq25611d
> +      - ti,bq25618
> +      - ti,bq25619
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,watchdog-timer:

Poorly named since we have 'ti,watchdog-timers' already and is 
completely different.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Watchdog timer in milli seconds. 0 (default) disables the watchdog

If you have units, then you should use standard unit suffix.

> +    minimum: 0
> +    maximum: 160000
> +    enum: [ 0, 40000, 80000, 160000]
> +
> +  input-voltage-limit-microvolt:
> +    description: |
> +       Minimum input voltage limit in micro volts with a 100000 micro volt step
> +    minimum: 3900000
> +    maximum: 5400000
> +
> +  input-current-limit-microamp:
> +    description: |
> +       Maximum input current limit in micro amps with a 100000 micro amp step
> +    minimum: 100000
> +    maximum: 3200000

Aren't these properties of the battery, not the charger?

> +
> +required:
> +  - compatible
> +  - reg

monitored-battery not required?

Add:

additionalProperties: false


> +
> +examples:
> +  - |
> +    bat: battery {
> +      compatible = "simple-battery";
> +      constant-charge-current-max-microamp = <2040000>;
> +      constant-charge-voltage-max-microvolt = <4352000>;
> +      precharge-current-microamp = <180000>;
> +      termination-current-microamp = <180000>;
> +    };
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {

i2c {

> +      pinctrl-names = "default";
> +      pinctrl-0 = <&i2c2_pins>;

Not relevant to the example.

> +
> +      status = "okay";

Don't show status in examples.

> +      clock-frequency = <400000>;
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      bq25601@6b {

charger@6b

> +        compatible = "ti,bq25601";
> +        reg = <0x6b>;
> +        monitored-battery = <&bat>;
> +
> +        interrupt-parent = <&gpio1>;
> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> +        watchdog-timer = <40000>;
> +
> +        input-voltage-limit-microvolt = <4500000>;
> +        input-current-limit-microamp = <2400000>;
> +       };
> +    };
> +...
> -- 
> 2.28.0
> 
