Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4A7C866F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjJMNN5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMNN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 09:13:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C44491;
        Fri, 13 Oct 2023 06:13:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso683915966b.0;
        Fri, 13 Oct 2023 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697202832; x=1697807632; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHMW2Zdy80665hOAEp5WBmOVvAp02hjPBGC5B0scs4w=;
        b=ChUiRRCOgLUa63qwW72ijS3jXSzeSOmIFCBcgiZdr/0r6eufSrCq31WSjGwYCXD5Vf
         DRYQShUIOva2qN4N6GJ0NN4v3nZ4Ib/K1IlRgJKxSH1WVUCpY95SmAXrb9dXTaL3Q6q+
         AIvNodM4hjZtRE6tfaqp29VZUZ6lHrjEoMuKtUTVEvF3oEbqTpFnt6yAKv3F3wXa8OCA
         quXqJWh0ZV0qqPi1+TCJ/kX9wgjmm2mPia5GIC156T4/2WWsT7n2LRAL74P79+fSv4hN
         cAlQjnyKVBmCqFF1YZIPIDufpPwcyhoIZszIiqXy+upSChRyeXg40M0pl7fwPQMx5+eE
         pbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697202832; x=1697807632;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHMW2Zdy80665hOAEp5WBmOVvAp02hjPBGC5B0scs4w=;
        b=Zvav0UPw4V/WB9+iGtwj42t5k17xwI/7D+L/fOYWo103Vz6DaOqoYKSNwRQ4ohK3rL
         taiQe6e0VqC16TV/f9JUAWsCm74LsJv8WKavNFWWP/AE2zgH3Atbnbw03zKe5Q3ue5b8
         KW9+RFF5v54kQJFHFSqag3NnYPvdgrErflb2OuTuGCHBoETcvA0ieLR+1ork3hLSKD4y
         NPJdjhEk5RBfKEz2cLL5ytajiEjwxSbJ+LvgKKM8xn626z3KQd71QxEA1Hysi0KWUfTe
         o/94Z3RpZC+Hf3BojJG+7oEyQbyjqju72YuBbKesLVeZAB7qvMMzUu88Em5FMQm1VArO
         1UGw==
X-Gm-Message-State: AOJu0YyTekOTfaaM4SU/uyMfX61HDchi6b/HvoZNqsVONQXsrB3Q5T6o
        P6zPmt3LVp2qf6vgU7y2s0o=
X-Google-Smtp-Source: AGHT+IEYKYqnqzBZHl9dMzd2tqRuWj4Z7eEqw5fEQhRR1J5ANEE8GCvpNcbtMA0Y7yNtADgDh0Soqg==
X-Received: by 2002:a17:907:9802:b0:9a5:794f:f3c5 with SMTP id ji2-20020a170907980200b009a5794ff3c5mr79578ejc.6.1697202832228;
        Fri, 13 Oct 2023 06:13:52 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709064a5200b0099bcdfff7cbsm12319856ejv.160.2023.10.13.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:13:51 -0700 (PDT)
Date:   Fri, 13 Oct 2023 15:13:50 +0200
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
Message-ID: <ZSlCjptcuIvVHuuM@orome.fritz.box>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <CABr+WTkT4LSYrMPVpxYO4VT87xoFA98qA9wFQMwoO4b4J8gF3g@mail.gmail.com>
 <ZSktVaje_h2Hiyy6@orome.fritz.box>
 <CABr+WTk9EGqVQ3_5579RmLVvOZj_NzNN3U8JMbyrQze5-9Wx8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NUNZ+HaQfG+5H671"
Content-Disposition: inline
In-Reply-To: <CABr+WTk9EGqVQ3_5579RmLVvOZj_NzNN3U8JMbyrQze5-9Wx8A@mail.gmail.com>
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


--NUNZ+HaQfG+5H671
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 02:45:57PM +0200, Nicolas Chauvet wrote:
> Le ven. 13 oct. 2023 =C3=A0 13:43, Thierry Reding
> <thierry.reding@gmail.com> a =C3=A9crit :
> >
> > On Fri, Oct 13, 2023 at 11:14:25AM +0200, Nicolas Chauvet wrote:
> > > Le jeu. 12 oct. 2023 =C3=A0 19:58, Thierry Reding
> > > <thierry.reding@gmail.com> a =C3=A9crit :
> > > >
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > Hi,
> > > >
> > > > this set of patches removes the registration of the SOCTHERM intern=
al
> > > > throttling mechanism as cooling device. Since this throttling starts
> > > > automatically once a certain temperature threshold is crossed, it
> > > > doesn't make sense to represent it as a cooling device, which are
> > > > typically "manually" activated by the thermal framework when thermal
> > > > sensors report temperature thresholds being crossed.
> > > >
> > > > Instead of using the cooling device mechanism, this statically prog=
rams
> > > > the throttling mechanism when it is configured in device tree. In o=
rder
> > > > to do this, an additional device tree property is needed to replace=
 the
> > > > information that was previously contained in trip points.
> > > >
> > > > There's a few preparatory patches to make the removal a bit simpler=
 and
> > > > also some follow up cleanups included as well.
> > > >
> > > > Changes in v2:
> > > > - rework the device tree bindings:
> > > >   - add nvidia,thermal-zones property to attach throttling to zones
> > > >   - use -millicelsius suffix and add hysteresis
> > > > - add patch to store thermal zone device tree node for later use
> > > > - add patch to enforce self-encapsulation of the thermal core now t=
hat
> > > >   no drivers need to reach into it anymore
> > > >
> > > > This applies on top of Daniel's self-encapsulation hardening series:
> > > >
> > > >         https://lore.kernel.org/all/20231012102700.2858952-1-daniel=
=2Elezcano@linaro.org/
> > > >
> > > > Thierry
> > > >
> > > > Thierry Reding (13):
> > > >   thermal: Store device tree node for thermal zone devices
> > > >   dt-bindings: thermal: tegra: Document throttle temperature
> > > >   dt-bindings: thermal: tegra: Add nvidia,thermal-zones property
> > > >   thermal: tegra: Use driver-private data consistently
> > > >   thermal: tegra: Constify SoC-specific data
> > > >   thermal: tegra: Do not register cooling device
> > > >   thermal: tegra: Use unsigned int where appropriate
> > > >   thermal: tegra: Avoid over-allocation of temporary array
> > > >   thermal: tegra: Remove gratuitous error assignment
> > > >   thermal: tegra: Minor stylistic cleanups
> > > >   ARM: tegra: Rework SOCTHERM on Tegra124
> > > >   arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
> > > >   thermal: Enforce self-encapsulation
> > > >
> > > >  .../thermal/nvidia,tegra124-soctherm.yaml     |  19 +
> > > >  arch/arm/boot/dts/nvidia/tegra124.dtsi        |  68 +--
> > > >  arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  66 +--
> > > >  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  86 +--
> > > >  drivers/thermal/tegra/soctherm.c              | 525 ++++++++------=
----
> > > >  drivers/thermal/tegra/soctherm.h              |   1 +
> > > >  drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
> > > >  drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
> > > >  drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
> > > >  drivers/thermal/thermal_core.h                |   2 +-
> > > >  drivers/thermal/thermal_of.c                  |   3 +
> > > >  11 files changed, 329 insertions(+), 453 deletions(-)
> > > >
> > > > --
> > > > 2.42.0
> > > >
> > >
> > > I'm still experiencing the following message on jetson-tx1 with this
> > > serie applied on top of 6.6-rc5 (with iommu-next and tegra-next
> > > applied).
> > > oct. 13 10:53:16 jetson-tx1 kernel: max77620-thermal max77620-thermal:
> > > Failed to register thermal zone: -19
> >
> > Not sure about this one. I don't think I've seen it. Do you know if
> > that's somehow caused by this series, or is it preexisting?
>=20
> It's pre-existing from this serie.
>=20
> > > oct. 13 10:53:16 jetson-tx1 kernel: tegra_soctherm
> > > 700e2000.thermal-sensor: throttle-cfg: heavy: no throt prop or invalid
> > > prop
> > >
> > > Is this expected ?
> >
> > This one is definitely not expected. I have seen this before, and it
> > happens when the device tree doesn't contain all the properties that are
> > expected. Patch 12 in this series should take care of that. Have you
> > made sure that that's been applied and is what the kernel uses to boot
> > with?
>=20
> Yes, this dtb change in patch12 is propagated to the device (as seen
> in /boot/dtbs)
> But comparing with what's available at runtime in /proc/device-tree, I
> see some changes
>=20
>                         heavy {
> -                               hysteresis-millicelsius =3D <0xfa0>;
> +                               #cooling-cells =3D <0x02>;
>                                 nvidia,cpu-throt-percent =3D <0x55>;
>                                 nvidia,gpu-throt-level =3D <0x03>;
>                                 nvidia,priority =3D <0x64>;
> -                               nvidia,thermal-zones =3D <0x49 0x4a>;
> -                               temperature-millicelsius =3D <0x180c4>;
> +                               phandle =3D <0x130>;
>                         };

Okay, that explains the error message.

>=20
> I'm using u-boot 2023.07 with EFI boot (L4T 32.7.4).
> Could it be that the bootloader has changed these entries ? Can this
> be prevented ?

I'm not aware of anything in the bootloader that would do this. Some
versions of U-Boot that ships with L4T can copy certain nodes in DTB but
I have never seen anything that would've touched thermal.

Is it possible that you're not loading the DTB and end up receiving one
=66rom UEFI or cboot?

> (MAC ethernet address is set as appropropriate).

That's a completely separate mechanism and shouldn't touch thermal at
all.

Thierry

--NUNZ+HaQfG+5H671
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpQosACgkQ3SOs138+
s6Ho2Q/9HrWknZuitsNbWjLu8gPV3z2Y2GykNCInZYzKb+IPt04CXNOZq5bQlE8J
usRLbZD5DsNg7pmvKWwBCebqVErrvHHxXspNgR/w36dVdglbznhm3niu9NspE3mV
aMiWiHOoTbELftzuzfgg2bYjbzmpD5unCVRHwHxNXnk2LWuc0j3ChfqlCi4MpfBD
vkIMTk6r8BkN+csSUSqZA11DyKVFr9G9bpbURCm3FWtQbv9wFXJXz/7+bQ2IJvd0
pCWbw0mnOcS3T2+ejm8TOqm7qfO4bJyJi5Gb7UWbSB62gsHuh21zAmwOH5RM98l4
CCjdWwdkyodp9CozvNHasmE1v4NNWRisDhM2R6yjAx1ggAMczlYOPzzLhXJi1afD
S+voKG5Jc7899mHaBASgW2WfpsCe8eHzGdfyUykxwTuIByGrwiIaKWz5NEhbh8Tm
YxEbuRJir5S+t8VsB9CWSFEqZXuOTgy39HdcbhkPEH8gz/4otLPQyIa8bG6SHxtP
pvQPQELel7Uz7d6mGoPcvNYQRoOaFnB1TUjO8+9fxC0ErX+/wg6/5N8G6XTFKeMP
EvLfRkbG7TZXIxL0oRsKDBtIhfFOPxV7TS59rBT59yWU63uUWXFqxw687lwtRrfl
LRVQknIUu48LqxGN9jhlXkUfNq3Sli7uHtH99HiKdF02erVDcH0=
=ChBh
-----END PGP SIGNATURE-----

--NUNZ+HaQfG+5H671--
