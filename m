Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B853F176693
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 23:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCBWHV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 17:07:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36124 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 17:07:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id t24so905972oij.3;
        Mon, 02 Mar 2020 14:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gaUz4RmK015uYG8BySpYbmsbCNuhkAc0ZAKHDWN8k64=;
        b=gSqRy9dfKLL/4+a3ER5b0kwLvJrdsLWj8C27jZ8f6IeoifVGNN6IxQZpo5NcJ7Nabo
         qy2qcKKiMIQr2WjIkLaiTFf5DeuKUM/sT6BTy4FQAvjTPDpIZsrPs03Xa+0fUmjRDJDe
         s2pnQFQ98NLI8w2pAnqCZNjYqTz0MTmSfTMmF9wj9cRdsTG6i6MwcEOIx03p6huUZtdr
         PgsizelI4flFHktqwmjZNYxU88hxFEzlaU7mmH4uEH7hnr8mt/hBo+CM42Cknaw5B0bs
         odFQrPWywsAAuR2qXkcdijnzS0Cb6ZFuuzytlUfT5gTdokfPgBBunCH54C6SIL+eZf3O
         naBA==
X-Gm-Message-State: ANhLgQ1AZkiQQnrRrqvM9tlAPNp3rOkCJc/LY1uHmTzbbs5nVqJ40BeO
        VxEtTN9FA93u3DojCefSsg==
X-Google-Smtp-Source: ADFU+vvUuYVypGT7Of+XmcvliyS4jcdOlyo88WbR4BiyU6iXmlR36utGbseh6RZ+0ug7eW8zPn/lWA==
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr358069oif.131.1583186839487;
        Mon, 02 Mar 2020 14:07:19 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a14sm7066619otr.54.2020.03.02.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:07:18 -0800 (PST)
Received: (nullmailer pid 15846 invoked by uid 1000);
        Mon, 02 Mar 2020 22:07:17 -0000
Date:   Mon, 2 Mar 2020 16:07:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 2/9] dt_bindings: ROHM BD99954 Charger
Message-ID: <20200302220717.GA6981@bogus>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
 <7aa7f2646077228924d596edbc4d076a787d9312.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa7f2646077228924d596edbc4d076a787d9312.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 10:52:32AM +0200, Matti Vaittinen wrote:
> The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
> secondary battery. Intended to be used in space-constraint equipment such
> as Low profile Notebook PC, Tablets and other applications. BD99954
> provides a Dual-source Battery Charger, two port BC1.2 detection and a
> Battery Monitor.
> 
> Document the DT bindings for BD99954
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Changes from rfc-v3:
>   - uncomment multipleOf
>   - add address and size cells properties to example I2C node
> 
>  .../bindings/power/supply/rohm,bd9995x.yaml   | 155 ++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
> new file mode 100644
> index 000000000000..547403773ec5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/rohm,bd9995x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD99954 Battery charger driver

Bindings are for h/w devices, not drivers.

> +
> +maintainers:
> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Markus Laine <markus.laine@fi.rohmeurope.com>
> +  - Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
> +
> +description: |
> +  The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
> +  secondary battery intended to be used in space-constraint equipment such
> +  as Low profile Notebook PC, Tablets and other applications. BD99954
> +  provides a Dual-source Battery Charger, two port BC1.2 detection and a
> +  Battery Monitor.
> +
> +
> +properties:
> +  compatible:
> +    const: rohm,bd9995x-charger

You can drop '-charger' if the whole chip is a charger IC. If it is not, 
then your example is wrong.

You use BD99954 elsewhere, use that here too. We don't do wildcards in 
compatible strings.

> +#
> +#    The battery charging profile of BD99954.
> +#
> +#    Curve (1) represents charging current.
> +#    Curve (2) represents battery voltage.
> +#
> +#    The BD99954 data sheet divides charging to three phases.
> +#    a) Trickle-charge with constant current (8).
> +#    b) pre-charge with constant current (6)
> +#    c) fast-charge with:
> +#       First a constant current (5) phase (CC)
> +#       Then constant voltage (CV) phase (after the battery voltage has reached
> +#       target level - until charging current has dropped to termination
> +#       level (7)
> +#
> +#     V ^                                                        ^ I
> +#       .                                                        .
> +#       .                                                        .
> +# (4)- -.- - - - - - - - - - - - - -  +++++++++++++++++++++++++++.
> +#       .                            /                           .
> +#       .                     ++++++/++ - - - - - - - - - - - - -.- - (5)
> +#       .                     +    /  +                          .
> +#       .                     +   -   --                         .
> +#       .                     +  -     +                         .
> +#       .                     +.-      -:                        .
> +#       .                    .+         +`                       .
> +#       .                  .- +       | `/                       .
> +#       .               .."   +          .:                      .
> +#       .             -"      +           --                     .
> +#       .    (2)  ..."        +       |    :-                    .
> +#       .    ...""            +             -:                   .
> +# (3)- -.-.""- - - - -+++++++++ - - - - - - -.:- - - - - - - - - .- - (6)
> +#       .             +                       `:.                .
> +#       .             +               |         -:               .
> +#       .             +                           -:             .
> +#       .             +                             ..           .
> +#       .   (1)       +               |               "+++- - - -.- - (7)
> +#       -++++++++++++++- - - - - - - - - - - - - - - - - + - - - .- - (8)
> +#       .                                                +       -
> +#       -------------------------------------------------+++++++++-->
> +#       |             |       |   CC   |      CV         |
> +#       | --trickle-- | -pre- | ---------fast----------- |
> +#
> +#   The charger uses the following battery properties
> +# - trickle-charge-current-microamp:
> +#     Current used at trickle-charge phase (8 in above chart)
> +#     minimum: 64000
> +#     maximum: 1024000
> +#     multipleOf: 64000

Why is all of this commented out still?

> +# - precharge-current-microamp:
> +#     Current used at pre-charge phase (6 in above chart)
> +#     minimum: 64000
> +#     maximum: 1024000
> +#     multipleOf: 64000
> +# - constant-charge-current-max-microamp
> +#     Current used at fast charge constant current phase (5 in above chart)
> +#     minimum: 64000
> +#     maximum: 1024000
> +#     multipleOf: 64000
> +# - constant-charge-voltage-max-microvolt
> +#     The constant voltage used in fast charging phase (4 in above chart)
> +#     minimum: 2560000
> +#     maximum: 19200000
> +#     multipleOf: 16000
> +# - precharge-upper-limit-microvolt
> +#     charging mode is changed from trickle charging to pre-charging
> +#     when battery voltage exceeds this limit voltage (3 in above chart)
> +#     minimum: 2048000
> +#     maximum: 19200000
> +#     multipleOf: 64000
> +# - re-charge-voltage-microvolt
> +#     minimum: 2560000
> +#     maximum: 19200000
> +#     multipleOf: 16000
> +#     re-charging is automatically started when battry has been discharging
> +#     to the point where the battery voltage drops below this limit
> +# - over-voltage-threshold-microvolt
> +#     battery is expected to be faulty if battery voltage exceeds this limit.
> +#     Charger will then enter to a "battery faulty" -state
> +#     minimum: 2560000
> +#     maximum: 19200000
> +#     multipleOf: 16000
> +# - charge-term-current-microamp
> +#     minimum: 0
> +#     maximum: 1024000
> +#     multipleOf: 64000
> +#     a charge cycle terminates when the battery voltage is above recharge
> +#     threshold, and the current is below this setting (7 in above chart)
> +#   See also Documentation/devicetree/bindings/power/supply/battery.txt
> +
> +  monitored-battery:
> +    description:
> +      phandle of battery characteristics devicetree node
> +
> +  rohm,vsys-regulation-microvolt:
> +    description: system specific lower limit for system voltage.
> +    minimum: 2560000
> +    maximum: 19200000
> +    multipleOf: 64000
> +
> +  rohm,vbus-input-current-limit-microamp:
> +    description: system specific VBUS input current limit (in microamps).
> +    minimum: 32000
> +    maximum: 16352000
> +    multipleOf: 32000
> +
> +  rohm,vcc-input-current-limit-microamp:
> +    description: system specific VCC/VACP input current limit (in microamps).
> +    minimum: 32000
> +    maximum: 16352000
> +    multipleOf: 32000
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        charger@9 {
> +            compatible = "rohm,bd9995x-charger";
> +            monitored-battery = <&battery>;
> +            reg = <0x9>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <29 8>;
> +            rohm,vsys-regulation-microvolt = <8960000>;
> +            rohm,vbus-input-current-limit-microamp = <1472000>;
> +            rohm,vcc-input-current-limit-microamp = <1472000>;
> +        };
> +    };
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
