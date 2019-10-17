Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6160CDB62A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392066AbfJQSbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 14:31:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38160 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSbJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 14:31:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id e11so2764206otl.5;
        Thu, 17 Oct 2019 11:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OnxgCaPx91Saoqy8npEJzvJj20RILVf3jGePsqx/d+Y=;
        b=axB+eSX3ohxhK8SK+y0s66fYpluc3IXt3xtes8L0Q8x+n/R9ljjy10vtYr4T8+iwos
         CDLd5mzkv/m/G7O9zvQw4+FxwKLCOhpSvF8376VBBs/DiEn1EIwWLg0XcYijEnB0Vhsz
         ArCFfrhzybk7uXc9rIBD/dLaN1qqGAHmkR0Xf1fZcBEL01oDGxaa50nLTFlhktaPyG1j
         0ltHm0sk4gfnY2rdek3tutzuZwwT5iN8ImYX7l+Mb92FVxa6bsRWm+58bfqdkc1E0zvL
         eGK9Vp2aVsQi1OEYdmj0wmMALds9HDX8XzsWuFm5RSZj343tDP7Jq5CP7HIpwNwyClye
         LM4w==
X-Gm-Message-State: APjAAAVJOoKF2q8VOwjBO/qMvT4FveyDg3NN6Arm3wyIdj3vgeoGq7OP
        uNpmeobodXFok2S3symwyg==
X-Google-Smtp-Source: APXvYqzLK+ftRPrSCHWviqWQFqjBZcgp7MpXsGy8NEdBzpkgNxxRyOnRAPZEAr7eo9Ro2kqizxeUfw==
X-Received: by 2002:a9d:7398:: with SMTP id j24mr4392143otk.287.1571337068346;
        Thu, 17 Oct 2019 11:31:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y137sm718064oie.53.2019.10.17.11.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:31:07 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:31:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: max77650: convert the binding
 document to yaml
Message-ID: <20191017183106.GA11667@bogus>
References: <20191017071234.8719-1-brgl@bgdev.pl>
 <20191017071234.8719-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017071234.8719-2-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 09:12:29AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 core MFD module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      |  46 ------
>  .../devicetree/bindings/mfd/max77650.yaml     | 151 ++++++++++++++++++
>  2 files changed, 151 insertions(+), 46 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
> deleted file mode 100644
> index b529d8d19335..000000000000
> --- a/Documentation/devicetree/bindings/mfd/max77650.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -MAX77650 ultra low-power PMIC from Maxim Integrated.
> -
> -Required properties:
> --------------------
> -- compatible:		Must be "maxim,max77650"
> -- reg:			I2C device address.
> -- interrupts:		The interrupt on the parent the controller is
> -			connected to.
> -- interrupt-controller: Marks the device node as an interrupt controller.
> -- #interrupt-cells:	Must be <2>.
> -
> -- gpio-controller:	Marks the device node as a gpio controller.
> -- #gpio-cells:		Must be <2>. The first cell is the pin number and
> -			the second cell is used to specify the gpio active
> -			state.
> -
> -Optional properties:
> ---------------------
> -gpio-line-names:	Single string containing the name of the GPIO line.
> -
> -The GPIO-controller module is represented as part of the top-level PMIC
> -node. The device exposes a single GPIO line.
> -
> -For device-tree bindings of other sub-modules (regulator, power supply,
> -LEDs and onkey) refer to the binding documents under the respective
> -sub-system directories.
> -
> -For more details on GPIO bindings, please refer to the generic GPIO DT
> -binding document <devicetree/bindings/gpio/gpio.txt>.
> -
> -Example:
> ---------
> -
> -	pmic@48 {
> -		compatible = "maxim,max77650";
> -		reg = <0x48>;
> -
> -		interrupt-controller;
> -		interrupt-parent = <&gpio2>;
> -		#interrupt-cells = <2>;
> -		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> -
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -		gpio-line-names = "max77650-charger";
> -	};
> diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
> new file mode 100644
> index 000000000000..66a447e1cf56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/max77650.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX77650 ultra low-power PMIC from Maxim Integrated.
> +
> +maintainers:
> +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +
> +description: |
> +  This document describes the DT properties of the core MFD controller.

So does every file in this directory.

Describe what this chip is.

> +
> +  The GPIO-controller module is represented as part of the top-level PMIC
> +  node. The device exposes a single GPIO line.
> +
> +  For device-tree bindings of other sub-modules (regulator, power supply,
> +  LEDs and onkey) refer to the binding documents under the respective
> +  sub-system directories.
> +
> +  For more details on GPIO bindings, please refer to the generic GPIO DT
> +  binding document <devicetree/bindings/gpio/gpio.txt>.

Also fairly useless and another reference to maintain...

> +
> +properties:
> +  compatible:
> +    const: maxim,max77650
> +
> +  reg:
> +    description:
> +      I2C device address.
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +    description:
> +      The first cell is the IRQ number, the second cell is the trigger type.
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description:
> +      The first cell is the pin number and the second cell is used to specify
> +      the gpio active state.
> +
> +  gpio-line-names:
> +    maxItems: 1
> +    description:
> +      Single string containing the name of the GPIO line.
> +
> +  regulators:
> +    $ref: ../regulator/max77650-regulator.yaml

Not bisectable... This patch needs to come last.

> +
> +  charger:
> +    $ref: ../power/supply/max77650-charger.yaml
> +
> +  leds:
> +    $ref: ../leds/leds-max77650.yaml
> +
> +  onkey:
> +    $ref: ../input/max77650-onkey.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - gpio-controller
> +  - "#gpio-cells"

None of the child nodes are required?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/input/linux-event-codes.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@48 {
> +            compatible = "maxim,max77650";
> +            reg = <0x48>;
> +
> +            interrupt-controller;
> +            interrupt-parent = <&gpio2>;
> +            #interrupt-cells = <2>;
> +            interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            gpio-line-names = "max77650-charger";
> +
> +            regulators {
> +                compatible = "maxim,max77650-regulator";
> +
> +                max77650_ldo: regulator@0 {
> +                    regulator-compatible = "ldo";
> +                    regulator-name = "max77650-ldo";
> +                    regulator-min-microvolt = <1350000>;
> +                    regulator-max-microvolt = <2937500>;
> +                };
> +
> +                max77650_sbb0: regulator@1 {
> +                    regulator-compatible = "sbb0";
> +                    regulator-name = "max77650-sbb0";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <1587500>;
> +                };
> +            };
> +
> +            charger {
> +                compatible = "maxim,max77650-charger";
> +                input-voltage-min-microvolt = <4200000>;
> +                input-current-limit-microamp = <285000>;
> +            };
> +
> +            leds {
> +                compatible = "maxim,max77650-led";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@0 {
> +                    reg = <0>;
> +                    label = "blue:usr0";
> +                };
> +
> +                led@1 {
> +                    reg = <1>;
> +                    label = "red:usr1";
> +                    linux,default-trigger = "heartbeat";
> +                };
> +
> +                led@2 {
> +                    reg = <2>;
> +                    label = "green:usr2";
> +                };
> +            };
> +
> +            onkey {
> +                compatible = "maxim,max77650-onkey";
> +                linux,code = <KEY_END>;
> +                maxim,onkey-slide;
> +            };
> +        };
> +    };
> -- 
> 2.23.0
> 
