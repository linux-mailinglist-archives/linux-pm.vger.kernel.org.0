Return-Path: <linux-pm+bounces-33623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E62B3F9A9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1304817301D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4A2EA16B;
	Tue,  2 Sep 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KfEszHi2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582D2E8E03
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804014; cv=none; b=ldvj2xQc51Asd7//GFNE3cKHulBQa9/oxAGBalvPRp2NBhBLkDQkGyAX3rJWwIelqFGsiz7ukHFhgzi9FfbQsB8jO6vzrNjcuB8PTJUr93ciQRN3NaIXrICndWzpgQDI4nKTJgKlhzQNDeu2GP8tV6hZMIvEjD3w7FBtns+A5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804014; c=relaxed/simple;
	bh=JgvZsw052NS4w823eEltRQux47qIyG7FAKLhhN0lOwI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=HVeOM65lea8X5+wMQVXnTfDh3hYPedFPCt+4mLMPIzy0WaD2FnPJD5Aj0U+etmOPZvAc49oEOZd4XJ4ZQgr2fjMbXufckLGoA/rU7PQWA9UaMZZlMWdj+LCpdBOg1JxyZB9IwwVWc9tO1V+WmR36NU8oh5JjehCZEVloRWfmy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KfEszHi2; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250902090650epoutp04c559153217b14b4be9f29d9bad92f2ae~ha-CJYqQy1116011160epoutp04_
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 09:06:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250902090650epoutp04c559153217b14b4be9f29d9bad92f2ae~ha-CJYqQy1116011160epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756804010;
	bh=LLyxRGwalIyNnt2QKIpysW7aXCLGTKUEGde82xrN0gg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=KfEszHi2Ae3f5DfYxZb2BsT2K3y0XN5mIflw5VcJRpIyDEdgamdgXgxLRfNv+9XXp
	 JNbxJAtGoxmLYEPbWlnCs51wWdY2H8aYYSIcY6+tFNxn9Xw3htITwOasYovItHMY4v
	 0sMRc1dQOj9VT0M2KSaPC89c+CmqOaAzP5EOcJkQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250902090649epcas2p26e03bbc57a829825eeff3dd12573257a~ha-BfOvEf1900619006epcas2p2T;
	Tue,  2 Sep 2025 09:06:49 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cGKcT1GvQz2SSKq; Tue,  2 Sep
	2025 09:06:49 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250902090648epcas2p296bd62ad9bb707f5671c50d2c21877ac~ha-ACTpGE3115731157epcas2p2Z;
	Tue,  2 Sep 2025 09:06:48 +0000 (GMT)
Received: from KORCO115296 (unknown [12.36.150.221]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250902090648epsmtip164a0f755c2d4a1395a6e70587a177e15~ha_-9FnBY1848318483epsmtip1H;
	Tue,  2 Sep 2025 09:06:48 +0000 (GMT)
From: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Bartlomiej Zolnierkiewicz'"
	<bzolnier@gmail.com>, "'Rafael J . Wysocki'" <rafael@kernel.org>, "'Daniel
 Lezcano'" <daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>,
	"'Lukasz	Luba'" <lukasz.luba@arm.com>, "'Rob Herring'" <robh@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>, "'Alim Akhtar'"
	<alim.akhtar@samsung.com>
Cc: <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <e573cfc8-be9c-482c-9b06-4eedbb92d520@kernel.org>
Subject: RE: [PATCH 3/3] arm64: dts: exynosautov920: Add tmu hardware
 binding
Date: Tue, 2 Sep 2025 18:06:47 +0900
Message-ID: <000501dc1be8$e9ac0640$bd0412c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ8jFumlJsm8aby6NwUOPwCr1UY/AFeDEJ7AytiP1UDOWYPQrMAn3WQ
Content-Language: ko
X-CMS-MailID: 20250902090648epcas2p296bd62ad9bb707f5671c50d2c21877ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250825064933epcas2p40a7c491366097f90add675bc36822ef9
References: <20250825064929.188101-1-shin.son@samsung.com>
	<CGME20250825064933epcas2p40a7c491366097f90add675bc36822ef9@epcas2p4.samsung.com>
	<20250825064929.188101-4-shin.son@samsung.com>
	<e573cfc8-be9c-482c-9b06-4eedbb92d520@kernel.org>

Hello Krzysztof Kozlowski,

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzk=40kernel.org=5D
> Sent: Saturday, August 30, 2025 6:08 PM
> To: Shin Son <shin.son=40samsung.com>; Bartlomiej Zolnierkiewicz
> <bzolnier=40gmail.com>; Rafael J . Wysocki <rafael=40kernel.org>; Daniel
> Lezcano <daniel.lezcano=40linaro.org>; Zhang Rui <rui.zhang=40intel.com>;
> Lukasz Luba <lukasz.luba=40arm.com>; Rob Herring <robh=40kernel.org>; Con=
or
> Dooley <conor+dt=40kernel.org>; Alim Akhtar <alim.akhtar=40samsung.com>
> Cc: linux-pm=40vger.kernel.org; linux-samsung-soc=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> kernel=40vger.kernel.org
> Subject: Re: =5BPATCH 3/3=5D arm64: dts: exynosautov920: Add tmu hardware
> binding
>=20
> On 25/08/2025 08:49, Shin Son wrote:
> > Create a new exynosautov920-tmu.dtsi describing new TMU hardware and
> > include it from exynosautov920.dtsi.
> >
> > The exynosautov920-tmu node uses the misc clock as its source and
> > exposes two new DT properties:
> >
> > - tmu-name: identifies the TMU variant for sensor skipping
> > - sensor-index-ranges: defines valid sensor index ranges for the
> > bitmap
> >
> > This TMU binding defines six thermal zones with a critical trip point
> > at 125 degrees:
> >
> > tmu_top : cpucl0-left, cpucl1
> > tmu_sub0: cpucl0-right, cpucl2
> > tmu_sub1: g3d, npu
> >
> > Signed-off-by: Shin Son <shin.son=40samsung.com>
> > ---
> >  .../boot/dts/exynos/exynosautov920-tmu.dtsi   =7C 92 +++++++++++++++++=
++
> >  .../arm64/boot/dts/exynos/exynosautov920.dtsi =7C 34 +++++++
> >  2 files changed, 126 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
> > b/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
> > new file mode 100644
> > index 000000000000..fa88e9bcdfec
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynosautov920-tmu.dtsi
> > =40=40 -0,0 +1,92 =40=40
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Samsung's ExynosAuto920 TMU configurations device tree source
> > + *
> > + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> > + *
> > + * Samsung's ExynosAuto920 SoC TMU(Thermal Managemenut Unit) are
> > +listed as
> > + * device tree nodes in this file.
> > + */
> > +
> > +/ =7B
> > +	thermal-zones =7B
> > +		cpucl0left-thermal =7B
> > +			polling-delay-passive =3D <0>;
> > +			polling-delay =3D <0>;
> > +			thermal-sensors =3D <&tmuctrl_top 0>;
> > +
> > +			trips =7B
> > +				cpucl0_0_critical: cpucl0-0-critical =7B
> > +					temperature =3D <125000>;	/*
> millicelsius */
> > +					hysteresis =3D <0>;	/* millicelsius */
> > +					type =3D =22critical=22;
> > +				=7D;
> > +			=7D;
> > +		=7D;
>=20
> Missing blank line.

I'll remove the blank line.

>=20
> > +		cpucl0right-thermal =7B
>=20
> It does not look like you tested the DTS against bindings. Please run
> =60make dtbs_check W=3D1=60 (see Documentation/devicetree/bindings/writin=
g-
> schema.rst or https://protect2.fireeye.com/v1/url?k=3D004c918d-61c784be-
> 004d1ac2-000babff9bb7-06e007e7dc12091d&q=3D1&e=3Dd6a22592-2d45-41f5-b737-
> a90830cceaeb&u=3Dhttps%3A%2F%2Fwww.linaro.org%2Fblog%2Ftips-and-tricks-fo=
r-
> validating-devicetree-sources-with-the-devicetree-schema%2F
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on distro
> packages for dtschema and be sure you are using the latest released
> dtschema.
>=20

Actually, I also updated both dtschema and yamllint and ran =22make CHECK_D=
TBS=3Dy W=3D1 exynos/exynosautov920-sadk.dtb=22, but no other issues were d=
etected.
I assume that the problem you mentioned about =22cpucl0right-thermal=22 mig=
ht be related to the regex.
Based on this assumption, I'll shorten the node name and include the change=
 in the next version.
If that is not the case, I'll investigate it further from another angle.

> > +			polling-delay-passive =3D <0>;
> > +			polling-delay =3D <0>;
> > +			thermal-sensors =3D <&tmuctrl_sub0 0>;
> > +
> > +			trips =7B
> > +				cpucl0_1_critical: cpucl0-1-critical =7B
> > +					temperature =3D <125000>;	/*
> millicelsius */
> > +					hysteresis =3D <0>;	/* millicelsius */
> > +					type =3D =22critical=22;
> > +				=7D;
> > +			=7D;
> > +		=7D;
> > +		cpucl1-thermal =7B
> > +			polling-delay-passive =3D <0>;
> > +			polling-delay =3D <0>;
> > +			thermal-sensors =3D <&tmuctrl_top 1>;
> > +
> > +			trips =7B
> > +				cpucl1_critical: cpucl1-critical =7B
> > +					temperature =3D <125000>;	/*
> millicelsius */
> > +					hysteresis =3D <0>;	/* millicelsius */
> > +					type =3D =22critical=22;
> > +				=7D;
> > +			=7D;
> > +		=7D;
> > +		cpucl2-thermal =7B
> > +			polling-delay-passive =3D <0>;
> > +			polling-delay =3D <0>;
> > +			thermal-sensors =3D <&tmuctrl_sub0 1>;
> > +
> > +			trips =7B
> > +				cpucl2_critical: cpucl2-critical =7B
> > +					temperature =3D <125000>;	/*
> millicelsius */
> > +					hysteresis =3D <0>;	/* millicelsius */
> > +					type =3D =22critical=22;
> > +				=7D;
> > +			=7D;
> > +		=7D;
> > +		g3d-thermal =7B
> > +			polling-delay-passive =3D <0>;
> > +			polling-delay =3D <0>;
> > +			thermal-sensors =3D <&tmuctrl_sub1 0>;
> > +
> > +			trips =7B
> > +				g3d_critical: g3d-critical =7B
> > +					temperature =3D <125000>; /* millicelsius
> */
> > +					hysteresis =3D <0>; /* millicelsius */
> > +					type =3D =22critical=22;
> > +				=7D;
> > +			=7D;
> > +		=7D;
> > +		npu-thermal =7B
> > +			polling-delay-passive =3D <0>;
> > +			polling-delay =3D <0>;
> > +			thermal-sensors =3D <&tmuctrl_sub1 1>;
> > +
> > +			trips =7B
> > +				npu_critical: npu-critical =7B
> > +					temperature =3D <125000>; /* millicelsius
> */
> > +					hysteresis =3D <0>; /* millicelsius */
> > +					type =3D =22critical=22;
> > +				=7D;
> > +			=7D;
> > +		=7D;
> > +	=7D;
> > +=7D;
> > diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> > b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> > index 0fdf2062930a..a4ff941f8e43 100644
> > --- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> > +++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> > =40=40 -330,6 +330,39 =40=40 watchdog_cl1: watchdog=4010070000 =7B
> >  			samsung,cluster-index =3D <1>;
> >  		=7D;
> >
> > +		tmuctrl_top: tmutop-thermal=40100a0000 =7B
>=20
> Node names should be generic. See also an explanation and list of example=
s
> (not exhaustive) in DT specification:
> https://protect2.fireeye.com/v1/url?k=3Dfbd86cff-9a5379cc-fbd9e7b0-
> 000babff9bb7-cfe00d75a7b0cdcf&q=3D1&e=3Dd6a22592-2d45-41f5-b737-
> a90830cceaeb&u=3Dhttps%3A%2F%2Fdevicetree-
> specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-
> basics.html%23generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to D=
T
> spec repo).
>=20
>=20
> Best regards,
> Krzysztof

Okay, I'll change the node names(e.g., tmutop-thermal ...) to be more gener=
ic.
After reviewing the existing kernel source, I noticed that nodes are writte=
n in the form of tmu=40..., so I will adopt that convention.
These changes will be included in the next version. Thank you.


