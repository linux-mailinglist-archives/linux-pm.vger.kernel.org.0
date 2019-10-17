Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC8DB68F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406827AbfJQSvV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 14:51:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33312 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388823AbfJQSvV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 14:51:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so2836784otu.0;
        Thu, 17 Oct 2019 11:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQYP/0Fr9W3z7AH2U3KxlY2QC+oTwq0Ok9HJ6oW23Oo=;
        b=kqifvuy1xpTCrGsb6usx5RT1exc91YnpZaw9jsX5hPADI2pTFo15hc9jmfzKAdgB6f
         xy172VOkSmUqp2jnWmsaY+PTxTM/tiM8m98bbCUBkhDJI+QKOPORAszA0XZOVY2dPz9V
         bBK6u0HkXZyLJQ/Blx76hsBYGRTmob/Siy/sckcY5JeAVZy+dB8H3b0G2zy1p7XYr6Lr
         iV3yeSFkGm74BOIORldvyYYeiZl2LbhV6QltFkBU56pBelg/+CuMVtBoAFozweOcM/bV
         gIu3X8mjZIO0TW3KBxU5gfd5RWwh+00AlA+Zm+MzpmUzgxP/eW2UcuWham6hH3B+6xDc
         yVOw==
X-Gm-Message-State: APjAAAW+2I7B8BhrLmMppGp9/LI0FKdxqzIfHETF7rfdTYSxrQ9DsLFt
        oCAMXTH9bkdIKoORP+d62UhosM0=
X-Google-Smtp-Source: APXvYqxHWeIp566bMef8Qjtvxkh468x/vVId7yRzAFfnsxxaEdu+fAz577HEprAedk4SvNVjed19yA==
X-Received: by 2002:a9d:6e92:: with SMTP id a18mr4130227otr.313.1571338279403;
        Thu, 17 Oct 2019 11:51:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w25sm816876oth.39.2019.10.17.11.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:51:18 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:51:17 -0500
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
Subject: Re: [PATCH v3 5/6] dt-bindings: leds: max77650: convert the binding
 document to yaml
Message-ID: <20191017185117.GA30431@bogus>
References: <20191017071234.8719-1-brgl@bgdev.pl>
 <20191017071234.8719-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017071234.8719-6-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 09:12:33AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Convert the binding document for MAX77650 LED module to YAML.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../bindings/leds/leds-max77650.txt           | 57 ------------------
>  .../bindings/leds/leds-max77650.yaml          | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
> deleted file mode 100644
> index 3a67115cc1da..000000000000
> --- a/Documentation/devicetree/bindings/leds/leds-max77650.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -LED driver for MAX77650 PMIC from Maxim Integrated.
> -
> -This module is part of the MAX77650 MFD device. For more details
> -see Documentation/devicetree/bindings/mfd/max77650.txt.
> -
> -The LED controller is represented as a sub-node of the PMIC node on
> -the device tree.
> -
> -This device has three current sinks.
> -
> -Required properties:
> ---------------------
> -- compatible:		Must be "maxim,max77650-led"
> -- #address-cells:	Must be <1>.
> -- #size-cells:		Must be <0>.
> -
> -Each LED is represented as a sub-node of the LED-controller node. Up to
> -three sub-nodes can be defined.
> -
> -Required properties of the sub-node:
> -------------------------------------
> -
> -- reg:			Must be <0>, <1> or <2>.
> -
> -Optional properties of the sub-node:
> -------------------------------------
> -
> -- label:		See Documentation/devicetree/bindings/leds/common.txt
> -- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
> -
> -For more details, please refer to the generic GPIO DT binding document
> -<devicetree/bindings/gpio/gpio.txt>.
> -
> -Example:
> ---------
> -
> -	leds {
> -		compatible = "maxim,max77650-led";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		led@0 {
> -			reg = <0>;
> -			label = "blue:usr0";
> -		};
> -
> -		led@1 {
> -			reg = <1>;
> -			label = "red:usr1";
> -			linux,default-trigger = "heartbeat";
> -		};
> -
> -		led@2 {
> -			reg = <2>;
> -			label = "green:usr2";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.yaml b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
> new file mode 100644
> index 000000000000..5a1e256185bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-max77650.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for MAX77650 PMIC from Maxim Integrated.
> +
> +maintainers:
> +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +
> +description: |
> +  This module is part of the MAX77650 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +  The LED controller is represented as a sub-node of the PMIC node on
> +  the device tree.
> +
> +  This device has three current sinks.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77650-led
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^led@[0-2]$":
> +    type: object
> +    description: |
> +      Properties for a single LED.
> +
> +    properties:
> +      reg:
> +        description:
> +          Index of the LED.
> +        maxItems: 1
> +        minimum: 0
> +        maximum: 2

Mixing array and scalar constraints. Just need (dropping maxItems):

items:
  - minimum: 0
    maximum: 2

> +
> +      label:
> +        $ref: "/schemas/types.yaml#/definitions/string"

Globally defined as a string already.

> +        description:
> +          The label of this LED.
> +
> +      linux,default-trigger:
> +        $ref: "/schemas/types.yaml#/definitions/string"

Assume this gets a common binding.

So just 'true' is sufficient for both of these.

> +        description:
> +          String defining the default trigger assigned to this LED.
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> -- 
> 2.23.0
> 
