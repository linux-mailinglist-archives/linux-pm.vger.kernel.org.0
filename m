Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74A60E4FD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Oct 2022 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiJZPrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Oct 2022 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJZPrm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2022 11:47:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FE2B2740
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 08:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABC0AB82347
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 15:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F30C433D7
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666799259;
        bh=GeuzFs8pWdAUzydmtLOfzBZk/JsujbY7OpcIJfpOIOA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z1jcSux9KvG9K9756+Xvm7GhfmuMfnSX5xRjRmNgp3IclbYjCTbgVj9bsXo0W0PIe
         L5xczQ4/f9me2ZCVP3LWGanZVehQk/4q7NDc2tV9zEYbIt1yKyP2TvCBnfVEWc10nr
         gNWi/5Ij4Z26LlyLr9P2YfVJ5pJa7DWCCXKtRePxlQMDrQSPx/6rj7RuF1GoNvSfCy
         ck36836uJZiB7JUqYOhduG/D3LQtARunJM7qTT4P/lGtM9Q4LOuCjxOuQQ5M+hvv3E
         CswqAvNaG7WSvJ1XoJ836X5r7P0s647Tfeaow6XYnak3bMeuFlEGRZjVfjVvHUESGz
         vyd3ZU4rZEuhg==
Received: by mail-lf1-f48.google.com with SMTP id bp15so29425358lfb.13
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2022 08:47:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ab4gyUuxW9UixfrJEkKRbkptxGyfpN82ypflWeLWKvreN01Ls
        /SOsZGQO4NtQUN+L6o2yGio4gGOe8mWdEq4A1g==
X-Google-Smtp-Source: AMsMyM70ghQtyjmgwgteRkJSa4oxbTr+2vJScE2yTCiLfUczWgz57+uLTRmGrDh9OrBF9ajyxL+WnCoryLrzZ3V0r98=
X-Received: by 2002:ac2:4c03:0:b0:4a2:2273:89c6 with SMTP id
 t3-20020ac24c03000000b004a2227389c6mr14946911lfq.245.1666799257316; Wed, 26
 Oct 2022 08:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
In-Reply-To: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Oct 2022 10:47:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
Message-ID: <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 25, 2022 at 4:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Folks,
>
> I have this in my dmesg in v6.1-rc1:
>
> [    3.879229] ab8500-fg ab8500-fg.0: line impedance: 36000 uOhm
> [    3.892793] power_supply ab8500_usb: Samsung SDI EB-L1M7FLU battery 1500 mAh
> [    3.901663] thermal_sys: Failed to find 'trips' node
> [    3.906635] thermal_sys: Failed to find trip points for thermistor id=0
> [    3.913427] ntc-thermistor thermistor: unable to register as hwmon device.
> [    3.920350] ntc-thermistor: probe of thermistor failed with error -22
>
> The device tree looks like this
> (arch/arm/boot/dts/ste-ux500-samsung-golden.dts):
>
>         thermal-zones {
>                 battery-thermal {
>                         /* This zone will be polled by the battery
> temperature code */
>                         polling-delay = <0>;
>                         polling-delay-passive = <0>;
>                         thermal-sensors = <&bat_therm>;
>                 };
>         };
>
> This is a thermal zone without trip points, which it seems like the new
> code does not allow, also the bindings were patched to not allow this,
> in commit 8c596324232d22e19f8df59ba03410b9b5b0f3d7
> "dt-bindings: thermal: Fix missing required property"
> but this broke my systems. The requirement to have trip points also
> broke my device trees.
>
> The reason why I have this is that the thermal zone is not managed
> by the OF thermal core, but by the battery charging algorithm which
> just retrieves the thermal zone and use it to read the temperature, see
> commit 2b0e7ac0841b3906aeecf432567b02af683a596c
> "power: supply: ab8500: Integrate thermal zone".
>
> The code is using
> thermal_zone_get_zone_by_name()
> thermal_zone_get_temp()
> and applying its own policy on the thermal zone in order to not
> dulicate code.
>
> I understand from the code and changes to the bindings that the
> authors assume that no zones without trips exist but... well they
> exist.
>
> I understand that the bindings always said that trips are required
> but ... thermal zones without trip points make a bit of sense.
> It's just a zone without a policy. It can be observed even if it can't
> be acted on.
>
> How do you want to solve this? Can we make trips non-compulsory
> again or shall I add dummy trip points to the device trees?
>
> This:
>
> diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> index b0dce91aff4b..d00e9e6ebbf7 100644
> --- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> +++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> @@ -35,6 +35,15 @@ battery-thermal {
>                         polling-delay = <0>;
>                         polling-delay-passive = <0>;
>                         thermal-sensors = <&bat_therm>;
> +
> +                       trips {
> +                               /* Unused trip point to please the framework */
> +                               dummy {
> +                                       temperature = <700000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +                       };

That's ugly and requiring a DT update breaks the ABI. So the
requirement for 'trips' should be reverted. (Well the schema should, I
imagine the code change is not just a revert.)

Rob
