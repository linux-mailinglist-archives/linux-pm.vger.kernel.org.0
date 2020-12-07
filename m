Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44D42D13DC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 15:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgLGOhO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 09:37:14 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:36080 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgLGOhO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 09:37:14 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2020 09:37:11 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607351660;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9xO2wGJAhLl5pgcUNhK9yul/eE7Yn45liR+B7i+kPok=;
        b=bUCZNyla++hyJpObKFpiZ0neT7TbNG2Rf63zlxDAsTqrtti58qZAJiBptbie9fekF6
        AcFkAtJvMeUj4c2skWz89a0wrAtCU8+m3WCrOXw5VGA8WCNBvYBMFdBdwpIYdPEFYeof
        oMsTodqQlF2U3O2IyDIFm5HS7klbH3ABO7fszllWoZrS7XcrEi8gaMYB74N1kM/Lg9Q/
        tGkiQ/sZEp4JKLDjVuSJBEUjWANQ89wp9Cv91hGauiJ6b+vk/aCQdooqzSThb7E2okqO
        eopppwxq5T9h99oDtX9egEQA0W7GrRlDga7OvlJfbwfLx6bdsCHjRWmx9eo+bmDsF/Ma
        i0ng==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wB7ESDOVe
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Dec 2020 15:28:13 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kmHUg-0001T2-TJ; Mon, 07 Dec 2020 15:28:02 +0100
Received: (nullmailer pid 17895 invoked by uid 502);
        Mon, 07 Dec 2020 14:28:02 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] power: reset: new driver regulator-poweroff
Date:   Mon,  7 Dec 2020 15:27:54 +0100
Message-Id: <20201207142756.17819-2-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207142756.17819-1-michael@fossekall.de>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver registers a pm_power_off function to disable a set of
regulators defined in the devicetree to turn off the board.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/power/reset/Kconfig              |   7 ++
 drivers/power/reset/Makefile             |   1 +
 drivers/power/reset/regulator-poweroff.c | 107 +++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/power/reset/regulator-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index d55b3727e00e..ae6cb7b0bd4d 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -177,6 +177,13 @@ config POWER_RESET_QNAP
 
 	  Say Y if you have a QNAP NAS.
 
+config POWER_RESET_REGULATOR
+	bool "Regulator subsystem power-off driver"
+	depends on OF && REGULATOR
+	help
+	  This driver supports turning off your board by disabling a set
+	  of regulators defined in the devicetree.
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
index 000000000000..df2ca4fdcc49
--- /dev/null
+++ b/drivers/power/reset/regulator-poweroff.c
@@ -0,0 +1,107 @@
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
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+#define DEFAULT_TIMEOUT_MS 3000
+
+/*
+ * Hold configuration here, cannot be more than one instance of the driver
+ * since pm_power_off itself is global.
+ */
+static struct regulator **poweroff_regulators;
+static u32 timeout = DEFAULT_TIMEOUT_MS;
+
+static void regulator_poweroff_do_poweroff(void)
+{
+	struct regulator **it;
+
+	if (poweroff_regulators)
+		for (it = poweroff_regulators; *it; ++it)
+			if (regulator_is_enabled(*it))
+				regulator_force_disable(*it);
+
+	/* give it some time */
+	mdelay(timeout);
+
+	WARN_ON(1);
+}
+
+static int regulator_poweroff_probe(struct platform_device *pdev)
+{
+	int count;
+	const char *name;
+	struct regulator **it;
+	struct property *prop;
+	struct device_node *node = pdev->dev.of_node;
+
+	/* If a pm_power_off function has already been added, leave it alone */
+	if (pm_power_off != NULL) {
+		dev_err(&pdev->dev,
+			"%s: pm_power_off function already registered\n",
+		       __func__);
+		return -EBUSY;
+	}
+
+	count = of_property_count_strings(node, "regulator-names");
+	if (count <= 0)
+		return -ENOENT;
+
+	poweroff_regulators = devm_kcalloc(&pdev->dev, count + 1,
+		sizeof(struct regulator *), GFP_KERNEL);
+
+	it = poweroff_regulators;
+	of_property_for_each_string(node, "regulator-names", prop, name) {
+		*it = devm_regulator_get(&pdev->dev, name);
+		if (IS_ERR(*it))
+			return PTR_ERR(*it);
+		it++;
+	}
+
+	of_property_read_u32(node, "timeout-ms", &timeout);
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

