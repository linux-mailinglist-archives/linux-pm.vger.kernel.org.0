Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC84218551
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 12:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgGHKzd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 06:55:33 -0400
Received: from vps.xff.cz ([195.181.215.36]:48804 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGHKzd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 06:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594205730; bh=FjQWXkffSauLT4RFe7L3pGAJhRaFdql4N1eA12iukYs=;
        h=From:To:Cc:Subject:Date:From;
        b=oKv3I7KcWEuiP1EnF+jHL6RAcGQpwZunw9eUecnt8AIhsN144n1mEN+RCAJ+9nq9Q
         OZJVWzRO12OVKWem8iC/PNSZ+f1Z/B0KsanEZ8+Y2JvYCrotI1vtwuwemuySTUlMwG
         7qnBmmLwsu9O1SsKNdx1ikc/RupzsSRITxr4gQOE=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org (open list:ALLWINNER THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: sun8i: Be loud when probe fails
Date:   Wed,  8 Jul 2020 12:55:27 +0200
Message-Id: <20200708105527.868987-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I noticed several mobile Linux distributions failing to enable the
thermal regulation correctly, because the kernel is silent
when thermal driver fails to probe. Add enough error reporting
to debug issues and warn users in case thermal sensor is failing
to probe.

Failing to notify users means, that SoC can easily overheat under
load.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 74d73be16496..9065e79ae743 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 
 	calcell = devm_nvmem_cell_get(dev, "calibration");
 	if (IS_ERR(calcell)) {
+		dev_err(dev, "Failed to get calibration nvmem cell (%ld)\n",
+			PTR_ERR(calcell));
+
 		if (PTR_ERR(calcell) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
+
 		/*
 		 * Even if the external calibration data stored in sid is
 		 * not accessible, the THS hardware can still work, although
@@ -308,6 +312,8 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	caldata = nvmem_cell_read(calcell, &callen);
 	if (IS_ERR(caldata)) {
 		ret = PTR_ERR(caldata);
+		dev_err(dev, "Failed to read calibration data (%d)\n",
+			ret);
 		goto out;
 	}
 
@@ -330,23 +336,35 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		return PTR_ERR(base);
 
 	tmdev->regmap = devm_regmap_init_mmio(dev, base, &config);
-	if (IS_ERR(tmdev->regmap))
+	if (IS_ERR(tmdev->regmap)) {
+		dev_err(dev, "Failed to init regmap (%ld)\n",
+			PTR_ERR(tmdev->regmap));
 		return PTR_ERR(tmdev->regmap);
+	}
 
 	if (tmdev->chip->has_bus_clk_reset) {
 		tmdev->reset = devm_reset_control_get(dev, NULL);
-		if (IS_ERR(tmdev->reset))
+		if (IS_ERR(tmdev->reset)) {
+			dev_err(dev, "Failed to get reset (%ld)\n",
+				PTR_ERR(tmdev->reset));
 			return PTR_ERR(tmdev->reset);
+		}
 
 		tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
-		if (IS_ERR(tmdev->bus_clk))
+		if (IS_ERR(tmdev->bus_clk)) {
+			dev_err(dev, "Failed to get bus clock (%ld)\n",
+				PTR_ERR(tmdev->bus_clk));
 			return PTR_ERR(tmdev->bus_clk);
+		}
 	}
 
 	if (tmdev->chip->has_mod_clk) {
 		tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
-		if (IS_ERR(tmdev->mod_clk))
+		if (IS_ERR(tmdev->mod_clk)) {
+			dev_err(dev, "Failed to get mod clock (%ld)\n",
+				PTR_ERR(tmdev->mod_clk));
 			return PTR_ERR(tmdev->mod_clk);
+		}
 	}
 
 	ret = reset_control_deassert(tmdev->reset);
@@ -471,8 +489,12 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 							     i,
 							     &tmdev->sensor[i],
 							     &ths_ops);
-		if (IS_ERR(tmdev->sensor[i].tzd))
+		if (IS_ERR(tmdev->sensor[i].tzd)) {
+			dev_err(tmdev->dev,
+				"Failed to register sensor %d (%ld)\n",
+				i, PTR_ERR(tmdev->sensor[i].tzd));
 			return PTR_ERR(tmdev->sensor[i].tzd);
+		}
 
 		if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
 			dev_warn(tmdev->dev,
@@ -501,19 +523,21 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 
 	ret = sun8i_ths_resource_init(tmdev);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_out;
+	}
 
 	ret = tmdev->chip->init(tmdev);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	ret = sun8i_ths_register(tmdev);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	/*
 	 * Avoid entering the interrupt handler, the thermal device is not
@@ -523,10 +547,17 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					sun8i_irq_thread,
 					IRQF_ONESHOT, "ths", tmdev);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_err(dev, "Failed to request irq (%d)\n", ret);
+		goto err_out;
+	}
 
+	dev_info(dev, "Thermal sensor ready!\n");
 	return 0;
+
+err_out:
+	dev_err(dev, "Failed to probe thermal sensor (%d)\n", ret);
+	return ret;
 }
 
 static int sun8i_ths_remove(struct platform_device *pdev)
-- 
2.27.0

