Return-Path: <linux-pm+bounces-33618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4742AB3F935
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 10:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C4134E393C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1074C2E88AB;
	Tue,  2 Sep 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t+0hnkZe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA82E8E0C
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803310; cv=none; b=cYGt0E7+y7hQ6dFiyuDcbdxPOfaWkfsrbNIpcujdBAin1NRcZyl0U/PY1C/AVElcPe+H0aLRuBjY1ZptwqqPiMEtTqB/x+om4mSgoZFsgRNsE7GcSPM/CISrlHx4v9xayvw41AYNRt/YpmrPcc+JHvIWdnmreU9SXTTD+AsvkHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803310; c=relaxed/simple;
	bh=kWombz4HNlpFcrMgQMXBBue7C+pUbLQVl5IC6T0/t6o=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Nt8h4TzIXwi87v2QbJQ9bI8jMgNxtvMmy75s1alyP6Cfj6i9njNPWsJRp9lsvFGMJkF/Io9buVXGFKCADXrm615xs53IbzQO56nQOcxREy25Uhf4sAtgBN/znNkTVHq0RvL7zP3nca3c82uiM6QxQDsDyGtufTTGi7+wGZ/P8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=t+0hnkZe; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250902085459epoutp0377e62f25edfa3199e7285894ea06ed15~ha0sR8KhG1911619116epoutp03L
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 08:54:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250902085459epoutp0377e62f25edfa3199e7285894ea06ed15~ha0sR8KhG1911619116epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756803299;
	bh=FWxR7EjLH+QBGQHkkz3O4Nq986bJi5SnUxrGo2YiUnU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=t+0hnkZejLMXJaQHvU/Eq8NUZgvjWhd3NPDCKEr91JamL8i8erMVKWK9yd3B3zWt+
	 lKm4dNit/DoNqCxIM2p3EyJJMggi5cm7mjZBqWnT8J0aeFP6oPX2YZuKlWgWWRCajk
	 QiYcnAM+9T5CLTxNQzHfKxa2dz90Vh0fxsyvjOCY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250902085459epcas2p109f24ef53f3456860134eec6ea128c26~ha0r7H-tJ1839518395epcas2p1u;
	Tue,  2 Sep 2025 08:54:59 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cGKLp5xgDz3hhT3; Tue,  2 Sep
	2025 08:54:58 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250902085457epcas2p11aa355e58a9547378b8cec16241df3b3~ha0qWwE1i1839518395epcas2p1p;
	Tue,  2 Sep 2025 08:54:57 +0000 (GMT)
Received: from KORCO115296 (unknown [12.36.150.221]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250902085457epsmtip2c11dabe67f690f51f48da7afcdba40a7~ha0qR7B5v1783317833epsmtip2K;
	Tue,  2 Sep 2025 08:54:57 +0000 (GMT)
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
In-Reply-To: <f6acdd01-8847-4282-b375-f8e564be81d2@kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: thermal: samsung: Add tmu-name and
 sensor-index-ranges properties
Date: Tue, 2 Sep 2025 17:54:57 +0900
Message-ID: <000401dc1be7$423272b0$c6975810$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ8jFumlJsm8aby6NwUOPwCr1UY/AHbmk9KAflqt+ACX/B717MNBDAw
Content-Language: ko
X-CMS-MailID: 20250902085457epcas2p11aa355e58a9547378b8cec16241df3b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250825064933epcas2p33e2b4566b5911fef8d7127900fc10002
References: <20250825064929.188101-1-shin.son@samsung.com>
	<CGME20250825064933epcas2p33e2b4566b5911fef8d7127900fc10002@epcas2p3.samsung.com>
	<20250825064929.188101-2-shin.son@samsung.com>
	<f6acdd01-8847-4282-b375-f8e564be81d2@kernel.org>

Hello Krzysztof Kozlowski,

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzk=40kernel.org=5D
> Sent: Saturday, August 30, 2025 6:07 PM
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
> Subject: Re: =5BPATCH 1/3=5D dt-bindings: thermal: samsung: Add tmu-name =
and
> sensor-index-ranges properties
>=20
> On 25/08/2025 08:49, Shin Son wrote:
> > The exynosautov920 TMU requires per-sensor interrupt enablement for
> > its critical trip points.
> > Add two new DT properties to the Samsung thermal bindings to support
> > this requirement:
> >
> > - **tmu-name**: an explicit identifier for each TMU,
> > 		used to skip specific sensors
> > (e.g., sensor 5 is temporarily disabled on the TMU_SUB1 block).
> >
> > - **sensor-index-ranges**: defines valid sensor index ranges
> > 			   for the driver=E2=80=99s=20bitmap=20in=20private=20data,=0D=0A>=
=20>=20=09=09=09=20=20=20enabling=20per-sensor=20interrupt=20setup=20and=20=
data=20access.=0D=0A>=20>=0D=0A>=20>=20Signed-off-by:=20Shin=20Son=20<shin.=
son=40samsung.com>=0D=0A>=20>=20---=0D=0A>=20>=20=20.../thermal/samsung,exy=
nos-thermal.yaml=20=20=20=20=20=20=20=7C=2023=20++++++++++++++++++-=0D=0A>=
=20>=20=201=20file=20changed,=2022=20insertions(+),=201=20deletion(-)=0D=0A=
>=20>=0D=0A>=20>=20diff=20--git=0D=0A>=20>=20a/Documentation/devicetree/bin=
dings/thermal/samsung,exynos-thermal.yam=0D=0A>=20>=20l=0D=0A>=20>=20b/Docu=
mentation/devicetree/bindings/thermal/samsung,exynos-thermal.yam=0D=0A>=20>=
=20l=20index=2029a08b0729ee..420fb7a944e3=20100644=0D=0A>=20>=20---=0D=0A>=
=20>=20a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.y=
am=0D=0A>=20>=20l=0D=0A>=20>=20+++=20b/Documentation/devicetree/bindings/th=
ermal/samsung,exynos-thermal=0D=0A>=20>=20+++=20.yaml=0D=0A>=20>=20=40=40=
=20-8,6=20+8,7=20=40=40=20title:=20Samsung=20Exynos=20SoC=20Thermal=20Manag=
ement=20Unit=0D=0A>=20>=20(TMU)=0D=0A>=20>=0D=0A>=20>=20=20maintainers:=0D=
=0A>=20>=20=20=20=20-=20Krzysztof=20Kozlowski=20<krzk=40kernel.org>=0D=0A>=
=20>=20+=20=20-=20Shin=20Son=20<shin.son=40samsung.com>=0D=0A>=20=0D=0A>=20=
This=20needs=20also=20explanation=20in=20commit=20msg.=0D=0A=0D=0AOk,=20I'l=
l=20add=20an=20explanation=20for=20this=0D=0A=0D=0A>=20=0D=0A>=20>=0D=0A>=
=20>=20=20description:=20=7C=0D=0A>=20>=20=20=20=20For=20multi-instance=20t=
mu=20each=20instance=20should=20have=20an=20alias=20correctly=0D=0A>=20>=20=
numbered=20=40=40=20-27,6=20+28,7=20=40=40=20properties:=0D=0A>=20>=20=20=
=20=20=20=20=20=20-=20samsung,exynos5420-tmu-ext-triminfo=0D=0A>=20>=20=20=
=20=20=20=20=20=20-=20samsung,exynos5433-tmu=0D=0A>=20>=20=20=20=20=20=20=
=20=20-=20samsung,exynos7-tmu=0D=0A>=20>=20+=20=20=20=20=20=20-=20samsung,e=
xynosautov920-tmu=0D=0A>=20>=0D=0A>=20>=20=20=20=20clocks:=0D=0A>=20>=20=20=
=20=20=20=20minItems:=201=0D=0A>=20>=20=40=40=20-62,11=20+64,29=20=40=40=20=
properties:=0D=0A>=20>=20=20=20=20=20=20minItems:=201=0D=0A>=20>=0D=0A>=20>=
=20=20=20=20'=23thermal-sensor-cells':=0D=0A>=20>=20-=20=20=20=20const:=200=
=0D=0A>=20>=20+=20=20=20=20enum:=0D=0A>=20>=20+=20=20=20=20=20=20-=200=0D=
=0A>=20>=20+=20=20=20=20=20=20-=201=0D=0A>=20>=0D=0A>=20>=20=20=20=20vtmu-s=
upply:=0D=0A>=20>=20=20=20=20=20=20description:=20The=20regulator=20node=20=
supplying=20voltage=20to=20TMU.=0D=0A>=20>=0D=0A>=20>=20+=20=20tmu-name:=0D=
=0A>=20=0D=0A>=20Generic=20property?=20Where=20is=20it=20defined.=0D=0A=0D=
=0AOk,=20I'll=20remove=20this.=0D=0A=0D=0A>=20=0D=0A>=20>=20+=20=20=20=20de=
scription:=20The=20TMU=20hardware=20name.=0D=0A>=20=0D=0A>=20Anyway,=20you=
=20do=20not=20get=20instance=20IDs.=20I=20talked=20about=20this=20at=20OSSE=
25.=0D=0A=0D=0AI've=20read=20your=20feedback=20and=20also=20reviewed=20your=
=20presentation=20at=20OSSE25.=20=0D=0A(https://osseu2025.sched.com/event/2=
5Vsl/dts-101-from-roots-to-trees-aka-devicetree-for-beginners-krzysztof-koz=
lowski-linaro)=0D=0AI=20will=20remove=20this=20and=20I=20utilized=20another=
=20way.=0D=0A=0D=0A>=20=0D=0A>=20=0D=0A>=20>=20+=20=20=20=20=24ref:=20/sche=
mas/types.yaml=23/definitions/string-array=0D=0A>=20>=20+=20=20=20=20minIte=
ms:=201=0D=0A>=20>=20+=20=20=20=20maxItems:=201=0D=0A>=20>=20+=0D=0A>=20>=
=20+=20=20sensor-index-ranges:=0D=0A>=20=0D=0A>=20Where=20is=20the=20proper=
ty=20defined?=20You=20keep=20adding=20generic=20properties.=0D=0A=0D=0AI'll=
=20remove=20the=20generic=20property=20and=20change=20it=20to=20=22samsung,=
hw-sensor-indexes=22.=0D=0A=0D=0A>=20>=20+=20=20=20=20description:=20=7C=0D=
=0A>=20>=20+=20=20=20=20=20=20Valid=20Sensor=20index=20ranges=20for=20the=
=20TMU=20hardware.=0D=0A>=20=0D=0A>=20I=20don't=20understand=20what=20is=20=
this=20for.=0D=0A=0D=0AI'll=20add=20more=20explanation=20for=20this.=0D=0A=
=0D=0A>=20=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=20=20Note::=20On=20the=
=20ExynosautoV920=20variant,=20the=20fifth=20sensor=20in=20the=20TMU=0D=0A>=
=20SUB1=20is=20disabled,=0D=0A>=20>=20+=20=20=20=20=20=20so=20the=20driver=
=20skips=20it=20when=20matching=20by=20tmu-name.=0D=0A>=20=0D=0A>=20That's=
=20not=20name,=20so=20why=20are=20you=20referring=20to=20tmu-name?=20And=20=
driver=20has=0D=0A>=20nothing=20to=20do=20here.=20Describe=20hardware.=0D=
=0A>=20=0D=0A>=20None=20of=20this=20is=20really=20correct.=20:/=0D=0A>=20=
=0D=0A>=20=0D=0A>=20Best=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=0AI'll=20re=
work=20the=20binding=20as=20you=20suggested.=0D=0AInstead=20of=20using=20ra=
nges,=20I'll=20list=20the=20sensor=20indices=20explicitly,=0D=0AWhich=20sho=
uld=20address=20the=20issues=20you=20pointed=20out.=0D=0A=0D=0AI'll=20inclu=
de=20this=20change=20in=20the=20next=20revision,=0D=0Aso=20I=20would=20appr=
eciate=20your=20review=20again.=0D=0AThank=20you.=0D=0A=0D=0ABest=20regards=
,=0D=0AShin=20Son=0D=0A=0D=0A

