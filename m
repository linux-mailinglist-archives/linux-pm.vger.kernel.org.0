Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE4A7C8904
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 17:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjJMPpY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJMPpX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 11:45:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1EDBF;
        Fri, 13 Oct 2023 08:45:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so3912207a12.3;
        Fri, 13 Oct 2023 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697211919; x=1697816719; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4Qik/8tCjQ/LSJkEYQYDKeqkxZOUG2QhVh5qP6Dp1k=;
        b=MYRY2A/AcFnFito6Vr/yWe4jNT1Wuk1SP9c2yTf0P2VMmQhc8trC2hnrAaRqBXaH67
         AfUuUU0c5Pgr0mXLe+XBYvHmEwnAg5WGSwXSPr9B0JY8CTQ/x1st+G1bkdYne8s4zmOy
         4xkyun26fiVI2wJysXMqiEyzJggupLWWxIDl/pd+DEhNBAa4+CwT9XVowMx+hb7pZWVn
         B143RW+Kspg2/6Q2siUW4XLwajWcP8WDfkriXSWLAgx/yP7fwU5nGIZX6+Oys5HbHRHZ
         eI4dVfKfmO2mbJsyAsL8AhT22qB4WvB8KG3qb9ds0r3eCy2kp29c7Og2Uv9EahvRZQRO
         11fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211919; x=1697816719;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4Qik/8tCjQ/LSJkEYQYDKeqkxZOUG2QhVh5qP6Dp1k=;
        b=CvBrqB0+usWKWqK8pddHoOvqQJLKpnuwdu1V+vyOHK6vTv3kLFy3bIje7nG8ZpI3MZ
         cMUhasvTpZx/iXNeA8fez4L1RrAlnwXdEflKP37dg0nGVYIuuKOCk7waUDEOl6Rkss8C
         sNpNP9dnSqtDBYnrSG6bdsT3CB9O8JGh+uaGB48a2Rcps8uwzI83SS+71i5WudQ/sd5i
         tlvevL+qqPtIgEC9I9aQNUh476pd15vMsQwityfP2V/91oULk9JzOWFel5duEaIg1BNu
         uS2O2VZve3pBznAHbqvqW3ZEyzniI2qA74V2TOMEPIgxfw0l6QaurzY9J75QL4oBWRds
         ZzPA==
X-Gm-Message-State: AOJu0Yyv/ZEMcL/kT1ukp+bXiwW1FZETeQVGffbc1vHCcnyfeoIReEYD
        W155ndTQZPZszwVHem+LPV8=
X-Google-Smtp-Source: AGHT+IGRbOXVhP0p7A0CuC6eXHOhNpqbEjwICKKgevPXpz7KnnlcZBKHMALqs03YW8kgUcYM1+3m6Q==
X-Received: by 2002:aa7:c159:0:b0:530:b86f:9c3f with SMTP id r25-20020aa7c159000000b00530b86f9c3fmr22878712edp.37.1697211919189;
        Fri, 13 Oct 2023 08:45:19 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a23-20020a50ff17000000b005342fa19070sm11635888edu.89.2023.10.13.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:45:18 -0700 (PDT)
Date:   Fri, 13 Oct 2023 17:45:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolas Chauvet <kwizart@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 00/13] thermal: tegra: Do not register cooling device
Message-ID: <ZSlmDTareNuAgX-r@orome.fritz.box>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <CABr+WTkT4LSYrMPVpxYO4VT87xoFA98qA9wFQMwoO4b4J8gF3g@mail.gmail.com>
 <ZSktVaje_h2Hiyy6@orome.fritz.box>
 <CABr+WTk9EGqVQ3_5579RmLVvOZj_NzNN3U8JMbyrQze5-9Wx8A@mail.gmail.com>
 <ZSlCjptcuIvVHuuM@orome.fritz.box>
 <CABr+WTnP-JencnDt-u9emuc7knm1LSNDS5VRf-X9sZzQ0jrs1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YE9OTwrIN9bc6tni"
Content-Disposition: inline
In-Reply-To: <CABr+WTnP-JencnDt-u9emuc7knm1LSNDS5VRf-X9sZzQ0jrs1w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--YE9OTwrIN9bc6tni
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 03:55:43PM +0200, Nicolas Chauvet wrote:
> Le ven. 13 oct. 2023 =C3=A0 15:13, Thierry Reding
> <thierry.reding@gmail.com> a =C3=A9crit :
> >
> > On Fri, Oct 13, 2023 at 02:45:57PM +0200, Nicolas Chauvet wrote:
> > > Le ven. 13 oct. 2023 =C3=A0 13:43, Thierry Reding
> > > <thierry.reding@gmail.com> a =C3=A9crit :
> > > >
> > > > On Fri, Oct 13, 2023 at 11:14:25AM +0200, Nicolas Chauvet wrote:
> > > > > Le jeu. 12 oct. 2023 =C3=A0 19:58, Thierry Reding
> > > > > <thierry.reding@gmail.com> a =C3=A9crit :
> > > > > >
> > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > this set of patches removes the registration of the SOCTHERM in=
ternal
> > > > > > throttling mechanism as cooling device. Since this throttling s=
tarts
> > > > > > automatically once a certain temperature threshold is crossed, =
it
> > > > > > doesn't make sense to represent it as a cooling device, which a=
re
> > > > > > typically "manually" activated by the thermal framework when th=
ermal
> > > > > > sensors report temperature thresholds being crossed.
> > > > > >
> > > > > > Instead of using the cooling device mechanism, this statically =
programs
> > > > > > the throttling mechanism when it is configured in device tree. =
In order
> > > > > > to do this, an additional device tree property is needed to rep=
lace the
> > > > > > information that was previously contained in trip points.
> > > > > >
> > > > > > There's a few preparatory patches to make the removal a bit sim=
pler and
> > > > > > also some follow up cleanups included as well.
> > > > > >
> > > > > > Changes in v2:
> > > > > > - rework the device tree bindings:
> > > > > >   - add nvidia,thermal-zones property to attach throttling to z=
ones
> > > > > >   - use -millicelsius suffix and add hysteresis
> > > > > > - add patch to store thermal zone device tree node for later use
> > > > > > - add patch to enforce self-encapsulation of the thermal core n=
ow that
> > > > > >   no drivers need to reach into it anymore
> > > > > >
> > > > > > This applies on top of Daniel's self-encapsulation hardening se=
ries:
> > > > > >
> > > > > >         https://lore.kernel.org/all/20231012102700.2858952-1-da=
niel.lezcano@linaro.org/
> > > > > >
> > > > > > Thierry
> > > > > >
> > > > > > Thierry Reding (13):
> > > > > >   thermal: Store device tree node for thermal zone devices
> > > > > >   dt-bindings: thermal: tegra: Document throttle temperature
> > > > > >   dt-bindings: thermal: tegra: Add nvidia,thermal-zones property
> > > > > >   thermal: tegra: Use driver-private data consistently
> > > > > >   thermal: tegra: Constify SoC-specific data
> > > > > >   thermal: tegra: Do not register cooling device
> > > > > >   thermal: tegra: Use unsigned int where appropriate
> > > > > >   thermal: tegra: Avoid over-allocation of temporary array
> > > > > >   thermal: tegra: Remove gratuitous error assignment
> > > > > >   thermal: tegra: Minor stylistic cleanups
> > > > > >   ARM: tegra: Rework SOCTHERM on Tegra124
> > > > > >   arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
> > > > > >   thermal: Enforce self-encapsulation
> > > > > >
> > > > > >  .../thermal/nvidia,tegra124-soctherm.yaml     |  19 +
> > > > > >  arch/arm/boot/dts/nvidia/tegra124.dtsi        |  68 +--
> > > > > >  arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  66 +--
> > > > > >  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  86 +--
> > > > > >  drivers/thermal/tegra/soctherm.c              | 525 ++++++++--=
--------
> > > > > >  drivers/thermal/tegra/soctherm.h              |   1 +
> > > > > >  drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
> > > > > >  drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
> > > > > >  drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
> > > > > >  drivers/thermal/thermal_core.h                |   2 +-
> > > > > >  drivers/thermal/thermal_of.c                  |   3 +
> > > > > >  11 files changed, 329 insertions(+), 453 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.42.0
> > > > > >
> > > > >
> > > > > I'm still experiencing the following message on jetson-tx1 with t=
his
> > > > > serie applied on top of 6.6-rc5 (with iommu-next and tegra-next
> > > > > applied).
> > > > > oct. 13 10:53:16 jetson-tx1 kernel: max77620-thermal max77620-the=
rmal:
> > > > > Failed to register thermal zone: -19
> > > >
> > > > Not sure about this one. I don't think I've seen it. Do you know if
> > > > that's somehow caused by this series, or is it preexisting?
> > >
> > > It's pre-existing from this serie.
> > >
> > > > > oct. 13 10:53:16 jetson-tx1 kernel: tegra_soctherm
> > > > > 700e2000.thermal-sensor: throttle-cfg: heavy: no throt prop or in=
valid
> > > > > prop
> > > > >
> > > > > Is this expected ?
> > > >
> > > > This one is definitely not expected. I have seen this before, and it
> > > > happens when the device tree doesn't contain all the properties tha=
t are
> > > > expected. Patch 12 in this series should take care of that. Have you
> > > > made sure that that's been applied and is what the kernel uses to b=
oot
> > > > with?
> > >
> > > Yes, this dtb change in patch12 is propagated to the device (as seen
> > > in /boot/dtbs)
> > > But comparing with what's available at runtime in /proc/device-tree, I
> > > see some changes
> > >
> > >                         heavy {
> > > -                               hysteresis-millicelsius =3D <0xfa0>;
> > > +                               #cooling-cells =3D <0x02>;
> > >                                 nvidia,cpu-throt-percent =3D <0x55>;
> > >                                 nvidia,gpu-throt-level =3D <0x03>;
> > >                                 nvidia,priority =3D <0x64>;
> > > -                               nvidia,thermal-zones =3D <0x49 0x4a>;
> > > -                               temperature-millicelsius =3D <0x180c4=
>;
> > > +                               phandle =3D <0x130>;
> > >                         };
> >
> > Okay, that explains the error message.
> >
> > >
> > > I'm using u-boot 2023.07 with EFI boot (L4T 32.7.4).
> > > Could it be that the bootloader has changed these entries ? Can this
> > > be prevented ?
> >
> > I'm not aware of anything in the bootloader that would do this. Some
> > versions of U-Boot that ships with L4T can copy certain nodes in DTB but
> > I have never seen anything that would've touched thermal.
> >
> > Is it possible that you're not loading the DTB and end up receiving one
> > from UEFI or cboot?
> Seems like it: a previous copy was in /boot/dts that took over /boot/dtbs.
> With updated dtb, the warning disappeared.

Okay, great!

> Only remaining error is: kernel: max77620-thermal max77620-thermal:
> Failed to register thermal zone: -19

Looks like that's -ENODEV from devm_thermal_of_zone_register() via
max77620_thermal_probe(). Looking at thermal_of_zone_register(), the
-ENODEV case is treated specially, so perhaps we should be doing the
same thing in max77620_probe()?

Let me send out a patch.

Thierry

--YE9OTwrIN9bc6tni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpZgwACgkQ3SOs138+
s6HFpxAAomBPc3BD2JvOlgt52XHD96e/Let5pkwF4VGsSDLWG/bZHohyiZuqHxcu
mEa/jZ2wntgZNZWpVyv0Nmwe7hGlw5pChrjPAJYzHsW/Y+wjDumGdprHybYqIyzr
FAY2sUBm2C6EiHFOHedA1Ceir8rk+y8m77GndWmSlOmQ8oB01UJ+tvjE3dtx6Aqx
5+lqLPLe92djrpq7eZVdGLXacQn2It6vsyeCr8QxCPhzCglYRh16s9M/Ffa2nJih
mtdtqJfb9rhpTzbM4yNPbbZq4+5siZA/QqlcEHyBfkt8WGW4/O9HEgdgBjRdnV7r
FWSJTVl/adQCSEYAZA+4H+mSun/1qPJWLc3yiZC2t8jBv/+KxMOB8a2uzaU+O0Ax
zgFR3v+ZQskcWG71eXm939PksOWWNLEAgkU/M8sCBfNZL7Cq2qO5iZrF8XimkXaQ
pO0V3OXObqanSlqJK3CNTkGz4h95pzhVergoOnmd9mwkytDYrrnwTHIrK+MuIPTK
HdsjPBEYL83wd89m1vEouEaQGl2K5w0Nr+0RkNhyYsmYHqowzTi9HElVqo5HS6mu
kiOVHT7cu9rRU8PNktK2bV+gnJxh17j9JZsJkK3YyvAjBGBOrr6J2m0rfCvH7BuB
SIagI1VI3XKfXsWaWvZ4hdmNPLwgRWCW9LYNMLerE6vdWC1Hiyc=
=ybdg
-----END PGP SIGNATURE-----

--YE9OTwrIN9bc6tni--
