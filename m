Return-Path: <linux-pm+bounces-11434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8E93D588
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D141C230A1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505CC1EB5B;
	Fri, 26 Jul 2024 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m12twyTo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47D23A8
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006233; cv=none; b=uObLTewuJp8Iz+enPQgfW43AiP2z3AL0TewcrTpd9g9rJpYybMTQUQ1cWAcyH8gW2v1YWH9y05CbtaNXeQXhDHDLiFLMwxcRTBwrOPJcyRWSm6m8w5pgtwGoLCoCZdrjmm4A6bD73uJ/3KRj4Leo+KE7cShJMKMjS+94lKT9dVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006233; c=relaxed/simple;
	bh=BMGxaSXqdPMq+4pPEklbnF3dYHS0Wrz39i3IzGixcGw=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=aKh38XmzLCHXoaznmlopshfyW/rTWg8dqPbobwtc/Q4iFlm1dBqO0xEK8VZMXiiJZ3R3Tk4LNWR0OIkvE/JSdUQIGtQu4sru+qhYmAtSsGl4m3+ViU2X4jqPj9isoy85UYttYHInD049ejtRVPKv7dM5s/2wCKARBEvZ0dqYXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m12twyTo; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240726150349euoutp01052a6211145338747fadf7d6f37e7837~ly4q9K0F41070210702euoutp01V
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 15:03:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240726150349euoutp01052a6211145338747fadf7d6f37e7837~ly4q9K0F41070210702euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722006229;
	bh=BMGxaSXqdPMq+4pPEklbnF3dYHS0Wrz39i3IzGixcGw=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=m12twyTo4XtaxMpq2/9KsGvuWqVHSPMLIhLqzC5ZZzv+uPy/CtX4vv9rLs+yvqaJu
	 V+b+T052U0H1b6XVXDTMIMX4pZSsZGvtQR5igYPbopIAQDlVoFkYrV+wv49KXWWlk+
	 MjSJKPS6+AfB58Sb/I9n+teQm1HfxwEEdVK125ik=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240726150348eucas1p2794c2d6fe56e7b20f94687c472348a67~ly4qX60890600606006eucas1p2z;
	Fri, 26 Jul 2024 15:03:48 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-61-66a3bad46e4e
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5F.AA.09624.4DAB3A66; Fri, 26
	Jul 2024 16:03:48 +0100 (BST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v2 0/6] Add initial Exynos850 support to the thermal
 driver
Reply-To: m.majewski2@samsung.com
Sender: Mateusz Majewski <m.majewski2@samsung.com>
From: Mateusz Majewski <m.majewski2@samsung.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, ALIM AKHTAR
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240726110114.1509733-1-m.majewski2@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240726150348eucms1p356a6209b11c81924a1dac027555466cd@eucms1p3>
Date: Fri, 26 Jul 2024 17:03:48 +0200
X-CMS-MailID: 20240726150348eucms1p356a6209b11c81924a1dac027555466cd
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240726110133eucas1p1a20d4fae252520ea6747bc1101c9d59a
X-EPHeader: Mail
X-ConfirmMail: N,general
CMS-TYPE: 201P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87pXdi1OM7i2TNHiwbxtbBbft1xn
	sliz9xyTxbzPshbzj5xjtTh/fgO7xabH11gtLu+aw2bxufcIo8WM8/uYLNZtvMVusbCphd1i
	4rHJzBZzv0xltvi/Zwe7xZOHfWwWz/v2MTkIeqyZt4bRY+esu+wei/e8ZPLYtKqTzePOtT1s
	HpuX1Hv0bVnF6PF5k1wARxSXTUpqTmZZapG+XQJXxo63kxkLXrFWvN/znrWB8R1LFyMnh4SA
	icSHP01MXYxcHEICKxgl5tz7zdjFyMHBKyAo8XeHMEiNsECgxLHGNWD1QgKKEp3b37BBxI0k
	Dr3YBWazCRhIPHizjB1kjojAVSaJZ08/gTnMAk+YJSZcmwK1jVdiRvtTKFtaYvvyrYwgNqeA
	vcSSSR8ZIeKiEjdXv2WHsd8fmw8VF5FovXeWGcIWlHjwczdUXEbi5IJlUHaxxMu1l6BqKiSO
	L5kONcdcYtPcNawgNq+Ar8T129PBbmARUJW4//cbK8jDEgIuEmue8IGEmQXkJba/ncMMEmYW
	0JRYv0sfosJR4vaeCoiBAhJrTsyBWiQhsbXlCStEJ5/EpG3TmWGe3THvCROErSpxfM8kZpjH
	n7TcZprAqDQLEdCzkOydhbB3ASPzKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMD0dvrf
	8U87GOe++qh3iJGJg/EQowQHs5II77L7C9OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcK
	CaQnlqRmp6YWpBbBZJk4OKUamKaYXhJnW+PK9LCQJ8cswvJgzNG2mgjrzM6eCu5zMx79vC8h
	NJVlkVJQzBfFfeLmhQvFLjJ13Jyl+0j4RuRZYTW34MbFQU5GXAFhE/O/Ps//4yGx4Ea61pm1
	kgc3zBDZxv10zU329ptvQ68vDk2vW1BdeHGn6hGlgxEZ1+9kp03nXhnz7OecZzJyD25/DPt7
	L25Cm318hdnfeqVwxVfCfr0+3wwjdgWvnNj6JntvpMT9l5v/JNTF92oVi5Rc7Ne4Fnz+ZF7o
	z/POU5Zxa6p5Jf5Jczyz+0WAOktrvtfRBT9tOQW/TZp07VLv8r/d89+EG7DfkNa55dy/KMIt
	U7G+NWfh4zVHqqY3VKlf4lkuq8RSnJFoqMVcVJwIAJTCqDDeAwAA
X-CMS-RootMailID: 20240726110133eucas1p1a20d4fae252520ea6747bc1101c9d59a
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
	<CGME20240726110133eucas1p1a20d4fae252520ea6747bc1101c9d59a@eucms1p3>

Forgot to mention it in the cover letter, but as discussed in v1 in
https://lore.kernel.org/lkml/CAPLW+4nfEjP4FDjRJORyyKk46x4VfFAcMuK88jXUT_LJoP1N_g@mail.gmail.com,
this requires support for the TMU clock to run, available in
https://lore.kernel.org/lkml/20240723163311.28654-2-semen.protsenko@linaro.org.
This series builds fine without this, only it is not possible to write a
devicetree source for this without the mentioned series, so as I
understand it is ok for this to be in review anyway?

By the way, I am going to have some more time to help with the upstream
kernel, and have access to most of the supported SoCs. If you feel that
it is appropriate, I would be very happy to become one of the
maintainers of this driver :)

