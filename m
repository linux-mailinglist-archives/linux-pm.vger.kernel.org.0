Return-Path: <linux-pm+bounces-11418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236393D175
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773691F21FBE
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030AD179663;
	Fri, 26 Jul 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WuebpcVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45220176240
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991704; cv=none; b=O+c9QktrXoqWDx51LeNBfu2wXSfUUHMlKsv9W/Ead1CVbixCnHonVXJZUlCoUjVB4CvIM3nJ6hmxx+Ir5edE1F9yqNp7HfKu6KewUJGvY0xviDpv98trIRPhSushRjnj5Vi+/PMeOn59jiq/s5W5W0Ir5h8cMhZ1Rx62webnh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991704; c=relaxed/simple;
	bh=G8SGnQGahIJiAKPyeQeKvQveyR8NwK/8b3eWpshYTq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=hitYAktu7YHlPiDTAUXgHTb4sYJWjfrBwzn9dG9LoE7Kwx+4i8gUmPuwvt/OvFGyzxyeokVwqQWQFuuIHGKP4LkHq5riHBeeQ02bhCVv4Mnlq2Zo1dw8eyGSblmOC66gA2neGuNvJmShNciao43MNIGjgHo+kHsGUU3SHC48a6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WuebpcVa; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240726110136euoutp01e910f80fa97b894ea191aaca6fbf01f7~lvlL7VSRa3068530685euoutp01d
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240726110136euoutp01e910f80fa97b894ea191aaca6fbf01f7~lvlL7VSRa3068530685euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721991696;
	bh=yj+6WZo4Jh1Ovyod4LsdDGfLEkdyiOxcrU/H1erGQ2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuebpcVaZpEhBsXuX4L9GF9ljrcQvIGv+A+xxLZB+vvnS3kaLRUjMVs+tj9K2kLxH
	 dwRh7aRPfm2fbrFzIQIX6IilhuR3p/YFCulGHXjEYSuuCSiGtzEMhwSj6N5dma8fEm
	 5txJw4Jm9DKj5I9gWwDhTPzvE+1Yw/sN3x6uVcxc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240726110135eucas1p2f440c6f19de370858c5b3edd8bd530d7~lvlLfnYJ12816328163eucas1p24;
	Fri, 26 Jul 2024 11:01:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id D3.C8.09875.F0283A66; Fri, 26
	Jul 2024 12:01:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240726110135eucas1p118620038792bd07154f32f7b95f48326~lvlLI2pis1393813938eucas1p1y;
	Fri, 26 Jul 2024 11:01:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240726110135eusmtrp27822bfa3b67deacdf4b7e23184051d2b~lvlLIJp5H1722117221eusmtrp2W;
	Fri, 26 Jul 2024 11:01:35 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-ae-66a3820f53dd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.27.08810.F0283A66; Fri, 26
	Jul 2024 12:01:35 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110134eusmtip2073c6e21bbffe2d00530a31abf252afa~lvlKQNE-H2468524685eusmtip2Q;
	Fri, 26 Jul 2024 11:01:34 +0000 (GMT)
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
Subject: [PATCH v2 1/6] drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
Date: Fri, 26 Jul 2024 13:01:05 +0200
Message-ID: <20240726110114.1509733-2-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240726110114.1509733-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87r8TYvTDDa/ULV4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVsfT0NraCt2wVO1uPsTUw/mDtYuTgkBAw
	kZiytayLkYtDSGAFo8Tb7rlsEM4XRonGCx1QzmdGiYdP7zN1MXKCdcy50MMIkVjOKDF30zYW
	CKeVSeLQz+UsIFVsAgYSD94sYwdJiAgsBpr14x0riMMs8IRZ4uerxUD97BzCAj4SMwJA7mAR
	UJX4vy8IpJVXwE7i5cbvzBDL5CV69/eBLeYUsJdYMukjI0SNoMTJmU/AVjED1TRvnc0MMl1C
	YDanxKrZ66GaXSRaHl5hh7CFJV4d3wJly0j83zkf6pt8iRmb37NAwqJC4u5BLwjTWuLjGWYQ
	k1lAU2L9Ln2IYkeJHc0PGSEq+CRuvBWEOIBPYtK26cwQYV6JjjYhiGpVieN7JkGdIi3xpOU2
	1EoPiR+d/9knMCrOQvLKLCSvzELYu4CReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg
	gjv97/iXHYzLX33UO8TIxMF4iFGCg1lJhHfZ/YVpQrwpiZVVqUX58UWlOanFhxilOViUxHlV
	U+RThQTSE0tSs1NTC1KLYLJMHJxSDUwbjjX0rH/enBRQIcbm8sxx2ddTUUJLrdotl60/NDFW
	YUe+54/YKRpNz+12P+YpnXNlQvtW0ZcGXXyhTkvKr14PV56xzm1KOWPT0s925xz9nBI23q8W
	5/GoDhPxMz5stq3XtWupQ+1Jd4ZKFZVp+ofn1XFb+2u7O52O3PX5z7mcbie2PzzfLW4a/Nzc
	fSecIfu/5oX4x0YyCk0sb9M5mIrnfLfIZvk6+/z8YxJ2M2uu8m1neX5SxCoqZoGxtfbCW2vm
	qi4Q8YwLY7RLEj2o8ManSDuPd42gdOuOoE+3M55LCZ46fvHM8i933kwUsNxvZ9e1Nd9Uy0b4
	hOWlVPmYtskfVX6e3elQ9WnH8ZSlckosxRmJhlrMRcWJAM4ANPXfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7r8TYvTDL4u5bd4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXsfT0NraCt2wVO1uPsTUw/mDtYuTkkBAwkZhzoYexi5GLQ0hgKaPEikVN
	LBAJaYnDX6awQ9jCEn+udbFBFDUzSbyfvZoRJMEmYCDx4M0ysCIRgeWMEpvbPUBsZoF3zBLt
	5/26GNk5hAV8JGYEdDFycLAIqEr83xcEUsArYCfxcuN3Zojp8hK9+/uYQGxOAXuJJZM+gg0X
	Aqq53wuxiFdAUOLkzCcsEMPlJZq3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xYZ6xYm5xaV5
	6XrJ+bmbGIHRuO3Yz807GOe9+qh3iJGJg/EQowQHs5II77L7C9OEeFMSK6tSi/Lji0pzUosP
	MZoCnT2RWUo0OR+YDvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODil
	GphiQqbHRVrZbWrWsnoWxlp4hn9CX0x0zEX+dWtvzvpuY8l15OyG2zduLkqf2mq9b9PeG4f3
	pv4VEZH5c0DZmu8Xs9r9D8E6B27kbmKbeuyS/csf24JeG365tcBD4ExLyOenM9U2+hotrHuq
	+r/Y0Ud1R7zb0YBNNnO3pVyc/PrBqfDI0p67+vtvz1e+3HjzR9mhGX1qz+1uuq74O+9nv6Ln
	rt0qK5Q22FxzCBFYLruMTXf1gstpXuxTG5hElnTwPefk8tv87kbh0UeWui9jp1cvP3jhZTXb
	4nlGJ7zNTYV3Npg0Jk4JyXT/deMKn7hmx8o/zIe8TPjm7gz+vP6c1z4WRubi1s+yoU27g9V6
	QjOXK7EUZyQaajEXFScCADPq7qtPAwAA
X-CMS-MailID: 20240726110135eucas1p118620038792bd07154f32f7b95f48326
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240726110135eucas1p118620038792bd07154f32f7b95f48326
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240726110135eucas1p118620038792bd07154f32f7b95f48326
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
	<CGME20240726110135eucas1p118620038792bd07154f32f7b95f48326@eucas1p1.samsung.com>

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
2.45.1


