Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483860E625
	for <lists+linux-pm@lfdr.de>; Wed, 26 Oct 2022 19:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiJZRHC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 13:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiJZRHB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 13:07:01 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D080E8E
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 10:07:00 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id mi9so2839157qvb.8
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 10:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30vWFKXCeh6oN2n0TSnNP+V63AhRkkK+O+ua5NS86k8=;
        b=vNwW3bMTFbYv0Ca0dKJC6X9kzxevTmN10vNITd2at5/OkuBixDl4mwn78kHjzKF8+t
         ka4LAuCyUcLBUaCZEf1xVpm63fk/QM2NT8prVGjpUyTm3rnN+VtJ5TZ2w5OCM8FaNMaX
         rVkeRQULDjmFcWMOb6EKaI0+gAxewafs/QKycVTHdxZEcKEz5v9Z9FEZSltqKMTtzmP7
         wkFvpqixIS7vUFbxMBFJkZ9cxh71fFObm4CaR072X4A5FY73wx4mWik++iQq3LDpNl9N
         kwBqpUenb706JP2jNAqWZ+mx7HR4kFL/RnxIVHfO+68doqTAjG38FLLHDLgw3/5MrFwS
         sgxg==
X-Gm-Message-State: ACrzQf0GTKG3MExL8Vq5MCbgGVj+HHKKqZLTn8QVBbbOFA0DQj/dlbot
        isVTuG+JKnP5o+DEaY4EYCp7rf1bVgGgPS1Lvoahnx0o
X-Google-Smtp-Source: AMsMyM6DchZkDV6vxt4NxDBP5bXr1EOB5OuzpLbJNj7P5+TtvWk5RLzT4A/0IZUPcD9E851ouTt8JQdAbpYMXko0zz0=
X-Received: by 2002:a05:6214:238f:b0:4bb:7bf:770b with SMTP id
 fw15-20020a056214238f00b004bb07bf770bmr24051896qvb.52.1666804019269; Wed, 26
 Oct 2022 10:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
 <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
In-Reply-To: <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Oct 2022 19:06:47 +0200
Message-ID: <CAJZ5v0i76X0TiaOhPa3a5440fRb7vA1z1mFKJibso8G6wYz7HQ@mail.gmail.com>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 26, 2022 at 5:47 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Oct 25, 2022 at 4:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Hi Folks,
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

I agree and the code change is not just a revert AFAICS.

This is Daniel's work, so I'm still hoping that he'll chime in
shortly, but in any case the code has to work with the existing
setups, no question about that.
