Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D801B14A6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDTSfV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 14:35:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44794 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgDTSfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 14:35:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id a2so5085626oia.11;
        Mon, 20 Apr 2020 11:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R4OQ//22u2MPOmZHKyicGJvmvsIaQtYSXsu+wdZNuM4=;
        b=QPdqckdskbRCogJpNcYplhwYEyeqNleapgNp2sift0yoLXOFp6lH4FbM9+xuJpOJtd
         41NdEBQuzI+XjVgkbmsMAaqN/z4X+j4UX8SRHQ7SKynz1Ui+NdjKqn/9XTkpFuOQelyX
         tqGXT18go9wKhA18QrTL0eIOKJjKX570hspYWofReMtRyoxK0UKNnaenaxkWf8np2ki5
         qdg9eKF3h/ufT+0VtbK3L9AwCKK5wQId+axcp+MwYwEEDKt5+MFqksCWEwFHVHAAOO66
         ryLtajfixPIMpbFaceWW0qnLlt810pkGaO/tBpENRTgl1ysvVSdf6OIrOHPqWk0KGrrd
         8mFg==
X-Gm-Message-State: AGi0PuY9OwHjBZDYXNL4Wwq3xcw4+4gV1jMFogsBfhgQieU0saVdAafJ
        /iL+Jo1QLZQyEGgrwubGTA==
X-Google-Smtp-Source: APiQypI5iWrU/MsQnhldGps2oxwvsnjbS3ZoaH/XAT2+pSAztESGSzhH48A1n6XI4AszMbeiLRaqlg==
X-Received: by 2002:aca:dc08:: with SMTP id t8mr521470oig.135.1587407719248;
        Mon, 20 Apr 2020 11:35:19 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q18sm100760otl.65.2020.04.20.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:35:18 -0700 (PDT)
Received: (nullmailer pid 10765 invoked by uid 1000);
        Mon, 20 Apr 2020 18:35:12 -0000
Date:   Mon, 20 Apr 2020 13:35:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] dt-bindings: thermal: Convert i.MX to json-schema
Message-ID: <20200420183512.GA5483@bogus>
References: <1586480844-19227-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586480844-19227-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 10, 2020 at 09:07:24AM +0800, Anson Huang wrote:
> Convert the i.MX thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- make clock property optional.
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    | 61 --------------
>  .../devicetree/bindings/thermal/imx-thermal.yaml   | 96 ++++++++++++++++++++++
>  2 files changed, 96 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> deleted file mode 100644
> index 823e417..0000000
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -* Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
> -
> -Required properties:
> -- compatible : must be one of following:
> -  - "fsl,imx6q-tempmon" for i.MX6Q,
> -  - "fsl,imx6sx-tempmon" for i.MX6SX,
> -  - "fsl,imx7d-tempmon" for i.MX7S/D.
> -- interrupts : the interrupt output of the controller:
> -  i.MX6Q has one IRQ which will be triggered when temperature is higher than high threshold,
> -  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
> -  when temperature is below than low threshold, IRQ_LOW will be triggered, when temperature
> -  is higher than panic threshold, system will auto reboot by SRC module.
> -- fsl,tempmon : phandle pointer to system controller that contains TEMPMON
> -  control registers, e.g. ANATOP on imx6q.
> -- nvmem-cells: A phandle to the calibration cells provided by ocotp.
> -- nvmem-cell-names: Should be "calib", "temp_grade".
> -
> -Deprecated properties:
> -- fsl,tempmon-data : phandle pointer to fuse controller that contains TEMPMON
> -  calibration data, e.g. OCOTP on imx6q.  The details about calibration data
> -  can be found in SoC Reference Manual.
> -
> -Direct access to OCOTP via fsl,tempmon-data is incorrect on some newer chips
> -because it does not handle OCOTP clock requirements.
> -
> -Optional properties:
> -- clocks : thermal sensor's clock source.
> -
> -Example:
> -ocotp: ocotp@21bc000 {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	compatible = "fsl,imx6sx-ocotp", "syscon";
> -	reg = <0x021bc000 0x4000>;
> -	clocks = <&clks IMX6SX_CLK_OCOTP>;
> -
> -	tempmon_calib: calib@38 {
> -		reg = <0x38 4>;
> -	};
> -
> -	tempmon_temp_grade: temp-grade@20 {
> -		reg = <0x20 4>;
> -	};
> -};
> -
> -tempmon: tempmon {
> -	compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
> -	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> -	fsl,tempmon = <&anatop>;
> -	nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> -	nvmem-cell-names = "calib", "temp_grade";
> -	clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> -};
> -
> -Legacy method (Deprecated):
> -tempmon {
> -	compatible = "fsl,imx6q-tempmon";
> -	fsl,tempmon = <&anatop>;
> -	fsl,tempmon-data = <&ocotp>;
> -	clocks = <&clks 172>;
> -};
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> new file mode 100644
> index 0000000..193c7e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/imx-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX Thermal Binding
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx6q-tempmon
> +              - fsl,imx6sx-tempmon
> +              - fsl,imx7d-tempmon
> +
> +  interrupts:
> +    description: |
> +      The interrupt output of the controller, the IRQ will be triggered
> +      when temperature is higher than high threshold.
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    description: |
> +      Phandle to the calibration cells provided by ocotp for calibration
> +      data and temperature grade.
> +    maxItems: 2
> +
> +  nvmem-cell-names:
> +    maxItems: 2
> +    items:
> +      - const: calib
> +      - const: temp_grade
> +
> +  fsl,tempmon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Phandle pointer to system controller that contains TEMPMON control
> +      registers, e.g. ANATOP on imx6q.

Really, this should have been a child of the system controller. Not too 
late to do that, but you'd need to keep this for compatibility.

> +
> +  fsl,tempmon-data:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Deprecated property, phandle pointer to fuse controller that contains
> +      TEMPMON calibration data, e.g. OCOTP on imx6q. The details about
> +      calibration data can be found in SoC Reference Manual.

Use 'deprecated: true' for deprecated properties.

> +
> +  clocks:
> +    description: |
> +      Thermal sensor's clock source, it is optional.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - fsl,tempmon
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6sx-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ocotp: ocotp@21bc000 {
> +         #address-cells = <1>;
> +         #size-cells = <1>;
> +         compatible = "fsl,imx6sx-ocotp", "syscon";
> +         reg = <0x021bc000 0x4000>;
> +         clocks = <&clks IMX6SX_CLK_OCOTP>;
> +
> +         tempmon_calib: calib@38 {
> +             reg = <0x38 4>;
> +         };
> +
> +         tempmon_temp_grade: temp-grade@20 {
> +             reg = <0x20 4>;
> +         };
> +    };
> +
> +    tempmon: tempmon {
> +         compatible = "fsl,imx6sx-tempmon";
> +         interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +         fsl,tempmon = <&anatop>;
> +         nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> +         nvmem-cell-names = "calib", "temp_grade";
> +         clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 
