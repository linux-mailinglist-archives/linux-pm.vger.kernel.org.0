Return-Path: <linux-pm+bounces-38461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9582C803C1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D4C1344896
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AA62FD69E;
	Mon, 24 Nov 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hzRl1sSZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF442FD1B6
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984484; cv=none; b=hEY3khPxqU1GdVELbb/+15kv20qExsr8ZReIvrIPNXnfjJlnRbgtzRXXV703o6ktvGc/kLJ4vRsiZjzWJr3vcV3hOo0lhHpLNtYcDOYJEb3ZxCnFOc14HmtHe1ocyh/v3hE2q7Qe2aI47FwLGXsTIoGisWvW+hm0Mxw8cqzBa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984484; c=relaxed/simple;
	bh=0XQjbE5d7jgXSgXWNI3PC9cZMugmfUhE/VINaRTJzlU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=law264HkID0pQvoEXYKPffprCVVVzWi+DWByWxeBnFFnCyG7pJCPhdx9JEpXOJ+MDfD+Ps/5seqjTXtq1uGzZScfmFePh4cPPLEq6w5yS8GKdUe9Vp3OMWu2fnEOSAFknSrDHeyufX1Vc4fndDsKWoOXYBtfjD7fmUzPBcg+Cl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hzRl1sSZ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251124114120epoutp023df2f85c389821671669694e4e625338~67on4MLz-1878018780epoutp027
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:41:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251124114120epoutp023df2f85c389821671669694e4e625338~67on4MLz-1878018780epoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763984480;
	bh=0XQjbE5d7jgXSgXWNI3PC9cZMugmfUhE/VINaRTJzlU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=hzRl1sSZRB4rfDpY6ssxumDAFm4tlTbDbYUh9cJyebMJpzjR/NYHunQb68jzub2qp
	 v0474kwRcU8OhIV6dxXaBk+U7TdS1KP3uO+Uc1xp5q33V7ubhgqOI1AS3cu6mgsmHY
	 06Pc9+WevTzt+bhWGJJnRweael/Bsfm3dH68w8Dw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20251124114119epcas2p2f39f75edc81388783afe6289980513c4~67onLQenN0092100921epcas2p2k;
	Mon, 24 Nov 2025 11:41:19 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.201]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dFP6R1YvRz2SSKb; Mon, 24 Nov
	2025 11:41:19 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20251124114118epcas2p33c2e69559c919dbba39c673cabbab22b~67omGMQJy0056200562epcas2p3O;
	Mon, 24 Nov 2025 11:41:18 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251124114118epsmtip2caa8be9701cc2704cd7d2990e6ce8bab~67ol_SLcu0905609056epsmtip2Q;
	Mon, 24 Nov 2025 11:41:18 +0000 (GMT)
From: =?utf-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>, "'Daniel Lezcano'"
	<daniel.lezcano@linaro.org>, "'Bartlomiej Zolnierkiewicz'"
	<bzolnier@gmail.com>, "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Rafael J
 . Wysocki'" <rafael@kernel.org>, "'Zhang Rui'" <rui.zhang@intel.com>,
	"'Lukasz	Luba'" <lukasz.luba@arm.com>, "'Rob Herring'" <robh@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>, "'Alim Akhtar'"
	<alim.akhtar@samsung.com>
Cc: "'Henrik Grimler'" <henrik@grimler.se>, <linux-pm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Peter	Griffin'" <peter.griffin@linaro.org>,
	=?utf-8?Q?'Andr=C3=A9_Draszik'?= <andre.draszik@linaro.org>, "'William
 McVicker'" <willmcvicker@google.com>, <jyescas@google.com>,
	<shin.son@samsung.com>
In-Reply-To: <12346382-7718-4942-a497-4de278b1d5a0@linaro.org>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Mon, 24 Nov 2025 20:41:16 +0900
Message-ID: <000b01dc5d37$3f6f5e80$be4e1b80$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KIBiaSaQQHdj7cKAU24glWzxHO7QA==
Content-Language: ko
X-CMS-MailID: 20251124114118epcas2p33c2e69559c919dbba39c673cabbab22b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237
References: <20251113064022.2701578-1-shin.son@samsung.com>
	<CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>
	<20251113064022.2701578-3-shin.son@samsung.com>
	<2180a854-8ba6-4424-add2-eb34637530c1@linaro.org>
	<000001dc5d2a$0697bf10$13c73d30$@samsung.com>
	<12346382-7718-4942-a497-4de278b1d5a0@linaro.org>

Hello, Tudor Ambarus.

> -----Original Message-----
> From: Tudor Ambarus =5Bmailto:tudor.ambarus=40linaro.org=5D
> Sent: Monday, November 24, 2025 7:43 PM
> To: =EC=86=90=EC=8B=A0=20<shin.son=40samsung.com>;=20'Daniel=20Lezcano'=
=0D=0A>=20<daniel.lezcano=40linaro.org>;=20'Bartlomiej=20Zolnierkiewicz'=0D=
=0A>=20<bzolnier=40gmail.com>;=20'Krzysztof=20Kozlowski'=20<krzk=40kernel.o=
rg>;=20'Rafael=20J=20.=0D=0A>=20Wysocki'=20<rafael=40kernel.org>;=20'Zhang=
=20Rui'=20<rui.zhang=40intel.com>;=20'Lukasz=0D=0A>=20Luba'=20<lukasz.luba=
=40arm.com>;=20'Rob=20Herring'=20<robh=40kernel.org>;=20'Conor=0D=0A>=20Doo=
ley'=20<conor+dt=40kernel.org>;=20'Alim=20Akhtar'=20<alim.akhtar=40samsung.=
com>=0D=0A>=20Cc:=20'Henrik=20Grimler'=20<henrik=40grimler.se>;=20linux-pm=
=40vger.kernel.org;=20linux-=0D=0A>=20samsung-soc=40vger.kernel.org;=20devi=
cetree=40vger.kernel.org;=20linux-arm-=0D=0A>=20kernel=40lists.infradead.or=
g;=20linux-kernel=40vger.kernel.org;=20Peter=20Griffin=0D=0A>=20<peter.grif=
fin=40linaro.org>;=20Andr=C3=A9=20Draszik=20<andre.draszik=40linaro.org>;=
=0D=0A>=20William=20McVicker=20<willmcvicker=40google.com>;=20jyescas=40goo=
gle.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=20v7=20RESEND=202/3=5D=20thermal=
:=20exynos_tmu:=20Support=20new=0D=0A>=20hardware=20and=20update=20TMU=20in=
terface=0D=0A>=20=0D=0A>=20Hi,=20Shin,=0D=0A>=20=0D=0A>=20On=2011/24/25=201=
2:06=20PM,=20=EC=86=90=EC=8B=A0=20wrote:=0D=0A>=20>>>=20+static=20void=20up=
date_con_reg(struct=20exynos_tmu_data=20*data)=20=7B=0D=0A>=20>>>=20+=09u32=
=20val,=20t_buf_vref_sel,=20t_buf_slope_sel;=0D=0A>=20>>>=20+=0D=0A>=20>>>=
=20+=09val=20=3D=20readl(data->base=20+=20EXYNOS_TMU_REG_TRIMINFO);=0D=0A>=
=20>>>=20+=09t_buf_vref_sel=20=3D=20(val=20>>=20EXYNOSAUTOV920_TMU_T_BUF_VR=
EF_SEL_SHIFT)=0D=0A>=20>>>=20+=09=09=09=09&=20EXYNOSAUTOV920_TMU_T_BUF_VREF=
_SEL_MASK;=0D=0A>=20>>>=20+=09t_buf_slope_sel=20=3D=20(val=20>>=20EXYNOSAUT=
OV920_TMU_T_BUF_SLOPE_SEL_SHIFT)=0D=0A>=20>>>=20+=09=09=09=09&=20EXYNOSAUTO=
V920_TMU_T_BUF_SLOPE_SEL_MASK;=0D=0A>=20>>>=20+=0D=0A>=20>>>=20+=09val=20=
=3D=20readl(data->base=20+=20=20EXYNOSAUTOV920_TMU_REG_CONTROL);=0D=0A>=20>=
>>=20+=09val=20&=3D=20=7E(EXYNOS_TMU_REF_VOLTAGE_MASK=20<<=0D=0A>=20>>=20EX=
YNOS_TMU_REF_VOLTAGE_SHIFT);=0D=0A>=20>>>=20+=09val=20=7C=3D=20(t_buf_vref_=
sel=20<<=20EXYNOS_TMU_REF_VOLTAGE_SHIFT);=0D=0A>=20>>>=20+=09val=20&=3D=20=
=7E(EXYNOS_TMU_BUF_SLOPE_SEL_MASK=20<<=0D=0A>=20>>=20EXYNOS_TMU_BUF_SLOPE_S=
EL_SHIFT);=0D=0A>=20>>>=20+=09val=20=7C=3D=20(t_buf_slope_sel=20<<=20EXYNOS=
_TMU_BUF_SLOPE_SEL_SHIFT);=0D=0A>=20>>>=20+=09writel(val,=20data->base=20+=
=20EXYNOSAUTOV920_TMU_REG_CONTROL);=0D=0A>=20>>>=20+=0D=0A>=20>>>=20+=09val=
=20=3D=20readl(data->base=20+=20EXYNOSAUTOV920_TMU_REG_CONTROL1);=0D=0A>=20=
>>>=20+=09val=20&=3D=20=7E(EXYNOSAUTOV920_TMU_NUM_PROBE_MASK=20<<=0D=0A>=20=
>>=20EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);=0D=0A>=20>>>=20+=09val=20&=3D=20=
=7E(EXYNOSAUTOV920_TMU_LPI_MODE_MASK=20<<=0D=0A>=20>>=20EXYNOSAUTOV920_TMU_=
LPI_MODE_SHIFT);=0D=0A>=20>>>=20+=09val=20=7C=3D=20(data->sensor_count=20<<=
=20EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);=0D=0A>=20>>>=20+=09writel(val,=20da=
ta->base=20+=20EXYNOSAUTOV920_TMU_REG_CONTROL1);=0D=0A>=20>>>=20+=0D=0A>=20=
>>>=20+=09writel(1,=20data->base=20+=20EXYNOSAUTOV920_TMU_SAMPLING_INTERVAL=
);=0D=0A>=20>>>=20+=09writel(EXYNOSAUTOV920_TMU_AVG_CON_UPDATE,=20data->bas=
e=20+=0D=0A>=20>>=20EXYNOSAUTOV920_TMU_REG_AVG_CONTROL);=0D=0A>=20>>>=20+=
=09writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE0_UPDATE,=0D=0A>=20>>>=20+=09=20=
=20=20=20=20=20=20data->base=20+=20EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0);=
=0D=0A>=20>>>=20+=09writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE1_UPDATE,=0D=0A>=
=20>>>=20+=09=20=20=20=20=20=20=20data->base=20+=20EXYNOSAUTOV920_TMU_REG_C=
OUNTER_VALUE1);=0D=0A>=20>>>=20+=7D=0D=0A>=20>>>=20+=0D=0A>=20>>=20This=20i=
s=20unreadable;=20please=20make=20it=20understandable=20for=20those=20who=
=20don=E2=80=99t=0D=0A>=20>>=20have=20the=20documentation=20(explicit=20sta=
tic=20inline=20functions,=20comments,=0D=0A>=20etc=20...).=0D=0A>=20>=20I'l=
l=20restructure=20this=20code=20by=20introducing=20explicit=20static=20inli=
ne=20helper=0D=0A>=20functions=20and=20proper=20comments=20to=20improve=20r=
eadability.=0D=0A>=20=0D=0A>=20We=20likely=20shouldn't=20use=20inlines=20he=
re,=20see=20Linus's=20reply=20from=202006:=0D=0A>=20https://lore.kernel.org=
/all/Pine.LNX.4.64.0601021105000.3668=40g5.osdl.org/T=0D=0A>=20/=23u=0D=0A>=
=20=0D=0A>=20I=20guess=20you=20can=20make=20this=20easier=20to=20read=20if=
=20you=20use=20FIELD_GET/SET=20from=0D=0A>=20bitfield.h.=20Other=20improvem=
ent=20would=20be=20using=20the=20regmap=20api.=0D=0A>=20=0D=0A>=20Shin,=20a=
=20bit=20unrelated=20with=20the=20patch,=20but=20I=20wanted=20to=20let=20yo=
u=20know=20that=20I=0D=0A>=20started=20looking=20at=20the=20GS101=20TMU.=20=
I=20assume=20it's=20very=20similar=20with=20the=20TMU=0D=0A>=20on=20exynosa=
utov920.=20Do=20you=20know=20if=20they=20share=20the=20same=20IP=20version?=
=0D=0A>=20=0D=0A>=20I=20noticed=20GS101=20uses=20ACPM=20calls=20to=20commun=
icate=20with=20the=20TMU.=20Why=20did=20you=0D=0A>=20choose=20to=20not=20us=
e=20ACPM=20for=20exynosautov920=20TMU?=0D=0A>=20=0D=0A>=20Thanks=21=0D=0A>=
=20ta=0D=0A=0D=0AI=20will=20adopt=20FIELD_GET/FIELD_PREP=20to=20simplify=20=
the=20bitfield=20handling,=20and=20I=20will=20avoid=20using=20inline=20func=
tions=20excessively=20as=20suggested.=0D=0A=0D=0ARegarding=20ACPM,=20I=20di=
d=20not=20introduce=20it=20earlier=20because=20I=20was=20trying=20to=20alig=
n=20the=20implementation=20with=20the=20existing=20framework.=0D=0AHowever,=
=20if=20we=20move=20toward=20a=20separate=20driver,=20I=20will=20reconsider=
=20whether=20ACPM=20integration=20makes=20sense=20there.=0D=0AWould=20it=20=
be=20possible=20to=20get=20your=20feedback=20again=20when=20I=20prepare=20t=
he=20next=20revision=20of=20the=20driver?=0D=0A=0D=0APlus,=20the=20GS101=20=
TMU=20driver=20isn't=20upstream=20yet,=20right?=0D=0ACould=20you=20share=20=
where=20I=20can=20find=20the=20example=20code=20you=20mentioned?=20Thank=20=
you=20in=20advance.=0D=0A=0D=0ABest=20regards,=0D=0AShin=0D=0A=0D=0A=0D=0A

