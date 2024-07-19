Return-Path: <linux-pm+bounces-11257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C693778A
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 14:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED541B21900
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64F13DDC0;
	Fri, 19 Jul 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dTFSjVDB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56D137775
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390998; cv=none; b=Z1a7ZSxetDU22g/UFuoCi6jCCUV45XqclKNV6hG3BMI3UodmhRXuLFkkQr3gMi0YG0ouCC3cJe2eUCwfhNlXEiwqJpUdZeT7fHPd/MtaPcRShFfZDzZMxv1vwf35knjO4CHUsc6JDagQlH1sFq8Toe2bk++dBn7wup//K/yOt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390998; c=relaxed/simple;
	bh=G8upNsRRZFGRuaLVZb3y1GWhWqr52/MyzluPmeFC6pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Nd1qUu38UokJwGgyqcwoYST4EG6+O2ic/Txhos1+Im7xnOUAFMXSkOl2d35TY6ry2W5uW7k3YFebgbIFV2L2/dn80YkwPGf75QX5LF6NK5AX9AMOiVxW0WjECwpFb2zdAszwmc4GmnBElVAQ6VdoLxhB0yih5ENBF3lJEniCYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dTFSjVDB; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240719120947euoutp02789f610c25a514b8d6fd394b0310e67e~jm-uj8ezv2292422924euoutp02n
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240719120947euoutp02789f610c25a514b8d6fd394b0310e67e~jm-uj8ezv2292422924euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721390987;
	bh=Nh0TJi293rn5IE+Jt9huGdfdtzwSXb2zQOIamLrmk2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTFSjVDBxEyDh/GBYfJeLYtNJ6zpmgZMXKKR8wqjM5F+OvzvupoGgy5xZ+jGp4Hbd
	 V3W1mJ/NTm+OO8pkaHpfIXcZirRnLzRw6+j3+/G23rG3FFtQrKDmu4plok6cpsJGvU
	 8w/9mxP9+F5RhC3T4jdeGQUUtVfxjnAAwDUGYGX8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240719120947eucas1p16f286d7036064242cc2ea94cbc05d937~jm-uJIicr0450904509eucas1p1k;
	Fri, 19 Jul 2024 12:09:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id FC.81.09620.B875A966; Fri, 19
	Jul 2024 13:09:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120946eucas1p1b565fa653d33aa2155cd3bb172c29d14~jm-tmLTgg2864628646eucas1p1t;
	Fri, 19 Jul 2024 12:09:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240719120946eusmtrp1697650eb63aa7cd3aebc2f0da878cab9~jm-tlZkNU0596405964eusmtrp1c;
	Fri, 19 Jul 2024 12:09:46 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-ff-669a578bb623
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id DC.85.08810.A875A966; Fri, 19
	Jul 2024 13:09:46 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120945eusmtip145c6651961e7d2ceefbd4e3d1488fd0d~jm-s0M3tT0493704937eusmtip1f;
	Fri, 19 Jul 2024 12:09:45 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>
Subject: [PATCH 3/6] drivers/thermal/exynos: check IS_ERR(data->clk)
 consistently
Date: Fri, 19 Jul 2024 14:08:47 +0200
Message-ID: <20240719120853.1924771-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240719120853.1924771-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87rd4bPSDH7MZrZ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oLpuU1JzMstQifbsErowd37ezFrRrVLw7tpepgXGlYhcjJ4eEgInExQ9bWEBsIYEV
	jBKLJgt2MXIB2V8YJdZ2bGGHcD4zSlz6vY0JpuPwrJdMEInljBK9i5ZDVbUySUxp2gw2i03A
	QOLBm2VgCRGBxYwSjT/esYI4zAKTmCUOrlnIClIlLBAscefGZnYQm0VAVWLT1iawOK+AncSy
	RUtYIfbJS/Tu7wPbzSlgL/G76S0bRI2gxMmZT8C2MQPVNG+dzQyyQEKgm1Pi3ocdjBDNLhLv
	VnyAOlxY4tXxLewQtozE6ck9LBB2vsSMze+BbA4gu0Li7kEvCNNa4uMZZhCTWUBTYv0ufYio
	o8Se+WkQJp/EjbeCEPv5JCZtm84MEeaV6GgTgpisKnF8zyRmCFta4knLbahLPCS6e1ezTWBU
	nIXkk1lIPpmFsHYBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwIR2+t/xrzsYV7z6
	qHeIkYmD8RCjBAezkgiv37eZaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5VVPkU4UE0hNLUrNT
	UwtSi2CyTBycUg1MwVsYP8/mDl/QyT2nXVty46u/L1Ssv3696cc51y7t6K9/yptmFucENYhO
	3C7iE/HnutQqpdjlk1XOWKtztpopaP/4fuHbkx2PtDa9dPP03uzD5MjMVybkbBzYoX0zys73
	QpLCiqCqoHf7j/NapfDaJbws7z66XCGi8nCj6D/HgEu+PpmGd/TWh0wSzkv1urTtuM2v3y3v
	OeNtKnKeXWtb+kZoCf/O8/MTvH4/LEuY9aPk7eJ0U6FtBg2sd2tPnd6z2ZbxdDGf2+p8Hn/z
	3Wzb5Rksl0zZPadtXb+vpb9k/JQbN9XsAmUzeB4om3LXeu7Ub+bl1Z2etMHPfp/crTobHaZ1
	vKdk1xy9O+GkeZQSS3FGoqEWc1FxIgALoENd1wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7pd4bPSDF4/VLJ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
	vYwd37ezFrRrVLw7tpepgXGlYhcjJ4eEgInE4VkvmboYuTiEBJYySkw7eZkdIiEtcfjLFChb
	WOLPtS42iKJmJon351+ygiTYBAwkHrxZBlYkIrCcUWJzuwdIEbPALGaJ3lNTGUESwgKBEucO
	7QBrYBFQldi0tQnM5hWwk1i2aAkrxAZ5id79fUwgNqeAvcTvprdsILYQUM3Oj/PYIOoFJU7O
	fMICYjMD1Tdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjcNux
	n5t3MM579VHvECMTB+MhRgkOZiURXr9vM9OEeFMSK6tSi/Lji0pzUosPMZoC3T2RWUo0OR+Y
	AvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiMGe7Nv2P7cMuB
	dQpvz3TUfFjppq8qm8d4OGPp0hlP9y6eH6xgkPwyTX73Od8ktcS/1ecSv/fP/Hb8eEzWrj1/
	OQwmWqxMdvZ/Onu1wqc9ZbfnPJP+4La8LMU/P3ql3TQnebcXmeu1ClZ5mz8qNF3NaXoibyP3
	b3+BK7sepjnm3D1otHFX0u9tS3l6Fl3+99Bu0kJx4eXy+isE3r/fv5jLpeVIs1Lzp2P3W7fO
	8Xondqa5/GZR60ShTy3+lxlkO/KXKXGuDG+vmnN0wgQDkyVsrXWLHWPO9i6tnrVQvsl8ufWJ
	D5OrFUpq2bPO8XPn3GpVDE6u3ajw/v38a+br56qVai55M5vTmCE9ZMmlSVoCSizFGYmGWsxF
	xYkAJeWFB0kDAAA=
X-CMS-MailID: 20240719120946eucas1p1b565fa653d33aa2155cd3bb172c29d14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240719120946eucas1p1b565fa653d33aa2155cd3bb172c29d14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240719120946eucas1p1b565fa653d33aa2155cd3bb172c29d14
References: <20240719120853.1924771-1-m.majewski2@samsung.com>
	<CGME20240719120946eucas1p1b565fa653d33aa2155cd3bb172c29d14@eucas1p1.samsung.com>

This will be needed for Exynos 850 support, which does not require this
clock.

It would also be possible to set data->clk to NULL instead, but doing it
like this is consistent with what we do with data->clk_sec.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 58 ++++++++++++++++++----------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 61606a9b9a00..f0de72a62fd7 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -257,7 +257,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	int ret = 0;
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_enable(data->clk);
 	if (!IS_ERR(data->clk_sec))
 		clk_enable(data->clk_sec);
 
@@ -271,7 +272,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
-	clk_disable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
 	return ret;
@@ -295,11 +297,13 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
 	}
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_enable(data->clk);
 
 	data->tmu_set_crit_temp(data, temp / MCELSIUS);
 
-	clk_disable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
 	return 0;
@@ -328,10 +332,12 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_enable(data->clk);
 	data->tmu_control(pdev, on);
 	data->enabled = on;
-	clk_disable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 }
 
@@ -648,7 +654,8 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 		return -EAGAIN;
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_enable(data->clk);
 
 	value = data->tmu_read(data);
 	if (value < 0)
@@ -656,7 +663,8 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 	else
 		*temp = code_to_temp(data, value) * MCELSIUS;
 
-	clk_disable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
 	return ret;
@@ -723,9 +731,11 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
 		goto out;
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_enable(data->clk);
 	data->tmu_set_emulation(data, temp);
-	clk_disable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 	return 0;
 out:
@@ -763,12 +773,14 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_enable(data->clk);
 
 	/* TODO: take action based on particular interrupt */
 	data->tmu_clear_irqs(data);
 
-	clk_disable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
 	return IRQ_HANDLED;
@@ -979,7 +991,8 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
 	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
 
 	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_enable(data->clk);
 
 	if (low > INT_MIN)
 		data->tmu_set_low_temp(data, low / MCELSIUS);
@@ -990,7 +1003,8 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
 	else
 		data->tmu_disable_high(data);
 
-	clk_disable(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
 	return 0;
@@ -1053,10 +1067,12 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = clk_prepare(data->clk);
-	if (ret) {
-		dev_err(dev, "Failed to get clock\n");
-		goto err_clk_sec;
+	if (!IS_ERR(data->clk)) {
+		ret = clk_prepare(data->clk);
+		if (ret) {
+			dev_err(dev, "Failed to get clock\n");
+			goto err_clk_sec;
+		}
 	}
 
 	switch (data->soc) {
@@ -1113,7 +1129,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_sclk:
 	clk_disable_unprepare(data->sclk);
 err_clk:
-	clk_unprepare(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_unprepare(data->clk);
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
@@ -1127,7 +1144,8 @@ static void exynos_tmu_remove(struct platform_device *pdev)
 	exynos_tmu_control(pdev, false);
 
 	clk_disable_unprepare(data->sclk);
-	clk_unprepare(data->clk);
+	if (!IS_ERR(data->clk))
+		clk_unprepare(data->clk);
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
 }
-- 
2.45.1


