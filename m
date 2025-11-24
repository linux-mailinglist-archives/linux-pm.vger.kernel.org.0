Return-Path: <linux-pm+bounces-38462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF0C803DF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BABC344902
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9542FDC26;
	Mon, 24 Nov 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HpJilch6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720982F83A3
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984584; cv=none; b=HLKWVNZdR/o7T/LlUfDMlaATkmwvIHsmZTyhz72z4Fn41Xrsi26yKK5ETMPzRLCUljLn/JsQYe+0bx+mhTG1k3MZZrbgdiYh+BSINQRS5v+bp5ApYpSKdR/dGPWOhI53+USvoDS3QmUMbRydl87WYwSCss60eS8svZ8ZFtty+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984584; c=relaxed/simple;
	bh=0UfPZnz9PDbhxDHBtLEyEa8gvhJLlctrIXKAOZGOWN4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=MYAdT7srZPndG270rRmcZL3PeQcpBCWrmnQdgN3L9LuWQgaAfIoCDNQBMww51vAcfNEhRz8yad4xUnSxyKzYmQkcWiSlkUaa5akRhF6QliLmnXVe1l+gJYqr2oIrlq0YVftkMO9+2tLirUl8WGykNxcu2gZJ3PjrFFIcbdfhY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HpJilch6; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251124114300epoutp03e13f8fdba422412e34a0363abf9334f5~67qFSQrLs0076700767epoutp03M
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251124114300epoutp03e13f8fdba422412e34a0363abf9334f5~67qFSQrLs0076700767epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763984580;
	bh=0UfPZnz9PDbhxDHBtLEyEa8gvhJLlctrIXKAOZGOWN4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HpJilch6TDX0BNZAKmAtksPr/pTIRtbn+k1MZzmRCfb/qNdQrIyStCoaDvrMl23J2
	 KnI0A8Hd6aGlB0SRPr5Fp8wgDhtNqlYNCymCj0DJu2tOsGknbwheu6JuV7Kqn2gE4G
	 su4enLOhBF8ngnvlypPptrDdRykNFvbrH94+UmzI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20251124114259epcas2p48a7d588390bbbab0b08ee6749024b466~67qEhbMgv1875518755epcas2p43;
	Mon, 24 Nov 2025 11:42:59 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.200]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dFP8M3DR6z2SSKX; Mon, 24 Nov
	2025 11:42:59 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20251124114258epcas2p103cab1d3b8b5414e7437a08126e36d8b~67qDVN1Ew1969819698epcas2p1T;
	Mon, 24 Nov 2025 11:42:58 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251124114258epsmtip22c7b65a35428b6c08ca8cac404c177c9~67qDPPttI1360513605epsmtip24;
	Mon, 24 Nov 2025 11:42:58 +0000 (GMT)
From: =?utf-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Daniel Lezcano'" <daniel.lezcano@linaro.org>, "'Bartlomiej
 Zolnierkiewicz'" <bzolnier@gmail.com>, "'Krzysztof Kozlowski'"
	<krzk@kernel.org>, "'Rafael J . Wysocki'" <rafael@kernel.org>, "'Zhang Rui'"
	<rui.zhang@intel.com>, "'Lukasz	Luba'" <lukasz.luba@arm.com>, "'Rob
	Herring'" <robh@kernel.org>, "'Conor Dooley'" <conor+dt@kernel.org>, "'Alim
	Akhtar'" <alim.akhtar@samsung.com>
Cc: "'Henrik Grimler'" <henrik@grimler.se>, <linux-pm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<shin.son@samsung.com>
In-Reply-To: <2b63c064-ce62-421b-8469-e434bd0c9652@linaro.org>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Mon, 24 Nov 2025 20:42:56 +0900
Message-ID: <000c01dc5d37$7b1b8da0$7152a8e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KIBiaSaQQHdj7cKAduSh9sCP+LNfQLSCcBls5d4FAA=
Content-Language: ko
X-CMS-MailID: 20251124114258epcas2p103cab1d3b8b5414e7437a08126e36d8b
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
	<ab35c20e-390c-4479-9bb1-9f5e49cba2a0@linaro.org>
	<000001dc5d32$2b4bfb20$81e3f160$@samsung.com>
	<2b63c064-ce62-421b-8469-e434bd0c9652@linaro.org>

Hello, Daniel Lezcano.

> -----Original Message-----
> From: Daniel Lezcano =5Bmailto:daniel.lezcano=40linaro.org=5D
> Sent: Monday, November 24, 2025 8:09 PM
> To: =EC=86=90=EC=8B=A0=20<shin.son=40samsung.com>;=20'Bartlomiej=20Zolnie=
rkiewicz'=0D=0A>=20<bzolnier=40gmail.com>;=20'Krzysztof=20Kozlowski'=20<krz=
k=40kernel.org>;=20'Rafael=20J=20.=0D=0A>=20Wysocki'=20<rafael=40kernel.org=
>;=20'Zhang=20Rui'=20<rui.zhang=40intel.com>;=20'Lukasz=0D=0A>=20Luba'=20<l=
ukasz.luba=40arm.com>;=20'Rob=20Herring'=20<robh=40kernel.org>;=20'Conor=0D=
=0A>=20Dooley'=20<conor+dt=40kernel.org>;=20'Alim=20Akhtar'=20<alim.akhtar=
=40samsung.com>=0D=0A>=20Cc:=20'Henrik=20Grimler'=20<henrik=40grimler.se>;=
=20linux-pm=40vger.kernel.org;=20linux-=0D=0A>=20samsung-soc=40vger.kernel.=
org;=20devicetree=40vger.kernel.org;=20linux-arm-=0D=0A>=20kernel=40lists.i=
nfradead.org;=20linux-kernel=40vger.kernel.org=0D=0A>=20Subject:=20Re:=20=
=5BPATCH=20v7=20RESEND=202/3=5D=20thermal:=20exynos_tmu:=20Support=20new=0D=
=0A>=20hardware=20and=20update=20TMU=20interface=0D=0A>=20=0D=0A>=20On=2011=
/24/25=2012:04,=20=EC=86=90=EC=8B=A0=20wrote:=0D=0A>=20>=20Hello,=20Daniel=
=20Lezcano.=0D=0A>=20>=0D=0A>=20>>=20On=2011/24/25=2011:06,=20=EC=86=90=EC=
=8B=A0=20wrote:=0D=0A>=20>>=20=5B=20...=20=5D=0D=0A>=20>>=0D=0A>=20>>>=20Ho=
wever,=20since=20ExynosAutov920=20diverges=20significantly=20from=20the=0D=
=0A>=20>>>=20existing=20driver,=20Would=20introducing=20a=20separate=20driv=
er=20instead=20of=0D=0A>=20>>>=20unifying=0D=0A>=20>>=20everything=20be=20a=
cceptable?=0D=0A>=20>>=0D=0A>=20>>=20So=20this=20driver=20is=20one=20contro=
ller=20for=20multiple=20sensors=20while=20the=0D=0A>=20>>=20others=20driver=
s=20are=20one=20controller=20for=20one=20sensor,=20right=20?=0D=0A>=20>>=0D=
=0A>=20>=0D=0A>=20>=20Yes.=20As=20far=20as=20I=20understand,=20the=20previo=
us=20Exynos=20variants=20used=20one=20TMU=0D=0A>=20>=20controller=20per=20s=
ensor,=20while=20on=20ExynosAutoV920=20the=20hardware=20has=20multiple=0D=
=0A>=20TMU=20instances=20and=20each=20instance=20contains=20multiple=20sens=
ors.=0D=0A>=20>=20Therefore,=20this=20new=20automotive=20SoC=20requires=20s=
upporting=20multiple=20sensors=0D=0A>=20behind=20a=20single=20TMU=20control=
ler.=0D=0A>=20=0D=0A>=20Ok=20thanks.=20It=20makes=20sense=20to=20create=20a=
=20separate=20driver.=0D=0A=0D=0AThen,=20I'll=20prepare=20a=20new=20patch=
=20series.=20Thank=20you=20for=20your=20feedback=0D=0A=0D=0ABest=20regards,=
=0D=0AShin=0D=0A=0D=0A

