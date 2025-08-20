Return-Path: <linux-pm+bounces-32674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F1B2D350
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 07:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBB11C21D26
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 05:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B82517AF;
	Wed, 20 Aug 2025 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0sOVeku"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7642A8C;
	Wed, 20 Aug 2025 05:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755667068; cv=none; b=qg46vYfSq7dJp94TQrp1ixhNYcqn0eXgnH8FDcMj3wJPLC/xkxNSMthbdAjf6wcgxCz5/57Dot/QPaaVqefE2rUJnYa/e+toqGZAxphfWB+shx8pXl7mii3a3bEKIXkF9RmeHM4vEbyM+k7Vo3+TnlPFA8lwQJBcFoMn3X93RYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755667068; c=relaxed/simple;
	bh=tqoGCLP9+74vKW90EcH+OlYlZbNmYCR/9Hf+PoUBcMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kxn0DUpwowobu4anxsResGQK0Bdl2cJS8CrpCZZjb9e/9wEHVdSqifGF3qpTc27Cb496X94sFSDieTVzMF+p29YqfhsNkTbX7xb3D90g4Vp6oG926fu+yo6ZdThOiUp9qPV172QbMf/pQvGHV538IjiikIg6bLRR86QaNuKXKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0sOVeku; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3bb30c72433so2044772f8f.3;
        Tue, 19 Aug 2025 22:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755667065; x=1756271865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6SOzmjVM7Uou5d5GhXQPVmrV/BigkiuvFiYvv6bbPU=;
        b=M0sOVekuFR/5d7ySRavbOsyiChxSC34wCXqQ0jN7zdZZTOz3atc+NWQ8++LImJ+v1D
         t59pyd3fxo8F0SFpWEVSKdEzzfGn0GtZ8el2iwIDOiiDfycxM2UkQLguK390BfBXj8eH
         z4eTs3B7lJQTym6LvT/VAoAY2t0cRfbSX/G59pfUpvmTlnDDhrM00G4c7MAYo5AgRKxH
         Bmag1dCJWmwaD76/ZnlcdqaJIL0LbxBIfNCxk0pcOVjKcx8Ovh9jK6KNBzjJ1MM6Pg4g
         5YIh9FhN0VmqZ1Jk4pI41radcXpC1lo/OObFCx4cPUArl5Xz+1mAb6xboi8KsY3SlqEQ
         FR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755667065; x=1756271865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6SOzmjVM7Uou5d5GhXQPVmrV/BigkiuvFiYvv6bbPU=;
        b=wzBjGkc3CnZhO8QHk3ceMb/S9f9FhYdGSEt72bpc23SqdAqNf1/XwGg9WkEXzxblQv
         lPpf0zcCLtCwFAjbxeKYIsbRhBSG+8GDghl5MXI22QEAjRwaHKiLiAo6CQVB/j7r3xX8
         CeyDfRItIqvVW3o08tUvzN7E1FpkRRqdOuaQG+oScqv5SJNNrAsg8VL7tndbdLMnlIGY
         6qu47arNEW2APfQ6QKAgqL8t7hzong+Bwmh8dYbFD2dS5BZN8WPZ7gZ2vp4vvtG8lLZr
         py4Fl8DgqlfklAVZdBKHVty77NDroTSUh9SSZwyGsNGAbQODpy/+kmONYpLU/JqgCVGn
         0/hA==
X-Forwarded-Encrypted: i=1; AJvYcCU+96z5illGC8j2cTI8QcM/Qo012RM2RkU/FOciWLDNXQOLkMjj+v1PQK4sq7O6ND0Bn4TrZMBRNwgEbLA=@vger.kernel.org, AJvYcCWP54glqZyu3+vW1TpvODb+zxC6tpIswkaWxJ/zLXJXkPszB4yuicvQspV2HHcm8nBkzjLsWjmHyso=@vger.kernel.org, AJvYcCX+OGZAc06ksxiBsHsCdtrQayHJhzLt3+kyPAHYAUga3uZMzQE7BHYN7zM1efdubJbvaFR0t4tRb3nv@vger.kernel.org, AJvYcCXOK3AfheUkts/Z2osrl4pVN/ls9gQTZjxEzPHN6CX//g6Nsvz7WyXYQJqC4hDjbSuJDmU7V+JNo2g8AEag@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGpZHKV/HLRze38fhT89lrr+TEGWhBvKkekwj63rCitsTzGs4
	AmroHnbdhcoChuKmYki4/JZcGmrtoajCTMux64vY3UiOxQPVVtHkBtvD1KP2Z8csy8oNnEL7dQI
	vaG2lFZPdOpvFG3bJ00A1uoOiJNw4PCs=
X-Gm-Gg: ASbGncvFL5VhccHEfo8rtX7J80EgTTxb8VCdKvMoN/WmIbz+Q9miHCEoFyKgDhrJ3j7
	EKvQzklw9s1IdYkHKafqnojEev1CqyO49eJoqv1yPHsqhld8GwFbk8LQrkMtLocpX5YuPV4qEBL
	ihefdyzFQRqkzpPcGQ846C4/PX5knG2eJ2a1DfcOuUFwISwsZ3uQHEKFhM0dEYM1bo5TKRDuuHC
	u/lEYdu
X-Google-Smtp-Source: AGHT+IEGBynKUW5kzhZO24yk05tzZRHHWrhvqyD0weWRBI66L9VHzGYiVaSzAQefZH65TvGdRC7EG3EKihr0MSjt4QY=
X-Received: by 2002:a05:6000:2511:b0:3b7:9613:adef with SMTP id
 ffacd0b85a97d-3c32ecce06fmr770158f8f.55.1755667064316; Tue, 19 Aug 2025
 22:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714082252.9028-1-clamor95@gmail.com> <20250714082252.9028-4-clamor95@gmail.com>
 <3738425.aeNJFYEL58@senjougahara>
In-Reply-To: <3738425.aeNJFYEL58@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 20 Aug 2025 08:17:32 +0300
X-Gm-Features: Ac12FXzJct9E7QGLJCka8bZCp2fLJgvViCVpA1zkwKIjCNi6ihC2ticyeIzSuHQ
Message-ID: <CAPVz0n1gqBTXE2MmwGCNGJWot5VDDqpHecAr+HgSy_=MJ8rb5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] thermal: tegra: soctherm-fuse: parametrize
 configuration further
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 20 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 07:3=
5 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Monday, July 14, 2025 5:22=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Prepare soctherm fuse calibration for Tegra114 support.
>
> Please describe the changes that are needed for Tegra114 in the commit
> message.
>

All changes are mostly related to different calibration register layout.

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/thermal/tegra/soctherm-fuse.c     | 33 ++++++++++++++++-------
> >  drivers/thermal/tegra/soctherm.h          | 13 ++++++++-
> >  drivers/thermal/tegra/tegra124-soctherm.c |  8 ++++++
> >  drivers/thermal/tegra/tegra132-soctherm.c |  8 ++++++
> >  drivers/thermal/tegra/tegra210-soctherm.c |  8 ++++++
> >  5 files changed, 59 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/thermal/tegra/soctherm-fuse.c
> > b/drivers/thermal/tegra/soctherm-fuse.c index 190f95280e0b..3b808c4521b=
8
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
> > @@ -44,6 +39,13 @@
> >   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >   * |---------------------------------------------------| SHIFT_CP  |
> >   * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> > + *
> > + * Tegra11x: Layout of bits in FUSE_TSENSOR_COMMON aka FUSE_VSENSOR_CA=
LIB:
>
> Let's just call it Tegra114. I see 'Tegra12x' is used above. You can chan=
ge
> that to 'Tegra124/Tegra132' while at it. The 'NNx' numbering is something
> leaking from (old) downstream code that we're trying to avoid.
>
> > + *    3                   2                   1                   0
> > + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> > + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> > + * | SHFT_FT |       BASE_FT       | SHIFT_CP  |      BASE_CP      |
> > + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >   */
>
> Based on these diagrams, the size of e.g. SHIFT_FT has not changed betwee=
n the
> chip generations. I checked old downstream code, where
>
>   #define FUSE_SHIFT_FT_BITS      5
>
> Below, we have
>
>   shifted_ft =3D sign_extend32(shifted_ft, 4);
>
> However, sign_extend32 calculates as '31 - x' whereas the downstream code=
 does
> '32 - x'. So it appears to me that the size hasn't changed between the ch=
ips
> and hence we don't need the added parameterization? Same might apply to o=
ther
> fields in the calibration data.
>

It seems you are correct regarding FUSE_SHIFT_FT_BITS and
FUSE_SHIFT_CP_BITS I will adjust that. Thank you

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
> > @@ -88,7 +90,7 @@ int tegra_calc_shared_calib(const struct
> > tegra_soctherm_fuse *tfuse,
> >
> >       shifted_ft =3D (val & tfuse->fuse_shift_ft_mask) >>
> >                    tfuse->fuse_shift_ft_shift;
> > -     shifted_ft =3D sign_extend32(shifted_ft, 4);
> > +     shifted_ft =3D sign_extend32(shifted_ft, tfuse->fuse_shift_ft_bit=
s);
> >
> >       if (tfuse->fuse_spare_realignment) {
> >               err =3D tegra_fuse_readl(tfuse->fuse_spare_realignment, &=
val);
> > @@ -96,10 +98,21 @@ int tegra_calc_shared_calib(const struct
> > tegra_soctherm_fuse *tfuse, return err;
> >       }
> >
> > -     shifted_cp =3D sign_extend32(val, 5);
> > +     shifted_cp =3D (val & tfuse->fuse_shift_cp_mask) >>
> > +                  tfuse->fuse_shift_cp_shift;
> > +     shifted_cp =3D sign_extend32(val, tfuse->fuse_shift_cp_bits);
> >
> > -     shared->actual_temp_cp =3D 2 * NOMINAL_CALIB_CP + shifted_cp;
> > -     shared->actual_temp_ft =3D 2 * NOMINAL_CALIB_FT + shifted_ft;
> > +     shared->actual_temp_cp =3D 2 * tfuse->nominal_calib_cp + shifted_=
cp;
> > +     shared->actual_temp_ft =3D 2 * tfuse->nominal_calib_ft + shifted_=
ft;
> > +
> > +     /*
> > +      * Tegra114 provides fuse thermal corrections in 0.5C while expec=
ted
> > +      * precision should be 1C
> > +      */
>
> If Tegra114 is lower precision, should this say it provides corrections i=
n 1C
> while newer chips are 0.5C?
>

lower_precision is an action not a statement (took that from
downstream iirc). Comment is correct, T114 provides output in 0.5C
while newer gens in 1C

> > +     if (tfuse->lower_precision) {
> > +             shared->actual_temp_cp /=3D 2;
> > +             shared->actual_temp_ft /=3D 2;
> > +     }
> >
> >       return 0;
> >  }
> > diff --git a/drivers/thermal/tegra/soctherm.h
> > b/drivers/thermal/tegra/soctherm.h index 70501e73d586..6c0e0cc594a5 100=
644
> > --- a/drivers/thermal/tegra/soctherm.h
> > +++ b/drivers/thermal/tegra/soctherm.h
> > @@ -56,6 +56,13 @@
> >  #define SENSOR_TEMP2_MEM_TEMP_MASK           (0xffff << 16)
> >  #define SENSOR_TEMP2_PLLX_TEMP_MASK          0xffff
> >
> > +#define NOMINAL_CALIB_FT                     105
> > +#define T114X_CALIB_FT                               90
> > +#define NOMINAL_CALIB_CP                     25
>
> I would either just hardcode these values in the chip-specific files, or
>
> #define TEGRA114_NOMINAL_CALIB_FT ...
> #define TEGRA124_NOMINAL_CALIB_FT ...
> #define TEGRA114_NOMINAL_CALIB_CP ...
>
> > +
> > +#define FUSE_VSENSOR_CALIB                   0x08c
> > +#define FUSE_TSENSOR_COMMON                  0x180
> > +
> >  /**
> >   * struct tegra_tsensor_group - SOC_THERM sensor group data
> >   * @name: short name of the temperature sensor group
> > @@ -109,9 +116,13 @@ struct tsensor_group_thermtrips {
> >
> >  struct tegra_soctherm_fuse {
> >       u32 fuse_base_cp_mask, fuse_base_cp_shift;
> > +     u32 fuse_shift_cp_mask, fuse_shift_cp_shift;
> >       u32 fuse_base_ft_mask, fuse_base_ft_shift;
> >       u32 fuse_shift_ft_mask, fuse_shift_ft_shift;
> > -     u32 fuse_spare_realignment;
> > +     u32 fuse_shift_cp_bits, fuse_shift_ft_bits;
> > +     u32 fuse_common_reg, fuse_spare_realignment;
> > +     u32 nominal_calib_cp, nominal_calib_ft;
> > +     bool lower_precision;
> >  };
> >
> >  struct tsensor_shared_calib {
> > diff --git a/drivers/thermal/tegra/tegra124-soctherm.c
> > b/drivers/thermal/tegra/tegra124-soctherm.c index
> > 20ad27f4d1a1..dd4dd7e9014d 100644
> > --- a/drivers/thermal/tegra/tegra124-soctherm.c
> > +++ b/drivers/thermal/tegra/tegra124-soctherm.c
> > @@ -200,11 +200,19 @@ static const struct tegra_tsensor tegra124_tsenso=
rs[]
> > =3D { static const struct tegra_soctherm_fuse tegra124_soctherm_fuse =
=3D {
> > .fuse_base_cp_mask =3D 0x3ff,
> >       .fuse_base_cp_shift =3D 0,
> > +     .fuse_shift_cp_mask =3D 0x1f,
> > +     .fuse_shift_cp_shift =3D 0,
> >       .fuse_base_ft_mask =3D 0x7ff << 10,
> >       .fuse_base_ft_shift =3D 10,
> >       .fuse_shift_ft_mask =3D 0x1f << 21,
> >       .fuse_shift_ft_shift =3D 21,
> > +     .fuse_shift_cp_bits =3D 5,
> > +     .fuse_shift_ft_bits =3D 4,
> > +     .fuse_common_reg =3D FUSE_TSENSOR_COMMON,
> >       .fuse_spare_realignment =3D 0x1fc,
> > +     .nominal_calib_cp =3D NOMINAL_CALIB_CP,
> > +     .nominal_calib_ft =3D NOMINAL_CALIB_FT,
> > +     .lower_precision =3D false,
> >  };
> >
> >  const struct tegra_soctherm_soc tegra124_soctherm =3D {
> > diff --git a/drivers/thermal/tegra/tegra132-soctherm.c
> > b/drivers/thermal/tegra/tegra132-soctherm.c index
> > b76308fdad9e..926836426688 100644
> > --- a/drivers/thermal/tegra/tegra132-soctherm.c
> > +++ b/drivers/thermal/tegra/tegra132-soctherm.c
> > @@ -200,11 +200,19 @@ static struct tegra_tsensor tegra132_tsensors[] =
=3D {
> >  static const struct tegra_soctherm_fuse tegra132_soctherm_fuse =3D {
> >       .fuse_base_cp_mask =3D 0x3ff,
> >       .fuse_base_cp_shift =3D 0,
> > +     .fuse_shift_cp_mask =3D 0x1f,
> > +     .fuse_shift_cp_shift =3D 0,
> >       .fuse_base_ft_mask =3D 0x7ff << 10,
> >       .fuse_base_ft_shift =3D 10,
> >       .fuse_shift_ft_mask =3D 0x1f << 21,
> >       .fuse_shift_ft_shift =3D 21,
> > +     .fuse_shift_cp_bits =3D 5,
> > +     .fuse_shift_ft_bits =3D 4,
> > +     .fuse_common_reg =3D FUSE_TSENSOR_COMMON,
> >       .fuse_spare_realignment =3D 0x1fc,
> > +     .nominal_calib_cp =3D NOMINAL_CALIB_CP,
> > +     .nominal_calib_ft =3D NOMINAL_CALIB_FT,
> > +     .lower_precision =3D false,
> >  };
> >
> >  const struct tegra_soctherm_soc tegra132_soctherm =3D {
> > diff --git a/drivers/thermal/tegra/tegra210-soctherm.c
> > b/drivers/thermal/tegra/tegra210-soctherm.c index
> > d0ff793f18c5..2877a7b43f2a 100644
> > --- a/drivers/thermal/tegra/tegra210-soctherm.c
> > +++ b/drivers/thermal/tegra/tegra210-soctherm.c
> > @@ -201,11 +201,19 @@ static const struct tegra_tsensor tegra210_tsenso=
rs[]
> > =3D { static const struct tegra_soctherm_fuse tegra210_soctherm_fuse =
=3D {
> > .fuse_base_cp_mask =3D 0x3ff << 11,
> >       .fuse_base_cp_shift =3D 11,
> > +     .fuse_shift_cp_mask =3D 0x1f,
> > +     .fuse_shift_cp_shift =3D 0,
> >       .fuse_base_ft_mask =3D 0x7ff << 21,
> >       .fuse_base_ft_shift =3D 21,
> >       .fuse_shift_ft_mask =3D 0x1f << 6,
> >       .fuse_shift_ft_shift =3D 6,
> > +     .fuse_shift_cp_bits =3D 5,
> > +     .fuse_shift_ft_bits =3D 4,
> > +     .fuse_common_reg =3D FUSE_TSENSOR_COMMON,
> >       .fuse_spare_realignment =3D 0,
> > +     .nominal_calib_cp =3D NOMINAL_CALIB_CP,
> > +     .nominal_calib_ft =3D NOMINAL_CALIB_FT,
> > +     .lower_precision =3D false,
> >  };
> >
> >  static struct tsensor_group_thermtrips tegra210_tsensor_thermtrips[] =
=3D {
>

