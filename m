Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE48B73328B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjFPNxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjFPNxC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 09:53:02 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C930E0
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 06:52:57 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686923576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8/g1/Mc++wAHGSDqJ3ioHDS6jCfK/N5G+E68j81znBA=;
        b=pWQoYCZ+uwxsZMqeD2FW4Zjuf2O9n96N70DXt14iEr9PqM1EvMdMHA98tpo4IJYY2+spNp
        DuIlYzqPi5FwAzXb3ER3RGXYnwPjFxWENDEKEvF+s142PdNUHTTRY1OwtoLO5RGF69dZ70
        4bbMxfa+b9bP4lRoRSznCY1Dm1sWLZ5gQuGHRzSijSxWx3uAwmQ2V4TjM2bNwMAjkYTdNb
        OR2IwG3dEogJUYjJxoDW8cRiY7egsRTqXairmq6rf4DNqvKsL9lgVk6K2upmjNzLQ0bXAQ
        bD9X78iesPaaDOcPOmUud7YLsPcVMltJNUCTjvBDu7DkvaHTki80VeE9dp5u/A==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEC0C4000C;
        Fri, 16 Jun 2023 13:52:55 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 2/2] power: reset: at91-reset: add sysfs interface to the power on reason
Date:   Fri, 16 Jun 2023 15:52:52 +0200
Message-Id: <20230616135252.2787679-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616135252.2787679-1-miquel.raynal@bootlin.com>
References: <20230616135252.2787679-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Introduce a list of generic reset sources and use them to export the
power on reason through sysfs. Update the ABI documentation to describe
this new interface.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[Miquel Raynal: Follow-up on Kamel's work, 4 years later]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../testing/sysfs-platform-power-on-reason    | 12 ++++++
 drivers/power/reset/at91-reset.c              | 37 ++++++++++++++-----
 include/linux/power/power_on_reason.h         | 19 ++++++++++
 3 files changed, 58 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-reason
 create mode 100644 include/linux/power/power_on_reason.h

diff --git a/Documentation/ABI/testing/sysfs-platform-power-on-reason b/Documentation/ABI/testing/sysfs-platform-power-on-reason
new file mode 100644
index 000000000000..060d6c43f192
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-power-on-reason
@@ -0,0 +1,12 @@
+What:		/sys/devices/platform/.../power_on_reason
+Date:		June 2023
+KernelVersion:	6.5
+Contact:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+Description:	Shows system power on reason. The following strings/reasons can
+		be read (the list can be extended):
+		"regular power-up", "RTC wakeup", "watchdog timeout",
+		"software reset", "reset button action", "CPU clock failure",
+		"crystal oscillator failure", "low-power condition",
+		"unknown reason".
+
+		The file is read only.
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index d6884841a6dc..e42c0aa18966 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/reset-controller.h>
+#include <linux/power/power_on_reason.h>
 
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
@@ -149,44 +150,54 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
-static const char * __init at91_reset_reason(struct at91_reset *reset)
+static const char *at91_reset_reason(struct at91_reset *reset)
 {
 	u32 reg = readl(reset->rstc_base + AT91_RSTC_SR);
 	const char *reason;
 
 	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
 	case RESET_TYPE_GENERAL:
-		reason = "general reset";
+		reason = POWER_ON_REASON_REGULAR;
 		break;
 	case RESET_TYPE_WAKEUP:
-		reason = "wakeup";
+		reason = POWER_ON_REASON_RTC;
 		break;
 	case RESET_TYPE_WATCHDOG:
-		reason = "watchdog reset";
+		reason = POWER_ON_REASON_WATCHDOG;
 		break;
 	case RESET_TYPE_SOFTWARE:
-		reason = "software reset";
+		reason = POWER_ON_REASON_SOFTWARE;
 		break;
 	case RESET_TYPE_USER:
-		reason = "user reset";
+		reason = POWER_ON_REASON_RST_BTN;
 		break;
 	case RESET_TYPE_CPU_FAIL:
-		reason = "CPU clock failure detection";
+		reason = POWER_ON_REASON_CPU_CLK_FAIL;
 		break;
 	case RESET_TYPE_XTAL_FAIL:
-		reason = "32.768 kHz crystal failure detection";
+		reason = POWER_ON_REASON_XTAL_FAIL;
 		break;
 	case RESET_TYPE_ULP2:
-		reason = "ULP2 reset";
+		reason = POWER_ON_REASON_LOW_POWER;
 		break;
 	default:
-		reason = "unknown reset";
+		reason = POWER_ON_REASON_UNKNOWN;
 		break;
 	}
 
 	return reason;
 }
 
+static ssize_t power_on_reason_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct at91_reset *reset = platform_get_drvdata(pdev);
+
+	return sprintf(buf, "%s\n", at91_reset_reason(reset));
+}
+static DEVICE_ATTR_RO(power_on_reason);
+
 static const struct of_device_id at91_ramc_of_match[] = {
 	{
 		.compatible = "atmel,at91sam9260-sdramc",
@@ -391,6 +402,12 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
 
+	ret = device_create_file(&pdev->dev, &dev_attr_power_on_reason);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not create sysfs entry\n");
+		return ret;
+	}
+
 	dev_info(&pdev->dev, "Starting after %s\n", at91_reset_reason(reset));
 
 	return 0;
diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
new file mode 100644
index 000000000000..a59d035f1a77
--- /dev/null
+++ b/include/linux/power/power_on_reason.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Author: Kamel Bouhra <kamel.bouhara@bootlin.com>
+ */
+
+#ifndef POWER_ON_REASON_H
+#define POWER_ON_REASON_H
+
+#define POWER_ON_REASON_REGULAR "regular power-up"
+#define POWER_ON_REASON_RTC "RTC wakeup"
+#define POWER_ON_REASON_WATCHDOG "watchdog timeout"
+#define POWER_ON_REASON_SOFTWARE "software reset"
+#define POWER_ON_REASON_RST_BTN "reset button action"
+#define POWER_ON_REASON_CPU_CLK_FAIL "CPU clock failure"
+#define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
+#define POWER_ON_REASON_LOW_POWER "low-power condition"
+#define POWER_ON_REASON_UNKNOWN "unknown reason"
+
+#endif /* POWER_ON_REASON_H */
-- 
2.34.1

