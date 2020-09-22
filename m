Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49347274C03
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIVWWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 18:22:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34641 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIVWWG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 18:22:06 -0400
Received: by mail-io1-f65.google.com with SMTP id m17so21511612ioo.1;
        Tue, 22 Sep 2020 15:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=87MFqmYXBUfdZIxtJV3tPDjsjNmqgFdian9+4/ug7uQ=;
        b=hCYcPZaH1mQy3I/3KH1KVQkfZflhBdLy9Sms/fbnBreIo1wYbi4mH3elTScQg/9Nfc
         yuPOJ6OQw4wroKsCS7oh8TeV59z6TrijSLRWqsqFHfakLhWDHI9wZhElKsvD7Jd+b5Ek
         cBw0Fk0MKztoi+AR5hp4QP3patCl7/57muYSAu+NDgbQp6LHsHEYljiDzBG14hWt7tUE
         xSDsM4zn+hq/7HM+2HQYIOiN9nQhFweo/GxR+99dei7T/6zZq2wh7IRa4Zn/SuuuNEhB
         +9ISx91lik9mMZG0SyX41mVR3hVYaqkxxJkSlSECwPNdPFmH2zrxv/edXG3nqXRCoRMF
         Hcyg==
X-Gm-Message-State: AOAM531/aRfeNytVovwzEgc/hlSSWYuShyw8GXjvgUpRuJzS/uujKgaE
        Zd3mtWGzs4YTZI2gZ01l2g==
X-Google-Smtp-Source: ABdhPJzcSJs6CEYrqclqDNhkG5AJkK03AOTx3JUa63WyB2L/JfSMR0Tgb6McCUlFw9TeNC6DQQ24MQ==
X-Received: by 2002:a05:6638:c6:: with SMTP id w6mr5931153jao.143.1600813324840;
        Tue, 22 Sep 2020 15:22:04 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m13sm8510599ilj.70.2020.09.22.15.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:22:04 -0700 (PDT)
Received: (nullmailer pid 3363669 invoked by uid 1000);
        Tue, 22 Sep 2020 22:22:03 -0000
Date:   Tue, 22 Sep 2020 16:22:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Add the bq256xx dt bindings
Message-ID: <20200922222203.GA3360459@bogus>
References: <20200910164534.16987-1-r-rivera-matos@ti.com>
 <20200910164534.16987-2-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200910164534.16987-2-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 10, 2020 at 11:45:33AM -0500, Ricardo Rivera-Matos wrote:
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
>  .../bindings/power/supply/bq256xx.yaml        | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> new file mode 100644
> index 000000000000..8cc2242f7df0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> @@ -0,0 +1,97 @@
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
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Watchdog timer in ms. 0 (default) disables the watchdog
> +    minimum: 0
> +    maximum: 160000
> +    enum: [ 0, 40000, 80000, 160000]
> +
> +  input-voltage-limit-microvolt:
> +    description: |
> +       Minimum input voltage limit in µV with a 100000 µV step
> +    minimum: 3900000
> +    maximum: 5400000
> +
> +  input-current-limit-microamp:
> +    description: |
> +       Maximum input current limit in µA with a 100000 µA step
> +    minimum: 100000
> +    maximum: 3200000
> +
> +required:
> +  - compatible
> +  - reg
> +  - monitored-battery

additionalProperties: false

And then fix what breaks in the example.

> +
> +examples:
> +  - |
> +    bat: battery {
> +      compatible = "simple-battery";
> +      constant-charge-current-max-microamp = <2040000>;
> +      constant-charge-voltage-max-microvolt = <4352000>;
> +      precharge-current-microamp = <180000>;
> +      charge-term-current-microamp = <180000>;
> +    };
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +
> +      clock-frequency = <400000>;
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      charger@6b {
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
