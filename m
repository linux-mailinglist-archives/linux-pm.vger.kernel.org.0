Return-Path: <linux-pm+bounces-14013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F54975183
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A51F231B7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB118FC9D;
	Wed, 11 Sep 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d7HMvBtx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E72188580
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056718; cv=none; b=k3Os1uRyboRhlA6V/sKhREJeA+6/MdkHcC+ePeXaJq3hFqX1FS4Lrwzxu+FCyhlVEDFseaKARFh/WkMdThc57t7rEUVmnHv0lRe9Ao/WwjeUvj4Q321I9NxRiMh1DO5qTbxmVtZ2q5IOccZliN6Lg/RRykt83BAHmRjxT6R52Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056718; c=relaxed/simple;
	bh=hwopkNPUqoevD6Cga6bxVg0ViqRZN33dDe39k+TX+PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kl+Hms6xTGUWMCaOnNdgP1v8TKGAgYBXTdI0HtjjjuDfODc3r9i84Nx6HOeqASy2so0UDJWwMIe1k9NVbKOwTk2sKaBiDPshxfiFuQYUM0cNwK4kxswOERR1IbZP7eptxCUwIT+Tu/0VwnEv6iwV9ONxtE9k3Tzf45vXOHeqtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=d7HMvBtx; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240911121153euoutp0275e9122b536612537d6e98f1d6f3df02~0L2_cOqHu0111101111euoutp02_
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240911121153euoutp0275e9122b536612537d6e98f1d6f3df02~0L2_cOqHu0111101111euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726056713;
	bh=0qS1OvBnHT+CBCcVEJwR8UDgglfjE/IHE9VpcHMT5q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d7HMvBtxIcZ3C+y3lLcfV/va2lV7cZdWaTnDlXu+CAwnJhvZ8uYhqcszX8rzG72KD
	 XyquQ2EC5i8+BjqGL3vDnz92dDr1tWGq+oWKigfsTQ4nllYsXkT8vFSoDTNi5j1tIT
	 mcnL0rTWHYXinyNeZdnqK1WqBuNOMP2V3xqTEsLQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240911121153eucas1p2761935111876fbc6971ecfcbedd26222~0L29635n41736617366eucas1p2x;
	Wed, 11 Sep 2024 12:11:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id F3.D1.09624.80981E66; Wed, 11
	Sep 2024 13:11:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121152eucas1p113445ce1ce6b6bd9c8f96322604bf517~0L29bZq2r1386613866eucas1p1o;
	Wed, 11 Sep 2024 12:11:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911121152eusmtrp299c699f697c3da3f8e1f2ee01298cafd~0L29aaIrr2708727087eusmtrp2g;
	Wed, 11 Sep 2024 12:11:52 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-91-66e18908d101
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.4D.19096.80981E66; Wed, 11
	Sep 2024 13:11:52 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121151eusmtip1b27d9ec62e0b7c209798e6802c626127~0L28gF1KN0847908479eusmtip1h;
	Wed, 11 Sep 2024 12:11:51 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 1/7] drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
Date: Wed, 11 Sep 2024 14:11:24 +0200
Message-ID: <20240911121136.1120026-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121136.1120026-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7ocnQ/TDBbdsLR4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XaI3fZLeZ+mcps8X/PDnaLJw/72Cye9+1jchDyWDNvDaPHzll32T0W73nJ5LFpVSeb
	x51re9g8Ni+p9+jbsorR4/MmuQCOKC6blNSczLLUIn27BK6Mn/NmMhe8ZatoW7WUpYHxB2sX
	IyeHhICJxIm+CUxdjFwcQgIrGCXmP5vJDpIQEvjCKNH4jRci8ZlR4urvdnaYjksH30IVLWeU
	+PUhD6KolUniye+vzCAJNgEDiQdvlrGDJEQEFgNN+vGOFcRhFpjIIrH+TTcjSJWwgI/EmuaD
	YKNYBFQlHm/ZAhbnFbCTWPtjPdSB8hIX1zxnA7E5Bewlvr9eDlUjKHFy5hMWEJsZqKZ562xm
	kAUSArM5JfZN/scC0ewicXP5PCYIW1ji1fEtUD/ISPzfOR8qni8xY/N7oHoOILtC4u5BLwjT
	WuLjGWYQk1lAU2L9Ln2IYkeJla82QxXzSdx4KwhxAJ/EpG3TmSHCvBIdbUIQ1aoSx/dMYoaw
	pSWetNyGWukhcfjQZcYJjIqzkLwyC8krsxD2LmBkXsUonlpanJueWmyYl1quV5yYW1yal66X
	nJ+7iRGY7k7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4e23u5cmxJuSWFmVWpQfX1Sak1p8iFGa
	g0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwMSrMpFH//ltvk+5ni8F1zyotQ2w3R1+Qunj
	4kXPf+hflctu2rza3fOx+6aUsqdqD+ev38bQ7rVP5/HU5Aw35kmXXzmtKDG6+6VqSvSMQ0XV
	XhcTFDiu1t2w2/qb98QrBvuSaYF9h2dvU/j6lkvqSNCf3U+N5xlOjXG+9/q7p0FU5juthN19
	PC9335ysyCa5/fGH09lZL5bnfzc3XLhx1qepN0+/X/kv96v+i12P7DNqPi5TyNO7vK3OeI/t
	tEOSgV8Xvc1qkTh9NuCAvsLLzvkhcRKFU2ut9jvFREqV7ZjhtPaX5A3V9gyV9nJzva1T8/kX
	nPoQs7n/91cNFwZ5uY6pyzZ3LV1SPX3q7bhPXj8YlFiKMxINtZiLihMBO69uLeYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7ocnQ/TDHZNk7J4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XaI3fZLeZ+mcps8X/PDnaLJw/72Cye9+1jchDyWDNvDaPHzll32T0W73nJ5LFpVSeb
	x51re9g8Ni+p9+jbsorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81gr
	I1MlfTublNSczLLUIn27BL2Mn/NmMhe8ZatoW7WUpYHxB2sXIyeHhICJxKWDb9m7GLk4hASW
	Mkqc/3UXKiEtcfjLFHYIW1jiz7UuNoiiZiaJu+t3MIEk2AQMJB68WQZWJCKwnFFic7sHSBGz
	wFwWic7Xq8ESwgI+EmuaD4LZLAKqEo+3bGEEsXkF7CTW/lgPtU1e4uKa52wgNqeAvcT318vB
	aoSAaj5uPMkKUS8ocXLmExYQmxmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKRXnJhb
	XJqXrpecn7uJERif24793LKDceWrj3qHGJk4GA8xSnAwK4nw9tvdSxPiTUmsrEotyo8vKs1J
	LT7EaAp090RmKdHkfGCCyCuJNzQzMDU0MbM0MLU0M1YS52W7cj5NSCA9sSQ1OzW1ILUIpo+J
	g1OqgYn/85k3zc/YG0qEC01aTKtNNh1ceTHX5czURO7VfP13vcIvd3SvdbzXIPQuytf1s57l
	b6sFalOsRcujr3xxdI/7uTksRk5CUn6dGhvnbdU7saFdfiE37vZu9pKKePUw8OzHfcpzrwsW
	LxJzsbWTdI/iOj2hU6uWJ0c1fnqcpVtKZ9jkmwqxUlO5wu7r7nnldf+DrnvAmx7HI7fmcVaf
	qw7h627OzN398mrt6YunTn6OrIjfccZuxfV5jLoLNjvGXSt7s1Nx45brv1fE/FHq/7vz6IQA
	aTEDO4k+Rv7eWeL5E4x3Pu10qlsf/XLdKXM77SpNnjlRM52+hLz5+n2P5TWnfbnfqv+EPSg0
	Zn2ZosRSnJFoqMVcVJwIACaeMpxYAwAA
X-CMS-MailID: 20240911121152eucas1p113445ce1ce6b6bd9c8f96322604bf517
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240911121152eucas1p113445ce1ce6b6bd9c8f96322604bf517
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240911121152eucas1p113445ce1ce6b6bd9c8f96322604bf517
References: <20240911121136.1120026-1-m.majewski2@samsung.com>
	<CGME20240911121152eucas1p113445ce1ce6b6bd9c8f96322604bf517@eucas1p1.samsung.com>

SIMPLE_DEV_PM_OPS is deprecated, as noted next to its definition.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 96cffb2c44ba..9b7ca93a72f1 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1150,8 +1150,8 @@ static int exynos_tmu_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
-			 exynos_tmu_suspend, exynos_tmu_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
+				exynos_tmu_suspend, exynos_tmu_resume);
 #define EXYNOS_TMU_PM	(&exynos_tmu_pm)
 #else
 #define EXYNOS_TMU_PM	NULL
-- 
2.45.2


