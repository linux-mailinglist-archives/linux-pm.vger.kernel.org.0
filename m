Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4E1614608
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 09:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiKAIwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Nov 2022 04:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKAIwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2022 04:52:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02AB7186D1
        for <linux-pm@vger.kernel.org>; Tue,  1 Nov 2022 01:52:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA0F61FB;
        Tue,  1 Nov 2022 01:52:38 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0313F5A1;
        Tue,  1 Nov 2022 01:52:31 -0700 (PDT)
Date:   Tue, 1 Nov 2022 08:52:21 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
Message-ID: <Y2DeRT6T+yiXJ8Kg@e120937-lin>
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
 <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 26, 2022 at 10:47:28AM -0500, Rob Herring wrote:
> On Tue, Oct 25, 2022 at 4:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Hi Folks,

Hi,

> >
> > I have this in my dmesg in v6.1-rc1:
> >
> > [    3.879229] ab8500-fg ab8500-fg.0: line impedance: 36000 uOhm
> > [    3.892793] power_supply ab8500_usb: Samsung SDI EB-L1M7FLU battery 1500 mAh
> > [    3.901663] thermal_sys: Failed to find 'trips' node
> > [    3.906635] thermal_sys: Failed to find trip points for thermistor id=0
> > [    3.913427] ntc-thermistor thermistor: unable to register as hwmon device.
> > [    3.920350] ntc-thermistor: probe of thermistor failed with error -22
> >
> > The device tree looks like this
> > (arch/arm/boot/dts/ste-ux500-samsung-golden.dts):
> >
> >         thermal-zones {
> >                 battery-thermal {
> >                         /* This zone will be polled by the battery
> > temperature code */
> >                         polling-delay = <0>;
> >                         polling-delay-passive = <0>;
> >                         thermal-sensors = <&bat_therm>;
> >                 };
> >         };
> >
> > This is a thermal zone without trip points, which it seems like the new
> > code does not allow, also the bindings were patched to not allow this,
> > in commit 8c596324232d22e19f8df59ba03410b9b5b0f3d7
> > "dt-bindings: thermal: Fix missing required property"
> > but this broke my systems. The requirement to have trip points also
> > broke my device trees.
> >
> > The reason why I have this is that the thermal zone is not managed
> > by the OF thermal core, but by the battery charging algorithm which
> > just retrieves the thermal zone and use it to read the temperature, see
> > commit 2b0e7ac0841b3906aeecf432567b02af683a596c
> > "power: supply: ab8500: Integrate thermal zone".
> >
> > The code is using
> > thermal_zone_get_zone_by_name()
> > thermal_zone_get_temp()
> > and applying its own policy on the thermal zone in order to not
> > dulicate code.
> >
> > I understand from the code and changes to the bindings that the
> > authors assume that no zones without trips exist but... well they
> > exist.
> >
> > I understand that the bindings always said that trips are required
> > but ... thermal zones without trip points make a bit of sense.
> > It's just a zone without a policy. It can be observed even if it can't
> > be acted on.
> >
> > How do you want to solve this? Can we make trips non-compulsory
> > again or shall I add dummy trip points to the device trees?
> >
> > This:
> >
> > diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> > b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> > index b0dce91aff4b..d00e9e6ebbf7 100644
> > --- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> > +++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> > @@ -35,6 +35,15 @@ battery-thermal {
> >                         polling-delay = <0>;
> >                         polling-delay-passive = <0>;
> >                         thermal-sensors = <&bat_therm>;
> > +
> > +                       trips {
> > +                               /* Unused trip point to please the framework */
> > +                               dummy {
> > +                                       temperature = <700000>;
> > +                                       hysteresis = <2000>;
> > +                                       type = "passive";
> > +                               };
> > +                       };
> 
> That's ugly and requiring a DT update breaks the ABI. So the
> requirement for 'trips' should be reverted. (Well the schema should, I
> imagine the code change is not just a revert.)
> 

I chime in just to say that I went through the same ordeal a few days ago
on a JUNO board where a number of thermal zones were defined but no trip
points ever.

Given that seemed that the 'trips' were always mandatory even though not
enforced (and for a while 'lapsed') AND given that on JUNO we indeed
use thermal zones for thermal monitoring purposes, I posted anyway a
fix[1] which adds a couple of critical trips, so that the framework is
pleased and maybe my setup hopefully fireproof :P


Thanks,
Cristian

[1]: https://lore.kernel.org/linux-arm-kernel/20221028140833.280091-8-cristian.marussi@arm.com/
