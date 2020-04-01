Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE319ABD6
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbgDAMkF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 08:40:05 -0400
Received: from foss.arm.com ([217.140.110.172]:50788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732348AbgDAMkF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 08:40:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EBC930E;
        Wed,  1 Apr 2020 05:40:04 -0700 (PDT)
Received: from [10.37.12.63] (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00DBE3F68F;
        Wed,  1 Apr 2020 05:40:01 -0700 (PDT)
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add yaml bindings for
 thermal sensors
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1585738725.git.amit.kucheria@linaro.org>
 <146b5dfebf23321c1eed8190ada957e2264ffe65.1585738725.git.amit.kucheria@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <da9860cf-0c2e-b7ff-47c2-19c79b06ad55@arm.com>
Date:   Wed, 1 Apr 2020 13:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <146b5dfebf23321c1eed8190ada957e2264ffe65.1585738725.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/1/20 12:15 PM, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The property #thermal-sensor-cells is required in each device that acts
> as a thermal sensor. It is used to uniquely identify the instance of the
> thermal sensor inside the system.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/thermal/thermal-sensor.yaml      | 72 +++++++++++++++++++
>   1 file changed, 72 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> new file mode 100644
> index 0000000000000..920ee7667591d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0)
> +# Copyright 2020 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal sensor binding
> +
> +maintainers:
> +  - Amit Kucheria <amitk@kernel.org>
> +
> +description: |
> +  Thermal management is achieved in devicetree by describing the sensor hardware
> +  and the software abstraction of thermal zones required to take appropriate
> +  action to mitigate thermal overloads.
> +
> +  The following node types are used to completely describe a thermal management
> +  system in devicetree:
> +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> +   - cooling-device: device used to dissipate heat either passively or artively

s/artively/actively

> +   - thermal-zones: a container of the following node types used to describe all
> +     thermal data for the platform
> +
> +  This binding describes the thermal-sensor.
> +
> +  Thermal sensor devices provide temperature sensing capabilities on thermal
> +  zones. Typical devices are I2C ADC converters and bandgaps. Thermal sensor
> +  devices may control one or more internal sensors.
> +
> +properties:
> +  "#thermal-sensor-cells":
> +    description:
> +      Used to uniquely identify a thermal sensor instance within an IC. Will be
> +      0 on sensor nodes with only a single sensor and at least 1 on nodes
> +      containing several internal sensors.
> +    enum: [0, 1]
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    // Example 1: SDM845 TSENS
> +    soc: soc@0 {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +
> +            /* ... */
> +
> +            tsens0: thermal-sensor@c263000 {
> +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
> +                          <0 0x0c222000 0 0x1ff>; /* SROT */
> +                    #qcom,sensors = <13>;
> +                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +                                 <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> +                    interrupt-names = "uplow", "critical";
> +                    #thermal-sensor-cells = <1>;
> +            };
> +
> +            tsens1: thermal-sensor@c265000 {
> +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
> +                          <0 0x0c223000 0 0x1ff>; /* SROT */
> +                    #qcom,sensors = <8>;
> +                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> +                                 <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> +                    interrupt-names = "uplow", "critical";
> +                    #thermal-sensor-cells = <1>;
> +            };
> +    };
> +...
> 

Apart from the above, looks good.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
