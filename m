Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE213C9255
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 22:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhGNUq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jul 2021 16:46:56 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:35420 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhGNUq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jul 2021 16:46:56 -0400
Received: by mail-io1-f46.google.com with SMTP id d9so3784876ioo.2;
        Wed, 14 Jul 2021 13:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78n9x8r54Zc4LVpo/BuDitmoDdD6fSFVZNhToAyEn/g=;
        b=HUdnWFL2vFww/af9qfhwF1C99Zn782vWzg7gzJL0rQuC3LWjrOq8fXWMWnKn7mJlbQ
         NQPMVi9FUA6Fioo4acjhvQYULn5Vncd26Fr9VulKoWj3nK2y9Cm+Zr+X/GOiWAuqH2+/
         oTDaEcWGu4ASk0Ysn0iiRtUW4CKLN/+jHlGAqRqKOOpN4PJ8flwTR/X/1eq01Fd+frw1
         6FokYvWDa51MdrHDriRzVVEh3lYvPHmtQCEWMbZR54/w1WtXbO5m8eNi73K3kW/ZH1pF
         HDVk31dTOmPhqXegW+P4r5SdFMUfp40qqqhj4XIWLcNqhKRncgmmE619IpaB3mbpmd1h
         8H2A==
X-Gm-Message-State: AOAM5313cCjN4RUAoGPZKKHdP7xTI2lfZdnJQ1PXU8nPMkimNiH3qcX5
        U8qLIEFS5GDWq0zuAPeu0euM7VZajA==
X-Google-Smtp-Source: ABdhPJwVgacr4nNJZAXEVWVKwxNHnYd77rw2Pvj5iYz9cC0zLeGO6XZhFQdua7F1gHtAPaA3MpIqkA==
X-Received: by 2002:a05:6602:3423:: with SMTP id n35mr14835ioz.188.1626295442797;
        Wed, 14 Jul 2021 13:44:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k4sm1796109ior.55.2021.07.14.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:44:02 -0700 (PDT)
Received: (nullmailer pid 3487467 invoked by uid 1000);
        Wed, 14 Jul 2021 20:44:00 -0000
Date:   Wed, 14 Jul 2021 14:44:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: mfd: convert tps65086.txt to YAML
Message-ID: <20210714204400.GB3476672@robh.at.kernel.org>
References: <20210625224744.1020108-1-kernel@esmil.dk>
 <20210625224744.1020108-2-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625224744.1020108-2-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 26, 2021 at 12:47:42AM +0200, Emil Renner Berthing wrote:
> This converts the tps65086.txt binding description to YAML schema so
> dts files can be verified automatically.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
> @Andrew: The dt-bindings meta schema requires a maintainer entry. I hope
> it's ok that I've added you, otherwise I don't know who should be
> listed.

Anyone that knows the h/w and/or cares if the binding is changed or 
deleted. If you can't find anyone, then good, one less binding. :)

> 
>  .../devicetree/bindings/mfd/ti,tps65086.yaml  | 127 ++++++++++++++++++
>  .../devicetree/bindings/mfd/tps65086.txt      |  54 --------
>  2 files changed, 127 insertions(+), 54 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> new file mode 100644
> index 000000000000..ba638bd10a58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,tps65086.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TPS65086 Power Management Integrated Circuit (PMIC)
> +
> +maintainers:
> +  - Andrew F. Davis <afd@ti.com>

Not a valid email any more. 

> +
> +properties:
> +  compatible:
> +    const: ti,tps65086
> +
> +  reg:
> +    const: 0x5e
> +    description: I2C slave address
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +    description: |
> +      The first cell is the IRQ number. The second cell is the flags,
> +      encoded as trigger masks from ../interrupt-controller/interrupts.txt.
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +    description: |
> +      The first cell is the pin number and the second cell is used to specify
> +      flags.  See ../gpio/gpio.txt for more information.
> +
> +  regulators:
> +    type: object
> +    description: |
> +      List of child nodes that specify the regulator initialization data.
> +      Child nodes must be named after their hardware counterparts:
> +      buck[1-6], ldoa[1-3], swa1, swb[1-2], and vtt.
> +      Each child node is defined using the standard binding for regulators and
> +      the optional regulator properties defined below.
> +
> +    patternProperties:
> +      "^buck[1-6]$":
> +        type: object
> +        $ref: ../regulator/regulator.yaml
> +
> +        properties:
> +          regulator-name: true
> +          regulator-boot-on: true
> +          regulator-always-on: true
> +          regulator-min-microvolt: true
> +          regulator-max-microvolt: true
> +          ti,regulator-step-size-25mv:
> +            type: boolean
> +            description: |
> +              Set this if the regulator is factory set with a 25mv step voltage
> +              mapping.
> +          ti,regulator-decay:
> +            type: boolean
> +            description: |
> +              Set this if the output needs to decay, default is for the output
> +              to slew down.
> +
> +        additionalProperties: false
> +
> +      "^(ldoa[1-3]|swa1|swb[1-2]|vtt)$":
> +        type: object
> +        $ref: ../regulator/regulator.yaml
> +
> +        properties:
> +          regulator-name: true
> +          regulator-boot-on: true
> +          regulator-always-on: true
> +          regulator-min-microvolt: true
> +          regulator-max-microvolt: true
> +
> +        additionalProperties: false
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - regulators
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic: tps65086@5e {

pmic@5e

> +            compatible = "ti,tps65086";
> +            reg = <0x5e>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +
> +            regulators {
> +                buck1 {
> +                    regulator-name = "vcc1";
> +                    regulator-min-microvolt = <1600000>;
> +                    regulator-max-microvolt = <1600000>;
> +                    regulator-boot-on;
> +                    ti,regulator-decay;
> +                    ti,regulator-step-size-25mv;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/tps65086.txt b/Documentation/devicetree/bindings/mfd/tps65086.txt
> deleted file mode 100644
> index 67eac0ed32df..000000000000
> --- a/Documentation/devicetree/bindings/mfd/tps65086.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -* TPS65086 Power Management Integrated Circuit (PMIC) bindings
> -
> -Required properties:
> - - compatible		: Should be "ti,tps65086".
> - - reg			: I2C slave address.
> - - interrupts		: The interrupt line the device is connected to.
> - - interrupt-controller	: Marks the device node as an interrupt controller.
> - - #interrupt-cells	: The number of cells to describe an IRQ, should be 2.
> -			    The first cell is the IRQ number.
> -			    The second cell is the flags, encoded as trigger
> -			    masks from ../interrupt-controller/interrupts.txt.
> - - gpio-controller      : Marks the device node as a GPIO Controller.
> - - #gpio-cells          : Should be two.  The first cell is the pin number and
> -                            the second cell is used to specify flags.
> -                            See ../gpio/gpio.txt for more information.
> - - regulators:          : List of child nodes that specify the regulator
> -                            initialization data. Child nodes must be named
> -                            after their hardware counterparts: buck[1-6],
> -                            ldoa[1-3], swa1, swb[1-2], and vtt. Each child
> -                            node is defined using the standard binding for
> -                            regulators and the optional regulator properties
> -                            defined below.
> -
> -Optional regulator properties:
> - - ti,regulator-step-size-25mv	: This is applicable for buck[1-6], set this
> -				    if the regulator is factory set with a 25mv
> -				    step voltage mapping.
> - - ti,regulator-decay		: This is applicable for buck[1-6], set this if
> -				    the output needs to decay, default is for
> -				    the output to slew down.
> -
> -Example:
> -
> -	pmic: tps65086@5e {
> -		compatible = "ti,tps65086";
> -		reg = <0x5e>;
> -		interrupt-parent = <&gpio1>;
> -		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-controller;
> -		#interrupt-cells = <2>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -
> -		regulators {
> -			buck1 {
> -				regulator-name = "vcc1";
> -				regulator-min-microvolt = <1600000>;
> -				regulator-max-microvolt = <1600000>;
> -				regulator-boot-on;
> -				ti,regulator-decay;
> -				ti,regulator-step-size-25mv;
> -			};
> -		};
> -	};
> -- 
> 2.32.0
> 
> 
