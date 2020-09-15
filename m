Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A914269ADE
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 03:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgIOBJ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 21:09:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32817 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgIOBJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 21:09:27 -0400
Received: by mail-io1-f67.google.com with SMTP id r25so2308017ioj.0;
        Mon, 14 Sep 2020 18:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUxGtvaIRUoyqovEVYWusEf+ErNPYsvl3hrLi3RtD/U=;
        b=B3QARGafoc4UVGNa5KuuuOGNTpXpe5WClvL1wRgIYeRu0gr99z/zyeYcHVJPjeWofU
         Hbo75Xo44IdZLnLDy8E99CIdEyR29nWtUG4wNjPs7bnKv2SggIGo6rDeurYDJcBEe5hv
         8XrczIPhYJRgA4XEjBpA1JUVS+1NQF92qr7w0BlMlIBqctngtxFLmiujTJI4uc3O3GZZ
         uErvKwM8lmZtznknW1HiPVZCa/8roEKc9642lYNhRbcLypykqi/SOFHvHJa4UOiFZIv9
         p9mIW5I6JCR+BY7PAmk+js5ELtbyFo3XhTAoApur4wkgpc42kJKYU17c6Jiyjd2DH1/P
         h4Xg==
X-Gm-Message-State: AOAM533mxkMfw39rcN4z2OpIp4D4NycsvBqwCSrsVkblsejiEPw3CrmM
        MWaxSFwg6nccHeuODKd1SQ==
X-Google-Smtp-Source: ABdhPJxLiHjz61DfOBs3dWFIQPtmOLahnEoMRx0JaOoZ3VNzcjZEmyPMmUqbqG6agxIN66M2mOAjag==
X-Received: by 2002:a02:a615:: with SMTP id c21mr15364024jam.106.1600132165659;
        Mon, 14 Sep 2020 18:09:25 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p9sm6877547iov.18.2020.09.14.18.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:09:24 -0700 (PDT)
Received: (nullmailer pid 633962 invoked by uid 1000);
        Tue, 15 Sep 2020 01:09:22 -0000
Date:   Mon, 14 Sep 2020 19:09:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Convert ingenic,battery.txt
 to YAML
Message-ID: <20200915010922.GA629419@bogus>
References: <20200906144726.8852-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906144726.8852-1-contact@artur-rojek.eu>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 06, 2020 at 04:47:25PM +0200, Artur Rojek wrote:
> Convert the textual documentation of Device Tree bindings for the
> Ingenic JZ47xx SoCs battery to YAML.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Changes:
>     v2: move introduction of new compatibles into a separate patch
> 
>  .../bindings/power/supply/ingenic,battery.txt | 31 ----------
>  .../power/supply/ingenic,battery.yaml         | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> deleted file mode 100644
> index 66430bf73815..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -* Ingenic JZ47xx battery bindings
> -
> -Required properties:
> -
> -- compatible: Must be "ingenic,jz4740-battery".
> -- io-channels: phandle and IIO specifier pair to the IIO device.
> -  Format described in iio-bindings.txt.
> -- monitored-battery: phandle to a "simple-battery" compatible node.
> -
> -The "monitored-battery" property must be a phandle to a node using the format
> -described in battery.txt, with the following properties being required:
> -
> -- voltage-min-design-microvolt: Drained battery voltage.
> -- voltage-max-design-microvolt: Fully charged battery voltage.
> -
> -Example:
> -
> -#include <dt-bindings/iio/adc/ingenic,adc.h>
> -
> -simple_battery: battery {
> -	compatible = "simple-battery";
> -	voltage-min-design-microvolt = <3600000>;
> -	voltage-max-design-microvolt = <4200000>;
> -};
> -
> -ingenic_battery {
> -	compatible = "ingenic,jz4740-battery";
> -	io-channels = <&adc INGENIC_ADC_BATTERY>;
> -	io-channel-names = "battery";
> -	monitored-battery = <&simple_battery>;
> -};
> diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> new file mode 100644
> index 000000000000..b4e0275ac63a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019-2020 Artur Rojek
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/ingenic,battery.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Ingenic JZ47xx battery bindings
> +
> +maintainers:
> +  - Artur Rojek <contact@artur-rojek.eu>
> +
> +properties:
> +  compatible:
> +    const: ingenic,jz4740-battery
> +
> +  io-channels:
> +    items:
> +      - description: >
> +          phandle and IIO specifier pair to the IIO device.
> +          See Documentation/devicetree/bindings/iio/iio-bindings.txt for more
> +          details.

No need to redefine common properties. 'maxItems: 1' is sufficient here.

> +
> +  io-channel-names:
> +    const: "battery"

Don't need quotes.

> +
> +  monitored-battery:
> +    items:
> +      - description: >

'monitored-battery' is always a single item. So just need 'description'.

> +          phandle to a "simple-battery" compatible node.
> +
> +          This property must be a phandle to a node using the format described
> +          in battery.txt, with the following properties being required:
> +          - voltage-min-design-microvolt: drained battery voltage,
> +          - voltage-max-design-microvolt: fully charged battery voltage.
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - io-channel-names
> +  - monitored-battery
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/ingenic,adc.h>
> +
> +    simple_battery: battery {
> +            compatible = "simple-battery";
> +            voltage-min-design-microvolt = <3600000>;
> +            voltage-max-design-microvolt = <4200000>;
> +    };
> +
> +    ingenic-battery {
> +            compatible = "ingenic,jz4740-battery";
> +            io-channels = <&adc INGENIC_ADC_BATTERY>;
> +            io-channel-names = "battery";
> +            monitored-battery = <&simple_battery>;
> +    };
> -- 
> 2.28.0
> 
