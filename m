Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68FF4421E2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 21:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhKAUtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 16:49:49 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46833 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhKAUtq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Nov 2021 16:49:46 -0400
Received: by mail-oi1-f176.google.com with SMTP id bd30so7027226oib.13;
        Mon, 01 Nov 2021 13:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bjw0j7Mx1+gCUHPQkiItObMWxExdrxG5rwoBsdrg1Qs=;
        b=w5HrDi0V3LJiE3idmbiHAKi4YmVrzbtithgFCkUSJb4SiFyMxA+iUIZ5NiVXiO2cIQ
         iumYwiIBgX2wq8DcGo6gzZe8gbcFZEgGZ6LtnUwZje8dBWkvt66JSWfiQHm256wpwBbG
         5Mr2UuQ2lhnO24Je4Ux1YotXNrzv7eKsDyTS9DgP64qcEcFqvsmwkDJ+9srbnKaHbUob
         K1373FmF9DHEtFsVush7Aj20RKZLU6phPZYukYtLY5UYmFZyQNRBi0yPCk+vr9eNaPha
         8QuVbWioapRT3b5c2DIBVFwqXtpcesaCRnNwWTnmwHgEw519Iv6mDqgWThTALnYnK0q1
         Z/vQ==
X-Gm-Message-State: AOAM531S2ko5Vv0XrKpsNjrUsosojTc8GrrAXinDgS2DzU3Q+JN1aVEZ
        7RHFdNoLPyTs7kCTGO3FbNO41qR3Ag==
X-Google-Smtp-Source: ABdhPJyyffhPl0qaDKlAt9AR/wfks2LhgDYHRLW/t2QL35e3G5C4F0WbhFfE8/aGAkn0dzN4nI/rTg==
X-Received: by 2002:aca:6c2:: with SMTP id 185mr1207003oig.31.1635799632535;
        Mon, 01 Nov 2021 13:47:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x65sm4343189oix.43.2021.11.01.13.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 13:47:11 -0700 (PDT)
Received: (nullmailer pid 1020841 invoked by uid 1000);
        Mon, 01 Nov 2021 20:47:11 -0000
Date:   Mon, 1 Nov 2021 15:47:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Message-ID: <YYBST6SAR0B9J+gM@robh.at.kernel.org>
References: <20211025180603.22290-1-j-keerthy@ti.com>
 <20211025180603.22290-2-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025180603.22290-2-j-keerthy@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 25, 2021 at 11:36:00PM +0530, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 J72XX supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../bindings/thermal/ti,j72xx-thermal.yaml    | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> new file mode 100644
> index 000000000000..8483c495cb9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/ti,j72xx-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments J72XX VTM (DTS) binding
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,j721e-vtm
> +    oneOf:
> +      - enum:
> +          - ti,j721e-vtm
> +          - ti,j7200-vtm

Not sure what you are trying to say here, but the 'const' with 'oneOf' 
isn't correct. If it is just 1 of either compatible string, you want 
just 'enum' part:

compatible:
  enum:
    - ti,j721e-vtm
    - ti,j7200-vtm

> +
> +  reg:
> +    maxItems: 3

Need to define what each entry is.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - "#thermal-sensor-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    wkup_vtm0: wkup_vtm0@42040000 {
> +        compatible = "ti,j721e-vtm";
> +        reg = <0x42040000 0x350>,
> +            <0x42050000 0x350>,
> +            <0x43000300 0x10>;
> +        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    mpu_thermal: mpu_thermal {
> +        polling-delay-passive = <250>; /* milliseconds */
> +        polling-delay = <500>; /* milliseconds */
> +        thermal-sensors = <&wkup_vtm0 0>;
> +
> +        trips {
> +                mpu_crit: mpu_crit {
> +                        temperature = <125000>; /* milliCelsius */
> +                        hysteresis = <2000>; /* milliCelsius */
> +                        type = "critical";
> +                };
> +        };
> +    };
> +...
> -- 
> 2.17.1
> 
> 
