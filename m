Return-Path: <linux-pm+bounces-38763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E6C8CB84
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 04:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2203B0DCB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 03:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C43029E0F7;
	Thu, 27 Nov 2025 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="szQaPHnT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367429B20A
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764212833; cv=none; b=DvDT7v8p14HHoGXGL4lmQsG5iDt2q2ls1lo4Nl79ZDX70nRuYEhBRMzU7hc9U8mHWbhOk1I32ROTusg7k0/NSrAyqSF/MlgKrH7i0gVI3AAnrqsN5WswKE8dqhoGfjbAIqV75DkO5oHQTTmM3RNCrgRwmGndaoYYodQ7QtVBQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764212833; c=relaxed/simple;
	bh=Ck1CerdFYVnxIkxaGmohLWCJdCkoLh2LqJaVJC1hCd0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=PxqZXrpSVNAvsCxCDZB8L3187zYZ89H0KtumQvlSAYDq8Fw/vF5srCJGSHsL7QHBBWI6mg2rG7Bztfm1am59LFaTKsB/JO15Ep7kRBi0DQK3Q7QHOgv4ejoQ2C3mE0f2ENkXhkwTw9VuCaBLFOawO2XHXufGq4fSbqidsAlvsyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=szQaPHnT; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251127030708epoutp031ee2e62f8c7e472d8c5e8057fadfb52f~7vjh03V6g0944609446epoutp03E
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 03:07:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251127030708epoutp031ee2e62f8c7e472d8c5e8057fadfb52f~7vjh03V6g0944609446epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764212828;
	bh=Ck1CerdFYVnxIkxaGmohLWCJdCkoLh2LqJaVJC1hCd0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=szQaPHnTdlYi+P3W0IwzhRchGikHBjQNYVk5jp7b2qPkSlggC20iHFqYJSkR+c9Ci
	 D4nHDAOFY/p7P4JG9UL1zbavz+8of4YYo8wqWaG10AlegyJWMJyvR63eJug3ZV9Ptu
	 rkKjT30ZP4y5wwHhvRXq/T3T4JkO5nGfimPfq6u4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20251127030707epcas2p419868242dc4de70716ce8a5ecfb4bbbd~7vjhHJs8E1090210902epcas2p4C;
	Thu, 27 Nov 2025 03:07:07 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.211]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dH1Yl3Wq9z2SSKX; Thu, 27 Nov
	2025 03:07:07 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20251127030706epcas2p414b6e28d55d2eba4edcfdf6bdbe324d5~7vjgD8hnM0805008050epcas2p4t;
	Thu, 27 Nov 2025 03:07:06 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251127030706epsmtip12c4432f93687b7d7c8cbafcb0bd7b6b0~7vjf7GeVj1250512505epsmtip1-;
	Thu, 27 Nov 2025 03:07:06 +0000 (GMT)
From: =?utf-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>, "'Bartlomiej
 Zolnierkiewicz'" <bzolnier@gmail.com>, "'Krzysztof Kozlowski'"
	<krzk@kernel.org>, "'Rafael J . Wysocki'" <rafael@kernel.org>, "'Daniel
 Lezcano'" <daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>,
	"'Lukasz Luba'" <lukasz.luba@arm.com>, "'Rob	Herring'" <robh@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>, "'Alim	Akhtar'"
	<alim.akhtar@samsung.com>, <youngmin.nam@samsung.com>
Cc: "'Henrik Grimler'" <henrik@grimler.se>, <linux-pm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Peter	Griffin'" <peter.griffin@linaro.org>,
	=?utf-8?Q?'Andr=C3=A9_Draszik'?= <andre.draszik@linaro.org>, "'William
 McVicker'" <willmcvicker@google.com>, <jyescas@google.com>,
	<shin.son@samsung.com>
In-Reply-To: <401ed9b9-19a4-4a19-b397-0f353e9f0c97@linaro.org>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Thu, 27 Nov 2025 12:07:04 +0900
Message-ID: <019301dc5f4a$e9aadd60$bd009820$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KICEvKvogHXMeJ7AVgXt0WzxDIQ4A==
Content-Language: ko
X-CMS-MailID: 20251127030706epcas2p414b6e28d55d2eba4edcfdf6bdbe324d5
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
	<015501dc5ea5$0c7dd460$25797d20$@samsung.com>
	<401ed9b9-19a4-4a19-b397-0f353e9f0c97@linaro.org>

Hello, Tudor Ambarus

> -----Original Message-----
> From: Tudor Ambarus =5Bmailto:tudor.ambarus=40linaro.org=5D
> Sent: Wednesday, November 26, 2025 6:22 PM
> To: =EC=86=90=EC=8B=A0=20<shin.son=40samsung.com>;=20'Bartlomiej=20Zolnie=
rkiewicz'=0D=0A>=20<bzolnier=40gmail.com>;=20'Krzysztof=20Kozlowski'=20<krz=
k=40kernel.org>;=20'Rafael=20J=20.=0D=0A>=20Wysocki'=20<rafael=40kernel.org=
>;=20'Daniel=20Lezcano'=20<daniel.lezcano=40linaro.org>;=0D=0A>=20'Zhang=20=
Rui'=20<rui.zhang=40intel.com>;=20'Lukasz=20Luba'=20<lukasz.luba=40arm.com>=
;=0D=0A>=20'Rob=20Herring'=20<robh=40kernel.org>;=20'Conor=20Dooley'=20<con=
or+dt=40kernel.org>;=0D=0A>=20'Alim=20Akhtar'=20<alim.akhtar=40samsung.com>=
;=20youngmin.nam=40samsung.com=0D=0A>=20Cc:=20'Henrik=20Grimler'=20<henrik=
=40grimler.se>;=20linux-pm=40vger.kernel.org;=20linux-=0D=0A>=20samsung-soc=
=40vger.kernel.org;=20devicetree=40vger.kernel.org;=20linux-arm-=0D=0A>=20k=
ernel=40lists.infradead.org;=20linux-kernel=40vger.kernel.org;=20'Peter=20G=
riffin'=0D=0A>=20<peter.griffin=40linaro.org>;=20'Andr=C3=A9=20Draszik'=20<=
andre.draszik=40linaro.org>;=0D=0A>=20'William=20McVicker'=20<willmcvicker=
=40google.com>;=20jyescas=40google.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=
=20v7=20RESEND=202/3=5D=20thermal:=20exynos_tmu:=20Support=20new=0D=0A>=20h=
ardware=20and=20update=20TMU=20interface=0D=0A>=20=0D=0A>=20Hi,=20Shin=20So=
n,=0D=0A>=20=0D=0A>=20On=2011/26/25=209:19=20AM,=20=EC=86=90=EC=8B=A0=20wro=
te:=0D=0A>=20>>=20Looking=20at=20the=20exynosautov9=20registers=20that=20yo=
u=20described=20and=0D=0A>=20>>=20comparing=20them=20with=0D=0A>=20>>=20gs1=
01=20I=20see=20just=202=20differences:=0D=0A>=20>>=201/=20exnosautov2=20has=
=20a=20TRIMINFO_CONFIG2=20register,=20while=20gs101=20doesn't=0D=0A>=20>>=
=202/=20EXYNOSAUTOV920_PEND=20register=20fields=20differ=20from=20GS101=0D=
=0A>=20>=20TRIMINFO_CONFIG2=20doesn't=20exist=20on=20eav920=20either;=20I=
=20simply=20misnamed=20it.=0D=0A>=20>=20However,=20the=20PEND=20register=20=
indeed=20differs=20from=20GS101.=0D=0A>=20>=0D=0A>=20>>=20Given=20the=20sim=
ilarities,=20and=20considering=20the=20EXYNOS9_=20registers=20rename=0D=0A>=
=20from:=0D=0A>=20>>=20https://lore.kernel.org/linux-samsung-soc/2025111707=
4140.4090939-5-=0D=0A>=20>>=20youngmin.nam=40samsung.com/=0D=0A>=20>>=20wou=
ld=20it=20make=20sense=20to=20use=20the=20SoC-era=20name=20instead=20of=20s=
pecific=20SoC,=0D=0A>=20i.e.=0D=0A>=20>>=20s/EXYNOSAUTOV920_/EXYNOS9_=20and=
=20use=20the=20latter=20for=20both=20exynosautov9=0D=0A>=20>>=20and=20gs101=
?=0D=0A>=20>>=0D=0A>=20>=20First=20of=20all,=20as=20far=20as=20I=20know,=20=
EXYNOS9=20is=20not=20the=20same=20as=20exynosautov9,=0D=0A>=20and=20exynosa=
utov920=20also=20differs=20from=20exynosautov9.=0D=0A>=20=0D=0A>=20See=20al=
so=20see=20this=20patch,=20or=20maybe=20the=20entire=20patch=20set:=0D=0A>=
=20https://lore.kernel.org/linux-samsung-soc/20251117074140.4090939-2-=0D=
=0A>=20youngmin.nam=40samsung.com/=0D=0A>=20=0D=0A>=20It's=20not=20just=20a=
utov9=20and=20gs101=20that=20have=20similar=20TMU=20registers=20(with=20the=
=0D=0A>=20two=20exceptions=20AFAICT),=20it's=20also=20exynos850=20that=20se=
ems=20identical=20with=0D=0A>=20autov9.=0D=0A=0D=0AYes,=20Do=20you=20have=
=20any=20plans=20to=20upstream=20the=20GS101=20TMU=20code?=20From=20what=20=
I=20understand,=0D=0AAutov9=20and=20exynos850=20are=20unlikely=20to=20be=20=
upstreamed=20in=20their=20current=20form.=0D=0A=0D=0A>=20All=20seem=20to=20=
be=20part=20of=20the=20same=20=22Exynos9-era=22=20SoCs.=20Let's=20think=20a=
bout=20how=0D=0A>=20gs101/exynos850=20TMU=20addition=20will=20follow.=20Sha=
ll=20one=20use=20the=20EXYNOSAUTOV920=0D=0A>=20registers?=20That=20seems=20=
misleading.=20Shall=20one=20redefine=20the=20entire=20register=0D=0A>=20set=
?=0D=0A>=20That=20won't=20fly=20because=20of=20the=20code=20duplication.=0D=
=0A=0D=0AI=20kind=20of=20admit=20that.=0D=0A=0D=0A>=20Thus=20I=20propose=20=
to=20use=20the=20EXYNOS9=20prefix=20for=20the=20register=20definitions,=20a=
nd=0D=0A>=20if=20there=20are=20SoCs=20with=20slight=20differences,=20that=
=20can=20be=20handled=20with=0D=0A>=20compatible=20match=20data=20and=20spe=
cific=20SoC=20definitions,=20but=20only=20where=20things=0D=0A>=20differ.=
=0D=0A=0D=0AHowever,=20I=20am=20not=20sure=20whether=20Exynos2200,=207885,=
=20990,=209810,=208890,=208895,=20or=20FSD=20share=20the=20same=20TMU=20har=
dware=20layout=20as=20exynosautov920.=0D=0ASo=20I=E2=80=99m=20wondering=20w=
hether=20the=20EXYNOS9=20prefix=20should=20be=20limited=20to=20GS101=20and=
=20eav920,=20or=20if=20we=20should=20consider=20a=20different=20prefix=20th=
at=20better=20reflects=20the=20grouping.=0D=0A=0D=0A>=20>=20So=20while=20sh=
aring=20a=20common=20prefix=20is=20a=20good=20suggestion=20in=20general,=20=
I=0D=0A>=20>=20believe=20it's=20not=20appropriate=20here=20Because=20the=20=
register=20definitions=20are=0D=0A>=20not=20fully=20compatible=20across=20t=
hese=20SoCs.=20Using=20a=20common=20name=20array=20may=0D=0A>=20introduce=
=20confusion=20later.=0D=0A>=20=0D=0A>=20Please=20reconsider=20this.=20Mayb=
e=20Youngmin=20Nam=20or=20others=20can=20intervene.=0D=0A=0D=0AOk,=20I'll=
=20reconsider=20this=20based=20on=20your=20clarification.=20Thank=20you=20f=
or=20the=20detailed=20feedback.=0D=0A=0D=0A>=20=0D=0A>=20Thanks=21=0D=0A>=
=20ta=0D=0A=0D=0ABest=20regards,=0D=0AShin=0D=0A=0D=0A

