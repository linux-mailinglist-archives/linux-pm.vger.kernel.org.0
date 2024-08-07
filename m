Return-Path: <linux-pm+bounces-11964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE494A351
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296991C2430C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35301CCB24;
	Wed,  7 Aug 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BID5LYoH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1252C1CB328
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020554; cv=none; b=cJki1B7UeLectSwAhe21IPLzC3ceJzHIZI8oPcbb5Zluh02zRknssVPNpBdMb8BXrz8/s8Ar8eJIcbNFZwddrUHYN95eSYer+NSSObSYT5tg98D1fd8X9yd4mehUHGzRKOWwibNwIJy+L+NQJxVVmZCXzFR5+ifo8iLox61KG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020554; c=relaxed/simple;
	bh=t0ekJRa/bwcza7nqSYIYmFRILhACg12lQL7jUL9Kwtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SQf/EirjPDf851gbvci8bU8l6u4NF5L11/Pb2DVOtwEq3F93U+XGC4m5wMEgP1TShi3D6Wxlu/QOSiuOwr6D6Uwmglo6APcHyWxYBVhcMqxGlNZra2sEbAdOaXTrtddlU8uk7KXy8iNY5BCI0Rz8PbMRqL751135zS94pdPjn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BID5LYoH; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240807084911euoutp0237f0cd150141b4e6b43fd44d0a5304c3~pZhAJpGrK3051330513euoutp02B
	for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2024 08:49:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240807084911euoutp0237f0cd150141b4e6b43fd44d0a5304c3~pZhAJpGrK3051330513euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723020551;
	bh=JihNWS+qQKkN2JSqVKvJDHUfHhnpQ/g8G2um7745xXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BID5LYoHS4XAqiaabpZXw0bXrpS9OxvCsEcRk/6nZb7A3dPo83mmf6UxWavQadr/d
	 vcxc/XenE3AKUc4NLrI/nxqElyHJL1rUwXDEy+9U2bPwd1KJD2ywq9LNFUhbU4/hKC
	 MPWrJpyMfNynHQ0F6Ipo274jA+RPxdbSPIOMAkuo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240807084911eucas1p1c0be09084f4cec4ae6bf24519589f2ec~pZg-3B0Sh0340503405eucas1p1a;
	Wed,  7 Aug 2024 08:49:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A9.02.09624.70533B66; Wed,  7
	Aug 2024 09:49:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240807084910eucas1p169d15e8209328d18230575a031e0a163~pZg-VQDGW0115601156eucas1p1E;
	Wed,  7 Aug 2024 08:49:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240807084910eusmtrp24210bd69ac355404823281e007c45bb5~pZg-UgD5n2321823218eusmtrp2C;
	Wed,  7 Aug 2024 08:49:10 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-23-66b335071461
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.DC.09010.60533B66; Wed,  7
	Aug 2024 09:49:10 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807084909eusmtip2952ba1ee9fc9058824f45180bc5d63af~pZg_azF9A1949919499eusmtip2R;
	Wed,  7 Aug 2024 08:49:09 +0000 (GMT)
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
Subject: [PATCH v3 2/6] drivers/thermal/exynos: use pm_sleep_ptr instead of
 conditional compilation
Date: Wed,  7 Aug 2024 10:48:21 +0200
Message-ID: <20240807084829.1037303-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240807084829.1037303-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djP87rsppvTDJr72CwezNvGZvF9y3Um
	izV7zzFZzPssazH/yDlWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/JYt3GW+wWC5ta2C0m
	HpvMbDH3y1Rmi/97drBbPHkINO553z4mB0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
	85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mq4PmcxU8FDrorHzfuYGxh7OLsYOTkkBEwk
	nn/rZAaxhQRWMEos+S7dxcgFZH9hlNjzeyIThPOZUeLQi7/MMB23H2xkh0gsZ5R4eXoqVFUr
	k8SP1WfAqtgEDCQevFkGViUisJhRovHHO1YQh1ngCbPEz1eLGUGqhAVSJRp2n2MDsVkEVCX2
	HG0H6+YVsJPY33SCHWKfvETv/j4mEJtTwF5iSXc3E0SNoMTJmU9YQGxmoJrmrbOZQRZICEzm
	lLi8ch8TRLOLxLZtb6EGCUu8Or4FypaR+L9zPlRNvsSMze+BBnEA2RUSdw96QZjWEh9BnuEA
	Gq8psX6XPkSxo0TzhXZGiAo+iRtvBSEO4JOYtG06M0SYV6KjTQiiWlXi+J5J0HCTlnjSchtq
	pYfExnP72SYwKs5C8sosJK/MQti7gJF5FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmCa
	O/3v+KcdjHNffdQ7xMjEwXiIUYKDWUmEtzl8U5oQb0piZVVqUX58UWlOavEhRmkOFiVxXtUU
	+VQhgfTEktTs1NSC1CKYLBMHp1QDk05JnX3ChKeTgyzaF0nrMfA4PNJK+ajE4rsrYXqv9qK7
	3kuu+yma3X0h8dkuI/T3wxkXUmyvV32oOz4nyGghW+6jX0/fHFaqqlpxUe/k3oeH17ydIX0k
	U6q+xZv7WOXnHdsvFjSoisvrHfTmaz3DXn24f/PbV8Hqm55wdW7/yVOwwrzUZ3rvZwZ1d+5d
	q/k8Wd9XKiXekMo+VK05e43iopTHoReqzwlfqnEIsgm2Nz8m5PjruUrrRcaw9BfJM6b8Wisj
	aMx8K9+n++aX72yFUS0vPuiVWUbbbpump/Wr/mz4tqPbHA9zdi3ZdsKkqCMitm2S4/F96Xmf
	QvbGdG/VneYdVlzRENGWJMq4Q0pDiaU4I9FQi7moOBEAetlScOIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7psppvTDF5+U7R4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXcX3OYqaCh1wVj5v3MTcw9nB2MXJySAiYSNx+sJG9i5GLQ0hgKaPEy3+b
	mSAS0hKHv0xhh7CFJf5c62KDKGpmkpg+vxOsiE3AQOLBm2VgRSICyxklNrd7gNjMAu+YJdrP
	+4HYwgLJEoefnmMDsVkEVCX2HG1nBrF5Bewk9jedgFogL9G7vw9sJqeAvcSS7m4wWwiopvfL
	Tqh6QYmTM5+wQMyXl2jeOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+du
	YgTG5LZjP7fsYFz56qPeIUYmDsZDjBIczEoivM3hm9KEeFMSK6tSi/Lji0pzUosPMZoC3T2R
	WUo0OR+YFPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpg45Lao
	tRs5GwRobRLQXpvw/dw95lST3LrqMw/3PnQw/33g+T5XUZ/4Y5vFLruERmuv8zT49fKyZfui
	xKTeD9uefzLQ61ZzTcxLPOf6+kz5FbNb95tc3jp8uKrx4uy9P8kn/8opuF5lanzKGvvx1Y9/
	6xZfj3Pd6LJVjCPY8U25yvH5zcaLVz1W/rf4CePjuYt0t5x4v2Dj/tUT3eWz99RfZP+0if+C
	6PZTkyvrCrMfCopfZM9hT5e5+++q4QYmu0kBcukJxosvBjPfP8Lm3rSw6fueJWs2mRUU+69+
	vyPv9LNPKr25yruv66y6rzlfnk96+v9dtgUtev3nnqTfz/hmxbdvkrv3EnmNx5+TRBmPKLEU
	ZyQaajEXFScCAKs65BZSAwAA
X-CMS-MailID: 20240807084910eucas1p169d15e8209328d18230575a031e0a163
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240807084910eucas1p169d15e8209328d18230575a031e0a163
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240807084910eucas1p169d15e8209328d18230575a031e0a163
References: <20240807084829.1037303-1-m.majewski2@samsung.com>
	<CGME20240807084910eucas1p169d15e8209328d18230575a031e0a163@eucas1p1.samsung.com>

Slightly simpler and nothing is lost if _suspend and _resume functions
are built unconditionally.

Suggested-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
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


