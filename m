Return-Path: <linux-pm+bounces-27002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F43DAB2741
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F614176F33
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA001D95B3;
	Sun, 11 May 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhRscjIi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48D1B85FD;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746951550; cv=none; b=Mfi0toLD6rf3wX3N8m+SApeoIlwXdb2EdZrQ6wPGzTi8LNIAqvJoc2h1LZ5U/znU3hFA5/EBkwehlsDrKfKc+SoLZtZST+8C0I7ICKeLpODhROoP2xztfLvSXH5Kny2mUO8wxcJO+4AT/cDGSmcOpJuWwZ4LcjkPDQG8WCk1G4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746951550; c=relaxed/simple;
	bh=SUDey3zZrMHSGZiN7e1LSm+eXDAfzk8RfxUKBQX2svU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OtHkdIFWs7uW7JwZoK4c7gjuiSGvEbb7wAY4BsP3A/cr6Oo9nzCQzKyFHoCatZ9MAUXe1avKNgjelJF43OeVQz4u6XIZAQg7l8S1WmKrMYaAjfUkzjjLVzO8AOeuXZIjb5Qguw6m+jdNRvtrqruB4vGAK77qnqZUp/Zxc2tePTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhRscjIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 705A3C4CEFD;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746951549;
	bh=SUDey3zZrMHSGZiN7e1LSm+eXDAfzk8RfxUKBQX2svU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EhRscjIicFgCtSJ8oePbAJzg4ApLAZMoi/tNcapHn/USHAyQCqzzSyEAmZmFJwBqo
	 /OYkKlplsQDOpy0UMQ3MK7EyMiLxl6c7wqWMectqoeVaU51sGdwz0D2s5M5LgJ11V/
	 huaMHCwpfMk53O+X1EA/8sdMLvToxI19+hydei6sWsQLYGhEl/e2soyCNSJyEKpQ3Z
	 0GX/loZ4Y8N+3BCEqjWrP7DH1YhN0w4nwYS4B0Zp1aCITVjFj8KbGkLv5ignB3Ur8P
	 Kdwl5wOJrmDF/ZAQmFDgVrESSQv8Ijb9Z60h3a2OH4v+jCqrENov6MpB2nNLZRN0dS
	 aLyacsXdp1jZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A4C3ABC5;
	Sun, 11 May 2025 08:19:09 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sun, 11 May 2025 08:18:42 +0000
Subject: [PATCH v5 07/10] power: reset: macsmc-reboot: Add driver for
 rebooting via Apple SMC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-smc-6-15-v5-7-f5980bdb18bd@svenpeter.dev>
References: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
In-Reply-To: <20250511-smc-6-15-v5-0-f5980bdb18bd@svenpeter.dev>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13328;
 i=sven@svenpeter.dev; h=from:subject:message-id;
 bh=07P0iMGVNi5LdTdD7rIECOZ7B9zNd8s6Fig9SDDKoRQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4ZCbPnG8z99zTP6Ps7sfLZu598tvZctFT6/KhVKv800+
 /BzFR+VjlIWBjEOBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBE1E4x/FNy8P1sYfFEuXKT
 +Mz99+5ndtXFC+y7M2vOTCb+dx+uLF7AyHA53utUuLDOOZaZ3SaLjPfeXs1ut5Cpd5+lz/adWpv
 X/WUCAA==
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

This driver implements the reboot/shutdown support exposed by the SMC
on Apple Silicon machines, such as Apple M1 Macs.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS                         |   1 +
 drivers/power/reset/Kconfig         |  11 ++
 drivers/power/reset/Makefile        |   1 +
 drivers/power/reset/macsmc-reboot.c | 363 ++++++++++++++++++++++++++++++++++++
 4 files changed, 376 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa3a5f9ee40446bcc725c9eac2a36651e6bc7553..84f7a730eb2260b7c1e0487d18c8eb3de82f5206 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2303,6 +2303,7 @@ F:	drivers/mfd/macsmc.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
+F:	drivers/power/reset/macsmc-reboot.c
 F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
 F:	drivers/spi/spi-apple.c
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 60bf0ca64cf395cd18238fc626611c74d29844ee..6e8dfff64fdc001d09b6c00630cd8b7e2fafdd8e 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -128,6 +128,17 @@ config POWER_RESET_LINKSTATION
 
 	  Say Y here if you have a Buffalo LinkStation LS421D/E.
 
+config POWER_RESET_MACSMC
+	tristate "Apple SMC reset/power-off driver"
+	depends on ARCH_APPLE || COMPILE_TEST
+	depends on MFD_MACSMC
+	depends on OF
+	help
+	  This driver supports reset and power-off on Apple Mac machines
+	  that implement this functionality via the SMC.
+
+	  Say Y here if you have an Apple Silicon Mac.
+
 config POWER_RESET_MSM
 	bool "Qualcomm MSM power-off driver"
 	depends on ARCH_QCOM
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 10782d32e1da39f4b8b4566e8a885f2e13f65130..887dd9e49b7293b69b9429ddc0c1571194a153cf 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_LINKSTATION) += linkstation-poweroff.o
+obj-$(CONFIG_POWER_RESET_MACSMC) += macsmc-reboot.o
 obj-$(CONFIG_POWER_RESET_MSM) += msm-poweroff.o
 obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
 obj-$(CONFIG_POWER_RESET_QCOM_PON) += qcom-pon.o
diff --git a/drivers/power/reset/macsmc-reboot.c b/drivers/power/reset/macsmc-reboot.c
new file mode 100644
index 0000000000000000000000000000000000000000..d82339e427886667be4ad2de0d1d5c04d2383059
--- /dev/null
+++ b/drivers/power/reset/macsmc-reboot.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple SMC Reboot/Poweroff Handler
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <linux/delay.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/macsmc.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+
+struct macsmc_reboot_nvmem {
+	struct nvmem_cell *shutdown_flag;
+	struct nvmem_cell *pm_setting;
+	struct nvmem_cell *boot_stage;
+	struct nvmem_cell *boot_error_count;
+	struct nvmem_cell *panic_count;
+};
+
+static const char * const nvmem_names[] = {
+	"shutdown_flag",
+	"pm_setting",
+	"boot_stage",
+	"boot_error_count",
+	"panic_count",
+};
+
+enum boot_stage {
+	BOOT_STAGE_SHUTDOWN		= 0x00, /* Clean shutdown */
+	BOOT_STAGE_IBOOT_DONE		= 0x2f, /* Last stage of bootloader */
+	BOOT_STAGE_KERNEL_STARTED	= 0x30, /* Normal OS booting */
+};
+
+enum pm_setting {
+	PM_SETTING_AC_POWER_RESTORE	= 0x02,
+	PM_SETTING_AC_POWER_OFF		= 0x03,
+};
+
+static const char * const ac_power_modes[] = { "off", "restore" };
+
+static int ac_power_mode_map[] = {
+	PM_SETTING_AC_POWER_OFF,
+	PM_SETTING_AC_POWER_RESTORE,
+};
+
+struct macsmc_reboot {
+	struct device *dev;
+	struct apple_smc *smc;
+	struct notifier_block reboot_notify;
+
+	union {
+		struct macsmc_reboot_nvmem nvm;
+		struct nvmem_cell *nvm_cells[ARRAY_SIZE(nvmem_names)];
+	};
+};
+
+/* Helpers to read/write a u8 given a struct nvmem_cell */
+static int nvmem_cell_get_u8(struct nvmem_cell *cell)
+{
+	size_t len;
+	u8 val;
+	void *ret = nvmem_cell_read(cell, &len);
+
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	if (len < 1) {
+		kfree(ret);
+		return -EINVAL;
+	}
+
+	val = *(u8 *)ret;
+	kfree(ret);
+	return val;
+}
+
+static int nvmem_cell_set_u8(struct nvmem_cell *cell, u8 val)
+{
+	return nvmem_cell_write(cell, &val, sizeof(val));
+}
+
+static ssize_t macsmc_ac_power_mode_store(struct device *dev, struct device_attribute *attr,
+					  const char *buf, size_t n)
+{
+	struct macsmc_reboot *reboot = dev_get_drvdata(dev);
+	int mode;
+	int ret;
+
+	mode = sysfs_match_string(ac_power_modes, buf);
+	if (mode < 0)
+		return mode;
+
+	ret = nvmem_cell_set_u8(reboot->nvm.pm_setting, ac_power_mode_map[mode]);
+	if (ret < 0)
+		return ret;
+
+	return n;
+}
+
+static ssize_t macsmc_ac_power_mode_show(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	struct macsmc_reboot *reboot = dev_get_drvdata(dev);
+	int len = 0;
+	int i;
+	int mode = nvmem_cell_get_u8(reboot->nvm.pm_setting);
+
+	if (mode < 0)
+		return mode;
+
+	for (i = 0; i < ARRAY_SIZE(ac_power_mode_map); i++) {
+		if (mode == ac_power_mode_map[i])
+			len += scnprintf(buf+len, PAGE_SIZE-len,
+					 "[%s] ", ac_power_modes[i]);
+		else
+			len += scnprintf(buf+len, PAGE_SIZE-len,
+					 "%s ", ac_power_modes[i]);
+	}
+
+	buf[len-1] = '\n';
+	return len;
+}
+static DEVICE_ATTR(ac_power_mode, 0644, macsmc_ac_power_mode_show,
+		   macsmc_ac_power_mode_store);
+
+/*
+ * SMC 'MBSE' key actions:
+ *
+ * 'offw' - shutdown warning
+ * 'slpw' - sleep warning
+ * 'rest' - restart warning
+ * 'off1' - shutdown (needs PMU bit set to stay on)
+ * 'susp' - suspend
+ * 'phra' - restart ("PE Halt Restart Action"?)
+ * 'panb' - panic beginning
+ * 'pane' - panic end
+ */
+
+static int macsmc_prepare_atomic(struct sys_off_data *data)
+{
+	struct macsmc_reboot *reboot = data->cb_data;
+
+	dev_info(reboot->dev, "Preparing SMC for atomic mode\n");
+
+	apple_smc_enter_atomic(reboot->smc);
+	return NOTIFY_OK;
+}
+
+static int macsmc_power_off(struct sys_off_data *data)
+{
+	struct macsmc_reboot *reboot = data->cb_data;
+
+	dev_info(reboot->dev, "Issuing power off (off1)\n");
+
+	if (apple_smc_write_u32_atomic(reboot->smc, SMC_KEY(MBSE), SMC_KEY(off1)) < 0) {
+		dev_err(reboot->dev, "Failed to issue MBSE = off1 (power_off)\n");
+	} else {
+		mdelay(100);
+		WARN_ONCE(1, "Unable to power off system\n");
+	}
+
+	return NOTIFY_OK;
+}
+
+static int macsmc_restart(struct sys_off_data *data)
+{
+	struct macsmc_reboot *reboot = data->cb_data;
+
+	dev_info(reboot->dev, "Issuing restart (phra)\n");
+
+	if (apple_smc_write_u32_atomic(reboot->smc, SMC_KEY(MBSE), SMC_KEY(phra)) < 0) {
+		dev_err(reboot->dev, "Failed to issue MBSE = phra (restart)\n");
+	} else {
+		mdelay(100);
+		WARN_ONCE(1, "Unable to restart system\n");
+	}
+
+	return NOTIFY_OK;
+}
+
+static int macsmc_reboot_notify(struct notifier_block *this, unsigned long action, void *data)
+{
+	struct macsmc_reboot *reboot = container_of(this, struct macsmc_reboot, reboot_notify);
+	u32 val;
+	u8 shutdown_flag;
+
+	switch (action) {
+	case SYS_RESTART:
+		val = SMC_KEY(rest);
+		shutdown_flag = 0;
+		break;
+	case SYS_POWER_OFF:
+		val = SMC_KEY(offw);
+		shutdown_flag = 1;
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	dev_info(reboot->dev, "Preparing for reboot (%p4ch)\n", &val);
+
+	/* On the Mac Mini, this will turn off the LED for power off */
+	if (apple_smc_write_u32(reboot->smc, SMC_KEY(MBSE), val) < 0)
+		dev_err(reboot->dev, "Failed to issue MBSE = %p4ch (reboot_prepare)\n", &val);
+
+	/* Set the boot_stage to 0, which means we're doing a clean shutdown/reboot. */
+	if (reboot->nvm.boot_stage &&
+	    nvmem_cell_set_u8(reboot->nvm.boot_stage, BOOT_STAGE_SHUTDOWN) < 0)
+		dev_err(reboot->dev, "Failed to write boot_stage\n");
+
+	/*
+	 * Set the PMU flag to actually reboot into the off state.
+	 * Without this, the device will just reboot. We make it optional in case it is no longer
+	 * necessary on newer hardware.
+	 */
+	if (reboot->nvm.shutdown_flag &&
+	    nvmem_cell_set_u8(reboot->nvm.shutdown_flag, shutdown_flag) < 0)
+		dev_err(reboot->dev, "Failed to write shutdown_flag\n");
+
+	return NOTIFY_OK;
+}
+
+static void macsmc_power_init_error_counts(struct macsmc_reboot *reboot)
+{
+	int boot_error_count, panic_count;
+
+	if (!reboot->nvm.boot_error_count || !reboot->nvm.panic_count)
+		return;
+
+	boot_error_count = nvmem_cell_get_u8(reboot->nvm.boot_error_count);
+	if (boot_error_count < 0) {
+		dev_err(reboot->dev, "Failed to read boot_error_count (%d)\n", boot_error_count);
+		return;
+	}
+
+	panic_count = nvmem_cell_get_u8(reboot->nvm.panic_count);
+	if (panic_count < 0) {
+		dev_err(reboot->dev, "Failed to read panic_count (%d)\n", panic_count);
+		return;
+	}
+
+	if (!boot_error_count && !panic_count)
+		return;
+
+	dev_warn(reboot->dev, "PMU logged %d boot error(s) and %d panic(s)\n",
+		 boot_error_count, panic_count);
+
+	if (nvmem_cell_set_u8(reboot->nvm.panic_count, 0) < 0)
+		dev_err(reboot->dev, "Failed to reset panic_count\n");
+	if (nvmem_cell_set_u8(reboot->nvm.boot_error_count, 0) < 0)
+		dev_err(reboot->dev, "Failed to reset boot_error_count\n");
+}
+
+static int macsmc_reboot_probe(struct platform_device *pdev)
+{
+	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
+	struct macsmc_reboot *reboot;
+	int ret, i;
+
+	/* Ignore devices without this functionality */
+	if (!apple_smc_key_exists(smc, SMC_KEY(MBSE)))
+		return -ENODEV;
+
+	reboot = devm_kzalloc(&pdev->dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	reboot->dev = &pdev->dev;
+	reboot->smc = smc;
+
+	platform_set_drvdata(pdev, reboot);
+
+	pdev->dev.of_node = of_get_child_by_name(pdev->dev.parent->of_node, "reboot");
+
+	for (i = 0; i < ARRAY_SIZE(nvmem_names); i++) {
+		struct nvmem_cell *cell;
+
+		cell = devm_nvmem_cell_get(&pdev->dev,
+					   nvmem_names[i]);
+		if (IS_ERR(cell)) {
+			if (PTR_ERR(cell) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_warn(&pdev->dev, "Missing NVMEM cell %s (%ld)\n",
+				 nvmem_names[i], PTR_ERR(cell));
+			/* Non fatal, we'll deal with it */
+			cell = NULL;
+		}
+		reboot->nvm_cells[i] = cell;
+	}
+
+	/* Set the boot_stage to indicate we're running the OS kernel */
+	if (reboot->nvm.boot_stage &&
+	    nvmem_cell_set_u8(reboot->nvm.boot_stage, BOOT_STAGE_KERNEL_STARTED) < 0)
+		dev_err(reboot->dev, "Failed to write boot_stage\n");
+
+	/* Display and clear the error counts */
+	macsmc_power_init_error_counts(reboot);
+
+	reboot->reboot_notify.notifier_call = macsmc_reboot_notify;
+
+	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF_PREPARE,
+					    SYS_OFF_PRIO_HIGH, macsmc_prepare_atomic, reboot);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register power-off prepare handler\n");
+	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_HIGH,
+					    macsmc_power_off, reboot);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register power-off handler\n");
+
+	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART_PREPARE,
+					    SYS_OFF_PRIO_HIGH, macsmc_prepare_atomic, reboot);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register restart prepare handler\n");
+	ret = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
+					    macsmc_restart, reboot);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register restart handler\n");
+
+	ret = devm_register_reboot_notifier(&pdev->dev, &reboot->reboot_notify);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register reboot notifier\n");
+
+	dev_info(&pdev->dev, "Handling reboot and poweroff requests via SMC\n");
+
+	if (device_create_file(&pdev->dev, &dev_attr_ac_power_mode))
+		dev_warn(&pdev->dev, "could not create sysfs file\n");
+
+	return 0;
+}
+
+static void macsmc_reboot_remove(struct platform_device *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_ac_power_mode);
+}
+
+static const struct of_device_id macsmc_reboot_of_table[] = {
+	{ .compatible = "apple,smc-reboot", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, macsmc_reboot_of_table);
+
+static struct platform_driver macsmc_reboot_driver = {
+	.driver = {
+		.name = "macsmc-reboot",
+		.of_match_table = macsmc_reboot_of_table,
+	},
+	.probe = macsmc_reboot_probe,
+	.remove = macsmc_reboot_remove,
+};
+module_platform_driver(macsmc_reboot_driver);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("Apple SMC reboot/poweroff driver");
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_ALIAS("platform:macsmc-reboot");

-- 
2.34.1



