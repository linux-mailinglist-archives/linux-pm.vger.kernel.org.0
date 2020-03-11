Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B78181BB1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 15:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgCKOtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 10:49:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35504 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgCKOtk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 10:49:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id k26so2238403otr.2;
        Wed, 11 Mar 2020 07:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAmQnkESq8xyxzPU1NSxQRhUYYEkaNDFnXmSP6WtBYY=;
        b=Htt3+uNfyTs/wTaoNk7JA7ZsvozIaC7eOGtPnw33GXK2gkWfKkC4iNogRYqxHtkBkK
         haBJdXjOesZCT5YZ0i+udTZBaOE5jP2PVJ5YQO3LDd5hjbb9C8Nlm1plc6ydGpY1IYR0
         XPSSSjdd5VnEA70gUVg0MG8ODM988CQLy4iB+zSVWh1bgVvlrijxZjM/1NLbtVWf9mob
         X4QIjdeURXVga8LeRQjs7iS5ZlQZtfxrpH6n5lbWSAGkgKv9WK9Jl6G0mIY1vhRbCMXH
         fd+76EJhzR2lLnTCHWpIgQ9l4KI1ni2adlt2v4HlFTd0dwWOAoHk5SM19o+3EzxDl6fI
         pudg==
X-Gm-Message-State: ANhLgQ1EbGEPbtAvZ0vHJ0Bn9A8qminSjY5jgVGKeB1+j2gD2pzYwtQ9
        7jJr1GEwJwqqNVDyUEmfvg==
X-Google-Smtp-Source: ADFU+vuzwty++ZwrsQLj5rc05t2nqaYMetCAo/APIGmyGbyeZTO2NSm92bLiDJhZrGnvqTmd+5wmZQ==
X-Received: by 2002:a9d:171e:: with SMTP id i30mr2693342ota.327.1583938177552;
        Wed, 11 Mar 2020 07:49:37 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e22sm17545796ote.32.2020.03.11.07.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:49:34 -0700 (PDT)
Received: (nullmailer pid 1034 invoked by uid 1000);
        Wed, 11 Mar 2020 14:49:33 -0000
Date:   Wed, 11 Mar 2020 09:49:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
Message-ID: <20200311144933.GA21587@bogus>
References: <cover.1583412540.git.amit.kucheria@linaro.org>
 <8a0cfe9e3018f7996c1563035bee76048941beb4.1583412540.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0cfe9e3018f7996c1563035bee76048941beb4.1583412540.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 05, 2020 at 06:26:43PM +0530, Amit Kucheria wrote:
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
>  .../bindings/thermal/thermal-zones.yaml       | 325 ++++++++++++++++++
>  1 file changed, 325 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> new file mode 100644
> index 0000000000000..f8f3b72bc3119
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -0,0 +1,325 @@
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
> +  thermal-zones:
> +    type: object
> +    description:
> +      A /thermal-zones node is required in order to use the thermal framework to
> +      manage input from the various thermal zones in the system in order to
> +      mitigate thermal overload conditions. It does not represent a real device
> +      in the system, but acts as a container to link thermal sensor devices,
> +      platform-data regarding temperature thresholds and the mitigation actions
> +      to take when the temperature crosses those thresholds.
> +

> +    properties:
> +      $nodename:
> +        pattern: "^[a-zA-Z][a-zA-Z0-9,\\-]{1,12}-thermal$"

These 3 lines should be:

patternProperties:
  "^[a-zA-Z][a-zA-Z0-9,\\-]{1,12}-thermal$":

Though we should drop ',' as well.

$nodename is only needed at the top level where it's kind of special.

> +        type: object
> +        description:
> +          Each thermal zone node contains information about how frequently it
> +          must be checked, the sensor responsible for reporting temperature for
> +          this zone, one sub-node containing the various trip points for this
> +          zone and one sub-node containing all the zone cooling-maps.
> +
> +        properties:
> +          polling-delay:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0

The type is unsigned, so the min is already 0.

> +            description:
> +              The maximum number of milliseconds to wait between polls when
> +              checking this thermal zone. Setting this to 0 disables the polling
> +              timers setup by the thermal framework and assumes that the thermal
> +              sensors in this zone support interrupts.
> +
> +          polling-delay-passive:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0
> +            description:
> +              The maximum number of milliseconds to wait between polls when
> +              checking this thermal zone while doing passive cooling. Setting
> +              this to 0 disables the polling timers setup by the thermal
> +              framework and assumes that the thermal sensors in this zone
> +              support interrupts.
> +
> +          thermal-sensors:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +            description:
> +              A list of thermal sensor phandles and sensor specifiers used to
> +              monitor this thermal zone.
> +
> +          trips:
> +            type: object
> +            description:
> +              This node describes a set of points in the temperature domain at
> +              which the thermal framework needs to takes action. The actions to
> +              be taken are defined in another node called cooling-maps.
> +
> +            patternProperties:
> +              "^[a-zA-Z][a-zA-Z0-9,+\\._]{0,63}$":

Drop ',', '+', '.', and ideally '_'. Probably need to add '-'.

> +                type: object
> +
> +                properties:
> +                  temperature:
> +                    $ref: /schemas/types.yaml#/definitions/int32
> +                    minimum: -273000
> +                    maximum: 200000
> +                    description:
> +                      An integer expressing the trip temperature in millicelsius.
> +
> +                  hysteresis:
> +                    $ref: /schemas/types.yaml#/definitions/uint32
> +                    description:
> +                      An unsigned integer expressing the hysteresis delta with
> +                      respect to the trip temperature property above, also in
> +                      millicelsius.
> +
> +                  type:

Needs a type reference (string).

> +                    enum:
> +                        # active: enable active cooling e.g. fans
> +                        - active

Wrong indentation. Should be 2 less.

Also, I think this would be more readable:

- active  # enable active cooling e.g. fans
  

> +                        # passive: enable passive cooling e.g. throttling cpu
> +                        - passive
> +                        # hot: send notification to driver if .notify
> +                        #      callback registered
> +                        - hot
> +                        # critical: send notification to driver if .notify
> +                        #           callback registered and trigger a shutdown
> +                        - critical
> +                    description: |
> +                      There are four valid trip types: active, passive, hot,
> +                      critical.
> +
> +                      The critical trip type is used to set the maximum
> +                      temperature threshold above which the HW becomes
> +                      unstable and underlying firmware might even trigger a
> +                      reboot. Hitting the critical threshold triggers a system
> +                      shutdown.
> +
> +                      The hot trip type can be used to send a notification to
> +                      the thermal driver (if a .notify callback is registered).
> +                      The action to be taken is left to the driver.
> +
> +                      The passive trip type can be used to slow down HW e.g. run
> +                      the CPU, GPU, bus at a lower frequency.
> +
> +                      The active trip type can be used to control other HW to
> +                      help in cooling e.g. fans can be sped up or slowed down
> +
> +                required:
> +                  - temperature
> +                  - hysteresis
> +                  - type
> +
> +            additionalProperties: false

You need 'additionalProperties' on the child nodes too, or are there 
vendor specific properties allowed?

> +
> +          cooling-maps:
> +            type: object
> +            description:
> +              This node describes the action to be taken when a thermal zone
> +              crosses one of the temperature thresholds described in the trips
> +              node. The action takes the form of a mapping relation between a
> +              trip and the target cooling device state.
> +
> +            patternProperties:
> +              "^map[0-9][-a-zA-Z0-9]*$":
> +                type: object
> +
> +                properties:
> +                  trip:
> +                    $ref: /schemas/types.yaml#/definitions/phandle
> +                    description:
> +                      A phandle of a trip point node within this thermal zone.
> +
> +                  cooling-device:
> +                    $ref: /schemas/types.yaml#/definitions/phandle-array
> +                    description:
> +                      A list of cooling device phandles along with the minimum
> +                      and maximum cooling state specifiers for each cooling
> +                      device. Using the THERMAL_NO_LIMIT (-1UL) constant in the
> +                      cooling-device phandle limit specifier lets the framework
> +                      use the minimum and maximum cooling state for that cooling
> +                      device automatically.
> +
> +                  contribution:
> +                    $ref: /schemas/types.yaml#/definitions/uint32
> +                    minimum: 0
> +                    maximum: 100
> +                    description:
> +                      The contribution of the cooling devices at the trip
> +                      temperature, both referenced in this map, to this thermal
> +                      zone as a percentage.
> +
> +                required:
> +                  - trip
> +                  - cooling-device
> +

'additionalProperties' for map* nodes?

> +            additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/thermal/thermal.h>
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
> +                            };
> +                    };
> +            };
> +
> +            /* ... */
> +
> +            cluster0-thermal {
> +                    polling-delay-passive = <250>;
> +                    polling-delay = <1000>;
> +
> +                    thermal-sensors = <&tsens0 5>;
> +
> +                    trips {
> +                            cluster0_alert0: trip-point0 {
> +                                    temperature = <90000>;
> +                                    hysteresis = <2000>;
> +                                    type = "hot";
> +                            };
> +                            cluster0_crit: cluster0_crit {
> +                                    temperature = <110000>;
> +                                    hysteresis = <2000>;
> +                                    type = "critical";
> +                            };
> +                    };
> +            };
> +
> +            /* ... */
> +
> +            gpu-thermal-top {

This one is not going to match (which should cause an error).
 
> +                    polling-delay-passive = <250>;
> +                    polling-delay = <1000>;
> +
> +                    thermal-sensors = <&tsens0 11>;
> +
> +                    trips {
> +                            gpu1_alert0: trip-point0 {
> +                                    temperature = <90000>;
> +                                    hysteresis = <2000>;
> +                                    type = "hot";
> +                            };
> +                    };
> +            };
> +    };
> +...
> -- 
> 2.20.1
> 
