Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04168192D16
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCYPmZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 11:42:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34582 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgCYPmZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 11:42:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10so2742958ljn.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6XG2whFohVXd5AQ1C08EQE0cymLHuuX/8O3HKq2GsE=;
        b=B6czuBxu/KoDXNV9D7lleVdMipVKCiFPokLMcLU3Ib25+PRalf11CH6ny8ey3s5ZAA
         mQGh4jVnYM/qc8OsJkIkYT9plVvcMQP0wsDSj/YUnfr5AbjSkUY+uEMELlhG8XWi7t9j
         gYVD99QrAKlQoeJMRtHiWvNhXBVcXLVPXKx/AMDV5qL0XK9V0ElCG4e9zuxIHpleGMT2
         bga3o6dWNj9bV/wQpnRDNEsIygsY3yXaPp0d1Y+51Luw6wfSFdBqVLiZpLzzOpQSR8EK
         y+wMxih7R6YbX3AifEUy4sWGg1eQUOnLBkICfXPLwXj+vCKOZTGIc46tb846tE/n65YY
         /G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6XG2whFohVXd5AQ1C08EQE0cymLHuuX/8O3HKq2GsE=;
        b=neymsxLhQN2TEBE67JbiiRESVSz/uy4A/CtbqxSIBP8WU83UXyEJqPuXXYkikAeMcs
         rm+9cDeEQgLuZjAgViKTxNUkiZ1U3QY8oYleNkx5oxdBOTd1qIfJDbFagnqggT9kZu2S
         HJJRF6JXptiCIXq7do1LO5/KgLsjuUGblZorvBKHSmSK1PKuGerDeN1QTPpbRJ1r690S
         TvmYFC1FmOe7eBe3qWWccJ1Bzi30xlCywyxBshkHaU2vT91Kxjvp1wsLhEvUQLWqhnQ8
         QSNw2oSnU+ccCS6fCUAMjFbvdm/iqDay2MFbDN35LWXE8aovjkSY5K6sa8LDrPv6q5lR
         x5iQ==
X-Gm-Message-State: ANhLgQ077JQ7glRRefbzbogtAnFa3GohOTajOGNyaZmtfq4Klrp3sXNd
        NItPoipmfOMiOZkNd7eP44SpBlpOfqFoU4IIZAzB3A==
X-Google-Smtp-Source: ADFU+vt4onp6VYyb/EthhQCkNnINPTTy+Y66DjO8zjSXv4OsQWR3PTNC2NXDnOxqaO0LJVbAbBXI03fGiRBXTHN3yYk=
X-Received: by 2002:a05:651c:1044:: with SMTP id x4mr2232515ljm.230.1585150941481;
 Wed, 25 Mar 2020 08:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585117436.git.amit.kucheria@linaro.org>
 <9c447186008ef2e3f4c3e712458dc0ddcd8a8b03.1585117436.git.amit.kucheria@linaro.org>
 <81b0cbe1-23c8-b4a3-4775-62e7d6c49b6b@arm.com>
In-Reply-To: <81b0cbe1-23c8-b4a3-4775-62e7d6c49b6b@arm.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 25 Mar 2020 21:12:10 +0530
Message-ID: <CAP245DWS=yqNQpbk3Y8_0KjcBurSyQbNW9jqepSz8LC=ruFWhA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 4:36 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 3/25/20 6:34 AM, Amit Kucheria wrote:
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
> > Changes since v2:
> > - Addressed review comment from Rob
> > - Added required properties for thermal-zones node
> > - Added select: true to thermal-cooling-devices.yaml
> > - Fixed up example to pass dt_binding_check
> >
> >   .../bindings/thermal/thermal-zones.yaml       | 324 ++++++++++++++++++
> >   1 file changed, 324 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > new file mode 100644
> > index 000000000000..5632304dcf62
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > @@ -0,0 +1,324 @@
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
> > +  $nodename:
> > +    const: thermal-zones
> > +    description:
> > +      A /thermal-zones node is required in order to use the thermal framework to
> > +      manage input from the various thermal zones in the system in order to
> > +      mitigate thermal overload conditions. It does not represent a real device
> > +      in the system, but acts as a container to link thermal sensor devices,
>
> I would say 'thermal sensor device', since there is 1-to-1 mapping and
> aggregating a few sensors inside one tz is not allowed (or I missed
> some patches queuing).

See below.

>
> > +      platform-data regarding temperature thresholds and the mitigation actions
> > +      to take when the temperature crosses those thresholds.
> > +
> > +patternProperties:
> > +  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
> > +    type: object
> > +    description:
> > +      Each thermal zone node contains information about how frequently it
> > +      must be checked, the sensor responsible for reporting temperature for
> > +      this zone, one sub-node containing the various trip points for this
> > +      zone and one sub-node containing all the zone cooling-maps.
> > +
> > +    properties:
> > +      polling-delay:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          The maximum number of milliseconds to wait between polls when
> > +          checking this thermal zone. Setting this to 0 disables the polling
> > +          timers setup by the thermal framework and assumes that the thermal
> > +          sensors in this zone support interrupts.
> > +
> > +      polling-delay-passive:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          The maximum number of milliseconds to wait between polls when
> > +          checking this thermal zone while doing passive cooling. Setting
> > +          this to 0 disables the polling timers setup by the thermal
> > +          framework and assumes that the thermal sensors in this zone
> > +          support interrupts.
> > +
> > +      thermal-sensors:
> > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > +        description:
> > +          A list of thermal sensor phandles and sensor specifiers used to
> > +          monitor this thermal zone.
>
> I don't know why it's not consistent with the actual code in
> of-thermal.c, where there is even a comment stated:
> /* For now, thermal framework supports only 1 sensor per zone */
>
> I think this is the place where developers should be informed about
> the limitation and not even try to put more sensors into the list.

That is a good point. I'm currently "porting" the existing binding as
described in thermal.txt to yaml. If you look at some of the example
(c) in there, the bindings allow many sensors to a zone mapping but
the thermal core doesn't implement that functionality.

So should we fix the core code or change the bindings? Thoughts - Rob,
Daniel, Rui?

> > +
> > +      trips:
> > +        type: object
> > +        description:
> > +          This node describes a set of points in the temperature domain at
> > +          which the thermal framework needs to takes action. The actions to
>
> s/needs to takes/needs to take/

Will fix.

> > +          be taken are defined in another node called cooling-maps.
> > +
> > +        patternProperties:
> > +          "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$":
> > +            type: object
> > +
> > +            properties:
> > +              temperature:
> > +                $ref: /schemas/types.yaml#/definitions/int32
> > +                minimum: -273000
> > +                maximum: 200000
> > +                description:
> > +                  An integer expressing the trip temperature in millicelsius.
> > +
> > +              hysteresis:
> > +                $ref: /schemas/types.yaml#/definitions/uint32
> > +                description:
> > +                  An unsigned integer expressing the hysteresis delta with
> > +                  respect to the trip temperature property above, also in
> > +                  millicelsius.
>
> This property is worth a bit longer description.

Will improve the description.

> > +
> > +              type:
> > +                $ref: /schemas/types.yaml#/definitions/string
> > +                enum:
> > +                  - active   # enable active cooling e.g. fans
> > +                  - passive  # enable passive cooling e.g. throttling cpu
> > +                  - hot      # send notification to driver
> > +                  - critical # send notification to driver, trigger shutdown
> > +                description: |
> > +                  There are four valid trip types: active, passive, hot,
> > +                  critical.
>
> [snip]
>
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
>
>  From this two examples of handling cpu0_alert0 and cpu0_alert1 you
> cannot conclude anything (if you don't understand thermal framework (and
> probably IPA). As a simple example it would be better to put a comment
> with a description and limit min, max to a specific OPP:
>
> map0 {
>      trip = <&cpu0_alert0>;
>      /* Corresponds to 1400MHz in OPP table */
>      cooling-device = <&CPU0 3 3>, <&CPU1 3 3>, <&CPU2 3 3>, <&CPU3 3 3>;
> };
>
> map1 {
>      trip = <&cpu0_alert1>;
>      /* Corresponds to 1000MHz in OPP table */
>      cooling-device = <&CPU0 5 5>, <&CPU1 5 5>, <&CPU2 5 5>, <&CPU3 5 5>;
> };
>
> IMHO this kind of example would tell more to an avg driver developer.

Will fix.

Thanks for the review.

Regards,
Amit
