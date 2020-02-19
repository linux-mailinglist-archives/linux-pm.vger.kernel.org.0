Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8461E164770
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 15:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBSOwc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 09:52:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34961 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgBSOwc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 09:52:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id r16so395163otd.2;
        Wed, 19 Feb 2020 06:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QQd+mLOG3Djgf9pAJU1+5MgOvviH0euD+JIlNG66B4U=;
        b=UaxOYRYAOVLA5URhT5swdnX0tTISSjvtmo46PBJUm461PJPLlctco5Ojgu1Kh2cM+r
         TDJpPW5tc+YOv6POJAWUr7X5IyCh2LlLxG98iumRSokKqa0sI0TfHi9Ud9n7KhY5IGT1
         v2Y0x0P5Xst2Q3HdEiW1i9ZLKUwnpBX4vE6WtgSsWKLi/gYeJlUnVY9JFDXnAsCUOR70
         dKi3pokSEw5oiWVcyhv4TuXZMzCPD7tb2qNRjV1vvtuQtmghiPbmXqLm+YwSlSmnD8X0
         Jjgl36FzF06fQHRUzqsYb9glP8YRy41zqUVmi63pEMj5oPtjDqI1LGIJJOBAP+6kJIUT
         mubg==
X-Gm-Message-State: APjAAAU467FTtLAwGDCqtZz+JDwn8ZrLzS1nS50o6A4I4EoSshtsW6ei
        NY1i2OEdAxG0n2SjKGe6Vg==
X-Google-Smtp-Source: APXvYqxLc1uqkSdx5A61GndakpE7hENl4nGHvYyySsvT2z371AUhrfW4GKZzZgnB1JAXwHj26eqB9w==
X-Received: by 2002:a05:6830:22ca:: with SMTP id q10mr21274221otc.280.1582123951275;
        Wed, 19 Feb 2020 06:52:31 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r17sm691926otq.70.2020.02.19.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 06:52:28 -0800 (PST)
Received: (nullmailer pid 4462 invoked by uid 1000);
        Wed, 19 Feb 2020 14:52:27 -0000
Date:   Wed, 19 Feb 2020 08:52:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v3 1/4] dt-bindings: thermal: k3: Add VTM bindings
 documentation
Message-ID: <20200219145227.GA1317@bogus>
References: <20200219074314.22829-1-j-keerthy@ti.com>
 <20200219074314.22829-2-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219074314.22829-2-j-keerthy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 19, 2020 at 01:13:11PM +0530, Keerthy wrote:
> Add VTM bindings documentation. In the Voltage Thermal
> Management Module(VTM), K3 AM654 supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v3:
> 
>   * Fixed errors seen with:
>     dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> 
>  .../bindings/thermal/ti,am654-thermal.yaml    | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> new file mode 100644
> index 000000000000..b6dc95c3acab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/ti,am654-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments AM654 VTM (DTS) binding
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am654-vtm
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +    description: phandle to the associated power domain

No need to redefine a standard property description.

> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +required:
> +  - "#thermal-sensor-cells"
> +  - compatible
> +  - reg
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    vtm: wkup_vtm0@42050000 {

thermal-sensor@...

Use generic node names and don't use '_' in node names.

> +        compatible = "ti,am654-vtm";
> +        reg = <0x0 0x42050000 0x0 0x25c>;
> +        power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> +        #thermal-sensor-cells = <1>;
> +    };
> +
> +    mpu0_thermal: mpu0_thermal {
> +        polling-delay-passive = <250>; /* milliseconds */
> +        polling-delay = <500>; /* milliseconds */
> +        thermal-sensors = <&vtm0 0>;
> +
> +        trips {
> +                mpu0_crit: mpu0_crit {
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
