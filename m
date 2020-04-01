Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC819ABBD
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbgDAMeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 08:34:44 -0400
Received: from foss.arm.com ([217.140.110.172]:50672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgDAMeo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 08:34:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 128C130E;
        Wed,  1 Apr 2020 05:34:44 -0700 (PDT)
Received: from [10.37.12.63] (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89A7A3F68F;
        Wed,  1 Apr 2020 05:34:41 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] dt-bindings: thermal: Add yaml bindings for
 thermal cooling-devices
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1585738725.git.amit.kucheria@linaro.org>
 <d1884aed542fdd5ac1178f7195fb7c189179c631.1585738725.git.amit.kucheria@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <44bef00a-ffd1-4154-1b8c-77aae9ccc20d@arm.com>
Date:   Wed, 1 Apr 2020 13:34:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d1884aed542fdd5ac1178f7195fb7c189179c631.1585738725.git.amit.kucheria@linaro.org>
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
> The property #cooling-cells is required in each device that acts as a
> cooling device - whether active or passive. So any device that can
> throttle its performance to passively reduce heat dissipation (e.g.
> cpus, gpus) and any device that can actively dissipate heat at different

maybe CPUs, GPUs

> levels (e.g. fans) will contain this property.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v3:
>   - Clarify example by using cooling state numbers and a comment
> 
>   .../thermal/thermal-cooling-devices.yaml      | 116 ++++++++++++++++++
>   1 file changed, 116 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> new file mode 100644
> index 0000000000000..0dc4a743a1351
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0)
> +# Copyright 2020 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal cooling device binding
> +
> +maintainers:
> +  - Amit Kucheria <amitk@kernel.org>
> +
> +description: |
> +  Thermal management is achieved in devicetree by describing the sensor hardware
> +  and the software abstraction of cooling devices and thermal zones required to
> +  take appropriate action to mitigate thermal overload.
> +
> +  The following node types are used to completely describe a thermal management
> +  system in devicetree:
> +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> +   - cooling-device: device used to dissipate heat either passively or artively

s/artively/actively

> +   - thermal-zones: a container of the following node types used to describe all
> +     thermal data for the platform
> +
> +  This binding describes the cooling devices.
> +
> +  There are essentially two ways to provide control on power dissipation:
> +    - Passive cooling: by means of regulating device performance. A typical
> +      passive cooling mechanism is a CPU that has dynamic voltage and frequency
> +      scaling (DVFS), and uses lower frequencies as cooling states.
> +    - Active cooling: by means of activating devices in order to remove the
> +      dissipated heat, e.g. regulating fan speeds.
> +
> +  Any cooling device has a range of cooling states (i.e. different levels of
> +  heat dissipation). They also have a way to determine the state of cooling in
> +  which the device is. For example, a fan's cooling states correspond to the
> +  different fan speeds possible. Cooling states are referred to by single
> +  unsigned integers, where larger numbers mean greater heat dissipation. The
> +  precise set of cooling states associated with a device should be defined in
> +  a particular device's binding.
> +
> +select: true
> +
> +properties:
> +  "#cooling-cells":
> +    description:
> +        Must be 2, in order to specify minimum and maximum cooling state used in
> +        the cooling-maps reference. The first cell is the minimum cooling state
> +        and the second cell is the maximum cooling state requested.
> +    const: 2
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/thermal/thermal.h>
> +
> +    // Example 1: Cpufreq cooling device on CPU0
> +    cpus {
> +            #address-cells = <2>;
> +            #size-cells = <0>;
> +
> +            CPU0: cpu@0 {
> +                    device_type = "cpu";
> +                    compatible = "qcom,kryo385";
> +                    reg = <0x0 0x0>;
> +                    enable-method = "psci";
> +                    cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +                                       &LITTLE_CPU_SLEEP_1
> +                                       &CLUSTER_SLEEP_0>;
> +                    capacity-dmips-mhz = <607>;
> +                    dynamic-power-coefficient = <100>;
> +                    qcom,freq-domain = <&cpufreq_hw 0>;
> +                    #cooling-cells = <2>;
> +                    next-level-cache = <&L2_0>;
> +                    L2_0: l2-cache {
> +                            compatible = "cache";
> +                            next-level-cache = <&L3_0>;
> +                            L3_0: l3-cache {
> +                                    compatible = "cache";
> +                            };
> +                    };
> +          };
> +
> +          /* ... */
> +
> +    };
> +
> +    /* ... */
> +
> +    thermal-zones {
> +            cpu0-thermal {
> +                    polling-delay-passive = <250>;
> +                    polling-delay = <1000>;
> +
> +                    thermal-sensors = <&tsens0 1>;
> +
> +                    trips {
> +                            cpu0_alert0: trip-point0 {
> +                                    temperature = <90000>;
> +                                    hysteresis = <2000>;
> +                                    type = "passive";
> +                            };
> +                    };
> +
> +                    cooling-maps {
> +                            map0 {
> +                                    trip = <&cpu0_alert0>;
> +                                    /* Corresponds to 1000MHz in OPP table */
> +                                    cooling-device = <&CPU0 5 5>;
> +                            };
> +                    };
> +            };
> +
> +            /* ... */
> +    };
> +...
> 

Apart from that, looks good:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
