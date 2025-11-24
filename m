Return-Path: <linux-pm+bounces-38440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B4C8012C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1D14E45BD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2762FD686;
	Mon, 24 Nov 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mS0Pz9Hk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BC2FC00E
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982303; cv=none; b=f1M0SjF74mjOXDRScWq+xFJhWexcTo/wUrRTG0F4ghU7oyHl7+Zo4Lzt245S+PDxW+I/rvlR+aqEXs0pDeFUzg+dqmGvsBl+HWxFgXJvCggy00BuYCCYyrBPwVy/RcQbl97wvSdy9qgDYDEtzyF5/EGzkrISZn+/tSeiyee6pIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982303; c=relaxed/simple;
	bh=J32kqd07hFmR6eCMuZ/OyisnVfntR08V/NULDB+Qtzw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=f0a8yrMhYRbxskc4ViglTRbkcXhb2cha2xm1JmIpZAkWJxd1CcG6Sq5Z8lPylmYfYD3QV/tLwJV4Wzd2kSx8xdDHEO+cfhWzSjDzLUvNCLzur86CuGaAwJqkC/E11zU5vSbv9P/g/0LMxey05DiI3SwLEeU1vkTjh8ADJTzjORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mS0Pz9Hk; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251124110459epoutp04958751535df796441e274c1e2b23748c~67I4o64Fs1666016660epoutp04o
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:04:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251124110459epoutp04958751535df796441e274c1e2b23748c~67I4o64Fs1666016660epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763982299;
	bh=J32kqd07hFmR6eCMuZ/OyisnVfntR08V/NULDB+Qtzw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=mS0Pz9Hk7zb44LWjov+0QWnVyDqaOuhmHK1+gWG7CBPxuLrMvQRL3dm6+jDRXxHHa
	 h/I44T3iGIliduswPtf0GhgQl82i8Y3Cs+3QIeH/Dnb/up/pnbxh2BPSry31pZ9bQO
	 mfxYRrTI8dE3WmDcLJpgPJE4j5/PV0Ur+l7yVt7M=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20251124110458epcas2p31e56f8e02f3934038a9fbfac7de56fa5~67I37P8K50477404774epcas2p3F;
	Mon, 24 Nov 2025 11:04:58 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.203]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dFNJV1X4Tz2SSKX; Mon, 24 Nov
	2025 11:04:58 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20251124110457epcas2p442cbe07b335d90a8b5e4c66cd02e928c~67I2noxqe0858708587epcas2p4u;
	Mon, 24 Nov 2025 11:04:57 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251124110457epsmtip29fb37f805b54cc32a362e2c7f1e2908d~67I2g3jBS1950019500epsmtip2R;
	Mon, 24 Nov 2025 11:04:57 +0000 (GMT)
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
In-Reply-To: <ab35c20e-390c-4479-9bb1-9f5e49cba2a0@linaro.org>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Mon, 24 Nov 2025 20:04:53 +0900
Message-ID: <000001dc5d32$2b4bfb20$81e3f160$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KIBiaSaQQHdj7cKAduSh9uzv/aP0A==
Content-Language: ko
X-CMS-MailID: 20251124110457epcas2p442cbe07b335d90a8b5e4c66cd02e928c
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

Hello, Daniel Lezcano.

> On 11/24/25 11:06, =EC=86=90=EC=8B=A0=20wrote:=0D=0A>=20=5B=20...=20=5D=
=0D=0A>=20=0D=0A>=20>=20However,=20since=20ExynosAutov920=20diverges=20sign=
ificantly=20from=20the=20existing=0D=0A>=20>=20driver,=20Would=20introducin=
g=20a=20separate=20driver=20instead=20of=20unifying=0D=0A>=20everything=20b=
e=20acceptable?=0D=0A>=20=0D=0A>=20So=20this=20driver=20is=20one=20controll=
er=20for=20multiple=20sensors=20while=20the=20others=0D=0A>=20drivers=20are=
=20one=20controller=20for=20one=20sensor,=20right=20?=0D=0A>=20=0D=0A=0D=0A=
Yes.=20As=20far=20as=20I=20understand,=20the=20previous=20Exynos=20variants=
=20used=20one=20TMU=20controller=20per=20sensor,=0D=0Awhile=20on=20ExynosAu=
toV920=20the=20hardware=20has=20multiple=20TMU=20instances=20and=20each=20i=
nstance=20contains=20multiple=20sensors.=0D=0ATherefore,=20this=20new=20aut=
omotive=20SoC=20requires=20supporting=20multiple=20sensors=20behind=20a=20s=
ingle=20TMU=20controller.=0D=0A=0D=0ABest=20regards,=0D=0AShin=0D=0A=0D=0A

