Return-Path: <linux-pm+bounces-13770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F996EF91
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C5AB223CA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA231C9DDE;
	Fri,  6 Sep 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="fOCTWDz1"
X-Original-To: linux-pm@vger.kernel.org
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D51C86EE;
	Fri,  6 Sep 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615485; cv=none; b=aQEDNVP+tT5jNIjbbNAK0dv56g7asML9esGluGy5HrGzUTa3vZo71N4S4mr4C6e+S4H1nR1YB0+M7WrplhJ3LEFJkVn33Gl9bofPbJeuvH3ytYprNlCxut1FuaIj9364FPSeUN4cpo5gGIzHTtFPlidZxyy+WeIlFjdMDjurA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615485; c=relaxed/simple;
	bh=uWE1HU+5tZUDSzRHvf0ewTtU7idX70QGnTnxQha4bLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR7vcIsvwxDrwVs7Yf5s6yRWhPBNx6DV6kJoSBvoAhAYxbXGjl+N92lV0+bqvowsqsnsLQpSXOGKx7zN3WwWF4hr6V17wjRO+nBmX5QR6xej9Fq6V5wyev9q6vPu4BZ8w2urJXM5eYZOvXeG8fKVCKkT/mKdTWBRbUV9jRH7AD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=fOCTWDz1; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 2F61778A00;
	Fri,  6 Sep 2024 17:38:00 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 2F61778A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725615481;
	bh=fPuodRfmaTupdvzBrA91yFT2O0NMhuRwoRu03bUlJyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOCTWDz11oAmKxyxl7ZNdmbpva9MP9akIqev1VahbWt5bdWFmUOdYMGm5+0qeuoCr
	 iMxQgOnQriG+LMDiyffm9a8iHxRXGAYQH2vamqlladTL19ZKsyiSvXitrd+IdvKqsG
	 uxac2OsEj2ioQgmi4Ol8BKjc62ppZ0lwqU6AG76I=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>
Subject: [PATCH 2/9] power: reset: add Photonicat PMU poweroff driver
Date: Fri,  6 Sep 2024 17:36:23 +0800
Message-ID: <20240906093630.2428329-3-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906093630.2428329-1-bigfoot@classfun.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver implements the shutdown function of Photonicat PMU:

- Host notifies PMU to shutdown:
  When powering off, a shutdown command (0x0F) needs to be sent
  to the MCU.

- PMU notifies host to shutdown:
  If the power button is long pressed, the MCU will send a shutdown
  command (0x0D) to the system.
  If system does not shutdown within 60 seconds,
  the power will be turned off directly.

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 drivers/power/reset/Kconfig               | 12 +++
 drivers/power/reset/Makefile              |  1 +
 drivers/power/reset/photonicat-poweroff.c | 95 +++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 drivers/power/reset/photonicat-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index fece990af4a7..c59529ce25a2 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -148,6 +148,18 @@ config POWER_RESET_ODROID_GO_ULTRA_POWEROFF
 	help
 	  This driver supports Power off for Odroid Go Ultra device.
 
+config POWER_RESET_PHOTONICAT_POWEROFF
+	tristate "Photonicat PMU power-off driver"
+	depends on MFD_PHOTONICAT_PMU
+	help
+	  This driver supports Power off for Photonicat PMU device.
+
+	  Supports operations:
+	    Host notifies PMU to shutdown
+	    PMU notifies host to shutdown
+
+	  Say Y if you have a Photonicat board.
+
 config POWER_RESET_PIIX4_POWEROFF
 	tristate "Intel PIIX4 power-off driver"
 	depends on PCI
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index a95d1bd275d1..339b36812b95 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_POWER_RESET_MT6323) += mt6323-poweroff.o
 obj-$(CONFIG_POWER_RESET_QCOM_PON) += qcom-pon.o
 obj-$(CONFIG_POWER_RESET_OCELOT_RESET) += ocelot-reset.o
 obj-$(CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF) += odroid-go-ultra-poweroff.o
+obj-$(CONFIG_POWER_RESET_PHOTONICAT_POWEROFF) += photonicat-poweroff.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) += piix4-poweroff.o
 obj-$(CONFIG_POWER_RESET_LTC2952) += ltc2952-poweroff.o
 obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
diff --git a/drivers/power/reset/photonicat-poweroff.c b/drivers/power/reset/photonicat-poweroff.c
new file mode 100644
index 000000000000..f9f1ea179247
--- /dev/null
+++ b/drivers/power/reset/photonicat-poweroff.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Junhao Xie <bigfoot@classfun.cn>
+ */
+
+#include <linux/mfd/photonicat-pmu.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+struct pcat_poweroff {
+	struct device *dev;
+	struct pcat_pmu *pmu;
+	struct notifier_block nb;
+};
+
+static int pcat_do_poweroff(struct sys_off_data *data)
+{
+	struct pcat_poweroff *poweroff = data->cb_data;
+
+	dev_info(poweroff->dev, "Host request PMU shutdown\n");
+	pcat_pmu_write_data(poweroff->pmu, PCAT_CMD_HOST_REQUEST_SHUTDOWN,
+			    NULL, 0);
+
+	return NOTIFY_DONE;
+}
+
+static int pcat_poweroff_notify(struct notifier_block *nb, unsigned long action,
+				void *data)
+{
+	struct pcat_poweroff *poweroff =
+		container_of(nb, struct pcat_poweroff, nb);
+
+	if (action != PCAT_CMD_PMU_REQUEST_SHUTDOWN)
+		return NOTIFY_DONE;
+
+	dev_info(poweroff->dev, "PMU request host shutdown\n");
+	orderly_poweroff(true);
+
+	return NOTIFY_DONE;
+}
+
+static int pcat_poweroff_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct pcat_poweroff *poweroff;
+
+	poweroff = devm_kzalloc(dev, sizeof(*poweroff), GFP_KERNEL);
+	if (!poweroff)
+		return -ENOMEM;
+
+	poweroff->dev = dev;
+	poweroff->pmu = dev_get_drvdata(dev->parent);
+	poweroff->nb.notifier_call = pcat_poweroff_notify;
+	platform_set_drvdata(pdev, poweroff);
+
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    pcat_do_poweroff,
+					    poweroff);
+	if (ret)
+		return ret;
+
+	return pcat_pmu_register_notify(poweroff->pmu, &poweroff->nb);
+}
+
+static void pcat_poweroff_remove(struct platform_device *pdev)
+{
+	struct pcat_poweroff *poweroff = platform_get_drvdata(pdev);
+
+	pcat_pmu_unregister_notify(poweroff->pmu, &poweroff->nb);
+}
+
+static const struct of_device_id pcat_poweroff_dt_ids[] = {
+	{ .compatible = "ariaboard,photonicat-pmu-poweroff", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pcat_poweroff_dt_ids);
+
+static struct platform_driver pcat_poweroff_driver = {
+	.driver = {
+		.name = "photonicat-poweroff",
+		.of_match_table = pcat_poweroff_dt_ids,
+	},
+	.probe = pcat_poweroff_probe,
+	.remove = pcat_poweroff_remove,
+};
+module_platform_driver(pcat_poweroff_driver);
+
+MODULE_AUTHOR("Junhao Xie <bigfoot@classfun.cn>");
+MODULE_DESCRIPTION("Photonicat PMU Poweroff");
+MODULE_LICENSE("GPL");
-- 
2.46.0


