Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122A87C873E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjJMNz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 09:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMNz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 09:55:57 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D813095;
        Fri, 13 Oct 2023 06:55:55 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4e7951dddso1370027a34.1;
        Fri, 13 Oct 2023 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697205355; x=1697810155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/LdPWVeMaQ2t1D7LtdC/Cr9HnftA6vjOPV9Z68q6dU=;
        b=K7n320w6Nw6aP28wALnjKoI+vPS9E+hM+qs3Uh7jiITfw1vO3GVvks3COldKHMcLNT
         9J0yeiT5JQtrFilo19vR+BMGDt3CRy4SeK0esiajRnjkBFOqPz24QJ/VCSzJRCcFGk1s
         Qp3C2gcMbiQpJHnXKXjH895YB3QvE+HM1BrlbDoXVfvcttn6F8p19uJWAfrIt1RGWmH2
         erV0qmokezn5/TIF+pcbMYb7EN5WnOK3GL6TwYQ+nw1GQTHJu4TG/+Kj87m1rL3CrjKK
         V2dVEpLnU9MpDXRj4/b4wpBGfOnC9hnmO2HaS9mY1JQ8qm3eNwpwZ5RJ6VrVm+4httI/
         dk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697205355; x=1697810155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/LdPWVeMaQ2t1D7LtdC/Cr9HnftA6vjOPV9Z68q6dU=;
        b=P2Cp0G8lVFfwDHBXJbqEcS1ySKyK9ktEUYgyZzePRPrOwZS7UXpilvTP1PQ0ZdamsK
         IF5jSHLfB7xBUCU0VUKDKt35Vpuf8d1jkjabnFrYSXK4TSZATrbVqJEUliWS7oW/tc7W
         sc48LfAJQnsn2EnoHtqqkaIdLo+XmmkB7lnLzzfmAI4aIijQCuO4dFq+sg92mb6gh+7q
         l5Q/3I42Rb2kMIdse6727Yb+7+TmAgJcKvcCAbNyNo7KzHNg2r7pYWWZ0jp1kfganXQQ
         Zgyk7y6JhOB+OEH3eMP82zrzrSqc82BnaqvT4JxJ2yIbLtZyhH5bVMVzjqQGUfYqgJXf
         ZsJA==
X-Gm-Message-State: AOJu0YxGGHKMDXpn0EmGlb7FPPxA69Xx5978/oBbObafd/8ZMm8UIB25
        r3Qrng/Z/iy9FuNKfqQAEs3d60pOF7jVCSa/4qM=
X-Google-Smtp-Source: AGHT+IFRlclhywjPn0HvY1oqtDeoehgE37SdItvITL8PpwFIhF29C/xufA9c+JlchpxpFusATF0LXWkj9SRwUPB4Hn8=
X-Received: by 2002:a9d:6396:0:b0:6c4:897a:31c4 with SMTP id
 w22-20020a9d6396000000b006c4897a31c4mr28350960otk.29.1697205355090; Fri, 13
 Oct 2023 06:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <CABr+WTkT4LSYrMPVpxYO4VT87xoFA98qA9wFQMwoO4b4J8gF3g@mail.gmail.com>
 <ZSktVaje_h2Hiyy6@orome.fritz.box> <CABr+WTk9EGqVQ3_5579RmLVvOZj_NzNN3U8JMbyrQze5-9Wx8A@mail.gmail.com>
 <ZSlCjptcuIvVHuuM@orome.fritz.box>
In-Reply-To: <ZSlCjptcuIvVHuuM@orome.fritz.box>
From:   Nicolas Chauvet <kwizart@gmail.com>
Date:   Fri, 13 Oct 2023 15:55:43 +0200
Message-ID: <CABr+WTnP-JencnDt-u9emuc7knm1LSNDS5VRf-X9sZzQ0jrs1w@mail.gmail.com>
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

Le ven. 13 oct. 2023 =C3=A0 15:13, Thierry Reding
<thierry.reding@gmail.com> a =C3=A9crit :
>
> On Fri, Oct 13, 2023 at 02:45:57PM +0200, Nicolas Chauvet wrote:
> > Le ven. 13 oct. 2023 =C3=A0 13:43, Thierry Reding
> > <thierry.reding@gmail.com> a =C3=A9crit :
> > >
> > > On Fri, Oct 13, 2023 at 11:14:25AM +0200, Nicolas Chauvet wrote:
> > > > Le jeu. 12 oct. 2023 =C3=A0 19:58, Thierry Reding
> > > > <thierry.reding@gmail.com> a =C3=A9crit :
> > > > >
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >
> > > > > Hi,
> > > > >
> > > > > this set of patches removes the registration of the SOCTHERM inte=
rnal
> > > > > throttling mechanism as cooling device. Since this throttling sta=
rts
> > > > > automatically once a certain temperature threshold is crossed, it
> > > > > doesn't make sense to represent it as a cooling device, which are
> > > > > typically "manually" activated by the thermal framework when ther=
mal
> > > > > sensors report temperature thresholds being crossed.
> > > > >
> > > > > Instead of using the cooling device mechanism, this statically pr=
ograms
> > > > > the throttling mechanism when it is configured in device tree. In=
 order
> > > > > to do this, an additional device tree property is needed to repla=
ce the
> > > > > information that was previously contained in trip points.
> > > > >
> > > > > There's a few preparatory patches to make the removal a bit simpl=
er and
> > > > > also some follow up cleanups included as well.
> > > > >
> > > > > Changes in v2:
> > > > > - rework the device tree bindings:
> > > > >   - add nvidia,thermal-zones property to attach throttling to zon=
es
> > > > >   - use -millicelsius suffix and add hysteresis
> > > > > - add patch to store thermal zone device tree node for later use
> > > > > - add patch to enforce self-encapsulation of the thermal core now=
 that
> > > > >   no drivers need to reach into it anymore
> > > > >
> > > > > This applies on top of Daniel's self-encapsulation hardening seri=
es:
> > > > >
> > > > >         https://lore.kernel.org/all/20231012102700.2858952-1-dani=
el.lezcano@linaro.org/
> > > > >
> > > > > Thierry
> > > > >
> > > > > Thierry Reding (13):
> > > > >   thermal: Store device tree node for thermal zone devices
> > > > >   dt-bindings: thermal: tegra: Document throttle temperature
> > > > >   dt-bindings: thermal: tegra: Add nvidia,thermal-zones property
> > > > >   thermal: tegra: Use driver-private data consistently
> > > > >   thermal: tegra: Constify SoC-specific data
> > > > >   thermal: tegra: Do not register cooling device
> > > > >   thermal: tegra: Use unsigned int where appropriate
> > > > >   thermal: tegra: Avoid over-allocation of temporary array
> > > > >   thermal: tegra: Remove gratuitous error assignment
> > > > >   thermal: tegra: Minor stylistic cleanups
> > > > >   ARM: tegra: Rework SOCTHERM on Tegra124
> > > > >   arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
> > > > >   thermal: Enforce self-encapsulation
> > > > >
> > > > >  .../thermal/nvidia,tegra124-soctherm.yaml     |  19 +
> > > > >  arch/arm/boot/dts/nvidia/tegra124.dtsi        |  68 +--
> > > > >  arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  66 +--
> > > > >  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  86 +--
> > > > >  drivers/thermal/tegra/soctherm.c              | 525 ++++++++----=
------
> > > > >  drivers/thermal/tegra/soctherm.h              |   1 +
> > > > >  drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
> > > > >  drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
> > > > >  drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
> > > > >  drivers/thermal/thermal_core.h                |   2 +-
> > > > >  drivers/thermal/thermal_of.c                  |   3 +
> > > > >  11 files changed, 329 insertions(+), 453 deletions(-)
> > > > >
> > > > > --
> > > > > 2.42.0
> > > > >
> > > >
> > > > I'm still experiencing the following message on jetson-tx1 with thi=
s
> > > > serie applied on top of 6.6-rc5 (with iommu-next and tegra-next
> > > > applied).
> > > > oct. 13 10:53:16 jetson-tx1 kernel: max77620-thermal max77620-therm=
al:
> > > > Failed to register thermal zone: -19
> > >
> > > Not sure about this one. I don't think I've seen it. Do you know if
> > > that's somehow caused by this series, or is it preexisting?
> >
> > It's pre-existing from this serie.
> >
> > > > oct. 13 10:53:16 jetson-tx1 kernel: tegra_soctherm
> > > > 700e2000.thermal-sensor: throttle-cfg: heavy: no throt prop or inva=
lid
> > > > prop
> > > >
> > > > Is this expected ?
> > >
> > > This one is definitely not expected. I have seen this before, and it
> > > happens when the device tree doesn't contain all the properties that =
are
> > > expected. Patch 12 in this series should take care of that. Have you
> > > made sure that that's been applied and is what the kernel uses to boo=
t
> > > with?
> >
> > Yes, this dtb change in patch12 is propagated to the device (as seen
> > in /boot/dtbs)
> > But comparing with what's available at runtime in /proc/device-tree, I
> > see some changes
> >
> >                         heavy {
> > -                               hysteresis-millicelsius =3D <0xfa0>;
> > +                               #cooling-cells =3D <0x02>;
> >                                 nvidia,cpu-throt-percent =3D <0x55>;
> >                                 nvidia,gpu-throt-level =3D <0x03>;
> >                                 nvidia,priority =3D <0x64>;
> > -                               nvidia,thermal-zones =3D <0x49 0x4a>;
> > -                               temperature-millicelsius =3D <0x180c4>;
> > +                               phandle =3D <0x130>;
> >                         };
>
> Okay, that explains the error message.
>
> >
> > I'm using u-boot 2023.07 with EFI boot (L4T 32.7.4).
> > Could it be that the bootloader has changed these entries ? Can this
> > be prevented ?
>
> I'm not aware of anything in the bootloader that would do this. Some
> versions of U-Boot that ships with L4T can copy certain nodes in DTB but
> I have never seen anything that would've touched thermal.
>
> Is it possible that you're not loading the DTB and end up receiving one
> from UEFI or cboot?
Seems like it: a previous copy was in /boot/dts that took over /boot/dtbs.
With updated dtb, the warning disappeared.

Only remaining error is: kernel: max77620-thermal max77620-thermal:
Failed to register thermal zone: -19

Thanks
