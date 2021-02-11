Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C808E318CB7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 14:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBKNwR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 08:52:17 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43052 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232187AbhBKNuJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 08:50:09 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BDj23R023969;
        Thu, 11 Feb 2021 05:49:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=eFDjoveljCQQJKcxDvUtCMV2TbXj5Ak0PinCMDmx6Uk=;
 b=GaQ315zkeEQWu2L/hgLgeEsMfZqWARQNc0WGu7Xraj9eG+IbJyySTIjodvLW8ZjHOJ0E
 6UsMaX5tqCl12b7tfZrVZm2psvl/TUnhE0WF/FjOen8Sv+kTvje118ngtmnZhi26OB4H
 VL64UVQXj3YOKr1Cg78V0aUoffkOZl9RCVp5ZeU/mlkuyz+qziyLac+ixkKphotdDNV1
 OChi+XMiGrH9la2JgvX1qWnM6XRezHuKWbusY8NeNZBjFAZCpevelXIv3fE1nk4pzyGT
 vkmxqI3RRj7Xz2KcYQ5bLzUQv9Ftt9VLsNmXRRytd1P1I4ULbVoeWMD7cCnFQ/3Y6pwz EA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqev4x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 05:49:05 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 05:49:02 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 05:49:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Feb 2021 05:49:02 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id C52CC3F7040;
        Thu, 11 Feb 2021 05:48:58 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Julia.Lawall@inria.fr>, <amitk@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <miquel.raynal@bootlin.com>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 1/2] thermal: armada: ap806: use firmware SiP services for thermal operations
Date:   Thu, 11 Feb 2021 15:48:51 +0200
Message-ID: <20210211134852.23648-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211134852.23648-1-kostap@marvell.com>
References: <20210211134852.23648-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Grzegorz Jaszczyk <jaz@semihalf.com>

This patch introduces support for ap806 thermal driver in case when SoC
DFX region is marked as secure by the firmware. In such case accessing
thermal registers, which are part of dfx register set, will not be
possible from non-secure world. Due to above the ARM Trusted Firmware
exposes thermal driver as a SiP service.  This allows Linux thermal
driver to initialise and perform various operations on thermal sensor
with use of SMC calls.

If during ap806 thermal initialisation the SMC is unhandled (old fw
case), fallback to regmap handling.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 drivers/thermal/armada_thermal.c  | 125 +++++++++++++++++++-
 include/soc/marvell/armada8k/fw.h |  19 +++
 2 files changed, 141 insertions(+), 3 deletions(-)
 create mode 100644 include/soc/marvell/armada8k/fw.h

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2ebfb5be4b3..ec077e834c85 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2013 Marvell
  */
+#include <linux/arm-smccc.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -18,6 +19,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/interrupt.h>
+#include <linux/time.h>
+#include "soc/marvell/armada8k/fw.h"
 
 #include "thermal_core.h"
 
@@ -62,6 +65,8 @@
 #define STATUS_POLL_TIMEOUT_US		100000
 #define OVERHEAT_INT_POLL_DELAY_MS	1000
 
+#define THERMAL_SUPPORTED_IN_FIRMWARE(priv) (priv->data->is_smc_supported)
+
 struct armada_thermal_data;
 
 /* Marvell EBU Thermal Sensor Dev Structure */
@@ -111,6 +116,12 @@ struct armada_thermal_data {
 
 	/* One sensor is in the thermal IC, the others are in the CPUs if any */
 	unsigned int cpu_nr;
+
+	/*
+	 * Thermal sensor operations exposed as firmware SIP services and
+	 * accessed via SMC
+	 */
+	bool is_smc_supported;
 };
 
 struct armada_drvdata {
@@ -135,6 +146,18 @@ struct armada_thermal_sensor {
 	int id;
 };
 
+static int thermal_smc(u32 addr, u32 *reg, u32 val1, u32 val2)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(MV_SIP_DFX, addr, val1, val2, 0, 0, 0, 0, &res);
+
+	if (res.a0 == 0 && reg != NULL)
+		*reg = res.a1;
+
+	return res.a0;
+}
+
 static void armadaxp_init(struct platform_device *pdev,
 			  struct armada_thermal_priv *priv)
 {
@@ -206,6 +229,27 @@ static void armada375_init(struct platform_device *pdev,
 static int armada_wait_sensor_validity(struct armada_thermal_priv *priv)
 {
 	u32 reg;
+	int ret;
+	ktime_t timeout;
+
+	if (THERMAL_SUPPORTED_IN_FIRMWARE(priv)) {
+		timeout = ktime_add_us(ktime_get(), STATUS_POLL_TIMEOUT_US);
+		do {
+			ret = thermal_smc(MV_SIP_DFX_THERMAL_IS_VALID,
+					  &reg, 0, 0);
+			if (ret || reg)
+				break;
+
+			usleep_range((STATUS_POLL_PERIOD_US >> 2) + 1,
+				     STATUS_POLL_PERIOD_US);
+
+		} while (ktime_before(ktime_get(), timeout));
+
+		if (ret == SMCCC_RET_SUCCESS)
+			return reg ? 0 : -ETIMEDOUT;
+
+		return ret;
+	}
 
 	return regmap_read_poll_timeout(priv->syscon,
 					priv->data->syscon_status_off, reg,
@@ -238,6 +282,22 @@ static void armada_ap806_init(struct platform_device *pdev,
 {
 	struct armada_thermal_data *data = priv->data;
 	u32 reg;
+	int ret;
+
+	/*
+	 * The ap806 thermal sensor registers are part of DFX which is secured
+	 * by latest firmware, therefore accessing relevant registers from
+	 * not-secure world will not be possible. In that case Arm Trusted
+	 * Firmware exposes thermal operations as firmware run-time service. If
+	 * SMC initialization succeeds, perform other thermal operations using
+	 * SMC, otherwise (old fw case) fallback to regmap handling.
+	 */
+	ret = thermal_smc(MV_SIP_DFX_THERMAL_INIT, 0x0, 0, 0);
+	if (ret == SMCCC_RET_SUCCESS) {
+		dev_info(&pdev->dev, "firmware support\n");
+		THERMAL_SUPPORTED_IN_FIRMWARE(priv) = true;
+		return;
+	}
 
 	regmap_read(priv->syscon, data->syscon_control0_off, &reg);
 	reg &= ~CONTROL0_TSEN_RESET;
@@ -274,11 +334,17 @@ static void armada_cp110_init(struct platform_device *pdev,
 
 static bool armada_is_valid(struct armada_thermal_priv *priv)
 {
+	int ret;
 	u32 reg;
 
 	if (!priv->data->is_valid_bit)
 		return true;
 
+	if (THERMAL_SUPPORTED_IN_FIRMWARE(priv)) {
+		ret = thermal_smc(MV_SIP_DFX_THERMAL_IS_VALID, &reg, 0, 0);
+		return ret ? false : reg;
+	}
+
 	regmap_read(priv->syscon, priv->data->syscon_status_off, &reg);
 
 	return reg & priv->data->is_valid_bit;
@@ -324,6 +390,7 @@ static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
 {
 	struct armada_thermal_data *data = priv->data;
 	u32 ctrl0;
+	int ret;
 
 	if (channel < 0 || channel > priv->data->cpu_nr)
 		return -EINVAL;
@@ -331,6 +398,16 @@ static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
 	if (priv->current_channel == channel)
 		return 0;
 
+	if (THERMAL_SUPPORTED_IN_FIRMWARE(priv)) {
+		ret = thermal_smc(MV_SIP_DFX_THERMAL_SEL_CHANNEL,
+				  NULL, channel, 0);
+		if (ret)
+			return ret;
+
+		priv->current_channel = channel;
+		goto is_valid;
+	}
+
 	/* Stop the measurements */
 	regmap_read(priv->syscon, data->syscon_control0_off, &ctrl0);
 	ctrl0 &= ~CONTROL0_TSEN_START;
@@ -357,6 +434,7 @@ static int armada_select_channel(struct armada_thermal_priv *priv, int channel)
 	ctrl0 |= CONTROL0_TSEN_START;
 	regmap_write(priv->syscon, data->syscon_control0_off, ctrl0);
 
+is_valid:
 	/*
 	 * The IP has a latency of ~15ms, so after updating the selected source,
 	 * we must absolutely wait for the sensor validity bit to ensure we read
@@ -376,6 +454,9 @@ static int armada_read_sensor(struct armada_thermal_priv *priv, int *temp)
 	u32 reg, div;
 	s64 sample, b, m;
 
+	if (THERMAL_SUPPORTED_IN_FIRMWARE(priv))
+		return thermal_smc(MV_SIP_DFX_THERMAL_READ, temp, 0, 0);
+
 	regmap_read(priv->syscon, priv->data->syscon_status_off, &reg);
 	reg = (reg >> priv->data->temp_shift) & priv->data->temp_mask;
 	if (priv->data->signed_sample)
@@ -559,7 +640,13 @@ static irqreturn_t armada_overheat_isr_thread(int irq, void *blob)
 			goto enable_irq;
 	} while (temperature >= low_threshold);
 
-	regmap_read(priv->syscon, priv->data->dfx_irq_cause_off, &dummy);
+	if (THERMAL_SUPPORTED_IN_FIRMWARE(priv)) {
+		if (thermal_smc(MV_SIP_DFX_THERMAL_IRQ, 0, 0, 0))
+			return IRQ_NONE;
+	} else {
+		regmap_read(priv->syscon, priv->data->dfx_irq_cause_off,
+			    &dummy);
+	}
 
 	/* Notify the thermal core that the temperature is acceptable again */
 	thermal_zone_device_update(priv->overheat_sensor,
@@ -772,6 +859,27 @@ static void armada_set_sane_name(struct platform_device *pdev,
 	} while (insane_char);
 }
 
+/*
+ * Let the firmware configure the thermal overheat threshold, hysteresis and
+ * enable overheat interrupt
+ */
+static int armada_fw_overheat_settings(struct armada_thermal_priv *priv,
+				       int thresh_mc, int hyst_mc)
+{
+	int ret;
+
+	ret = thermal_smc(MV_SIP_DFX_THERMAL_THRESH, NULL, thresh_mc, hyst_mc);
+	if (ret)
+		return ret;
+
+	if (thresh_mc >= 0)
+		priv->current_threshold = thresh_mc;
+	if (hyst_mc >= 0)
+		priv->current_hysteresis = hyst_mc;
+
+	return 0;
+}
+
 /*
  * The IP can manage to trigger interrupts on overheat situation from all the
  * sensors. However, the interrupt source changes along with the last selected
@@ -803,11 +911,22 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 	if (ret)
 		return ret;
 
+	priv->overheat_sensor = tz;
+	priv->interrupt_source = sensor_id;
+
+	if (THERMAL_SUPPORTED_IN_FIRMWARE(priv)) {
+		/*
+		 * When thermal supported in firmware the configuring overheat
+		 * threshold and enabling overheat interrupt is done in one
+		 * step.
+		 */
+		return armada_fw_overheat_settings(priv, trips[i].temperature,
+						   trips[i].hysteresis);
+	}
+
 	armada_set_overheat_thresholds(priv,
 				       trips[i].temperature,
 				       trips[i].hysteresis);
-	priv->overheat_sensor = tz;
-	priv->interrupt_source = sensor_id;
 
 	armada_enable_overheat_interrupt(priv);
 
diff --git a/include/soc/marvell/armada8k/fw.h b/include/soc/marvell/armada8k/fw.h
new file mode 100644
index 000000000000..2a80f26cbf6f
--- /dev/null
+++ b/include/soc/marvell/armada8k/fw.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Marvell International Ltd.
+ */
+
+#ifndef _SOC_MARVELL_ARMADA8K_FW_H
+#define _SOC_MARVELL_ARMADA8K_FW_H
+
+/* FW related definitions */
+#define MV_SIP_DFX			0x82000014
+
+#define MV_SIP_DFX_THERMAL_INIT		1
+#define MV_SIP_DFX_THERMAL_READ		2
+#define MV_SIP_DFX_THERMAL_IS_VALID	3
+#define MV_SIP_DFX_THERMAL_IRQ		4
+#define MV_SIP_DFX_THERMAL_THRESH	5
+#define MV_SIP_DFX_THERMAL_SEL_CHANNEL	6
+
+#endif /* _SOC_MARVELL_ARMADA8K_FW_H */
-- 
2.17.1

