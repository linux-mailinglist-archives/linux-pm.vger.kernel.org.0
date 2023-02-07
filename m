Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EA668D8A3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 14:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBGNLS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 08:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjBGNKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 08:10:45 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE373B3F3
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 05:10:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so2766279wmb.5
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaTn3gF8DRRVfJPAnjC4yTLYwU3NC6xMLL26zfvjBeM=;
        b=uzchu41EWSH6xzMnx7tagLkAB7MlOhvfhzh9Pkkc3UmO9alHAD1nAnQq9xp7WU0JNf
         xCw5rgwx8NCGV4ov1Mugv7d38O5BR9Wu3VRZ9LQvajI3LSDt6efn3Ne/hIuqbiVZjSVS
         gp2JOkqB1JisW3w4oCkJ4o1L2Zrk+VZOvdtWD6WBxUjuRhdH7maPnE4plOLfw4h3gahC
         sLOB6XSmTjTL/rc94hkTS7B0ow6ISQ5NR2Las+0fDsrK8E/tXqHPmOFe68MJoce9+b9+
         kXp+jaATcRuc27FiHCRClKRm84apjBkSvLal3fam5J+twczFsO1QdXpUapdRbpiqvRri
         OuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaTn3gF8DRRVfJPAnjC4yTLYwU3NC6xMLL26zfvjBeM=;
        b=Qqk9nHbegK5ZlBq8dhvG4IyXmdkdj2ye6r9dyWYRUvTF+DBrygtDcMzvrvp4it21cz
         40MejhIrY7i6Vvoi9rpbQXbIQK6UcKTZVCEEPAAxTBvso+LkxZ084swZ1S/+qovMmw9I
         Sw95lS6NpQfv005daSmrqlJc2UPw5H/q7JZ+Dc/vgst3abhYkPz7m0JOUISZmKqR56Jh
         5uMBLx9asFI9SJG1xbuBg2h4mdC181iDf51y9VoCQYI8QA71UgKWJ6GQonw4dJluhuDl
         mSq28klpVDjBmhyUNVckQul8hAwUACDWvRwuIf8SwzcjVF5bSNGfAqEdaL/op/G0/ft1
         Pa9Q==
X-Gm-Message-State: AO0yUKVakpkXsPGDHU04PrTkxjN314+RXZBqiIc8wkGlYt9+f3tT17Kk
        bz4InFCcGO6Kx+ysJ9FRWvUYoQ==
X-Google-Smtp-Source: AK7set+MUWIwcVE2RfifYshwJMxFh8ngmnFkWlWfuKiW71rQ6kxk6J68xBR97c0TRw/ePHoB2LVmDw==
X-Received: by 2002:a05:600c:747:b0:3dc:438a:c381 with SMTP id j7-20020a05600c074700b003dc438ac381mr2961297wmn.28.1675775407765;
        Tue, 07 Feb 2023 05:10:07 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id g24-20020a7bc4d8000000b003df30c94850sm17987385wmk.25.2023.02.07.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:10:07 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v13 4/6] thermal: drivers: mediatek: Add the Low Voltage Thermal Sensor driver
Date:   Tue,  7 Feb 2023 14:09:56 +0100
Message-Id: <20230207130958.608305-5-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207130958.608305-1-bchihi@baylibre.com>
References: <20230207130958.608305-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
controllers contained in a thermal domain.

A thermal domains can be the MCU or the AP.

Each thermal domains contain up to seven controllers, each thermal
controller handle up to four thermal sensors.

The LVTS has two Finite State Machines (FSM), one to handle the
functionin temperatures range like hot or cold temperature and another
one to handle monitoring trip point. The FSM notifies via interrupts
when a trip point is crossed.

The interrupt is managed at the thermal controller level, so when an
interrupt occurs, the driver has to find out which sensor triggered
such an interrupt.

The sampling of the thermal can be filtered or immediate. For the
former, the LVTS measures several points and applies a low pass
filter.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On MT8195 Tomato Chromebook:
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mediatek/Kconfig        |   16 +
 drivers/thermal/mediatek/Makefile       |    1 +
 drivers/thermal/mediatek/lvts_thermal.c | 1224 +++++++++++++++++++++++
 3 files changed, 1241 insertions(+)
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.c

diff --git a/drivers/thermal/mediatek/Kconfig b/drivers/thermal/mediatek/Kconfig
index 7558a847d4e9..d82c86d9be56 100644
--- a/drivers/thermal/mediatek/Kconfig
+++ b/drivers/thermal/mediatek/Kconfig
@@ -18,4 +18,20 @@ config MTK_SOC_THERMAL
 	  This driver configures thermal controllers to collect
 	  temperature via AUXADC interface.
 
+config MTK_LVTS_THERMAL
+        tristate "LVTS Thermal Driver for MediaTek SoCs"
+        depends on HAS_IOMEM
+        help
+          Enable this option if you want to get SoC temperature
+          information for supported MediaTek platforms.
+          This driver configures LVTS (Low Voltage Thermal Sensor)
+          thermal controllers to collect temperatures via ASIF
+          (Analog Serial Interface).
+
+config MTK_LVTS_THERMAL_DEBUGFS
+       bool "LVTS thermal debugfs"
+       depends on MTK_LVTS_THERMAL && DEBUG_FS
+       help
+         Enable this option to debug the internals of the device driver.
+
 endif
diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
index 53e86e30b26f..1c6daa1e644b 100644
--- a/drivers/thermal/mediatek/Makefile
+++ b/drivers/thermal/mediatek/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MTK_SOC_THERMAL)	+= auxadc_thermal.o
+obj-$(CONFIG_MTK_LVTS_THERMAL)	+= lvts_thermal.o
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
new file mode 100644
index 000000000000..84ba65a27acf
--- /dev/null
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -0,0 +1,1224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ * Author: Balsam CHIHI <bchihi@baylibre.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/debugfs.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
+
+#define LVTS_MONCTL0(__base)	(__base + 0x0000)
+#define LVTS_MONCTL1(__base)	(__base + 0x0004)
+#define LVTS_MONCTL2(__base)	(__base + 0x0008)
+#define LVTS_MONINT(__base)		(__base + 0x000C)
+#define LVTS_MONINTSTS(__base)	(__base + 0x0010)
+#define LVTS_MONIDET0(__base)	(__base + 0x0014)
+#define LVTS_MONIDET1(__base)	(__base + 0x0018)
+#define LVTS_MONIDET2(__base)	(__base + 0x001C)
+#define LVTS_MONIDET3(__base)	(__base + 0x0020)
+#define LVTS_H2NTHRE(__base)	(__base + 0x0024)
+#define LVTS_HTHRE(__base)		(__base + 0x0028)
+#define LVTS_OFFSETH(__base)	(__base + 0x0030)
+#define LVTS_OFFSETL(__base)	(__base + 0x0034)
+#define LVTS_MSRCTL0(__base)	(__base + 0x0038)
+#define LVTS_MSRCTL1(__base)	(__base + 0x003C)
+#define LVTS_TSSEL(__base)		(__base + 0x0040)
+#define LVTS_CALSCALE(__base)	(__base + 0x0048)
+#define LVTS_ID(__base)			(__base + 0x004C)
+#define LVTS_CONFIG(__base)		(__base + 0x0050)
+#define LVTS_EDATA00(__base)	(__base + 0x0054)
+#define LVTS_EDATA01(__base)	(__base + 0x0058)
+#define LVTS_EDATA02(__base)	(__base + 0x005C)
+#define LVTS_EDATA03(__base)	(__base + 0x0060)
+#define LVTS_MSR0(__base)		(__base + 0x0090)
+#define LVTS_MSR1(__base)		(__base + 0x0094)
+#define LVTS_MSR2(__base)		(__base + 0x0098)
+#define LVTS_MSR3(__base)		(__base + 0x009C)
+#define LVTS_IMMD0(__base)		(__base + 0x00A0)
+#define LVTS_IMMD1(__base)		(__base + 0x00A4)
+#define LVTS_IMMD2(__base)		(__base + 0x00A8)
+#define LVTS_IMMD3(__base)		(__base + 0x00AC)
+#define LVTS_PROTCTL(__base)	(__base + 0x00C0)
+#define LVTS_PROTTA(__base)		(__base + 0x00C4)
+#define LVTS_PROTTB(__base)		(__base + 0x00C8)
+#define LVTS_PROTTC(__base)		(__base + 0x00CC)
+#define LVTS_CLKEN(__base)		(__base + 0x00E4)
+
+#define LVTS_PERIOD_UNIT			((118 * 1000) / (256 * 38))
+#define LVTS_GROUP_INTERVAL			1
+#define LVTS_FILTER_INTERVAL		1
+#define LVTS_SENSOR_INTERVAL		1
+#define LVTS_HW_FILTER				0x2
+#define LVTS_TSSEL_CONF				0x13121110
+#define LVTS_CALSCALE_CONF			0x300
+#define LVTS_MONINT_CONF			0x9FBF7BDE
+
+#define LVTS_INT_SENSOR0			0x0009001F
+#define LVTS_INT_SENSOR1			0X000881F0
+#define LVTS_INT_SENSOR2			0x00247C00
+#define LVTS_INT_SENSOR3			0x1FC00000
+
+#define LVTS_SENSOR_MAX				4
+#define LVTS_GOLDEN_TEMP_MAX		62
+#define LVTS_GOLDEN_TEMP_DEFAULT	50
+#define LVTS_COEFF_A				-250460
+#define LVTS_COEFF_B				250460
+
+#define LVTS_MSR_IMMEDIATE_MODE		0
+#define LVTS_MSR_FILTERED_MODE		1
+
+#define LVTS_HW_SHUTDOWN_MT8195		105000
+
+static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
+static int coeff_b = LVTS_COEFF_B;
+
+struct lvts_sensor_data {
+	int dt_id;
+};
+
+struct lvts_ctrl_data {
+	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
+	int cal_offset[LVTS_SENSOR_MAX];
+	int hw_tshut_temp;
+	int num_lvts_sensor;
+	int offset;
+	int mode;
+};
+
+struct lvts_data {
+	const struct lvts_ctrl_data *lvts_ctrl;
+	int num_lvts_ctrl;
+};
+
+struct lvts_sensor {
+	struct thermal_zone_device *tz;
+	void __iomem *msr;
+	void __iomem *base;
+	int id;
+	int dt_id;
+};
+
+struct lvts_ctrl {
+	struct lvts_sensor sensors[LVTS_SENSOR_MAX];
+	u32 calibration[LVTS_SENSOR_MAX];
+	u32 hw_tshut_raw_temp;
+	int num_lvts_sensor;
+	int mode;
+	void __iomem *base;
+};
+
+struct lvts_domain {
+	struct lvts_ctrl *lvts_ctrl;
+	struct reset_control *reset;
+	struct clk *clk;
+	int num_lvts_ctrl;
+	void __iomem *base;
+	size_t calib_len;
+	u8 *calib;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dom_dentry;
+#endif
+};
+
+#ifdef CONFIG_MTK_LVTS_THERMAL_DEBUGFS
+
+#define LVTS_DEBUG_FS_REGS(__reg)		\
+{						\
+	.name = __stringify(__reg),		\
+	.offset = __reg(0),			\
+}
+
+static const struct debugfs_reg32 lvts_regs[] = {
+	LVTS_DEBUG_FS_REGS(LVTS_MONCTL0),
+	LVTS_DEBUG_FS_REGS(LVTS_MONCTL1),
+	LVTS_DEBUG_FS_REGS(LVTS_MONCTL2),
+	LVTS_DEBUG_FS_REGS(LVTS_MONINT),
+	LVTS_DEBUG_FS_REGS(LVTS_MONINTSTS),
+	LVTS_DEBUG_FS_REGS(LVTS_MONIDET0),
+	LVTS_DEBUG_FS_REGS(LVTS_MONIDET1),
+	LVTS_DEBUG_FS_REGS(LVTS_MONIDET2),
+	LVTS_DEBUG_FS_REGS(LVTS_MONIDET3),
+	LVTS_DEBUG_FS_REGS(LVTS_H2NTHRE),
+	LVTS_DEBUG_FS_REGS(LVTS_HTHRE),
+	LVTS_DEBUG_FS_REGS(LVTS_OFFSETH),
+	LVTS_DEBUG_FS_REGS(LVTS_OFFSETL),
+	LVTS_DEBUG_FS_REGS(LVTS_MSRCTL0),
+	LVTS_DEBUG_FS_REGS(LVTS_MSRCTL1),
+	LVTS_DEBUG_FS_REGS(LVTS_TSSEL),
+	LVTS_DEBUG_FS_REGS(LVTS_CALSCALE),
+	LVTS_DEBUG_FS_REGS(LVTS_ID),
+	LVTS_DEBUG_FS_REGS(LVTS_CONFIG),
+	LVTS_DEBUG_FS_REGS(LVTS_EDATA00),
+	LVTS_DEBUG_FS_REGS(LVTS_EDATA01),
+	LVTS_DEBUG_FS_REGS(LVTS_EDATA02),
+	LVTS_DEBUG_FS_REGS(LVTS_EDATA03),
+	LVTS_DEBUG_FS_REGS(LVTS_MSR0),
+	LVTS_DEBUG_FS_REGS(LVTS_MSR1),
+	LVTS_DEBUG_FS_REGS(LVTS_MSR2),
+	LVTS_DEBUG_FS_REGS(LVTS_MSR3),
+	LVTS_DEBUG_FS_REGS(LVTS_IMMD0),
+	LVTS_DEBUG_FS_REGS(LVTS_IMMD1),
+	LVTS_DEBUG_FS_REGS(LVTS_IMMD2),
+	LVTS_DEBUG_FS_REGS(LVTS_IMMD3),
+	LVTS_DEBUG_FS_REGS(LVTS_PROTCTL),
+	LVTS_DEBUG_FS_REGS(LVTS_PROTTA),
+	LVTS_DEBUG_FS_REGS(LVTS_PROTTB),
+	LVTS_DEBUG_FS_REGS(LVTS_PROTTC),
+	LVTS_DEBUG_FS_REGS(LVTS_CLKEN),
+};
+
+static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
+{
+	struct debugfs_regset32 *regset;
+	struct lvts_ctrl *lvts_ctrl;
+	struct dentry *dentry;
+	char name[64];
+	int i;
+
+	lvts_td->dom_dentry = debugfs_create_dir(dev_name(dev), NULL);
+	if (!lvts_td->dom_dentry)
+		return 0;
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
+
+		lvts_ctrl = &lvts_td->lvts_ctrl[i];
+
+		sprintf(name, "controller%d", i);
+		dentry = debugfs_create_dir(name, lvts_td->dom_dentry);
+		if (!dentry)
+			continue;
+
+		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+		if (!regset)
+			continue;
+
+		regset->base = lvts_ctrl->base;
+		regset->regs = lvts_regs;
+		regset->nregs = ARRAY_SIZE(lvts_regs);
+
+		debugfs_create_regset32("registers", 0400, dentry, regset);
+	}
+
+	return 0;
+}
+
+static void lvts_debugfs_exit(struct lvts_domain *lvts_td)
+{
+	debugfs_remove_recursive(lvts_td->dom_dentry);
+}
+
+#else
+
+static inline int lvts_debugfs_init(struct device *dev,
+				    struct lvts_domain *lvts_td)
+{
+	return 0;
+}
+
+static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
+
+#endif
+
+static int lvts_raw_to_temp(u32 raw_temp)
+{
+	int temperature;
+
+	temperature = ((s64)(raw_temp & 0xFFFF) * LVTS_COEFF_A) >> 14;
+	temperature += coeff_b;
+
+	return temperature;
+}
+
+static u32 lvts_temp_to_raw(int temperature)
+{
+	u32 raw_temp = ((s64)(coeff_b - temperature)) << 14;
+
+	raw_temp = div_s64(raw_temp, -LVTS_COEFF_A);
+
+	return raw_temp;
+}
+
+static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct lvts_sensor *lvts_sensor = tz->devdata;
+	void __iomem *msr = lvts_sensor->msr;
+	u32 value;
+
+	/*
+	 * Measurement registers:
+	 *
+	 * LVTS_MSR[0-3] / LVTS_IMMD[0-3]
+	 *
+	 * Bits:
+	 *
+	 * 32-17: Unused
+	 * 16	: Valid temperature
+	 * 15-0	: Raw temperature
+	 */
+	value = readl(msr);
+
+	/*
+	 * As the thermal zone temperature will read before the
+	 * hardware sensor is fully initialized, we have to check the
+	 * validity of the temperature returned when reading the
+	 * measurement register. The thermal controller will set the
+	 * valid bit temperature only when it is totally initialized.
+	 *
+	 * Otherwise, we may end up with garbage values out of the
+	 * functionning temperature and directly jump to a system
+	 * shutdown.
+	 */
+	if (!(value & BIT(16)))
+		return -EAGAIN;
+
+	*temp = lvts_raw_to_temp(value & 0xFFFF);
+
+	return 0;
+}
+
+static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct lvts_sensor *lvts_sensor = tz->devdata;
+	void __iomem *base = lvts_sensor->base;
+	u32 raw_low = lvts_temp_to_raw(low);
+	u32 raw_high = lvts_temp_to_raw(high);
+
+	/*
+	 * Hot to normal temperature threshold
+	 *
+	 * LVTS_H2NTHRE
+	 *
+	 * Bits:
+	 *
+	 * 14-0 : Raw temperature for threshold
+	 */
+	if (low != -INT_MAX) {
+		dev_dbg(&tz->device, "Setting low limit temperature interrupt: %d\n", low);
+		writel(raw_low, LVTS_H2NTHRE(base));
+	}
+
+	/*
+	 * Hot temperature threshold
+	 *
+	 * LVTS_HTHRE
+	 *
+	 * Bits:
+	 *
+	 * 14-0 : Raw temperature for threshold
+	 */
+	dev_dbg(&tz->device, "Setting high limit temperature interrupt: %d\n", high);
+	writel(raw_high, LVTS_HTHRE(base));
+
+	return 0;
+}
+
+static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
+{
+	irqreturn_t iret = IRQ_NONE;
+	u32 value;
+	u32 masks[] = {
+		LVTS_INT_SENSOR0,
+		LVTS_INT_SENSOR1,
+		LVTS_INT_SENSOR2,
+		LVTS_INT_SENSOR3
+	};
+	int i;
+
+	/*
+	 * Interrupt monitoring status
+	 *
+	 * LVTS_MONINTST
+	 *
+	 * Bits:
+	 *
+	 * 31 : Interrupt for stage 3
+	 * 30 : Interrupt for stage 2
+	 * 29 : Interrupt for state 1
+	 * 28 : Interrupt using filter on sensor 3
+	 *
+	 * 27 : Interrupt using immediate on sensor 3
+	 * 26 : Interrupt normal to hot on sensor 3
+	 * 25 : Interrupt high offset on sensor 3
+	 * 24 : Interrupt low offset on sensor 3
+	 *
+	 * 23 : Interrupt hot threshold on sensor 3
+	 * 22 : Interrupt cold threshold on sensor 3
+	 * 21 : Interrupt using filter on sensor 2
+	 * 20 : Interrupt using filter on sensor 1
+	 *
+	 * 19 : Interrupt using filter on sensor 0
+	 * 18 : Interrupt using immediate on sensor 2
+	 * 17 : Interrupt using immediate on sensor 1
+	 * 16 : Interrupt using immediate on sensor 0
+	 *
+	 * 15 : Interrupt device access timeout interrupt
+	 * 14 : Interrupt normal to hot on sensor 2
+	 * 13 : Interrupt high offset interrupt on sensor 2
+	 * 12 : Interrupt low offset interrupt on sensor 2
+	 *
+	 * 11 : Interrupt hot threshold on sensor 2
+	 * 10 : Interrupt cold threshold on sensor 2
+	 *  9 : Interrupt normal to hot on sensor 1
+	 *  8 : Interrupt high offset interrupt on sensor 1
+	 *
+	 *  7 : Interrupt low offset interrupt on sensor 1
+	 *  6 : Interrupt hot threshold on sensor 1
+	 *  5 : Interrupt cold threshold on sensor 1
+	 *  4 : Interrupt normal to hot on sensor 0
+	 *
+	 *  3 : Interrupt high offset interrupt on sensor 0
+	 *  2 : Interrupt low offset interrupt on sensor 0
+	 *  1 : Interrupt hot threshold on sensor 0
+	 *  0 : Interrupt cold threshold on sensor 0
+	 *
+	 * We are interested in the sensor(s) responsible of the
+	 * interrupt event. We update the thermal framework with the
+	 * thermal zone associated with the sensor. The framework will
+	 * take care of the rest whatever the kind of interrupt, we
+	 * are only interested in which sensor raised the interrupt.
+	 *
+	 * sensor 3 interrupt: 0001 1111 1100 0000 0000 0000 0000 0000
+	 *                  => 0x1FC00000
+	 * sensor 2 interrupt: 0000 0000 0010 0100 0111 1100 0000 0000
+	 *                  => 0x00247C00
+	 * sensor 1 interrupt: 0000 0000 0001 0001 0000 0011 1110 0000
+	 *                  => 0X000881F0
+	 * sensor 0 interrupt: 0000 0000 0000 1001 0000 0000 0001 1111
+	 *                  => 0x0009001F
+	 */
+	value = readl(LVTS_MONINTSTS(lvts_ctrl->base));
+
+	/*
+	 * Let's figure out which sensors raised the interrupt
+	 *
+	 * NOTE: the masks array must be ordered with the index
+	 * corresponding to the sensor id eg. index=0, mask for
+	 * sensor0.
+	 */
+	for (i = 0; i < ARRAY_SIZE(masks); i++) {
+
+		if (!(value & masks[i]))
+			continue;
+
+		thermal_zone_device_update(lvts_ctrl->sensors[i].tz,
+					   THERMAL_TRIP_VIOLATED);
+		iret = IRQ_HANDLED;
+	}
+
+	/*
+	 * Write back to clear the interrupt status (W1C)
+	 */
+	writel(value, LVTS_MONINTSTS(lvts_ctrl->base));
+
+	return iret;
+}
+
+/*
+ * Temperature interrupt handler. Even if the driver supports more
+ * interrupt modes, we use the interrupt when the temperature crosses
+ * the hot threshold the way up and the way down (modulo the
+ * hysteresis).
+ *
+ * Each thermal domain has a couple of interrupts, one for hardware
+ * reset and another one for all the thermal events happening on the
+ * different sensors.
+ *
+ * The interrupt is configured for thermal events when crossing the
+ * hot temperature limit. At each interrupt, we check in every
+ * controller if there is an interrupt pending.
+ */
+static irqreturn_t lvts_irq_handler(int irq, void *data)
+{
+	struct lvts_domain *lvts_td = data;
+	irqreturn_t aux, iret = IRQ_NONE;
+	int i;
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
+
+		aux = lvts_ctrl_irq_handler(lvts_td->lvts_ctrl);
+		if (aux != IRQ_HANDLED)
+			continue;
+
+		iret = IRQ_HANDLED;
+	}
+
+	return iret;
+}
+
+static struct thermal_zone_device_ops lvts_ops = {
+	.get_temp = lvts_get_temp,
+	.set_trips = lvts_set_trips,
+};
+
+static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
+					const struct lvts_ctrl_data *lvts_ctrl_data)
+{
+	struct lvts_sensor *lvts_sensor = lvts_ctrl->sensors;
+	void __iomem *msr_regs[] = {
+		LVTS_MSR0(lvts_ctrl->base),
+		LVTS_MSR1(lvts_ctrl->base),
+		LVTS_MSR2(lvts_ctrl->base),
+		LVTS_MSR3(lvts_ctrl->base)
+	};
+
+	void __iomem *imm_regs[] = {
+		LVTS_IMMD0(lvts_ctrl->base),
+		LVTS_IMMD1(lvts_ctrl->base),
+		LVTS_IMMD2(lvts_ctrl->base),
+		LVTS_IMMD3(lvts_ctrl->base)
+	};
+
+	int i;
+
+	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++) {
+
+		int dt_id = lvts_ctrl_data->lvts_sensor[i].dt_id;
+
+		/*
+		 * At this point, we don't know which id matches which
+		 * sensor. Let's set arbitrally the id from the index.
+		 */
+		lvts_sensor[i].id = i;
+
+		/*
+		 * The thermal zone registration will set the trip
+		 * point interrupt in the thermal controller
+		 * register. But this one will be reset in the
+		 * initialization after. So we need to post pone the
+		 * thermal zone creation after the controller is
+		 * setup. For this reason, we store the device tree
+		 * node id from the data in the sensor structure
+		 */
+		lvts_sensor[i].dt_id = dt_id;
+
+		/*
+		 * We assign the base address of the thermal
+		 * controller as a back pointer. So it will be
+		 * accessible from the different thermal framework ops
+		 * as we pass the lvts_sensor pointer as thermal zone
+		 * private data.
+		 */
+		lvts_sensor[i].base = lvts_ctrl->base;
+
+		/*
+		 * Each sensor has its own register address to read from.
+		 */
+		lvts_sensor[i].msr = lvts_ctrl_data->mode == LVTS_MSR_IMMEDIATE_MODE ?
+			imm_regs[i] : msr_regs[i];
+	};
+
+	lvts_ctrl->num_lvts_sensor = lvts_ctrl_data->num_lvts_sensor;
+
+	return 0;
+}
+
+/*
+ * The efuse blob values follows the sensor enumeration per thermal
+ * controller. The decoding of the stream is as follow:
+ *
+ *                        <--?-> <----big0 ???---> <-sensor0-> <-0->
+ *                        ------------------------------------------
+ * index in the stream: : | 0x0 | 0x1 | 0x2 | 0x3 | 0x4 | 0x5 | 0x6 |
+ *                        ------------------------------------------
+ *
+ *                        <--sensor1--><-0-> <----big1 ???---> <-sen
+ *                        ------------------------------------------
+ *                        | 0x7 | 0x8 | 0x9 | 0xA | 0xB | OxC | OxD |
+ *                        ------------------------------------------
+ *
+ *                        sor0-> <-0-> <-sensor1-> <-0-> ..........
+ *                        ------------------------------------------
+ *                        | 0x7 | 0x8 | 0x9 | 0xA | 0xB | OxC | OxD |
+ *                        ------------------------------------------
+ *
+ * And so on ...
+ *
+ * The data description gives the offset of the calibration data in
+ * this bytes stream for each sensor.
+ *
+ * Each thermal controller can handle up to 4 sensors max, we don't
+ * care if there are less as the array of calibration is sized to 4
+ * anyway. The unused sensor slot will be zeroed.
+ */
+static int lvts_calibration_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
+					const struct lvts_ctrl_data *lvts_ctrl_data,
+					u8 *efuse_calibration)
+{
+	int i;
+
+	for (i = 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
+		memcpy(&lvts_ctrl->calibration[i],
+		       efuse_calibration + lvts_ctrl_data->cal_offset[i], 2);
+
+	return 0;
+}
+
+/*
+ * The efuse bytes stream can be split into different chunk of
+ * nvmems. This function reads and concatenate those into a single
+ * buffer so it can be read sequentially when initializing the
+ * calibration data.
+ */
+static int lvts_calibration_read(struct device *dev, struct lvts_domain *lvts_td,
+					const struct lvts_data *lvts_data)
+{
+	struct device_node *np = dev_of_node(dev);
+	struct nvmem_cell *cell;
+	struct property *prop;
+	const char *cell_name;
+
+	of_property_for_each_string(np, "nvmem-cell-names", prop, cell_name) {
+		size_t len;
+		u8 *efuse;
+
+		cell = of_nvmem_cell_get(np, cell_name);
+		if (IS_ERR(cell)) {
+			dev_err(dev, "Failed to get cell '%s'\n", cell_name);
+			return PTR_ERR(cell);
+		}
+
+		efuse = nvmem_cell_read(cell, &len);
+
+		nvmem_cell_put(cell);
+
+		if (IS_ERR(efuse)) {
+			dev_err(dev, "Failed to read cell '%s'\n", cell_name);
+			return PTR_ERR(efuse);
+		}
+
+		lvts_td->calib = devm_krealloc(dev, lvts_td->calib,
+					       lvts_td->calib_len + len, GFP_KERNEL);
+		if (!lvts_td->calib)
+			return -ENOMEM;
+
+		memcpy(lvts_td->calib + lvts_td->calib_len, efuse, len);
+
+		lvts_td->calib_len += len;
+
+		kfree(efuse);
+	}
+
+	return 0;
+}
+
+static int lvts_golden_temp_init(struct device *dev, u32 *value)
+{
+	u32 gt;
+
+	gt = (*value) >> 24;
+
+	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
+		golden_temp = gt;
+
+	coeff_b = golden_temp * 500 + LVTS_COEFF_B;
+
+	return 0;
+}
+
+static int lvts_ctrl_init(struct device *dev, struct lvts_domain *lvts_td,
+					const struct lvts_data *lvts_data)
+{
+	size_t size = sizeof(*lvts_td->lvts_ctrl) * lvts_data->num_lvts_ctrl;
+	struct lvts_ctrl *lvts_ctrl;
+	int i, ret;
+
+	/*
+	 * Create the calibration bytes stream from efuse data
+	 */
+	ret = lvts_calibration_read(dev, lvts_td, lvts_data);
+	if (ret)
+		return ret;
+
+	/*
+	 * The golden temp information is contained in the first chunk
+	 * of efuse data.
+	 */
+	ret = lvts_golden_temp_init(dev, (u32 *)lvts_td->calib);
+	if (ret)
+		return ret;
+
+	lvts_ctrl = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!lvts_ctrl)
+		return -ENOMEM;
+
+	for (i = 0; i < lvts_data->num_lvts_ctrl; i++) {
+
+		lvts_ctrl[i].base = lvts_td->base + lvts_data->lvts_ctrl[i].offset;
+
+		ret = lvts_sensor_init(dev, &lvts_ctrl[i],
+				       &lvts_data->lvts_ctrl[i]);
+		if (ret)
+			return ret;
+
+		ret = lvts_calibration_init(dev, &lvts_ctrl[i],
+					    &lvts_data->lvts_ctrl[i],
+					    lvts_td->calib);
+		if (ret)
+			return ret;
+
+		/*
+		 * The mode the ctrl will use to read the temperature
+		 * (filtered or immediate)
+		 */
+		lvts_ctrl[i].mode = lvts_data->lvts_ctrl[i].mode;
+
+		/*
+		 * The temperature to raw temperature must be done
+		 * after initializing the calibration.
+		 */
+		lvts_ctrl[i].hw_tshut_raw_temp =
+			lvts_temp_to_raw(lvts_data->lvts_ctrl[i].hw_tshut_temp);
+	}
+
+	/*
+	 * We no longer need the efuse bytes stream, let's free it
+	 */
+	devm_kfree(dev, lvts_td->calib);
+
+	lvts_td->lvts_ctrl = lvts_ctrl;
+	lvts_td->num_lvts_ctrl = lvts_data->num_lvts_ctrl;
+
+	return 0;
+}
+
+/*
+ * At this point the configuration register is the only place in the
+ * driver where we write multiple values. Per hardware constraint,
+ * each write in the configuration register must be separated by a
+ * delay of 2 us.
+ */
+static void lvts_write_config(struct lvts_ctrl *lvts_ctrl, u32 *cmds, int nr_cmds)
+{
+	int i;
+
+	/*
+	 * Configuration register
+	 */
+	for (i = 0; i < nr_cmds; i++) {
+		writel(cmds[i], LVTS_CONFIG(lvts_ctrl->base));
+		usleep_range(2, 4);
+	}
+}
+
+static int lvts_irq_init(struct lvts_ctrl *lvts_ctrl)
+{
+	/*
+	 * LVTS_PROTCTL : Thermal Protection Sensor Selection
+	 *
+	 * Bits:
+	 *
+	 * 19-18 : Sensor to base the protection on
+	 * 17-16 : Strategy:
+	 *         00 : Average of 4 sensors
+	 *         01 : Max of 4 sensors
+	 *         10 : Selected sensor with bits 19-18
+	 *         11 : Reserved
+	 */
+	writel(BIT(16), LVTS_PROTCTL(lvts_ctrl->base));
+
+	/*
+	 * LVTS_PROTTA : Stage 1 temperature threshold
+	 * LVTS_PROTTB : Stage 2 temperature threshold
+	 * LVTS_PROTTC : Stage 3 temperature threshold
+	 *
+	 * Bits:
+	 *
+	 * 14-0: Raw temperature threshold
+	 *
+	 * writel(0x0, LVTS_PROTTA(lvts_ctrl->base));
+	 * writel(0x0, LVTS_PROTTB(lvts_ctrl->base));
+	 */
+	writel(lvts_ctrl->hw_tshut_raw_temp, LVTS_PROTTC(lvts_ctrl->base));
+
+	/*
+	 * LVTS_MONINT : Interrupt configuration register
+	 *
+	 * The LVTS_MONINT register layout is the same as the LVTS_MONINTSTS
+	 * register, except we set the bits to enable the interrupt.
+	 */
+	writel(LVTS_MONINT_CONF, LVTS_MONINT(lvts_ctrl->base));
+
+	return 0;
+}
+
+static int lvts_domain_reset(struct device *dev, struct reset_control *reset)
+{
+	int ret;
+
+	ret = reset_control_assert(reset);
+	if (ret)
+		return ret;
+
+	return reset_control_deassert(reset);
+}
+
+/*
+ * Enable or disable the clocks of a specified thermal controller
+ */
+static int lvts_ctrl_set_enable(struct lvts_ctrl *lvts_ctrl, int enable)
+{
+	/*
+	 * LVTS_CLKEN : Internal LVTS clock
+	 *
+	 * Bits:
+	 *
+	 * 0 : enable / disable clock
+	 */
+	writel(enable, LVTS_CLKEN(lvts_ctrl->base));
+
+	return 0;
+}
+
+static int lvts_ctrl_connect(struct device *dev, struct lvts_ctrl *lvts_ctrl)
+{
+	u32 id, cmds[] = { 0xC103FFFF, 0xC502FF55 };
+
+	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
+
+	/*
+	 * LVTS_ID : Get ID and status of the thermal controller
+	 *
+	 * Bits:
+	 *
+	 * 0-5	: thermal controller id
+	 *   7	: thermal controller connection is valid
+	 */
+	id = readl(LVTS_ID(lvts_ctrl->base));
+	if (!(id & BIT(7)))
+		return -EIO;
+
+	return 0;
+}
+
+static int lvts_ctrl_initialize(struct device *dev, struct lvts_ctrl *lvts_ctrl)
+{
+	/*
+	 * Write device mask: 0xC1030000
+	 */
+	u32 cmds[] = {
+		0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098D, 0xC10308F1,
+		0xC10307A6, 0xC10306B8, 0xC1030500, 0xC1030420, 0xC1030300,
+		0xC1030030, 0xC10300F6, 0xC1030050, 0xC1030060, 0xC10300AC,
+		0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E1
+	};
+
+	lvts_write_config(lvts_ctrl, cmds, ARRAY_SIZE(cmds));
+
+	return 0;
+}
+
+static int lvts_ctrl_calibrate(struct device *dev, struct lvts_ctrl *lvts_ctrl)
+{
+	int i;
+	void __iomem *lvts_edata[] = {
+		LVTS_EDATA00(lvts_ctrl->base),
+		LVTS_EDATA01(lvts_ctrl->base),
+		LVTS_EDATA02(lvts_ctrl->base),
+		LVTS_EDATA03(lvts_ctrl->base)
+	};
+
+	/*
+	 * LVTS_EDATA0X : Efuse calibration reference value for sensor X
+	 *
+	 * Bits:
+	 *
+	 * 20-0 : Efuse value for normalization data
+	 */
+	for (i = 0; i < LVTS_SENSOR_MAX; i++)
+		writel(lvts_ctrl->calibration[i], lvts_edata[i]);
+
+	return 0;
+}
+
+static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
+{
+	u32 value;
+
+	/*
+	 * LVTS_TSSEL : Sensing point index numbering
+	 *
+	 * Bits:
+	 *
+	 * 31-24: ADC Sense 3
+	 * 23-16: ADC Sense 2
+	 * 15-8	: ADC Sense 1
+	 * 7-0	: ADC Sense 0
+	 */
+	value = LVTS_TSSEL_CONF;
+	writel(value, LVTS_TSSEL(lvts_ctrl->base));
+
+	/*
+	 * LVTS_CALSCALE : ADC voltage round
+	 */
+	value = 0x300;
+	value = LVTS_CALSCALE_CONF;
+
+	/*
+	 * LVTS_MSRCTL0 : Sensor filtering strategy
+	 *
+	 * Filters:
+	 *
+	 * 000 : One sample
+	 * 001 : Avg 2 samples
+	 * 010 : 4 samples, drop min and max, avg 2 samples
+	 * 011 : 6 samples, drop min and max, avg 4 samples
+	 * 100 : 10 samples, drop min and max, avg 8 samples
+	 * 101 : 18 samples, drop min and max, avg 16 samples
+	 *
+	 * Bits:
+	 *
+	 * 0-2  : Sensor0 filter
+	 * 3-5  : Sensor1 filter
+	 * 6-8  : Sensor2 filter
+	 * 9-11 : Sensor3 filter
+	 */
+	value = LVTS_HW_FILTER << 9 |  LVTS_HW_FILTER << 6 |
+			LVTS_HW_FILTER << 3 | LVTS_HW_FILTER;
+	writel(value, LVTS_MSRCTL0(lvts_ctrl->base));
+
+	/*
+	 * LVTS_MSRCTL1 : Measurement control
+	 *
+	 * Bits:
+	 *
+	 * 9: Ignore MSRCTL0 config and do immediate measurement on sensor3
+	 * 6: Ignore MSRCTL0 config and do immediate measurement on sensor2
+	 * 5: Ignore MSRCTL0 config and do immediate measurement on sensor1
+	 * 4: Ignore MSRCTL0 config and do immediate measurement on sensor0
+	 *
+	 * That configuration will ignore the filtering and the delays
+	 * introduced below in MONCTL1 and MONCTL2
+	 */
+	if (lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE) {
+		value = BIT(9) | BIT(6) | BIT(5) | BIT(4);
+		writel(value, LVTS_MSRCTL1(lvts_ctrl->base));
+	}
+
+	/*
+	 * LVTS_MONCTL1 : Period unit and group interval configuration
+	 *
+	 * The clock source of LVTS thermal controller is 26MHz.
+	 *
+	 * The period unit is a time base for all the interval delays
+	 * specified in the registers. By default we use 12. The time
+	 * conversion is done by multiplying by 256 and 1/26.10^6
+	 *
+	 * An interval delay multiplied by the period unit gives the
+	 * duration in seconds.
+	 *
+	 * - Filter interval delay is a delay between two samples of
+	 * the same sensor.
+	 *
+	 * - Sensor interval delay is a delay between two samples of
+	 * different sensors.
+	 *
+	 * - Group interval delay is a delay between different rounds.
+	 *
+	 * For example:
+	 *     If Period unit = C, filter delay = 1, sensor delay = 2, group delay = 1,
+	 *     and two sensors, TS1 and TS2, are in a LVTS thermal controller
+	 *     and then
+	 *     Period unit time = C * 1/26M * 256 = 12 * 38.46ns * 256 = 118.149us
+	 *     Filter interval delay = 1 * Period unit = 118.149us
+	 *     Sensor interval delay = 2 * Period unit = 236.298us
+	 *     Group interval delay = 1 * Period unit = 118.149us
+	 *
+	 *     TS1    TS1 ... TS1    TS2    TS2 ... TS2    TS1...
+	 *        <--> Filter interval delay
+	 *                       <--> Sensor interval delay
+	 *                                             <--> Group interval delay
+	 * Bits:
+	 *      29 - 20 : Group interval
+	 *      16 - 13 : Send a single interrupt when crossing the hot threshold (1)
+	 *                or an interrupt everytime the hot threshold is crossed (0)
+	 *       9 - 0  : Period unit
+	 *
+	 */
+	value = LVTS_GROUP_INTERVAL << 20 | LVTS_PERIOD_UNIT;
+	writel(value, LVTS_MONCTL1(lvts_ctrl->base));
+
+	/*
+	 * LVTS_MONCTL2 : Filtering and sensor interval
+	 *
+	 * Bits:
+	 *
+	 *      25-16 : Interval unit in PERIOD_UNIT between sample on
+	 *              the same sensor, filter interval
+	 *       9-0  : Interval unit in PERIOD_UNIT between each sensor
+	 *
+	 */
+	value = LVTS_FILTER_INTERVAL << 16 | LVTS_SENSOR_INTERVAL;
+	writel(value, LVTS_MONCTL2(lvts_ctrl->base));
+
+	return lvts_irq_init(lvts_ctrl);
+}
+
+static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
+{
+	struct lvts_sensor *lvts_sensors = lvts_ctrl->sensors;
+	struct thermal_zone_device *tz;
+	u32 sensor_map = 0;
+	int i;
+
+	for (i = 0; i < lvts_ctrl->num_lvts_sensor; i++) {
+
+		int dt_id = lvts_sensors[i].dt_id;
+
+		tz = devm_thermal_of_zone_register(dev, dt_id, &lvts_sensors[i],
+						   &lvts_ops);
+		if (IS_ERR(tz)) {
+			/*
+			 * This thermal zone is not described in the
+			 * device tree. It is not an error from the
+			 * thermal OF code POV, we just continue.
+			 */
+			if (PTR_ERR(tz) == -ENODEV)
+				continue;
+
+			return PTR_ERR(tz);
+		}
+
+		/*
+		 * The thermal zone pointer will be needed in the
+		 * interrupt handler, we store it in the sensor
+		 * structure. The thermal domain structure will be
+		 * passed to the interrupt handler private data as the
+		 * interrupt is shared for all the controller
+		 * belonging to the thermal domain.
+		 */
+		lvts_sensors[i].tz = tz;
+
+		/*
+		 * This sensor was correctly associated with a thermal
+		 * zone, let's set the corresponding bit in the sensor
+		 * map, so we can enable the temperature monitoring in
+		 * the hardware thermal controller.
+		 */
+		sensor_map |= BIT(i);
+	}
+
+	/*
+	 * Bits:
+	 *      9: Single point access flow
+	 *    0-3: Enable sensing point 0-3
+	 *
+	 * The initialization of the thermal zones give us
+	 * which sensor point to enable. If any thermal zone
+	 * was not described in the device tree, it won't be
+	 * enabled here in the sensor map.
+	 */
+	writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
+
+	return 0;
+}
+
+static int lvts_domain_init(struct device *dev, struct lvts_domain *lvts_td,
+					const struct lvts_data *lvts_data)
+{
+	struct lvts_ctrl *lvts_ctrl;
+	int i, ret;
+
+	ret = lvts_ctrl_init(dev, lvts_td, lvts_data);
+	if (ret)
+		return ret;
+
+	ret = lvts_domain_reset(dev, lvts_td->reset);
+	if (ret) {
+		dev_dbg(dev, "Failed to reset domain");
+		return ret;
+	}
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
+
+		lvts_ctrl = &lvts_td->lvts_ctrl[i];
+
+		/*
+		 * Initialization steps:
+		 *
+		 * - Enable the clock
+		 * - Connect to the LVTS
+		 * - Initialize the LVTS
+		 * - Prepare the calibration data
+		 * - Select monitored sensors
+		 * [ Configure sampling ]
+		 * [ Configure the interrupt ]
+		 * - Start measurement
+		 */
+		ret = lvts_ctrl_set_enable(lvts_ctrl, true);
+		if (ret) {
+			dev_dbg(dev, "Failed to enable LVTS clock");
+			return ret;
+		}
+
+		ret = lvts_ctrl_connect(dev, lvts_ctrl);
+		if (ret) {
+			dev_dbg(dev, "Failed to connect to LVTS controller");
+			return ret;
+		}
+
+		ret = lvts_ctrl_initialize(dev, lvts_ctrl);
+		if (ret) {
+			dev_dbg(dev, "Failed to initialize controller");
+			return ret;
+		}
+
+		ret = lvts_ctrl_calibrate(dev, lvts_ctrl);
+		if (ret) {
+			dev_dbg(dev, "Failed to calibrate controller");
+			return ret;
+		}
+
+		ret = lvts_ctrl_configure(dev, lvts_ctrl);
+		if (ret) {
+			dev_dbg(dev, "Failed to configure controller");
+			return ret;
+		}
+
+		ret = lvts_ctrl_start(dev, lvts_ctrl);
+		if (ret) {
+			dev_dbg(dev, "Failed to start controller");
+			return ret;
+		}
+	}
+
+	return lvts_debugfs_init(dev, lvts_td);
+}
+
+static int lvts_probe(struct platform_device *pdev)
+{
+	const struct lvts_data *lvts_data;
+	struct lvts_domain *lvts_td;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int irq, ret;
+
+	lvts_td = devm_kzalloc(dev, sizeof(*lvts_td), GFP_KERNEL);
+	if (!lvts_td)
+		return -ENOMEM;
+
+	lvts_data = of_device_get_match_data(dev);
+
+	lvts_td->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(lvts_td->clk))
+		return dev_err_probe(dev, PTR_ERR(lvts_td->clk), "Failed to retrieve clock\n");
+
+	res = platform_get_mem_or_io(pdev, 0);
+	if (!res)
+		return dev_err_probe(dev, (-ENXIO), "No IO resource\n");
+
+	lvts_td->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(lvts_td->base))
+		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io resource\n");
+
+	lvts_td->reset = devm_reset_control_get_by_index(dev, 0);
+	if (IS_ERR(lvts_td->reset))
+		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get reset control\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "No irq resource\n");
+
+	ret = lvts_domain_init(dev, lvts_td, lvts_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize the lvts domain\n");
+
+	/*
+	 * At this point the LVTS is initialized and enabled. We can
+	 * safely enable the interrupt.
+	 */
+	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
+					IRQF_ONESHOT, dev_name(dev), lvts_td);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+
+	platform_set_drvdata(pdev, lvts_td);
+
+	return 0;
+}
+
+static int lvts_remove(struct platform_device *pdev)
+{
+	struct lvts_domain *lvts_td;
+	int i;
+
+	lvts_td = platform_get_drvdata(pdev);
+
+	for (i = 0; i < lvts_td->num_lvts_ctrl; i++)
+		lvts_ctrl_set_enable(&lvts_td->lvts_ctrl[i], false);
+
+	lvts_debugfs_exit(lvts_td);
+
+	return 0;
+}
+
+static const struct lvts_ctrl_data mt8195_lvts_data_ctrl[] = {
+	{
+		.cal_offset = { 0x04, 0x07 },
+		.lvts_sensor = {
+			{ .dt_id = MT8195_MCU_BIG_CPU0 },
+			{ .dt_id = MT8195_MCU_BIG_CPU1 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x0,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
+	},
+	{
+		.cal_offset = { 0x0d, 0x10 },
+		.lvts_sensor = {
+			{ .dt_id = MT8195_MCU_BIG_CPU2 },
+			{ .dt_id = MT8195_MCU_BIG_CPU3 }
+		},
+		.num_lvts_sensor = 2,
+		.offset = 0x100,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
+	},
+	{
+		.cal_offset = { 0x16, 0x19, 0x1c, 0x1f },
+		.lvts_sensor = {
+			{ .dt_id = MT8195_MCU_LITTLE_CPU0 },
+			{ .dt_id = MT8195_MCU_LITTLE_CPU1 },
+			{ .dt_id = MT8195_MCU_LITTLE_CPU2 },
+			{ .dt_id = MT8195_MCU_LITTLE_CPU3 }
+		},
+		.num_lvts_sensor = 4,
+		.offset = 0x200,
+		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT8195,
+	}
+};
+
+static const struct lvts_data mt8195_lvts_mcu_data = {
+	.lvts_ctrl	= mt8195_lvts_data_ctrl,
+	.num_lvts_ctrl	= ARRAY_SIZE(mt8195_lvts_data_ctrl),
+};
+
+static const struct of_device_id lvts_of_match[] = {
+	{ .compatible = "mediatek,mt8195-lvts-mcu", .data = &mt8195_lvts_mcu_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, lvts_of_match);
+
+static struct platform_driver lvts_driver = {
+	.probe = lvts_probe,
+	.remove = lvts_remove,
+	.driver = {
+		.name = "mtk-lvts-thermal",
+		.of_match_table = lvts_of_match,
+	},
+};
+module_platform_driver(lvts_driver);
+
+MODULE_AUTHOR("Balsam CHIHI <bchihi@baylibre.com>");
+MODULE_DESCRIPTION("MediaTek LVTS Thermal Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

