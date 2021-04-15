Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD93608CB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhDOMEZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 08:04:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbhDOMEX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 08:04:23 -0400
Date:   Thu, 15 Apr 2021 12:03:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618488238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCw9VXv+Ts+G/vKgBAnCmGvlYayfbPH5zdQ/cYSLOJI=;
        b=eSiScKXZaS9iAVypCGEOr1XyZWxTzBsVvXEWqVvDeNxsDTVgdZ5MGq5JlNucz9GupTVCpm
        FMsZ+kJESjPgbhZoFXNWrdiBb/9js1J3EoVjxBgcN7JNNp66K9Ii9+89ipstsFGVe4Hapc
        49D5VXfkox/nTAUSGva+CU8H+GQukfhyZLa1Iz8y7MUrSvM0OqHE2R32vjDs1WnP+Hi2jG
        wFruu5f5rVNfhsYfpf1ncwpE7Q5PeSnvYGPSBQyaE2SCGHM/ZPzsADgST1G4QJMgKrOyrb
        zgsS7So5VtFf4AeQpGNmKNDBOFMrQP/tr3pXCDikDyLUuHknW/keCmG05jrYnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618488238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCw9VXv+Ts+G/vKgBAnCmGvlYayfbPH5zdQ/cYSLOJI=;
        b=5jhMzKayMv7nL88gvg91lmOkigqkY+d6ge9p3jyfK72OQXWNfea3Kwz3cEiMwKEMKS4+RP
        0HiIM/vKBAMmx4Dw==
From:   "thermal-bot for Ansuel Smith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/tsens: Fix bug in sensor
 enable for msm8960
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210404144823.31867-6-ansuelsmth@gmail.com>
References: <20210404144823.31867-6-ansuelsmth@gmail.com>
MIME-Version: 1.0
Message-ID: <161848823790.29796.13208214932206882829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f1c6aa8f9cbd35f3119d915cd553020495d23f0e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f1c6aa8f9cbd35f3119d915cd553020495d23f0e
Author:        Ansuel Smith <ansuelsmth@gmail.com>
AuthorDate:    Sun, 04 Apr 2021 16:48:19 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 15 Apr 2021 13:21:43 +02:00

thermal/drivers/tsens: Fix bug in sensor enable for msm8960

Device based on tsens VER_0 contains a hardware bug that results in some
problem with sensor enablement. Sensor id 6-11 can't be enabled
selectively and all of them must be enabled in one step.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210404144823.31867-6-ansuelsmth@gmail.com
---
 drivers/thermal/qcom/tsens-8960.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 86585f4..95fccca 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -27,9 +27,9 @@
 #define EN			BIT(0)
 #define SW_RST			BIT(1)
 #define SENSOR0_EN		BIT(3)
+#define MEASURE_PERIOD		BIT(18)
 #define SLP_CLK_ENA		BIT(26)
 #define SLP_CLK_ENA_8660	BIT(24)
-#define MEASURE_PERIOD		1
 #define SENSOR0_SHIFT		3
 
 /* INT_STATUS_ADDR bitmasks */
@@ -126,17 +126,34 @@ static int resume_8960(struct tsens_priv *priv)
 static int enable_8960(struct tsens_priv *priv, int id)
 {
 	int ret;
-	u32 reg, mask;
+	u32 reg, mask = BIT(id);
 
 	ret = regmap_read(priv->tm_map, CNTL_ADDR, &reg);
 	if (ret)
 		return ret;
 
-	mask = BIT(id + SENSOR0_SHIFT);
+	/* HARDWARE BUG:
+	 * On platforms with more than 6 sensors, all remaining sensors
+	 * must be enabled together, otherwise undefined results are expected.
+	 * (Sensor 6-7 disabled, Sensor 3 disabled...) In the original driver,
+	 * all the sensors are enabled in one step hence this bug is not
+	 * triggered.
+	 */
+	if (id > 5)
+		mask = GENMASK(10, 6);
+
+	mask <<= SENSOR0_SHIFT;
+
+	/* Sensors already enabled. Skip. */
+	if ((reg & mask) == mask)
+		return 0;
+
 	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg | SW_RST);
 	if (ret)
 		return ret;
 
+	reg |= MEASURE_PERIOD;
+
 	if (priv->num_sensors > 1)
 		reg |= mask | SLP_CLK_ENA | EN;
 	else
