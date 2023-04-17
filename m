Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0896E4332
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 11:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjDQJG0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 05:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDQJGZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 05:06:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF959170D;
        Mon, 17 Apr 2023 02:06:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a5so5685798ejb.6;
        Mon, 17 Apr 2023 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681722382; x=1684314382;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRw++8DCsbGRpKEYAvR6c5N87LkuLbIZdhy/p3qR+is=;
        b=OdcAo9gViulnTDbqdPTYCzAVE/krbdLJaDTSOSsz2UEKmR/QWJFG9DlfieG2lvMnxP
         Q247aeezUz8ssIfDJ7F/F+uQZWocDRMAgDT3b4RQvmzJ9N4/3EOMESdOB4Pfg2K9syE3
         7go/d449NALS5uwoONLWDRjEUqRDM1gN2yoMB/YS5w6l8BCudd6X91dl0hzApKX/rWTu
         VDXLXsZWf8AuwFEJpoIAAOW5qMpgjTzPJvfEKFWoT/PF1ePvgMLgeCRz+2eIZCC9RSGC
         m5vOm49lK/TkCDLcXM58yXAod1BXl5PP+pD4gagqflPU1RBgZp/osWgRu7ypGYx8czks
         apVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681722382; x=1684314382;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRw++8DCsbGRpKEYAvR6c5N87LkuLbIZdhy/p3qR+is=;
        b=Av6nh+Uuu5PjAE46iOBnXbBXqG+dk+7HyjQF2Q9ToheE6Ai17ZscQgto5X8SVCGg2f
         zTdZPu3Sg7TypyHKKFIIG2nDy044npru6HpSreW7lcIlg5MO0fvaJ+of+GuzPiczdJ8j
         zfWKPyVjlzV4ZKPLLFyk8whfrQ90CO7C3VIzXpTRA9BfpLlSi5qFQUNS3RKVMRpFozlm
         jfLHjIaK8zkyCSR60EZE5D43dmd7N+hd6vhHEQwiBpwxeqXTKNLtCeVwbSWxmZAAcbOB
         1s24ebGz+1hVCCijp4WDKa2O57EPmP8QOt6niD9s64C2FTmoJsjb4OGbNQCM3H5Afynu
         tn8g==
X-Gm-Message-State: AAQBX9f1rAwdQ2Dyvg8gv3u+m3FWCWdIPZ0BOKcFYSTjuN08757RTnrj
        JL76Ewgc66HBrz+NboMOQolAN+WeWjY=
X-Google-Smtp-Source: AKy350ZK+YGWEv6Grr3hY2pQZOUcytskKThJXsUjLmFw8fe9hhjYsGOEj0Z/OgMhzz4761KptxN76Q==
X-Received: by 2002:a17:907:1623:b0:94f:49a2:619a with SMTP id hb35-20020a170907162300b0094f49a2619amr4068267ejc.11.1681722381812;
        Mon, 17 Apr 2023 02:06:21 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qb37-20020a1709077ea500b0094ee0c9a6d0sm4820220ejc.184.2023.04.17.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:06:21 -0700 (PDT)
Date:   Mon, 17 Apr 2023 11:06:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 09/10] arm64: tegra: Rework SOCTHERM on Tegra132 and
 Tegra210
Message-ID: <ZD0MC6AqgNtYUJ4a@orome>
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
 <20230414125721.1043589-10-thierry.reding@gmail.com>
 <ed5f12fd-f1f8-9823-a32d-5782068dc790@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xwrNWjN09bPXOM+0"
Content-Disposition: inline
In-Reply-To: <ed5f12fd-f1f8-9823-a32d-5782068dc790@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xwrNWjN09bPXOM+0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2023 at 10:15:11AM +0200, Daniel Lezcano wrote:
> On 14/04/2023 14:57, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The "heavy throttle" cooling device that SOCTHERM uses isn't a cooling
> > device in the traditional sense. It's an automatic mechanism that cannot
> > be actively controlled. Do not expose it as a cooling device and instead
> > of tying it to a specific trip point, hard-code the temperature at which
> > the automatic throttling will begin.
> >=20
> > While at it, clean up the trip point names to reflect the names used by
> > the thermal device tree bindings.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >   arch/arm64/boot/dts/nvidia/tegra132.dtsi | 63 +++++-------------
> >   arch/arm64/boot/dts/nvidia/tegra210.dtsi | 83 +++++++-----------------
> >   2 files changed, 39 insertions(+), 107 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot=
/dts/nvidia/tegra132.dtsi
> > index 8b78be8f4f9d..11ebf7517df1 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> > @@ -876,11 +876,10 @@ soctherm: thermal-sensor@700e2000 {
> >   		#thermal-sensor-cells =3D <1>;
> >   		throttle-cfgs {
> > -			throttle_heavy: heavy {
> > +			heavy {
> >   				nvidia,priority =3D <100>;
> >   				nvidia,cpu-throt-level =3D <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
> > -
> > -				#cooling-cells =3D <2>;
> > +				temperature =3D <102000>;
> >   			};
> >   		};
> >   	};
> > @@ -1136,114 +1135,84 @@ cpu-thermal {
> >   			polling-delay-passive =3D <1000>;
> >   			polling-delay =3D <0>;
> > -			thermal-sensors =3D
> > -				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
> > +			thermal-sensors =3D <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
> >   			trips {
> > -				cpu_shutdown_trip {
> > +				critical {
> >   					temperature =3D <105000>;
> >   					hysteresis =3D <1000>;
> >   					type =3D "critical";
> >   				};
> > -				cpu_throttle_trip: throttle-trip {
> > +				hot {
> >   					temperature =3D <102000>;
> >   					hysteresis =3D <1000>;
> >   					type =3D "hot";
> >   				};
> >   			};
> > -
> > -			cooling-maps {
> > -				map0 {
> > -					trip =3D <&cpu_throttle_trip>;
> > -					cooling-device =3D <&throttle_heavy 1 1>;
> > -				};
> > -			};
>=20
> If the hardware mitigation is 'heavy', don't you want to have DVFS acting
> before hardware throttling ?

The throttling here is in fact some form of DVFS, but yes, generally we
would likely want to have additional forms of DVFS before we reach this
state. We could add CPU cooling devices and there's also a mechanism to
throttle the DRAM frequency on certain boards.

But those are mostly orthogonal to this series. The goal here is to get
rid of the throttling mechanism as a cooling device.

Thierry

--xwrNWjN09bPXOM+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ9DAsACgkQ3SOs138+
s6FELg/+L3hpRpV39q61zhQbh/YoF7yUOFJNYif7YnBVic6Rl2wVaoV0v8bQhVcx
h7qTUhSg4nTgwRHzOaPpfAbiTwch7a3hGHJJ9GV6Dpv/2DkGDDiFUur1l84EhX7A
nNg3PzmbZiig4HRR5qpelCirAWq4iApIuq5AwDjrUScV3bAeVvQSLYQLddnx+/pZ
kpg9K0XGggfOvgdtaYo2cIDWPTNJYwbSIPUAf2w7valVHb4JOGQlUznp9j+OnZTh
sX8M9BZBNZ2ri3gB60KcQfWpsleiv49DWo7v7N/ZOtPSOAxLtFZXCvRLJv/0Q2xf
IN3zCDwlSVw710XqoKAKhmEtYK7Dpj0rQN50UxXASygVr43jBbFH7gJ3E/4rGt6B
iyZhL+2h4fwhPaPDQh7VZBHIh3iboO9wvGDl6Hjq3M1DxZ07T4HIGl9IrpM+oWDu
x1fzlFkuDbuH6G8YSKOFn7Bki7BJwOREbTzCMtHdbVwti4mmwe24oPi9Ay8N7nca
Dh4h0/8J5hfHZYQa8A+xwaMSlziXprZGDOys4tw21v8scj1xxwv/EXkBMncYE0ti
0LLONmdhycrKY9DtBI6iSDsvRIGbzlTTHGIp3O3nnb74DHtZGx/95GN6GBIGXGp6
tXFO5FO77thcrhbj3Bkm1Ax/bgFgdaSriA9p62DavTOhP/7lzDA=
=xoD4
-----END PGP SIGNATURE-----

--xwrNWjN09bPXOM+0--
