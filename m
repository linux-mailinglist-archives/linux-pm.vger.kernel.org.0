Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009147C84BB
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJMLnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjJMLnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 07:43:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D016BD;
        Fri, 13 Oct 2023 04:43:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b98a699f45so315107866b.3;
        Fri, 13 Oct 2023 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697197400; x=1697802200; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZlpw4y4gEaoKsPgIReoXlzuapyQfA8qP/fBmVpWYGk=;
        b=XS1ad79y21f7QpUIHrcl4gzAvSwAthh2mPMHhIeLfdu/ldpBS9vNQnBcoeEoDTbVB5
         UmCmrzbe+6AAGNRDBLZpTA9zmIxYWTPcc7KkPr/DVoDSKGlKcX+RScuqnrMDqElSgmeM
         gEuM2MxhXwuZCFrzJMFDqzAAiA5/Th4iYPefHKzH7VZF72Eloh79n7KLRR8GqppiGK01
         5fBTC9vY/lwMPzM9ZWggDlsuDBnQJICOTtkrFCCQWHmnfh9V+o5fEoW2+6EplaIn8p2w
         J2pSg07arak216Dx6Xjyp6Rau2fEC60a6pPEPm+NVOFVpYNVW7ZV8YbcBoLRy/ej5Vfj
         OTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197400; x=1697802200;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZlpw4y4gEaoKsPgIReoXlzuapyQfA8qP/fBmVpWYGk=;
        b=Z/5vPA7KDtzxyoF+EygtcYIP/8nQ7ydKLWY7THvrnaW2sYGbgx9ynJ0gJ9Ue4tPR0k
         KwAzEWTk0GwMfx0wTELP7KIOZjMrQkVIHeTGg4eC6HtxxTlDvgitePYwjckApGaxWunP
         8+3G7SZxVfQZqugf300xPOnrTmt/YKcw0Arem5XoyKa9J3voCXDlxRD0TYZ87fexSYSf
         2gDYHDF0R8K6Mt6A+3LUyazfac66p/Vqmuj+TFwfHUEBYlojIDq+drDnnWaZqDtKliYr
         bBwBXRdYNlpR7edK5DElHzKoexQBHLpaMkSDYxobYTn8cNMG1kfl7K8EgeAjETrn4180
         ZRbQ==
X-Gm-Message-State: AOJu0YyqWz2tx2ubeA1zn9kU4YTUdaswkktxOz6uq4BjOhl2QL9x9Sqo
        jQpLO4EXEXcCuNUORAo5Ruo=
X-Google-Smtp-Source: AGHT+IGCa2zpM9AB40+JO6jiETF/OfaJVdPzw1xPbggYiJKABWAlrav7L27HHnfQOo89D3+Z6h3VYQ==
X-Received: by 2002:a17:907:360b:b0:9bd:a619:db38 with SMTP id bk11-20020a170907360b00b009bda619db38mr1189980ejc.39.1697197399727;
        Fri, 13 Oct 2023 04:43:19 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lu20-20020a170906fad400b0099297782aa9sm12189802ejb.49.2023.10.13.04.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:43:19 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:43:17 +0200
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
Message-ID: <ZSktVaje_h2Hiyy6@orome.fritz.box>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <CABr+WTkT4LSYrMPVpxYO4VT87xoFA98qA9wFQMwoO4b4J8gF3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sw5sjewipfOoKclJ"
Content-Disposition: inline
In-Reply-To: <CABr+WTkT4LSYrMPVpxYO4VT87xoFA98qA9wFQMwoO4b4J8gF3g@mail.gmail.com>
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


--sw5sjewipfOoKclJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 11:14:25AM +0200, Nicolas Chauvet wrote:
> Le jeu. 12 oct. 2023 =C3=A0 19:58, Thierry Reding
> <thierry.reding@gmail.com> a =C3=A9crit :
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Hi,
> >
> > this set of patches removes the registration of the SOCTHERM internal
> > throttling mechanism as cooling device. Since this throttling starts
> > automatically once a certain temperature threshold is crossed, it
> > doesn't make sense to represent it as a cooling device, which are
> > typically "manually" activated by the thermal framework when thermal
> > sensors report temperature thresholds being crossed.
> >
> > Instead of using the cooling device mechanism, this statically programs
> > the throttling mechanism when it is configured in device tree. In order
> > to do this, an additional device tree property is needed to replace the
> > information that was previously contained in trip points.
> >
> > There's a few preparatory patches to make the removal a bit simpler and
> > also some follow up cleanups included as well.
> >
> > Changes in v2:
> > - rework the device tree bindings:
> >   - add nvidia,thermal-zones property to attach throttling to zones
> >   - use -millicelsius suffix and add hysteresis
> > - add patch to store thermal zone device tree node for later use
> > - add patch to enforce self-encapsulation of the thermal core now that
> >   no drivers need to reach into it anymore
> >
> > This applies on top of Daniel's self-encapsulation hardening series:
> >
> >         https://lore.kernel.org/all/20231012102700.2858952-1-daniel.lez=
cano@linaro.org/
> >
> > Thierry
> >
> > Thierry Reding (13):
> >   thermal: Store device tree node for thermal zone devices
> >   dt-bindings: thermal: tegra: Document throttle temperature
> >   dt-bindings: thermal: tegra: Add nvidia,thermal-zones property
> >   thermal: tegra: Use driver-private data consistently
> >   thermal: tegra: Constify SoC-specific data
> >   thermal: tegra: Do not register cooling device
> >   thermal: tegra: Use unsigned int where appropriate
> >   thermal: tegra: Avoid over-allocation of temporary array
> >   thermal: tegra: Remove gratuitous error assignment
> >   thermal: tegra: Minor stylistic cleanups
> >   ARM: tegra: Rework SOCTHERM on Tegra124
> >   arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
> >   thermal: Enforce self-encapsulation
> >
> >  .../thermal/nvidia,tegra124-soctherm.yaml     |  19 +
> >  arch/arm/boot/dts/nvidia/tegra124.dtsi        |  68 +--
> >  arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  66 +--
> >  arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  86 +--
> >  drivers/thermal/tegra/soctherm.c              | 525 ++++++++----------
> >  drivers/thermal/tegra/soctherm.h              |   1 +
> >  drivers/thermal/tegra/tegra124-soctherm.c     |   4 +
> >  drivers/thermal/tegra/tegra132-soctherm.c     |   4 +
> >  drivers/thermal/tegra/tegra210-soctherm.c     |   4 +
> >  drivers/thermal/thermal_core.h                |   2 +-
> >  drivers/thermal/thermal_of.c                  |   3 +
> >  11 files changed, 329 insertions(+), 453 deletions(-)
> >
> > --
> > 2.42.0
> >
>=20
> I'm still experiencing the following message on jetson-tx1 with this
> serie applied on top of 6.6-rc5 (with iommu-next and tegra-next
> applied).
> oct. 13 10:53:16 jetson-tx1 kernel: max77620-thermal max77620-thermal:
> Failed to register thermal zone: -19

Not sure about this one. I don't think I've seen it. Do you know if
that's somehow caused by this series, or is it preexisting?

> oct. 13 10:53:16 jetson-tx1 kernel: tegra_soctherm
> 700e2000.thermal-sensor: throttle-cfg: heavy: no throt prop or invalid
> prop
>=20
> Is this expected ?

This one is definitely not expected. I have seen this before, and it
happens when the device tree doesn't contain all the properties that are
expected. Patch 12 in this series should take care of that. Have you
made sure that that's been applied and is what the kernel uses to boot
with?

Thierry

--sw5sjewipfOoKclJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpLVUACgkQ3SOs138+
s6EE+w/+LMqg4g3pwPXwpNR44sbHgjRhLQHktgJMaVKUEd8ih+q436JMxKNFSIKL
Q2uw9OxcwnV10oAYXlSAUeRU+D/QOwPBQ2g2/jnMKrvYnBFZSFyOdYR8x8b0EYUB
N5MXENSgwhZ9H/0Dg+XRSY+ktuULw+Yc9G/1CB7qzz9wIFqqAUoT97Rz9yThxDTe
uqH2e/g2QJ0wsp2uyxch/LdRKqX2mRCv9Y73KLOzMmPCWBcGT+S0zV9tE/zzTRuQ
wFTPkwRwyNQwc6P66BxtPt4ueGt1X+IORR7rUF3Phr6Rq1u5rq9WY5kQ+oQ9Zcrd
4forIHadH6nKmgAMi+sd9ryVCly9eyfzSgBvK6FL+fJSUbSRScjixHIg+jvhpU4U
I4bxUVarKmm4k23F29aVn7Lj8yXXqCw8v3j0y1BduUm8IzzT7PcJXnrAekP7JrNl
yX6KCI5H9kE4gzpm8qcSlV1t6FZl24Z2/Ck3lUXESvLtvPC7MolpFGQVfCnhzuEh
IXlTKbdYzbkeAHdzJDv9SsBnSPU7jmgkwEkSVyxsSSex9D8FOQCaqs+JRH9h+nLg
lATGrSEyWWzV3Q3Oopkj7rTyggYwpjDtP4LqnSrf6tV0IssoZWhisl3/T+aujy4k
gUNvkDDx+Qitz881VrIf83pgAUaGPg0Stv4thiPiUbC9y2TN7Hg=
=kSo1
-----END PGP SIGNATURE-----

--sw5sjewipfOoKclJ--
