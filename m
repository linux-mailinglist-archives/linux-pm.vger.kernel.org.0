Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6524E322
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 00:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHUWUK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 18:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgHUWUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 18:20:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED9C061575;
        Fri, 21 Aug 2020 15:20:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t10so4288804ejs.8;
        Fri, 21 Aug 2020 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fhh3ourzHmhVLH1ln9oScZ/YWyJaRap92ziW8DQPBmY=;
        b=k8/7fJ17HHsGWU6RD7GXlyd2DmN8NKrm7Oei9gqboMHnQQLn7m29QqUzqRQZZ3W21r
         9b7C1i3SafTA9yyDLeeMVY5un0ngqV8HWjE2K48723MLeu4S9HClItTh9YHQFCvrCu2C
         0MmrfsRwNx5nZ6NWZLp9a+MYLZtCeoJW3rG2qi6kgX5AT2+oSbmHm1alXsmObIUJnWYp
         c983seSd11CeH22fQzgLyxJOC4Sazfa5rBOoYcj5Vn3PURMvHq3oPda5jAXCZq/aISq+
         rr8y8ap+IMXuKi7IGeFsoAfJLW+qfVPhL+dGxkLhWycLVtSfCQ0SRkpgc3iNCMvjql7P
         u66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fhh3ourzHmhVLH1ln9oScZ/YWyJaRap92ziW8DQPBmY=;
        b=FFjrZ52bO0N0kN/Y/26NTlY/SS2LUqViEeYA1lolmm01Ttz7ssHC+jKkzgrzLFuwpP
         Q8v4T+Q+WdCcU3nm/ypnMRsV0Y1TGmvfuBh3xEZ1iXIjDSLdSkesI4acsdyijWo0wiS2
         0jYaCKqbKEDsDRUSpZn495EbsQrb6IJBAC9PUT1aBeubUGb+d//2C08476an8qNZ3BXD
         QvRpm7EsM2WQwA8hl+F6+tonWIZ1TZd2epN47OsknzhiSENJicfhGJ0YTrPJ4STt6+za
         WQ11z7+cfPztpE3LOUwzQ7uHafulL74nK91Et0mnCqD0g2gssQoiOMnYXooOgMM5niqh
         QvJg==
X-Gm-Message-State: AOAM531EdbmdI5ZhqELRBuaFOmxrFNjduIJMeMiGCUcWqdq6GpaKQjcK
        ZzlYV2mJlsEWJQIvjZh8j0EcWLr8H0YdHQ==
X-Google-Smtp-Source: ABdhPJw8dq/iCbN8UC4WwA8Fkk7irf65uTYdN1gFpXhqXtWlxLTTgMI5rrq1B2bPSDKW5yKuqBF3jw==
X-Received: by 2002:a17:906:6146:: with SMTP id p6mr5155236ejl.211.1598048400363;
        Fri, 21 Aug 2020 15:20:00 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id p23sm1780147edm.31.2020.08.21.15.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:19:59 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 4/6] power: reset: Add poweroff driver for ATC260x PMICs
Date:   Sat, 22 Aug 2020 01:19:50 +0300
Message-Id: <1c83a46ac8c39edceee1d98da2cd9e7c6eae35e8.1598043782.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver provides poweroff and reboot support for a system through
the ATC2603C and ATC2609A chip variants of the Actions Semi ATC260x
family of PMICs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/power/reset/Kconfig            |   8 +-
 drivers/power/reset/Makefile           |   1 +
 drivers/power/reset/atc260x-poweroff.c | 274 +++++++++++++++++++++++++
 3 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/reset/atc260x-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 0a1fb5c74f83..df6c3676b892 100644
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
@@ -285,4 +292,3 @@ config NVMEM_REBOOT_MODE
 	  action according to the mode.
 
 endif
-
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index c51eceba9ea3..829df1157540 100644
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
index 000000000000..81a99e7e4a91
--- /dev/null
+++ b/drivers/power/reset/atc260x-poweroff.c
@@ -0,0 +1,274 @@
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
+	if (!pdev->dev.of_node)
+		return -ENXIO;
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
+static const struct of_device_id atc260x_pwrc_of_match[] = {
+	{ .compatible = "actions,atc2603c-pwrc" },
+	{ .compatible = "actions,atc2609a-pwrc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, atc260x_pwrc_of_match);
+
+static struct platform_driver atc260x_pwrc_driver = {
+	.probe = atc260x_pwrc_probe,
+	.remove = atc260x_pwrc_remove,
+	.driver = {
+		.name = "atc260x-pwrc",
+		.of_match_table = of_match_ptr(atc260x_pwrc_of_match),
+	},
+};
+
+module_platform_driver(atc260x_pwrc_driver);
+
+MODULE_DESCRIPTION("Poweroff & reset driver for ATC260x PMICs");
+MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.28.0

