Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BFF2E72AF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 18:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgL2Rcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 12:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgL2Rcf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Dec 2020 12:32:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3435C06179B;
        Tue, 29 Dec 2020 09:31:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qw4so18966972ejb.12;
        Tue, 29 Dec 2020 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=osoTrdmSdrZ51v7mgrsifMoWWdOBLq9AWUy9Y5u9/8k=;
        b=kJgRrMdIgaDfYSTbrFKxoOQersCONnhClwxLrQ37NyvSMA3KPa8KrnmZtKhBKYc49M
         3uWy4J1c+NaSZvwFBOmDOvF15tH7dLpDK+gufHRJTAEvHBzFCTIqSOY6yX8wQ+XUq7Tu
         /dktMTOmWBDgRaqukErZvUMm1ouh4XWvem8uu6LTWgkFEH90OiTEHnGuqF+JDeNGSIdo
         Se1ryHmDDNBH21n78u/JU7no0PpZYFzZpZrp2UpIrf5gpKdDuQvNkOj5MuPPaH5KXJOY
         xWBT6lgU4oMswrKkbOiepwEqBHTFEtzBNBiTj2jDgJJxJ0U3zLwl4ocIUgS12CROaXR1
         /nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osoTrdmSdrZ51v7mgrsifMoWWdOBLq9AWUy9Y5u9/8k=;
        b=Ac5x3v+9selcX6GDxApvSaIbA3WmTuG8aHcAkEDWYqm9iUOBJc6SBQY3IYgy/MOC+S
         jprjeQl8Gt8W4MZVRIJdQ7dkqpynQaJQoMcy+9Ijafy6KOloTlK3CJK6etEnW9pQBtub
         wMl5vjSVjYGT6Z7JSoo6mAcMOE3Q6m7ohCFzklhy4bXgE77fhENhjYaLCXccOKuKMr2i
         fA6ajhGqqgqsQnIJGK4vSacfd0sDbvuk1aGeKda00jpELeSg0pTmv5ngeot70YxazY6i
         b828x+B1Cg7BdYNgKhlb1/VRnzQSTEYRJunBGhk0fQXFc/QNGyihAYMxCf8sTwdIsXWn
         iZjw==
X-Gm-Message-State: AOAM533/XBx1UbUF0+LGFLRBAlpyxRTR0OKye4TJ0Yw48U7Rm+7EUJg+
        yBuUB302kuV+r1dev9hDCBQ=
X-Google-Smtp-Source: ABdhPJwBqewUXvTyflCBNoK7Smdjttx+wTqmmflliDF8dXramGmdih4pv5+QkODwfn/0tqwMekSdPg==
X-Received: by 2002:a17:906:aeda:: with SMTP id me26mr45713210ejb.11.1609263094460;
        Tue, 29 Dec 2020 09:31:34 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id q25sm37385362eds.85.2020.12.29.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 09:31:33 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 5/7] power: reset: Add poweroff driver for ATC260x PMICs
Date:   Tue, 29 Dec 2020 19:31:20 +0200
Message-Id: <eef6e5a4e0fc5f20da235a3a4124ba81eebfe2ca.1609258905.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
References: <cover.1609258905.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver provides poweroff and reboot support for a system through
the ATC2603C and ATC2609A chip variants of the Actions Semi ATC260x
family of PMICs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v4:
 - None

Changes in v3:
 - Removed the unnecessary driver compatibles

 drivers/power/reset/Kconfig            |   8 +-
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/atc260x-poweroff.c | 263 +++++++++++++++++++++++++
 3 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/reset/atc260x-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index b22c4fdb2561..1737e227b16e 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -39,6 +39,13 @@ config POWER_RESET_AT91_SAMA5D2_SHDWC
 	  This driver supports the alternate shutdown controller for some Atmel
 	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.
 
+config POWER_RESET_ATC260X
+	tristate "Actions Semi ATC260x PMIC power-off driver"
+	depends on MFD_ATC260X
+	help
+	  This driver provides power-off and restart support for a system
+	  through Actions Semi ATC260x series PMICs.
+
 config POWER_RESET_AXXIA
 	bool "LSI Axxia reset driver"
 	depends on ARCH_AXXIA
@@ -292,4 +299,3 @@ config NVMEM_REBOOT_MODE
 	  action according to the mode.
 
 endif
-
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 9dc49d3a57ff..b4601c0a96ed 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
 obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) += at91-poweroff.o
 obj-$(CONFIG_POWER_RESET_AT91_RESET) += at91-reset.o
 obj-$(CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC) += at91-sama5d2_shdwc.o
+obj-$(CONFIG_POWER_RESET_ATC260X) += atc260x-poweroff.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMKONA) += brcm-kona-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
diff --git a/drivers/power/reset/atc260x-poweroff.c b/drivers/power/reset/atc260x-poweroff.c
new file mode 100644
index 000000000000..81b050f99302
--- /dev/null
+++ b/drivers/power/reset/atc260x-poweroff.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Poweroff & reset driver for Actions Semi ATC260x PMICs
+ *
+ * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/mfd/atc260x/core.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+struct atc260x_pwrc {
+	struct device *dev;
+	struct regmap *regmap;
+	struct notifier_block restart_nb;
+	int (*do_poweroff)(const struct atc260x_pwrc *pwrc, bool restart);
+};
+
+/* Global variable needed only for pm_power_off */
+static struct atc260x_pwrc *atc260x_pwrc_data;
+
+static int atc2603c_do_poweroff(const struct atc260x_pwrc *pwrc, bool restart)
+{
+	int ret, deep_sleep = 0;
+	uint reg_mask, reg_val;
+
+	/* S4-Deep Sleep Mode is NOT available for WALL/USB power */
+	if (!restart && !power_supply_is_system_supplied()) {
+		deep_sleep = 1;
+		dev_info(pwrc->dev, "Enabling S4-Deep Sleep Mode");
+	}
+
+	/* Update wakeup sources */
+	reg_val = ATC2603C_PMU_SYS_CTL0_ONOFF_LONG_WK_EN |
+		  (restart ? ATC2603C_PMU_SYS_CTL0_RESET_WK_EN
+			   : ATC2603C_PMU_SYS_CTL0_ONOFF_SHORT_WK_EN);
+
+	ret = regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL0,
+				 ATC2603C_PMU_SYS_CTL0_WK_ALL, reg_val);
+	if (ret)
+		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
+
+	/* Update power mode */
+	reg_mask = ATC2603C_PMU_SYS_CTL3_EN_S2 | ATC2603C_PMU_SYS_CTL3_EN_S3;
+
+	ret = regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL3, reg_mask,
+				 deep_sleep ? 0 : ATC2603C_PMU_SYS_CTL3_EN_S3);
+	if (ret) {
+		dev_err(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
+		return ret;
+	}
+
+	/* Trigger poweroff / restart sequence */
+	reg_mask = restart ? ATC2603C_PMU_SYS_CTL0_RESTART_EN
+			   : ATC2603C_PMU_SYS_CTL1_EN_S1;
+	reg_val = restart ? ATC2603C_PMU_SYS_CTL0_RESTART_EN : 0;
+
+	ret = regmap_update_bits(pwrc->regmap,
+				 restart ? ATC2603C_PMU_SYS_CTL0 : ATC2603C_PMU_SYS_CTL1,
+				 reg_mask, reg_val);
+	if (ret) {
+		dev_err(pwrc->dev, "failed to write SYS_CTL%d: %d\n",
+			restart ? 0 : 1, ret);
+		return ret;
+	}
+
+	/* Wait for trigger completion */
+	mdelay(200);
+
+	return 0;
+}
+
+static int atc2609a_do_poweroff(const struct atc260x_pwrc *pwrc, bool restart)
+{
+	int ret, deep_sleep = 0;
+	uint reg_mask, reg_val;
+
+	/* S4-Deep Sleep Mode is NOT available for WALL/USB power */
+	if (!restart && !power_supply_is_system_supplied()) {
+		deep_sleep = 1;
+		dev_info(pwrc->dev, "Enabling S4-Deep Sleep Mode");
+	}
+
+	/* Update wakeup sources */
+	reg_val = ATC2609A_PMU_SYS_CTL0_ONOFF_LONG_WK_EN |
+		  (restart ? ATC2609A_PMU_SYS_CTL0_RESET_WK_EN
+			   : ATC2609A_PMU_SYS_CTL0_ONOFF_SHORT_WK_EN);
+
+	ret = regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL0,
+				 ATC2609A_PMU_SYS_CTL0_WK_ALL, reg_val);
+	if (ret)
+		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
+
+	/* Update power mode */
+	reg_mask = ATC2609A_PMU_SYS_CTL3_EN_S2 | ATC2609A_PMU_SYS_CTL3_EN_S3;
+
+	ret = regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL3, reg_mask,
+				 deep_sleep ? 0 : ATC2609A_PMU_SYS_CTL3_EN_S3);
+	if (ret) {
+		dev_err(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
+		return ret;
+	}
+
+	/* Trigger poweroff / restart sequence */
+	reg_mask = restart ? ATC2609A_PMU_SYS_CTL0_RESTART_EN
+			   : ATC2609A_PMU_SYS_CTL1_EN_S1;
+	reg_val = restart ? ATC2609A_PMU_SYS_CTL0_RESTART_EN : 0;
+
+	ret = regmap_update_bits(pwrc->regmap,
+				 restart ? ATC2609A_PMU_SYS_CTL0 : ATC2609A_PMU_SYS_CTL1,
+				 reg_mask, reg_val);
+	if (ret) {
+		dev_err(pwrc->dev, "failed to write SYS_CTL%d: %d\n",
+			restart ? 0 : 1, ret);
+		return ret;
+	}
+
+	/* Wait for trigger completion */
+	mdelay(200);
+
+	return 0;
+}
+
+static int atc2603c_init(const struct atc260x_pwrc *pwrc)
+{
+	int ret;
+
+	/*
+	 * Delay transition from S2/S3 to S1 in order to avoid
+	 * DDR init failure in Bootloader.
+	 */
+	ret = regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL3,
+				 ATC2603C_PMU_SYS_CTL3_S2S3TOS1_TIMER_EN,
+				 ATC2603C_PMU_SYS_CTL3_S2S3TOS1_TIMER_EN);
+	if (ret)
+		dev_warn(pwrc->dev, "failed to write SYS_CTL3: %d\n", ret);
+
+	/* Set wakeup sources */
+	ret = regmap_update_bits(pwrc->regmap, ATC2603C_PMU_SYS_CTL0,
+				 ATC2603C_PMU_SYS_CTL0_WK_ALL,
+				 ATC2603C_PMU_SYS_CTL0_HDSW_WK_EN |
+				 ATC2603C_PMU_SYS_CTL0_ONOFF_LONG_WK_EN);
+	if (ret)
+		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
+
+	return ret;
+}
+
+static int atc2609a_init(const struct atc260x_pwrc *pwrc)
+{
+	int ret;
+
+	/* Set wakeup sources */
+	ret = regmap_update_bits(pwrc->regmap, ATC2609A_PMU_SYS_CTL0,
+				 ATC2609A_PMU_SYS_CTL0_WK_ALL,
+				 ATC2609A_PMU_SYS_CTL0_HDSW_WK_EN |
+				 ATC2609A_PMU_SYS_CTL0_ONOFF_LONG_WK_EN);
+	if (ret)
+		dev_warn(pwrc->dev, "failed to write SYS_CTL0: %d\n", ret);
+
+	return ret;
+}
+
+static void atc260x_pwrc_pm_handler(void)
+{
+	atc260x_pwrc_data->do_poweroff(atc260x_pwrc_data, false);
+
+	WARN_ONCE(1, "Unable to power off system\n");
+}
+
+static int atc260x_pwrc_restart_handler(struct notifier_block *nb,
+					unsigned long mode, void *cmd)
+{
+	struct atc260x_pwrc *pwrc = container_of(nb, struct atc260x_pwrc,
+						 restart_nb);
+	pwrc->do_poweroff(pwrc, true);
+
+	return NOTIFY_DONE;
+}
+
+static int atc260x_pwrc_probe(struct platform_device *pdev)
+{
+	struct atc260x *atc260x = dev_get_drvdata(pdev->dev.parent);
+	struct atc260x_pwrc *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->regmap = atc260x->regmap;
+	priv->restart_nb.notifier_call = atc260x_pwrc_restart_handler;
+	priv->restart_nb.priority = 192;
+
+	switch (atc260x->ic_type) {
+	case ATC2603C:
+		priv->do_poweroff = atc2603c_do_poweroff;
+		ret = atc2603c_init(priv);
+		break;
+	case ATC2609A:
+		priv->do_poweroff = atc2609a_do_poweroff;
+		ret = atc2609a_init(priv);
+		break;
+	default:
+		dev_err(priv->dev,
+			"Poweroff not supported for ATC260x PMIC type: %u\n",
+			atc260x->ic_type);
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	if (!pm_power_off) {
+		atc260x_pwrc_data = priv;
+		pm_power_off = atc260x_pwrc_pm_handler;
+	} else {
+		dev_warn(priv->dev, "Poweroff callback already assigned\n");
+	}
+
+	ret = register_restart_handler(&priv->restart_nb);
+	if (ret)
+		dev_err(priv->dev, "failed to register restart handler: %d\n",
+			ret);
+
+	return ret;
+}
+
+static int atc260x_pwrc_remove(struct platform_device *pdev)
+{
+	struct atc260x_pwrc *priv = platform_get_drvdata(pdev);
+
+	if (atc260x_pwrc_data == priv) {
+		pm_power_off = NULL;
+		atc260x_pwrc_data = NULL;
+	}
+
+	unregister_restart_handler(&priv->restart_nb);
+
+	return 0;
+}
+
+static struct platform_driver atc260x_pwrc_driver = {
+	.probe = atc260x_pwrc_probe,
+	.remove = atc260x_pwrc_remove,
+	.driver = {
+		.name = "atc260x-pwrc",
+	},
+};
+
+module_platform_driver(atc260x_pwrc_driver);
+
+MODULE_DESCRIPTION("Poweroff & reset driver for ATC260x PMICs");
+MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.30.0

