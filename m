Return-Path: <linux-pm+bounces-14012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C9975182
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E382128737D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647418F2FF;
	Wed, 11 Sep 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GIwkwKp/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291B188A14
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056718; cv=none; b=sCyGZ/ANne06I6BOi77xYuDT5/nKdQviKXrLw+ZUNfG5vJaEEBCvJJU3Tj7QKSFIVEV2SWxsCUlsEKXzX3pQhIgOWoXgSYvhOm/CU6d5L4qvUDVH6Rq/qTTmSIck0lDOXZpLDn6e5ngwjtkCfXFIZXDPMZwDgRF9rwlDMQ7K8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056718; c=relaxed/simple;
	bh=FEDEmbpAYmPOuuRo+RlDglGdJcWvHkw84rfZyKXuWo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sq/uGZ879oedAFKkxAyr2G/v56oDgXnXLid0pMq76Mnh1veIFwL8lPDYrd/Z+YCcR6eOWc24ukcK8f5uPMheJYZcH17XVsEGyde302/gyjGqUtvCv3JH5yuu/w0sMd13liEoCB0QtiilzkBI/ENFyGxIeq/ww5xl248lV6XE8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GIwkwKp/; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240911121154euoutp028ae5cc127f4e5c7e141d2fc9d65aa5b8~0L2-supCN0109201092euoutp026
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240911121154euoutp028ae5cc127f4e5c7e141d2fc9d65aa5b8~0L2-supCN0109201092euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726056714;
	bh=nvjwVOd+W/1Fy0GOMSwgEOErF159CdYtI3kdur0Gf6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIwkwKp/OZGhVNI+2PDPIYRSOA1k/TD/DTxp8uDzG7tVeQql2Np8gd7Z+QzqKRnhs
	 6ux1Z9Pf6JHsKSispYTpN+kA5HYebJtJDX+EK/UUOmCJHUSwnC9t3IlhnQdlzbjfBt
	 wOM4jYv89zRV+cw204xfOKL/RA5HjiU8Bnx4YsXo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240911121154eucas1p2552975738977fa101ffa3a3c06d5579a~0L2_8pLtA1732517325eucas1p2r;
	Wed, 11 Sep 2024 12:11:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B0.61.09875.90981E66; Wed, 11
	Sep 2024 13:11:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911121153eucas1p20f864c51746e6a7de55ecd0e52efe5c4~0L2_Xdqg22858828588eucas1p2o;
	Wed, 11 Sep 2024 12:11:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911121153eusmtrp2b14e07e38aec133391ae4431a80287ec~0L2_WRz632688526885eusmtrp2b;
	Wed, 11 Sep 2024 12:11:53 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-8f-66e18909b265
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8B.4D.19096.90981E66; Wed, 11
	Sep 2024 13:11:53 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121152eusmtip124636a6e621dbf563a9446cfc7e7ca49~0L29Ypa2P3163131631eusmtip19;
	Wed, 11 Sep 2024 12:11:52 +0000 (GMT)
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
Subject: [PATCH v4 2/7] drivers/thermal/exynos: use pm_sleep_ptr instead of
 conditional compilation
Date: Wed, 11 Sep 2024 14:11:25 +0200
Message-ID: <20240911121136.1120026-3-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121136.1120026-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djP87pcnQ/TDHovM1k8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLtkbvsFnO/TGW2+L9nB7vFk4d9bBbP+/YxOQh5rJm3htFj56y77B6L97xk8ti0qpPN
	4861PWwem5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG2kdHmAseclUcXnyepYGxh7OL
	kZNDQsBEYlHnXLYuRi4OIYEVjBK/Dp+Ecr4wSvT1fWGGcD4zSiydd5sdpuVa6x+oxHJGieam
	SWwgCSGBViaJFQeYQGw2AQOJB2+WsYMUiQgsZpRo/PGOFcRhFpjIIrH+TTcjSJWwQKrE5uXX
	wMayCKhKnL3Qywxi8wrYSXx5uYsFYp28xMU1z8E2cArYS3x/vZwRokZQ4uTMJ2A1zEA1zVtn
	g50kITCfU2LX3h/MEM0uEkfO3oeyhSVeHd8C9YOMxP+d85kg7HyJGZvfAw3iALIrJO4e9IIw
	rSU+nmEGMZkFNCXW79KHKHaU6J20kwmigk/ixltBiAP4JCZtm84MEeaV6GgTgqhWlTi+ZxLU
	emmJJy23oVZ6SCz+18g0gVFxFpJXZiF5ZRbC3gWMzKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1
	kvNzNzECE97pf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIrz9dvfShHhTEiurUovy44tKc1KLDzFK
	c7AoifOqpsinCgmkJ5akZqemFqQWwWSZODilGpiSmmqenqzew+hRKJcUGr6hSGfd5qUWr5SO
	T7i0RYNX/tDJGXvuu7Q3PGe98fVSS92KSLtL/S7JK/f0nHSytjG57rhr+4s7U7iLlpU/3y0p
	0ZUpNJtT1SBF7ci95g9m7580zVpl0mvJqLW06qj+kS+XNZ4U+3HZu1x/FbDo/g4hFz/5BScz
	edJVbddeCdn37i1z6KI9qlddN3NdExILXpj7IF6hYOFJgYsby2L49ycc6ZMvzYhw/fns7xR2
	75pPFaypUkFG/ItOMtZZ2LVsTztWu58l/lDaFmZ//ytLk1M2xaedmqHey2Xxg+XFUZftR5kN
	QhOP7g75/+bGrlS+4LZgbRWTQ+9W9qnuejt98wQlluKMREMt5qLiRAAMaNqJ5wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7qcnQ/TDK6sELd4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XaI3fZLeZ+mcps8X/PDnaLJw/72Cye9+1jchDyWDNvDaPHzll32T0W73nJ5LFpVSeb
	x51re9g8Ni+p9+jbsorR4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81gr
	I1MlfTublNSczLLUIn27BL2MtY+OMBc85Ko4vPg8SwNjD2cXIyeHhICJxLXWP8wgtpDAUkaJ
	rWsMIeLSEoe/TGGHsIUl/lzrYuti5AKqaWaS+LXwHStIgk3AQOLBm2VgRSICyxklNrd7gBQx
	C8xlkeh8vRosISyQLPG1cy+YzSKgKnH2Qi/YNl4BO4kvL3exQGyQl7i45jkbiM0pYC/x/fVy
	RoiL7CQ+bjzJClEvKHFy5hOwemag+uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJu
	cWleul5yfu4mRmB0bjv2c8sOxpWvPuodYmTiYDzEKMHBrCTC2293L02INyWxsiq1KD++qDQn
	tfgQoynQ3ROZpUST84HpIa8k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU7NTUgtQimD4m
	Dk6pBqZdDo0JWX6ObLNvLxf+t+KWzIupd1j7+yzezL7VOimjKemUvrrdy8+hM9MlE6UbxLsb
	W5/lPlujmzzxraTDtexNojynuPZ4zOyf2iGW93R99T6r9P9MQff2SVsrcV345c6lKhneUKNi
	Lf++efGblJJ/nrvsClT2vEg8v8T+hX7H3hITD5OjT7uu7WOeMDN/W9Aci0VeIu+PBzw4rnVc
	zPOj4c8TuvtOnGtZfzOkm+MLg96aKlmmiqsTDHq1LsQ5ctccYzm8wvJHy2SFe+GxS8pMU/5v
	m7pl5oNJp16aHJh9d4niAX6hXyeluffr7BM9p/WoUa0g5YWXh+g549LaXyoLQg0/3uIpPj71
	Q9HGXzxKLMUZiYZazEXFiQCKAhD+VwMAAA==
X-CMS-MailID: 20240911121153eucas1p20f864c51746e6a7de55ecd0e52efe5c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240911121153eucas1p20f864c51746e6a7de55ecd0e52efe5c4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240911121153eucas1p20f864c51746e6a7de55ecd0e52efe5c4
References: <20240911121136.1120026-1-m.majewski2@samsung.com>
	<CGME20240911121153eucas1p20f864c51746e6a7de55ecd0e52efe5c4@eucas1p2.samsung.com>

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
2.45.2


