Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FEA2D4C83
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 22:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbgLIVHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 16:07:09 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:8830 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgLIVG7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 16:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607547839;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:
        Subject:Sender;
        bh=OiI0XH3fNnsW/IR1c687ZRZ5XK36eBaoH252ZMMTpCs=;
        b=czsrSZYOHBhKK+eegrXRxBd/TpTrTLyy/r7xfZJ0QrVZFrUN52CUD2FYU9pcOeP6GT
        EkGnZfVDR8shoxT3NgpRmq490vw6s/KPTSnxthD4EDL5wp8LzNbuewKiS9XZbmB2jZoB
        3Jj0AqYmbUbxje6kExe5oN6xWQqOCQ6K0UlU+ZHSsvRNFPuhpuQUl31EaPFLLNaTx6CO
        VA6EA0xjdNeX41RKsNTd/i0WLAfCf1/p6f/1w9INvMM3e225/us/8GLahgEJEq2aCRaP
        0bEyMfbfpEY6CKGnpaPJqsGVi1nxxJgaozVKqMvnUo7wk1J0+5tWthIkPsrwgGCej1om
        T0Fg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.6.2 AUTH)
        with ESMTPSA id e07b38wB9L3sB2I
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 22:03:54 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kn6cj-0008Ca-So; Wed, 09 Dec 2020 22:03:45 +0100
Received: (nullmailer pid 385345 invoked by uid 502);
        Wed, 09 Dec 2020 21:03:45 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] power: reset: new driver regulator-poweroff
Date:   Wed,  9 Dec 2020 22:02:19 +0100
Message-Id: <20201209210221.385188-2-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209210221.385188-1-michael@fossekall.de>
References: <20201209210221.385188-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver registers a pm_power_off function to disable a set of
regulators defined in the devicetree to turn off the board.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/power/reset/Kconfig              |  7 ++
 drivers/power/reset/Makefile             |  1 +
 drivers/power/reset/regulator-poweroff.c | 86 ++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/power/reset/regulator-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index d55b3727e00e..b22c4fdb2561 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -177,6 +177,13 @@ config POWER_RESET_QNAP
 
 	  Say Y if you have a QNAP NAS.
 
+config POWER_RESET_REGULATOR
+	bool "Regulator subsystem power-off driver"
+	depends on OF && REGULATOR
+	help
+	  This driver supports turning off your board by disabling a
+	  power regulator defined in the devicetree.
+
 config POWER_RESET_RESTART
 	bool "Restart power-off driver"
 	help
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index c51eceba9ea3..9dc49d3a57ff 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
+obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
 obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/reset/regulator-poweroff.c
new file mode 100644
index 000000000000..c67136cd7b90
--- /dev/null
+++ b/drivers/power/reset/regulator-poweroff.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Force-disables a regulator to power down a device
+ *
+ * Michael Klein <michael@fossekall.de>
+ *
+ * Copyright (C) 2020 Michael Klein
+ *
+ * Based on the gpio-poweroff driver.
+ */
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regulator/consumer.h>
+
+#define TIMEOUT_MS 3000
+
+/*
+ * Hold configuration here, cannot be more than one instance of the driver
+ * since pm_power_off itself is global.
+ */
+static struct regulator *poweroff_regulator;
+
+static void regulator_poweroff_do_poweroff(void)
+{
+	if (poweroff_regulator && regulator_is_enabled(poweroff_regulator))
+		regulator_force_disable(poweroff_regulator);
+
+	/* give it some time */
+	mdelay(TIMEOUT_MS);
+
+	WARN_ON(1);
+}
+
+static int regulator_poweroff_probe(struct platform_device *pdev)
+{
+	struct regulator *regulator;
+
+	/* If a pm_power_off function has already been added, leave it alone */
+	if (pm_power_off != NULL) {
+		dev_err(&pdev->dev,
+			"%s: pm_power_off function already registered\n",
+			__func__);
+		return -EBUSY;
+	}
+
+	regulator = devm_regulator_get(&pdev->dev, "power");
+	if (IS_ERR(regulator))
+		return PTR_ERR(regulator);
+
+	poweroff_regulator = regulator;
+
+	pm_power_off = &regulator_poweroff_do_poweroff;
+	return 0;
+}
+
+static int regulator_poweroff_remove(__maybe_unused struct platform_device *pdev)
+{
+	if (pm_power_off == &regulator_poweroff_do_poweroff)
+		pm_power_off = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id of_regulator_poweroff_match[] = {
+	{ .compatible = "regulator-poweroff", },
+	{},
+};
+
+static struct platform_driver regulator_poweroff_driver = {
+	.probe = regulator_poweroff_probe,
+	.remove = regulator_poweroff_remove,
+	.driver = {
+		.name = "poweroff-regulator",
+		.of_match_table = of_regulator_poweroff_match,
+	},
+};
+
+module_platform_driver(regulator_poweroff_driver);
+
+MODULE_AUTHOR("Michael Klein <michael@fossekall.de>");
+MODULE_DESCRIPTION("Regulator poweroff driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:poweroff-regulator");
-- 
2.29.2

