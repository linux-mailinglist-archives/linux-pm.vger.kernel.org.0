Return-Path: <linux-pm+bounces-38532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC418C83F54
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA6F3AEFDF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227EB2D8379;
	Tue, 25 Nov 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NUGGobgw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43C2D73A9
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058992; cv=none; b=TIIkAdPQ3RrrtA+28enFAvi6BPzqajIuRsMNJlx5mDlMbrX1DJDRbtUKQnbGkYDP70qAwuVpTv8dEDmUGquZd/n5H8Of13EVoz402mtgFxscy9n8/o6QTeF+6KXA4g9C8Uai1lZXGZvrJhcAI3TemVtXBPqWHVEFf8Hivn8U1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058992; c=relaxed/simple;
	bh=ht1OugzOUwV/KrUVMyjQ7leJQSldE8jckGSOW5P0o/g=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=eC3QLaUSOoitErRcfzK+MA1NL/kTujURlLjmo93ybmZqvEhTgGr53lYm7pwkd6Uc5Mjt/eDI5QnK73avq3WYk5o+8pxRE/LdM8fxVH0T39lR9GEQyQrwT6wmJBcvhYk723UHCCxxerIJywuHPzD2QHony77pYbE41634/Oz+Nrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NUGGobgw; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251125082307epoutp03bb76bc86e04cb5acd3a77b66de956e7c~7Mk2VBMAh0564705647epoutp03h
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 08:23:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251125082307epoutp03bb76bc86e04cb5acd3a77b66de956e7c~7Mk2VBMAh0564705647epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764058987;
	bh=ht1OugzOUwV/KrUVMyjQ7leJQSldE8jckGSOW5P0o/g=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=NUGGobgwunfFIVm/RnNL4GpxahnQBJf5tiWmW9VeEKNcjONhmz3aHQCZH6zkzi1o4
	 j8QaJsZxZ+bbUfXBhL2dKwuNXK6R6sJPAyeUmLxOociGG5ORSlpiAsX5YsbfPzCtEc
	 bpidDAM5eZkbMf8DTplx2e7GmYMosSjOyLuKQCMY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20251125082307epcas2p2017c082a27abe4d786ebc4613bd3976d~7Mk1n23d_0875708757epcas2p22;
	Tue, 25 Nov 2025 08:23:07 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.210]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dFwgG43YJz6B9mB; Tue, 25 Nov
	2025 08:23:06 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20251125082305epcas2p407d1d0314c6df8477fd07c4efb1a32f1~7Mk0hflfD3030730307epcas2p4E;
	Tue, 25 Nov 2025 08:23:05 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251125082305epsmtip161f504ec4fc5f1b153e41448f36076e3~7Mk0Z5LcV1597415974epsmtip1V;
	Tue, 25 Nov 2025 08:23:05 +0000 (GMT)
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
 McVicker'" <willmcvicker@google.com>, <jyescas@google.com>
In-Reply-To: <1baaae91-f712-4965-9105-4358a59ff1d1@linaro.org>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Tue, 25 Nov 2025 17:23:03 +0900
Message-ID: <00e201dc5de4$b948e0c0$2bdaa240$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KIBiaSaQQHdj7cKAU24glUB3tS++QLNzNdgs6AJmGA=
Content-Language: ko
X-CMS-MailID: 20251125082305epcas2p407d1d0314c6df8477fd07c4efb1a32f1
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
	<000b01dc5d37$3f6f5e80$be4e1b80$@samsung.com>
	<1baaae91-f712-4965-9105-4358a59ff1d1@linaro.org>

Hello, Tudor Ambarus.

> -----Original Message-----
> From: Tudor Ambarus =5Bmailto:tudor.ambarus=40linaro.org=5D
> Sent: Monday, November 24, 2025 9:24 PM
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
g;=20linux-kernel=40vger.kernel.org;=20'Peter=20Griffin'=0D=0A>=20<peter.gr=
iffin=40linaro.org>;=20'Andr=C3=A9=20Draszik'=20<andre.draszik=40linaro.org=
>;=0D=0A>=20'William=20McVicker'=20<willmcvicker=40google.com>;=20jyescas=
=40google.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=20v7=20RESEND=202/3=5D=20t=
hermal:=20exynos_tmu:=20Support=20new=0D=0A>=20hardware=20and=20update=20TM=
U=20interface=0D=0A>=20=0D=0A>=20Hi,=20Shin=20Son,=0D=0A>=20=0D=0A>=20On=20=
11/24/25=201:41=20PM,=20=EC=86=90=EC=8B=A0=20wrote:=0D=0A>=20>>=20Shin,=20a=
=20bit=20unrelated=20with=20the=20patch,=20but=20I=20wanted=20to=20let=20yo=
u=20know=0D=0A>=20>>=20that=20I=20started=20looking=20at=20the=20GS101=20TM=
U.=20I=20assume=20it's=20very=20similar=0D=0A>=20>>=20with=20the=20TMU=20on=
=20exynosautov920.=20Do=20you=20know=20if=20they=20share=20the=20same=20IP=
=0D=0A>=20version?=0D=0A>=20=0D=0A>=20I=20guess=20you=20omitted=20this=20qu=
estion.=0D=0A>=0D=0AOh,=20Sorry=20-=20I=20missed=20that=20question=20earlie=
r.=20I=20do=20see=20many=20similarities,=0D=0ABut=20I'm=20not=20sure=20whet=
her=20Exynosautov920=20actually=20share=20the=20same=20IP=20version=20as=20=
GS101.=0D=0A=0D=0A>=20>=20Regarding=20ACPM,=20I=20did=20not=20introduce=20i=
t=20earlier=20because=20I=20was=20trying=20to=0D=0A>=20align=20the=20implem=
entation=20with=20the=20existing=20framework.=0D=0A>=20>=20However,=20if=20=
we=20move=20toward=20a=20separate=20driver,=20I=20will=20reconsider=20wheth=
er=0D=0A>=20ACPM=20integration=20makes=20sense=20there.=0D=0A>=20>=20Would=
=20it=20be=20possible=20to=20get=20your=20feedback=20again=20when=20I=20pre=
pare=20the=20next=0D=0A>=20revision=20of=20the=20driver?=0D=0A>=20=0D=0A>=
=20Yes,=20I'll=20try=20to=20review=20it.=20Add=20me=20to=20cc=20please.=0D=
=0A=0D=0AThanks=20a=20lot=21=0D=0A=0D=0A>=20Is=20the=20downstream=20exynosa=
utov9=20code=20publicly=20available?=20Can=20you=20provide=0D=0A>=20some=20=
links?=0D=0A>=20=0D=0A>=20Thanks=21=0D=0A>=20ta=0D=0A=0D=0AThank=20you=20fo=
r=20sharing=20the=20links.=20As=20far=20as=20I=20know,=20the=20downstream=
=20eav9=20code=20is=20not=20publicly=20available.=0D=0AIn=20the=20next=20pa=
tch=20series,=20I'll=20make=20sure=20to=20add=20you=20to=20CC.=20I=20apprec=
iate=20your=20help=20and=20feedback.=0D=0A=0D=0AThanks,=0D=0AShin=0D=0A=0D=
=0A=0D=0A

