Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A011B14C8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 20:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgDTSh2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 14:37:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41153 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgDTSh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 14:37:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so9010561otp.8;
        Mon, 20 Apr 2020 11:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SwEht26LXsrYWXHN9AUzhB2LIZfMy4nj6PiaQR9cyys=;
        b=j7OMx1yXolF7jI3IoToWGl1yee1T4SrQZHPsixHd8fuqyFUY6qJmzETIwv4vNWOh8+
         WLR+gKYrBSI427r34cqNCLKcCa3udcVvDZMid9ZZkSf87qiylmYddJ96MYz77dZtceJI
         WBNXv1QqCxkVnCMNrIuzTm4vl3pzPHwaYn4gPDGmKAa6URbKS7UNJ7qahYwHZY7clUIE
         nxkj8tGi2V6pJ1/72VW1Z7rP1sFaCMnWvlDY/hCKZ985TMELBcskHWpRRNXg2ndAT+eD
         XYJScwJPpLWcwn9N/m9VAED6QmWGFLm7uEt2aGVg7Pk5x+VXvn3Os83UOLs4UXZuW8sn
         LSvA==
X-Gm-Message-State: AGi0PuaPT6xzZto0OTPc2ru3hhY59NPmb0uGHS4iZszhaHfTeNFcb5yI
        GC+RLw8WN7oztazmn46u8Q==
X-Google-Smtp-Source: APiQypITmTVLmCHUT2eoWbm+5j8UVDm4ArOIAfxEx6QVgHNIjF0wocTSMcaN3A1FjSNLuRxTVjRewg==
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr10268404otb.367.1587407846953;
        Mon, 20 Apr 2020 11:37:26 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r21sm106975otg.67.2020.04.20.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:37:26 -0700 (PDT)
Received: (nullmailer pid 13827 invoked by uid 1000);
        Mon, 20 Apr 2020 18:37:25 -0000
Date:   Mon, 20 Apr 2020 13:37:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] dt-bindings: thermal: Convert i.MX8MM to json-schema
Message-ID: <20200420183725.GA11019@bogus>
References: <1586481044-19283-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586481044-19283-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 10, 2020 at 09:10:44AM +0800, Anson Huang wrote:
> Convert the i.MX8MM thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Add description to mention that i.MX8MM thermal driver supports
> 	  both i.MX8MM(1 sensor) and i.MX8MP(2 sensors).
> 	- Remove ./thermal.txt reference.
> ---
>  .../devicetree/bindings/thermal/imx8mm-thermal.txt | 15 ------
>  .../bindings/thermal/imx8mm-thermal.yaml           | 62 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> deleted file mode 100644
> index 3629d3c..0000000
> --- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -* Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
> -
> -Required properties:
> -- compatible : Must be "fsl,imx8mm-tmu" or "fsl,imx8mp-tmu".
> -- reg : Address range of TMU registers.
> -- clocks : TMU's clock source.
> -- #thermal-sensor-cells : Should be 0 or 1. See ./thermal.txt for a description.
> -
> -Example:
> -tmu: tmu@30260000 {
> -	compatible = "fsl,imx8mm-tmu";
> -	reg = <0x30260000 0x10000>;
> -	clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
> -	#thermal-sensor-cells = <0>;
> -};
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> new file mode 100644
> index 0000000..71807e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/imx8mm-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Mini Thermal Binding
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +description: |
> +  i.MX8MM has TMU IP to allow temperature measurement, there are
> +  currently two distinct major versions of the IP that is supported
> +  by a single driver. The IP versions are named v1 and v2, v1 is
> +  for i.MX8MM which has ONLY 1 sensor, v2 is for i.MX8MP which has
> +  2 sensors.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-tmu
> +              - fsl,imx8mp-tmu

Just:

compatible:
  enum:
    - fsl,imx8mm-tmu
    - fsl,imx8mp-tmu

> +  reg:
> +    description: |
> +      Address range of TMU registers.

Drop this.

> +    maxItems: 1

Blank line here.

> +  clocks:
> +    description: |
> +      TMU's clock source.

Drop

> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    description: |
> +      Number of cells required to uniquely identify the thermal
> +      sensors, 0 for ONLY one sensor and 1 for multiple sensors.
> +    enum:
> +      - 0
> +      - 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#thermal-sensor-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +
> +    tmu: tmu@30260000 {

thermal-sensor@...

> +         compatible = "fsl,imx8mm-tmu";
> +         reg = <0x30260000 0x10000>;
> +         clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
> +         #thermal-sensor-cells = <0>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 
