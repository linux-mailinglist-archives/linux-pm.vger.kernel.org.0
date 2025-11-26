Return-Path: <linux-pm+bounces-38678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8915C88658
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 08:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A72D4E2C41
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838AF28FFF6;
	Wed, 26 Nov 2025 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D0at0VgC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74128DB71
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141603; cv=none; b=IQbrOqy+tW/Xk0Y2RTbjF9Fslp1v/yJFw8MiZPEr+TeM+L63eZ+vs7L7JwBEVGsM3LtFwnYG8U2+7lXbxGVWbObL8Aw7Kasz0UPKvspZY9aCWQqJdeomF1PAEPhGlaXpFL4mTdW8ep0nfgFKzD1BBGMETHI+QHtkA0uvr6PoKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141603; c=relaxed/simple;
	bh=4bi4KMO68dH7w3d/t0Hvvq45GQEDJf0mVLD1A3u8r5g=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=E/sEdsZcyfoqDT/7wXLRYwoH37C8MVkwzhWP3+ujM5l7s6N2OgAXgL42XSSDaIQZe9QP9Fs4wdkD+7fgn7OSTQk2eGXBXEHCbhrX8wzdwesaMBW0eWvSgRjBh7ogmrBY7dMJDXqc2uyjt1eq8Tvx5vyYsGJCe64CKVo9Uq7Jeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=D0at0VgC; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251126071951epoutp0402b6ed975b9e613e187831b843f6c807~7fW5EK1dj1873818738epoutp04h
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 07:19:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251126071951epoutp0402b6ed975b9e613e187831b843f6c807~7fW5EK1dj1873818738epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764141591;
	bh=4bi4KMO68dH7w3d/t0Hvvq45GQEDJf0mVLD1A3u8r5g=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=D0at0VgC2S+Pr03Buy6twkwnbZIjrhDau0zMQg3g/vNZXAf4iC0e/s02mXQJhzDWo
	 fAOrrkoqqyl9x3816OEdufS2ItUH39yZSFBLfIEoCj5cJHGizg3/nV41e7lIKoo9Ed
	 yK06TqtECVjibQDWLZ373DmrCOsTQ+/XM/idLBYA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20251126071950epcas2p3aea5d8a8fa1582663f9d654ce24306ca~7fW4TZHTO0460304603epcas2p3U;
	Wed, 26 Nov 2025 07:19:50 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.202]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dGWCp1pmzz6B9m7; Wed, 26 Nov
	2025 07:19:50 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20251126071948epcas2p1197f2f373a91b4383a36f76b012ecd79~7fW2dwifR3238332383epcas2p1Q;
	Wed, 26 Nov 2025 07:19:48 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251126071948epsmtip2395dc6efec8527355f47688f10b3105b~7fW2Vv2yR1128611286epsmtip2D;
	Wed, 26 Nov 2025 07:19:48 +0000 (GMT)
From: =?utf-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>, "'Bartlomiej
 Zolnierkiewicz'" <bzolnier@gmail.com>, "'Krzysztof Kozlowski'"
	<krzk@kernel.org>, "'Rafael J . Wysocki'" <rafael@kernel.org>, "'Daniel
 Lezcano'" <daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>,
	"'Lukasz Luba'" <lukasz.luba@arm.com>, "'Rob	Herring'" <robh@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>, "'Alim Akhtar'"
	<alim.akhtar@samsung.com>
Cc: "'Henrik Grimler'" <henrik@grimler.se>, <linux-pm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Peter	Griffin'" <peter.griffin@linaro.org>,
	=?utf-8?Q?'Andr=C3=A9_Draszik'?= <andre.draszik@linaro.org>, "'William
 McVicker'" <willmcvicker@google.com>, <jyescas@google.com>,
	<shin.son@samsung.com>
In-Reply-To: <5a6a749b-b2b7-41bb-bcb4-a2342e7f4e98@linaro.org>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Wed, 26 Nov 2025 16:19:47 +0900
Message-ID: <015501dc5ea5$0c7dd460$25797d20$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KICEvKvorPcLIjw
Content-Language: ko
X-CMS-MailID: 20251126071948epcas2p1197f2f373a91b4383a36f76b012ecd79
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
	<5a6a749b-b2b7-41bb-bcb4-a2342e7f4e98@linaro.org>

Hello Tudor Ambarus

> -----Original Message-----
> From: Tudor Ambarus =5Bmailto:tudor.ambarus=40linaro.org=5D
> Sent: Tuesday, November 25, 2025 6:15 PM
> To: Shin Son <shin.son=40samsung.com>; Bartlomiej Zolnierkiewicz
> <bzolnier=40gmail.com>; Krzysztof Kozlowski <krzk=40kernel.org>; Rafael J=
 .
> Wysocki <rafael=40kernel.org>; Daniel Lezcano <daniel.lezcano=40linaro.or=
g>;
> Zhang Rui <rui.zhang=40intel.com>; Lukasz Luba <lukasz.luba=40arm.com>; R=
ob
> Herring <robh=40kernel.org>; Conor Dooley <conor+dt=40kernel.org>; Alim A=
khtar
> <alim.akhtar=40samsung.com>
> Cc: Henrik Grimler <henrik=40grimler.se>; linux-pm=40vger.kernel.org; lin=
ux-
> samsung-soc=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org; Peter Griff=
in
> <peter.griffin=40linaro.org>; Andr=C3=A9=20Draszik=20<andre.draszik=40lin=
aro.org>;=0D=0A>=20William=20McVicker=20<willmcvicker=40google.com>;=20jyes=
cas=40google.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=20v7=20RESEND=202/3=5D=
=20thermal:=20exynos_tmu:=20Support=20new=0D=0A>=20hardware=20and=20update=
=20TMU=20interface=0D=0A>=20=0D=0A>=20Hi,=20Shin=20Son,=0D=0A>=20=0D=0A>=20=
Just=20trivial=20notes=20on=20registers=20description=20for=20now.=0D=0A>=
=20=0D=0A>=20On=2011/13/25=208:40=20AM,=20Shin=20Son=20wrote:=0D=0A>=20>=20=
diff=20--git=20a/drivers/thermal/samsung/exynos_tmu.c=20b/drivers/=20therma=
l/=0D=0A>=20>=20samsung/exynos_tmu.c=20index=2047a99b3c5395..8fa188928b79=
=0D=0A>=20>=20100644=20---=20a/=20drivers/thermal/samsung/exynos_tmu.c=20++=
+=20b/drivers/=0D=0A>=20>=20thermal/samsung/=20exynos_tmu.c=20=40=40=20-121=
,8=20+121,51=20=40=40=0D=0A>=20>=0D=0A>=20>=20=23define=20EXYNOS_NOISE_CANC=
EL_MODE=09=094=0D=0A>=20>=0D=0A>=20>=20+/*=20ExynosAutov920=20specific=20re=
gisters=20*/=20+=23define=0D=0A>=20>=20EXYNOSAUTOV920_SLOPE_COMP=09=0925=20=
+=23define=0D=0A>=20>=20EXYNOSAUTOV920_SLOPE_COMP_MASK=09=090xf=0D=0A>=20=
=0D=0A>=20Register=20fields=20shall=20be=20named=0D=0A>=20SOC_REG_NAME_FIEL=
D_NAME=0D=0A>=20=0D=0A>=20If=20you=20include=20<linux/bits.h>=20you=20can=
=20substitute=20the=20above=202=20definitions=0D=0A>=20with=20just=20one:=
=0D=0A>=20EXYNOSAUTOV920_TRIMINFO_SLOPE_COMP=09GENMASK(28,=2025)=0D=0A>=20=
=0D=0A>=20and=20later=20on=20in=20the=20code,=20instead=20of=20doing=20the=
=20shift=20and=20the=20mask,=20you=20can=0D=0A>=20include=20<linux/bitfield=
.h>=20and=20do:=0D=0A>=20=0D=0A>=20data->slope_comp=20=3D=20FIELD_GET(EXYNO=
SAUTOV920_TRIMINFO_SLOPE_COMP,=20val);=0D=0A>=20=0D=0A>=20btw,=20above=20ma=
tches=20the=20GS101=20definitions.=0D=0A=0D=0AI=20understand=20your=20point=
=20and=20will=20apply=20there=20bit=20operations=20in=20the=20new=20patch=
=20series.=0D=0A=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_CALIB_SEL_TEMP=09=
=0930=20+=23define=0D=0A>=20>=20EXYNOSAUTOV920_CALIB_SEL_TEMP_MASK=090x2=20=
+=0D=0A>=20=0D=0A>=20is=20this=20BIT(31)?=0D=0A>=20EXYNOSAUTOV920_TRIMINFO2=
_CALIB_SEL_TEMP=09=09BIT(31)=0D=0A>=20=0D=0A=0D=0AThis=20field=20actually=
=20uses=20both=20bit=2030=20and=20bit=2031,=20so=20the=20mask=20should=20be=
=20updated=20from=200x2=20to=200x3.=20Sorry=20for=20the=20confusion.=0D=0A=
=0D=0A>=20GS101=20differs,=20it=20has=20this=20field=20defined=20at:=0D=0A>=
=20GS101_TRIMINFO_CALIB_SEL_TEMP=09=09=09BIT(0)=0D=0A>=20where=20TRIMINFO=
=20is=20at=20Base=20Address=20+=200x0,=20not=20at=20Base=20Address=20+=200x=
4=20as=20in=0D=0A>=20your=20case.=0D=0A=0D=0AAt=20base=20address=20+=200x4,=
=20the=20register=20actually=20contains=20CALIB_TEMP,=20not=20CALIB_SEL=20i=
n=20my=20case.=0D=0ASo=20the=20naming=20was=20incorrect,=20and=20I'll=20fix=
=20it=20in=20the=20next=20patch=20series.=0D=0A=0D=0A>=20>=20+=23define=20E=
XYNOSAUTOV920_SENSOR0_TRIM_INFO=090x10=0D=0A>=20=0D=0A>=20GS101=20does=20no=
t=20have=20any=20SENSOR0=20in=20the=20reg=20name,=20so=20maybe=20rename=20i=
t=20to:=0D=0A>=20=23define=20EXYNOSAUTOV920_TRIMINFO0=09=090x10=0D=0A=0D=0A=
That's=20correct.=20I'll=20rename=20it=20in=20the=20next=20patch=20series.=
=0D=0A=20=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_TRIM_MASK=09=090x1ff=20+=
=23define=0D=0A>=20>=20EXYNOSAUTOV920_TRIMINFO_25_SHIFT=090=20+=23define=0D=
=0A>=20>=20EXYNOSAUTOV920_TRIMINFO_85_SHIFT=099=0D=0A>=20=0D=0A>=20=23defin=
e=20EXYNOSAUTOV920_TRIMINFO_85_P0=09=09GENMASK(17,=209)=0D=0A>=20=23define=
=20EXYNOSAUTOV920_TRIMINFO_25_P0=09=09GENMASK(8,=200)=0D=0A=0D=0AUnderstood=
.=20Thanks.=0D=0A=0D=0A>=20>=20+=20+=23define=20EXYNOSAUTOV920_TMU_REG_TRIM=
INFO2=090x04=0D=0A>=20=0D=0A>=20Is=20this=20a=20TRIMINFO_CONFIG2=20register=
?=20I=20don't=20have=20such=20thing=20on=20GS101.=0D=0A=0D=0ANo,=20that=20n=
ame=20is=20incorrect.=20I'll=20rename=20it=20to=20TRIMINFO_CONFIG1.=0D=0A=
=0D=0A>=20>=20+=20+=23define=20EXYNOSAUTOV920_TMU_REG_THRESHOLD(p)=09(((p))=
=20*=200x50=20+=0D=0A>=20>=200x00d0)=0D=0A>=20=0D=0A>=20=23define=20EXYNOSA=
UTOV920_THRESHOLD_TEMP_RISE7_6(p)=09(((p))=20*=200x50=20+=200xd0)=0D=0A>=20=
and=20then:=0D=0A>=20=23define=20EXYNOSAUTOV920_THRESHOLD_TEMP_RISE7_6_RISE=
7=20=09GENMASK(24,=2016)=0D=0A>=20=23define=20EXYNOSAUTOV920_THRESHOLD_TEMP=
_RISE7_6_RISE6=20=09GENMASK(8,=200)=0D=0A>=20you'll=20stop=20passing=20the=
=20shift=20and=20mask=20as=20function=20arguments=20:)=0D=0A=0D=0AGot=20it.=
=20Thanks=20:).=0D=0A=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_TMU_REG_INTE=
N(p)=09=09(((p))=20*=200x50=20+=0D=0A>=200x00f0)=0D=0A>=20=0D=0A>=20=23defi=
ne=20EXYNOSAUTOV920_INTEN(p)=09=09=09=09(((p))=20*=200x50=20+=200xf0)=0D=0A=
>=20=0D=0A>=20I=20see=20you=20use=20just=20BIT(7)=20from=20this=20register.=
=20Let's=20define=20it=20and=20stop=0D=0A>=20passing=20the=20bit=20offset=
=20as=20function=20argument:=0D=0A>=20=23define=20EXYNOSAUTOV920_INTEN_RISE=
7=09=09=09BIT(7)=0D=0A=0D=0AOk,=20Thanks.=20I'll=20define=20the=20BIT(7)=20=
field=20as=20suggested.=0D=0A=0D=0A=20=0D=0A>=20>=20+=23define=20EXYNOSAUTO=
V920_TMU_REG_INT_PEND(p)=09(((p))=20*=200x50=20+=200x00f8)=0D=0A>=20=0D=0A>=
=20=23define=20EXYNOSAUTOV920_PEND(p)=09=09=09=09(((p))=20*=200x50=20+=200x=
f8)=0D=0A=0D=0AUnderstood.=0D=0A=0D=0A>=20Are=20you=20using=20GENMASK(15,=
=200)=20for=20this=20register?=0D=0A>=20=0D=0A>=20On=20GS101=20GENMASK(15,=
=209)=20is=20reserved.=20Here's=20how=20the=20bits=20are=20defined=20for=0D=
=0A>=20GS101:=0D=0A>=20=0D=0A>=20=23define=20EXYNOSAUTOV920_PEND_FALL(i)=09=
=09=09BIT(16=20+=20(i))=0D=0A>=20=23define=20EXYNOSAUTOV920_PEND_RISE_MASK=
=09=09=09GENMASK(23,=2016)=0D=0A>=20=23define=20EXYNOSAUTOV920_PEND_RISE(i)=
=09=09=09BIT(i)=0D=0A>=20=23define=20EXYNOSAUTOV920_PEND_RISE_MASK=09=09=09=
GENMASK(8,=200)=0D=0A>=20=0D=0A>=20Would=20you=20please=20verify=20and=20le=
t=20me=20know=20if=20EXYNOSAUTOV920=20differs=20or=20not?=0D=0A=0D=0AIt=20d=
iffers,=20On=20Exynosautov920m=20bits=208=20-=2015=20are=20reserved,=20so=
=20only=20bits=200-7=20are=20used.=20=0D=0A=0D=0A>=20>=20+=23define=20EXYNO=
SAUTOV920_CURRENT_TEMP_P1_P0=090x084=0D=0A>=20=0D=0A>=20no=20leading=200=0D=
=0A>=20=23define=20EXYNOSAUTOV920_CURRENT_TEMP_P1_P0=09=090x84=0D=0A=0D=0AG=
ot=20it.=0D=0A=0D=0A>=20then=20define=20the=20fields:=0D=0A>=20=23define=20=
EXYNOSAUTOV920_CURRENT_TEMP_P1=09=09=09GENMASK(24,=2016)=0D=0A>=20=23define=
=20EXYNOSAUTOV920_CURRENT_TEMP_P0=09=09=09GENMASK(8,=200)=0D=0A=0D=0AThank=
=20you.=0D=0A=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_TMU_REG_EMUL_CON=09=
=090x0b0=0D=0A>=20=0D=0A>=20no=20TMU_REG=20in=20the=20name,=20no=20leading=
=200,=20define=20the=20fields=20as=20GENMASK=0D=0A>=20=23define=20EXYNOSAUT=
OV920_EMUL_CON=09=09=09=090xb0=0D=0A>=20=23define=20EXYNOSAUTOV920_EMUL_CON=
_EMUL_NEXT_TIME=09=09GENMASK(31,=2016)=0D=0A>=20=23define=20EXYNOSAUTOV920_=
EMUL_CON_EMUL_NEXT_DATA=09=09GENMASK(15,=207)=0D=0A>=20=23define=20EXYNOSAU=
TOV920_EMUL_CON_EMUL_EN=09=09=09BIT(0)=0D=0A=0D=0AThat's=20right.=20Thanks.=
=0D=0A=0D=0A>=20>=20+=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_TMU_REG_CONT=
ROL=09=090x50=0D=0A>=20=0D=0A>=20no=20reg=20in=20the=20name,=20control0=0D=
=0A>=20=23define=20EXYNOSAUTOV920_TMU_CONTROL0=09=09=090x50=0D=0A>=20=0D=0A=
>=20define=20fields=20as=20GENMASK=20and=20BIT=0D=0A=0D=0AGot=20it.=20=0D=
=0A=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_TMU_REG_CONTROL1=09=090x54=0D=
=0A>=20=0D=0A>=20ditto=0D=0A=0D=0AGot=20it.=0D=0A=0D=0A=0D=0A>=20>=20+=23de=
fine=20EXYNOSAUTOV920_TMU_REG_AVG_CONTROL=090x58=0D=0A>=20=0D=0A>=20ditto=
=0D=0A=0D=0AGot=20it.=0D=0A=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_TMU_SA=
MPLING_INTERVAL=090x70=0D=0A>=20=0D=0A>=20no=20TMU=20in=20the=20name,=20res=
pect=20the=20registers=20name=20from=20the=20datasheet=20please.=0D=0A>=20d=
efine=20the=20full=20genmask=0D=0A>=20=23define=20EXYNOSAUTOV920_SAMPLING_I=
NTERVAL_MASK=09=09GENMASK(31,=200)=0D=0A=0D=0AOk,=20I'll=20follow=20the=20d=
atasheet=20naming=20update=20it=20accordingly.=0D=0A=0D=0A>=20>=20+=23defin=
e=20EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0=090x74=0D=0A>=20>=20+=23define=20=
EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE1=090x78=0D=0A>=20=0D=0A>=20no=20TMU_RE=
G=20in=20the=20name,=20define=20fields=0D=0A=0D=0AGot=20it.=0D=0A=0D=0A>=20=
>=20+=23define=20EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_SHIFT=09=098=0D=0A>=20>=
=20+=23define=20EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_MASK=09=090x1f=0D=0A>=20>=
=20+=23define=20EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_SHIFT=093=0D=0A>=20>=20+=
=23define=20EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_MASK=09=090xf=0D=0A>=20>=20+=
=23define=20EXYNOSAUTOV920_TMU_NUM_PROBE_MASK=09=090xf=0D=0A>=20>=20+=23def=
ine=20EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT=09=0916=0D=0A>=20>=20+=23define=20=
EXYNOSAUTOV920_TMU_LPI_MODE_MASK=09=091=0D=0A>=20>=20+=23define=20EXYNOSAUT=
OV920_TMU_LPI_MODE_SHIFT=09=0910=0D=0A>=20=0D=0A>=20you=20won't=20need=20th=
ese=20if=20you=20define=20the=20register=20fields,=20isn't=20it?=0D=0A=0D=
=0AGot=20it.=20I'll=20refactor=20this=20part=20accordingly.=0D=0A=0D=0A>=20=
>=20+=23define=20EXYNOSAUTOV920_TMU_AVG_CON_UPDATE=09=090x0008011a=0D=0A>=
=20=0D=0A>=20no=20leading=20zeros.=20You=20better=20construct=20the=20field=
s=20dynamically,=20by=20using=0D=0A>=20bitfields,=20no=20full=20register=20=
magic=20number,=20humans=20don't=20understand=20this.=0D=0A=0D=0AUnderstood=
.=20I'll=20replace=20the=20magic=20number=20with=20proper=20bit=20field=20c=
onstructions.=0D=0A=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_TMU_COUNTER_VA=
LUE0_UPDATE=090x030003c0=0D=0A>=20>=20+=23define=20EXYNOSAUTOV920_TMU_COUNT=
ER_VALUE1_UPDATE=090x03c0004d=0D=0A>=20=0D=0A>=20same=20for=20both=0D=0A=0D=
=0AGot=20it.=0D=0A=0D=0A>=20>=20+=0D=0A>=20>=20=20=23define=20MCELSIUS=0910=
00=0D=0A>=20>=0D=0A>=20>=20+=23define=20EXYNOS_DEFAULT_SENSOR_COUNT=09=09=
=091=0D=0A>=20>=20+=23define=20EXYNOS_MAX_SENSOR_COUNT=0D=0A>=20would=20it=
=20make=20sense=20to=20have=20the=20tzd_array=20to=20fit=20just=20the=20sen=
sor=20count=0D=0A>=20that=20we're=20using=20so=20that=20we=20don't=20waste=
=20memory?=20i.e.=20allocate=20tzd_array=0D=0A>=20dynamically.=0D=0A=0D=0AO=
k,=20I=20may=20need=20to=20prepare=20a=20separate=20patch=20for=20the=20the=
rmal=20driver=20on=20eav920=20and=20allocate=20the=20tzd_array=20dynamicall=
y=20there.=0D=0A=0D=0A>=20Looking=20at=20the=20exynosautov9=20registers=20t=
hat=20you=20described=20and=20comparing=0D=0A>=20them=20with=0D=0A>=20gs101=
=20I=20see=20just=202=20differences:=0D=0A>=201/=20exnosautov2=20has=20a=20=
TRIMINFO_CONFIG2=20register,=20while=20gs101=20doesn't=202/=0D=0A>=20EXYNOS=
AUTOV920_PEND=20register=20fields=20differ=20from=20GS101=0D=0A=0D=0ATRIMIN=
FO_CONFIG2=20doesn't=20exist=20on=20eav920=20either;=20I=20simply=20misname=
d=20it.=0D=0AHowever,=20the=20PEND=20register=20indeed=20differs=20from=20G=
S101.=0D=0A=0D=0A>=20Given=20the=20similarities,=20and=20considering=20the=
=20EXYNOS9_=20registers=20rename=20from:=0D=0A>=20https://lore.kernel.org/l=
inux-samsung-soc/20251117074140.4090939-5-=0D=0A>=20youngmin.nam=40samsung.=
com/=0D=0A>=20would=20it=20make=20sense=20to=20use=20the=20SoC-era=20name=
=20instead=20of=20specific=20SoC,=20i.e.=0D=0A>=20s/EXYNOSAUTOV920_/EXYNOS9=
_=20and=20use=20the=20latter=20for=20both=20exynosautov9=20and=0D=0A>=20gs1=
01?=0D=0A>=20=0D=0A>=20Cheers,=0D=0A>=20ta=0D=0A=0D=0AFirst=20of=20all,=20a=
s=20far=20as=20I=20know,=20EXYNOS9=20is=20not=20the=20same=20as=20exynosaut=
ov9,=20and=20exynosautov920=20also=20differs=20from=20exynosautov9.=0D=0ASo=
=20while=20sharing=20a=20common=20prefix=20is=20a=20good=20suggestion=20in=
=20general,=20I=20believe=20it's=20not=20appropriate=20here=0D=0ABecause=20=
the=20register=20definitions=20are=20not=20fully=20compatible=20across=20th=
ese=20SoCs.=20Using=20a=20common=20name=20array=20may=20introduce=20confusi=
on=20later.=0D=0A=0D=0AI'll=20prepare=20a=20new=20patch=20series=20accordin=
gly=20and=20make=20sure=20to=20CC=20you.=0D=0A=0D=0ABest=20regards,=0D=0ASh=
in=0D=0A=0D=0A=0D=0A=0D=0A

