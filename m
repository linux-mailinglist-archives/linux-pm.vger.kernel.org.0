Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024691187A6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 13:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfLJMIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 07:08:21 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41964 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLJMIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 07:08:21 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so7336560pjb.8;
        Tue, 10 Dec 2019 04:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0HuOzr3js6bx1a49Ey/KolOnoNvrg5PlFhq4psSm0UI=;
        b=Zm43JEJxc0FJCiu2sL/JtQkyA8kvovaAJdpoXiIOT7jTJWSK/TiEu0lk6PZdRZ6gkH
         Pfuq+Nq7CKiAgkfozh97gQhTKZ1ZdYfvla8fA9/M3cDoIqy7bIkW8ls+BxrRt12htksD
         LmPDm+rcdqMlwyFOdQnHkVo2n+bTYxRU6z1gX4UtIjly0JOxHqb/wmHTfs3hIkMFbJoa
         QE6esvLbBLg8B6fgWqFOMJj84mzc+FfYXWTGhb1Jl9ZDKx8wxG9Fx9TWshU/QmEmJibj
         /5sibhrwfA1Tgn3W0b0WLE3MpaRjX7xrsSlFJS3sdMm7mUNfFqYlnLin64HBNg4InOad
         Tc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0HuOzr3js6bx1a49Ey/KolOnoNvrg5PlFhq4psSm0UI=;
        b=mmPWCELD9hfycskNXSgY1CN5Wa7JnW+Rw8gaJqzLWBDsNoRiDYYwFcP2RYzPrDiQbE
         RLk/8RQtS3X2yGN8U9bupk1vu+ql6ybU9FR9YXSACdxgv1r+oa39skvO9xYqK8nVkouv
         0n6C+3dmr4zO4y+AWTRG5fylyJwKVcpME0aju7jwXFz9MfgP1h6btDKPIQvXXoZgOO5b
         /vCjMG+PCQb6lnY2nyJE0gL4S5RdVDKDi/Wui5lQ2tJaSA9kCJlojDLRQf8dCnz3Tw/D
         ruSTDDT1DmB6u6jV2tRraLu1qu99UMcG8hth4sbEOig1ffNLeRO8r8aKHigzVjX43kc9
         cMhw==
X-Gm-Message-State: APjAAAUMx1Pc+QZPfotdmSQoD30Ec//UhwisHLmdks8jqVNvyNAr7cqS
        ZzIrcAT+4GKJ93kNJFdlUDE=
X-Google-Smtp-Source: APXvYqxJUDwtVnz7leOtwDIH2XmWbtXJOuLFNbtFPNEiMUnRUz6TRKHUzUva4H/Ao+tDiuj9QKH8lQ==
X-Received: by 2002:a17:90a:2710:: with SMTP id o16mr4886371pje.110.1575979699929;
        Tue, 10 Dec 2019 04:08:19 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r193sm3440295pfr.100.2019.12.10.04.08.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 04:08:19 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, freeman.liu@unisoc.com,
        zhang.lyra@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] thermal: sprd: Add Spreadtrum thermal driver support
Date:   Tue, 10 Dec 2019 20:07:18 +0800
Message-Id: <dd3303a956e7dd5c065ac2b92b1dea7ee5d1df17.1575978484.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
In-Reply-To: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

This patch adds the support for Spreadtrum thermal sensor controller,
which can support maximum 8 sensors.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v1:
 - None.
---
 drivers/thermal/Kconfig        |    7 +
 drivers/thermal/Makefile       |    1 +
 drivers/thermal/sprd_thermal.c |  548 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 556 insertions(+)
 create mode 100644 drivers/thermal/sprd_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 59b79fc..646873d 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -429,4 +429,11 @@ config UNIPHIER_THERMAL
 	  Enable this to plug in UniPhier on-chip PVT thermal driver into the
 	  thermal framework. The driver supports CPU thermal zone temperature
 	  reporting and a couple of trip points.
+
+config SPRD_THERMAL
+	tristate "Temperature sensor on Spreadtrum SoCs"
+	depends on ARCH_SPRD || COMPILE_TEST
+	help
+	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
+	  framework.
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index baeb70b..544d867 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
 obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
+obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
new file mode 100644
index 0000000..d9b6074
--- /dev/null
+++ b/drivers/thermal/sprd_thermal.c
@@ -0,0 +1,548 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Spreadtrum Communications Inc.
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#define SPRD_THM_CTL			0x0
+#define SPRD_THM_INT_EN			0x4
+#define SPRD_THM_INT_STS		0x8
+#define SPRD_THM_INT_RAW_STS		0xc
+#define SPRD_THM_DET_PERIOD		0x10
+#define SPRD_THM_INT_CLR		0x14
+#define SPRD_THM_INT_CLR_ST		0x18
+#define SPRD_THM_MON_PERIOD		0x4c
+#define SPRD_THM_MON_CTL		0x50
+#define SPRD_THM_INTERNAL_STS1		0x54
+#define SPRD_THM_RAW_READ_MSK		0x3ff
+
+#define SPRD_THM_OFFSET(id)		((id) * 0x4)
+#define SPRD_THM_TEMP(id)		(SPRD_THM_OFFSET(id) + 0x5c)
+#define SPRD_THM_THRES(id)		(SPRD_THM_OFFSET(id) + 0x2c)
+
+#define SPRD_THM_SEN(id)		BIT((id) + 2)
+#define SPRD_THM_SEN_OVERHEAT_EN(id)	BIT((id) + 8)
+#define SPRD_THM_SEN_OVERHEAT_ALARM_EN(id)	BIT((id) + 0)
+
+/* bits definitions for register THM_CTL */
+#define SPRD_THM_SET_RDY_ST		BIT(13)
+#define SPRD_THM_SET_RDY		BIT(12)
+#define SPRD_THM_MON_EN			BIT(1)
+#define SPRD_THM_EN			BIT(0)
+
+/* bits definitions for register THM_INT_CTL */
+#define SPRD_THM_BIT_INT_EN		BIT(26)
+#define SPRD_THM_OVERHEAT_EN		BIT(25)
+#define SPRD_THM_OTP_TRIP_SHIFT		10
+
+/* bits definitions for register SPRD_THM_INTERNAL_STS1 */
+#define SPRD_THM_TEMPER_RDY		BIT(0)
+
+#define SPRD_THM_DET_PERIOD_DATA	0x800
+#define SPRD_THM_DET_PERIOD_MASK	GENMASK(19, 0)
+#define SPRD_THM_MON_MODE		0x7
+#define SPRD_THM_MON_MODE_MASK		GENMASK(3, 0)
+#define SPRD_THM_MON_PERIOD_DATA	0x10
+#define SPRD_THM_MON_PERIOD_MASK	GENMASK(15, 0)
+#define SPRD_THM_THRES_MASK		GENMASK(19, 0)
+#define SPRD_THM_INT_CLR_MASK		GENMASK(24, 0)
+
+/* thermal sensor calibration parameters */
+#define SPRD_THM_TEMP_LOW		-40000
+#define SPRD_THM_TEMP_HIGH		120000
+#define SPRD_THM_OTP_TEMP		120000
+#define SPRD_THM_HOT_TEMP		75000
+#define SPRD_THM_RAW_DATA_LOW		0
+#define SPRD_THM_RAW_DATA_HIGH		1000
+#define SPRD_THM_SEN_NUM		8
+#define SPRD_THM_DT_OFFSET		24
+#define SPRD_THM_RATION_OFFSET		17
+#define SPRD_THM_RATION_SIGN		16
+
+#define SPRD_THM_RDYST_POLLING_TIME	10
+#define SPRD_THM_RDYST_TIMEOUT		700
+#define SPRD_THM_TEMP_READY_POLL_TIME	10000
+#define SPRD_THM_TEMP_READY_TIMEOUT	600000
+#define SPRD_THM_MAX_SENSOR		8
+
+struct sprd_thermal_sensor {
+	struct thermal_zone_device *thmzone_dev;
+	struct sprd_thermal_data *data;
+	struct device *dev;
+	bool ready;
+	int cal_slope;
+	int cal_offset;
+	int last_temp;
+	int id;
+};
+
+struct sprd_thermal_data {
+	const struct sprd_thm_variant_data *var_data;
+	struct sprd_thermal_sensor *sensor[SPRD_THM_MAX_SENSOR];
+	struct clk *clk;
+	void __iomem *base;
+	u32 ratio_off;
+	u32 ratio_sign;
+	int nr_sensors;
+};
+
+/*
+ * The conversion between ADC and temperature is based on linear relationship,
+ * and use idea_k to specify the slope and ideal_b to specify the offset.
+ *
+ * Since different Spreadtrum SoCs have different ideal_k and ideal_b,
+ * we should save ideal_k and ideal_b in the device data structure.
+ */
+struct sprd_thm_variant_data {
+	u32 ideal_k;
+	u32 ideal_b;
+};
+
+static const struct sprd_thm_variant_data ums512_data = {
+	.ideal_k = 262,
+	.ideal_b = 66400,
+};
+
+static inline void sprd_thm_update_bits(void __iomem *reg, u32 mask, u32 val)
+{
+	u32 tmp, orig;
+
+	orig = readl(reg);
+	tmp = orig & ~mask;
+	tmp |= val & mask;
+	writel(tmp, reg);
+}
+
+static int sprd_thm_cal_read(struct device_node *np, const char *cell_id,
+			     u32 *val)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+
+	cell = of_nvmem_cell_get(np, cell_id);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	memcpy(val, buf, min(len, sizeof(u32)));
+
+	kfree(buf);
+	return 0;
+}
+
+static int sprd_thm_senor_calibration(struct device_node *np,
+				      struct sprd_thermal_data *thm,
+				      struct sprd_thermal_sensor *sen)
+{
+	int ret;
+	/*
+	 * According to thermal datasheet, the default calibration offset is 64,
+	 * and the default ratio is 1000.
+	 */
+	int dt_offset = 64, ratio = 1000;
+
+	ret = sprd_thm_cal_read(np, "sen_delta_cal", &dt_offset);
+	if (ret)
+		return ret;
+
+	if (thm->ratio_sign == 1)
+		ratio = 1000 - thm->ratio_off;
+	else
+		ratio = 1000 + thm->ratio_off;
+
+	/*
+	 * According to the ideal slope K and ideal offset B, combined with
+	 * calibration value of thermal from efuse, then calibrate the real
+	 * slope k and offset b:
+	 * k_cal = (k * ratio) / 1000.
+	 * b_cal = b + (dt_offset - 64) * 500.
+	 */
+	sen->cal_slope = (thm->var_data->ideal_k * ratio) / 1000;
+	sen->cal_offset = thm->var_data->ideal_b + (dt_offset - 128) * 250;
+
+	return 0;
+}
+
+static int sprd_thm_rawdata_to_temp(struct sprd_thermal_sensor *sen,
+				    u32 rawdata)
+{
+	if (rawdata < SPRD_THM_RAW_DATA_LOW)
+		rawdata = SPRD_THM_RAW_DATA_LOW;
+	else if (rawdata > SPRD_THM_RAW_DATA_HIGH)
+		rawdata = SPRD_THM_RAW_DATA_HIGH;
+
+	/*
+	 * According to the thermal datasheet, the formula of converting
+	 * adc value to the temperature value should be:
+	 * T_final = k_cal * x - b_cal.
+	 */
+	return sen->cal_slope * rawdata - sen->cal_offset;
+}
+
+static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
+{
+	u32 val;
+
+	if (temp < SPRD_THM_TEMP_LOW)
+		temp = SPRD_THM_TEMP_LOW;
+	else if (temp > SPRD_THM_TEMP_HIGH)
+		temp = SPRD_THM_TEMP_HIGH;
+
+	/*
+	 * According to the thermal datasheet, the formula of converting
+	 * adc value to the temperature value should be:
+	 * T_final = k_cal * x - b_cal.
+	 */
+	val = (temp + sen->cal_offset) / sen->cal_slope;
+
+	return val >= SPRD_THM_RAW_DATA_HIGH ? (SPRD_THM_RAW_DATA_HIGH - 1) : val;
+}
+
+static int sprd_thm_read_temp(void *devdata, int *temp)
+{
+	struct sprd_thermal_sensor *sen = devdata;
+	int sensor_temp;
+	u32 data;
+
+	data = readl(sen->data->base + SPRD_THM_TEMP(sen->id)) &
+		SPRD_THM_RAW_READ_MSK;
+
+	if (sen->ready) {
+		sensor_temp = sprd_thm_rawdata_to_temp(sen, data);
+		sen->last_temp = sensor_temp;
+		*temp = sensor_temp;
+	} else {
+		/*
+		 * If the sensor is not ready, then just return last
+		 * temperature value.
+		 */
+		*temp = sen->last_temp;
+	}
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops sprd_thm_ops = {
+	.get_temp = sprd_thm_read_temp,
+};
+
+static int sprd_thm_poll_ready_status(struct sprd_thermal_data *thm)
+{
+	u32 val;
+	int ret;
+
+	/*
+	 * Wait for thermal ready status before configuring thermal parameters.
+	 */
+	ret = readl_poll_timeout(thm->base + SPRD_THM_CTL, val,
+				 !(val & SPRD_THM_SET_RDY_ST),
+				 SPRD_THM_RDYST_POLLING_TIME,
+				 SPRD_THM_RDYST_TIMEOUT);
+	if (ret)
+		return ret;
+
+	sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_MON_EN,
+			     SPRD_THM_MON_EN);
+	sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_SET_RDY,
+			     SPRD_THM_SET_RDY);
+	return 0;
+}
+
+static int sprd_thm_wait_temp_ready(struct sprd_thermal_data *thm)
+{
+	u32 val;
+
+	/* Wait for first temperature data ready before reading temperature */
+	return readl_poll_timeout(thm->base + SPRD_THM_INTERNAL_STS1, val,
+				  !(val & SPRD_THM_TEMPER_RDY),
+				  SPRD_THM_TEMP_READY_POLL_TIME,
+				  SPRD_THM_TEMP_READY_TIMEOUT);
+}
+
+static int sprd_thm_set_ready(struct sprd_thermal_data *thm)
+{
+	int ret;
+
+	ret = sprd_thm_poll_ready_status(thm);
+	if (ret)
+		return ret;
+
+	/*
+	 * Clear interrupt status, enable thermal interrupt and enable thermal.
+	 */
+	writel(SPRD_THM_INT_CLR_MASK, thm->base + SPRD_THM_INT_CLR);
+	sprd_thm_update_bits(thm->base + SPRD_THM_INT_EN,
+			     SPRD_THM_BIT_INT_EN, SPRD_THM_BIT_INT_EN);
+	sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
+			     SPRD_THM_EN, SPRD_THM_EN);
+	return 0;
+}
+
+static void sprd_thm_sensor_init(struct sprd_thermal_data *thm,
+				 struct sprd_thermal_sensor *sen)
+{
+	u32 otp_rawdata, hot_rawdata;
+
+	otp_rawdata = sprd_thm_temp_to_rawdata(SPRD_THM_OTP_TEMP, sen);
+	hot_rawdata = sprd_thm_temp_to_rawdata(SPRD_THM_HOT_TEMP, sen);
+
+	/* Enable the sensor' overheat temperature protection interrupt */
+	sprd_thm_update_bits(thm->base + SPRD_THM_INT_EN,
+			     SPRD_THM_SEN_OVERHEAT_ALARM_EN(sen->id),
+			     SPRD_THM_SEN_OVERHEAT_ALARM_EN(sen->id));
+
+	/* Set the sensor' overheat and hot threshold temperature */
+	sprd_thm_update_bits(thm->base + SPRD_THM_THRES(sen->id),
+			     SPRD_THM_THRES_MASK,
+			     (otp_rawdata << SPRD_THM_OTP_TRIP_SHIFT) |
+			     hot_rawdata);
+
+	/* Enable the corresponding sensor */
+	sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_SEN(sen->id),
+			     SPRD_THM_SEN(sen->id));
+}
+
+static void sprd_thm_para_config(struct sprd_thermal_data *thm)
+{
+	/* Set the period of two valid temperature detection action */
+	sprd_thm_update_bits(thm->base + SPRD_THM_DET_PERIOD,
+			     SPRD_THM_DET_PERIOD_MASK, SPRD_THM_DET_PERIOD);
+
+	/* Set the sensors' monitor mode */
+	sprd_thm_update_bits(thm->base + SPRD_THM_MON_CTL,
+			     SPRD_THM_MON_MODE_MASK, SPRD_THM_MON_MODE);
+
+	/* Set the sensors' monitor period */
+	sprd_thm_update_bits(thm->base + SPRD_THM_MON_PERIOD,
+			     SPRD_THM_MON_PERIOD_MASK, SPRD_THM_MON_PERIOD);
+}
+
+static int sprd_thm_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *sen_child;
+	struct sprd_thermal_data *thm;
+	struct sprd_thermal_sensor *sen;
+	const struct sprd_thm_variant_data *pdata;
+	int ret, i;
+
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "No matching driver data found\n");
+		return -EINVAL;
+	}
+
+	thm = devm_kzalloc(&pdev->dev, sizeof(*thm), GFP_KERNEL);
+	if (!thm)
+		return -ENOMEM;
+
+	thm->var_data = pdata;
+	thm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (!thm->base)
+		return -ENOMEM;
+
+	thm->nr_sensors = of_get_child_count(np);
+	if (thm->nr_sensors == 0 || thm->nr_sensors > SPRD_THM_MAX_SENSOR) {
+		dev_err(&pdev->dev, "incorrect sensor count\n");
+		return -EINVAL;
+	}
+
+	thm->clk = devm_clk_get(&pdev->dev, "enable");
+	if (IS_ERR(thm->clk)) {
+		dev_err(&pdev->dev, "failed to get enable clock\n");
+		return PTR_ERR(thm->clk);
+	}
+
+	ret = clk_prepare_enable(thm->clk);
+	if (ret)
+		return ret;
+
+	sprd_thm_para_config(thm);
+
+	ret = sprd_thm_cal_read(np, "thm_sign_cal", &thm->ratio_sign);
+	if (ret)
+		goto disable_clk;
+
+	ret = sprd_thm_cal_read(np, "thm_ratio_cal", &thm->ratio_off);
+	if (ret)
+		goto disable_clk;
+
+	for_each_child_of_node(np, sen_child) {
+		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
+		if (!sen) {
+			ret = -ENOMEM;
+			goto disable_clk;
+		}
+
+		sen->ready = false;
+		sen->data = thm;
+		sen->dev = &pdev->dev;
+
+		ret = of_property_read_u32(sen_child, "reg", &sen->id);
+		if (ret) {
+			dev_err(&pdev->dev, "get sensor reg failed");
+			goto disable_clk;
+		}
+
+		ret = sprd_thm_senor_calibration(sen_child, thm, sen);
+		if (ret) {
+			dev_err(&pdev->dev, "efuse cal analysis failed");
+			goto disable_clk;
+		}
+
+		sprd_thm_sensor_init(thm, sen);
+
+		sen->thmzone_dev =
+			devm_thermal_zone_of_sensor_register(sen->dev, sen->id,
+							     sen, &sprd_thm_ops);
+		if (IS_ERR(sen->thmzone_dev)) {
+			dev_err(&pdev->dev, "register thermal zone failed %d\n",
+				sen->id);
+			ret = PTR_ERR(sen->thmzone_dev);
+			goto disable_clk;
+		}
+
+		thm->sensor[sen->id] = sen;
+	}
+
+	ret = sprd_thm_set_ready(thm);
+	if (ret)
+		goto disable_clk;
+
+	ret = sprd_thm_wait_temp_ready(thm);
+	if (ret)
+		goto disable_clk;
+
+	for (i = 0; i < thm->nr_sensors; i++)
+		thm->sensor[i]->ready = true;
+
+	platform_set_drvdata(pdev, thm);
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(thm->clk);
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void sprd_thm_hw_suspend(struct sprd_thermal_data *thm)
+{
+	int i;
+
+	for (i = 0; i < thm->nr_sensors; i++) {
+		sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
+				     SPRD_THM_SEN(thm->sensor[i]->id), 0);
+	}
+
+	sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
+			     SPRD_THM_EN, 0x0);
+}
+
+static int sprd_thm_suspend(struct device *dev)
+{
+	struct sprd_thermal_data *thm = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < thm->nr_sensors; i++)
+		thm->sensor[i]->ready = false;
+
+	sprd_thm_hw_suspend(thm);
+	clk_disable_unprepare(thm->clk);
+
+	return 0;
+}
+
+static int sprd_thm_hw_resume(struct sprd_thermal_data *thm)
+{
+	int ret, i;
+
+	for (i = 0; i < thm->nr_sensors; i++) {
+		sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
+				     SPRD_THM_SEN(thm->sensor[i]->id),
+				     SPRD_THM_SEN(thm->sensor[i]->id));
+	}
+
+	ret = sprd_thm_poll_ready_status(thm);
+	if (ret)
+		return ret;
+
+	writel(SPRD_THM_INT_CLR_MASK, thm->base + SPRD_THM_INT_CLR);
+	sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
+			     SPRD_THM_EN, SPRD_THM_EN);
+	return sprd_thm_wait_temp_ready(thm);
+}
+
+static int sprd_thm_resume(struct device *dev)
+{
+	struct sprd_thermal_data *thm = dev_get_drvdata(dev);
+	int ret, i;
+
+	ret = clk_prepare_enable(thm->clk);
+	if (ret)
+		return ret;
+
+	ret = sprd_thm_hw_resume(thm);
+	if (ret)
+		goto disable_clk;
+
+	for (i = 0; i < thm->nr_sensors; i++)
+		thm->sensor[i]->ready = true;
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(thm->clk);
+	return ret;
+}
+#endif
+
+static int sprd_thm_remove(struct platform_device *pdev)
+{
+	struct sprd_thermal_data *thm = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < thm->nr_sensors; i++) {
+		devm_thermal_zone_of_sensor_unregister(&pdev->dev,
+						       thm->sensor[i]->thmzone_dev);
+	}
+
+	clk_disable_unprepare(thm->clk);
+	return 0;
+}
+
+static const struct of_device_id sprd_thermal_of_match[] = {
+	{ .compatible = "sprd,ums512-thermal", .data = &ums512_data },
+	{ },
+};
+
+static const struct dev_pm_ops sprd_thermal_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sprd_thm_suspend, sprd_thm_resume)
+};
+
+static struct platform_driver sprd_thermal_driver = {
+	.probe = sprd_thm_probe,
+	.remove = sprd_thm_remove,
+	.driver = {
+		.name = "sprd-thermal",
+		.pm = &sprd_thermal_pm_ops,
+		.of_match_table = sprd_thermal_of_match,
+	},
+};
+
+module_platform_driver(sprd_thermal_driver);
+
+MODULE_AUTHOR("Freeman Liu <freeman.liu@unisoc.com>");
+MODULE_DESCRIPTION("Spreadtrum thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

