Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0271E8B28
	for <lists+linux-pm@lfdr.de>; Sat, 30 May 2020 00:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgE2WSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 18:18:50 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43299 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2WSt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 18:18:49 -0400
Received: by mail-il1-f193.google.com with SMTP id l20so3981526ilj.10;
        Fri, 29 May 2020 15:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xP9ZdCTR/EdOYCoxJDYWH1I3j59aBXgMz8ABRaYokf4=;
        b=EnkUCAliTt4+7W7okqrM6yy3mTWuoHxpRfFOilHrU3jHIf63Uvu1u8BTDISFStnmwF
         SGYXGd5N7sdkOe03GoHWQKmlFkjM1obp0eu8x5t6b9PtX6Nk/xlDltM8qwVZxpAzjrVL
         8Or/+GoDfeSF/oCVcGkxitFghBngtxCIUxzanlUGpT8cdS5l9jzRXywMAdrB/fp9cx2j
         MZOiJaq+SlOK2rhl7q9AHAR583MukwHIKBSiSsCau+lZPyWvUb1L8L+/84SMhYE45Fpi
         asOQuItErwfdeyDptmpQq/3emuQttvq+rFu19xPrW/Z57SFejJgyjZ0UXhQj+jeu8mjg
         lbqQ==
X-Gm-Message-State: AOAM5317sVZIEiOFaRzIZo4woUtgTINMSd9hecAMos39Zk1rEtm3MWZv
        JVkFsoTgJiMa2Z5QXb9U7A==
X-Google-Smtp-Source: ABdhPJxFrWwW9yCM3emL/I68ZY9eupWOO0auBUElisbWJWq+swH93cjkz+RAJZLCvKZKkZwNUza8eQ==
X-Received: by 2002:a92:d1d0:: with SMTP id u16mr2746809ilg.2.1590790728722;
        Fri, 29 May 2020 15:18:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z4sm4356288iot.24.2020.05.29.15.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 15:18:47 -0700 (PDT)
Received: (nullmailer pid 3089385 invoked by uid 1000);
        Fri, 29 May 2020 22:18:46 -0000
Date:   Fri, 29 May 2020 16:18:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, pali@kernel.org, afd@ti.com, dmurphy@ti.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sspatil@android.com
Subject: Re: [PATCH v12 3/4] dt-bindings: power: Add the bindings for the
 bq2515x family of chargers.
Message-ID: <20200529221846.GA3086777@bogus>
References: <20200528225350.661-1-r-rivera-matos@ti.com>
 <20200528225350.661-4-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528225350.661-4-r-rivera-matos@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 28, 2020 at 05:53:49PM -0500, Ricardo Rivera-Matos wrote:
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
>  .../bindings/power/supply/bq2515x.yaml        | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> new file mode 100644
> index 000000000000..19cb336d581e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
> @@ -0,0 +1,91 @@
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
> +       pin.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO used for hardware reset.
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    description: GPIO used for low power mode of IC.
> +    maxItems: 1
> +
> +  charge-enable-gpios:
> +    description: GPIO used to turn on and off charging.
> +    maxItems: 1
> +
> +  input-current-limit-microamp:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Maximum input current in micro Amps.
> +    minimum: 50000
> +    maximum: 500000
> +
> +  monitored-battery:
> +    $ref: battery.yaml#

This doesn't work. It's saying monitored-battery is a node containing 
all the properties in battery.yaml.

> +
> +required:
> +  - compatible
> +  - reg

How is the battery optional?

> +
> +additionalProperties: false
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
> +        input-current-limit-microamp = <100000>;
> +
> +        ac-detect-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +        reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
> +        powerdown-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +        charge-enable-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +      };
> +    };
> -- 
> 2.26.2
> 
