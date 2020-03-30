Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF18F19795B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 12:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgC3Kee (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 06:34:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33786 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgC3Ked (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 06:34:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id z65so20066430ede.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPOhyjyg+qG//E9KnpQ1mLh4HGsinrsLHjaD641g04c=;
        b=ACSvsBh7q95ipi88Pn9UOo3e32tcG9KrkdpfN7C9kIhxyg+PzQxsjZYWjzfNNE5JJv
         l07ISRyAg4M2yHP8s02mgUkX0QGYNdms7/UHK9qNCdRxIe9hSYWmcJqspLfnET8pOfCW
         SYguXhE2XhwN92RgqAcrMn9Vcp4+IG0MALVWHiOVUWPCj1wZFAn22NPnbExWKxWHf1NA
         rsOtaKKMmou0qxjS29TjALGqkzvixQHxFnEhPOV18AZJgKBjjQkpP6CNwkHl560r8p3v
         mo2zmWoy4OZHct8BFfa2CrX3cVOadzLLUFvOBAJdLNLT1Vq33OfI5fRig0Pe8ONYHGBC
         8Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPOhyjyg+qG//E9KnpQ1mLh4HGsinrsLHjaD641g04c=;
        b=XwLK0B6qkgrsBaX6VD2gbJGWzsyz5EYgGhFfAyv7qWPXhm59VZpyjuZBzGV/Lf4UT4
         kf/muvhYNH8xqs9iZDIvsZdAm5s8vZmXO+NOEDCreZIe0SlyxxvJVx5w4EzgAehBjxaH
         4QaqXwfuFrSzBjnA9cYkV3Y5RHmnBiSbGJhv0Rb9t0JuEqDNQSiRfpv0yG9V1qS7rn9T
         64ycDhkNcZa+kz8UNacXCeH621xcBscUg8gxOki3C81uViqQRZ9aqldtOxZtoNI5xbfG
         wL7eYgE/VktJJrS3DZ1IwPnzvavfXvmvDClMpdJ+1a5yBBKXJhikV+I5uMFKHogx90co
         MH6g==
X-Gm-Message-State: ANhLgQ0gEUNDLNgoryx6cAwve/Y3CL+ccv7B3ki8qq2gB+TOo6bSV2eM
        cjvNxZ9M5Eo7sNJenrXcriWsDKb0WsQNGJjawla9Bg==
X-Google-Smtp-Source: ADFU+vuvWHGnq0/YuZUhp3RM0rW7+tCZrWHDFezzi9eX+CTdv2q4cGHnufRtfw1o5QzF28+dfZ0sNVd3tIemm/OP+Yw=
X-Received: by 2002:a17:906:319b:: with SMTP id 27mr10502059ejy.240.1585564470386;
 Mon, 30 Mar 2020 03:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585117436.git.amit.kucheria@linaro.org>
 <9c447186008ef2e3f4c3e712458dc0ddcd8a8b03.1585117436.git.amit.kucheria@linaro.org>
 <81b0cbe1-23c8-b4a3-4775-62e7d6c49b6b@arm.com> <CAP245DWS=yqNQpbk3Y8_0KjcBurSyQbNW9jqepSz8LC=ruFWhA@mail.gmail.com>
In-Reply-To: <CAP245DWS=yqNQpbk3Y8_0KjcBurSyQbNW9jqepSz8LC=ruFWhA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 30 Mar 2020 16:04:19 +0530
Message-ID: <CAHLCerMRcPmE70kN1Cyxio4_Dd1OoWT3iZ4vpzYKQVfORS336Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 25, 2020 at 9:12 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Wed, Mar 25, 2020 at 4:36 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> >
> >
> > On 3/25/20 6:34 AM, Amit Kucheria wrote:
> > > As part of moving the thermal bindings to YAML, split it up into 3
> > > bindings: thermal sensors, cooling devices and thermal zones.
> > >
> > > The thermal-zone binding is a software abstraction to capture the
> > > properties of each zone - how often they should be checked, the
> > > temperature thresholds (trips) at which mitigation actions need to be
> > > taken and the level of mitigation needed at those thresholds.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > > Changes since v2:
> > > - Addressed review comment from Rob
> > > - Added required properties for thermal-zones node
> > > - Added select: true to thermal-cooling-devices.yaml
> > > - Fixed up example to pass dt_binding_check
> > >
> > >   .../bindings/thermal/thermal-zones.yaml       | 324 ++++++++++++++++++
> > >   1 file changed, 324 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > new file mode 100644
> > > index 000000000000..5632304dcf62
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > @@ -0,0 +1,324 @@
> > > +# SPDX-License-Identifier: (GPL-2.0)
> > > +# Copyright 2020 Linaro Ltd.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/base.yaml#
> > > +
> > > +title: Thermal zone binding
> > > +
> > > +maintainers:
> > > +  - Amit Kucheria <amitk@kernel.org>
> > > +
> > > +description: |
> > > +  Thermal management is achieved in devicetree by describing the sensor hardware
> > > +  and the software abstraction of cooling devices and thermal zones required to
> > > +  take appropriate action to mitigate thermal overloads.
> > > +
> > > +  The following node types are used to completely describe a thermal management
> > > +  system in devicetree:
> > > +   - thermal-sensor: device that measures temperature, has SoC-specific bindings
> > > +   - cooling-device: device used to dissipate heat either passively or actively
> > > +   - thermal-zones: a container of the following node types used to describe all
> > > +     thermal data for the platform
> > > +
> > > +  This binding describes the thermal-zones.
> > > +
> > > +  The polling-delay properties of a thermal-zone are bound to the maximum dT/dt
> > > +  (temperature derivative over time) in two situations for a thermal zone:
> > > +    1. when passive cooling is activated (polling-delay-passive)
> > > +    2. when the zone just needs to be monitored (polling-delay) or when
> > > +       active cooling is activated.
> > > +
> > > +  The maximum dT/dt is highly bound to hardware power consumption and
> > > +  dissipation capability. The delays should be chosen to account for said
> > > +  max dT/dt, such that a device does not cross several trip boundaries
> > > +  unexpectedly between polls. Choosing the right polling delays shall avoid
> > > +  having the device in temperature ranges that may damage the silicon structures
> > > +  and reduce silicon lifetime.
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    const: thermal-zones
> > > +    description:
> > > +      A /thermal-zones node is required in order to use the thermal framework to
> > > +      manage input from the various thermal zones in the system in order to
> > > +      mitigate thermal overload conditions. It does not represent a real device
> > > +      in the system, but acts as a container to link thermal sensor devices,
> >
> > I would say 'thermal sensor device', since there is 1-to-1 mapping and
> > aggregating a few sensors inside one tz is not allowed (or I missed
> > some patches queuing).
>
> See below.
>
> >
> > > +      platform-data regarding temperature thresholds and the mitigation actions
> > > +      to take when the temperature crosses those thresholds.
> > > +
> > > +patternProperties:
> > > +  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
> > > +    type: object
> > > +    description:
> > > +      Each thermal zone node contains information about how frequently it
> > > +      must be checked, the sensor responsible for reporting temperature for
> > > +      this zone, one sub-node containing the various trip points for this
> > > +      zone and one sub-node containing all the zone cooling-maps.
> > > +
> > > +    properties:
> > > +      polling-delay:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description:
> > > +          The maximum number of milliseconds to wait between polls when
> > > +          checking this thermal zone. Setting this to 0 disables the polling
> > > +          timers setup by the thermal framework and assumes that the thermal
> > > +          sensors in this zone support interrupts.
> > > +
> > > +      polling-delay-passive:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description:
> > > +          The maximum number of milliseconds to wait between polls when
> > > +          checking this thermal zone while doing passive cooling. Setting
> > > +          this to 0 disables the polling timers setup by the thermal
> > > +          framework and assumes that the thermal sensors in this zone
> > > +          support interrupts.
> > > +
> > > +      thermal-sensors:
> > > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +        description:
> > > +          A list of thermal sensor phandles and sensor specifiers used to
> > > +          monitor this thermal zone.
> >
> > I don't know why it's not consistent with the actual code in
> > of-thermal.c, where there is even a comment stated:
> > /* For now, thermal framework supports only 1 sensor per zone */
> >
> > I think this is the place where developers should be informed about
> > the limitation and not even try to put more sensors into the list.
>
> That is a good point. I'm currently "porting" the existing binding as
> described in thermal.txt to yaml. If you look at some of the example
> (c) in there, the bindings allow many sensors to a zone mapping but
> the thermal core doesn't implement that functionality.
>
> So should we fix the core code or change the bindings? Thoughts - Rob,
> Daniel, Rui?

Rob, Daniel: Any comments? We don't have any concerns for Linux
backward compatibility since multiple sensors per zone isn't used
anywhere. But asking since bindings are supposed to be OS-agnostic.

> > > +
> > > +      trips:
> > > +        type: object
> > > +        description:
> > > +          This node describes a set of points in the temperature domain at
> > > +          which the thermal framework needs to takes action. The actions to
> >
> > s/needs to takes/needs to take/
>
> Will fix.
>
> > > +          be taken are defined in another node called cooling-maps.
> > > +
> > > +        patternProperties:
> > > +          "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$":
> > > +            type: object
> > > +
> > > +            properties:
> > > +              temperature:
> > > +                $ref: /schemas/types.yaml#/definitions/int32
> > > +                minimum: -273000
> > > +                maximum: 200000
> > > +                description:
> > > +                  An integer expressing the trip temperature in millicelsius.
> > > +
> > > +              hysteresis:
> > > +                $ref: /schemas/types.yaml#/definitions/uint32
> > > +                description:
> > > +                  An unsigned integer expressing the hysteresis delta with
> > > +                  respect to the trip temperature property above, also in
> > > +                  millicelsius.
> >
> > This property is worth a bit longer description.
>
> Will improve the description.
>
> > > +
> > > +              type:
> > > +                $ref: /schemas/types.yaml#/definitions/string
> > > +                enum:
> > > +                  - active   # enable active cooling e.g. fans
> > > +                  - passive  # enable passive cooling e.g. throttling cpu
> > > +                  - hot      # send notification to driver
> > > +                  - critical # send notification to driver, trigger shutdown
> > > +                description: |
> > > +                  There are four valid trip types: active, passive, hot,
> > > +                  critical.
> >
> > [snip]
> >
> > > +
> > > +    thermal-zones {
> > > +            cpu0-thermal {
> > > +                    polling-delay-passive = <250>;
> > > +                    polling-delay = <1000>;
> > > +
> > > +                    thermal-sensors = <&tsens0 1>;
> > > +
> > > +                    trips {
> > > +                            cpu0_alert0: trip-point0 {
> > > +                                    temperature = <90000>;
> > > +                                    hysteresis = <2000>;
> > > +                                    type = "passive";
> > > +                            };
> > > +
> > > +                            cpu0_alert1: trip-point1 {
> > > +                                    temperature = <95000>;
> > > +                                    hysteresis = <2000>;
> > > +                                    type = "passive";
> > > +                            };
> > > +
> > > +                            cpu0_crit: cpu_crit {
> > > +                                    temperature = <110000>;
> > > +                                    hysteresis = <1000>;
> > > +                                    type = "critical";
> > > +                            };
> > > +                    };
> > > +
> > > +                    cooling-maps {
> > > +                            map0 {
> > > +                                    trip = <&cpu0_alert0>;
> > > +                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
> > > +                                                            THERMAL_NO_LIMIT>,
> > > +                                                     <&CPU1 THERMAL_NO_LIMIT
> > > +                                                            THERMAL_NO_LIMIT>,
> > > +                                                     <&CPU2 THERMAL_NO_LIMIT
> > > +                                                            THERMAL_NO_LIMIT>,
> > > +                                                     <&CPU3 THERMAL_NO_LIMIT
> > > +                                                            THERMAL_NO_LIMIT>;
> > > +                            };
> > > +
> > > +                            map1 {
> > > +                                    trip = <&cpu0_alert1>;
> > > +                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
> > > +                                                            THERMAL_NO_LIMIT>,
> > > +                                                     <&CPU1 THERMAL_NO_LIMIT
> > > +                                                            THERMAL_NO_LIMIT>,
> > > +                                                     <&CPU2 THERMAL_NO_LIMIT
> > > +                                                            THERMAL_NO_LIMIT>,
> > > +                                                     <&CPU3 THERMAL_NO_LIMIT
> > > +                                                            THERMAL_NO_LIMIT>;
> >
> >  From this two examples of handling cpu0_alert0 and cpu0_alert1 you
> > cannot conclude anything (if you don't understand thermal framework (and
> > probably IPA). As a simple example it would be better to put a comment
> > with a description and limit min, max to a specific OPP:
> >
> > map0 {
> >      trip = <&cpu0_alert0>;
> >      /* Corresponds to 1400MHz in OPP table */
> >      cooling-device = <&CPU0 3 3>, <&CPU1 3 3>, <&CPU2 3 3>, <&CPU3 3 3>;
> > };
> >
> > map1 {
> >      trip = <&cpu0_alert1>;
> >      /* Corresponds to 1000MHz in OPP table */
> >      cooling-device = <&CPU0 5 5>, <&CPU1 5 5>, <&CPU2 5 5>, <&CPU3 5 5>;
> > };
> >
> > IMHO this kind of example would tell more to an avg driver developer.
>
> Will fix.
>
> Thanks for the review.
>
> Regards,
> Amit
