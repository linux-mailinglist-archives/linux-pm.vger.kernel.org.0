Return-Path: <linux-pm+bounces-34654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDDB5739A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B75817332F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314A52F28EC;
	Mon, 15 Sep 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MedraKfH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AE2F28E7
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926305; cv=none; b=KpsXXDBJhm0epTVCESo82vUBmN/CLhuS+FqdKz8+wH9hGqvhkY/2N4S24YZv+Hu1JvP4wkSb00vVyQ2qWg6KHGZLb/AHPb+307eAlpF+y569TtrqQI+Txjh/m1c4tJw9KhXghn/W5uP8q6/G0YN1DS86f4WjCw3swpN7adWmRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926305; c=relaxed/simple;
	bh=V3y54E2BdymNuc5NY8vOwonPsgJIAekAN7zO4zsTLCU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=JNtolulLmLdUR7WR6Gn+cqwkeimWdGanKmrfQGSB3eC4jZWiCYkPCUpN7m3SYrJC7p0Xn0x2S8b6Np6C8QXcPH/hlcxgF/i6CH9Qw71QhvgkFtUPMMq5BJhq+/iw0c0xpf8m205Vf4qPF8+0tfqTbSQ1gvLd93CMByVhh7j7NIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MedraKfH; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250915085140epoutp04fdb9e16358766379216994b4d947332a~laKgVykJp0143501435epoutp04Z
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:51:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250915085140epoutp04fdb9e16358766379216994b4d947332a~laKgVykJp0143501435epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757926300;
	bh=QBZQ2T2IZb9DQ5IKJhfncUR/bMicrgAtY+dpr/zeHT0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=MedraKfHUyaAHFSN+Kx1D0w1PiBwWeuUJtEb0nhh2T26ar+2y1uoeFj6p8U0/biIU
	 67PCxuds34yT2r7l0oXQGFmV/MliMedPiKUKLqO7iAW/kSmSIABnfzWS6sWkHqTMXn
	 Gk2xM46Z91lriMnGEsMpMYImXq0X6JRrOIcsSjzc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250915085140epcas2p264ea28075622118bb8178354436c2cfc~laKfzCsiN1521415214epcas2p2M;
	Mon, 15 Sep 2025 08:51:40 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cQJfz3k27z6B9mK; Mon, 15 Sep
	2025 08:51:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250915085138epcas2p4b3b2f8058172efd14ca4438ccb232a7c~laKefpnwd1110011100epcas2p46;
	Mon, 15 Sep 2025 08:51:38 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250915085138epsmtip19453fc15026e8e8a191121d4eb7d3f4f~laKeaRwwd1433914339epsmtip1J;
	Mon, 15 Sep 2025 08:51:38 +0000 (GMT)
From: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Bartlomiej Zolnierkiewicz'"
	<bzolnier@gmail.com>, "'Rafael J . Wysocki'" <rafael@kernel.org>, "'Daniel
 Lezcano'" <daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>,
	"'Lukasz	Luba'" <lukasz.luba@arm.com>, "'Rob Herring'" <robh@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>, "'Alim Akhtar'"
	<alim.akhtar@samsung.com>, "'Henrik Grimler'" <henrik@grimler.se>
Cc: <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <b453e64b-b3db-4b8f-ba9d-0da7e55fe057@kernel.org>
Subject: RE: [PATCH v3 1/3] dt-bindings: thermal: samsung: Add a
 hw-sensor-indices property
Date: Mon, 15 Sep 2025 17:51:38 +0900
Message-ID: <060601dc261d$f2f2d5a0$d8d880e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQI2gN6OiEY8j6d92YCX64Q86w41mAJQEA6QAjvruSIB3AjCg7Or+Kxw
Content-Language: ko
X-CMS-MailID: 20250915085138epcas2p4b3b2f8058172efd14ca4438ccb232a7c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250915040742epcas2p4ddc37eb56eb9d96313a5c3fac8befe5d
References: <20250915040715.486733-1-shin.son@samsung.com>
	<CGME20250915040742epcas2p4ddc37eb56eb9d96313a5c3fac8befe5d@epcas2p4.samsung.com>
	<20250915040715.486733-2-shin.son@samsung.com>
	<b453e64b-b3db-4b8f-ba9d-0da7e55fe057@kernel.org>

Hello, Krzysztof Kozlowski.

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzk=40kernel.org=5D
> Sent: Monday, September 15, 2025 1:29 PM
> To: Shin Son <shin.son=40samsung.com>; Bartlomiej Zolnierkiewicz
> <bzolnier=40gmail.com>; Rafael J . Wysocki <rafael=40kernel.org>; Daniel
> Lezcano <daniel.lezcano=40linaro.org>; Zhang Rui <rui.zhang=40intel.com>;
> Lukasz Luba <lukasz.luba=40arm.com>; Rob Herring <robh=40kernel.org>; Con=
or
> Dooley <conor+dt=40kernel.org>; Alim Akhtar <alim.akhtar=40samsung.com>;
> Henrik Grimler <henrik=40grimler.se>
> Cc: linux-pm=40vger.kernel.org; linux-samsung-soc=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> kernel=40vger.kernel.org
> Subject: Re: =5BPATCH v3 1/3=5D dt-bindings: thermal: samsung: Add a hw-
> sensor-indices property
>=20
> On 15/09/2025 06:07, Shin Son wrote:
> > The exynosautov920 TMU requires per-sensor interrupt enablement for
> > its critical trip points.
> >
> > - **samsung,hw-sensor-indices**: List of sensor indices physically
> >                                  monitored by this TMU block.
> > 				 Indicies not listed exist in the SoC
> > 				 register map but are not part of
> > 				 this TMU instance
>=20
> Not much improved here. Same comment as before. That's not even correct
> syntax but some oddly formatted code. I asked to drop it and instead
> describe hardware. This is not a place to write some **code** or whatever
> this paragraph is about to represent.

Understood=E2=80=94sorry=20for=20the=20confusion.=20I'll=20remove=20the=20c=
ode-like=20formatting=20and=20replace=20it=20with=20a=20plain,=20hardware-f=
ocused=0D=0ADescription=20as=20requested.=0D=0A=0D=0A>=20=0D=0A>=20>=0D=0A>=
=20>=20Additionally,=20add=20myself=20to=20the=20bindings'=20maintainers=20=
list,=20as=20I=20plan=0D=0A>=20>=20to=20actively=20work=20on=20the=20exynos=
autov920=20TMU=20support=20and=20handle=20further=0D=0A>=20>=20updates=20in=
=20this=20area.=0D=0A>=20>=20I=20also=20restrict=20'samsung,hw-sensor-indic=
es'=20to=20the=20V920=20variant.=20To=0D=0A>=20>=20ensure=20properties=20in=
troduced=20in=20'if/then'=20blocks=20are=20recognized,=20I=0D=0A>=20>=20rep=
lace=20'addtionalProperties:=20false'=20with=20'unevaluatedProperties:=20fa=
lse'.=0D=0A>=20=0D=0A>=20No,=20don't=20do=20that.=0D=0A=0D=0AUnderstood.=20=
I'll=20keep=20'addtionalProperties:=20false'=20as=20is=20and=20promote=20's=
amsung,hw-sensor-indices'=20to=20the=20common=20sections.=0D=0A=0D=0A>=20=
=0D=0A>=20>=0D=0A>=20>=20Signed-off-by:=20Shin=20Son=20<shin.son=40samsung.=
com>=0D=0A>=20>=20---=0D=0A>=20>=20=20.../thermal/samsung,exynos-thermal.ya=
ml=20=20=20=20=20=20=20=7C=2040=20++++++++++++++++++-=0D=0A>=20>=20=201=20f=
ile=20changed,=2038=20insertions(+),=202=20deletions(-)=0D=0A>=20>=0D=0A>=
=20>=20diff=20--git=0D=0A>=20>=20a/Documentation/devicetree/bindings/therma=
l/samsung,exynos-thermal.yam=0D=0A>=20>=20l=0D=0A>=20>=20b/Documentation/de=
vicetree/bindings/thermal/samsung,exynos-thermal.yam=0D=0A>=20>=20l=20index=
=2029a08b0729ee..448c68986b10=20100644=0D=0A>=20>=20---=0D=0A>=20>=20a/Docu=
mentation/devicetree/bindings/thermal/samsung,exynos-thermal.yam=0D=0A>=20>=
=20l=0D=0A>=20>=20+++=20b/Documentation/devicetree/bindings/thermal/samsung=
,exynos-thermal=0D=0A>=20>=20+++=20.yaml=0D=0A>=20>=20=40=40=20-8,6=20+8,7=
=20=40=40=20title:=20Samsung=20Exynos=20SoC=20Thermal=20Management=20Unit=
=0D=0A>=20>=20(TMU)=0D=0A>=20>=0D=0A>=20>=20=20maintainers:=0D=0A>=20>=20=
=20=20=20-=20Krzysztof=20Kozlowski=20<krzk=40kernel.org>=0D=0A>=20>=20+=20=
=20-=20Shin=20Son=20<shin.son=40samsung.com>=0D=0A>=20>=0D=0A>=20>=20=20des=
cription:=20=7C=0D=0A>=20>=20=20=20=20For=20multi-instance=20tmu=20each=20i=
nstance=20should=20have=20an=20alias=20correctly=0D=0A>=20>=20numbered=20=
=40=40=20-27,6=20+28,7=20=40=40=20properties:=0D=0A>=20>=20=20=20=20=20=20=
=20=20-=20samsung,exynos5420-tmu-ext-triminfo=0D=0A>=20>=20=20=20=20=20=20=
=20=20-=20samsung,exynos5433-tmu=0D=0A>=20>=20=20=20=20=20=20=20=20-=20sams=
ung,exynos7-tmu=0D=0A>=20>=20+=20=20=20=20=20=20-=20samsung,exynosautov920-=
tmu=0D=0A>=20>=0D=0A>=20>=20=20=20=20clocks:=0D=0A>=20>=20=20=20=20=20=20mi=
nItems:=201=0D=0A>=20>=20=40=40=20-62,7=20+64,7=20=40=40=20properties:=0D=
=0A>=20>=20=20=20=20=20=20minItems:=201=0D=0A>=20>=0D=0A>=20>=20=20=20=20'=
=23thermal-sensor-cells':=0D=0A>=20>=20-=20=20=20=20const:=200=0D=0A>=20>=
=20+=20=20=20=20enum:=20=5B0,=201=5D=0D=0A>=20>=0D=0A>=20>=20=20=20=20vtmu-=
supply:=0D=0A>=20>=20=20=20=20=20=20description:=20The=20regulator=20node=
=20supplying=20voltage=20to=20TMU.=0D=0A>=20>=20=40=40=20-97,6=20+99,8=20=
=40=40=20allOf:=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20reg:=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20=20=20=20minItems:=202=0D=0A>=20>=20=20=20=20=20=20=
=20=20=20=20=20=20maxItems:=202=0D=0A>=20>=20+=20=20=20=20=20=20=20=20'=23t=
hermal-sensor-cells':=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20const:=20=
0=0D=0A>=20>=20=20=20=20-=20if:=0D=0A>=20>=20=20=20=20=20=20=20=20propertie=
s:=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20compatible:=0D=0A>=20>=20=40=40=
=20-119,6=20+123,8=20=40=40=20allOf:=0D=0A>=20>=20=20=20=20=20=20=20=20=20=
=20reg:=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A>=
=20>=20=20=20=20=20=20=20=20=20=20=20=20maxItems:=201=0D=0A>=20>=20+=20=20=
=20=20=20=20=20=20'=23thermal-sensor-cells':=0D=0A>=20>=20+=20=20=20=20=20=
=20=20=20=20=20const:=200=0D=0A>=20>=0D=0A>=20>=20=20=20=20-=20if:=0D=0A>=
=20>=20=20=20=20=20=20=20=20properties:=0D=0A>=20>=20=40=40=20-139,8=20+145=
,38=20=40=40=20allOf:=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20reg:=0D=0A>=
=20>=20=20=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A>=20>=20=20=20=
=20=20=20=20=20=20=20=20=20maxItems:=201=0D=0A>=20>=20+=20=20=20=20=20=20=
=20=20'=23thermal-sensor-cells':=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=
=20const:=200=0D=0A>=20>=0D=0A>=20>=20-additionalProperties:=20false=0D=0A>=
=20>=20+=20=20-=20if:=0D=0A>=20>=20+=20=20=20=20=20=20properties:=0D=0A>=20=
>=20+=20=20=20=20=20=20=20=20compatible:=0D=0A>=20>=20+=20=20=20=20=20=20=
=20=20=20=20contains:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20con=
st:=20samsung,exynosautov920-tmu=0D=0A>=20>=20+=20=20=20=20then:=0D=0A>=20>=
=20+=20=20=20=20=20=20properties:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20clo=
cks:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20minItems:=201=0D=0A>=20>=
=20+=20=20=20=20=20=20=20=20=20=20maxItems:=201=0D=0A>=20>=20+=20=20=20=20=
=20=20=20=20reg:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20minItems:=201=
=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20maxItems:=201=0D=0A>=20>=20+=
=20=20=20=20=20=20=20=20'=23thermal-sensor-cells':=0D=0A>=20>=20+=20=20=20=
=20=20=20=20=20=20=20const:=201=0D=0A>=20>=20+=20=20=20=20=20=20=20=20samsu=
ng,hw-sensor-indices:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20descripti=
on:=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20List=20of=20thermal=
=20sensor=20indices=20physically=20monitored=20by=20this=0D=0A>=20TMU=20ins=
tance.=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20Indices=20not=20li=
sted=20correspond=20to=20registers=20that=20exist=20in=20the=0D=0A>=20SoC=
=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=20=20=20=20but=20are=20not=20connec=
ted=20to=20this=20TMU=20hardware=20block.=0D=0A>=20>=20+=20=20=20=20=20=20=
=20=20=20=20=24ref:=20/schemas/types.yaml=23/definitions/uint32-array=0D=0A=
>=20=0D=0A>=20I=20don't=20understand=20what=20is=20happening=20here=20with=
=20this=20binding.=20See=20writing=0D=0A>=20schema=20and=20example-schema.=
=0D=0A>=20=0D=0A>=20=0D=0A>=20=0D=0A>=20Best=20regards,=0D=0A>=20Krzysztof=
=0D=0A=0D=0AUnderstood.=20I'll=20rework=20the=20binding=20to=20follow=20the=
=20'writing=20schema'=20and=20'example-schema'=20guidance=0D=0Aand=20includ=
e=20these=20changes=20in=20v4.=0D=0A=0D=0AThanks.=0D=0ABest=20regards,=0D=
=0AShin=20Son=0D=0A=0D=0A

