Return-Path: <linux-pm+bounces-32964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F6DB33509
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 06:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320B6189B62C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 04:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A392571AA;
	Mon, 25 Aug 2025 04:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaZPHHZh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED6241139;
	Mon, 25 Aug 2025 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096021; cv=none; b=AGAQwwBEUWWkKnG9fXXQplkxxUP5qx/I37DGJued9X8EibFo6Q0UxgIG1aOgp1lbmVGZbLQyDV03jra+DmXHikrRrmO/5Mhqg0C+HfM+JDoMHjFu6f4A3377zv2gvVgZ+CXOaLvWsr7oPzzKSaJzbPEYtCHIcLffcqDDpv2JDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096021; c=relaxed/simple;
	bh=T2KNeitGqMrA4lQFUWPAPqsr3uw3BA9T+qVqNSGH6P4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cMH38UQZPbB8ZMcxgHhzgL1nByXdwV9upDtAKSuaoP5B9Lr8qn0xpJnSq2EDSBL/kTPYvtIZm9uZt0hC03y8SXMsvAKksx/Y3a//C0tk+WQ57xMdh2CuCvs7UnkBkZ/Z3qR3iPx4Q8xvAyJHfH7QwXd7c9Cn7KFD305azPNa3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaZPHHZh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so8214183a12.3;
        Sun, 24 Aug 2025 21:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756096018; x=1756700818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HehqKz7DcqQo+iRQ7tqcTNNvNXOyAsHSoNxFFxCivuM=;
        b=AaZPHHZhPhnYs5XmomTxnZk+0IfeGSILIQLTz0rN36LJOW0bbCmc8IYo0ixfUfgFTY
         SkBaqD7UFbKUeZSZF9fixvTSYvO8s5zNR15yZ63E4ZiNn5LbdqPaTPi6beFQk9uIMUYU
         4TKlF6S5ykQCqkDyHIRFB9b6M6lxnCLWLb21pT3Jn/vZnA7IIr9qz2+FGLMpFYsDI41Z
         4VXf21pLiayifV6XLwmogdYpzrcOdNGXoH/ZOsJFEAHhasTQY0d0sukvGzQw5b4W8u7D
         eehc2eufaJOyWza728BP2GoOn5ec1keqfH7b3eEyL/bndzSzG4PtoyT+6BWGLtcdIrjE
         xDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756096018; x=1756700818;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HehqKz7DcqQo+iRQ7tqcTNNvNXOyAsHSoNxFFxCivuM=;
        b=Cp8iBNZAGoK3GmltNJDZtzdVPQxOp+1E4WTarMMsUVamGJ8LOQJtHG5atjESZLEMyd
         aukftOci77YrHPAeFxoex7w1G2zOtWqek5jaVJTmDfc0MvKxeV6kXd8y3DCEtXSt2FAJ
         wzL/dv+hA4u9xblb1WV+XeDUfNv2YrVQH+KVo8djg4EY+mnokYe5xAHzF1jDQ8HK9V7I
         xSYsWQmm0ft85LGIZqqjjXUfbxFQ/Jo2OGfRWwrqFOvk5L2Lg3CKvy8g8x04RJSV7OWU
         QCXFPFM3kkxNpDDSc26G1e7GaU/chvMTUmva/ZqzlnyEbIk+EJsNw34bpxzAE5l05yWd
         3ofA==
X-Forwarded-Encrypted: i=1; AJvYcCUXKDP706xeJfYrlCCLzHsmji/T7ziwT5LzxLKwogcD9QeWYOmaO7DXhs6bTzDch90PfXyEVPnByOw=@vger.kernel.org, AJvYcCVpCiSkK063T6y4aL9TioCIPwpG75g7KdNGKNfMCa1iyo9vZGvhdFzk2/otOouPrLJAA1HCxJA2VZk=@vger.kernel.org, AJvYcCWprQwTpd/D+19LusQGTloYlBP1Dzk1VS+fkrQ2MTHRGk2A6OKLThum153N7TPGZ4EkTtJT/LkNZKCENAGr@vger.kernel.org, AJvYcCXam8ssfPRdf8eldcJFt3p5o+oREFVRw1NeF2VqEOOCBeCWAcQVj5nGVbg496C5RaXwsEMVgSvM6dnoBQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv72quzCmSPZbT7oFS4pLAocua/3TOJgUVX96O94J95p26wAe4
	95KOdo7pJV5/VKevZxB5S5P+LBD/izEdnyBQCSZSuPDyuxYeT0dD4i3Z
X-Gm-Gg: ASbGnctuxbA2elQ9EB83WY+mf3lYHHLUP6s2MHLxkhf+qwJePPrx39JnX96l5URFgwS
	lNM27JSDTjbJCRyOsx8ViTuOCcMq0PIOl0cLfxO01bB5ai5AZnuS0YbN+0QFEkVeRvdxrpTY/SH
	pTqD0sTtmNdL4F+qSAwPDtkiMLyp5EnHfn06e8icvmh3zsZrAbvCg4+UodThN0frpIt4bLgoQr9
	Fs6P2vkKR0QxVXdseh/wg8vZclej3AUV86z6+qVQz6iaqffagwWEu2Tt2kFrhHHoHpFqiye5toM
	1JAOA5Vymyf2POcYywEDApX7m1l9H6+LWsJsiV/Xu5RpGEmhiujO5BdomoXMFB6GW8yraGo86LX
	/PzGsWs2nNawvgAI=
X-Google-Smtp-Source: AGHT+IHovRBHbssX5qoAa1uGysmLNUE5XzYtwqBIUbX+G9XsiBZON5wkKM4gUG+rS19rAFFRvDd/uQ==
X-Received: by 2002:a05:6402:a0cb:b0:61a:967f:55f9 with SMTP id 4fb4d7f45d1cf-61c1b492cb4mr9401400a12.10.1756096017568;
        Sun, 24 Aug 2025 21:26:57 -0700 (PDT)
Received: from [127.0.0.1] ([5.248.9.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c316f4f45sm4239498a12.36.2025.08.24.21.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 21:26:57 -0700 (PDT)
Date: Mon, 25 Aug 2025 07:26:55 +0300
From: Svyatoslav <clamor95@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>
CC: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/3] ARM: tegra: Add DFLL clock support on Tegra 4
User-Agent: K-9 Mail for Android
In-Reply-To: <2480891.iZASKD2KPV@senjougahara>
References: <20250321095556.91425-1-clamor95@gmail.com> <117069551.nniJfEyVGO@senjougahara> <CAPVz0n24N1-iAoQFpzw7r7sz2E4Xhd8fB-gaoPesdc7XaR2HcQ@mail.gmail.com> <2480891.iZASKD2KPV@senjougahara>
Message-ID: <9139A302-ADF6-4E2C-917E-0E0E1D6CBA0A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



25 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2025=E2=80=AF=D1=80=2E 07:20:10 GM=
T+03:00, Mikko Perttunen <mperttunen@nvidia=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5=
:
>On Friday, August 22, 2025 2:19=E2=80=AFPM Svyatoslav Ryhel wrote:
>> =D0=BF=D1=82, 22 =D1=81=D0=B5=D1=80=D0=BF=2E 2025=E2=80=AF=D1=80=2E =D0=
=BE 06:05 Mikko Perttunen <mperttunen@nvidia=2Ecom> =D0=BF=D0=B8=D1=88=D0=
=B5:
>> > On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
>> > > Add DFLL clock node to common Tegra114 device tree along with clock=
s
>> > > property to cpu node=2E
>> > >=20
>> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> > > ---
>> > >=20
>> > >  arch/arm/boot/dts/nvidia/tegra114=2Edtsi | 34 ++++++++++++++++++++=
++++++
>> > >  1 file changed, 34 insertions(+)
>> > >=20
>> > > diff --git a/arch/arm/boot/dts/nvidia/tegra114=2Edtsi
>> > > b/arch/arm/boot/dts/nvidia/tegra114=2Edtsi index
>> > > 341ec0962460=2E=2E25d063a47ca5
>> > > 100644
>> > > --- a/arch/arm/boot/dts/nvidia/tegra114=2Edtsi
>> > > +++ b/arch/arm/boot/dts/nvidia/tegra114=2Edtsi
>> > > @@ -4,6 +4,7 @@
>> > >=20
>> > >  #include <dt-bindings/memory/tegra114-mc=2Eh>
>> > >  #include <dt-bindings/pinctrl/pinctrl-tegra=2Eh>
>> > >  #include <dt-bindings/interrupt-controller/arm-gic=2Eh>
>> > >=20
>> > > +#include <dt-bindings/reset/tegra114-car=2Eh>
>> > >=20
>> > >  #include <dt-bindings/soc/tegra-pmc=2Eh>
>> > > =20
>> > >  #include "tegra114-peripherals-opp=2Edtsi"
>> > >=20
>> > > @@ -710,6 +711,30 @@ mipi: mipi@700e3000 {
>> > >=20
>> > >               #nvidia,mipi-calibrate-cells =3D <1>;
>> > >      =20
>> > >       };
>> > >=20
>> > > +     dfll: clock@70110000 {
>> > > +             compatible =3D "nvidia,tegra114-dfll";
>> > > +             reg =3D <0x70110000 0x100>, /* DFLL control */
>> > > +                   <0x70110000 0x100>, /* I2C output control */
>> > > +                   <0x70110100 0x100>, /* Integrated I2C controlle=
r */
>> > > +                   <0x70110200 0x100>; /* Look-up table RAM */
>> > > +             interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>> > > +             clocks =3D <&tegra_car TEGRA114_CLK_DFLL_SOC>,
>> > > +                      <&tegra_car TEGRA114_CLK_DFLL_REF>,
>> > > +                      <&tegra_car TEGRA114_CLK_I2C5>;
>> > > +             clock-names =3D "soc", "ref", "i2c";
>> > > +             resets =3D <&tegra_car TEGRA114_RST_DFLL_DVCO>;
>> > > +             reset-names =3D "dvco";
>> > > +             #clock-cells =3D <0>;
>> > > +             clock-output-names =3D "dfllCPU_out";
>> > > +             nvidia,sample-rate =3D <11500>;
>> >=20
>> > Should this be 12500? That would match Tegra124 and a downstream kern=
el
>> > for
>> > Tegra114 I have=2E
>>=20
>> I referred to tegratab and macallan boards in 3=2E4 kernel which give
>> 11500, maybe sample-rate was changed to 12500 later with tegra124
>> addition?
>
>That's interesting=2E I was looking at the public roth (Shield Portable) =
kernel,=20
>which does not support Tegra124=2E I checked the L4T r17 release now, and=
 it=20
>seems it's a newer version, where the sample rate has been changed to 115=
00 on=20
>some boards due to a voltage undershoot issue with vdd_cpu on macallan/
>tegratab [1]=2E
>
>So on macallan/tegratab, the vdd_cpu (smps123) ramp rate should be set to=
=20
>2=2E5mV/us and sample-rate to 11500, while on other boards it can be 5mV/=
us with=20
>12500 for faster ramping=2E
>
>[1] https://nv-tegra=2Envidia=2Ecom/r/plugins/gitiles/linux-2=2E6/+/
>b92cab2d4cb6379aeded80adc4c5d0708c3f038e%5E%21/#F0
>
>Cheers,
>Mikko
>

So should I stick with 11500 as a safer, acceptable for every t114 option?

>>=20
>> > > +             nvidia,droop-ctrl =3D <0x00000f00>;
>> > > +             nvidia,force-mode =3D <1>;
>> > > +             nvidia,cf =3D <10>;
>> > > +             nvidia,ci =3D <0>;
>> > > +             nvidia,cg =3D <2>;
>> > > +             status =3D "disabled";
>> > > +     };
>> > > +
>> > >=20
>> > >       mmc@78000000 {
>> > >      =20
>> > >               compatible =3D "nvidia,tegra114-sdhci";
>> > >               reg =3D <0x78000000 0x200>;
>> > >=20
>> > > @@ -841,6 +866,15 @@ cpu@0 {
>> > >=20
>> > >                       device_type =3D "cpu";
>> > >                       compatible =3D "arm,cortex-a15";
>> > >                       reg =3D <0>;
>> > >=20
>> > > +
>> > > +                     clocks =3D <&tegra_car TEGRA114_CLK_CCLK_G>,
>> > > +                              <&tegra_car TEGRA114_CLK_CCLK_LP>,
>> > > +                              <&tegra_car TEGRA114_CLK_PLL_X>,
>> > > +                              <&tegra_car TEGRA114_CLK_PLL_P>,
>> > > +                              <&dfll>;
>> > > +                     clock-names =3D "cpu_g", "cpu_lp", "pll_x", "=
pll_p",
>> >=20
>> > "dfll";
>> >=20
>> > > +                     /* FIXME: what's the actual transition time? =
*/
>> > > +                     clock-latency =3D <300000>;
>> > >=20
>> > >               };
>> > >              =20
>> > >               cpu@1 {
>
>
>
>

