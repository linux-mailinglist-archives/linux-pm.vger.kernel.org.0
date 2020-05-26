Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B61E3056
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 22:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404052AbgEZUxP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 16:53:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38388 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404010AbgEZUxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 16:53:15 -0400
Received: by mail-io1-f66.google.com with SMTP id d7so23643673ioq.5;
        Tue, 26 May 2020 13:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qjmwyia8m0idHo7LSD/jUZIkRzjqZXNiiim0DOiQRZg=;
        b=uCLCeBuVoVtMJCluG3aKXYME8nFsxbV4h2SgwvaB1I30SckKZ+qpV/NT/3QNEBMPw9
         OK9FOJ2yM+m9/FbxilerpSzWDGlnPD6kRiqv6USCbqJNBj7dzatxsbHjI/jfx1uOejqn
         Oblr9+im0nVP/UUB8NhMicdmpKakhuPTN+A06G61IGPU+rjtUOIZShrE6oF+UV0cL9o6
         eCqKM7megByJC1ny5b1w0Yp18Euxpb/i+be3cEB8EOh7MGzjAVNHRCjX0GGmJPmhnC6V
         3XPRlmEhQbEvCSD7B0KLYVAQxI+azi4bF9l2cqUhCuC4AD7r3CGnM2DvSOXCwqt8s5oj
         WVLA==
X-Gm-Message-State: AOAM531p/och7esOkCa3TFbMt6SIAycy2/Axpj+Lr+zVp5KK63DyNXI9
        MRBM1G4fQcSvuf1sTllnXQ==
X-Google-Smtp-Source: ABdhPJwDNco5Muj0tbO/Tcz6zkkPMhylBcvTg1YWB0BRz9M/iDI5+3oQwITya3FlxOlrjEMqsrnFjQ==
X-Received: by 2002:a5d:8e0d:: with SMTP id e13mr18640719iod.132.1590526393661;
        Tue, 26 May 2020 13:53:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t17sm545168ilm.7.2020.05.26.13.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:53:12 -0700 (PDT)
Received: (nullmailer pid 351420 invoked by uid 1000);
        Tue, 26 May 2020 20:53:12 -0000
Date:   Tue, 26 May 2020 14:53:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sre@kernel.org, sspatil@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: Re: [PATCH v8 2/3] Add the bindings for the bq25150 and bq25155
 500mA charging ICs from Texas Instruments.
Message-ID: <20200526205312.GA337476@bogus>
References: <20200520122027.31320-1-dmurphy@ti.com>
 <20200520122027.31320-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520122027.31320-3-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 07:20:26AM -0500, Dan Murphy wrote:
> From: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> 
> The BQ2515X family of devices are highly integrated battery management
> ICs that integrate the most common functions for wearable devices
> namely a charger, an output voltage rail, ADC for battery and system
> monitoring, and a push-button controller.
> 
> Datasheets:
> http://www.ti.com/lit/ds/symlink/bq25150.pdf
> http://www.ti.com/lit/ds/symlink/bq25155.pdf
> 
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  .../bindings/power/supply/bq2515x.yaml        | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> new file mode 100644
> index 000000000000..83487957fc8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq2515x.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI bq2515x 500-mA Linear charger family
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +  - Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> +
> +description: |
> +  The BQ2515x family is a highly integrated battery charge management IC that
> +  integrates the most common functions for wearable devices, namely a charger,
> +  an output voltage rail, ADC for battery and system monitoring, and
> +  push-button controller.
> +
> +  Specifications about the charger can be found at:
> +    http://www.ti.com/lit/ds/symlink/bq25150.pdf
> +    http://www.ti.com/lit/ds/symlink/bq25155.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq25150
> +      - ti,bq25155
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the charger.
> +
> +  ac-detect-gpios:
> +    description: |
> +       GPIO used for connecting the bq2515x device PG (AC Detect)
> +       pin.  This pin should be used if possible as this is the
> +       recommended way to obtain the charger's input PG state.
> +       If this pin is not specified a software-based approach for PG
> +       detection is used.

How many? (maxItems: 1)

Same for the rest of the GPIOs.

> +
> +  reset-gpios:
> +    description: |
> +       GPIO used for hardware reset.
> +
> +  low-power-gpios:
> +    description: |
> +       GPIO used for low power mode of IC.

powerdown-gpios is the somewhat standard name for this.

> +
> +  charge-enable-gpios:
> +    description: |
> +       GPIO used to turn on and off charging.
> +

> +  constant-charge-current-max-microamp:
> +    description: |
> +       Maximum charging current in micro Amps.
> +    minimum: 50000
> +    maximum: 600000
> +
> +  precharge-current-max-microamp:
> +    description: |
> +       Maximum precharging current in micro Amps.
> +    minimum: 1250
> +    maximum: 77500
> +
> +  input-current-limit-microamp:
> +    description: |
> +       Maximum input current in micro Amps.
> +    minimum: 50000
> +    maximum: 500000
> +
> +  constant-charge-voltage-max-microvolt:
> +    description: |
> +       Maximum charging voltage in micro volts.
> +    minimum: 3600000
> +    maximum: 4600000

Other than input-current-limit-microamp, none of these should be part of 
this schema as they apply to the battery node. There's not really a way 
for us to express something like this.

> +
> +required:
> +  - compatible
> +  - reg

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    bat: battery {
> +      compatible = "simple-battery";
> +      constant-charge-current-max-microamp = <50000>;
> +      precharge-current-microamp = <2500>;
> +      constant-charge-voltage-max-microvolt = <4000000>;
> +    };
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      bq25150: charger@6b {
> +        compatible = "ti,bq25150";
> +        reg = <0x6b>;
> +        monitored-battery = <&bat>;

Not documented.

> +        input-current-limit-microamp = <100000>;
> +
> +        ac-detect-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +        reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
> +        low-power-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +        charge-enable-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +      };
> +    };
> -- 
> 2.26.2
> 
