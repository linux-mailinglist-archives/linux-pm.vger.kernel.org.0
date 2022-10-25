Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B397B60D606
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 23:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJYVNa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 17:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJYVNa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 17:13:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFF106A55
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 14:13:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a5so25232286edb.11
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ByTOKCULrSLwLlBGRIeVAgvWUWQgG9lN44ptA5ZES40=;
        b=cih32NNOnQeRZiq0TLFfH9IL4cMQMT+vP4YzoNASMfErw0c3mf5epwKpEarhanVt7t
         Zlkk0mNTpcl7rGdQkXp1WoM+r3LCyxRfU5OV5KbFZjomLua8eALLgSkrHYbnRfkDQ63N
         rIKRmhxzgAPpw5Qnx9PftLAIj6809NqdNFYg/NCIFMkghJDZXlUNSNT3hRhoQjdYERMV
         kF+6CY3cdaKYCVftsmm26C1m5vYdsz7JZERF/76SFV7IKhwed617B0jaCjnFE6CFmPyx
         JckL+dOVRnJVWewubIweulIlPytcGfWlgJIa2+mtU7KnHyPndOYBPJFjgA/pBXh//Lqg
         eQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByTOKCULrSLwLlBGRIeVAgvWUWQgG9lN44ptA5ZES40=;
        b=Iku8i/SpNrJ3vOYEcLmGr1E8d/JwIlPapzL7wvd3vN0eN3dC1vbfNG3pS3d8+iLZ4x
         tHVu/rWyYSt8CFLTm8YVOkQyu1Lih+03TxfVTLpiEj+Qtka2d/pPKX1O1fWbl+B+zR4e
         sQtUwj/tF5X6MRQlbv5p4IID0cufDqDCrc7nG39OINNxCyzvxsVJPyPrdU1sXNf9sYLo
         MpJtf1YSXwiUIVFUdmr3mTbFg4euP1vVnpriqSzLO7Jt7n9HO8jj0Jmam94vxqr/jY1+
         vs712vSld0XuZyN/tvn8avyeDXzGwm0S4RZyTPCUJhehysVbcMnJ/vypKWlhcbx12C62
         2F1A==
X-Gm-Message-State: ACrzQf31yJJzEvtann1DBJW5OvO7fbaFk4XwiziSlHIaMQq8x7qmXzzP
        HrJA8oYbT8pMQ5rbuDtChVnT/4yCy5nBDNh96N7uG+cWkxMUTRbb
X-Google-Smtp-Source: AMsMyM4lv9Kml39F8CvxpVFPHnR/jFxOgakD0jWl/uoYGqRk2WfoSVqii97LnBdEdhGquO8j3C6OSbfrjzgEeQd9y+Y=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr37671378edb.46.1666732406307; Tue, 25
 Oct 2022 14:13:26 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Oct 2022 23:13:15 +0200
Message-ID: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
Subject: Regression after recent changes to drivers/thermal/thermal_of.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Folks,

I have this in my dmesg in v6.1-rc1:

[    3.879229] ab8500-fg ab8500-fg.0: line impedance: 36000 uOhm
[    3.892793] power_supply ab8500_usb: Samsung SDI EB-L1M7FLU battery 1500 mAh
[    3.901663] thermal_sys: Failed to find 'trips' node
[    3.906635] thermal_sys: Failed to find trip points for thermistor id=0
[    3.913427] ntc-thermistor thermistor: unable to register as hwmon device.
[    3.920350] ntc-thermistor: probe of thermistor failed with error -22

The device tree looks like this
(arch/arm/boot/dts/ste-ux500-samsung-golden.dts):

        thermal-zones {
                battery-thermal {
                        /* This zone will be polled by the battery
temperature code */
                        polling-delay = <0>;
                        polling-delay-passive = <0>;
                        thermal-sensors = <&bat_therm>;
                };
        };

This is a thermal zone without trip points, which it seems like the new
code does not allow, also the bindings were patched to not allow this,
in commit 8c596324232d22e19f8df59ba03410b9b5b0f3d7
"dt-bindings: thermal: Fix missing required property"
but this broke my systems. The requirement to have trip points also
broke my device trees.

The reason why I have this is that the thermal zone is not managed
by the OF thermal core, but by the battery charging algorithm which
just retrieves the thermal zone and use it to read the temperature, see
commit 2b0e7ac0841b3906aeecf432567b02af683a596c
"power: supply: ab8500: Integrate thermal zone".

The code is using
thermal_zone_get_zone_by_name()
thermal_zone_get_temp()
and applying its own policy on the thermal zone in order to not
dulicate code.

I understand from the code and changes to the bindings that the
authors assume that no zones without trips exist but... well they
exist.

I understand that the bindings always said that trips are required
but ... thermal zones without trip points make a bit of sense.
It's just a zone without a policy. It can be observed even if it can't
be acted on.

How do you want to solve this? Can we make trips non-compulsory
again or shall I add dummy trip points to the device trees?

This:

diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index b0dce91aff4b..d00e9e6ebbf7 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -35,6 +35,15 @@ battery-thermal {
                        polling-delay = <0>;
                        polling-delay-passive = <0>;
                        thermal-sensors = <&bat_therm>;
+
+                       trips {
+                               /* Unused trip point to please the framework */
+                               dummy {
+                                       temperature = <700000>;
+                                       hysteresis = <2000>;
+                                       type = "passive";
+                               };
+                       };
                };
        };


Makes the thermal zone probe again. I can't see if that really solves
it because there are other possibly unrelated bugs.

There are some other users of thermal_zone_get_temp() and they
may be broken too, I haven't' looked close.

Yours,
Linus Walleij
