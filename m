Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC3234DA4
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGaWkb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 18:40:31 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43376 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWka (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 18:40:30 -0400
Received: by mail-il1-f196.google.com with SMTP id y18so18188358ilp.10;
        Fri, 31 Jul 2020 15:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfW9s2DGUedr2mUFf7i55ndR1OuYzXAhoJ0w+EZ2kis=;
        b=im4nv6tYwP1mMyXBPqVrs1BBmlWOYzz+RRVg1AkoNNyEQ0XrnPa2cOwjSaRT728IgL
         Eq4RCGAtZtWB39s4L22rM24sXssBBqMM0xdxRwGvStUyQI8i2sDMyQsdusmxPfT3PJh8
         azlQ2z1KRCfMX+UuV6nJjNgGLlu0BXXtrNTzwLETVyKsIP/Nk4UboMuWRn+8eMulDcQH
         gE+8On0L0tJubKNlpIG5104y2CAEzJRsZF6o/VJd5Wr+uPpHu3qECk/i4ar0xlZUVVwR
         s/Tj2aDA2UAse6aJI2xLHUAAYwh0sc9A0SPfJo0MTAcM4ZRj3ais6JwKYOK1kueFydQV
         sENA==
X-Gm-Message-State: AOAM533Eitjmdzc3vRdIbq40m2CP6qZbDKCOwnNDuLe4Y/p95RP0UU8J
        +Uz5RgkKjLWXZjBak9Le9w==
X-Google-Smtp-Source: ABdhPJz6JvYVALKdg2VfBfWJh0CybxGekwW/qKcCum31wkZgSbPinffbdp+6olAeka8X9SswHlgntw==
X-Received: by 2002:a92:150d:: with SMTP id v13mr5738888ilk.93.1596235229311;
        Fri, 31 Jul 2020 15:40:29 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b2sm5569581ilf.0.2020.07.31.15.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:40:28 -0700 (PDT)
Received: (nullmailer pid 938876 invoked by uid 1000);
        Fri, 31 Jul 2020 22:40:27 -0000
Date:   Fri, 31 Jul 2020 16:40:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sre@kernel.org, devicetree@vger.kernel.org, r-rivera-matos@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: Add the bq25790 dt bindings
Message-ID: <20200731224027.GA923778@bogus>
References: <20200730145834.29227-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730145834.29227-1-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 09:58:33AM -0500, Dan Murphy wrote:
> Add the bindings for the bq25790.
> 
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/bq25790.yaml        | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq25790.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25790.yaml b/Documentation/devicetree/bindings/power/supply/bq25790.yaml
> new file mode 100644
> index 000000000000..97dd539c1625
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq25790.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq25790.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI BQ25790 Switch Mode Buck-Boost Charger
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  BQ25790 is a highly integrated switch-mode buck-boost charger for 1-4 cell
> +  Li-ion batteries and Li-polymer batteries. The device charges a battery from a
> +  wide range of input sources including legacy USB adapters to high voltage USB
> +  PD adapters and traditional barrel adapters.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq25790
> +      - ti,bq25792
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,watchdog-timer:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Watchdog timer in milli seconds. 0 (default) disables the watchdog.

Add a standard unit suffix and you can drop the type. And maybe 
s/timer/timeout/ would be a bit clearer.

Also:

default: 0

> +    minimum: 0
> +    maximum: 160000
> +    enum: [ 0, 500, 1000, 2000, 20000, 40000, 80000, 160000]
> +
> +  input-voltage-limit-microvolt:
> +    description: |
> +      Minimum input voltage limit in micro volts with a 100000 micro volt step.
> +    minimum: 3600000
> +    maximum: 22000000
> +
> +  input-current-limit-microamp:
> +    description: |
> +      Maximum input current limit in micro amps with a 100000 micro amp step.
> +    minimum: 100000
> +    maximum: 3300000
> +
> +  monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the battery node being monitored
> +
> +required:
> +  - compatible
> +  - reg
> +  - monitored-battery

Add:

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    bat: battery {
> +      compatible = "simple-battery";
> +      constant-charge-current-max-microamp = <2000000>;
> +      constant-charge-voltage-max-microvolt = <4200000>;
> +      precharge-current-microamp = <160000>;
> +      charge-term-current-microamp = <160000>;
> +    };
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      bq25790: charger@6b {
> +          compatible = "ti,bq25790";
> +          reg = <0x6b>;
> +          interrupt-parent = <&gpio1>;
> +          interrupts = <16 IRQ_TYPE_EDGE_FALLING>;

Not documented.

> +          ti,watchdog-timer = <2000>;
> +          input-current-limit = <3000000>;
> +          input-voltage-limit = <4500000>;

Doesn't match the schema.

> +          monitored-battery = <&bat>;
> +      };
> +    };
> +
> +...
> -- 
> 2.28.0
> 
