Return-Path: <linux-pm+bounces-15594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E099C185
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DA6282CCF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCFE14A4C7;
	Mon, 14 Oct 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="js8fchSs";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="YKLOVGQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919F149C7A;
	Mon, 14 Oct 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891532; cv=none; b=V9c/zwRwRRo8xvEC4QHjuHvkxaib1gjmAg+l5iu9qp2gomNMzbTgxddf/zu7/tR6yFnmOf7njTRTAu6jUXu/2f8buaJonMTzrEWLaiHM7OZnLvaxjt2ood7rF7wRybvwDik8Gr5RTY4RwLEhdtyH/lL/V+65NwvAMcP+HQEjMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891532; c=relaxed/simple;
	bh=hXwiaJsujF57M9a4+lPqhF/DWZkT5Kmxxr871kS+4m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWUXkwwE7ffqP4PHa+M/I/E+0XlUGIB17fc2wcaGsHMpE5+sB+C2jStc5kUcioG0jPAkm1khxlL0Elm2Czm04L8BKy16COYMNSuPpIIw6MbSrWsitD7gvqbRIJBEUhbwSW6WN9XFwiQkKRFtgOPHTuSOEXM6glWoGdcQ0RNAsfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=js8fchSs; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=YKLOVGQv; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 319C5122FE29;
	Mon, 14 Oct 2024 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728891529; bh=hXwiaJsujF57M9a4+lPqhF/DWZkT5Kmxxr871kS+4m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=js8fchSsHCLMxHgABXht3UMHSh+fVlRBGmE9PAYQrykNw0xY2UdJJv4r/jkdTvBo3
	 bYRZEyeYcA8+Rp9Jao8iHpNoAz0wkVZ7V6R+BU4XXB5+TyW5A3HHS3nebOlMeU0V+b
	 oREwAt5oRfMyAUvKGC7qvyecmxqUIp1Xm4lxpyz6y6H5Q+AWAelnBneECoCl3Vqko+
	 x4182UMv5+8EHPInVUHDvzyHYPg15TIRKPWLRQHyfDWHuSCPgIyW7fL38dvVCYP5U9
	 qdyJAUGOg1HMyrzlUR1J5F6vQbTyHvmiBvfXDgTo5JCzV/6aCOqh4AMwn1VXHFoPuu
	 ilnYH7LZ3Ek1A==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qAbo-MGPcEAK; Mon, 14 Oct 2024 00:38:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [110.52.220.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 2E178122FE1E;
	Mon, 14 Oct 2024 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728891528; bh=hXwiaJsujF57M9a4+lPqhF/DWZkT5Kmxxr871kS+4m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKLOVGQvU0R48d6tO5iwOzL3uJJCNt0EjD6HMOFreq49tlzwhZsRVmpgzflRvqZMc
	 7mqw3B9MGMAh3kETQv/E8qD2dMp5WCZZvPOkKmuT02zAmXo5PWKtz6o4r0x/W5jsfp
	 lBpCSNWGK5grihw4U3PvvzRjwJtbqiXFXzSxOVExpo5NXocrgqYNFi5QICOhR+JdHd
	 p+QZ4FbYKcCmCGi1tF4ab6HiSQAgm/Asyk8eYvhLTmh2jGs7D6QO0r9D9uX6+aJKqb
	 YHkQ0rqVU/VWXq/AKVWED3jS5rQd2+/Cz1CPp7KpWRslToRTS7H7KHD8AxndlrqyeG
	 ObjoOZvXPOYYg==
From: Haylen Chu <heylenay@4d2.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v5 2/3] thermal: cv1800: Add cv1800 thermal driver support
Date: Mon, 14 Oct 2024 07:38:12 +0000
Message-ID: <20241014073813.23984-3-heylenay@4d2.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014073813.23984-1-heylenay@4d2.org>
References: <20241014073813.23984-1-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for cv1800 SoC integrated thermal sensors. Temperature is
calculated with a curve-fitted formula. Threshold registers are set as
specified by trip points and the thermal zone will be updated on
threshold violation interrupts.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
---
 drivers/thermal/Kconfig          |   6 +
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/cv1800_thermal.c | 296 +++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/thermal/cv1800_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 61e7ae524b1f..901524ba8b38 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -499,4 +499,10 @@ config LOONGSON2_THERMAL
 	  is higher than the high temperature threshold or lower than the low
 	  temperature threshold, the interrupt will occur.
 
+config CV1800_THERMAL
+	tristate "Temperature sensor driver for Sophgo CV1800"
+	help
+	  If you say yes here you get support for thermal sensor integrated in
+	  Sophgo CV1800 SoC.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 41c4d56beb40..b1890b570f9b 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -63,4 +63,5 @@ obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
 obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
+obj-$(CONFIG_CV1800_THERMAL)	+= cv1800_thermal.o
 obj-$(CONFIG_THERMAL_CORE_TESTING)	+= testing/
diff --git a/drivers/thermal/cv1800_thermal.c b/drivers/thermal/cv1800_thermal.c
new file mode 100644
index 000000000000..588fc2da06e1
--- /dev/null
+++ b/drivers/thermal/cv1800_thermal.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Sophgo Inc.
+ * Copyright (C) 2024 Haylen Chu <heylenay@4d2.org>
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#define TEMPSEN_VERSION					0x0
+#define TEMPSEN_CTRL					0x4
+#define  TEMPSEN_CTRL_EN				BIT(0)
+#define  TEMPSEN_CTRL_SEL_MASK				GENMASK(7, 4)
+#define  TEMPSEN_CTRL_SEL_OFFSET			4
+#define TEMPSEN_STATUS					0x8
+#define TEMPSEN_SET					0xc
+#define  TEMPSEN_SET_CHOPSEL_MASK			GENMASK(5, 4)
+#define  TEMPSEN_SET_CHOPSEL_OFFSET			4
+#define  TEMPSEN_SET_CHOPSEL_128T			0
+#define  TEMPSEN_SET_CHOPSEL_256T			1
+#define  TEMPSEN_SET_CHOPSEL_512T			2
+#define  TEMPSEN_SET_CHOPSEL_1024T			3
+#define  TEMPSEN_SET_ACCSEL_MASK			GENMASK(7, 6)
+#define  TEMPSEN_SET_ACCSEL_OFFSET			6
+#define  TEMPSEN_SET_ACCSEL_512T			0
+#define  TEMPSEN_SET_ACCSEL_1024T			1
+#define  TEMPSEN_SET_ACCSEL_2048T			2
+#define  TEMPSEN_SET_ACCSEL_4096T			3
+#define  TEMPSEN_SET_CYC_CLKDIV_MASK			GENMASK(15, 8)
+#define  TEMPSEN_SET_CYC_CLKDIV_OFFSET			8
+#define TEMPSEN_INTR_EN					0x10
+#define TEMPSEN_INTR_CLR				0x14
+#define TEMPSEN_INTR_STA				0x18
+#define TEMPSEN_INTR_RAW				0x1c
+#define  TEMPSEN_INTR_THRESHOLD_HIGH(n)			BIT(4 + (n))
+#define  TEMPSEN_INTR_THRESHOLD_LOW(n)			BIT(8 + (n))
+#define TEMPSEN_RESULT(n)				(0x20 + (n) * 4)
+#define  TEMPSEN_RESULT_RESULT_MASK			GENMASK(12, 0)
+#define  TEMPSEN_RESULT_MAX_RESULT_MASK			GENMASK(28, 16)
+#define  TEMPSEN_RESULT_CLR_MAX_RESULT			BIT(31)
+#define TEMPSEN_THRESHOLD(n)				(0x40 + (n) * 4)
+#define  TEMPSEN_THRESHOLD_HIGH_OFFSET			0
+#define  TEMPSEN_THRESHOLD_LOW_OFFSET			16
+#define TEMPSEN_AUTO_PERIOD				0x64
+#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK		GENMASK(23, 0)
+#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET		0
+
+struct cv1800_thermal_zone {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *clk_tempsen;
+	u32 sample_cycle;
+};
+
+static void cv1800_thermal_init(struct cv1800_thermal_zone *ctz)
+{
+	void __iomem *base = ctz->base;
+	u32 regval;
+
+	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
+	writel(TEMPSEN_RESULT_CLR_MAX_RESULT, base + TEMPSEN_RESULT(0));
+
+	regval = readl(base + TEMPSEN_SET);
+	regval &= ~TEMPSEN_SET_CHOPSEL_MASK;
+	regval &= ~TEMPSEN_SET_ACCSEL_MASK;
+	regval &= ~TEMPSEN_SET_CYC_CLKDIV_MASK;
+	regval |= TEMPSEN_SET_CHOPSEL_1024T << TEMPSEN_SET_CHOPSEL_OFFSET;
+	regval |= TEMPSEN_SET_ACCSEL_2048T << TEMPSEN_SET_ACCSEL_OFFSET;
+	regval |= 0x31 << TEMPSEN_SET_CYC_CLKDIV_OFFSET;
+	writel(regval, base + TEMPSEN_SET);
+
+	regval = readl(base + TEMPSEN_AUTO_PERIOD);
+	regval &= ~TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK;
+	regval |= ctz->sample_cycle << TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET;
+	writel(regval, base + TEMPSEN_AUTO_PERIOD);
+
+	regval = readl(base + TEMPSEN_CTRL);
+	regval &= ~TEMPSEN_CTRL_SEL_MASK;
+	regval |= 1 << TEMPSEN_CTRL_SEL_OFFSET;
+	regval |= TEMPSEN_CTRL_EN;
+	writel(regval, base + TEMPSEN_CTRL);
+}
+
+static void cv1800_thermal_deinit(struct cv1800_thermal_zone *ctz)
+{
+	void __iomem *base = ctz->base;
+	u32 regval;
+
+	regval = readl(base + TEMPSEN_CTRL);
+	regval &= ~(TEMPSEN_CTRL_SEL_MASK | TEMPSEN_CTRL_EN);
+	writel(regval, base + TEMPSEN_CTRL);
+
+	writel(0, base + TEMPSEN_INTR_EN);
+}
+
+/*
+ *	Raw register value to temperature (mC) formula:
+ *
+ *		       read_val * 1000 * 716
+ *	Temperature = ----------------------- - 273000
+ *				divider
+ *
+ *	where divider should be ticks number of accumulation period,
+ *	e.g. 2048 for TEMPSEN_CTRL_ACCSEL_2048T
+ */
+static int cv1800_calc_temp(u32 result)
+{
+	return (result * 1000) * 716 / 2048 - 273000;
+}
+
+static u32 cv1800_calc_raw(int temp)
+{
+	return (temp + 273000) * 2048 / (1000 * 716);
+}
+
+static int cv1800_set_threshold(struct cv1800_thermal_zone *ctz,
+				int low, int high)
+{
+	writel((cv1800_calc_raw(low) << TEMPSEN_THRESHOLD_LOW_OFFSET) |
+	       (cv1800_calc_raw(high) << TEMPSEN_THRESHOLD_HIGH_OFFSET),
+	       ctz->base + TEMPSEN_THRESHOLD(0));
+	writel(TEMPSEN_INTR_THRESHOLD_LOW(0) | TEMPSEN_INTR_THRESHOLD_HIGH(0),
+	       ctz->base + TEMPSEN_INTR_EN);
+
+	return 0;
+}
+
+static irqreturn_t cv1800_irq_thread(int irq, void *dev)
+{
+	struct thermal_zone_device *tdev = dev;
+	struct cv1800_thermal_zone *ctz = thermal_zone_device_priv(tdev);
+
+	writel(readl(ctz->base + TEMPSEN_INTR_RAW),
+	       ctz->base + TEMPSEN_INTR_CLR);
+
+	thermal_zone_device_update(tdev, THERMAL_EVENT_UNSPECIFIED);
+
+	return IRQ_HANDLED;
+}
+
+static int cv1800_get_temp(struct thermal_zone_device *tdev, int *temperature)
+{
+	struct cv1800_thermal_zone *ctz = thermal_zone_device_priv(tdev);
+	void __iomem *base = ctz->base;
+	u32 result;
+
+	result = readl(base + TEMPSEN_RESULT(0)) & TEMPSEN_RESULT_RESULT_MASK;
+	*temperature = cv1800_calc_temp(result);
+
+	return 0;
+}
+
+static int cv1800_set_trips(struct thermal_zone_device *tdev, int low, int high)
+{
+	struct cv1800_thermal_zone *ctz = thermal_zone_device_priv(tdev);
+
+	return cv1800_set_threshold(ctz,
+				    clamp(low, -273 * 1000, 200 * 1000),
+				    clamp(high, -273 * 1000, 200 * 1000));
+}
+
+static const struct thermal_zone_device_ops cv1800_thermal_ops = {
+	.get_temp	= cv1800_get_temp,
+	.set_trips	= cv1800_set_trips,
+};
+
+static const struct of_device_id cv1800_thermal_of_match[] = {
+	{ .compatible = "sophgo,cv1800-thermal" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv1800_thermal_of_match);
+
+static int
+cv1800_parse_dt(struct cv1800_thermal_zone *ctz)
+{
+	struct device_node *np = ctz->dev->of_node;
+	u32 tmp;
+
+	if (of_property_read_u32(np, "sample-rate-hz", &tmp)) {
+		ctz->sample_cycle = 1000000;
+	} else {
+		/* sample cycle should be at least 524us */
+		if (tmp > 1000000 / 524) {
+			dev_err(ctz->dev, "invalid sample rate %d\n", tmp);
+			return -EINVAL;
+		}
+
+		ctz->sample_cycle = 1000000 / tmp;
+	}
+
+	return 0;
+}
+
+static int cv1800_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *tdev;
+	struct cv1800_thermal_zone *ctz;
+	struct resource *res;
+	int ret, irq;
+
+	ctz = devm_kzalloc(&pdev->dev, sizeof(*ctz), GFP_KERNEL);
+	if (!ctz)
+		return -ENOMEM;
+
+	ctz->dev = &pdev->dev;
+
+	ret = cv1800_parse_dt(ctz);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to parse dt\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctz->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctz->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->base),
+				     "failed to map tempsen registers\n");
+
+	ctz->clk_tempsen = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(ctz->clk_tempsen))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
+				     "failed to get clk_tempsen\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	cv1800_thermal_init(ctz);
+
+	tdev = devm_thermal_of_zone_register(&pdev->dev, 0, ctz,
+					     &cv1800_thermal_ops);
+	if (IS_ERR(tdev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tdev),
+				     "failed to register thermal zone\n");
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					cv1800_irq_thread, IRQF_ONESHOT,
+					"cv1800_thermal", tdev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to request irq\n");
+
+	platform_set_drvdata(pdev, ctz);
+
+	return 0;
+}
+
+static void cv1800_thermal_remove(struct platform_device *pdev)
+{
+	struct cv1800_thermal_zone *ctz = platform_get_drvdata(pdev);
+
+	cv1800_thermal_deinit(ctz);
+}
+
+static int __maybe_unused cv1800_thermal_suspend(struct device *dev)
+{
+	struct cv1800_thermal_zone *ctz = dev_get_drvdata(dev);
+
+	cv1800_thermal_deinit(ctz);
+	clk_disable_unprepare(ctz->clk_tempsen);
+
+	return 0;
+}
+
+static int __maybe_unused cv1800_thermal_resume(struct device *dev)
+{
+	struct cv1800_thermal_zone *ctz = dev_get_drvdata(dev);
+
+	clk_prepare_enable(ctz->clk_tempsen);
+	cv1800_thermal_init(ctz);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(cv1800_thermal_pm_ops,
+			 cv1800_thermal_suspend, cv1800_thermal_resume);
+
+static struct platform_driver cv1800_thermal_driver = {
+	.probe = cv1800_thermal_probe,
+	.remove = cv1800_thermal_remove,
+	.driver = {
+		.name = "cv1800-thermal",
+		.pm = &cv1800_thermal_pm_ops,
+		.of_match_table = cv1800_thermal_of_match,
+	},
+};
+
+module_platform_driver(cv1800_thermal_driver);
+
+MODULE_DESCRIPTION("Sophgo CV1800 thermal driver");
+MODULE_AUTHOR("Haylen Chu <heylenay@4d2.org>");
+MODULE_LICENSE("GPL");
-- 
2.46.2


