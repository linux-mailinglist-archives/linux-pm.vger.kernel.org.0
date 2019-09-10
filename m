Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E60AE472
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406606AbfIJHOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 03:14:31 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:43488 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404344AbfIJHOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 03:14:31 -0400
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by new.mxwww.masterlogin.de (Postfix) with ESMTPS id 164869634E;
        Tue, 10 Sep 2019 07:05:16 +0000 (UTC)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.253])
        by mxout2.routing.net (Postfix) with ESMTP id 6672D6208B;
        Tue, 10 Sep 2019 07:05:16 +0000 (UTC)
Received: from localhost.localdomain (fttx-pool-185.75.73.135.bambit.de [185.75.73.135])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 68831100C2A;
        Tue, 10 Sep 2019 07:05:15 +0000 (UTC)
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        "Tianping Fang" <tianping.fang@mediatek.com>
Subject: [PATCH v7 3/7] rtc: mt6397: improvements of rtc driver
Date:   Tue, 10 Sep 2019 09:04:42 +0200
Message-Id: <20190910070446.639-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910070446.639-1-frank-w@public-files.de>
References: <20190910070446.639-1-frank-w@public-files.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

- use regmap_read_poll_timeout to drop while-loop
- use devm-api to drop remove-callback

Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
changes since v6: none
changes since v5: none
changes since v4: none
changes since v3: none
changes since v2:
- fix allocation after irq-request
- compatible for mt6323 in separate commit => part 5
---
 drivers/rtc/rtc-mt6397.c | 51 +++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index c08ee5edf865..9370b7fc9f81 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -4,16 +4,19 @@
 * Author: Tianping.Fang <tianping.fang@mediatek.com>
 */
 
-#include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/mfd/mt6397/rtc.h>
+#include <linux/mod_devicetable.h>
 
 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 {
-	unsigned long timeout = jiffies + HZ;
 	int ret;
 	u32 data;
 
@@ -21,19 +24,13 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 	if (ret < 0)
 		return ret;
 
-	while (1) {
-		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
-				  &data);
-		if (ret < 0)
-			break;
-		if (!(data & RTC_BBPU_CBUSY))
-			break;
-		if (time_after(jiffies, timeout)) {
-			ret = -ETIMEDOUT;
-			break;
-		}
-		cpu_relax();
-	}
+	ret = regmap_read_poll_timeout(rtc->regmap,
+					rtc->addr_base + RTC_BBPU, data,
+					!(data & RTC_BBPU_CBUSY),
+					MTK_RTC_POLL_DELAY_US,
+					MTK_RTC_POLL_TIMEOUT);
+	if (ret < 0)
+		dev_err(rtc->dev, "failed to write WRTGE: %d\n", ret);
 
 	return ret;
 }
@@ -266,19 +263,19 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 		return rtc->irq;
 
 	rtc->regmap = mt6397_chip->regmap;
-	rtc->dev = &pdev->dev;
 	mutex_init(&rtc->lock);
 
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->rtc_dev = devm_rtc_allocate_device(rtc->dev);
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
-	ret = request_threaded_irq(rtc->irq, NULL,
-				   mtk_rtc_irq_handler_thread,
-				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-				   "mt6397-rtc", rtc);
+	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
+					mtk_rtc_irq_handler_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					"mt6397-rtc", rtc);
+
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
@@ -302,15 +299,6 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_rtc_remove(struct platform_device *pdev)
-{
-	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
-
-	free_irq(rtc->irq, rtc);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int mt6397_rtc_suspend(struct device *dev)
 {
@@ -349,7 +337,6 @@ static struct platform_driver mtk_rtc_driver = {
 		.pm = &mt6397_pm_ops,
 	},
 	.probe	= mtk_rtc_probe,
-	.remove = mtk_rtc_remove,
 };
 
 module_platform_driver(mtk_rtc_driver);
-- 
2.17.1

