Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0DCB55EE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfIQTGW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 15:06:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35333 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbfIQTGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 15:06:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id x3so2384757oig.2;
        Tue, 17 Sep 2019 12:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1eCFNKmdR9qknMbLVpP77gHix0l96bg6/0uGAd5V+bU=;
        b=PPqrhn+ff0k5tKE1uZsy7GOJkJ6HEK8klIuBcAyMtuPFuhLCwmIL309GTzLxBI0RGy
         MFT3btZDoRBpZ+gmHrgLBCR+5Yk5QxjCoPx6VwLH1H5+COfSduHbFb7yD7Gih21JNxqr
         jYodToHMPZTyUpjOe2bxmPns4omSMIg4Mg0b0/nRQfU9NHWsbBaF5J8gz2wnWbHJwnyo
         1ikGr0E6OVhpb8p7ba8x/FAdVL5IQwTilxxUh431IrxprpCdsmyj2ZEaGARjDYMLqiX+
         00esFciBvQtZFzh7UqWJMS5291sjo/ovk8Wgt1kneDQ6W/uW/YLi6zbKZqsNhKAml8Al
         YNTg==
X-Gm-Message-State: APjAAAXN4TifmvlAofX6H+qdufkNtUs9eUnSMtGH0D9w8xe7lhABW5HD
        ZdHnx1JC45ezsO4YFKxRtA==
X-Google-Smtp-Source: APXvYqztXee9rjqqCwZzhzyN5Fd/D7ApgUPjJu+F+1STc7M7IAqn+O4HcJozmULd50ih0Nq2qcKYug==
X-Received: by 2002:aca:4705:: with SMTP id u5mr4826363oia.161.1568747180886;
        Tue, 17 Sep 2019 12:06:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v12sm971600oiv.58.2019.09.17.12.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 12:06:20 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:06:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 07/15] dt-bindings: thermal: tsens: Convert over to a
 yaml schema
Message-ID: <20190917190619.GA9311@bogus>
References: <cover.1568185732.git.amit.kucheria@linaro.org>
 <933f033298cbd7726a6c0b4b3b6cc7adc81784ba.1568185732.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933f033298cbd7726a6c0b4b3b6cc7adc81784ba.1568185732.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 11, 2019 at 12:46:24PM +0530, Amit Kucheria wrote:
> Document interrupt support in the tsens driver by converting over to a
> YAML schema.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../bindings/thermal/qcom-tsens.txt           |  55 ------
>  .../bindings/thermal/qcom-tsens.yaml          | 174 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 175 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml


> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> new file mode 100644
> index 000000000000..6784766fe58f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -0,0 +1,174 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +# Copyright 2019 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM SoC Temperature Sensor (TSENS)
> +
> +maintainers:
> +  - Amit Kucheria <amit.kucheria@linaro.org>
> +
> +description: |
> +  QCOM SoCs have TSENS IP to allow temperature measurement. There are currently
> +  three distinct major versions of the IP that is supported by a single driver.
> +  The IP versions are named v0.1, v1 and v2 in the driver, where v0.1 captures
> +  everything before v1 when there was no versioning information.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: v0.1 of TSENS
> +        items:
> +          - enum:
> +              - qcom,msm8916-tsens
> +              - qcom,msm8974-tsens
> +          - const: qcom,tsens-v0_1
> +
> +      - description: v1 of TSENS
> +        items:
> +          - enum:
> +              - qcom,qcs404-tsens
> +          - const: qcom,tsens-v1
> +
> +      - description: v2 of TSENS
> +        items:
> +          - enum:
> +              - qcom,msm8996-tsens
> +              - qcom,msm8998-tsens
> +              - qcom,sdm845-tsens
> +          - const: qcom,tsens-v2
> +
> +  reg:
> +    maxItems: 2
> +    items:
> +      - description: TM registers
> +      - description: SROT registers
> +
> +  nvmem-cells:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Reference to an nvmem node for the calibration data
> +
> +  nvmem-cells-names:

This is going to require 2 items, so you need an explicit minItems and 
maxItems.

> +    items:
> +      - enum:
> +        - caldata
> +        - calsel
> +
> +  "#qcom,sensors":
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 1
> +      - maximum: 16
> +    description:
> +      Number of sensors enabled on this platform
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description:
> +      Number of cells required to uniquely identify the thermal sensors. Since
> +      we have multiple sensors this is set to 1
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8916-tsens
> +              - qcom,msm8974-tsens
> +              - qcom,qcs404-tsens
> +              - qcom,tsens-v0_1
> +              - qcom,tsens-v1
> +    then:
> +      properties:
> +        interrupts:

> +          minItems: 1
> +          maxItems: 1

These can be implicit.

> +          items:
> +            - description: Combined interrupt if upper or lower threshold crossed
> +        interrupt-names:
> +          minItems: 1
> +          maxItems: 1

ditto.

> +          items:
> +            - const: uplow
> +
> +    else:
> +      properties:
> +        interrupts:
> +          minItems: 2
> +          maxItems: 2

ditto.

> +          items:
> +            - description: Combined interrupt if upper or lower threshold crossed
> +            - description: Interrupt if critical threshold crossed
> +        interrupt-names:
> +          minItems: 2
> +          maxItems: 2

ditto.

> +          items:
> +            - const: uplow
> +            - const: critical
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#qcom,sensors"
> +  - interrupts
> +  - interrupt-names
> +  - "#thermal-sensor-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    // Example 1 (legacy: for pre v1 IP):
> +    tsens1: thermal-sensor@900000 {
> +           compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
> +           reg = <0x4a9000 0x1000>, /* TM */
> +                 <0x4a8000 0x1000>; /* SROT */
> +
> +           nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
> +           nvmem-cell-names = "caldata", "calsel";
> +
> +           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +           interrupt-names = "uplow";
> +
> +           #qcom,sensors = <5>;
> +           #thermal-sensor-cells = <1>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    // Example 2 (for any platform containing v1 of the TSENS IP):
> +    tsens2: thermal-sensor@4a9000 {
> +          compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
> +          reg = <0x004a9000 0x1000>, /* TM */
> +                <0x004a8000 0x1000>; /* SROT */
> +
> +          nvmem-cells = <&tsens_caldata>;
> +          nvmem-cell-names = "calib";
> +
> +          interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> +          interrupt-names = "uplow";
> +
> +          #qcom,sensors = <10>;
> +          #thermal-sensor-cells = <1>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    // Example 3 (for any platform containing v2 of the TSENS IP):
> +    tsens3: thermal-sensor@c263000 {
> +           compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +           reg = <0xc263000 0x1ff>,
> +                 <0xc222000 0x1ff>;
> +
> +           interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> +           interrupt-names = "uplow", "critical";
> +
> +           #qcom,sensors = <13>;
> +           #thermal-sensor-cells = <1>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7a47b5210fd..ff757a4a060c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13360,6 +13360,7 @@ L:	linux-pm@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/thermal/qcom/
> +F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>  
>  QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
>  M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
> -- 
> 2.17.1
> 
