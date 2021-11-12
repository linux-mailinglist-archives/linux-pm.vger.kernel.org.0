Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49D44EDA7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 21:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhKLUCt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 15:02:49 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36449 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbhKLUCt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 15:02:49 -0500
Received: by mail-ot1-f51.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so15507142otl.3;
        Fri, 12 Nov 2021 11:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x/9G41UdYRtkiB0ZIc4zt/rdnv8hPdO42CGomcHng38=;
        b=JHl4G57Zxes2XxmQtsaLvLSnbkdyvaSfSb9VbE0uM8a7chtuidIl42ggAgki5q9dXf
         bUZNRZzxNfEb0ZFcLLAjJYeMSRt+65FBOY1vm6vqYY9X8JABDD+KJqUy18wiehVVUt2g
         QxeT8XK6C518NtVsaS0WmEfPipOFyzcu8FeHiEecrblMFsDH5W8w0cdxqTStwSRgjQJr
         PH/5n+selXs4jbnLWQJ128T3VoUgRyAo1TVBdi99oyK52YtxRpeG7CM3jutC3gx2S4XX
         qRS+rFTqfMK2Xm5AGFEdmIi6A7xP2WPNQRxT1Myf4FrdNejDVGAC5gREaS75OBlRIooz
         3Xlg==
X-Gm-Message-State: AOAM532wiqGgjSJW6fu3cYOarywwpV/BklojJ7494jWFkiNLcGxrxqpx
        We+uwpnvrvw1eAr3RgeUWw==
X-Google-Smtp-Source: ABdhPJw6g4cjPq8+Ep/5pUuf4Rr9a3W5h7wiZ3ytYUDEaWqrx3nts/iHa6wu0IZ5k94/FazXx6u/6A==
X-Received: by 2002:a9d:5190:: with SMTP id y16mr14765619otg.364.1636747197583;
        Fri, 12 Nov 2021 11:59:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n1sm1241376ooi.27.2021.11.12.11.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 11:59:57 -0800 (PST)
Received: (nullmailer pid 3271110 invoked by uid 1000);
        Fri, 12 Nov 2021 19:59:56 -0000
Date:   Fri, 12 Nov 2021 13:59:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Message-ID: <YY7HvCyJ90Ge8mr7@robh.at.kernel.org>
References: <20211103091924.32742-1-j-keerthy@ti.com>
 <20211103091924.32742-2-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103091924.32742-2-j-keerthy@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 03, 2021 at 02:49:21PM +0530, Keerthy wrote:
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

Again, this isn't correct. In C like logic, it is saying compatible is 
(ti,j721e-vtm && (ti,j721e-vtm || ti,j7200-vtm)) which is just 
'ti,j721e-vtm'. I think you want just the 'enum'.

> +
> +  reg:
> +    maxItems: 3

What is each entry?

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

thermal-sensor@...

> +        compatible = "ti,j721e-vtm";
> +        reg = <0x42040000 0x350>,
> +            <0x42050000 0x350>,
> +            <0x43000300 0x10>;
> +        power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    mpu_thermal: mpu_thermal {

mpu-thermal

> +        polling-delay-passive = <250>; /* milliseconds */
> +        polling-delay = <500>; /* milliseconds */
> +        thermal-sensors = <&wkup_vtm0 0>;
> +
> +        trips {
> +                mpu_crit: mpu_crit {

mpu-crit

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
