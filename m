Return-Path: <linux-pm+bounces-32965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5886BB33512
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 06:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D23481BEE
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 04:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EF92741DA;
	Mon, 25 Aug 2025 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmDlUJqH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01194272E43;
	Mon, 25 Aug 2025 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096333; cv=none; b=l+5rRRLUtxKht4BZScg/Um3cq+NOTw1UA7QDxMciuuXaxvb31j2ETSHJeD3b5MggmaQonGZVXNY5O2GrMO0OyR9IFy7zRpV/rTylLEbzIG5kQJXYnFlqCE7kMwbvBIQXRxFwKJj4pFgTLjwJANwWCDe8SPPN7K8Z0bo/Iu204Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096333; c=relaxed/simple;
	bh=T2KNeitGqMrA4lQFUWPAPqsr3uw3BA9T+qVqNSGH6P4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tL8FouVNQpe44EcGymjBd/Kbv3gXKKDu9mnNN16MjVJxbrHpNJzEs+TqtL3RpMpdEEmgPEKuw6jqxE/yu2urXdUaRgbK/1TrefNPTdOhtSQBWmfqI1b4Xz/5meTjiolj1wB3SbY9W4Laep/JKTSCOzBoCrfKs9qbLEisLVN1cP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmDlUJqH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a0442bso631782666b.2;
        Sun, 24 Aug 2025 21:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756096329; x=1756701129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HehqKz7DcqQo+iRQ7tqcTNNvNXOyAsHSoNxFFxCivuM=;
        b=HmDlUJqHHUQAycNsLFcPx3jib6RDkirNOAAd8uSp82jQC3yMASrQX15JjzMY9f0S7q
         9tKqAdRknFTZs6HaEX0YwCTQH1pb+fl6ndkJFuqaqCEU2oJfuly0dRyd1oRZPFnukrrB
         8fYWswZakDJVWS5q/GDfPf7Dhqx90YLpdwO5sQ58/ECjXfB14JO71ebVAa/VI7ryrLtp
         +les6SAcoOGxKtUDwnsBYB2a3+gHa19z8Tdq7fiAPHIRisKBH8PwsenpOYNXizDmkqbU
         4+zWv3ubRPXJraARvErdkDWqUEYduZROPK0XgS2XhBUBANkYurvpx/a5wBDQFT5L08a+
         JtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756096329; x=1756701129;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HehqKz7DcqQo+iRQ7tqcTNNvNXOyAsHSoNxFFxCivuM=;
        b=QoXGtsFUl86FrwamWb8376+jMocsmhBZIiqmt4zluO9DxVCOkxx0DlqQNp5lCBIBdX
         HptXnXnr7NLQTVhy0P3s6Cbm2JvbM28lvbPDGAgpkVEkabKZuVvBHBtyGSt+/GVij5BX
         fKjRlQygF+9FKbeO6iHEunOBc7Hnv7VxYBhAgjO00iW2v9vu47k8MKZ29r0ya0HWEfEz
         K9JRIZIu8ZF29C0RgZxCz1gjuXZD3phs3N1ciUZnou11AuXx+NYSc182VGTyGTP9JDNa
         G/hkmCYtjzkBZC8EqCWQfbg7E5dPztQ2aZzeFjvqzJrCxzdNLXJamHelTgoETTHZ9KbS
         ZrrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCkOz5cEqYOVfu+h2X1k9CSEyzn1No/KzcE3rrddadBwAtYdzAnGNsVuSqvXoyYZkh6A2PPImwbe8=@vger.kernel.org, AJvYcCVyNklVluw4Jh6z8zxCFrnsRm0OvXFf/8gcx5quxl0E+aUJQIX78beK0U891A/JfPLqW/xZJdKXPVA=@vger.kernel.org, AJvYcCWP3Ah7j7xxGmMPJYN9jpfsmrpeYw+QWjDqB7rybbzFvUn5iCfgh68sM8dI3ZhyQXujQIPjjO1RC7XcZ04C@vger.kernel.org, AJvYcCXK8jIyy97i1ce4VlWiLiMZ+7WRbG8k+EcVtoH7+x/11HDnlMxaGUUxRoqw/rZQsHo08+nmtenLxEtUXGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHEmZY6UgxmuBq+U1lllntnE9LnxMGLDj6NCQn/Eg9KBSf2q3/
	LZAuIlEFYmgrBM/BiflCGXkqIFiRqGTgBrLvbunLPBdlabDTwmPjkyJP
X-Gm-Gg: ASbGnctfHBqEr0wq8ygFkjLCBcBhnAKj5Hfa3i0h1zkXOMbJ31PUNBuZjHBW454tkUX
	z/Gg9OtwVlPcc5cCdvJZZRniWhuT+JVVd3xTK9snkASmh3RIuhv6YfaWZnfGXwtcenfiNvhpEAR
	/tKDc+1OCM2L0yOfEJBS0YYkaTBJZYIouztS//6C+tBW/SZmr1oR3QsoC3FK+TagJooQYZDDjhE
	Eno8N/5LpaHOO+/R25SLhp4zKzsuZak67OGhKxpplVjnongmpUTr95wYYwGloJMEweS3RhCrwYH
	8XgysThTONU50ff62XDBFAn4u9vf3JsqcxShTR3SJ6z6+9txTe+/o3vOJNMXCS6VyzG0jqfQFR7
	xroSaxpelyqgISS8=
X-Google-Smtp-Source: AGHT+IGgMZjvSi5hBqPeOAS6df/Om1vBrQYnwfMUsc/Px8r3PDByl/9RSYzZLSjPWc5sXUs2UF8mUg==
X-Received: by 2002:a17:907:6d0a:b0:af9:566c:4cba with SMTP id a640c23a62f3a-afe28ffbe48mr889373266b.9.1756096329171;
        Sun, 24 Aug 2025 21:32:09 -0700 (PDT)
Received: from [127.0.0.1] ([5.248.9.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe492da3adsm486431266b.69.2025.08.24.21.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 21:32:09 -0700 (PDT)
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

