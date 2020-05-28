Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CC1E53A2
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 04:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgE1CGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 22:06:36 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:38548 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1CGf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 22:06:35 -0400
Received: by mail-io1-f43.google.com with SMTP id d7so28362261ioq.5;
        Wed, 27 May 2020 19:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e0JdTAh/sH1xhLv5fA+UWq+PNY013b4LCOvIOpzDEg8=;
        b=BUXpsZAX2eW+NlUi12xGcIdUM5KfEygCVBexXFiwFXPR+YGU4s8qzVvfEBd4Ly0ZVj
         yyjncjr3otY4XjJI4yaavqT9oP7DuUOEf5LFpSaEv9D8xCobzrhEkTosxPcUB9ENjR4C
         N1jTqUJss1zn3u21wPMq8mnZ3pTTKFOpk4zXEs9nZlLo/WyDy4vquAMB5pvVpM2f12BK
         y9s+oMkM3JyDaAWPy51+5tMoGTfC2YRbYX0nrYjllqa89AmBcaitRPNQRsByHmGhDv0Z
         4PHU8GEjUTda8LRbWcvcYgElUlBHucnti/SmPxs86qX/HlagsiFL3aB0ffRioTgWUTXF
         umeg==
X-Gm-Message-State: AOAM533jX06RYJqljC80id4ys48CU2M67XoiyHrVCJHA/ZMpZZ+7N8MN
        dMBCR2HwDHZ+2CbHL5/ncw==
X-Google-Smtp-Source: ABdhPJzBXlXqNm6zjTvpUegdAoReVOZFmSVXnwBwUSxdfkNW24PCybA278OPvjw9EwqDBZI4/cp0ag==
X-Received: by 2002:a05:6638:134b:: with SMTP id u11mr715500jad.102.1590631594041;
        Wed, 27 May 2020 19:06:34 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j9sm2461867ilr.18.2020.05.27.19.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:06:33 -0700 (PDT)
Received: (nullmailer pid 3214169 invoked by uid 1000);
        Thu, 28 May 2020 02:06:32 -0000
Date:   Wed, 27 May 2020 20:06:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 2/2] dt-bindings: power: supply: gpio-charger: convert
 to yaml
Message-ID: <20200528020632.GA3201271@bogus>
References: <20200513115601.360642-1-sebastian.reichel@collabora.com>
 <20200513115601.360642-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513115601.360642-2-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 13, 2020 at 01:56:01PM +0200, Sebastian Reichel wrote:
> Convert the gpio-charger bindings from text format to
> new YAML based representation.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/gpio-charger.txt    | 38 ----------
>  .../bindings/power/supply/gpio-charger.yaml   | 75 +++++++++++++++++++
>  2 files changed, 75 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> deleted file mode 100644
> index dbfd29029f69..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -gpio-charger
> -
> -Required properties :
> - - compatible : "gpio-charger"
> - - charger-type : power supply type, one of
> -     unknown
> -     battery
> -     ups
> -     mains
> -     usb-sdp (USB standard downstream port)
> -     usb-dcp (USB dedicated charging port)
> -     usb-cdp (USB charging downstream port)
> -     usb-aca (USB accessory charger adapter)
> -
> -Optional properties:
> - - gpios : GPIO indicating the charger presence.
> -   See GPIO binding in bindings/gpio/gpio.txt .
> - - charge-status-gpios: GPIO indicating whether a battery is charging.
> - - charge-current-limit-gpios: Output GPIOs specifiers for limiting the charge current
> - - charge-current-limit-mapping: List of touples with current in uA and a GPIO bitmap (in this order).
> -                                The GPIOs are encoded in the same order as specified in charge-current-limit-gpios.
> -				The touples must be provided in descending order of the current limit.
> -
> -Example:
> -
> -	usb_charger: charger {
> -		compatible = "gpio-charger";
> -		charger-type = "usb-sdp";
> -		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
> -		charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
> -
> -		charge-current-limit-gpios = <&gpioA 11 GPIO_ACTIVE_HIGH>, <&gpioA 12 GPIO_ACTIVE_HIGH>;
> -		charge-current-limit-mapping = <2500000 0x00>, <700000 0x01>, <0 0x02>;
> -	};
> -
> -	battery {
> -		power-supplies = <&usb_charger>;
> -	};
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> new file mode 100644
> index 000000000000..14fb3e54f861
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/gpio-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: simple battery chargers only communicating through GPIOs
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |

Can drop '|' if formatting is not important.

> +  This binding is for all chargers, which are working more
> +  or less autonomously, only providing some status GPIOs
> +  and possibly some GPIOs for limited control over the
> +  charging process.
> +
> +properties:
> +  compatible:
> +    const: gpio-charger
> +
> +  charger-type:
> +    oneOf:
> +      - const: unknown
> +      - const: battery
> +      - const: ups
> +      - const: mains
> +      - const: usb-sdp                   # USB standard downstream port
> +      - const: usb-dcp                   # USB dedicated charging port
> +      - const: usb-cdp                   # USB charging downstream port
> +      - const: usb-aca                   # USB accessory charger adapter

Use enum rather than oneOf+const

Should have a description too.

> +
> +  gpios:
> +    maxItems: 1
> +    description: GPIO indicating the charger presence
> +
> +  charge-status-gpios:
> +    maxItems: 1
> +    description: GPIO indicating the charging status
> +
> +  charge-current-limit-gpios:
> +    minItems: 1
> +    maxItems: 32
> +    description: GPIOs used for current limiting
> +
> +  charge-current-limit-mapping:
> +    description: List of touples with current in uA and a GPIO bitmap (in
> +      this order). The GPIOs are encoded in the same order as specified in
> +      charge-current-limit-gpios. The touples must be provided in descending
> +      order of the current limit.
> +    $ref: "/meta-schemas/cell.yaml#array"

That's a first... A meta-schema is what checks this document. Not what 
you want. Should be like this:

$ref: /schemas/types.yaml#/definitions/uint32-matrix
items:
  items:
    - description: Current limit in uA
    - description: Encoded GPIO setting...

I guess there's not any more constraints we can add here.

> +
> +required:
> +  - compatible

blank line

At least 1 of the gpio properties is required, right? Can be expressed 
with required entries under a oneOf or anyOf.

> +additionalProperties: false
> +
> +dependencies:
> +  charge-current-limit-gpios: [ charge-current-limit-mapping ]
> +  charge-current-limit-mapping: [ charge-current-limit-gpios ]
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    charger {
> +      compatible = "gpio-charger";
> +      charger-type = "usb-sdp";
> +
> +      gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
> +      charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
> +
> +      charge-current-limit-gpios = <&gpioA 11 GPIO_ACTIVE_HIGH>,
> +                                   <&gpioA 12 GPIO_ACTIVE_HIGH>;
> +      charge-current-limit-mapping = <2500000 0x00>, <700000 0x01>, <0 0x02>;
> +    };
> -- 
> 2.26.2
> 
