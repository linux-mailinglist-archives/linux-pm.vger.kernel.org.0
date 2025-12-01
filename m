Return-Path: <linux-pm+bounces-38942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6658C9582D
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 02:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4CDD4E060B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6E13B5AE;
	Mon,  1 Dec 2025 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CPZfh8Ix"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF75981AA8
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553135; cv=none; b=hVxr5+gFdtCEYDaq8orDiUP/FGUsAFRsTrpJqaOg8Kdh/MMMxIHqbrcc+rJDjmOkjrBYDbAWxSDNkhKAqGjUlHPviN5t2pVcWGfggewYuoS2FKIuI/lbXjcRfTe/71lSqAk/p96lEwwNIQde7ZzBhTrzBGnvJCgTV9UH6ZKxsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553135; c=relaxed/simple;
	bh=EsphNECWH6FlY+/fe8I5Dr8EOrnC9119goArJKPN7Mg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Yfi8pYzh9/mAQZfB/RfDAbTnQKLJk6jROvbSDmAccNzeXqeN9bz0ENGXUO2inH8Ag0lo/righhLWok4V8we61oDdFs6GlnqpqF9/MPn2pMyKO/PaqbhGUrQUrGJU14kfSHRcMPDxNw1nYOofExJWU0yWubXn/UI/HI0h/0NSlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CPZfh8Ix; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251201013844epoutp04a0ee9a5b47528630cb7c5ffdb7dfab84~887fI8IUQ0200502005epoutp04b
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 01:38:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251201013844epoutp04a0ee9a5b47528630cb7c5ffdb7dfab84~887fI8IUQ0200502005epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764553124;
	bh=EsphNECWH6FlY+/fe8I5Dr8EOrnC9119goArJKPN7Mg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=CPZfh8IxcqENs97fdEl013f3S5nszJhFabG63EbOh6ZrvHK4Nb+Evqh4rY+ZmpQuc
	 QWuEZWCdQl4tF3huMtqgMCPqxAomKYgrvDKBpodQ6OJoCNcWhgbP8J+xGRYo96Hqk9
	 wTgHf/Yx7/0t+DmBjpuaVbAKdm/lKYN8hPH6gD/k=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20251201013843epcas2p2944a9c960745b2537458a3359803b97a~887ee830e2497924979epcas2p2p;
	Mon,  1 Dec 2025 01:38:43 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.206]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dKRPv3wjpz6B9m7; Mon,  1 Dec
	2025 01:38:43 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20251201013842epcas2p358dd69f1ccf89e6641f18de7aa36c405~887dgwr212919429194epcas2p3d;
	Mon,  1 Dec 2025 01:38:42 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251201013842epsmtip156a337ee8ce3fd5c1b4ac983debd2da6~887dYx5zk1615416154epsmtip1i;
	Mon,  1 Dec 2025 01:38:42 +0000 (GMT)
From: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>
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
	=?UTF-8?Q?'Andr=C3=A9_Draszik'?= <andre.draszik@linaro.org>, "'William
 McVicker'" <willmcvicker@google.com>, <jyescas@google.com>,
	<shin.son@samsung.com>
In-Reply-To: <1704827d-f273-4360-bcd5-c18818a85034@linaro.org>
Subject: RE: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware
 and update TMU interface
Date: Mon, 1 Dec 2025 10:38:35 +0900
Message-ID: <01da01dc6263$39efe660$adcfb320$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: ko
Thread-Index: AQJR08pAfg/+KuTfxFjIW+Bmb4uKqAKoesbtAuyt0KICEvKvogHXMeJ7AVgXt0UBNbSBZgGsluTSs7NOStA=
X-CMS-MailID: 20251201013842epcas2p358dd69f1ccf89e6641f18de7aa36c405
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
	<019301dc5f4a$e9aadd60$bd009820$@samsung.com>
	<1704827d-f273-4360-bcd5-c18818a85034@linaro.org>

Hello, Tudor Ambarus.

> > Yes, Do you have any plans to upstream the GS101 TMU code? From what I
> > understand,
>=20
> Yes, I'm currently working on upstreaming the GS101 TMU code. My plan is
> to do the acpm tmu helpers and then integrate the gs101 TMU support with
> what will be the new exynos TMU driver.

Ok, Understood.


> > Autov9 and exynos850 are unlikely to be upstreamed in their current for=
m.
>=20
> From what I understand from your email exchanges with Daniel, you're goin=
g
> to propose a new driver. Is my understanding correct? Do you have a
> timeline for it?
> I'll then follow with the gs101 support.

We don't have a timeline yet. Separating the driver was not our initial pla=
n,
So this work will likely be postponed to next year. When we resume it, I wi=
ll CC you.


> exynos850 has the same reg layout as eav920 and gs101 too. If Exynos9-era
> is a common terminology used inside Samsung then we should be good to go
> with
> Exynos9 prefix I think. Especially since we have a predecessor, the
> renaming tried in pinctrl. But if you're not sure about it, use just
> EXYNOS_ then.
>=20
> Cheers,
> ta

Got it. Thank you for your clarification.

Best regards,
Shin


