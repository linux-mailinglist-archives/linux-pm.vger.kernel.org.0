Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A6818FFB4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 21:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCWUqR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 16:46:17 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46184 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCWUqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 16:46:17 -0400
Received: by mail-ua1-f65.google.com with SMTP id y17so1697453uap.13
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2020 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avSGiptGQF9hE9IPVYyfDgpvYQHJFA6GQoG6Pm5p1nI=;
        b=fy5B7M4WVPNB6wx97QHx57yM2C5O4ieAW8exwVd8nqBhwKISmdgk8JH6b0GUZjMfyH
         NZvHcEoZMI+QWIcrxGu5a8Tf+NcQ9F5nch7b5P/RO1NixEhCNit0wmIpl5NhYBFBxWsd
         S/qRQie6TmA8j4GO9pSrEBO9ik+xRRON89Cpoh1pdHNeopOjhNeXZdjF7NMop1RQO+fe
         SekXj0t5AoJyCIDZg0DYsKENuky/9tHxcNpbb8HdIqZBSJZxrfuA1V8CugjhGw810hBc
         8CTQ0QcIuViBq1rFyYkt3l0ZnbROGEhcdLyOXk7p6wUqO6U3b+m0I8/omfH7UmZ4kiUp
         nzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avSGiptGQF9hE9IPVYyfDgpvYQHJFA6GQoG6Pm5p1nI=;
        b=UbPWTs46gGkfwcJsQkqF/xrcxXEIbsqBNOsBpF1Tdrs83EkXqpKQ7qpAkMl7VZD23S
         jiMljWuB2SBaO2HOldGKfpZGrBGvD4iexi3oxODx2lELdZ13pzIpfYj72tt16tFbTq1H
         5H1v7nKc7NbTSyaUH0tf7hcOCVF4ZAjNMoocwP6q0DtWsrwaAnOSmgJGhOk+Ad8GHRPN
         l9oZidfw0gNQ6k+3f31WW0hf9JrpVYsWsr9032cxyBD3r5Q6vs+5R3vEGGa3zQS3l43r
         M9jAH+QvggozhVjYRF6m25oHmcHLvB4lcFcV7xSQrNg9Nv370FIwVo4qnfK7C8SPxCZY
         2rUw==
X-Gm-Message-State: ANhLgQ0T0AfYc1zwWvO+wtqpN4nfOJIz3I7Mq/Aa5gZO/oSefbbjkhkI
        Zi1c3NQpH5dEPe4Sf5NKEGIkIJLjmA69VT+UCzUOWw==
X-Google-Smtp-Source: ADFU+vvDAnEKB4ZFdPiysFslS8rnid5/tsQxnFQLzSdrHuIa9MfbBbVr4nylyNL61u3dVZsW1GLblgFDK3Lz+CvmCXY=
X-Received: by 2002:ab0:5f90:: with SMTP id b16mr15354828uaj.77.1584996374341;
 Mon, 23 Mar 2020 13:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583412540.git.amit.kucheria@linaro.org>
 <8a0cfe9e3018f7996c1563035bee76048941beb4.1583412540.git.amit.kucheria@linaro.org>
 <20200311144933.GA21587@bogus>
In-Reply-To: <20200311144933.GA21587@bogus>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 24 Mar 2020 02:16:03 +0530
Message-ID: <CAHLCerN99eKOofxcCuvNwjNGbJfB7BzoPGAPCtXHNQdN9w8Bcw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

Thanks for the review.

On Wed, Mar 11, 2020 at 8:19 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 05, 2020 at 06:26:43PM +0530, Amit Kucheria wrote:
> > As part of moving the thermal bindings to YAML, split it up into 3
> > bindings: thermal sensors, cooling devices and thermal zones.
> >
> > The thermal-zone binding is a software abstraction to capture the
> > properties of each zone - how often they should be checked, the
> > temperature thresholds (trips) at which mitigation actions need to be
> > taken and the level of mitigation needed at those thresholds.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  .../bindings/thermal/thermal-zones.yaml       | 325 ++++++++++++++++++
> >  1 file changed, 325 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > new file mode 100644
> > index 0000000000000..f8f3b72bc3119
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > @@ -0,0 +1,325 @@
> > +# SPDX-License-Identifier: (GPL-2.0)
> > +# Copyright 2020 Linaro Ltd.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> > +$schema: http://devicetree.org/meta-schemas/base.yaml#
> > +
> > +title: Thermal zone binding
> > +
> > +maintainers:
> > +  - Amit Kucheria <amitk@kernel.org>
> > +
> > +description: |
> > +  Thermal management is achieved in devicetree by describing the sensor hardware
> > +  and the software abstraction of cooling devices and thermal zones required to
> > +  take appropriate action to mitigate thermal overloads.
> > +
> > +  The following node types are used to completely describe a thermal management
> > +  system in devicetree:
> > +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> > +   - cooling-device: device used to dissipate heat either passively or actively
> > +   - thermal-zones: a container of the following node types used to describe all
> > +     thermal data for the platform
> > +
> > +  This binding describes the thermal-zones.
> > +
> > +  The polling-delay properties of a thermal-zone are bound to the maximum dT/dt
> > +  (temperature derivative over time) in two situations for a thermal zone:
> > +    1. when passive cooling is activated (polling-delay-passive)
> > +    2. when the zone just needs to be monitored (polling-delay) or when
> > +       active cooling is activated.
> > +
> > +  The maximum dT/dt is highly bound to hardware power consumption and
> > +  dissipation capability. The delays should be chosen to account for said
> > +  max dT/dt, such that a device does not cross several trip boundaries
> > +  unexpectedly between polls. Choosing the right polling delays shall avoid
> > +  having the device in temperature ranges that may damage the silicon structures
> > +  and reduce silicon lifetime.
> > +
> > +properties:
> > +  thermal-zones:
> > +    type: object
> > +    description:
> > +      A /thermal-zones node is required in order to use the thermal framework to
> > +      manage input from the various thermal zones in the system in order to
> > +      mitigate thermal overload conditions. It does not represent a real device
> > +      in the system, but acts as a container to link thermal sensor devices,
> > +      platform-data regarding temperature thresholds and the mitigation actions
> > +      to take when the temperature crosses those thresholds.
> > +
>
> > +    properties:
> > +      $nodename:
> > +        pattern: "^[a-zA-Z][a-zA-Z0-9,\\-]{1,12}-thermal$"
>
> These 3 lines should be:
>
> patternProperties:
>   "^[a-zA-Z][a-zA-Z0-9,\\-]{1,12}-thermal$":
>
> Though we should drop ',' as well.
>
> $nodename is only needed at the top level where it's kind of special.

Fixed.

> > +        type: object
> > +        description:
> > +          Each thermal zone node contains information about how frequently it
> > +          must be checked, the sensor responsible for reporting temperature for
> > +          this zone, one sub-node containing the various trip points for this
> > +          zone and one sub-node containing all the zone cooling-maps.
> > +
> > +        properties:
> > +          polling-delay:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            minimum: 0
>
> The type is unsigned, so the min is already 0.

Dropped.

> > +            description:
> > +              The maximum number of milliseconds to wait between polls when
> > +              checking this thermal zone. Setting this to 0 disables the polling
> > +              timers setup by the thermal framework and assumes that the thermal
> > +              sensors in this zone support interrupts.
> > +
> > +          polling-delay-passive:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            minimum: 0

Dropped.

> > +            description:
> > +              The maximum number of milliseconds to wait between polls when
> > +              checking this thermal zone while doing passive cooling. Setting
> > +              this to 0 disables the polling timers setup by the thermal
> > +              framework and assumes that the thermal sensors in this zone
> > +              support interrupts.
> > +
> > +          thermal-sensors:
> > +            $ref: /schemas/types.yaml#/definitions/phandle-array
> > +            description:
> > +              A list of thermal sensor phandles and sensor specifiers used to
> > +              monitor this thermal zone.
> > +
> > +          trips:
> > +            type: object
> > +            description:
> > +              This node describes a set of points in the temperature domain at
> > +              which the thermal framework needs to takes action. The actions to
> > +              be taken are defined in another node called cooling-maps.
> > +
> > +            patternProperties:
> > +              "^[a-zA-Z][a-zA-Z0-9,+\\._]{0,63}$":
>
> Drop ',', '+', '.', and ideally '_'. Probably need to add '-'.

Dropping underscore flags a lot of DTs in dtbs_check. Do you want me
to go fix them or can we live with the underscore. Is there some
document I should read on why underscore isn't desirable?

Fixed the rest.

>
> > +                type: object
> > +
> > +                properties:
> > +                  temperature:
> > +                    $ref: /schemas/types.yaml#/definitions/int32
> > +                    minimum: -273000
> > +                    maximum: 200000
> > +                    description:
> > +                      An integer expressing the trip temperature in millicelsius.
> > +
> > +                  hysteresis:
> > +                    $ref: /schemas/types.yaml#/definitions/uint32
> > +                    description:
> > +                      An unsigned integer expressing the hysteresis delta with
> > +                      respect to the trip temperature property above, also in
> > +                      millicelsius.
> > +
> > +                  type:
>
> Needs a type reference (string).

Fixed.

>
> > +                    enum:
> > +                        # active: enable active cooling e.g. fans
> > +                        - active
>
> Wrong indentation. Should be 2 less.
>
> Also, I think this would be more readable:
>
> - active  # enable active cooling e.g. fans

Yes, fixed.

>
> > +                        # passive: enable passive cooling e.g. throttling cpu
> > +                        - passive
> > +                        # hot: send notification to driver if .notify
> > +                        #      callback registered
> > +                        - hot
> > +                        # critical: send notification to driver if .notify
> > +                        #           callback registered and trigger a shutdown
> > +                        - critical
> > +                    description: |
> > +                      There are four valid trip types: active, passive, hot,
> > +                      critical.
> > +
> > +                      The critical trip type is used to set the maximum
> > +                      temperature threshold above which the HW becomes
> > +                      unstable and underlying firmware might even trigger a
> > +                      reboot. Hitting the critical threshold triggers a system
> > +                      shutdown.
> > +
> > +                      The hot trip type can be used to send a notification to
> > +                      the thermal driver (if a .notify callback is registered).
> > +                      The action to be taken is left to the driver.
> > +
> > +                      The passive trip type can be used to slow down HW e.g. run
> > +                      the CPU, GPU, bus at a lower frequency.
> > +
> > +                      The active trip type can be used to control other HW to
> > +                      help in cooling e.g. fans can be sped up or slowed down
> > +
> > +                required:
> > +                  - temperature
> > +                  - hysteresis
> > +                  - type
> > +
> > +            additionalProperties: false
>
> You need 'additionalProperties' on the child nodes too, or are there
> vendor specific properties allowed?

Done. No vendor-specific properties allowed here.

> > +
> > +          cooling-maps:
> > +            type: object
> > +            description:
> > +              This node describes the action to be taken when a thermal zone
> > +              crosses one of the temperature thresholds described in the trips
> > +              node. The action takes the form of a mapping relation between a
> > +              trip and the target cooling device state.
> > +
> > +            patternProperties:
> > +              "^map[0-9][-a-zA-Z0-9]*$":
> > +                type: object
> > +
> > +                properties:
> > +                  trip:
> > +                    $ref: /schemas/types.yaml#/definitions/phandle
> > +                    description:
> > +                      A phandle of a trip point node within this thermal zone.
> > +
> > +                  cooling-device:
> > +                    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +                    description:
> > +                      A list of cooling device phandles along with the minimum
> > +                      and maximum cooling state specifiers for each cooling
> > +                      device. Using the THERMAL_NO_LIMIT (-1UL) constant in the
> > +                      cooling-device phandle limit specifier lets the framework
> > +                      use the minimum and maximum cooling state for that cooling
> > +                      device automatically.
> > +
> > +                  contribution:
> > +                    $ref: /schemas/types.yaml#/definitions/uint32
> > +                    minimum: 0
> > +                    maximum: 100
> > +                    description:
> > +                      The contribution of the cooling devices at the trip
> > +                      temperature, both referenced in this map, to this thermal
> > +                      zone as a percentage.
> > +
> > +                required:
> > +                  - trip
> > +                  - cooling-device
> > +
>
> 'additionalProperties' for map* nodes?

Done.

> > +            additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/thermal/thermal.h>
> > +
> > +    // Example 1: SDM845 TSENS
> > +    soc: soc@0 {
> > +            #address-cells = <2>;
> > +            #size-cells = <2>;
> > +
> > +            /* ... */
> > +
> > +            tsens0: thermal-sensor@c263000 {
> > +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
> > +                          <0 0x0c222000 0 0x1ff>; /* SROT */
> > +                    #qcom,sensors = <13>;
> > +                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> > +                                 <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "uplow", "critical";
> > +                    #thermal-sensor-cells = <1>;
> > +            };
> > +
> > +            tsens1: thermal-sensor@c265000 {
> > +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
> > +                          <0 0x0c223000 0 0x1ff>; /* SROT */
> > +                    #qcom,sensors = <8>;
> > +                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> > +                                 <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "uplow", "critical";
> > +                    #thermal-sensor-cells = <1>;
> > +            };
> > +    };
> > +
> > +    /* ... */
> > +
> > +    thermal-zones {
> > +            cpu0-thermal {
> > +                    polling-delay-passive = <250>;
> > +                    polling-delay = <1000>;
> > +
> > +                    thermal-sensors = <&tsens0 1>;
> > +
> > +                    trips {
> > +                            cpu0_alert0: trip-point0 {
> > +                                    temperature = <90000>;
> > +                                    hysteresis = <2000>;
> > +                                    type = "passive";
> > +                            };
> > +
> > +                            cpu0_alert1: trip-point1 {
> > +                                    temperature = <95000>;
> > +                                    hysteresis = <2000>;
> > +                                    type = "passive";
> > +                            };
> > +
> > +                            cpu0_crit: cpu_crit {
> > +                                    temperature = <110000>;
> > +                                    hysteresis = <1000>;
> > +                                    type = "critical";
> > +                            };
> > +                    };
> > +
> > +                    cooling-maps {
> > +                            map0 {
> > +                                    trip = <&cpu0_alert0>;
> > +                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>,
> > +                                                     <&CPU1 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>,
> > +                                                     <&CPU2 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>,
> > +                                                     <&CPU3 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>;
> > +                            };
> > +
> > +                            map1 {
> > +                                    trip = <&cpu0_alert1>;
> > +                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>,
> > +                                                     <&CPU1 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>,
> > +                                                     <&CPU2 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>,
> > +                                                     <&CPU3 THERMAL_NO_LIMIT
> > +                                                            THERMAL_NO_LIMIT>;
> > +                            };
> > +                    };
> > +            };
> > +
> > +            /* ... */
> > +
> > +            cluster0-thermal {
> > +                    polling-delay-passive = <250>;
> > +                    polling-delay = <1000>;
> > +
> > +                    thermal-sensors = <&tsens0 5>;
> > +
> > +                    trips {
> > +                            cluster0_alert0: trip-point0 {
> > +                                    temperature = <90000>;
> > +                                    hysteresis = <2000>;
> > +                                    type = "hot";
> > +                            };
> > +                            cluster0_crit: cluster0_crit {
> > +                                    temperature = <110000>;
> > +                                    hysteresis = <2000>;
> > +                                    type = "critical";
> > +                            };
> > +                    };
> > +            };
> > +
> > +            /* ... */
> > +
> > +            gpu-thermal-top {
>
> This one is not going to match (which should cause an error).

Good catch. Unfortunately, this isn't getting caught. Nor is the
12-char limitation before -thermal in the thermal zone name. I can't
figure out why.

> > +                    polling-delay-passive = <250>;
> > +                    polling-delay = <1000>;
> > +
> > +                    thermal-sensors = <&tsens0 11>;
> > +
> > +                    trips {
> > +                            gpu1_alert0: trip-point0 {
> > +                                    temperature = <90000>;
> > +                                    hysteresis = <2000>;
> > +                                    type = "hot";
> > +                            };
> > +                    };
> > +            };
> > +    };
> > +...
> > --
> > 2.20.1
> >
