Return-Path: <linux-pm+bounces-32781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B5AB2F05E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 10:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC481BA8C4D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34692EA463;
	Thu, 21 Aug 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVbfFlaS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA12EA14E;
	Thu, 21 Aug 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763267; cv=none; b=HODoecBOUjX7VwRvTUq1DnbCrq8xreMYrrPeljXjUV3RJcsOitxppvhvj27LPeU8laTL8DHi3Ire4tJO7a/qED0MX9P2k6jC6AHhMVCy08p1JQTm5jxxQKIPtoyoCTqBtHjL8FDK40nLA9aEzy7otcYmb1oyc+OpXmOtspXUMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763267; c=relaxed/simple;
	bh=LDomPiZ9p1Qt2fE9RQvZk4IbzMA8y76qgVlk+q9O49M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qA64/IekbLeSiiOZEPt+Vfsg5lzuRrQeMW6H4X4FPDF17AxM1Rtzo4U+lzwbWsL7w6Z16leiv83KATLjcr5m/K1JuPd+TPqC5XJO+mR9UfrFKct47ntjgvthxWd4tMTpSiY9h+1BX1yhQ43KZ5ocY6/OonhXplNXxIqESeQ0YmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVbfFlaS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c380aa198eso288617f8f.0;
        Thu, 21 Aug 2025 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755763264; x=1756368064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYC81/CspQI2x5Zt5nFbZgxnDKsw/U0sKguPuiHeEsU=;
        b=cVbfFlaSRfAS/dVH9WK5idYBXwUUUws2DHtZ2QKvRvQbDWbbI13bD2PdGfzho3ASMy
         7zRfQoDFPX1iRRvqDRnc4Oz5NcQroreQAvVX5wtsH0DoB+qfrVSnndIB0onStRvM2YxC
         2a9mBy5QUmZy2uIQ7M+TYv//8fA5rAYLER21fpJtvrFuSQci6nka29CyG0z1HQkIbNQK
         iWqFlupEmaxxNLzKBXV91T6hs1O2nkmuJepV3znfYCJIgvbjvcijdIJTVz2FodqYbimT
         vcPbjQ4Yso2Vea2ifl0c7RQsxwWagsi0422IOPEO5uwLZAsjgywhEr75w4v8dQXYfik2
         1v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763264; x=1756368064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYC81/CspQI2x5Zt5nFbZgxnDKsw/U0sKguPuiHeEsU=;
        b=O3pEiO92PaDE2pDMF/mmdIenRK1Yxp9+Kw+wRVaKWznvhV4NsowmYnEqLyxnf09zgy
         eTPjWLfSppQx9DFj2JjfQXMIVCwFp0i2CmqIweCT5sJgTAM8o3Gt4/ya5iNpNmVjJk6w
         Wh9Cw/CTH/w7581JiOhYZju9w8RcZu8hKCcq7DVVHxdD9IjydAcdA6UWoRKUoj/8V4hj
         QgHQIL6DM72L9iaqTas+MX9SSqvE/WGGcv8p0YUntxOTXQo8rnWyvor/JjnLC6lwD0MG
         9vAHDNWAmaxPz6Ce26vwNDfK+zmpIZoHWwjFu1YBWaFxS99YMdS0nX02oq9nLo/5CjVN
         zKSg==
X-Forwarded-Encrypted: i=1; AJvYcCV6HoV5fV9j/rWbj5+OCQ2V0jYX+S3h1qDDf5y+HTfNtJfW13Pz/EDYTfQKsQe/xn1wO8h6pMGTiZQz/JI=@vger.kernel.org, AJvYcCW/sChiY4SMfp1fe0CWs1mkXyXMmrJL0GuLfRZzXp4vDikjd0MBcy/uz0YcD50EKzeFB+n+/W5flOno@vger.kernel.org, AJvYcCWciwGq20Jzrn4kqVOBwLe+si//cBrtT0KHGUymp17qW/XJVrzuVWd+DdILApOuXpLFJElsmUFEflk=@vger.kernel.org, AJvYcCXWKUzhxDKvp0FDKS0WRJytb7ovTR8Era7Zl7U0MC6RI7bdnlVHmZLica8Vd+eM71nLcxA538nhq0bGW6zt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7WphJVjIx8ZOIIxyRMVAC9RTkiADpw80lt357WbhPAAg7AzAZ
	r2LAqUqFXKmPx4dJ+X8oTasfc57FoZ+TDW6ttrcI7mkJDR4p1uyXYVinQ+NfGBZ5NPCTfj6V5t0
	pVvhrum2NHTuyEuCXnSGVFHF6KZCl0/0=
X-Gm-Gg: ASbGncvgs+VO+ex9S7zblaM37jNXIWZN2ChRBpT2gSeJYFgufp3YMwke06RcE9hdqq7
	++gVFe+/Tf8+XJOMi4XNsO2Qu93VNRIMf29N1IvVfBRRAEBsuMo3mNokV8ycpi3lvqRrXeipQfG
	ffb7sdOL3W/R8dNuoMYbYF2WcTN/z5H7aC192xdUPDZCuh2EmDfaBBA50VqyhcKtCSZZ/BuQBsV
	2o8l1ot
X-Google-Smtp-Source: AGHT+IHlu6plWkGMAqF0313C+JSEwT6vux+7MQ+TdBXXvqnjy/h7v5byLE/hb46RMj242B7yotgV8zSydX3+XR8ue+A=
X-Received: by 2002:a05:6000:2307:b0:3c3:d82c:2295 with SMTP id
 ffacd0b85a97d-3c49549d23dmr1368855f8f.24.1755763263696; Thu, 21 Aug 2025
 01:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820114231.150441-1-clamor95@gmail.com> <20250820114231.150441-4-clamor95@gmail.com>
 <22816196.EfDdHjke4D@senjougahara>
In-Reply-To: <22816196.EfDdHjke4D@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 21 Aug 2025 11:00:52 +0300
X-Gm-Features: Ac12FXyXQq5Kfxjhl2aCxdTEED7OiYUsslF67UQV98LjSRtX5dSrp8cwLQqjhNY
Message-ID: <CAPVz0n0vCjM=tz_GAM9TTKO76eMmq-1AjW4y8C==GDg2NUZE=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] thermal: tegra: soctherm-fuse: prepare calibration
 for Tegra114 support
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 21 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 10:4=
2 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wednesday, August 20, 2025 8:42=E2=80=AFPM Svyatoslav Ryhel wrote:
> > The Tegra114 has a different fuse calibration register layout and addre=
ss
> > compared to other Tegra SoCs, requiring SOCTHERM shift, mask, register
> > address, and nominal calibration values to be configurable.
> >
> > Additionally, a use_lower_precision option was implemented to account f=
or
> > the Tegra114's 0.5C thermal data output, which differs from the 1C
> > precision of newer SoCs.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/thermal/tegra/soctherm-fuse.c     | 31 ++++++++++++++++-------
> >  drivers/thermal/tegra/soctherm.h          |  8 +++++-
> >  drivers/thermal/tegra/tegra124-soctherm.c |  6 +++++
> >  drivers/thermal/tegra/tegra132-soctherm.c |  6 +++++
> >  drivers/thermal/tegra/tegra210-soctherm.c |  6 +++++
> >  5 files changed, 47 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/thermal/tegra/soctherm-fuse.c
> > b/drivers/thermal/tegra/soctherm-fuse.c index 190f95280e0b..d27876dd9b2=
a
> > 100644
> > --- a/drivers/thermal/tegra/soctherm-fuse.c
> > +++ b/drivers/thermal/tegra/soctherm-fuse.c
> > @@ -9,15 +9,10 @@
> >
> >  #include "soctherm.h"
> >
> > -#define NOMINAL_CALIB_FT                     105
> > -#define NOMINAL_CALIB_CP                     25
> > -
> >  #define FUSE_TSENSOR_CALIB_CP_TS_BASE_MASK   0x1fff
> >  #define FUSE_TSENSOR_CALIB_FT_TS_BASE_MASK   (0x1fff << 13)
> >  #define FUSE_TSENSOR_CALIB_FT_TS_BASE_SHIFT  13
> >
> > -#define FUSE_TSENSOR_COMMON                  0x180
> > -
> >  /*
> >   * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
> >   *    3                   2                   1                   0
> > @@ -26,7 +21,7 @@
> >   * |       BASE_FT       |      BASE_CP      | SHFT_FT | SHIFT_CP  |
> >   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >   *
> > - * Tegra12x, etc:
> > + * Tegra124:
> >   * In chips prior to Tegra210, this fuse was incorrectly sized as 26 b=
its,
> >   * and didn't hold SHIFT_CP in [31:26]. Therefore these missing six bi=
ts
> >   * were obtained via the FUSE_SPARE_REALIGNMENT_REG register [5:0].
> > @@ -44,6 +39,13 @@
> >   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >   * |---------------------------------------------------| SHIFT_CP  |
> >   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> > + *
> > + * Tegra114: Layout of bits in FUSE_TSENSOR_COMMON aka FUSE_VSENSOR_CA=
LIB:
> > + *    3                   2                   1                   0
> > + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> > + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> > + * | SHFT_FT |       BASE_FT       | SHIFT_CP  |      BASE_CP      |
> > + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >   */
> >
> >  #define CALIB_COEFFICIENT 1000000LL
> > @@ -77,7 +79,7 @@ int tegra_calc_shared_calib(const struct
> > tegra_soctherm_fuse *tfuse, s32 shifted_cp, shifted_ft;
> >       int err;
> >
> > -     err =3D tegra_fuse_readl(FUSE_TSENSOR_COMMON, &val);
> > +     err =3D tegra_fuse_readl(tfuse->fuse_common_reg, &val);
> >       if (err)
> >               return err;
> >
> > @@ -96,10 +98,21 @@ int tegra_calc_shared_calib(const struct
> > tegra_soctherm_fuse *tfuse, return err;
> >       }
> >
> > +     shifted_cp =3D (val & tfuse->fuse_shift_cp_mask) >>
> > +                  tfuse->fuse_shift_cp_shift;
> >       shifted_cp =3D sign_extend32(val, 5);
> >
> > -     shared->actual_temp_cp =3D 2 * NOMINAL_CALIB_CP + shifted_cp;
> > -     shared->actual_temp_ft =3D 2 * NOMINAL_CALIB_FT + shifted_ft;
> > +     shared->actual_temp_cp =3D 2 * tfuse->nominal_calib_cp + shifted_=
cp;
> > +     shared->actual_temp_ft =3D 2 * tfuse->nominal_calib_ft + shifted_=
ft;
> > +
> > +     /*
> > +      * Tegra114 provides fuse thermal corrections in 0.5C while newer
> > +      * SoCs provide data in 1C
> > +      */
>
> I've been looking a bit into these fuses, and from what I can tell the
> precision for these fuses should be in 0.5C units for all of Tegra114, 12=
4,
> and 210. The documented nominal CP (cold) and FT (hot) temperatures for
> Tegra114 should be 25C and 90C respectively.
>
> The reason for the code '2 * NOMINAL_CALIB_XX + shifted_xx' then is that =
the
> value of 'actual_temp_xx' is in 0.5C units -- NOMINAL_CALIB_XX being in 1=
C
> units and being multiplied by 2 to match the units of the shifted_xx valu=
es
> coming from fuses.
>
> If you're getting correct values with your code, clearly there's more hij=
inks
> going on.
>

I have based this code on downstream kernel which sometimes can be
quite challenging to understand correctly. If you assume that Tegra114
fits into existing driver even more, that is great, I will test it and
remove unnecessary parts.

