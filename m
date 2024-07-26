Return-Path: <linux-pm+bounces-11421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54C193D17E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0D3281C29
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E217A5B7;
	Fri, 26 Jul 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RQpO+Bpl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24083179956
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991707; cv=none; b=BkF2Wq0lyfRHFmC8eQ3YpC6UKbj91tHDVJCsIhIQpL7qEPvID5oRmnSoOTZNbs/M/Hf3KCrg0azQuZcspvE0kt1xVvQsMH4kUU6sR+chOSfAL/wYUIZjYfsNcg6vJ3f+34ItqfCDFlinzP8dp0Nmmtmcb7zcSKmz8oDxFFQ0y1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991707; c=relaxed/simple;
	bh=6+x2NU+bO6SYQfy5ttoPIJJ+saijMgx572Nw18DrXkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TgJ7i2yfejQ9qF13HQnB7X02N45aSFSbXKDErv2PqTmPMvq2kQqWY4yziaJfoKHrtHJOX5zWeQ+O+LSAE8HnnRYbo7dMrrVOeNukp5gvq4LVKLtA2XAWBWkY5599W8zO7zhJwNLG173CQ8xjmn8vltgDfUwvjobKv+HRYmrGtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RQpO+Bpl; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240726110137euoutp011f6f58fda1df0c05ee212be136fbc29c~lvlNkPEis0139401394euoutp01q
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240726110137euoutp011f6f58fda1df0c05ee212be136fbc29c~lvlNkPEis0139401394euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721991697;
	bh=0BeiRE0Ve1CHw9X9pRqdMFWHo53wdnWTEwVCP12z2WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQpO+BplCEPdPNcJIP/+0Gau5v/Fihmq0RmwLl/oDRjgbFzHQ/K8YH3GSVlYiwQhQ
	 ba2UmSSjPwWzduYD7tbdQShyJCGl7g4NJpnmRWCLfrFYv3zAjttlJiXZEwrZqeN4Fi
	 QimxMoBJbzu0t6txo3grOkn2+hS0cqjdowur27Bs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240726110137eucas1p1652a14a57090c22eca8fac649b09c57e~lvlNNESh01887818878eucas1p15;
	Fri, 26 Jul 2024 11:01:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.FB.09624.11283A66; Fri, 26
	Jul 2024 12:01:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110136eucas1p2c100992bb710acb5a12bb294401d4aeb~lvlMr-E8a2810128101eucas1p2_;
	Fri, 26 Jul 2024 11:01:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240726110136eusmtrp2bc7ffc6e6474d8bb970f41fb4e1451f7~lvlMrOXnB1722517225eusmtrp2R;
	Fri, 26 Jul 2024 11:01:36 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-e7-66a382119a17
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C7.B1.09010.01283A66; Fri, 26
	Jul 2024 12:01:36 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110135eusmtip2e50f4a82cc50608f178a006e78792e12~lvlLvW_zQ2467724677eusmtip2L;
	Fri, 26 Jul 2024 11:01:35 +0000 (GMT)
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
	Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 2/6] drivers/thermal/exynos: use pm_sleep_ptr instead of
 conditional compilation
Date: Fri, 26 Jul 2024 13:01:06 +0200
Message-ID: <20240726110114.1509733-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240726110114.1509733-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7qCTYvTDFqOi1g8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLul6nMFv/37GC3ePKwj83ied8+JgdBjzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofN
	Y/OSeo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK2HhoH0vBCq6KQzOmsDQw3uDoYuTkkBAw
	kdh86ylLFyMXh5DACkaJ3RefsUE4XxglZj3eDeV8ZpRoXbmCCabl8+SvTBCJ5YwSf5v6mSGc
	ViaJUwsfgVWxCRhIPHizjB0kISKwmFGi8cc7VhCHWeAJs8TPV4sZQaqEBVIlfixYA2azCKhK
	dH88wgJi8wrYSVyeNIMZYp+8RO/+PrCpnAL2EksmfWSEqBGUODnzCVg9M1BN89bZYGdICEzn
	lLi5+zYLRLOLxOv7p1ghbGGJV8e3sEPYMhL/d86HeihfYsbm90D1HEB2hcTdg14QprXExzPM
	ICazgKbE+l36EMWOEvMfPGaCqOCTuPFWEOIAPolJ26YzQ4R5JTrahCCqVSWO75kE9Ye0xJOW
	21ArPSQWvbzPPIFRcRaSV2YheWUWwt4FjMyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcx
	AhPd6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8y+4vTBPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	q5oinyokkJ5YkpqdmlqQWgSTZeLglGpgkolfZa3T2qFfaq/nI9PMvVfv5uRbRRYWHp7P+z+e
	tr2fm75vs6eYj4bMTfkHP04/t11/6oT1R8ldKdeSBT9wCGvxz7B6Of3WwuY6YdsUc5fEDUXR
	d2JWL2W2LN9XuuHSUpXwC3HOt8/wJid6C6VyPm/w6U4JflDoHp1+s9xrwRGn0po/HDNfv5x4
	5PB2B3HG4q+fi9+/PPbjt02O6uKlbc+1fWK6p6d6iKrv135dXvrHcQbXzcs/Z5UXBWzTnvlu
	9u79zFULo7z++Sx57pl/I3GBtzHv9uefM65/S/I4J1nZvzXlTqvWx6b3UQoN3hFtLcqblbJc
	F/LeOtdx5dmyvoTaFYz6rwoEObimrk1VYinOSDTUYi4qTgQApFXlL+MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7oCTYvTDL5vNrR4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXsfHQPpaCFVwVh2ZMYWlgvMHRxcjJISFgIvF58lemLkYuDiGBpYwSJ5Yu
	YoRISEsc/jKFHcIWlvhzrYsNoqiZSWLrtWtgCTYBA4kHb5aB2SICyxklNrd7gNjMAu+YJdrP
	+4HYwgLJEnde9jKD2CwCqhLdH4+wgNi8AnYSlyfNYIZYIC/Ru7+PCcTmFLCXWDLpI9gRQkA1
	93tXM0LUC0qcnPmEBWK+vETz1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0L10v
	OT93EyMwJrcd+7llB+PKVx/1DjEycTAeYpTgYFYS4V12f2GaEG9KYmVValF+fFFpTmrxIUZT
	oLsnMkuJJucDk0JeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVANT
	UF2w3GydgoVNkWJ3l/59ltJ+rMfczHvqR763ogVKz2eai306bGD7e67khAPH2A6KyP6urpWw
	fstru2Gfwp5TPlYa8bcYnht9+8YTvsGA8c7Png9z5ttqdOuVTba4EMrtULmq8n/mBHv1TzkG
	1m/bu6ZMPdphkzNhpsuXlJ/dxhekbZyudp5SYK996aZ5019+X+JZHqfXcta3GP+1RiQ+eS7b
	eNz/XIXPJbe1144GTRRb8V8n6fWHYsuG4/5fO6ad1/nza/VvuTXmr08ylAlo+pf9e+5Tcmpa
	o9OZA5yZ8+MWP+6Ltj/6/06iw8rQipyFCi0L418c5vimZbfebhJ7CZcE63yGS8+d21X+8R1Q
	YinOSDTUYi4qTgQAoW1ef1IDAAA=
X-CMS-MailID: 20240726110136eucas1p2c100992bb710acb5a12bb294401d4aeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240726110136eucas1p2c100992bb710acb5a12bb294401d4aeb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240726110136eucas1p2c100992bb710acb5a12bb294401d4aeb
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
	<CGME20240726110136eucas1p2c100992bb710acb5a12bb294401d4aeb@eucas1p2.samsung.com>

Slightly simpler and nothing is lost if _suspend and _resume functions
are built unconditionally.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9b7ca93a72f1..b68e9755c933 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1132,7 +1132,6 @@ static void exynos_tmu_remove(struct platform_device *pdev)
 		clk_unprepare(data->clk_sec);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int exynos_tmu_suspend(struct device *dev)
 {
 	exynos_tmu_control(to_platform_device(dev), false);
@@ -1152,15 +1151,11 @@ static int exynos_tmu_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
 				exynos_tmu_suspend, exynos_tmu_resume);
-#define EXYNOS_TMU_PM	(&exynos_tmu_pm)
-#else
-#define EXYNOS_TMU_PM	NULL
-#endif
 
 static struct platform_driver exynos_tmu_driver = {
 	.driver = {
 		.name   = "exynos-tmu",
-		.pm     = EXYNOS_TMU_PM,
+		.pm     = pm_sleep_ptr(&exynos_tmu_pm),
 		.of_match_table = exynos_tmu_match,
 	},
 	.probe = exynos_tmu_probe,
-- 
2.45.1


