Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0438331F130
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBRUlv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhBRUkY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E516BC061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:39:43 -0800 (PST)
Date:   Thu, 18 Feb 2021 20:39:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YbnYxrVRA87c8ujCov1Q3Q910IxjptEboQBlSbF/iJM=;
        b=TsvaY0qEfH5j59joyZhHmJ4lBbsMompxt62fBZps3ZM/w71JeROfG3Bmj/y3O1nC98OAIc
        mTSKuRWYfdUHUrywEyXdfHrtFUOV1KGmsXXfWqv8RkNKWtaD0b1HREPTWm/UNHKnsLy7RF
        vgrzogPK8+6erIoq8NCnKBhGEP6rgF3HbMOwS0OJTqpqaabU0DFYIYYd8jEVhyTwmYuprK
        fjNsTqEqiaTF4LiUP3cC/jb+jXkG03Dd+lQqUjxb6IfwzSYbcr1FvyL7HFb6hw5vGK0V4M
        ri+Rd7YRwNhbs/SPOFEm+2W4sUMi2BJydi/b6goNpj8ux+P1CQ7SXV0lPRyuWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YbnYxrVRA87c8ujCov1Q3Q910IxjptEboQBlSbF/iJM=;
        b=lJIvjv3+EmZIGTEOfWLuBLGVy5XnfLMkdgLcDFAGSrwX96e8eN1bzuqlI/q6UhPqv+mu7z
        JIrnHI/TwJ/DEzDg==
From:   "thermal-bot for Tony Lindgren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: ti-soc-thermal: Use non-inverted
 define for omap4
Cc:     Adam Ford <aford173@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Eduardo Valentin <edubezval@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210205134534.49200-5-tony@atomide.com>
References: <20210205134534.49200-5-tony@atomide.com>
MIME-Version: 1.0
Message-ID: <161368078142.20312.12715367795685959954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     c13636babc80db2092ec1c2fc4167ea6f62cd80e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c13636babc80db2092ec1c2fc4167ea6f62cd80e
Author:        Tony Lindgren <tony@atomide.com>
AuthorDate:    Fri, 05 Feb 2021 15:45:34 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 15 Feb 2021 21:19:32 +01:00

thermal: ti-soc-thermal: Use non-inverted define for omap4

When we set bit 10 high we use continuous mode and not single
mode. Let's correct this to avoid confusion. No functional
changes here, the code does the right thing with bit 10.

Cc: Adam Ford <aford173@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Adam Ford <aford173@gmail.com> #logicpd-torpedo-37xx-devkit
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210205134534.49200-5-tony@atomide.com
---
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c | 4 ++--
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index 80c051a..b4ef734 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -24,7 +24,7 @@ omap4430_mpu_temp_sensor_registers = {
 	.bgap_dtemp_mask = OMAP4430_BGAP_TEMP_SENSOR_DTEMP_MASK,
 
 	.bgap_mode_ctrl = OMAP4430_TEMP_SENSOR_CTRL_OFFSET,
-	.mode_ctrl_mask = OMAP4430_SINGLE_MODE_MASK,
+	.mode_ctrl_mask = OMAP4430_CONTINUOUS_MODE_MASK,
 
 	.bgap_efuse = OMAP4430_FUSE_OPP_BGAP,
 };
@@ -97,7 +97,7 @@ omap4460_mpu_temp_sensor_registers = {
 	.mask_cold_mask = OMAP4460_MASK_COLD_MASK,
 
 	.bgap_mode_ctrl = OMAP4460_BGAP_CTRL_OFFSET,
-	.mode_ctrl_mask = OMAP4460_SINGLE_MODE_MASK,
+	.mode_ctrl_mask = OMAP4460_CONTINUOUS_MODE_MASK,
 
 	.bgap_counter = OMAP4460_BGAP_COUNTER_OFFSET,
 	.counter_mask = OMAP4460_COUNTER_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
index 9a3955c..c63f439 100644
--- a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
@@ -40,7 +40,7 @@
 /* OMAP4430.TEMP_SENSOR bits */
 #define OMAP4430_BGAP_TEMPSOFF_MASK			BIT(12)
 #define OMAP4430_BGAP_TSHUT_MASK			BIT(11)
-#define OMAP4430_SINGLE_MODE_MASK			BIT(10)
+#define OMAP4430_CONTINUOUS_MODE_MASK			BIT(10)
 #define OMAP4430_BGAP_TEMP_SENSOR_SOC_MASK		BIT(9)
 #define OMAP4430_BGAP_TEMP_SENSOR_EOCZ_MASK		BIT(8)
 #define OMAP4430_BGAP_TEMP_SENSOR_DTEMP_MASK		(0xff << 0)
@@ -113,7 +113,7 @@
 #define OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK		(0x3ff << 0)
 
 /* OMAP4460.BANDGAP_CTRL bits */
-#define OMAP4460_SINGLE_MODE_MASK			BIT(31)
+#define OMAP4460_CONTINUOUS_MODE_MASK			BIT(31)
 #define OMAP4460_MASK_HOT_MASK				BIT(1)
 #define OMAP4460_MASK_COLD_MASK				BIT(0)
 
