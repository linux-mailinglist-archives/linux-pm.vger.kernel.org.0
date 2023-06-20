Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0602736395
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jun 2023 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFTG1C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jun 2023 02:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTG1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2023 02:27:02 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93B81A5
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 23:27:00 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687242419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7pl6qCNBQeotbXsdQRYataHay2+MrATT6vr5AKa1Xc8=;
        b=n0DLBu/0zLrq8qT4ZF0wn6HAIyqtn4wQMCPiYIDg+qNZcEkLArU7QPCOWAcUrxng5u+k8e
        0DsaH6TPnKLn9WqeNxmG+UEBNsID/fpHmRgGX1fdPX2n2PzXTs+C9l3BiZs5b5tifWyv9i
        KYyFVqVMNd2GLPWMB3BW+3swrHAnx/3eWdst7C5nFZnAsGag6bpLDXVAd80W3Z/GO6zVqj
        gWOIvkxXdvUWpczm0oo3epTKFCWpnXk18lJ+nDx/q+FTZCSXMsyIO4E9zxJB4KdsP5t11J
        qZip9iV/yQ/NkOiPNCZlWXcsyn/HnQDiW+MPEvpmKnFVRjQoOwBqAzEsvUAQsg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FD6D40007;
        Tue, 20 Jun 2023 06:26:58 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, <linux-arm-kernel@lists.infradead.org>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4] power: reset: at91-reset: add sysfs interface to the power on reason
Date:   Tue, 20 Jun 2023 08:26:57 +0200
Message-Id: <20230620062657.3127468-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
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

Changes in v4:
* Patch 1/2 was merged.
* Changed the "low-power condition" into a "brown-out reset" as
  suggested by Sebastian.

Changes in v3:
* Made the series bisectable.
* Updated the date and kernel version for this new feature.
* Changed a few definitions as discussed with Sebastian.

Changes in v2:
* Collected Nicolas' Acked-by
* Dropped the Xtal frequency information (as this may change between
  platforms of course).

 .../testing/sysfs-platform-power-on-reason    | 12 ++++++
 drivers/power/reset/at91-reset.c              | 37 ++++++++++++++-----
 include/linux/power/power_on_reason.h         | 19 ++++++++++
 3 files changed, 58 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-reason
 create mode 100644 include/linux/power/power_on_reason.h

diff --git a/Documentation/ABI/testing/sysfs-platform-power-on-reason b/Documentation/ABI/testing/sysfs-platform-power-on-reason
new file mode 100644
index 000000000000..c3b29dbc64bf
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
+		"crystal oscillator failure", "brown-out reset",
+		"unknown reason".
+
+		The file is read only.
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index d6884841a6dc..aa9b012d3d00 100644
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
+		reason = POWER_ON_REASON_BROWN_OUT;
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
index 000000000000..95a1ec0c403c
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
+#define POWER_ON_REASON_BROWN_OUT "brown-out reset"
+#define POWER_ON_REASON_UNKNOWN "unknown reason"
+
+#endif /* POWER_ON_REASON_H */
-- 
2.34.1

