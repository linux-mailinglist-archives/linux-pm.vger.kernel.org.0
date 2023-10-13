Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6D7C8605
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJMMqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 08:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMMqM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 08:46:12 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CB8C9;
        Fri, 13 Oct 2023 05:46:10 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c4b9e09528so1293853a34.3;
        Fri, 13 Oct 2023 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697201169; x=1697805969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff7HfvAhb1UMBPqBacU+KVHJKUyK4NxVafqckPtz1Tc=;
        b=miV0qHkv0izPOizyniBaJPiembj6O9bo1uVy/J03aHd96Onjv9NfbNUSPlecvMxd3f
         xJS2xI+6WK52SW0d4UJ8nF8UUS7ej0oaXvuFGHZfE85+iptUoUX2gQEg9y7OUNrqOYDG
         CPxxYKako7Ggoy9Rhs0AMvqUopoP8cGOZlbf3qJokKoSC95LMx4lAV6+7Aill0bCgpJS
         5kekxQTGucRmI3Afv8SzCggMW366P1+BoMoQRIAhcCN7D4eVsQmR4+zn9tajCrBGBuRx
         M7v0O9riDhTjgP17jBcYCN+OMOKZaBU/buHK2uJ+3ycZBTBlITTJiQccM5lrsxRHBMs5
         M56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697201169; x=1697805969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ff7HfvAhb1UMBPqBacU+KVHJKUyK4NxVafqckPtz1Tc=;
        b=xHNQ9X/PXg1Oibd3AgIxct/QQqpwyJ+ew41HhIkBSdiXyaJsfXhPqtW6NJLypOiHXm
         Sx3/wxMB9DBcfdCjGPDfnm7SchkkMPhKVgaeZ5ubDavnUofyYWH0gaW/9YBGozTcwpJv
         NWMOr/Lwz0t7fwWVaaQnodxc2rtndHtn0t+5CqKbYo7uTNcldsqN9nLxxoL7EiELCC0F
         g6oM+4O15z8YzSaJPCY4AcCVesnn/X8rJOPZuETK877UCNLGuS9RvsdPrP7fNYM0jMiL
         25w+2E4Vwus1eUXfGrcmacDkX8s47fO150CHSr8UNZfsN+xJ0UDsNIcFI0mBe3DN3P02
         XlJQ==
X-Gm-Message-State: AOJu0Yy9d9J7YLMYoKeO6oM74lEn25ZAxwkEYeA4WI7HfHmuquxOKghm
        AIgFDe9tV38eKF0TnMQq8F4hT/SrAdSJfg/kmaY=
X-Google-Smtp-Source: AGHT+IFGPDfwzJhaqs/Ltq2iQe4wWiJjdhO7Us5y+BmOpuU1iCYaB5FzqnNLqhsPWD6NY139KuUv7tJUkl8WNMEVoRg=
X-Received: by 2002:a9d:7843:0:b0:6c4:f095:7b76 with SMTP id
 c3-20020a9d7843000000b006c4f0957b76mr26382558otm.31.1697201169172; Fri, 13
 Oct 2023 05:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <CABr+WTkT4LSYrMPVpxYO4VT87xoFA98qA9wFQMwoO4b4J8gF3g@mail.gmail.com> <ZSktVaje_h2Hiyy6@orome.fritz.box>
In-Reply-To: <ZSktVaje_h2Hiyy6@orome.fritz.box>
From:   Nicolas Chauvet <kwizart@gmail.com>
Date:   Fri, 13 Oct 2023 14:45:57 +0200
Message-ID: <CABr+WTk9EGqVQ3_5579RmLVvOZj_NzNN3U8JMbyrQze5-9Wx8A@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] thermal: tegra: Do not register cooling device
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le ven. 13 oct. 2023 =C3=A0 13:43, Thierry Reding
<thierry.reding@gmail.com> a =C3=A9crit :
>
> On Fri, Oct 13, 2023 at 11:14:25AM +0200, Nicolas Chauvet wrote:
> > Le jeu. 12 oct. 2023 =C3=A0 19:58, Thierry Reding
> > <thierry.reding@gmail.com> a =C3=A9crit :
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Hi,
> > >
> > > this set of patches removes the registration of the SOCTHERM internal
> > > throttling mechanism as cooling device. Since this throttling starts
> > > automatically once a certain temperature threshold is crossed, it
> > > doesn't make sense to represent it as a cooling device, which are
> > > typically "manually" activated by the thermal framework when thermal
> > > sensors report temperature thresholds being crossed.
> > >
> > > Instead of using the cooling device mechanism, this statically progra=
ms
> > > the throttling mechanism when it is configured in device tree. In ord=
er
> > > to do this, an additional device tree property is needed to replace t=
he
> > > information that was previously contained in trip points.
> > >
> > > There's a few preparatory patches to make the removal a bit simpler a=
nd
> > > also some follow up cleanups included as well.
> > >
> > > Changes in v2:
> > > - rework the device tree bindings:
> > >   - add nvidia,thermal-zones property to attach throttling to zones
> > >   - use -millicelsius suffix and add hysteresis
> > > - add patch to store thermal zone device tree node for later use
> > > - add patch to enforce self-encapsulation of the thermal core now tha=
t
> > >   no drivers need to reach into it anymore
> > >
> > > This applies on top of Daniel's self-encapsulation hardening series:
> > >
> > >         https://lore.kernel.org/all/20231012102700.2858952-1-daniel.l=
ezcano@linaro.org/
> > >
> > > Thierry
> > >
> > > Thierry Reding (13):
> > >   thermal: Store device tree node for thermal zone devices
> > >   dt-bindings: thermal: tegra: Document throttle temperature
> > >   dt-bindings: thermal: tegra: Add nvidia,thermal-zones property
> > >   thermal: tegra: Use driver-private data consistently
> > >   thermal: tegra: Constify SoC-specific data
> > >   thermal: tegra: Do not register cooling device
> > >   thermal: tegra: Use unsigned int where appropriate
> > >   thermal: tegra: Avoid over-allocation of temporary array
> > >   thermal: tegra: Remove gratuitous error assignment
> > >   thermal: tegra: Minor stylistic cleanups
> > >   ARM: tegra: Rework SOCTHERM on Tegra124
> > >   arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
> > >   thermal: Enforce self-encapsulation
> > >
> > >  .../thermal/nvidia,tegra124-soctherm.yaml     |  19 +
> > >  arch/arm/boot/dts/nvidia/tegra124.dtsi        |  68 +--
> > >  arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  66 +--
> > >  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  86 +--
> > >  drivers/thermal/tegra/soctherm.c              | 525 ++++++++--------=
--
> > >  drivers/thermal/tegra/soctherm.h              |   1 +
> > >  drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
> > >  drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
> > >  drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
> > >  drivers/thermal/thermal_core.h                |   2 +-
> > >  drivers/thermal/thermal_of.c                  |   3 +
> > >  11 files changed, 329 insertions(+), 453 deletions(-)
> > >
> > > --
> > > 2.42.0
> > >
> >
> > I'm still experiencing the following message on jetson-tx1 with this
> > serie applied on top of 6.6-rc5 (with iommu-next and tegra-next
> > applied).
> > oct. 13 10:53:16 jetson-tx1 kernel: max77620-thermal max77620-thermal:
> > Failed to register thermal zone: -19
>
> Not sure about this one. I don't think I've seen it. Do you know if
> that's somehow caused by this series, or is it preexisting?

It's pre-existing from this serie.

> > oct. 13 10:53:16 jetson-tx1 kernel: tegra_soctherm
> > 700e2000.thermal-sensor: throttle-cfg: heavy: no throt prop or invalid
> > prop
> >
> > Is this expected ?
>
> This one is definitely not expected. I have seen this before, and it
> happens when the device tree doesn't contain all the properties that are
> expected. Patch 12 in this series should take care of that. Have you
> made sure that that's been applied and is what the kernel uses to boot
> with?

Yes, this dtb change in patch12 is propagated to the device (as seen
in /boot/dtbs)
But comparing with what's available at runtime in /proc/device-tree, I
see some changes

                        heavy {
-                               hysteresis-millicelsius =3D <0xfa0>;
+                               #cooling-cells =3D <0x02>;
                                nvidia,cpu-throt-percent =3D <0x55>;
                                nvidia,gpu-throt-level =3D <0x03>;
                                nvidia,priority =3D <0x64>;
-                               nvidia,thermal-zones =3D <0x49 0x4a>;
-                               temperature-millicelsius =3D <0x180c4>;
+                               phandle =3D <0x130>;
                        };

I'm using u-boot 2023.07 with EFI boot (L4T 32.7.4).
Could it be that the bootloader has changed these entries ? Can this
be prevented ?
(MAC ethernet address is set as appropropriate).

Thanks
