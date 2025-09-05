Return-Path: <linux-pm+bounces-33935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBB3B45207
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEE4B63138
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 08:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D183280A29;
	Fri,  5 Sep 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VokOjQNR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BA15DBC1
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062068; cv=none; b=LK+R0hDsn02utRhYU3W7YVJOYbSdp87cZqXRwVZfJNe4SKAB1yxDF3/CAaGf/kiE/ZBGKhxSrDD7mr3TZrUvgLT0TxGDA92ohGcCbcJ8WqDkq01ZVkmDA+QaV0eePftovF0Syw63lNpfl6eKoi5soBQQ70Qlvz3K9S+FDglDbZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062068; c=relaxed/simple;
	bh=fOZPrfeirJR+JDRPn+8B9LZz7+N94QcXaMJ5P19eoWc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=j/4cXyiDlcTBKEymHNnW7X+NnGf9N0nlx8dRFjQpoGcByrp/Lu90fRyWu2xLhBwvCX2HuAvP9066aycpPC7C+P6zbAHmS5xbL0/wuG5+CfoHprWhm9RwtcWEGiUPJX1A6B9AFqoeHaLPiPkoDdxtzHWGYMesw2ocQzKwZ4bwafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VokOjQNR; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250905084744epoutp03eb0bdeecc1333c1bf0156aef81e61eeb~iVqNV10650472604726epoutp03U
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 08:47:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250905084744epoutp03eb0bdeecc1333c1bf0156aef81e61eeb~iVqNV10650472604726epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757062064;
	bh=mGHoIy1u5YwF44RSJWPpqSfDEUJvtheqWLknK2zHyFU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=VokOjQNRa8qIcm/dtJHJLnFz4cy+2SXpSsrUeiIjUgZb52kFbUykbkZSNSPzbAbpK
	 JskakR2E3dhwPWqjxKeaJ7obpfG0rmiJLZoVzkCT6YyyodrgQJeq8uqzTMY0Z4Ywax
	 4WlxLolGlOritOGvJtNx2tTBdqjH62OcyBmCan/A=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250905084743epcas2p1209d3973b38799f3420a2824b3332e6b~iVqM0BAPM2283222832epcas2p11;
	Fri,  5 Sep 2025 08:47:43 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.68]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cJ8zC2rZ7z6B9mB; Fri,  5 Sep
	2025 08:44:23 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250905084422epcas2p3adcac9df0246c693fccd56c6321633a0~iVnRzknAo1169711697epcas2p3z;
	Fri,  5 Sep 2025 08:44:22 +0000 (GMT)
Received: from KORCO115296 (unknown [12.36.150.221]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250905084422epsmtip1c3a98abb7296146ebad52327dc761bfb~iVnRuW2Wo1642316423epsmtip1R;
	Fri,  5 Sep 2025 08:44:22 +0000 (GMT)
From: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>, "'Rafael J .
 Wysocki'" <rafael@kernel.org>, "'Daniel Lezcano'"
	<daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>, "'Lukasz
 Luba'" <lukasz.luba@arm.com>, "'Rob Herring'" <robh@kernel.org>, "'Conor
 Dooley'" <conor+dt@kernel.org>, "'Alim Akhtar'" <alim.akhtar@samsung.com>,
	<linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20250904-chocolate-kangaroo-of-order-2cced3@kuoka>
Subject: RE: [PATCH v2 1/3] dt-bindings: thermal: samsung: Add tmu-name and
 sensor-index-ranges properties
Date: Fri, 5 Sep 2025 17:44:22 +0900
Message-ID: <022001dc1e41$46f7ba60$d4e72f20$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJcDpuT0zWDya8nliyk6vzs/32vBQIURjbqAvLO/ccDYiYaWLNA+7WQ
Content-Language: ko
X-CMS-MailID: 20250905084422epcas2p3adcac9df0246c693fccd56c6321633a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91
References: <20250903073634.1898865-1-shin.son@samsung.com>
	<CGME20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91@epcas2p4.samsung.com>
	<20250903073634.1898865-2-shin.son@samsung.com>
	<20250904-chocolate-kangaroo-of-order-2cced3@kuoka>

Hello Krzysztof Kozlowski,

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzk=40kernel.org=5D
> Sent: Thursday, September 4, 2025 5:00 PM
> To: Shin Son <shin.son=40samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier=40gmail.com>; Rafael J . Wysocki
> <rafael=40kernel.org>; Daniel Lezcano <daniel.lezcano=40linaro.org>; Zhan=
g Rui
> <rui.zhang=40intel.com>; Lukasz Luba <lukasz.luba=40arm.com>; Rob Herring
> <robh=40kernel.org>; Conor Dooley <conor+dt=40kernel.org>; Alim Akhtar
> <alim.akhtar=40samsung.com>; linux-pm=40vger.kernel.org; linux-samsung-
> soc=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
> Subject: Re: =5BPATCH v2 1/3=5D dt-bindings: thermal: samsung: Add tmu-na=
me
> and sensor-index-ranges properties
>=20
> On Wed, Sep 03, 2025 at 04:36:32PM +0900, Shin Son wrote:
> > The exynosautov920 TMU requires per-sensor interrupt enablement for
> > its critical trip points.
> > Add a DT property to the Samsung thermal bindings to support this
> > requirement:
>=20
> That's pretty redundant sentence.

I'll remove this sentence.

> >
> > - **samsung,hw-sensor-indices**: Defines the sensors currently
> >                                  mapped to the TMU hardware.
> > 				 Indices not listed are absent or fused off
>=20
> Don't write here any code, but concise prose dxescribing hardware.
>=20
> If sensors are fused out, you certainly can read their status from efuse,
> no?

=22fused out=22 was a wrong expression =E2=80=94=20sensors=20are=20not=20in=
dicated=20in=20any=20register.=20Sorry=20for=20the=20confusion.=0D=0AThe=20=
hardware=20does=20not=20provide=20a=20bitmask=20of=20present=20sensors.=0D=
=0ATherefore,=20the=20DT=20must=20explicitly=20list=20which=20indices=20bel=
ong=20to=20this=20TMU=20instance.=0D=0A=0D=0AAdditionally,=20I'll=20rephras=
e=20this=20sentence=20to=20clearly=20describe=20the=20TMU=20hardware=20only=
.=0D=0A=0D=0A>=20=0D=0A>=20This=20is=20really=20vague=20description=20of=20=
hardware.=20I=20don't=20understand=20why=20you=0D=0A>=20are=20changing=20se=
nsor-cells,=20why=20older=20variants=20of=20tmu=20gets=20now=20cells=3D1=0D=
=0A>=20(missing=20constraints?).=0D=0A>=20=0D=0A>=20Why=20older=20variants=
=20also=20get=20that=20property=20for=20sensors?=20It=20does=20not=20make=
=0D=0A>=20sense=20there,=20because=20they=20have=20one-to-one=20mapping=20b=
etween=20TMU=20and=20sensor.=0D=0A=0D=0AOlder=20variants=20should=20be=20fi=
xed=20to=200,=0D=0Abut=20my=20patch=20mistakenly=20opened=20it=20with=20an=
=20enum=20so=20that=201=20was=20also=20allowed=20there,=20I'll=20fix=20this=
.=0D=0AI'll=20also=20restrict=20the=20sensor=20indices=20property=20to=20v9=
20=20only.=0D=0A=0D=0A>=20=0D=0A>=20>=0D=0A>=20>=20Additionally,=20add=20my=
self=20to=20the=20bindings'=20maintainers=20list,=20as=20I=20plan=0D=0A>=20=
>=20to=20actively=20work=20on=20the=20exynosautov920=20TMU=20support=20and=
=20handle=20further=0D=0A>=20>=20updates=20in=20this=20area.=0D=0A>=20>=0D=
=0A>=20>=20Signed-off-by:=20Shin=20Son=20<shin.son=40samsung.com>=0D=0A>=20=
>=20---=0D=0A>=20>=20=20.../bindings/thermal/samsung,exynos-thermal.yaml=20=
=7C=2016=0D=0A>=20>=20+++++++++++++++-=0D=0A>=20>=20=201=20file=20changed,=
=2015=20insertions(+),=201=20deletion(-)=0D=0A>=20>=0D=0A>=20>=20diff=20--g=
it=0D=0A>=20>=20a/Documentation/devicetree/bindings/thermal/samsung,exynos-=
thermal.yam=0D=0A>=20>=20l=0D=0A>=20>=20b/Documentation/devicetree/bindings=
/thermal/samsung,exynos-thermal.yam=0D=0A>=20>=20l=20index=2029a08b0729ee..=
abd89902d33a=20100644=0D=0A>=20>=20---=0D=0A>=20>=20a/Documentation/devicet=
ree/bindings/thermal/samsung,exynos-thermal.yam=0D=0A>=20>=20l=0D=0A>=20>=
=20+++=20b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal=
=0D=0A>=20>=20+++=20.yaml=0D=0A>=20>=20=40=40=20-8,6=20+8,7=20=40=40=20titl=
e:=20Samsung=20Exynos=20SoC=20Thermal=20Management=20Unit=0D=0A>=20>=20(TMU=
)=0D=0A>=20>=0D=0A>=20>=20=20maintainers:=0D=0A>=20>=20=20=20=20-=20Krzyszt=
of=20Kozlowski=20<krzk=40kernel.org>=0D=0A>=20>=20+=20=20-=20Shin=20Son=20<=
shin.son=40samsung.com>=0D=0A>=20>=0D=0A>=20>=20=20description:=20=7C=0D=0A=
>=20>=20=20=20=20For=20multi-instance=20tmu=20each=20instance=20should=20ha=
ve=20an=20alias=20correctly=0D=0A>=20>=20numbered=20=40=40=20-27,6=20+28,7=
=20=40=40=20properties:=0D=0A>=20>=20=20=20=20=20=20=20=20-=20samsung,exyno=
s5420-tmu-ext-triminfo=0D=0A>=20>=20=20=20=20=20=20=20=20-=20samsung,exynos=
5433-tmu=0D=0A>=20>=20=20=20=20=20=20=20=20-=20samsung,exynos7-tmu=0D=0A>=
=20>=20+=20=20=20=20=20=20-=20samsung,exynosautov920-tmu=0D=0A>=20>=0D=0A>=
=20>=20=20=20=20clocks:=0D=0A>=20>=20=20=20=20=20=20minItems:=201=0D=0A>=20=
>=20=40=40=20-62,11=20+64,22=20=40=40=20properties:=0D=0A>=20>=20=20=20=20=
=20=20minItems:=201=0D=0A>=20>=0D=0A>=20>=20=20=20=20'=23thermal-sensor-cel=
ls':=0D=0A>=20>=20-=20=20=20=20const:=200=0D=0A>=20>=20+=20=20=20=20enum:=
=0D=0A>=20>=20+=20=20=20=20=20=20-=200=0D=0A>=20>=20+=20=20=20=20=20=20-=20=
1=0D=0A>=20>=0D=0A>=20>=20=20=20=20vtmu-supply:=0D=0A>=20>=20=20=20=20=20=
=20description:=20The=20regulator=20node=20supplying=20voltage=20to=20TMU.=
=0D=0A>=20>=0D=0A>=20>=20+=20=20samsung,hw-sensor-indices:=0D=0A>=20>=20+=
=20=20=20=20description:=20=7C=0D=0A>=20=0D=0A>=20Drop=20=7C=0D=0A=0D=0AI'l=
l=20drop=20this.=0D=0A=0D=0A>=20=0D=0A>=20>=20+=20=20=20=20=20=20List=20of=
=20hardware=20sensor=20indices=20that=20are=20physically=20present=20and=0D=
=0A>=20usable=0D=0A>=20>=20+=20=20=20=20=20=20in=20this=20TMU=20instance.=
=20Indices=20not=20listed=20are=20either=20unmapped=20or=0D=0A>=20unused.=
=0D=0A>=20>=20+=20=20=20=20=24ref:=20/schemas/types.yaml=23/definitions/uin=
t32-array=0D=0A>=20>=20+=20=20=20=20minItems:=201=0D=0A>=20>=20+=20=20=20=
=20maxItems:=2016=0D=0A>=20>=20+=20=20=20=20uniqueItems:=20true=0D=0A>=20=
=0D=0A>=20Best=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=0AThanks.=0D=0A=0D=0A=
Best=20regards,=0D=0AShin=20Son=0D=0A=0D=0A

