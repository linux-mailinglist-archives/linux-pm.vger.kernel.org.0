Return-Path: <linux-pm+bounces-41062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C4D39C7F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 03:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CD84300A1EE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A2257854;
	Mon, 19 Jan 2026 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q773TddP"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AEAC8CE;
	Mon, 19 Jan 2026 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790565; cv=none; b=homuxH985nFZSAN0kxpFh0k4/qrP6ic+VDVEbyRNbe6oYWM8oJH2s3QgwkEJIo7B3UOnYfpcaHdhgU0d+V0IeJxukRuQHahb6YdOTfT8mCuHqr/Oh+znLSnY9eo7pR6yts4cUo8oxASi7DXrgUULvf761rCl+xz6DRsUA0LTdf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790565; c=relaxed/simple;
	bh=SqhRICDvd/YB575WouEr3ndp2i8m5xadfy5Rb+Noi+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sle6w18zt02nLGzNzTis2vCw9pmFXAEr9ZNPoeyVXQSmJthZDFINJy6RdR12qZbTJmhvlkL8H9R5KfnUbOfXgv3/FHpuor5J2HKlAVqFm2uQ3KLYD4HjAYrXX1ays/zdZiq1lWTOt50bEgVIXM/enn+6RY6oi7Ln1MGhkazz7Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q773TddP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=aaX2UrhdB4rQdKfarfCkzxhRZCsZePP0jL1LtzjcHqY=;
	b=Q773TddPLxmn/f9VXgwC7z3UZuxvAOCAs1ZF9Efto9SlHEW3xH3ZAJO81RhBLJ
	Nw4lq6HcdsYi5ES86hBf9SQLK7oes6vl0VOS/SdH8oa168hSlEBeiCMeptMdjSWQ
	3o81z/wMaKCGD+hkB7RSWwWZNIWjm+1KrCJSjEgKBGPo4=
Received: from [113.54.162.98] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXQfnSmW1pNwHHLg--.6S4;
	Mon, 19 Jan 2026 10:41:31 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Date: Mon, 19 Jan 2026 10:41:22 +0800
Subject: [PATCH v3 2/3] thermal: spacemit: k1: Add thermal sensor support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-patchv2-k1-thermal-v3-2-3d82c9ebe8a4@163.com>
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
In-Reply-To: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Shuwei Wu <shuweiwoo@163.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768790485; l=11788;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=SqhRICDvd/YB575WouEr3ndp2i8m5xadfy5Rb+Noi+4=;
 b=wjwOibNCddNmnzBL6beecOympoArf9csoub+bAxKWfVOe2S2oOiLr27obebKKM0HtQq7ua+Jk
 6fLERP76vwXAVdHFvqqAP6IGUhybha0FAHofyjM5+ssHy2yEceEGqRc
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:PygvCgAXQfnSmW1pNwHHLg--.6S4
X-Coremail-Antispam: 1Uf129KBjvJXoWfJFyDuFW3Zw4rtw17GFWfKrg_yoWktF13pF
	4DGrZrArWUGF4xC3Z7ZFsrAFWaqa12yFWjgrn29w45ZFs8Ary7W3W0q34Yvry8ury5uF45
	tw4qqr43C34DG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziBMKXUUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/xtbC5BtS4GltmduFEAAA3e

The thermal sensor on K1 supports monitoring five temperature zones.
The driver registers these sensors with the thermal framework
and supports standard operations:
- Reading temperature (millidegree Celsius)
- Setting high/low thresholds for interrupts

Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
---
Changes in v3:
- Align multi-line assignments as suggested by reviewer
- Remove unnecessary variable definitions

Changes in v2:
- Rename k1_thermal.c to k1_tsensor.c for better hardware alignment
- Move driver to drivers/thermal/spacemit/
- Add Kconfig/Makefile for spacemit and update top-level build files
- Refactor names, style, code alignment, and comments
- Simplify probe and error handling
---
 drivers/thermal/Kconfig               |   2 +
 drivers/thermal/Makefile              |   1 +
 drivers/thermal/spacemit/Kconfig      |  19 +++
 drivers/thermal/spacemit/Makefile     |   3 +
 drivers/thermal/spacemit/k1_tsensor.c | 281 ++++++++++++++++++++++++++++++++++
 5 files changed, 306 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b10080d61860..1c4a5cd5a23e 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -472,6 +472,8 @@ endmenu
 
 source "drivers/thermal/renesas/Kconfig"
 
+source "drivers/thermal/spacemit/Kconfig"
+
 source "drivers/thermal/tegra/Kconfig"
 
 config GENERIC_ADC_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index bb21e7ea7fc6..3b249195c088 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -65,6 +65,7 @@ obj-y				+= mediatek/
 obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
+obj-y				+= spacemit/
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
 obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
diff --git a/drivers/thermal/spacemit/Kconfig b/drivers/thermal/spacemit/Kconfig
new file mode 100644
index 000000000000..fbfd22f8fcd3
--- /dev/null
+++ b/drivers/thermal/spacemit/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "SpacemiT thermal drivers"
+depends on ARCH_SPACEMIT || COMPILE_TEST
+
+config SPACEMIT_K1_TSENSOR
+	tristate "SpacemiT K1 thermal sensor driver"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	help
+	  This driver provides support for the thermal sensor
+	  integrated in the SpacemiT K1 SoC.
+
+	  The thermal sensor monitors temperatures for five thermal zones:
+	  soc, package, gpu, cluster0, and cluster1. It supports reporting
+	  temperature values and handling high/low threshold interrupts.
+
+	  Say Y here if you want to enable thermal monitoring on SpacemiT K1.
+	  If compiled as a module, it will be called k1_tsensor.
+
+endmenu
diff --git a/drivers/thermal/spacemit/Makefile b/drivers/thermal/spacemit/Makefile
new file mode 100644
index 000000000000..82b30741e4ec
--- /dev/null
+++ b/drivers/thermal/spacemit/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SPACEMIT_K1_TSENSOR)	+= k1_tsensor.o
diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
new file mode 100644
index 000000000000..4788ab47a086
--- /dev/null
+++ b/drivers/thermal/spacemit/k1_tsensor.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Thermal sensor driver for SpacemiT K1 SoC
+ *
+ * Copyright (C) 2026 Shuwei Wu <shuweiwoo@163.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "../thermal_hwmon.h"
+
+#define K1_TSENSOR_PCTRL_REG		0x00
+#define K1_TSENSOR_PCTRL_ENABLE		BIT(0)
+#define K1_TSENSOR_PCTRL_TEMP_MODE	BIT(3)
+#define K1_TSENSOR_PCTRL_RAW_SEL	BIT(7)
+
+#define K1_TSENSOR_PCTRL_CTUNE		GENMASK(11, 8)
+#define K1_TSENSOR_PCTRL_SW_CTRL	GENMASK(21, 18)
+#define K1_TSENSOR_PCTRL_HW_AUTO_MODE	BIT(23)
+
+#define K1_TSENSOR_EN_REG		0x08
+#define K1_TSENSOR_EN_ALL		GENMASK(MAX_SENSOR_NUMBER - 1, 0)
+
+#define K1_TSENSOR_TIME_REG		0x0C
+#define K1_TSENSOR_TIME_WAIT_REF_CNT	GENMASK(3, 0)
+#define K1_TSENSOR_TIME_ADC_CNT_RST	GENMASK(7, 4)
+#define K1_TSENSOR_TIME_FILTER_PERIOD	GENMASK(21, 20)
+#define K1_TSENSOR_TIME_MASK		GENMASK(23, 0)
+
+#define K1_TSENSOR_INT_CLR_REG		0x10
+#define K1_TSENSOR_INT_EN_REG		0x14
+#define K1_TSENSOR_INT_STA_REG		0x18
+
+#define K1_TSENSOR_INT_EN_MASK		BIT(0)
+#define K1_TSENSOR_INT_MASK(x)		(GENMASK(2, 1) << ((x) * 2))
+
+#define K1_TSENSOR_DATA_BASE_REG	0x20
+#define K1_TSENSOR_DATA_REG(x)		(K1_TSENSOR_DATA_BASE_REG + ((x) / 2) * 4)
+#define K1_TSENSOR_DATA_LOW_MASK	GENMASK(15, 0)
+#define K1_TSENSOR_DATA_HIGH_MASK	GENMASK(31, 16)
+
+#define K1_TSENSOR_THRSH_BASE_REG	0x40
+#define K1_TSENSOR_THRSH_REG(x)		(K1_TSENSOR_THRSH_BASE_REG + ((x) * 4))
+#define K1_TSENSOR_THRSH_LOW_MASK	GENMASK(15, 0)
+#define K1_TSENSOR_THRSH_HIGH_MASK	GENMASK(31, 16)
+
+#define MAX_SENSOR_NUMBER		5
+
+/* Hardware offset value required for temperature calculation */
+#define TEMPERATURE_OFFSET		278
+
+struct k1_tsensor_channel {
+	struct k1_tsensor *ts;
+	struct thermal_zone_device *tzd;
+	int id;
+};
+
+struct k1_tsensor {
+	void __iomem *base;
+	struct k1_tsensor_channel ch[MAX_SENSOR_NUMBER];
+};
+
+static void k1_tsensor_init(struct k1_tsensor *ts)
+{
+	u32 val;
+
+	/* Disable all the interrupts */
+	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
+
+	/* Configure ADC sampling time and filter period */
+	val = readl(ts->base + K1_TSENSOR_TIME_REG);
+	val &= ~K1_TSENSOR_TIME_MASK;
+	val |= K1_TSENSOR_TIME_FILTER_PERIOD |
+	       K1_TSENSOR_TIME_ADC_CNT_RST |
+	       K1_TSENSOR_TIME_WAIT_REF_CNT;
+	writel(val, ts->base + K1_TSENSOR_TIME_REG);
+
+	/*
+	 * Enable all sensors' auto mode, enable dither control,
+	 * consecutive mode, and power up sensor.
+	 */
+	val = readl(ts->base + K1_TSENSOR_PCTRL_REG);
+	val &= ~K1_TSENSOR_PCTRL_SW_CTRL;
+	val &= ~K1_TSENSOR_PCTRL_CTUNE;
+	val |= K1_TSENSOR_PCTRL_RAW_SEL |
+	       K1_TSENSOR_PCTRL_TEMP_MODE |
+	       K1_TSENSOR_PCTRL_HW_AUTO_MODE |
+	       K1_TSENSOR_PCTRL_ENABLE;
+	writel(val, ts->base + K1_TSENSOR_PCTRL_REG);
+
+	/* Enable thermal interrupt */
+	val = readl(ts->base + K1_TSENSOR_INT_EN_REG);
+	val |= K1_TSENSOR_INT_EN_MASK;
+	writel(val, ts->base + K1_TSENSOR_INT_EN_REG);
+
+	/* Enable each sensor */
+	val = readl(ts->base + K1_TSENSOR_EN_REG);
+	val |= K1_TSENSOR_EN_ALL;
+	writel(val, ts->base + K1_TSENSOR_EN_REG);
+}
+
+static void k1_tsensor_enable_irq(struct k1_tsensor_channel *ch)
+{
+	struct k1_tsensor *ts = ch->ts;
+	u32 val;
+
+	val = readl(ts->base + K1_TSENSOR_INT_CLR_REG);
+	val |= K1_TSENSOR_INT_MASK(ch->id);
+	writel(val, ts->base + K1_TSENSOR_INT_CLR_REG);
+
+	val = readl(ts->base + K1_TSENSOR_INT_EN_REG);
+	val &= ~K1_TSENSOR_INT_MASK(ch->id);
+	writel(val, ts->base + K1_TSENSOR_INT_EN_REG);
+}
+
+/*
+ * The conversion formula used is:
+ * T(m°C) = (((raw_value & mask) >> shift) - TEMPERATURE_OFFSET) * 1000
+ */
+static int k1_tsensor_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct k1_tsensor_channel *ch = thermal_zone_device_priv(tz);
+	struct k1_tsensor *ts = ch->ts;
+	u32 val;
+
+	val = readl(ts->base + K1_TSENSOR_DATA_REG(ch->id));
+	if (ch->id % 2)
+		*temp = FIELD_GET(K1_TSENSOR_DATA_HIGH_MASK, val);
+	else
+		*temp = FIELD_GET(K1_TSENSOR_DATA_LOW_MASK, val);
+
+	*temp -= TEMPERATURE_OFFSET;
+	*temp *= 1000;
+
+	return 0;
+}
+
+/*
+ * For each sensor, the hardware threshold register is 32 bits:
+ * - Lower 16 bits [15:0] configure the low threshold temperature.
+ * - Upper 16 bits [31:16] configure the high threshold temperature.
+ */
+static int k1_tsensor_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct k1_tsensor_channel *ch = thermal_zone_device_priv(tz);
+	struct k1_tsensor *ts = ch->ts;
+	u32 val;
+
+	if (low >= high)
+		return -EINVAL;
+
+	if (low < 0)
+		low = 0;
+
+	high = high / 1000 + TEMPERATURE_OFFSET;
+	low = low / 1000 + TEMPERATURE_OFFSET;
+
+	val = readl(ts->base + K1_TSENSOR_THRSH_REG(ch->id));
+	val &= ~K1_TSENSOR_THRSH_HIGH_MASK;
+	val |= FIELD_PREP(K1_TSENSOR_THRSH_HIGH_MASK, high);
+
+	val &= ~K1_TSENSOR_THRSH_LOW_MASK;
+	val |= FIELD_PREP(K1_TSENSOR_THRSH_LOW_MASK, low);
+	writel(val, ts->base + K1_TSENSOR_THRSH_REG(ch->id));
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops k1_tsensor_ops = {
+	.get_temp = k1_tsensor_get_temp,
+	.set_trips = k1_tsensor_set_trips,
+};
+
+static irqreturn_t k1_tsensor_irq_thread(int irq, void *data)
+{
+	struct k1_tsensor *ts = (struct k1_tsensor *)data;
+	int mask, status, i;
+
+	status = readl(ts->base + K1_TSENSOR_INT_STA_REG);
+
+	for (i = 0; i < MAX_SENSOR_NUMBER; i++) {
+		if (status & K1_TSENSOR_INT_MASK(i)) {
+			mask = readl(ts->base + K1_TSENSOR_INT_CLR_REG);
+			mask |= K1_TSENSOR_INT_MASK(i);
+			writel(mask, ts->base + K1_TSENSOR_INT_CLR_REG);
+			thermal_zone_device_update(ts->ch[i].tzd, THERMAL_EVENT_UNSPECIFIED);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int k1_tsensor_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct k1_tsensor *ts;
+	struct reset_control *reset;
+	struct clk *clk;
+	int i, irq, ret;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ts->base))
+		return dev_err_probe(dev, PTR_ERR(ts->base), "Failed to get reg\n");
+
+	reset = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get/deassert reset control\n");
+
+	clk = devm_clk_get_enabled(dev, "core");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get core clock\n");
+
+	clk = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get bus clock\n");
+
+	k1_tsensor_init(ts);
+
+	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
+		ts->ch[i].id = i;
+		ts->ch[i].ts = ts;
+		ts->ch[i].tzd = devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_tsensor_ops);
+		if (IS_ERR(ts->ch[i].tzd))
+			return PTR_ERR(ts->ch[i].tzd);
+
+		/* Attach sysfs hwmon attributes for userspace monitoring */
+		ret = devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
+		if (ret)
+			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
+
+		k1_tsensor_enable_irq(ts->ch + i);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					k1_tsensor_irq_thread,
+					IRQF_ONESHOT, "k1_tsensor", ts);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, ts);
+
+	return 0;
+}
+
+static const struct of_device_id k1_tsensor_dt_ids[] = {
+	{ .compatible = "spacemit,k1-tsensor" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, k1_tsensor_dt_ids);
+
+static struct platform_driver k1_tsensor_driver = {
+	.driver = {
+		.name		= "k1_tsensor",
+		.of_match_table = k1_tsensor_dt_ids,
+	},
+	.probe	= k1_tsensor_probe,
+};
+module_platform_driver(k1_tsensor_driver);
+
+MODULE_DESCRIPTION("SpacemiT K1 Thermal Sensor Driver");
+MODULE_AUTHOR("Shuwei Wu <shuweiwoo@163.com>");
+MODULE_LICENSE("GPL");

-- 
2.52.0


