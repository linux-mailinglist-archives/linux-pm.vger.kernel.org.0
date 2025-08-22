Return-Path: <linux-pm+bounces-32872-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3326B30DE9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A84160131E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2EB28DB54;
	Fri, 22 Aug 2025 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuwGjPDX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46CB28505F;
	Fri, 22 Aug 2025 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840009; cv=none; b=qVBQL3SieXuGAMZh1i7S5xooFF06lwujO+asxZYObW2mNnAqbPNXDaCK7QdwSTW9UZa2NEIZFtndgyQgZUKZuz47dhCi5B0jjuIY8PlEwprEPmyqgC500vQSa7neK2J8DmrGyxidlohrUYTXj5w4wKKKfkmkKwJbEjxc+YSxM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840009; c=relaxed/simple;
	bh=GrMumvBLGMCAFUAXwfZUYHjPyRNBWCX8dH7XHX+DxJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2gqlPRHvZaZzCXUNuKv2O7dGUNSXedu7paC90eB/20/W5xG8+Yfbs9sgO8of945I6ZVmfriedU3HZbennu0HzgaKf4Jn05Kyg8VSgebk+lsZwjjenFzyqggyn6FwwanfAXOBJBfxMvR9NVCHAVi0O9VtixhUsdfq08c4LXhGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuwGjPDX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso1427453f8f.2;
        Thu, 21 Aug 2025 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755840006; x=1756444806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnn/5PSHpSjfU2b5+BfRC0bYY4gLtCL0ez5DFkTN+5o=;
        b=fuwGjPDXjl0O9/URBiyeOrBTpY35kBMcOhd9Y8TaC7mqOI3BeV7n0nHzP2OaIDkkN7
         b12F3gm1IEX4HHNq/5dGl62dbtZEFgPiCrGXw6fY/F7qBq/5is4KPqaJGoNnGM/0SFSF
         ugGtDiKh+m3JQ8MRqCGE05L/PQg2uwLV6ZxAYp+PFjolBp+uzRmjHSX8opd4sKmdiMS2
         d67ToGa3CkL9YcvLUeIIfB4aS7GzVQeayukIj+49yLKFXML2ZldZOBk6EfNOZNQFXcDn
         OaBzAI8WCqn8MhEeWaSXQ/ra8R7gYtBB2hn01Exi2/xqns28p9d0Lo4QlcQM9OKZWaDR
         6rCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755840006; x=1756444806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnn/5PSHpSjfU2b5+BfRC0bYY4gLtCL0ez5DFkTN+5o=;
        b=EUZJURWuvpEUx2R3hJmrqwGBWB2DAditdEV4liicBTi4OUOFJTkSY7nmIt0SqlXDjt
         cunWa9/BAXR8OsSj8k/xOEQcKfTmlfstQfo/L3QvuNF9JCm0CG1lAaGeP9U3e5A4taSb
         wlX1LWnsgEtFtHA85zuouW/h4PFL+yEU4PXDYB7LIL9UYOQoY3hBzLsxzOCciyZOn9D4
         +WFeR9aZnByPBiggjzgnN9IV6sMcU0KeKtxIp5iX6uyd4gxK8pPYmiv+U0xzVmOtCzP4
         LTWwE+vm4Kfyj11r+RfEqaevuhO4qzgLHLfkWt0qHS3r2WJjhG/M+u45I5CXJItvP0mX
         t95A==
X-Forwarded-Encrypted: i=1; AJvYcCVIWJggNoVmFKj5TKFXXKGhVhDpc3vE8diRLjxaXFXeywMCFXz2wl0AYHvzBlUU0395V9q+4MZK60M=@vger.kernel.org, AJvYcCVQGglQZRFOqsdDGt1lD1Xdo8ty8PoDLjMgRYtxzinEFJ1emRTyTll4+gi+51aR3++ddKTj43SjcFJlOxVg@vger.kernel.org, AJvYcCVUirCLxnb9gv56BkCcb5kNQzvvsBnkJh98exuN9YLO4oG+8lqVMAN6pgyf5g75aa3jQdOjFUfcF5M=@vger.kernel.org, AJvYcCVuD7n6n3hp9nXbuYCwV0/HlPFdtx8Ls12BMAAgCUMRmZAp5sgk7Z3peBqR6+uzbSY1PGpCtwEAf25UB9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqEBj1oBLweIXMO830NAkriYPTlK/wp3mfx7BytyGuN+Z5MmXE
	jkxUY1pfDzeqWRR89O4DfTZ5hB4U/hAH+gN7NP8+Snac6McZsAFJmq4+qE6KR/Bfo4UBspmvVf+
	Lmoch1a7i4Ryes+UjsNlWXEYHOuTR3L8=
X-Gm-Gg: ASbGncsqO4vO22zT1UQTDYh1TKnTFiNp5DVVNbQiFZcHJSV4ROLVFMO/1KDEPd2YcDi
	L305918R7hjIvj5YwQpoG4O8Puc8xiXCrlog/J+QAL9k+y25ULffaa0FFmK6+PrxRr6YeUvrgra
	GGGfxWtRDMD/ZppWtbIExYajGoxRl8b5XJ3awSkjl4YeCyfOLPuP54gFjxS2RyC/z96D4egmIcN
	ZMghXK/1YEMFL9B7Mo=
X-Google-Smtp-Source: AGHT+IGayn+dYhiP+xVrv/kU7JYYwK/92uVhgjhPGNmyjhxABuhQYzDSr93Xpts5u+oiyuEsnRxb+FaGnuuk9Io8Iho=
X-Received: by 2002:a05:6000:2283:b0:3a6:f2a7:d0bb with SMTP id
 ffacd0b85a97d-3c5da54ee0amr988708f8f.12.1755840005776; Thu, 21 Aug 2025
 22:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321095556.91425-1-clamor95@gmail.com> <20250321095556.91425-4-clamor95@gmail.com>
 <117069551.nniJfEyVGO@senjougahara>
In-Reply-To: <117069551.nniJfEyVGO@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 22 Aug 2025 08:19:53 +0300
X-Gm-Features: Ac12FXxiZO-Cd4dYwR186y5TmAKHb9LT42IjQgUuEeVgtUMAOTz0EvTyxIUsxCY
Message-ID: <CAPVz0n24N1-iAoQFpzw7r7sz2E4Xhd8fB-gaoPesdc7XaR2HcQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] ARM: tegra: Add DFLL clock support on Tegra 4
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 22 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 06:0=
5 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Friday, March 21, 2025 6:55=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Add DFLL clock node to common Tegra114 device tree along with clocks
> > property to cpu node.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  arch/arm/boot/dts/nvidia/tegra114.dtsi | 34 ++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > b/arch/arm/boot/dts/nvidia/tegra114.dtsi index 341ec0962460..25d063a47c=
a5
> > 100644
> > --- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > +++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
> > @@ -4,6 +4,7 @@
> >  #include <dt-bindings/memory/tegra114-mc.h>
> >  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/reset/tegra114-car.h>
> >  #include <dt-bindings/soc/tegra-pmc.h>
> >
> >  #include "tegra114-peripherals-opp.dtsi"
> > @@ -710,6 +711,30 @@ mipi: mipi@700e3000 {
> >               #nvidia,mipi-calibrate-cells =3D <1>;
> >       };
> >
> > +     dfll: clock@70110000 {
> > +             compatible =3D "nvidia,tegra114-dfll";
> > +             reg =3D <0x70110000 0x100>, /* DFLL control */
> > +                   <0x70110000 0x100>, /* I2C output control */
> > +                   <0x70110100 0x100>, /* Integrated I2C controller */
> > +                   <0x70110200 0x100>; /* Look-up table RAM */
> > +             interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> > +             clocks =3D <&tegra_car TEGRA114_CLK_DFLL_SOC>,
> > +                      <&tegra_car TEGRA114_CLK_DFLL_REF>,
> > +                      <&tegra_car TEGRA114_CLK_I2C5>;
> > +             clock-names =3D "soc", "ref", "i2c";
> > +             resets =3D <&tegra_car TEGRA114_RST_DFLL_DVCO>;
> > +             reset-names =3D "dvco";
> > +             #clock-cells =3D <0>;
> > +             clock-output-names =3D "dfllCPU_out";
> > +             nvidia,sample-rate =3D <11500>;
>
> Should this be 12500? That would match Tegra124 and a downstream kernel f=
or
> Tegra114 I have.
>

I referred to tegratab and macallan boards in 3.4 kernel which give
11500, maybe sample-rate was changed to 12500 later with tegra124
addition?

> > +             nvidia,droop-ctrl =3D <0x00000f00>;
> > +             nvidia,force-mode =3D <1>;
> > +             nvidia,cf =3D <10>;
> > +             nvidia,ci =3D <0>;
> > +             nvidia,cg =3D <2>;
> > +             status =3D "disabled";
> > +     };
> > +
> >       mmc@78000000 {
> >               compatible =3D "nvidia,tegra114-sdhci";
> >               reg =3D <0x78000000 0x200>;
> > @@ -841,6 +866,15 @@ cpu@0 {
> >                       device_type =3D "cpu";
> >                       compatible =3D "arm,cortex-a15";
> >                       reg =3D <0>;
> > +
> > +                     clocks =3D <&tegra_car TEGRA114_CLK_CCLK_G>,
> > +                              <&tegra_car TEGRA114_CLK_CCLK_LP>,
> > +                              <&tegra_car TEGRA114_CLK_PLL_X>,
> > +                              <&tegra_car TEGRA114_CLK_PLL_P>,
> > +                              <&dfll>;
> > +                     clock-names =3D "cpu_g", "cpu_lp", "pll_x", "pll_=
p",
> "dfll";
> > +                     /* FIXME: what's the actual transition time? */
> > +                     clock-latency =3D <300000>;
> >               };
> >
> >               cpu@1 {
>
>
>
>

