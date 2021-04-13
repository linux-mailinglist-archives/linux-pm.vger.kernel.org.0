Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA24B35E2F4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbhDMPek (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 11:34:40 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38542 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbhDMPec (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 11:34:32 -0400
Received: by mail-ot1-f46.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so16448564otk.5;
        Tue, 13 Apr 2021 08:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TxiWDmjeFP05zHVYI6G1MOBLZOY6XCJAiE1VwEry1aw=;
        b=c/KtKbEFlTQ3/zsx9WLV3ALIgKlKYFl6owShHArKFUw/rYDlN/kNXpWL9ygyHJVaZI
         yyP9+cFOLeZcZwhu2VF0NnrjBnWKhLj4hpusYUFaaO5KYVYJSw7aDw8GZCFv1VEuN/uJ
         J8wap6JIdHkVmjlnSU098HmK2uETBIuQhsn9lKiP0ewytkLixB+2+/HI7/+N4rZxMIB0
         wtqwZ7g8DiYwJdq/MMwzAw5AK1h0jfm9gVlEq95bN2b4o9Wh0QTihmT3Js+Ne3LLp2Ri
         wcw4wvlJxBok0QRSIdtoNDX5cRlTHYv1qDXU7h1WvKEF2uzP3K3x5IXra5LPZepQiUqz
         1OBg==
X-Gm-Message-State: AOAM530fy9RBRnblV4/kjSYzdIZ1DIVdNIVAoJq8QpMiy3R7EB/0gSKJ
        PRlvMlNSovUgDZfSQ0OhMg==
X-Google-Smtp-Source: ABdhPJzemfkw5Xws9Q02QDTOyuvBXp3nF0rZlJXJcrm6xIj5jrklJ7qyRTYdubW4XJwPvPTteQBU6Q==
X-Received: by 2002:a9d:7453:: with SMTP id p19mr28215236otk.271.1618328051852;
        Tue, 13 Apr 2021 08:34:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 24sm2898254oij.58.2021.04.13.08.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:34:08 -0700 (PDT)
Received: (nullmailer pid 1716640 invoked by uid 1000);
        Tue, 13 Apr 2021 15:34:07 -0000
Date:   Tue, 13 Apr 2021 10:34:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 5/6] dt-bindings: power: mfd: max8925: Convert to DT
 schema format
Message-ID: <20210413153407.GA1707829@robh.at.kernel.org>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
 <20210412230320.382885-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412230320.382885-6-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 13, 2021 at 01:03:19AM +0200, Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> The sub-functions of this MFD device do not have their own compatible
> string and are thus described directly in the MFD binding document
> after being converted to YAML.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../leds/backlight/max8925-backlight.txt      |  10 --
>  .../devicetree/bindings/mfd/max8925.txt       |  64 --------
>  .../bindings/mfd/maxim,max8925.yaml           | 139 ++++++++++++++++++
>  .../bindings/power/supply/max8925_battery.txt |  18 ---
>  4 files changed, 139 insertions(+), 92 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max8925.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/max8925_battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
> deleted file mode 100644
> index b4cffdaa4137..000000000000
> --- a/Documentation/devicetree/bindings/leds/backlight/max8925-backlight.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -88pm860x-backlight bindings
> -
> -Optional properties:
> -  - maxim,max8925-dual-string: whether support dual string
> -
> -Example:
> -
> -	backlights {
> -		maxim,max8925-dual-string = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/mfd/max8925.txt b/Documentation/devicetree/bindings/mfd/max8925.txt
> deleted file mode 100644
> index 4f0dc6638e5e..000000000000
> --- a/Documentation/devicetree/bindings/mfd/max8925.txt
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -* Maxim max8925 Power Management IC
> -
> -Required parent device properties:
> -- compatible : "maxim,max8925"
> -- reg : the I2C slave address for the max8925 chip
> -- interrupts : IRQ line for the max8925 chip
> -- interrupt-controller: describes the max8925 as an interrupt
> -  controller (has its own domain)
> -- #interrupt-cells : should be 1.
> -	- The cell is the max8925 local IRQ number
> -
> -Optional parent device properties:
> -- maxim,tsc-irq: there are 2 IRQ lines for max8925, one is indicated in
> -  interrupts property, the other is indicated here.
> -
> -max8925 consists of a large and varied group of sub-devices:
> -
> -Device			 Supply Names	 Description
> -------			 ------------	 -----------
> -max8925-onkey		:		: On key
> -max8925-rtc		:		: RTC
> -max8925-regulator	:		: Regulators
> -max8925-backlight	:		: Backlight
> -max8925-touch		:		: Touchscreen
> -max8925-power		:		: Charger
> -
> -Example:
> -
> -	pmic: max8925@3c {
> -		compatible = "maxim,max8925";
> -		reg = <0x3c>;
> -		interrupts = <1>;
> -		interrupt-parent = <&intcmux4>;
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -		maxim,tsc-irq = <0>;
> -
> -		regulators {
> -			SDV1 {
> -				regulator-min-microvolt = <637500>;
> -				regulator-max-microvolt = <1425000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			LDO1 {
> -				regulator-min-microvolt = <750000>;
> -				regulator-max-microvolt = <3900000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -		};
> -		backlight {
> -			maxim,max8925-dual-string = <0>;
> -		};
> -		charger {
> -			batt-detect = <0>;
> -			topoff-threshold = <1>;
> -			fast-charge = <7>;
> -			no-temp-support = <0>;
> -			no-insert-detect = <0>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max8925.yaml b/Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
> new file mode 100644
> index 000000000000..45365c53bb46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max8925.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max8925.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX8925 PMIC from Maxim Integrated.
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: maxim,max8925
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +    description:
> +      The cell is the IRQ number
> +
> +  maxim,tsc-irq:
> +    description: second interrupt from max8925
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "^SDV[1-3]$|^LDO[1-9]$|^LDO1[0-9]$|^LDO20$":
> +        description: regulator configuration for SDV1-3 and LDO1-20
> +        $ref: /schemas/regulator/regulator.yaml
> +
> +    additionalProperties: false
> +
> +  backlight:
> +    type: object
> +    properties:
> +      maxim,max8925-dual-string:
> +        description: set to 1 to support dual string
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +        default: 0
> +
> +    additionalProperties: false
> +
> +  charger:
> +    type: object
> +    properties:
> +      batt-detect:
> +        description: set to 1 if battery detection via ID pin is supported
> +        enum: [0, 1]
> +        default: 0
> +
> +      topoff-threshold:
> +        description: charging current in topoff mode, configures bits 5-6 in CHG_CNTL1
> +        minimum: 0
> +        maximum: 3
> +        default: 0
> +
> +      fast-charge:
> +        description: set charging current in fast mode, configures bits 0-3 in CHG_CNTL1
> +        minimum: 0
> +        maximum: 7
> +        default: 0
> +
> +      no-temp-support:
> +        description: set to 1 if temperature sensing is not supported
> +        enum: [0, 1]
> +        default: 0
> +
> +      no-insert-detect:
> +        description: set to 1 if AC detection is not supported
> +        enum: [0, 1]
> +        default: 0

All these need a type reference.

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        max8925@3c {
> +            compatible = "maxim,max8925";
> +            reg = <0x3c>;
> +            interrupts = <1>;
> +            interrupt-parent = <&intcmux4>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +            maxim,tsc-irq = <0>;
> +
> +            regulators {
> +                SDV1 {
> +                    regulator-min-microvolt = <637500>;
> +                    regulator-max-microvolt = <1425000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                LDO1 {
> +                    regulator-min-microvolt = <750000>;
> +                    regulator-max-microvolt = <3900000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +            };
> +
> +            backlight {
> +                maxim,max8925-dual-string = <0>;
> +            };
> +
> +            charger {
> +                batt-detect = <0>;
> +                topoff-threshold = <1>;
> +                fast-charge = <7>;
> +                no-temp-support = <0>;
> +                no-insert-detect = <0>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/power/supply/max8925_battery.txt b/Documentation/devicetree/bindings/power/supply/max8925_battery.txt
> deleted file mode 100644
> index d7e3e0c0f71d..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/max8925_battery.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -max8925-battery bindings
> -~~~~~~~~~~~~~~~~
> -
> -Optional properties :
> - - batt-detect: whether support battery detect
> - - topoff-threshold: set charging current in topoff mode
> - - fast-charge: set charging current in fast mode
> - - no-temp-support: whether support temperature protection detect
> - - no-insert-detect: whether support insert detect
> -
> -Example:
> -	charger {
> -		batt-detect = <0>;
> -		topoff-threshold = <1>;
> -		fast-charge = <7>;
> -		no-temp-support = <0>;
> -		no-insert-detect = <0>;
> -	};
> -- 
> 2.30.2
> 
