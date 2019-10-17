Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5980DAC77
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfJQMlR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:41:17 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52671 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfJQMlR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 08:41:17 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 04BEA6000D;
        Thu, 17 Oct 2019 12:41:14 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH] power: reset: at91-reset: add sysfs interface to the power on reason
Date:   Thu, 17 Oct 2019 14:40:58 +0200
Message-Id: <20191017124058.19300-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch export the power on reason through the sysfs interface and
introduce some generic reset sources.
Update the ABI documentation to list current power on sources.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 .../sysfs-devices-platform-power-on-reason    | 14 ++++++
 drivers/power/reset/at91-reset.c              | 44 +++++++++++++------
 include/linux/power/power_on_reason.h         | 19 ++++++++
 3 files changed, 64 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-power-on-reason
 create mode 100644 include/linux/power/power_on_reason.h

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-power-on-reason b/Documentation/ABI/testing/sysfs-devices-platform-power-on-reason
new file mode 100644
index 000000000000..83daeb9b1aa2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-power-on-reason
@@ -0,0 +1,14 @@
+What:		/sys/devices/platform/.../power_on_reason
+
+Date:		October 2019
+KernelVersion:	5.4
+Contact:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+Description:	This file shows system power on reason.
+		The possible sources are:
+		General System Power-ON, RTC wakeup, Watchdog timeout,
+		Software Reset, User pressed reset button,
+		CPU Clock failure, 32.768kHz Oscillator Failure,
+		Low power mode exit, Unknown.
+
+		The file is read only.
+
diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 44ca983a49a1..3cb2df40af37 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -17,7 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
-
+#include <linux/power/power_on_reason.h>
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>

@@ -146,42 +146,42 @@ static int samx7_restart(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }

-static void __init at91_reset_status(struct platform_device *pdev)
+static const char *at91_reset_reason(struct platform_device *pdev)
 {
 	const char *reason;
 	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);

 	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
 	case RESET_TYPE_GENERAL:
-		reason = "general reset";
+		reason = POWER_ON_REASON_GENERAL;
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
+		reason = POWER_ON_REASON_USER;
 		break;
 	case RESET_TYPE_CPU_FAIL:
-		reason = "CPU clock failure detection";
+		reason = POWER_ON_REASON_CPU_FAIL;
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

-	dev_info(&pdev->dev, "Starting after %s\n", reason);
+	return reason;
 }

 static const struct of_device_id at91_ramc_of_match[] = {
@@ -204,6 +204,17 @@ static struct notifier_block at91_restart_nb = {
 	.priority = 192,
 };

+static ssize_t power_on_reason_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	return sprintf(buf, "%s\n", at91_reset_reason(pdev));
+}
+
+static DEVICE_ATTR_RO(power_on_reason);
+
 static int __init at91_reset_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -248,7 +259,14 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 		return ret;
 	}

-	at91_reset_status(pdev);
+	ret = device_create_file(&pdev->dev, &dev_attr_power_on_reason);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not create sysfs entry\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "Starting after %s reset\n",
+		 at91_reset_reason(pdev));

 	return 0;
 }
diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
new file mode 100644
index 000000000000..9978cc757427
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
+#define POWER_ON_REASON_GENERAL "General"
+#define POWER_ON_REASON_RTC "RTC wakeup"
+#define POWER_ON_REASON_WATCHDOG "Watchdog timeout"
+#define POWER_ON_REASON_SOFTWARE "Software"
+#define POWER_ON_REASON_USER "User"
+#define POWER_ON_REASON_CPU_FAIL "CPU Clock Failure"
+#define POWER_ON_REASON_XTAL_FAIL "32.768k Crystal oscillator Failure"
+#define POWER_ON_REASON_LOW_POWER "Low power exit"
+#define POWER_ON_REASON_UNKNOWN "Unknown"
+
+#endif /* POWER_ON_REASON_H */
--
2.23.0

