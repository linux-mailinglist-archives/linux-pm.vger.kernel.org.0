Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9309D179A9D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 22:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbgCDVDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 16:03:02 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33829 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgCDVDC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 16:03:02 -0500
Received: by mail-vs1-f66.google.com with SMTP id y204so2154165vsy.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 13:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSWbLAptYGm4youMYgWgnMN5qqb706efy6UOGCdWvcQ=;
        b=K49C+fYSdfa4qTb8U+6tb88/iuugs66Yo2DVdIczMqBe6W4j84aoX5JMToOwvzKmf3
         utiGUUMiOdaBT/cDU6m0uhr5feLj9DrW+eni9RNCkSIU/m00M/eP8rmFlHctEFH0RUJ3
         RlaVxwnX0o804N47nONMX28oVdZVBsksp4rg2IEJnotoobcrBNB69JWNxWrI3GO4QY9t
         PSyBiFAHvL+K1fYKQh8KxkII20W/8mOMjfYWPphz6o/XiAA2O50v7aRGX7P9xa2gBRWJ
         rU5FNOfZe55zyfYL8Wpr7+7BJiCeqcQEvd2tqqkV40C6nPMyGYEPDVE6ipMH8djlYDEM
         78GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSWbLAptYGm4youMYgWgnMN5qqb706efy6UOGCdWvcQ=;
        b=ZrcDrMWq9t8IzGwuMIhEALgdwCrs2Ivg7719nznwPJpoJrMAP1CFmT0qVlgJKBJhgL
         r94rgDH7k3wkxUtASNvCkooyj4hKWWXv7P4edguTGUl8Vq2+IFRlRnAII68ZDwi/BY7A
         51xlfgTTImBSiXdrzYfK1DysPo78PNjIE4csIFNJY4vpD3Z5z7SCaL4kHn07QYGhwBPY
         hUxFThL39rSOjnI45h7oZnoHCmiIenPeFQrkwtIAhcOzu3HmYSMC1LZANn0zYg4+E4l5
         JG7gKnalO8L/OGov+Kkv5OLWsOzMu8r0kOTMOIUTf4UsUglozDZj64lnlMj3Yp33AGBD
         MCyA==
X-Gm-Message-State: ANhLgQ398dWuse5pTfsnUh+jQl4R4Ww8XmzhC2Gym8fPKty1zSY49v03
        tQKGW2UhckDiUzstwzYjSAwfxSLMVJq5aR4TAzsfng==
X-Google-Smtp-Source: ADFU+vvuIaCJ9RoJIG1WciLy4L7eJyoFJkFSRigHOLZeFlCU/g+PxtzylpEHh1UjrV15fqmxiNhhq3ZwJB6/YQhziJc=
X-Received: by 2002:a67:e99a:: with SMTP id b26mr2947573vso.27.1583355779012;
 Wed, 04 Mar 2020 13:02:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582528977.git.amit.kucheria@linaro.org>
 <59d24f8ec98e29d119c5cbdb2abe6d4644cc51cf.1582528977.git.amit.kucheria@linaro.org>
 <CAL_Jsq+wBF-VGmaaDk6EYzE=4g7Yq=w15WLL=mLjiR5FmxdWkQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+wBF-VGmaaDk6EYzE=4g7Yq=w15WLL=mLjiR5FmxdWkQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 5 Mar 2020 02:32:47 +0530
Message-ID: <CAHLCerMB2Nde-Gre+2pyNcd3AW2kDPSgo8KqON4V5vMUXZN1kw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 3:24 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Feb 24, 2020 at 1:26 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
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
> >  .../bindings/thermal/thermal-zones.yaml       | 302 ++++++++++++++++++
> >  1 file changed, 302 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > new file mode 100644
> > index 000000000000..bc1ce8e41324
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > @@ -0,0 +1,302 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
>
> Why MIT instead of BSD-2-Clause? And do you have rights to add that?
> Any text you copied over from the .txt file was only GPL2. Relicensing
> would be nice if you can get permission from the authors.

Changed back to GPL2. I will send out a separate email to get
permission for relicensing the bindings.

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
> > +   - cooling-device: device used to dissipate heat either passively or artively
>
> typo

Fixed.

>
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
> > +    properties:
> > +      $nodename:
> > +        pattern: "^[a-zA-Z][a-zA-Z0-9,\\-]{1,12}-thermal$"
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
> > +            description:
> > +              The maximum number of milliseconds to wait between polls when
> > +              checking this thermal zone. Setting this to 0 disables the polling
> > +              timers setup by the thermal framework and assumes that the thermal
> > +              sensors in this zone support interrupts.
> > +
> > +          polling-delay-passive:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            minimum: 0
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
> > +                type: object
> > +
> > +                properties:
> > +                  temperature:
> > +                    $ref: /schemas/types.yaml#/definitions/int32
> > +                    description:
> > +                      An integer expressing the trip temperature in millicelsius.
>
> Wouldn't 200000 mC be a reasonable max? And -273000 mC min.

It would indeed. :-)

> > +
> > +                  hysteresis:
> > +                    $ref: /schemas/types.yaml#/definitions/uint32
> > +                    description:
> > +                      An unsigned integer expressing the hysteresis delta with
> > +                      respect to the trip temperature property above, also in
> > +                      millicelsius.
> > +
> > +                  type:
> > +                    oneOf:
> > +                      - items:
> > +                        - enum:
>
> Drop oneOf and items. Just enum is enough.

Fixed.

>
> > +                            - active
> > +                            - passive
> > +                            - hot
> > +                            - critical
> > +                    description: |
> > +                      There are four valid trip types,
> > +                       - active   - enable active cooling e.g. fans
> > +                       - passive  - enable passive cooling e.g. throttling cpu
> > +                       - hot      - send notification to driver if .notify
> > +                                    callback registered
> > +                       - critical - send notification to driver if .notify
> > +                                    callback registered and trigger a shutdown
>
> Perhaps make these comments on each enum entry.

I've moved the one-line descriptions to comments before each enum
entry. However, I ended up adding more detailed descriptions in the
description sections because I felt these are not well-defined in
documentation. Let me know what you think.

> > +
> > +                required:
> > +                  - temperature
> > +                  - hysteresis
> > +                  - type
>
> 'additionalProperties: false'? Or can the node have other properties?

Added.

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
>
> 'additionalProperties: false'?

Added

Thanks for the review.


>
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
> > +                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "uplow";
> > +                    #thermal-sensor-cells = <1>;
> > +            };
> > +
> > +            tsens1: thermal-sensor@c265000 {
> > +                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> > +                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
> > +                          <0 0x0c223000 0 0x1ff>; /* SROT */
> > +                    #qcom,sensors = <8>;
> > +                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
> > +                    interrupt-names = "uplow";
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
