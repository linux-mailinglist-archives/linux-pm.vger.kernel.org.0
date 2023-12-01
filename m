Return-Path: <linux-pm+bounces-597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFDA8007A5
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 10:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69A6281A6C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 09:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7420309;
	Fri,  1 Dec 2023 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K3HjacCi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670910D7
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 01:56:47 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231201095643euoutp01393bc63554c732edee9fa7e577720176~crKmtA3Cz3266132661euoutp01s
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 09:56:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231201095643euoutp01393bc63554c732edee9fa7e577720176~crKmtA3Cz3266132661euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701424604;
	bh=z+drqHSTXutvqyghqqSngnAvaJMAvU0O0c1Ke0HntPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3HjacCitpbsvAAArshg5c4PSE7wFI7byH4NgQMIp/wHpp3stCE6RPypJpEqe0JiW
	 vXixjGjf3o/v9S5+LtskZXXaEGm+u8NfBzfxDxYwRBbDhw135lOWZ8h/mtmlphNb/R
	 RAxgi6IxMobMRSpfabJiSxHN+0EhYTiGnImaHy/Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231201095643eucas1p248111e49847cdb4b7ffd5e7933f55425~crKmTenTx2503225032eucas1p2K;
	Fri,  1 Dec 2023 09:56:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id C4.FF.09552.BDDA9656; Fri,  1
	Dec 2023 09:56:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2~crKlwCaxA0245502455eucas1p1G;
	Fri,  1 Dec 2023 09:56:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231201095642eusmtrp1f90b9537441ea0e19c34183c6f809ffa~crKlvZNCU0736407364eusmtrp15;
	Fri,  1 Dec 2023 09:56:42 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-83-6569addba546
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 66.20.09146.ADDA9656; Fri,  1
	Dec 2023 09:56:42 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231201095641eusmtip2eb358f372ab5769c2c5640d3ac5e896a~crKk2NVYP1302313023eusmtip2T;
	Fri,  1 Dec 2023 09:56:41 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui
	<rui.zhang@intel.com>, Alim Akhtar <alim.akhtar@samsung.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Lukasz Luba <lukasz.luba@arm.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: [PATCH v6 3/9] thermal: exynos: switch from workqueue-driven
 interrupt handling to threaded interrupts
Date: Fri,  1 Dec 2023 10:56:19 +0100
Message-ID: <20231201095625.301884-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201095625.301884-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djPc7q312amGvzaJWXxYN42NovD8yss
	pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
	1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
	85J6j74tqxg9Pm+SC+CI4rJJSc3JLEst0rdL4Mr4NOk4U8EeyYrJz56wNTBOEu1i5OSQEDCR
	2NP4namLkYtDSGAFo8TEK21QzhdGiY2NT1kgnM+MEjN39THDtEz9OQuqajmjRPv+8+wQTiuT
	RMPch4wgVWwCBhIP3ixjB7FFBFqB2pvUQWxmgYUsEi3/ckFsYYFCiffvl4JNZRFQlejrmcwC
	YvMK2EpM/HaIFWKbvMSeRSAHcnJwCthJzD/UClUjKHFy5hMWiJnyEs1bZzODHCEhMJ1T4u+0
	1WwQzS4SJ28cZ4SwhSVeHd/CDmHLSJye3MMCYedLzNj8HsjmALIrJO4e9IIwrSU+nmEGMZkF
	NCXW79KHKHaUmHinhwmigk/ixltBiAP4JCZtm84MEeaV6GgTgqhWlTi+ZxI01KQlnrTcZoKw
	PSSmrTjHMoFRcRaSV2YheWUWwt4FjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAlPc
	6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK815+mpwrxpiRWVqUW5ccXleakFh9ilOZgURLnVU2R
	TxUSSE8sSc1OTS1ILYLJMnFwSjUwmU1IdFua+lWi57/lvPtKPyU5dG5kXPb8UevhEZTArjnh
	7zyxWuEn6R93bJ8wNWTipEMJhx6wzJ82a1aThI2nk+HL2ewlrR07F076Fs1d8Lvyz7IkrRM9
	aQlWqvlfr+YwybPc9WAxy0vzvN/HOHm+546TJQ9u7IsIrmA9sONKdHvvrtAvh+bP2mbulBB1
	ZaKMuWqdVslieX97Efdtxp7mrzPm/P+nlCZj4DpFevv3/tf+ry55X2S2Ocisoa0+JcrqI9+z
	/+rrtkkK7vjqPEUxN49Z/j+/1JaugzN/X7d/G62gE7/+fuesBzqqsmr88qlMPRfci++Izqy8
	p7mlrsPw8es5upPOXnL1yzw1i+u1EktxRqKhFnNRcSIALBCMB+ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7q31mamGkxfZWbxYN42NovD8yss
	pj58wmbxfct1JosP81rZLeZ9lrXY+3oru8W3Kx1MFpseX2O1uLxrDpvF594jjBYzzu9jsljY
	1MJuMfHYZGaLtUfuslvM/TKV2eLJwz42B0GPNfPWMHrsnHWX3WPxnpdMHptWdbJ53Lm2h81j
	85J6j74tqxg9Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
	Sc3JLEst0rdL0Mv4NOk4U8EeyYrJz56wNTBOEu1i5OSQEDCRmPpzFlMXIxeHkMBSRonFZ/ey
	QCSkJQ5/mcIOYQtL/LnWxQZR1MwkMWHhUbAEm4CBxIM3y9hBEiICnYwSXZvPgY1iFljNInFs
	33cmkCphgXyJO1va2UBsFgFVib6eyWAreAVsJSZ+O8QKsUJeYs8iiHpOATuJ+YdawWqEgGq6
	tvxnhKgXlDg58wlYnBmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpec
	n7uJERiV24793LyDcd6rj3qHGJk4GA8xSnAwK4nwXn+anirEm5JYWZValB9fVJqTWnyI0RTo
	7onMUqLJ+cC0kFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwFRg
	4Sf8/3H7o0o5xaaDoYUV9xdIv9yb+cf+27srx2o/frl1dUb8/rv7Kz8/PVOZVvT2tG9T+HoB
	YZWjejPKJ/ExiL6VqPY/vDZ1d0jv28fSu7WjZJp+5r5l2l4XtjhzEZsr8/XOvVt8IljfbJTP
	WFqj3fPs1KsPxo1f1NW43QXCal/+mPHigYXx7mWFD8z/WUycemulWd32KXdDOmS3zBd0aprB
	8X59xaGj1bK7OFi23NJ2fpt8ct6ZAxu/W346+m+1TrjUhWwr+4Cqzg3LjvyeVnnvUfjCk4I5
	rIe/3pzMp71SoWtWbEn7uvYClnXiB/kKojgeKa3I5HTi+CHBqHMmLVXL/s+F5A1qU7aHLzFS
	YinOSDTUYi4qTgQAK7MZXlMDAAA=
X-CMS-MailID: 20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2
References: <20231201095625.301884-1-m.majewski2@samsung.com>
	<CGME20231201095642eucas1p13b5699805523f9afcf6d4034e1b838b2@eucas1p1.samsung.com>

The workqueue boilerplate is mostly one-to-one what the threaded
interrupts do.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: devm_request_threaded_irq call formatting change.

 drivers/thermal/samsung/exynos_tmu.c | 29 +++++++++-------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 4ff32245d2a9..c144592d4584 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -142,7 +142,6 @@ enum soc_type {
  * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
  * @soc: id of the SOC type.
- * @irq_work: pointer to the irq work structure.
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
  * @clk_sec: pointer to the clock structure for accessing the base_second.
@@ -175,7 +174,6 @@ struct exynos_tmu_data {
 	void __iomem *base_second;
 	int irq;
 	enum soc_type soc;
-	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
 	u32 cal_type;
@@ -763,10 +761,9 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
 		EXYNOS7_TMU_TEMP_MASK;
 }
 
-static void exynos_tmu_work(struct work_struct *work)
+static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
-	struct exynos_tmu_data *data = container_of(work,
-			struct exynos_tmu_data, irq_work);
+	struct exynos_tmu_data *data = id;
 
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
@@ -778,7 +775,8 @@ static void exynos_tmu_work(struct work_struct *work)
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-	enable_irq(data->irq);
+
+	return IRQ_HANDLED;
 }
 
 static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
@@ -812,16 +810,6 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	writel(val_irq, data->base + tmu_intclear);
 }
 
-static irqreturn_t exynos_tmu_irq(int irq, void *id)
-{
-	struct exynos_tmu_data *data = id;
-
-	disable_irq_nosync(irq);
-	schedule_work(&data->irq_work);
-
-	return IRQ_HANDLED;
-}
-
 static const struct of_device_id exynos_tmu_match[] = {
 	{
 		.compatible = "samsung,exynos3250-tmu",
@@ -1023,8 +1011,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sensor;
 
-	INIT_WORK(&data->irq_work, exynos_tmu_work);
-
 	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
@@ -1093,8 +1079,11 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
-		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
+	ret = devm_request_threaded_irq(&pdev->dev, data->irq, NULL,
+					exynos_tmu_threaded_irq,
+					IRQF_TRIGGER_RISING
+						| IRQF_SHARED | IRQF_ONESHOT,
+					dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
 		goto err_sclk;
-- 
2.42.0


