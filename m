Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5532E1926BC
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 12:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCYLGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 07:06:32 -0400
Received: from foss.arm.com ([217.140.110.172]:46696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgCYLGc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Mar 2020 07:06:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1164231B;
        Wed, 25 Mar 2020 04:06:31 -0700 (PDT)
Received: from [10.37.12.110] (unknown [10.37.12.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C30883F71F;
        Wed, 25 Mar 2020 04:06:28 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1585117436.git.amit.kucheria@linaro.org>
 <9c447186008ef2e3f4c3e712458dc0ddcd8a8b03.1585117436.git.amit.kucheria@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <81b0cbe1-23c8-b4a3-4775-62e7d6c49b6b@arm.com>
Date:   Wed, 25 Mar 2020 11:06:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9c447186008ef2e3f4c3e712458dc0ddcd8a8b03.1585117436.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/25/20 6:34 AM, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The thermal-zone binding is a software abstraction to capture the
> properties of each zone - how often they should be checked, the
> temperature thresholds (trips) at which mitigation actions need to be
> taken and the level of mitigation needed at those thresholds.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
> Changes since v2:
> - Addressed review comment from Rob
> - Added required properties for thermal-zones node
> - Added select: true to thermal-cooling-devices.yaml
> - Fixed up example to pass dt_binding_check
> 
>   .../bindings/thermal/thermal-zones.yaml       | 324 ++++++++++++++++++
>   1 file changed, 324 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> new file mode 100644
> index 000000000000..5632304dcf62
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -0,0 +1,324 @@
> +# SPDX-License-Identifier: (GPL-2.0)
> +# Copyright 2020 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> +$schema: http://devicetree.org/meta-schemas/base.yaml#
> +
> +title: Thermal zone binding
> +
> +maintainers:
> +  - Amit Kucheria <amitk@kernel.org>
> +
> +description: |
> +  Thermal management is achieved in devicetree by describing the sensor hardware
> +  and the software abstraction of cooling devices and thermal zones required to
> +  take appropriate action to mitigate thermal overloads.
> +
> +  The following node types are used to completely describe a thermal management
> +  system in devicetree:
> +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> +   - cooling-device: device used to dissipate heat either passively or actively
> +   - thermal-zones: a container of the following node types used to describe all
> +     thermal data for the platform
> +
> +  This binding describes the thermal-zones.
> +
> +  The polling-delay properties of a thermal-zone are bound to the maximum dT/dt
> +  (temperature derivative over time) in two situations for a thermal zone:
> +    1. when passive cooling is activated (polling-delay-passive)
> +    2. when the zone just needs to be monitored (polling-delay) or when
> +       active cooling is activated.
> +
> +  The maximum dT/dt is highly bound to hardware power consumption and
> +  dissipation capability. The delays should be chosen to account for said
> +  max dT/dt, such that a device does not cross several trip boundaries
> +  unexpectedly between polls. Choosing the right polling delays shall avoid
> +  having the device in temperature ranges that may damage the silicon structures
> +  and reduce silicon lifetime.
> +
> +properties:
> +  $nodename:
> +    const: thermal-zones
> +    description:
> +      A /thermal-zones node is required in order to use the thermal framework to
> +      manage input from the various thermal zones in the system in order to
> +      mitigate thermal overload conditions. It does not represent a real device
> +      in the system, but acts as a container to link thermal sensor devices,

I would say 'thermal sensor device', since there is 1-to-1 mapping and
aggregating a few sensors inside one tz is not allowed (or I missed
some patches queuing).

> +      platform-data regarding temperature thresholds and the mitigation actions
> +      to take when the temperature crosses those thresholds.
> +
> +patternProperties:
> +  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
> +    type: object
> +    description:
> +      Each thermal zone node contains information about how frequently it
> +      must be checked, the sensor responsible for reporting temperature for
> +      this zone, one sub-node containing the various trip points for this
> +      zone and one sub-node containing all the zone cooling-maps.
> +
> +    properties:
> +      polling-delay:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The maximum number of milliseconds to wait between polls when
> +          checking this thermal zone. Setting this to 0 disables the polling
> +          timers setup by the thermal framework and assumes that the thermal
> +          sensors in this zone support interrupts.
> +
> +      polling-delay-passive:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The maximum number of milliseconds to wait between polls when
> +          checking this thermal zone while doing passive cooling. Setting
> +          this to 0 disables the polling timers setup by the thermal
> +          framework and assumes that the thermal sensors in this zone
> +          support interrupts.
> +
> +      thermal-sensors:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description:
> +          A list of thermal sensor phandles and sensor specifiers used to
> +          monitor this thermal zone.

I don't know why it's not consistent with the actual code in
of-thermal.c, where there is even a comment stated:
/* For now, thermal framework supports only 1 sensor per zone */

I think this is the place where developers should be informed about
the limitation and not even try to put more sensors into the list.

> +
> +      trips:
> +        type: object
> +        description:
> +          This node describes a set of points in the temperature domain at
> +          which the thermal framework needs to takes action. The actions to

s/needs to takes/needs to take/

> +          be taken are defined in another node called cooling-maps.
> +
> +        patternProperties:
> +          "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$":
> +            type: object
> +
> +            properties:
> +              temperature:
> +                $ref: /schemas/types.yaml#/definitions/int32
> +                minimum: -273000
> +                maximum: 200000
> +                description:
> +                  An integer expressing the trip temperature in millicelsius.
> +
> +              hysteresis:
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                description:
> +                  An unsigned integer expressing the hysteresis delta with
> +                  respect to the trip temperature property above, also in
> +                  millicelsius.

This property is worth a bit longer description.

> +
> +              type:
> +                $ref: /schemas/types.yaml#/definitions/string
> +                enum:
> +                  - active   # enable active cooling e.g. fans
> +                  - passive  # enable passive cooling e.g. throttling cpu
> +                  - hot      # send notification to driver
> +                  - critical # send notification to driver, trigger shutdown
> +                description: |
> +                  There are four valid trip types: active, passive, hot,
> +                  critical.

[snip]

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
> +
> +                            cpu0_alert1: trip-point1 {
> +                                    temperature = <95000>;
> +                                    hysteresis = <2000>;
> +                                    type = "passive";
> +                            };
> +
> +                            cpu0_crit: cpu_crit {
> +                                    temperature = <110000>;
> +                                    hysteresis = <1000>;
> +                                    type = "critical";
> +                            };
> +                    };
> +
> +                    cooling-maps {
> +                            map0 {
> +                                    trip = <&cpu0_alert0>;
> +                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>,
> +                                                     <&CPU1 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>,
> +                                                     <&CPU2 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>,
> +                                                     <&CPU3 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>;
> +                            };
> +
> +                            map1 {
> +                                    trip = <&cpu0_alert1>;
> +                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>,
> +                                                     <&CPU1 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>,
> +                                                     <&CPU2 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>,
> +                                                     <&CPU3 THERMAL_NO_LIMIT
> +                                                            THERMAL_NO_LIMIT>;

 From this two examples of handling cpu0_alert0 and cpu0_alert1 you
cannot conclude anything (if you don't understand thermal framework (and
probably IPA). As a simple example it would be better to put a comment
with a description and limit min, max to a specific OPP:

map0 {
     trip = <&cpu0_alert0>;
     /* Corresponds to 1400MHz in OPP table */
     cooling-device = <&CPU0 3 3>, <&CPU1 3 3>, <&CPU2 3 3>, <&CPU3 3 3>;
};

map1 {
     trip = <&cpu0_alert1>;
     /* Corresponds to 1000MHz in OPP table */
     cooling-device = <&CPU0 5 5>, <&CPU1 5 5>, <&CPU2 5 5>, <&CPU3 5 5>;
};

IMHO this kind of example would tell more to an avg driver developer.

Regards,
Lukasz
