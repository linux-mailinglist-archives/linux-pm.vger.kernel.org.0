Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDAA2C5C54
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 20:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405122AbgKZSz3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405011AbgKZSy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:54:57 -0500
X-Greylist: delayed 499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Nov 2020 10:54:56 PST
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C7C061A04;
        Thu, 26 Nov 2020 10:54:56 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 149A8405F1;
        Thu, 26 Nov 2020 19:46:36 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        jorge.ramirez-ortiz@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, daniel.lezcano@linaro.org, nks@flawful.org,
        bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 08/13] soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
Date:   Thu, 26 Nov 2020 19:45:54 +0100
Message-Id: <20201126184559.3052375-9-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit introduces a new driver, based on the one for cpr v1,
to enable support for the newer Qualcomm Core Power Reduction
hardware, known downstream as CPR3, CPR4 and CPRh.

In these new versions of the hardware, support for various new
features was introduced, including voltage reduction for the GPU,
security hardening and a new way of controlling CPU DVFS,
consisting in internal communication between microcontrollers,
specifically the CPR-Hardened and the Operating State Manager.

The CPR v3, v4 and CPRh are present in a broad range of SoCs,
from the mid-range to the high end ones including, but not limited
to, MSM8953/8996/8998, SDM630/636/660/845.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/soc/qcom/Kconfig  |   17 +
 drivers/soc/qcom/Makefile |    1 +
 drivers/soc/qcom/cpr3.c   | 2474 +++++++++++++++++++++++++++++++++++++
 3 files changed, 2492 insertions(+)
 create mode 100644 drivers/soc/qcom/cpr3.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 37f22dcd20af..9d3f35fc4ab1 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -42,6 +42,23 @@ config QCOM_CPR
 	  To compile this driver as a module, choose M here: the module will
 	  be called qcom-cpr
 
+config QCOM_CPR3
+	tristate "QCOM Core Power Reduction (CPR v3/v4/Hardened) support"
+	depends on ARCH_QCOM && HAS_IOMEM
+	select PM_OPP
+	select REGMAP
+	help
+	  Say Y here to enable support for the CPR hardware found on a broad
+	  variety of Qualcomm SoCs like MSM8996, MSM8998, SDM630, SDM660,
+	  SDM845 and others.
+
+	  This driver populates OPP tables and makes adjustments to them
+	  based on feedback from the CPR hardware. If you want to do CPU
+	  and/or GPU frequency scaling say Y here.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called qcom-cpr3
+
 config QCOM_GENI_SE
 	tristate "QCOM GENI Serial Engine Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 778a2a5f07bb..0500283c2dc5 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_CPR)		+= cpr-common.o cpr.o
+obj-$(CONFIG_QCOM_CPR3)		+= cpr-common.o cpr3.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
diff --git a/drivers/soc/qcom/cpr3.c b/drivers/soc/qcom/cpr3.c
new file mode 100644
index 000000000000..a7e83ef8f478
--- /dev/null
+++ b/drivers/soc/qcom/cpr3.c
@@ -0,0 +1,2474 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2013-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2019 Linaro Limited
+ * Copyright (c) 2020, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/debugfs.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
+#include <linux/clk.h>
+#include <linux/nvmem-consumer.h>
+#include "cpr-common.h"
+
+#define CPR3_RO_COUNT				16
+#define CPR3_RO_MASK				GENMASK(CPR3_RO_COUNT - 1, 0)
+
+/* CPR3 registers */
+#define CPR3_REG_CPR_VERSION			0x0
+#define CPRH_CPR_VERSION_4P5			0x40050000
+
+#define CPR3_REG_CPR_CTL			0x4
+#define CPR3_CPR_CTL_LOOP_EN_MASK		BIT(0)
+#define CPR3_CPR_CTL_IDLE_CLOCKS_MASK		GENMASK(4, 0)
+#define CPR3_CPR_CTL_IDLE_CLOCKS_SHIFT		1
+#define CPR3_CPR_CTL_COUNT_MODE_MASK		GENMASK(1, 0)
+#define CPR3_CPR_CTL_COUNT_MODE_SHIFT		6
+#define CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MIN	0
+#define CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MAX	1
+#define CPR3_CPR_CTL_COUNT_MODE_STAGGERED	2
+#define CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_AGE	3
+#define CPR3_CPR_CTL_COUNT_REPEAT_MASK		GENMASK(22, 0)
+#define CPR3_CPR_CTL_COUNT_REPEAT_SHIFT		9
+
+#define CPR3_REG_CPR_STATUS			0x8
+#define CPR3_CPR_STATUS_BUSY_MASK		BIT(0)
+
+/*
+ * This register is not present on controllers that support HW closed-loop
+ * except CPR4 APSS controller.
+ */
+#define CPR3_REG_CPR_TIMER_AUTO_CONT		0xC
+
+#define CPR3_REG_CPR_STEP_QUOT			0x14
+#define CPR3_CPR_STEP_QUOT_MIN_MASK		GENMASK(5, 0)
+#define CPR3_CPR_STEP_QUOT_MIN_SHIFT		0
+#define CPR3_CPR_STEP_QUOT_MAX_MASK		GENMASK(5, 0)
+#define CPR3_CPR_STEP_QUOT_MAX_SHIFT		6
+#define CPRH_DELTA_QUOT_STEP_FACTOR		4
+
+#define CPR3_REG_GCNT(ro)			(0xA0 + 0x4 * (ro))
+#define CPR3_REG_SENSOR_OWNER(sensor)		(0x200 + 0x4 * (sensor))
+
+#define CPR3_REG_CONT_CMD			0x800
+#define CPR3_CONT_CMD_ACK			0x1
+#define CPR3_CONT_CMD_NACK			0x0
+
+#define CPR3_REG_THRESH(thread)			(0x808 + 0x440 * (thread))
+#define CPR3_THRESH_CONS_DOWN_MASK		GENMASK(3, 0)
+#define CPR3_THRESH_CONS_DOWN_SHIFT		0
+#define CPR3_THRESH_CONS_UP_MASK		GENMASK(3, 0)
+#define CPR3_THRESH_CONS_UP_SHIFT		4
+#define CPR3_THRESH_DOWN_THRESH_MASK		GENMASK(4, 0)
+#define CPR3_THRESH_DOWN_THRESH_SHIFT		8
+#define CPR3_THRESH_UP_THRESH_MASK		GENMASK(4, 0)
+#define CPR3_THRESH_UP_THRESH_SHIFT		13
+
+#define CPR3_REG_RO_MASK(thread)		(0x80C + 0x440 * (thread))
+
+#define CPR3_REG_RESULT0(thread)		(0x810 + 0x440 * (thread))
+#define CPR3_RESULT0_BUSY_MASK			BIT(0)
+#define CPR3_RESULT0_STEP_DN_MASK		BIT(1)
+#define CPR3_RESULT0_STEP_UP_MASK		BIT(2)
+#define CPR3_RESULT0_ERROR_STEPS_MASK		GENMASK(4, 0)
+#define CPR3_RESULT0_ERROR_STEPS_SHIFT		3
+#define CPR3_RESULT0_ERROR_MASK			GENMASK(11, 0)
+#define CPR3_RESULT0_ERROR_SHIFT		8
+
+#define CPR3_REG_RESULT1(thread)		(0x814 + 0x440 * (thread))
+#define CPR3_RESULT1_QUOT_MIN_MASK		GENMASK(11, 0)
+#define CPR3_RESULT1_QUOT_MIN_SHIFT		0
+#define CPR3_RESULT1_QUOT_MAX_MASK		GENMASK(11, 0)
+#define CPR3_RESULT1_QUOT_MAX_SHIFT		12
+#define CPR3_RESULT1_RO_MIN_MASK		GENMASK(3, 0)
+#define CPR3_RESULT1_RO_MIN_SHIFT		24
+#define CPR3_RESULT1_RO_MAX_MASK		GENMASK(3, 0)
+#define CPR3_RESULT1_RO_MAX_SHIFT		28
+
+#define CPR3_REG_RESULT2(thread)		(0x818 + 0x440 * (thread))
+#define CPR3_RESULT2_STEP_QUOT_MIN_MASK		GENMASK(5, 0)
+#define CPR3_RESULT2_STEP_QUOT_MIN_SHIFT	0
+#define CPR3_RESULT2_STEP_QUOT_MAX_MASK		GENMASK(5, 0)
+#define CPR3_RESULT2_STEP_QUOT_MAX_SHIFT	6
+#define CPR3_RESULT2_SENSOR_MIN_MASK		GENMASK(7, 0)
+#define CPR3_RESULT2_SENSOR_MIN_SHIFT		16
+#define CPR3_RESULT2_SENSOR_MAX_MASK		GENMASK(7, 0)
+#define CPR3_RESULT2_SENSOR_MAX_SHIFT		24
+
+#define CPR3_REG_IRQ_EN				0x81C
+#define CPR3_REG_IRQ_CLEAR			0x820
+#define CPR3_REG_IRQ_STATUS			0x824
+#define CPR3_IRQ_UP				BIT(3)
+#define CPR3_IRQ_MID				BIT(2)
+#define CPR3_IRQ_DOWN				BIT(1)
+#define CPR3_IRQ_ALL				(CPR3_IRQ_UP | CPR3_IRQ_MID | CPR3_IRQ_DOWN)
+
+#define CPR3_REG_TARGET_QUOT(thread, ro)	(0x840 + 0x440 * (thread) + 0x4 * (ro))
+
+/* Registers found only on controllers that support HW closed-loop. */
+#define CPR3_REG_PD_THROTTLE			0xE8
+
+#define CPR3_REG_HW_CLOSED_LOOP_DISABLED	0x3000
+#define CPR3_REG_CPR_TIMER_MID_CONT		0x3004
+#define CPR3_REG_CPR_TIMER_UP_DN_CONT		0x3008
+
+/* CPR4 controller specific registers and bit definitions */
+#define CPR4_REG_CPR_TIMER_CLAMP			0x10
+#define CPR4_CPR_TIMER_CLAMP_THREAD_AGGREGATION_EN	BIT(27)
+
+#define CPR4_REG_MISC				0x700
+#define CPR4_MISC_RESET_STEP_QUOT_LOOP_EN	BIT(2)
+#define CPR4_MISC_THREAD_HAS_ALWAYS_VOTE_EN	BIT(3)
+
+#define CPR4_REG_SAW_ERROR_STEP_LIMIT		0x7A4
+#define CPR4_SAW_ERROR_STEP_LIMIT_UP_MASK	GENMASK(4, 0)
+#define CPR4_SAW_ERROR_STEP_LIMIT_UP_SHIFT	0
+#define CPR4_SAW_ERROR_STEP_LIMIT_DN_MASK	GENMASK(4, 0)
+#define CPR4_SAW_ERROR_STEP_LIMIT_DN_SHIFT	5
+
+#define CPR4_REG_MARGIN_TEMP_CORE_TIMERS			0x7A8
+#define CPR4_MARGIN_TEMP_CORE_TIMERS_SETTLE_VOLTAGE_COUNT_MASK	GENMASK(10, 0)
+#define CPR4_MARGIN_TEMP_CORE_TIMERS_SETTLE_VOLTAGE_COUNT_SHFT	18
+
+#define CPR4_REG_MARGIN_ADJ_CTL				0x7F8
+#define CPR4_MARGIN_ADJ_HW_CLOSED_LOOP_EN		BIT(4)
+#define CPR4_MARGIN_ADJ_PER_RO_KV_MARGIN_EN		BIT(7)
+#define CPR4_MARGIN_ADJ_PMIC_STEP_SIZE_MASK		GENMASK(4, 0)
+#define CPR4_MARGIN_ADJ_PMIC_STEP_SIZE_SHIFT		12
+
+#define CPR4_REG_CPR_MASK_THREAD(thread)		(0x80C + 0x440 * (thread))
+#define CPR4_CPR_MASK_THREAD_DISABLE_THREAD		BIT(31)
+#define CPR4_CPR_MASK_THREAD_RO_MASK4THREAD_MASK	GENMASK(15, 0)
+
+/* CPRh controller specific registers and bit definitions */
+#define __CPRH_REG_CORNER(rbase, tbase, tid, cnum) (rbase + (tbase * tid) + \
+						    (0x4 * cnum))
+#define CPRH_REG_CORNER(d, t, c) __CPRH_REG_CORNER(d->reg_corner,     \
+						   d->reg_corner_tid, \
+						   t, c);
+
+#define CPRH_CTL_OSM_ENABLED			BIT(0)
+#define CPRH_CTL_BASE_VOLTAGE_MASK		GENMASK(10, 1)
+#define CPRH_CTL_BASE_VOLTAGE_SHIFT		1
+#define CPRH_CTL_MODE_SWITCH_DELAY_MASK		GENMASK(24, 17)
+#define CPRH_CTL_MODE_SWITCH_DELAY_SHIFT	17
+#define CPRH_CTL_VOLTAGE_MULTIPLIER_MASK	GENMASK(28, 25)
+#define CPRH_CTL_VOLTAGE_MULTIPLIER_SHIFT	25
+
+#define CPRH_CORNER_INIT_VOLTAGE_MASK		GENMASK(7, 0)
+#define CPRH_CORNER_INIT_VOLTAGE_SHIFT		0
+#define CPRH_CORNER_FLOOR_VOLTAGE_MASK		GENMASK(15, 8)
+#define CPRH_CORNER_FLOOR_VOLTAGE_SHIFT		8
+#define CPRH_CORNER_QUOT_DELTA_MASK		GENMASK(24, 16)
+#define CPRH_CORNER_QUOT_DELTA_SHIFT		16
+#define CPRH_CORNER_RO_SEL_MASK			GENMASK(28, 25)
+#define CPRH_CORNER_RO_SEL_SHIFT		25
+#define CPRH_CORNER_CPR_CL_DISABLE		BIT(29)
+
+#define CPRH_CORNER_INIT_VOLTAGE_MAX_VALUE	255
+#define CPRH_CORNER_FLOOR_VOLTAGE_MAX_VALUE	255
+#define CPRH_CORNER_QUOT_DELTA_MAX_VALUE	511
+
+enum cpr_type {
+	CTRL_TYPE_CPR3,
+	CTRL_TYPE_CPR4,
+	CTRL_TYPE_CPRH,
+	CTRL_TYPE_MAX,
+};
+
+/*
+ * struct cpr_thread_desc - CPR Thread-specific parameters
+ *
+ * @controller_id:      Identifier of the CPR controller expected by the HW
+ * @ro_scaling_factor:  Scaling factor for each ring oscillator entry
+ * @hw_tid:             Identifier of the CPR thread expected by the HW
+ * @init_voltage_step:  Voltage in uV for each step read from the fuse array
+ * @init_voltage_width: Bitwidth of the voltage read from the fuse array
+ * @sensor_range_start: First sensor ID used by a thread
+ * @sensor_range_end:   Last sensor ID used by a thread
+ * @num_fuse_corners:   Number of valid entries in fuse_corner_data
+ * @fuse_corner_data:   Parameters for calculation of each fuse corner
+ */
+struct cpr_thread_desc {
+	int		controller_id;
+	int		hw_tid;
+	const int	*ro_scaling_factor;
+	int		init_voltage_step;
+	int		init_voltage_width;
+	int		sensor_range_start;
+	int		sensor_range_end;
+	unsigned int	num_fuse_corners;
+	struct fuse_corner_data *fuse_corner_data;
+};
+
+/*
+ * struct cpr_desc - Driver instance-wide CPR parameters
+ *
+ * @cpr_type:              Type (base version) of the CPR controller
+ * @num_threads:           Max. number of threads supported by this controller
+ * @timer_delay_us:        Loop delay time in uS
+ * @timer_updn_delay_us:   Voltage after-up/before-down delay time in uS
+ * @timer_cons_up:         Wait between consecutive up requests in uS
+ * @timer_cons_down:       Wait between consecutive down requests in uS
+ * @up_threshold:          Generic corner up threshold
+ * @down_threshold:        Generic corner down threshold
+ * @idle_clocks:           CPR Sensor: idle timer in cpr clocks unit
+ * @count_mode:            CPR Sensor: counting mode
+ * @count_repeat:          CPR Sensor: number of times to repeat reading
+ * @step_quot_init_min:    Minimum achievable step quotient
+ * @step_quot_init_max:    Maximum achievable step quotient
+ * @gcnt_us:               CPR measurement interval in uS
+ * @vreg_step_fixed:       Regulator voltage per step (if vreg unusable)
+ * @vreg_step_up_limit:    Num. of steps up at once before re-measuring sensors
+ * @vreg_step_down_limit:  Num. of steps dn at once before re-measuring sensors
+ * @vdd_settle_time_us:    Settling timer to account for one VDD supply step
+ * @corner_settle_time_us: Settle time for corner switch request
+ * @apm_threshold:         Array Power Mux (APM) voltage threshold
+ * @apm_hysteresis:        Hysteresis for APM V-threshold related calculations
+ * @cpr_base_voltage:      Safety: Absolute minimum voltage (uV) on this CPR
+ * @cpr_max_voltage:       Safety: Absolute maximum voltage (uV) on this CPR
+ * @pd_throttle_val:       CPR Power Domain throttle during voltage switch
+ * @threads:               Array containing "CPR Thread" specific parameters
+ * @reduce_to_fuse_uV:     Reduce corner max volts (if higher) to fuse ceiling
+ * @reduce_to_corner_uV:   Reduce corner max volts (if higher) to corner ceil.
+ * @hw_closed_loop_en:     Enable CPR HW Closed-Loop voltage auto-adjustment
+ */
+struct cpr_desc {
+	enum cpr_type		cpr_type;
+	unsigned int		num_threads;
+	unsigned int		timer_delay_us;
+	unsigned int		timer_updn_delay_us;
+	unsigned int		timer_cons_up;
+	unsigned int		timer_cons_down;
+	unsigned int		up_threshold;
+	unsigned int		down_threshold;
+	unsigned int		idle_clocks;
+	unsigned int		count_mode;
+	unsigned int		count_repeat;
+	unsigned int		step_quot_init_min;
+	unsigned int		step_quot_init_max;
+	unsigned int		gcnt_us;
+	unsigned int		vreg_step_fixed;
+	unsigned int		vreg_step_up_limit;
+	unsigned int		vreg_step_down_limit;
+	unsigned int		vdd_settle_time_us;
+	unsigned int		corner_settle_time_us;
+	int			apm_threshold;
+	int			apm_hysteresis;
+	u32			cpr_base_voltage;
+	u32			cpr_max_voltage;
+	u32			pd_throttle_val;
+
+	const struct cpr_thread_desc **threads;
+	bool reduce_to_fuse_uV;
+	bool reduce_to_corner_uV;
+	bool hw_closed_loop_en;
+};
+
+struct cpr_drv;
+struct cpr_thread {
+	int			num_corners;
+	int			id;
+	bool			enabled;
+	void __iomem		*base;
+	struct clk		*cpu_clk;
+	struct corner		*corner;
+	struct corner		*corners;
+	struct fuse_corner	*fuse_corners;
+	struct cpr_drv		*drv;
+	struct generic_pm_domain pd;
+	struct device		*attached_cpu_dev;
+	struct work_struct	restart_work;
+	bool			restarting;
+
+	const struct cpr_fuse	*cpr_fuses;
+	const struct cpr_thread_desc *desc;
+};
+
+struct cpr_drv {
+	int			num_threads;
+	int			irq;
+	unsigned int		ref_clk_khz;
+	struct device		*dev;
+	struct mutex		lock;
+	struct regulator	*vreg;
+	struct regmap		*tcsr;
+	u32			gcnt;
+	u32			speed_bin;
+	u32			fusing_rev;
+	u32			last_uV;
+	u32			cpr_hw_rev;
+	u32			reg_corner;
+	u32			reg_corner_tid;
+	u32			reg_ctl;
+	u32			reg_status;
+	int			fuse_level_set;
+	int			extra_corners;
+	unsigned int		vreg_step;
+	bool			enabled;
+
+	struct cpr_thread	*threads;
+	struct genpd_onecell_data cell_data;
+
+	const struct cpr_desc *desc;
+	const struct acc_desc *acc_desc;
+	struct dentry *debugfs;
+};
+
+static void cpr_write(struct cpr_thread *thread, u32 offset, u32 value)
+{
+	writel_relaxed(value, thread->base + offset);
+}
+
+static u32 cpr_read(struct cpr_thread *thread, u32 offset)
+{
+	return readl_relaxed(thread->base + offset);
+}
+
+static void
+cpr_masked_write(struct cpr_thread *thread, u32 offset, u32 mask, u32 value)
+{
+	u32 val;
+
+	val = readl_relaxed(thread->base + offset);
+	val &= ~mask;
+	val |= value & mask;
+	writel_relaxed(val, thread->base + offset);
+}
+
+static void cpr_irq_clr(struct cpr_thread *thread)
+{
+	cpr_write(thread, CPR3_REG_IRQ_CLEAR, CPR3_IRQ_ALL);
+}
+
+static void cpr_irq_clr_nack(struct cpr_thread *thread)
+{
+	cpr_irq_clr(thread);
+	cpr_write(thread, CPR3_REG_CONT_CMD, CPR3_CONT_CMD_NACK);
+}
+
+static void cpr_irq_clr_ack(struct cpr_thread *thread)
+{
+	cpr_irq_clr(thread);
+	cpr_write(thread, CPR3_REG_CONT_CMD, CPR3_CONT_CMD_ACK);
+}
+
+static void cpr_irq_set(struct cpr_thread *thread, u32 int_bits)
+{
+	/* On CPR-hardened, interrupts are managed by and on firmware */
+	if (thread->drv->desc->cpr_type == CTRL_TYPE_CPRH)
+		return;
+
+	cpr_write(thread, CPR3_REG_IRQ_EN, int_bits);
+}
+
+/**
+ * cpr_ctl_enable - Enable CPR thread
+ * @thread:     Structure holding CPR thread-specific parameters
+ */
+static void cpr_ctl_enable(struct cpr_thread *thread)
+{
+	if (thread->drv->enabled && !thread->restarting)
+		cpr_masked_write(thread, CPR3_REG_CPR_CTL,
+				CPR3_CPR_CTL_LOOP_EN_MASK,
+				CPR3_CPR_CTL_LOOP_EN_MASK);
+}
+
+/**
+ * cpr_ctl_disable - Disable CPR thread
+ * @thread:     Structure holding CPR thread-specific parameters
+ */
+static void cpr_ctl_disable(struct cpr_thread *thread)
+{
+	const struct cpr_desc *desc = thread->drv->desc;
+
+	if (desc->cpr_type != CTRL_TYPE_CPRH) {
+		cpr_irq_set(thread, 0);
+		cpr_irq_clr(thread);
+	}
+
+	cpr_masked_write(thread, CPR3_REG_CPR_CTL,
+			 CPR3_CPR_CTL_LOOP_EN_MASK, 0);
+}
+
+/**
+ * cpr_ctl_is_enabled - Check if thread is enabled
+ * @thread:     Structure holding CPR thread-specific parameters
+ *
+ * Returns: true if the CPR is enabled, false if it is disabled.
+ */
+static bool cpr_ctl_is_enabled(struct cpr_thread *thread)
+{
+	u32 reg_val;
+
+	reg_val = cpr_read(thread, CPR3_REG_CPR_CTL);
+	return reg_val & CPR3_CPR_CTL_LOOP_EN_MASK;
+}
+
+/**
+ * cpr_check_any_thread_busy - Check if HW is done processing
+ * @thread:     Structure holding CPR thread-specific parameters
+ *
+ * Returns: true if the CPR is busy, false if it is ready.
+ */
+static bool cpr_check_any_thread_busy(struct cpr_thread *thread)
+{
+	int i;
+
+	for (i = 0; i < thread->drv->num_threads; i++)
+		if (cpr_read(thread, CPR3_REG_RESULT0(i)) &
+		    CPR3_RESULT0_BUSY_MASK)
+			return true;
+
+	return false;
+}
+
+static void cpr_restart_worker(struct work_struct *work)
+{
+	struct cpr_thread *thread = container_of(work, struct cpr_thread,
+						 restart_work);
+	struct cpr_drv *drv = thread->drv;
+	int i;
+
+	mutex_lock(&drv->lock);
+
+	thread->restarting = true;
+	cpr_ctl_disable(thread);
+	disable_irq(drv->irq);
+
+	mutex_unlock(&drv->lock);
+
+	for (i = 0; i < 20; i++) {
+		u32 cpr_status = cpr_read(thread, CPR3_REG_CPR_STATUS);
+		u32 ctl = cpr_read(thread, CPR3_REG_CPR_CTL);
+
+		if ((cpr_status & CPR3_CPR_STATUS_BUSY_MASK) &&
+		   !(ctl & CPR3_CPR_CTL_LOOP_EN_MASK))
+			break;
+
+		udelay(10);
+	}
+
+	cpr_irq_clr(thread);
+
+	for (i = 0; i < 20; i++) {
+		u32 status = cpr_read(thread, CPR3_REG_IRQ_STATUS);
+
+		if (!(status & CPR3_IRQ_ALL))
+			break;
+		udelay(10);
+	}
+
+	mutex_lock(&drv->lock);
+
+	thread->restarting = false;
+	enable_irq(drv->irq);
+	cpr_ctl_enable(thread);
+
+	mutex_unlock(&drv->lock);
+}
+
+/**
+ * cpr_corner_restore - Restore saved corner level
+ * @thread: Structure holding CPR thread-specific parameters
+ * @corner: Structure holding the saved corner level
+ */
+static void cpr_corner_restore(struct cpr_thread *thread,
+			       struct corner *corner)
+{
+	struct cpr_drv *drv = thread->drv;
+	struct fuse_corner *fuse = corner->fuse_corner;
+	const struct cpr_thread_desc *tdesc = thread->desc;
+	u32 ro_sel = fuse->ring_osc_idx;
+
+	cpr_write(thread, CPR3_REG_GCNT(ro_sel), drv->gcnt);
+
+	cpr_write(thread, CPR3_REG_RO_MASK(tdesc->hw_tid),
+		  CPR3_RO_MASK & ~BIT(ro_sel));
+
+	cpr_write(thread, CPR3_REG_TARGET_QUOT(tdesc->hw_tid, ro_sel),
+		  fuse->quot - corner->quot_adjust);
+
+	if (drv->desc->cpr_type == CTRL_TYPE_CPR4) {
+		cpr_masked_write(thread,
+				 CPR4_REG_CPR_MASK_THREAD(tdesc->hw_tid),
+				 CPR4_CPR_MASK_THREAD_DISABLE_THREAD |
+				 CPR4_CPR_MASK_THREAD_RO_MASK4THREAD_MASK, 0);
+	}
+
+	thread->corner = corner;
+	corner->last_uV = corner->uV;
+}
+
+/**
+ * cpr_set_acc - Set fuse level to the mem-acc
+ * @thread: Structure holding CPR thread-specific parameters
+ * @f:      Fuse level
+ */
+static void cpr_set_acc(struct cpr_drv *drv, int f)
+{
+	const struct acc_desc *desc = drv->acc_desc;
+	struct reg_sequence *s = desc->settings;
+	int n = desc->num_regs_per_fuse;
+
+	if (!s || f == drv->fuse_level_set)
+		return;
+
+	regmap_multi_reg_write(drv->tcsr, s + (n * f), n);
+	drv->fuse_level_set = f;
+}
+
+/**
+ * cpr_post_voltage - Actions to execute before setting voltage
+ * @thread:     Structure holding CPR thread-specific parameters
+ * @dir:        Enumeration for voltage change direction
+ * @fuse_level: Fuse corner for mem-acc, if supported.
+ *
+ * Returns: Zero for success or negative number on errors.
+ */
+static int cpr_pre_voltage(struct cpr_thread *thread,
+			   enum voltage_change_dir dir,
+			   int fuse_level)
+{
+	struct cpr_drv *drv = thread->drv;
+
+	if (drv->desc->cpr_type == CTRL_TYPE_CPR3 &&
+	    drv->desc->pd_throttle_val)
+		cpr_write(thread, CPR3_REG_PD_THROTTLE,
+			  drv->desc->pd_throttle_val);
+
+	if (drv->tcsr && dir == DOWN)
+		cpr_set_acc(drv, fuse_level);
+
+	return 0;
+}
+
+/**
+ * cpr_post_voltage - Actions to execute after setting voltage
+ * @thread:     Structure holding CPR thread-specific parameters
+ * @dir:        Enumeration for voltage change direction
+ * @fuse_level: Fuse corner for mem-acc, if supported.
+ *
+ * Returns: Zero for success or negative number on errors.
+ */
+static int cpr_post_voltage(struct cpr_thread *thread,
+			    enum voltage_change_dir dir,
+			    int fuse_level)
+{
+	struct cpr_drv *drv = thread->drv;
+
+	if (drv->tcsr && dir == UP)
+		cpr_set_acc(drv, fuse_level);
+
+	if (drv->desc->cpr_type == CTRL_TYPE_CPR3)
+		cpr_write(thread, CPR3_REG_PD_THROTTLE, 0);
+
+	return 0;
+}
+
+/**
+ * cpr_commit_state - Set the newly requested voltage
+ * @thread:     Structure holding CPR thread-specific parameters
+ *
+ * Returns: IRQ_SUCCESS for success, IRQ_NONE if the CPR is disabled.
+ */
+static int cpr_commit_state(struct cpr_thread *thread)
+{
+	struct cpr_drv *drv = thread->drv;
+	int min_uV = 0, max_uV = 0, new_uV = 0, fuse_level = 0;
+	enum voltage_change_dir dir;
+	u32 next_irqmask = 0;
+	int ret, i;
+
+	/* On CPRhardened, control states are managed in firmware */
+	if (drv->desc->cpr_type == CTRL_TYPE_CPRH)
+		return 0;
+
+	for (i = 0; i < drv->num_threads; i++) {
+		struct cpr_thread *thread = &drv->threads[i];
+
+		if (!thread->corner)
+			continue;
+
+		fuse_level = max(fuse_level,
+				 (int) (thread->corner->fuse_corner -
+				 &thread->fuse_corners[0]));
+
+		max_uV = max(max_uV, thread->corner->max_uV);
+		min_uV = max(min_uV, thread->corner->min_uV);
+		new_uV = max(new_uV, thread->corner->last_uV);
+	}
+	dev_vdbg(drv->dev, "%s: new uV: %d, last uV: %d\n",
+		 __func__, new_uV, drv->last_uV);
+
+	/*
+	 * Safety measure: if the voltage is out of the globally allowed
+	 * range, then go out and warn the user.
+	 * This should *never* happen.
+	 */
+	if (new_uV > drv->desc->cpr_max_voltage ||
+	    new_uV < drv->desc->cpr_base_voltage) {
+		dev_warn(drv->dev, "Voltage (%u uV) out of range.", new_uV);
+		return -EINVAL;
+	}
+
+	if (new_uV == drv->last_uV || fuse_level == drv->fuse_level_set)
+		goto out;
+
+	if (fuse_level > drv->fuse_level_set)
+		dir = UP;
+	else
+		dir = DOWN;
+
+	ret = cpr_pre_voltage(thread, fuse_level, dir);
+	if (ret)
+		return ret;
+
+	dev_vdbg(drv->dev, "setting voltage: %d\n", new_uV);
+
+	ret = regulator_set_voltage(drv->vreg, new_uV, new_uV);
+	if (ret) {
+		dev_err_ratelimited(drv->dev, "failed to set voltage %d: %d\n",
+				    new_uV, ret);
+		return ret;
+	}
+
+	ret = cpr_post_voltage(thread, fuse_level, dir);
+	if (ret)
+		return ret;
+
+	drv->last_uV = new_uV;
+out:
+	if (new_uV > min_uV)
+		next_irqmask |= CPR3_IRQ_DOWN;
+	if (new_uV < max_uV)
+		next_irqmask |= CPR3_IRQ_UP;
+
+	cpr_irq_set(thread, next_irqmask);
+
+	return 0;
+}
+
+static unsigned int cpr_get_cur_perf_state(struct cpr_thread *thread)
+{
+	return thread->corner ? thread->corner - thread->corners + 1 : 0;
+}
+
+/**
+ * cpr_scale - Calculate new voltage for the received direction
+ * @thread: Structure holding CPR thread-specific parameters
+ * @dir:    Enumeration for voltage change direction
+ *
+ * The CPR scales one by one: this function calculates the new
+ * voltage to set when a voltage-UP or voltage-DOWN request comes
+ * and stores it into the per-thread structure that gets passed.
+ */
+static void cpr_scale(struct cpr_thread *thread, enum voltage_change_dir dir)
+{
+	struct cpr_drv *drv = thread->drv;
+	const struct cpr_thread_desc *tdesc = thread->desc;
+	u32 val, error_steps;
+	int last_uV, new_uV;
+	struct corner *corner;
+
+	if (dir != UP && dir != DOWN)
+		return;
+
+	corner = thread->corner;
+	val = cpr_read(thread, CPR3_REG_RESULT0(tdesc->hw_tid));
+	error_steps = val >> CPR3_RESULT0_ERROR_STEPS_SHIFT;
+	error_steps &= CPR3_RESULT0_ERROR_STEPS_MASK;
+
+	last_uV = corner->last_uV;
+
+	if (dir == UP) {
+		if (!(val & CPR3_RESULT0_STEP_UP_MASK))
+			return;
+
+		/* Calculate new voltage */
+		new_uV = last_uV + drv->vreg_step;
+		new_uV = min(new_uV, corner->max_uV);
+
+		dev_vdbg(drv->dev,
+			"[T%u] UP - new_uV=%d last_uV=%d p-state=%u st=%u\n",
+			thread->id, new_uV, last_uV,
+			cpr_get_cur_perf_state(thread), error_steps);
+	} else {
+		if (!(val & CPR3_RESULT0_STEP_DN_MASK))
+			return;
+
+		/* Calculate new voltage */
+		new_uV = last_uV - drv->vreg_step;
+		new_uV = max(new_uV, corner->min_uV);
+		dev_vdbg(drv->dev,
+			"[T%u] DOWN - new_uV=%d last_uV=%d p-state=%u st=%u\n",
+			thread->id, new_uV, last_uV,
+			cpr_get_cur_perf_state(thread), error_steps);
+	}
+	corner->last_uV = new_uV;
+}
+
+/**
+ * cpr_irq_handler - Handle CPR3/CPR4 status interrupts
+ * @irq: Number of the interrupt
+ * @dev: Pointer to the cpr_thread structure
+ *
+ * Handle the interrupts coming from non-hardened CPR HW as to get
+ * an ok to scale voltages immediately, or to pass error status to
+ * the hardware (either success/ACK or failure/NACK).
+ *
+ * Returns: IRQ_SUCCESS for success, IRQ_NONE if the CPR is disabled.
+ */
+static irqreturn_t cpr_irq_handler(int irq, void *dev)
+{
+	struct cpr_thread *thread = dev;
+	struct cpr_drv *drv = thread->drv;
+	irqreturn_t ret = IRQ_HANDLED;
+	int i, rc;
+	enum voltage_change_dir dir = NO_CHANGE;
+	u32 val;
+
+	mutex_lock(&drv->lock);
+
+	val = cpr_read(thread, CPR3_REG_IRQ_STATUS);
+
+	dev_vdbg(drv->dev, "IRQ_STATUS = %#02x\n", val);
+
+	if (!cpr_ctl_is_enabled(thread)) {
+		dev_vdbg(drv->dev, "CPR is disabled\n");
+		ret = IRQ_NONE;
+	} else if (cpr_check_any_thread_busy(thread)) {
+		cpr_irq_clr_nack(thread);
+		dev_dbg(drv->dev, "CPR measurement is not ready\n");
+	} else {
+		/*
+		 * Following sequence of handling is as per each IRQ's
+		 * priority
+		 */
+		if (val & CPR3_IRQ_UP)
+			dir = UP;
+		else if (val & CPR3_IRQ_DOWN)
+			dir = DOWN;
+
+		if (dir != NO_CHANGE) {
+			for (i = 0; i < drv->num_threads; i++) {
+				thread = &drv->threads[i];
+				cpr_scale(thread, dir);
+			}
+
+			rc = cpr_commit_state(thread);
+			if (rc)
+				cpr_irq_clr_nack(thread);
+			else
+				cpr_irq_clr_ack(thread);
+		} else if (val & CPR3_IRQ_MID) {
+			dev_dbg(drv->dev, "IRQ occurred for Mid Flag\n");
+		} else {
+			dev_warn(drv->dev,
+				 "IRQ occurred for unknown flag (%#08x)\n",
+				 val);
+			schedule_work(&thread->restart_work);
+		}
+	}
+
+	mutex_unlock(&drv->lock);
+
+	return ret;
+}
+
+static int cpr_switch(struct cpr_drv *drv)
+{
+	int i, ret;
+	bool enabled = false;
+
+	if (drv->desc->cpr_type == CTRL_TYPE_CPRH)
+		return 0;
+
+	for (i = 0; i < drv->num_threads && !enabled; i++)
+		enabled = drv->threads[i].enabled;
+
+	dev_vdbg(drv->dev, "%s: enabled = %d\n", __func__, enabled);
+
+	if (enabled == drv->enabled)
+		return 0;
+
+	if (enabled) {
+		ret = regulator_enable(drv->vreg);
+		if (ret)
+			return ret;
+
+		drv->enabled = enabled;
+
+		for (i = 0; i < drv->num_threads; i++)
+			if (drv->threads[i].corner)
+				break;
+
+		if (i < drv->num_threads) {
+			cpr_irq_clr(&drv->threads[i]);
+
+			cpr_commit_state(&drv->threads[i]);
+			cpr_ctl_enable(&drv->threads[i]);
+		}
+	} else {
+		for (i = 0; i < drv->num_threads && !enabled; i++)
+			cpr_ctl_disable(&drv->threads[i]);
+
+		drv->enabled = enabled;
+
+		ret = regulator_disable(drv->vreg);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * cpr_enable - Enables a CPR thread
+ * @thread: Structure holding CPR thread-specific parameters
+ *
+ * Returns: Zero for success or negative number on errors.
+ */
+static int cpr_enable(struct cpr_thread *thread)
+{
+	struct cpr_drv *drv = thread->drv;
+	int ret;
+
+	dev_dbg(drv->dev, "Enabling thread %d\n", thread->id);
+
+	mutex_lock(&drv->lock);
+
+	thread->enabled = true;
+	ret = cpr_switch(thread->drv);
+
+	mutex_unlock(&drv->lock);
+
+	return ret;
+}
+
+/**
+ * cpr_disable - Disables a CPR thread
+ * @thread: Structure holding CPR thread-specific parameters
+ *
+ * Returns: Zero for success or negative number on errors.
+ */
+static int cpr_disable(struct cpr_thread *thread)
+{
+	struct cpr_drv *drv = thread->drv;
+	int ret;
+
+	dev_dbg(drv->dev, "Disabling thread %d\n", thread->id);
+
+	mutex_lock(&drv->lock);
+
+	thread->enabled = false;
+	ret = cpr_switch(thread->drv);
+
+	mutex_unlock(&drv->lock);
+
+	return ret;
+}
+
+/**
+ * cpr_configure - Configure main HW parameters
+ * @thread: Structure holding CPR thread-specific parameters
+ *
+ * This function configures the main CPR hardware parameters, such as
+ * internal timers (and delays), sensor ownerships, activates and/or
+ * deactivates cpr-threads and others, as one sequence for all of the
+ * versions supported in this driver. By design, the function may
+ * return a success earlier if the sequence for "a previous version"
+ * has ended.
+ *
+ * NOTE: The CPR must be clocked before calling this function!
+ *
+ * Returns: Zero for success or negative number on errors.
+ */
+static int cpr_configure(struct cpr_thread *thread)
+{
+	struct cpr_drv *drv = thread->drv;
+	const struct cpr_desc *desc = drv->desc;
+	const struct cpr_thread_desc *tdesc = thread->desc;
+	int i;
+	u32 val;
+
+	/* Disable interrupt and CPR */
+	cpr_irq_set(thread, 0);
+	cpr_write(thread, CPR3_REG_CPR_CTL, 0);
+
+	/* Init and save gcnt */
+	drv->gcnt = drv->ref_clk_khz * desc->gcnt_us;
+	do_div(drv->gcnt, 1000);
+
+	/* Program the delay count for the timer */
+	val = drv->ref_clk_khz * desc->timer_delay_us;
+	do_div(val, 1000);
+	if (desc->cpr_type == CTRL_TYPE_CPR3) {
+		cpr_write(thread, CPR3_REG_CPR_TIMER_MID_CONT, val);
+
+		val = drv->ref_clk_khz * desc->timer_updn_delay_us;
+		do_div(val, 1000);
+		cpr_write(thread, CPR3_REG_CPR_TIMER_UP_DN_CONT, val);
+	} else {
+		cpr_write(thread, CPR3_REG_CPR_TIMER_AUTO_CONT, val);
+	}
+	dev_dbg(drv->dev, "Timer count: %#0x (for %d us)\n", val,
+		desc->timer_delay_us);
+
+	/* Program the control register */
+	val = desc->idle_clocks << CPR3_CPR_CTL_IDLE_CLOCKS_SHIFT
+	    | desc->count_mode << CPR3_CPR_CTL_COUNT_MODE_SHIFT
+	    | desc->count_repeat << CPR3_CPR_CTL_COUNT_REPEAT_SHIFT;
+	cpr_write(thread, CPR3_REG_CPR_CTL, val);
+
+	/* Configure CPR default step quotients */
+	val = desc->step_quot_init_min << CPR3_CPR_STEP_QUOT_MIN_SHIFT
+	    | desc->step_quot_init_max << CPR3_CPR_STEP_QUOT_MAX_SHIFT;
+	cpr_write(thread, CPR3_REG_CPR_STEP_QUOT, val);
+
+	/*
+	 * Configure the CPR sensor ownership always on thread 0
+	 * TODO: SDM845 has different ownership for sensors!!
+	 */
+	for (i = tdesc->sensor_range_start; i < tdesc->sensor_range_end; i++)
+		cpr_write(thread, CPR3_REG_SENSOR_OWNER(i), 0);
+
+	/* Program Consecutive Up & Down */
+	val = desc->timer_cons_up << CPR3_THRESH_CONS_UP_SHIFT;
+	val |= desc->timer_cons_down << CPR3_THRESH_CONS_DOWN_SHIFT;
+	val |= desc->up_threshold << CPR3_THRESH_UP_THRESH_SHIFT;
+	val |= desc->down_threshold << CPR3_THRESH_DOWN_THRESH_SHIFT;
+	cpr_write(thread, CPR3_REG_THRESH(tdesc->hw_tid), val);
+
+	/* Mask all ring oscillators for all threads initially */
+	cpr_write(thread, CPR3_REG_RO_MASK(tdesc->hw_tid), CPR3_RO_MASK);
+
+	/* HW Closed-loop control */
+	if (desc->cpr_type == CTRL_TYPE_CPR3)
+		cpr_write(thread, CPR3_REG_HW_CLOSED_LOOP_DISABLED,
+			  !desc->hw_closed_loop_en);
+	else
+		cpr_masked_write(thread, CPR4_REG_MARGIN_ADJ_CTL,
+				CPR4_MARGIN_ADJ_HW_CLOSED_LOOP_EN,
+				desc->hw_closed_loop_en ?
+				CPR4_MARGIN_ADJ_HW_CLOSED_LOOP_EN : 0);
+
+	/* Additional configuration for CPR4 and beyond */
+	if (desc->cpr_type < CTRL_TYPE_CPR4)
+		return 0;
+
+	/* Disable threads initially only on non-hardened CPR4 */
+	if (desc->cpr_type == CTRL_TYPE_CPR4)
+		cpr_masked_write(thread, CPR4_REG_CPR_MASK_THREAD(1),
+				CPR4_CPR_MASK_THREAD_DISABLE_THREAD |
+				CPR4_CPR_MASK_THREAD_RO_MASK4THREAD_MASK,
+				CPR4_CPR_MASK_THREAD_DISABLE_THREAD |
+				CPR4_CPR_MASK_THREAD_RO_MASK4THREAD_MASK);
+
+	if (drv->num_threads == 2)
+		cpr_masked_write(thread, CPR4_REG_MISC,
+				 CPR4_MISC_RESET_STEP_QUOT_LOOP_EN |
+				 CPR4_MISC_THREAD_HAS_ALWAYS_VOTE_EN,
+				 CPR4_MISC_RESET_STEP_QUOT_LOOP_EN |
+				 CPR4_MISC_THREAD_HAS_ALWAYS_VOTE_EN);
+
+	val = drv->vreg_step;
+	do_div(val, 1000);
+	cpr_masked_write(thread, CPR4_REG_MARGIN_ADJ_CTL,
+			 CPR4_MARGIN_ADJ_PMIC_STEP_SIZE_MASK,
+			 val << CPR4_MARGIN_ADJ_PMIC_STEP_SIZE_SHIFT);
+
+	cpr_masked_write(thread, CPR4_REG_SAW_ERROR_STEP_LIMIT,
+			 CPR4_SAW_ERROR_STEP_LIMIT_DN_MASK,
+			 desc->vreg_step_down_limit <<
+			 CPR4_SAW_ERROR_STEP_LIMIT_DN_SHIFT);
+
+	cpr_masked_write(thread, CPR4_REG_SAW_ERROR_STEP_LIMIT,
+			 CPR4_SAW_ERROR_STEP_LIMIT_UP_MASK,
+			 desc->vreg_step_up_limit <<
+			 CPR4_SAW_ERROR_STEP_LIMIT_UP_SHIFT);
+
+	cpr_masked_write(thread, CPR4_REG_MARGIN_ADJ_CTL,
+			 CPR4_MARGIN_ADJ_PER_RO_KV_MARGIN_EN,
+			 CPR4_MARGIN_ADJ_PER_RO_KV_MARGIN_EN);
+
+	if (drv->num_threads > 1)
+		cpr_masked_write(thread, CPR4_REG_CPR_TIMER_CLAMP,
+				 CPR4_CPR_TIMER_CLAMP_THREAD_AGGREGATION_EN,
+				 CPR4_CPR_TIMER_CLAMP_THREAD_AGGREGATION_EN);
+
+	/* Settling timer to account for one VDD supply step */
+	if (desc->vdd_settle_time_us > 0) {
+		u32 m = CPR4_MARGIN_TEMP_CORE_TIMERS_SETTLE_VOLTAGE_COUNT_MASK;
+		u32 s = CPR4_MARGIN_TEMP_CORE_TIMERS_SETTLE_VOLTAGE_COUNT_SHFT;
+
+		cpr_masked_write(thread, CPR4_REG_MARGIN_TEMP_CORE_TIMERS,
+				 m, desc->vdd_settle_time_us << s);
+	}
+
+	/* Additional configuration for CPR-hardened */
+	if (desc->cpr_type < CTRL_TYPE_CPRH)
+		return 0;
+
+	/* Settling timer to account for one corner-switch request */
+	if (desc->corner_settle_time_us > 0)
+		cpr_masked_write(thread, drv->reg_ctl,
+				 CPRH_CTL_MODE_SWITCH_DELAY_MASK,
+				 desc->corner_settle_time_us <<
+				 CPRH_CTL_MODE_SWITCH_DELAY_SHIFT);
+
+	/* Base voltage and multiplier values for CPRh internal calculations */
+	cpr_masked_write(thread, drv->reg_ctl,
+			 CPRH_CTL_BASE_VOLTAGE_MASK,
+			 (DIV_ROUND_UP(desc->cpr_base_voltage,
+				       drv->vreg_step) <<
+			  CPRH_CTL_BASE_VOLTAGE_SHIFT));
+
+	cpr_masked_write(thread, drv->reg_ctl,
+			 CPRH_CTL_VOLTAGE_MULTIPLIER_MASK,
+			 DIV_ROUND_UP(drv->vreg_step, 1000) <<
+			 CPRH_CTL_VOLTAGE_MULTIPLIER_SHIFT);
+
+	return 0;
+}
+
+static int cpr_set_performance_state(struct generic_pm_domain *domain,
+				     unsigned int state)
+{
+	struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
+	struct cpr_drv *drv = thread->drv;
+	struct corner *corner, *end;
+	int ret = 0;
+
+	/* On CPRhardened, performance states are managed in firmware */
+	if (drv->desc->cpr_type == CTRL_TYPE_CPRH)
+		return 0;
+
+	mutex_lock(&drv->lock);
+
+	dev_dbg(drv->dev,
+		"setting perf state: %u (prev state: %u thread: %u)\n",
+		state, cpr_get_cur_perf_state(thread), thread->id);
+
+	/*
+	 * Determine new corner we're going to.
+	 * Remove one since lowest performance state is 1.
+	 */
+	corner = thread->corners + state - 1;
+	end = &thread->corners[thread->num_corners - 1];
+	if (corner > end || corner < thread->corners) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	cpr_ctl_disable(thread);
+
+	cpr_irq_clr(thread);
+	if (thread->corner != corner)
+		cpr_corner_restore(thread, corner);
+
+	ret = cpr_commit_state(thread);
+	if (ret)
+		goto unlock;
+
+	cpr_ctl_enable(thread);
+unlock:
+	mutex_unlock(&drv->lock);
+
+	dev_dbg(drv->dev,
+		"set perf state %u on thread %u\n", state, thread->id);
+
+	return ret;
+}
+
+/**
+ * cpr3_adjust_quot - Adjust the closed-loop quotients
+ * @thread: Structure holding CPR thread-specific parameters
+ *
+ * Calculates the quotient adjustment factor based on closed-loop
+ * quotients and ring oscillator factor.
+ *
+ * Returns: Adjusted quotient
+ */
+static int cpr3_adjust_quot(int ring_osc_factor, int volt_closed_loop)
+{
+	s64 temp;
+
+	if (ring_osc_factor == 0 || volt_closed_loop == 0)
+		return 0;
+
+	temp = (s64)(ring_osc_factor * volt_closed_loop);
+
+	return (int)div_s64(temp, 1000000);
+}
+
+/**
+ * cpr_fuse_corner_init - Calculate fuse corner table
+ * @thread: Structure holding CPR thread-specific parameters
+ *
+ * This function populates the fuse corners table by reading the
+ * values from the fuses, eventually adjusting them with a fixed
+ * per-corner offset and doing basic checks about them being
+ * supported by the regulator that is assigned to this CPR - if
+ * it is available (on CPR-Hardened, there is no usable vreg, as
+ * that is protected by the hypervisor).
+ *
+ * Returns: Zero for success, negative number on error
+ */
+static int cpr_fuse_corner_init(struct cpr_thread *thread)
+{
+	struct cpr_drv *drv = thread->drv;
+	const struct cpr_thread_desc *desc = thread->desc;
+	const struct cpr_fuse *cpr_fuse = thread->cpr_fuses;
+	struct fuse_corner_data *fdata;
+	struct fuse_corner *fuse, *end;
+	int i, ret;
+
+	/* Populate fuse_corner members */
+	fuse = thread->fuse_corners;
+	end = &fuse[desc->num_fuse_corners - 1];
+	fdata = desc->fuse_corner_data;
+
+	for (i = 0; fuse <= end; fuse++, cpr_fuse++, i++, fdata++) {
+		int ro_fac = desc->ro_scaling_factor[fuse->ring_osc_idx];
+
+		ret = cpr_populate_fuse_common(drv->dev, fdata, cpr_fuse,
+					       fuse, drv->vreg_step,
+					       desc->init_voltage_width,
+					       desc->init_voltage_step);
+		if (ret)
+			return ret;
+
+		/*
+		 * Adjust the fuse quot with per-fuse-corner closed-loop
+		 * voltage adjustment parameters.
+		 */
+		fuse->quot += cpr3_adjust_quot(ro_fac,
+					       fdata->volt_cloop_adjust);
+
+		/* CPRh: no regulator access... */
+		if (drv->desc->cpr_type == CTRL_TYPE_CPRH)
+			goto skip_pvs_restrict;
+
+		/* Re-check if corner voltage range is supported by regulator */
+		ret = cpr_check_vreg_constraints(drv->dev, drv->vreg, fuse);
+		if (ret)
+			return ret;
+
+skip_pvs_restrict:
+		dev_dbg(drv->dev,
+			"fuse corner %d: [%d %d %d] RO%hhu quot %d\n",
+			i, fuse->min_uV, fuse->uV, fuse->max_uV,
+			fuse->ring_osc_idx, fuse->quot);
+	}
+
+	return 0;
+}
+
+/*
+ * cprh_corner_adjust_opps - Set voltage on each CPU OPP table entry
+ *
+ * On CPR-Hardened, the voltage level is controlled internally through
+ * the OSM hardware: in order to initialize the latter, we have to
+ * communicate the voltage to its driver, so that it will be able to
+ * write the right parameters (as they have to be set both on the CPRh
+ * and on the OSM) on it.
+ * This function is called only for CPRh.
+ *
+ * Return: Zero for success, negative number for error.
+ */
+static int cprh_corner_adjust_opps(struct cpr_thread *thread)
+{
+	struct corner *corner = thread->corners;
+	struct cpr_drv *drv = thread->drv;
+	struct opp_table *tbl;
+	int i, ret;
+
+	tbl = dev_pm_opp_get_opp_table(thread->attached_cpu_dev);
+	if (IS_ERR(tbl))
+		return PTR_ERR(tbl);
+
+	for (i = 0; i < thread->num_corners; i++) {
+		ret = dev_pm_opp_adjust_voltage(thread->attached_cpu_dev,
+						corner[i].freq,
+						corner[i].uV,
+						corner[i].min_uV,
+						corner[i].max_uV);
+		if (ret)
+			break;
+
+		dev_dbg(drv->dev,
+			"OPP voltage adjusted for %lu kHz, %d uV\n",
+			corner[i].freq, corner[i].uV);
+	}
+
+	dev_pm_opp_put_opp_table(tbl);
+	return ret;
+}
+
+/**
+ * cpr3_corner_init - Calculate and set-up corners for the CPR HW
+ * @thread: Structure holding CPR thread-specific parameters
+ *
+ * This function calculates all the corner parameters by comparing
+ * and interpolating the values read from the various set-points
+ * read from the fuses (also called "fuse corners") to generate and
+ * program to the CPR a lookup table that describes each voltage
+ * step, mapped to a performance level (or corner number).
+ *
+ * It also programs other essential parameters on the CPR and - if
+ * we are dealing with CPR-Hardened, it will also enable the internal
+ * interface between the Operating State Manager (OSM) and the CPRh
+ * in order to achieve CPU DVFS.
+ *
+ * Returns: Zero for success, negative number on error
+ */
+static int cpr3_corner_init(struct cpr_thread *thread)
+{
+	struct cpr_drv *drv = thread->drv;
+	const struct cpr_desc *desc = drv->desc;
+	const struct cpr_thread_desc *tdesc = thread->desc;
+	const struct cpr_fuse *fuses = thread->cpr_fuses;
+	int i, ret, total_corners, level, scaling = 0;
+	unsigned int fnum, fc;
+	const char *quot_offset;
+	const struct fuse_corner_data *fdata;
+	struct fuse_corner *fuse, *prev_fuse;
+	struct corner *corner, *end;
+	struct corner_data *cdata;
+	struct dev_pm_opp *opp;
+	bool apply_scaling;
+	unsigned long freq;
+	u32 ring_osc_mask = CPR3_RO_MASK, min_quotient = U32_MAX;
+
+	corner = thread->corners;
+	end = &corner[thread->num_corners - 1];
+
+	cdata = devm_kcalloc(drv->dev,
+			     thread->num_corners + drv->extra_corners,
+			     sizeof(struct corner_data),
+			     GFP_KERNEL);
+	if (!cdata)
+		return -ENOMEM;
+
+	for (level = 1; level <= thread->num_corners; level++) {
+		opp = dev_pm_opp_find_level_exact(&thread->pd.dev, level);
+		if (IS_ERR(opp))
+			return -EINVAL;
+
+		/*
+		 * If there is only one specified qcom,opp-fuse-level, then
+		 * it is assumed that this only one is global and valid for
+		 * all IDs, so try to get the specific one but, on failure,
+		 * go for the global one.
+		 */
+		fc = cpr_get_fuse_corner(opp, thread->id);
+		if (fc == 0) {
+			fc = cpr_get_fuse_corner(opp, 0);
+			if (fc == 0) {
+				dev_err(drv->dev,
+					"qcom,opp-fuse-level is missing!\n");
+				dev_pm_opp_put(opp);
+				return -EINVAL;
+			}
+		}
+		fnum = fc - 1;
+
+		freq = cpr_get_opp_hz_for_req(opp, thread->attached_cpu_dev);
+		if (!freq) {
+			thread->num_corners = max(level - 1, 0);
+			end = &thread->corners[thread->num_corners - 1];
+			break;
+		}
+		cdata[level - 1].fuse_corner = fnum;
+		cdata[level - 1].freq = freq;
+
+		fuse = &thread->fuse_corners[fnum];
+		dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
+			freq, dev_pm_opp_get_level(opp) - 1, fnum);
+		if (freq > fuse->max_freq)
+			fuse->max_freq = freq;
+		dev_pm_opp_put(opp);
+	}
+
+	if (thread->num_corners < 2) {
+		dev_err(drv->dev, "need at least 2 OPPs to use CPR\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get the quotient adjustment scaling factor, according to:
+	 *
+	 * scaling = min(1000 * (QUOT(corner_N) - QUOT(corner_N-1))
+	 *		/ (freq(corner_N) - freq(corner_N-1)), max_factor)
+	 *
+	 * QUOT(corner_N):	quotient read from fuse for fuse corner N
+	 * QUOT(corner_N-1):	quotient read from fuse for fuse corner (N - 1)
+	 * freq(corner_N):	max frequency in MHz supported by fuse corner N
+	 * freq(corner_N-1):	max frequency in MHz supported by fuse corner
+	 *			 (N - 1)
+	 *
+	 * Then walk through the corners mapped to each fuse corner
+	 * and calculate the quotient adjustment for each one using the
+	 * following formula:
+	 *
+	 * quot_adjust = (freq_max - freq_corner) * scaling / 1000
+	 *
+	 * freq_max: max frequency in MHz supported by the fuse corner
+	 * freq_corner: frequency in MHz corresponding to the corner
+	 * scaling: calculated from above equation
+	 *
+	 *
+	 *     +                           +
+	 *     |                         v |
+	 *   q |           f c           o |           f c
+	 *   u |         c               l |         c
+	 *   o |       f                 t |       f
+	 *   t |     c                   a |     c
+	 *     | c f                     g | c f
+	 *     |                         e |
+	 *     +---------------            +----------------
+	 *       0 1 2 3 4 5 6               0 1 2 3 4 5 6
+	 *          corner                      corner
+	 *
+	 *    c = corner
+	 *    f = fuse corner
+	 *
+	 */
+	for (apply_scaling = false, i = 0; corner <= end; corner++, i++) {
+		unsigned long freq_diff_mhz;
+
+		fnum = cdata[i].fuse_corner;
+		fdata = &tdesc->fuse_corner_data[fnum];
+		quot_offset = fuses[fnum].quotient_offset;
+		fuse = &thread->fuse_corners[fnum];
+		ring_osc_mask &= (u16)(~BIT(fuse->ring_osc_idx));
+		if (fnum)
+			prev_fuse = &thread->fuse_corners[fnum - 1];
+		else
+			prev_fuse = NULL;
+
+		corner->fuse_corner = fuse;
+		corner->freq = cdata[i].freq;
+		corner->uV = fuse->uV;
+
+		if (prev_fuse) {
+			scaling = cpr_calculate_scaling(quot_offset, drv->dev,
+							fdata, corner);
+			if (scaling < 0)
+				return scaling;
+
+			apply_scaling = true;
+		} else if (corner->freq == fuse->max_freq) {
+			/* This is a fuse corner; don't scale anything */
+			apply_scaling = false;
+		}
+
+		if (apply_scaling) {
+			freq_diff_mhz = fuse->max_freq - corner->freq;
+			do_div(freq_diff_mhz, 1000000); /* now in MHz */
+
+			corner->quot_adjust = scaling * freq_diff_mhz;
+			do_div(corner->quot_adjust, 1000);
+
+			corner->uV = cpr_interpolate(corner,
+						     drv->vreg_step, fdata);
+		}
+
+		/* Negative fuse quotients are nonsense. */
+		if (fuse->quot < corner->quot_adjust)
+			return -EINVAL;
+
+		min_quotient = min(min_quotient,
+				   (u32)(fuse->quot - corner->quot_adjust));
+		corner->max_uV = fuse->max_uV;
+		corner->min_uV = fuse->min_uV;
+		corner->uV = clamp(corner->uV, corner->min_uV, corner->max_uV);
+		corner->last_uV = corner->uV;
+
+		/* Reduce the ceiling voltage if needed */
+		if (desc->reduce_to_corner_uV && corner->uV < corner->max_uV)
+			corner->max_uV = corner->uV;
+		else if (desc->reduce_to_fuse_uV && fuse->uV < corner->max_uV)
+			corner->max_uV = max(corner->min_uV, fuse->uV);
+
+		corner->min_uV = max(corner->max_uV - fdata->range_uV,
+				     corner->min_uV);
+		/*
+		 * Adjust per-corner floor and ceiling voltages so that
+		 * they do not overlap the memory Array Power Mux (APM)
+		 * threshold voltage.
+		 * The apm_hysteresis is checked because it is available
+		 * only on CPR controllers that need to fullfill this
+		 * requirement.
+		 */
+		if (desc->apm_hysteresis > 0 &&
+		    desc->apm_threshold > corner->min_uV &&
+		    desc->apm_threshold < corner->max_uV) {
+			if (corner->uV >= desc->apm_threshold) {
+				corner->min_uV = max(corner->min_uV,
+						     desc->apm_threshold -
+						     desc->apm_hysteresis);
+				if (corner->min_uV > corner->uV)
+					corner->uV = corner->min_uV;
+			} else {
+				corner->max_uV = desc->apm_threshold;
+				corner->max_uV -= drv->vreg_step;
+			}
+		}
+
+		dev_dbg(drv->dev, "corner %d: [%d %d %d] scaling %d quot %d\n", i,
+			corner->min_uV, corner->uV, corner->max_uV, scaling,
+			fuse->quot - corner->quot_adjust);
+	}
+
+	/* Additional setup for CPRh only */
+	if (desc->cpr_type < CTRL_TYPE_CPRH)
+		return 0;
+
+	/* If the OPPs can't be adjusted, programming the CPRh is useless */
+	ret = cprh_corner_adjust_opps(thread);
+	if (ret) {
+		dev_err(drv->dev, "Cannot adjust CPU OPP voltages: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Unmask the ring oscillator(s) that we're going to use: it seems
+	 * to be mandatory to do this *before* sending the rest of the
+	 * CPRhardened specific configuration.
+	 */
+	dev_dbg(drv->dev,
+		"Unmasking ring oscillators with mask 0x%x\n", ring_osc_mask);
+	cpr_write(thread, CPR3_REG_RO_MASK(tdesc->hw_tid), ring_osc_mask);
+
+	total_corners = thread->num_corners;
+
+	/* If the APM extra corner exists, add it now. */
+	if (desc->apm_threshold && desc->apm_hysteresis &&
+	    drv->extra_corners) {
+		thread->corners[total_corners].uV = desc->apm_threshold;
+		thread->corners[total_corners].min_uV = desc->apm_threshold;
+		thread->corners[total_corners].max_uV = desc->apm_threshold;
+		thread->corners[total_corners].is_open_loop = true;
+
+		/*
+		 * Also add and disable an opp with zero frequency: other
+		 * drivers will need to know what is the APM threshold voltage.
+		 */
+		ret = dev_pm_opp_add(thread->attached_cpu_dev, 0,
+				     desc->apm_threshold);
+		if (ret)
+			return ret;
+
+		ret = dev_pm_opp_disable(thread->attached_cpu_dev, 0);
+		if (ret)
+			return ret;
+
+		dev_dbg(drv->dev, "corner %d (APM): [%d %d %d] Open-Loop\n",
+			total_corners, desc->apm_threshold,
+			desc->apm_threshold, desc->apm_threshold);
+
+		total_corners += drv->extra_corners;
+	}
+
+	for (i = 0; i < total_corners; i++) {
+		int volt_oloop_steps, volt_floor_steps, delta_quot_steps;
+		int ring_osc;
+		u32 val;
+
+		fnum = cdata[i].fuse_corner;
+		fuse = &thread->fuse_corners[fnum];
+
+		val = thread->corners[i].uV - desc->cpr_base_voltage;
+		volt_oloop_steps = DIV_ROUND_UP(val, drv->vreg_step);
+
+		val = thread->corners[i].min_uV - desc->cpr_base_voltage;
+		volt_floor_steps = DIV_ROUND_UP(val, drv->vreg_step);
+
+		val = fuse->quot - thread->corners[i].quot_adjust;
+		val -= min_quotient;
+		delta_quot_steps = DIV_ROUND_UP(val,
+						CPRH_DELTA_QUOT_STEP_FACTOR);
+
+		/*
+		 * If we are accessing corners that are not used as
+		 * an active DCVS set-point, then always select RO 0
+		 * and zero out the delta quotient
+		 */
+		if (i >= thread->num_corners) {
+			ring_osc = 0;
+			delta_quot_steps = 0;
+		} else {
+			ring_osc = fuse->ring_osc_idx;
+		}
+
+		if (volt_oloop_steps > CPRH_CORNER_INIT_VOLTAGE_MAX_VALUE  ||
+		    volt_floor_steps > CPRH_CORNER_FLOOR_VOLTAGE_MAX_VALUE ||
+		    delta_quot_steps > CPRH_CORNER_QUOT_DELTA_MAX_VALUE) {
+			dev_err(drv->dev,
+				"Invalid cfg: oloop=%d, floor=%d, delta=%d\n",
+				volt_oloop_steps, volt_floor_steps,
+				delta_quot_steps);
+			return -EINVAL;
+		}
+		/* Green light: Go, Go, Go! */
+		val = CPRH_REG_CORNER(drv, tdesc->hw_tid, i);
+
+		/* Set the minimal quotient for all corners */
+		cpr_write(thread, CPR3_REG_TARGET_QUOT(tdesc->hw_tid, i),
+			  min_quotient);
+
+		/* Set number of open-loop steps */
+		cpr_masked_write(thread, val,
+				 CPRH_CORNER_INIT_VOLTAGE_MASK,
+				 volt_oloop_steps <<
+				 CPRH_CORNER_INIT_VOLTAGE_SHIFT);
+
+		/* Set number of floor voltage steps */
+		cpr_masked_write(thread, val,
+				 CPRH_CORNER_FLOOR_VOLTAGE_MASK,
+				 volt_floor_steps <<
+				 CPRH_CORNER_FLOOR_VOLTAGE_SHIFT);
+
+		/* Set number of target quotient delta steps */
+		cpr_masked_write(thread, val,
+				 CPRH_CORNER_QUOT_DELTA_MASK,
+				 delta_quot_steps <<
+				 CPRH_CORNER_QUOT_DELTA_SHIFT);
+
+		/* Select ring oscillator for this corner */
+		cpr_masked_write(thread, val,
+				 CPRH_CORNER_RO_SEL_MASK,
+				 ring_osc << CPRH_CORNER_RO_SEL_SHIFT);
+
+		dev_dbg(drv->dev,
+			"steps [%d]: open-loop %d, floor %d, delta_quot %d\n",
+			i, volt_oloop_steps, volt_floor_steps,
+			delta_quot_steps);
+
+		/* Open loop only corner is for APM crossover */
+		if (thread->corners[i].is_open_loop) {
+			dev_dbg(drv->dev,
+				"Disabling Closed-Loop on corner %d\n", i);
+			cpr_masked_write(thread, val,
+					 CPRH_CORNER_CPR_CL_DISABLE,
+					 CPRH_CORNER_CPR_CL_DISABLE);
+		}
+	}
+	/*
+	 * Make sure that all the writes go through before enabling
+	 * internal communication between the OSM and the CPRh
+	 * controllers, otherwise there is a high risk of hardware
+	 * lockups due to under-voltage for the selected CPU clock.
+	 *
+	 * Please note that the CPR-hardened gets set-up in Linux but
+	 * then gets actually used in firmware (and only by the OSM);
+	 * after handing it off we will have no more control on it,
+	 * hence the only way to get things up properly for sure here
+	 * is a write barrier.
+	 */
+	wmb();
+
+	/* Enable the interface between OSM and CPRh */
+	cpr_masked_write(thread, drv->reg_ctl,
+			 CPRH_CTL_OSM_ENABLED,
+			 CPRH_CTL_OSM_ENABLED);
+
+	/* On success, free cdata manually */
+	devm_kfree(drv->dev, cdata);
+	return 0;
+}
+
+/**
+ * cpr3_init_parameters - Initialize CPR global parameters
+ * @drv: Main driver structure
+ *
+ * Initial "integrity" checks and setup for the thread-independent parameters.
+ *
+ * Returns: Zero for success, negative number on error
+ */
+static int cpr3_init_parameters(struct cpr_drv *drv)
+{
+	const struct cpr_desc *desc = drv->desc;
+	struct clk *clk;
+
+	clk = devm_clk_get(drv->dev, "ref");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	drv->ref_clk_khz = clk_get_rate(clk);
+	do_div(drv->ref_clk_khz, 1000);
+
+	/* On CPRh this clock is not always-on... */
+	if (desc->cpr_type == CTRL_TYPE_CPRH)
+		clk_prepare_enable(clk);
+	else
+		devm_clk_put(drv->dev, clk);
+
+	if (desc->timer_cons_up > CPR3_THRESH_CONS_UP_MASK ||
+	    desc->timer_cons_down > CPR3_THRESH_CONS_DOWN_MASK ||
+	    desc->up_threshold > CPR3_THRESH_UP_THRESH_MASK ||
+	    desc->down_threshold > CPR3_THRESH_DOWN_THRESH_MASK ||
+	    desc->idle_clocks > CPR3_CPR_CTL_IDLE_CLOCKS_MASK ||
+	    desc->count_mode > CPR3_CPR_CTL_COUNT_MODE_MASK ||
+	    desc->count_repeat > CPR3_CPR_CTL_COUNT_REPEAT_MASK ||
+	    desc->step_quot_init_min > CPR3_CPR_STEP_QUOT_MIN_MASK ||
+	    desc->step_quot_init_max > CPR3_CPR_STEP_QUOT_MAX_MASK)
+		return -EINVAL;
+
+	/*
+	 * Read the CPR version register only from CPR3 onwards:
+	 * this is needed to get the additional register offsets.
+	 *
+	 * Note: When threaded, even if multi-controller, there
+	 *       is no chance to have different versions at the
+	 *       same time in the same domain, so it is safe to
+	 *       check this only on the first controller/thread.
+	 */
+	drv->cpr_hw_rev = cpr_read(&drv->threads[0],
+				   CPR3_REG_CPR_VERSION);
+	dev_dbg(drv->dev,
+		"CPR hardware revision: 0x%x\n", drv->cpr_hw_rev);
+
+	if (drv->cpr_hw_rev >= CPRH_CPR_VERSION_4P5) {
+		drv->reg_corner = 0x3500;
+		drv->reg_corner_tid = 0xa0;
+		drv->reg_ctl = 0x3a80;
+		drv->reg_status = 0x3a84;
+	} else {
+		drv->reg_corner = 0x3a00;
+		drv->reg_corner_tid = 0;
+		drv->reg_ctl = 0x3aa0;
+		drv->reg_status = 0x3aa4;
+	}
+
+	dev_dbg(drv->dev, "up threshold = %u, down threshold = %u\n",
+		desc->up_threshold, desc->down_threshold);
+
+	return 0;
+}
+
+/**
+ * cpr3_find_initial_corner - Finds boot-up p-state and enables CPR
+ * @thread: Structure holding CPR thread-specific parameters
+ *
+ * Differently from CPRv1, from CPRv3 onwards when we successfully find
+ * the target boot-up performance state, we must refresh the HW
+ * immediately to guarantee system stability and to avoid overheating
+ * during the boot process, thing that would more likely happen without
+ * this driver doing its job.
+ *
+ * Returns: Zero for success, negative number on error
+ */
+static int cpr3_find_initial_corner(struct cpr_thread *thread)
+{
+	struct cpr_drv *drv = thread->drv;
+	struct corner *corner;
+	int uV, idx;
+
+	idx = cpr_find_initial_corner(drv->dev, thread->cpu_clk,
+				      thread->corners,
+				      thread->num_corners);
+	if (idx < 0)
+		return idx;
+
+	cpr_ctl_disable(thread);
+
+	corner = &thread->corners[idx];
+	cpr_corner_restore(thread, corner);
+
+	uV = regulator_get_voltage(drv->vreg);
+	uV = clamp(uV, corner->min_uV, corner->max_uV);
+
+	corner->last_uV = uV;
+	if (!drv->last_uV)
+		drv->last_uV = uV;
+
+	cpr_commit_state(thread);
+	thread->enabled = true;
+	cpr_switch(drv);
+
+	return 0;
+}
+
+static const int sdm630_gold_scaling_factor[] = {
+	4040, 3230,    0, 2210,
+	2560, 2450, 2230, 2220,
+	2410, 2300, 2560, 2470,
+	1600, 3120, 2620, 2280,
+};
+
+static const int sdm630_silver_scaling_factor[] = {
+	3600, 3600, 3830, 2430,
+	2520, 2700, 1790, 1760,
+	1970, 1880, 2110, 2010,
+	2510, 4900, 4370, 4780,
+};
+
+static const struct cpr_thread_desc sdm630_thread_gold = {
+	.controller_id = 0,
+	.hw_tid = 0,
+	.ro_scaling_factor = sdm630_gold_scaling_factor,
+	.sensor_range_start = 0,
+	.sensor_range_end = 6,
+	.init_voltage_step = 10000,
+	.init_voltage_width = 6,
+	.num_fuse_corners = 5,
+	.fuse_corner_data = (struct fuse_corner_data[]){
+		/* fuse corner 0 */
+		{
+			.ref_uV = 644000,
+			.max_uV = 724000,
+			.min_uV = 588000,
+			.range_uV = 40000,
+			.volt_cloop_adjust = -30000,
+			.volt_oloop_adjust = 15000,
+			.max_volt_scale = 10,
+			.max_quot_scale = 300,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+		/* fuse corner 1 */
+		{
+			.ref_uV = 788000,
+			.max_uV = 788000,
+			.min_uV = 652000,
+			.range_uV = 40000,
+			.volt_cloop_adjust = -30000,
+			.volt_oloop_adjust = 5000,
+			.max_volt_scale = 320,
+			.max_quot_scale = 275,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+		/* fuse corner 2 */
+		{
+			.ref_uV = 868000,
+			.max_uV = 868000,
+			.min_uV = 712000,
+			.range_uV = 40000,
+			.volt_cloop_adjust = -30000,
+			.volt_oloop_adjust = 5000,
+			.max_volt_scale = 350,
+			.max_quot_scale = 800,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+		/* fuse corner 3 */
+		{
+			.ref_uV = 988000,
+			.max_uV = 988000,
+			.min_uV = 784000,
+			.range_uV = 66000,
+			.volt_cloop_adjust = -30000,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 868,
+			.max_quot_scale = 980,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+		/* fuse corner 4 */
+		{
+			.ref_uV = 1068000,
+			.max_uV = 1068000,
+			.min_uV = 844000,
+			.range_uV = 40000,
+			.volt_cloop_adjust = -30000,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 868,
+			.max_quot_scale = 980,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+	},
+};
+
+static const struct cpr_thread_desc sdm630_thread_silver = {
+	.controller_id = 1,
+	.hw_tid = 0,
+	.ro_scaling_factor = sdm630_silver_scaling_factor,
+	.sensor_range_start = 0,
+	.sensor_range_end = 6,
+	.init_voltage_step = 10000,
+	.init_voltage_width = 6,
+	.num_fuse_corners = 3,
+	.fuse_corner_data = (struct fuse_corner_data[]){
+		/* fuse corner 0 */
+		{
+			.ref_uV = 644000,
+			.max_uV = 724000,
+			.min_uV = 588000,
+			.range_uV = 32000,
+			.volt_cloop_adjust = -30000,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 10,
+			.max_quot_scale = 360,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+		/* fuse corner 1 */
+		{
+			.ref_uV = 788000,
+			.max_uV = 788000,
+			.min_uV = 652000,
+			.range_uV = 40000,
+			.volt_cloop_adjust = -30000,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 500,
+			.max_quot_scale = 550,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+		/* fuse corner 2 */
+		{
+			.ref_uV = 1068000,
+			.max_uV = 1068000,
+			.min_uV = 800000,
+			.range_uV = 40000,
+			.volt_cloop_adjust = -30000,
+			.volt_oloop_adjust = 0,
+			.max_volt_scale = 2370,
+			.max_quot_scale = 550,
+			.quot_offset = 0,
+			.quot_scale = 1,
+			.quot_adjust = 0,
+			.quot_offset_scale = 5,
+			.quot_offset_adjust = 0,
+		},
+	},
+};
+
+static const struct cpr_desc sdm630_cpr_desc = {
+	.cpr_type = CTRL_TYPE_CPRH,
+	.num_threads = 2,
+	.apm_threshold = 872000,
+	.apm_hysteresis = 20000,
+	.cpr_base_voltage = 400000,
+	.cpr_max_voltage = 1300000,
+	.step_quot_init_min = 12,
+	.step_quot_init_max = 14,
+	.timer_delay_us = 5000,
+	.timer_cons_up = 0,
+	.timer_cons_down = 2,
+	.up_threshold = 2,
+	.down_threshold = 2,
+	.idle_clocks = 15,
+	.count_mode = CPR3_CPR_CTL_COUNT_MODE_ALL_AT_ONCE_MIN,
+	.count_repeat = 14,
+	.gcnt_us = 1,
+	.vreg_step_fixed = 4000,
+	.vreg_step_up_limit = 1,
+	.vreg_step_down_limit = 1,
+	.vdd_settle_time_us = 34,
+	.corner_settle_time_us = 5,
+	.reduce_to_corner_uV = true,
+	.hw_closed_loop_en = true,
+	.threads = (const struct cpr_thread_desc *[]) {
+		&sdm630_thread_gold,
+		&sdm630_thread_silver,
+	},
+};
+
+static const struct cpr_acc_desc sdm630_cpr_acc_desc = {
+	.cpr_desc = &sdm630_cpr_desc,
+};
+
+static unsigned int cpr_get_performance_state(struct generic_pm_domain *genpd,
+					      struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_get_level(opp);
+}
+
+static int cpr_power_off(struct generic_pm_domain *domain)
+{
+	struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
+
+	return cpr_disable(thread);
+}
+
+static int cpr_power_on(struct generic_pm_domain *domain)
+{
+	struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
+
+	return cpr_enable(thread);
+}
+
+static void cpr_pd_detach_dev(struct generic_pm_domain *domain,
+			      struct device *dev)
+{
+	struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
+	struct cpr_drv *drv = thread->drv;
+
+	mutex_lock(&drv->lock);
+
+	dev_dbg(drv->dev, "detach callback for: %s\n", dev_name(dev));
+	thread->attached_cpu_dev = NULL;
+
+	mutex_unlock(&drv->lock);
+}
+
+static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
+			     struct device *dev)
+{
+	struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
+	struct cpr_drv *drv = thread->drv;
+	const struct acc_desc *acc_desc = drv->acc_desc;
+	int ret = 0;
+
+	mutex_lock(&drv->lock);
+
+	dev_dbg(drv->dev, "attach callback for: %s\n", dev_name(dev));
+
+	/*
+	 * This driver only supports scaling voltage for a CPU cluster
+	 * where all CPUs in the cluster share a single regulator.
+	 * Therefore, save the struct device pointer only for the first
+	 * CPU device that gets attached. There is no need to do any
+	 * additional initialization when further CPUs get attached.
+	 */
+	if (thread->attached_cpu_dev)
+		goto unlock;
+
+	/*
+	 * cpr_scale_voltage() requires the direction (if we are changing
+	 * to a higher or lower OPP). The first time
+	 * cpr_set_performance_state() is called, there is no previous
+	 * performance state defined. Therefore, we call
+	 * cpr_find_initial_corner() that gets the CPU clock frequency
+	 * set by the bootloader, so that we can determine the direction
+	 * the first time cpr_set_performance_state() is called.
+	 */
+	thread->cpu_clk = devm_clk_get(dev, NULL);
+	if (drv->desc->cpr_type < CTRL_TYPE_CPRH &&
+	    IS_ERR(thread->cpu_clk)) {
+		ret = PTR_ERR(thread->cpu_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(drv->dev, "could not get cpu clk: %d\n", ret);
+		goto unlock;
+	}
+	thread->attached_cpu_dev = dev;
+
+	dev_dbg(drv->dev, "using cpu clk from: %s\n",
+		dev_name(thread->attached_cpu_dev));
+
+	/*
+	 * Everything related to (virtual) corners has to be initialized
+	 * here, when attaching to the power domain, since we need to know
+	 * the maximum frequency for each fuse corner, and this is only
+	 * available after the cpufreq driver has attached to us.
+	 * The reason for this is that we need to know the highest
+	 * frequency associated with each fuse corner.
+	 */
+	ret = dev_pm_opp_get_opp_count(&thread->pd.dev);
+	if (ret < 0) {
+		dev_err(drv->dev, "could not get OPP count\n");
+		thread->attached_cpu_dev = NULL;
+		goto unlock;
+	}
+	thread->num_corners = ret;
+
+	thread->corners = devm_kcalloc(drv->dev,
+				       thread->num_corners +
+				       drv->extra_corners,
+				       sizeof(*thread->corners),
+				       GFP_KERNEL);
+	if (!thread->corners) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	ret = cpr3_corner_init(thread);
+	if (ret)
+		goto unlock;
+
+	if (drv->desc->cpr_type < CTRL_TYPE_CPRH) {
+		ret = cpr3_find_initial_corner(thread);
+		if (ret)
+			goto unlock;
+
+		if (acc_desc->config)
+			regmap_multi_reg_write(drv->tcsr, acc_desc->config,
+					       acc_desc->num_regs_per_fuse);
+
+		/* Enable ACC if required */
+		if (acc_desc->enable_mask)
+			regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
+					   acc_desc->enable_mask,
+					   acc_desc->enable_mask);
+	}
+	dev_info(drv->dev, "thread %d initialized with %u OPPs\n",
+		 thread->id, thread->num_corners);
+
+unlock:
+	mutex_unlock(&drv->lock);
+
+	return ret;
+}
+
+static int cpr3_debug_info_show(struct seq_file *s, void *unused)
+{
+	u32 ro_sel, ctl, irq_status, reg, quot;
+	struct cpr_thread *thread = s->private;
+	struct corner *corner = thread->corners;
+	struct fuse_corner *fuse = thread->fuse_corners;
+	unsigned int i;
+
+	const struct {
+		const char *name;
+		uint32_t mask;
+		uint8_t shift;
+	} result0_fields[] = {
+		{ "busy", 1, 0 },
+		{ "step_dn", 1, 1 },
+		{ "step_up", 1, 2 },
+		{ "error_steps", CPR3_RESULT0_ERROR_STEPS_MASK,
+				 CPR3_RESULT0_ERROR_STEPS_SHIFT },
+		{ "error", CPR3_RESULT0_ERROR_MASK, CPR3_RESULT0_ERROR_SHIFT },
+		{ "negative", 1, 20 },
+	}, result1_fields[] = {
+		{ "quot_min", CPR3_RESULT1_QUOT_MIN_MASK,
+			      CPR3_RESULT1_QUOT_MIN_SHIFT },
+		{ "quot_max", CPR3_RESULT1_QUOT_MAX_MASK,
+			      CPR3_RESULT1_QUOT_MAX_SHIFT },
+		{ "ro_min", CPR3_RESULT1_RO_MIN_MASK,
+			    CPR3_RESULT1_RO_MIN_SHIFT },
+		{ "ro_max", CPR3_RESULT1_RO_MAX_MASK,
+			    CPR3_RESULT1_RO_MAX_SHIFT },
+	}, result2_fields[] = {
+		{ "qout_step_min", CPR3_RESULT2_STEP_QUOT_MIN_MASK,
+				   CPR3_RESULT2_STEP_QUOT_MIN_SHIFT },
+		{ "qout_step_max", CPR3_RESULT2_STEP_QUOT_MAX_MASK,
+				   CPR3_RESULT2_STEP_QUOT_MAX_SHIFT },
+		{ "sensor_min", CPR3_RESULT2_SENSOR_MIN_MASK,
+				CPR3_RESULT2_SENSOR_MIN_SHIFT },
+		{ "sensor_max", CPR3_RESULT2_SENSOR_MAX_MASK,
+				CPR3_RESULT2_SENSOR_MAX_SHIFT },
+	};
+
+	if (thread->drv->desc->cpr_type < CTRL_TYPE_CPRH)
+		seq_printf(s, "current_volt = %d uV\n", thread->drv->last_uV);
+
+	irq_status = cpr_read(thread, CPR3_REG_IRQ_STATUS);
+	seq_printf(s, "irq_status = %#02X\n", irq_status);
+
+	ctl = cpr_read(thread, CPR3_REG_CPR_CTL);
+	seq_printf(s, "cpr_ctl = %#02X\n", ctl);
+
+	seq_printf(s, "thread %d - hw tid: %d - enabled: %d:\n",
+		   thread->id, thread->desc->hw_tid, thread->enabled);
+	seq_printf(s, "%d corners, derived from %d fuse corners\n",
+		   thread->num_corners, thread->desc->num_fuse_corners);
+
+	for (i = 0; i < thread->num_corners; i++, corner++)
+		seq_printf(s, "corner %d - uV=[%d %d %d] quot=%d freq=%lu\n",
+			   i, corner->min_uV, corner->uV, corner->max_uV,
+			   corner->quot_adjust, corner->freq);
+
+	for (i = 0; i < thread->desc->num_fuse_corners; i++, fuse++)
+		seq_printf(s, "fuse %d - uV=[%d %d %d] quot=%d freq=%lu\n",
+			   i, fuse->min_uV, fuse->uV, fuse->max_uV,
+			   fuse->quot, corner->freq);
+
+	seq_printf(s, "requested voltage: %d uV\n",
+		   thread->corner->last_uV);
+
+	ro_sel = corner->fuse_corner->ring_osc_idx;
+	quot = cpr_read(thread, CPR3_REG_TARGET_QUOT(i, ro_sel));
+	seq_printf(s, "quot_target (%u) = %#02X\n", ro_sel, quot);
+
+	reg = cpr_read(thread, CPR3_REG_RESULT0(i));
+	seq_printf(s, "cpr_result_0 = %#02X\n  [", reg);
+	for (i = 0; i < ARRAY_SIZE(result0_fields); i++)
+		seq_printf(s, "%s%s = %u",
+			   i ? ", " : "",
+			   result0_fields[i].name,
+			   (reg >> result0_fields[i].shift) &
+				result0_fields[i].mask);
+	seq_puts(s, "]\n");
+	reg = cpr_read(thread, CPR3_REG_RESULT1(i));
+	seq_printf(s, "cpr_result_1 = %#02X\n  [", reg);
+	for (i = 0; i < ARRAY_SIZE(result1_fields); i++)
+		seq_printf(s, "%s%s = %u",
+			   i ? ", " : "",
+			   result1_fields[i].name,
+			   (reg >> result1_fields[i].shift) &
+				result1_fields[i].mask);
+	seq_puts(s, "]\n");
+	reg = cpr_read(thread, CPR3_REG_RESULT2(i));
+	seq_printf(s, "cpr_result_2 = %#02X\n  [", reg);
+	for (i = 0; i < ARRAY_SIZE(result2_fields); i++)
+		seq_printf(s, "%s%s = %u",
+			   i ? ", " : "",
+			   result2_fields[i].name,
+			   (reg >> result2_fields[i].shift) &
+				result2_fields[i].mask);
+	seq_puts(s, "]\n");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(cpr3_debug_info);
+
+static void cpr3_debugfs_init(struct cpr_drv *drv)
+{
+	int i;
+
+	drv->debugfs = debugfs_create_dir("qcom_cpr3", NULL);
+
+	for (i = 0; i < drv->num_threads; i++) {
+		char buf[50];
+
+		snprintf(buf, sizeof(buf), "thread%d", i);
+
+		debugfs_create_file(buf, 0444, drv->debugfs, &drv->threads[i],
+				    &cpr3_debug_info_fops);
+	}
+}
+
+/**
+ * cpr_thread_init - Initialize CPR thread related parameters
+ * @drv: Main driver structure
+ * @tid: Thread ID
+ *
+ * Returns: Zero for success, negative number on error
+ */
+static int cpr_thread_init(struct cpr_drv *drv, int tid)
+{
+	const struct cpr_desc *desc = drv->desc;
+	const struct cpr_thread_desc *tdesc = desc->threads[tid];
+	struct cpr_thread *thread = &drv->threads[tid];
+	int ret;
+
+	thread->id = tid;
+	thread->drv = drv;
+	thread->desc = tdesc;
+	thread->fuse_corners = devm_kcalloc(drv->dev,
+					    tdesc->num_fuse_corners +
+					    drv->extra_corners,
+					    sizeof(*thread->fuse_corners),
+					    GFP_KERNEL);
+	if (!thread->fuse_corners)
+		return -ENOMEM;
+
+	thread->cpr_fuses = cpr_get_fuses(drv->dev, tid,
+					  tdesc->num_fuse_corners);
+	if (IS_ERR(thread->cpr_fuses))
+		return PTR_ERR(thread->cpr_fuses);
+
+	ret = cpr_populate_ring_osc_idx(thread->drv->dev, thread->fuse_corners,
+					thread->cpr_fuses,
+					tdesc->num_fuse_corners);
+	if (ret)
+		return ret;
+
+	ret = cpr_fuse_corner_init(thread);
+	if (ret)
+		return ret;
+
+	thread->pd.name = devm_kasprintf(drv->dev, GFP_KERNEL,
+					 "%s_thread%d",
+					 drv->dev->of_node->full_name,
+					 thread->id);
+	if (!thread->pd.name)
+		return -EINVAL;
+
+	thread->pd.power_off = cpr_power_off;
+	thread->pd.power_on = cpr_power_on;
+	thread->pd.set_performance_state = cpr_set_performance_state;
+	thread->pd.opp_to_performance_state = cpr_get_performance_state;
+	thread->pd.attach_dev = cpr_pd_attach_dev;
+	thread->pd.detach_dev = cpr_pd_detach_dev;
+
+	/* Anything later than CPR1 must be always-on for now */
+	thread->pd.flags = GENPD_FLAG_ALWAYS_ON;
+
+	drv->cell_data.domains[tid] = &thread->pd;
+
+	ret = pm_genpd_init(&thread->pd, NULL, false);
+	if (ret)
+		return ret;
+
+	/* On CPRhardened, the interrupts are managed in firmware */
+	if (desc->cpr_type < CTRL_TYPE_CPRH) {
+		INIT_WORK(&thread->restart_work, cpr_restart_worker);
+
+		ret = devm_request_threaded_irq(drv->dev, drv->irq,
+						NULL, cpr_irq_handler,
+						IRQF_ONESHOT |
+						IRQF_TRIGGER_RISING,
+						"cpr", drv);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * cpr3_resources_init - Initialize resources used by this driver
+ * @pdev: Platform device
+ * @drv:  Main driver structure
+ *
+ * Returns: Zero for success, negative number on error
+ */
+static int cpr3_resources_init(struct platform_device *pdev,
+			       struct cpr_drv *drv)
+{
+	const struct cpr_desc *desc = drv->desc;
+	struct cpr_thread *threads = drv->threads;
+	unsigned int i;
+	u8 cid_mask = 0;
+
+	/*
+	 * Here, we are accounting for the following usecases:
+	 * - One controller
+	 *   - One or multiple threads on the same iospace
+	 *
+	 * - Multiple controllers
+	 *   - Each controller has its own iospace and each
+	 *     may have one or multiple threads in their
+	 *     parent controller's iospace
+	 *
+	 * Then, to avoid complicating the code for no reason,
+	 * this also needs a mandatory order in the list of
+	 * threads which implies that all of them from the same
+	 * controllers are specified sequentially. As an example:
+	 *
+	 *      C0-T0, C0-T1...C0-Tn, C1-T0, C1-T1...C1-Tn
+	 */
+	for (i = 0; i < desc->num_threads; i++) {
+		u8 cid = desc->threads[i]->controller_id;
+
+		if (cid_mask & BIT(cid)) {
+			if (desc->threads[i - 1]->controller_id != cid) {
+				dev_err(drv->dev,
+					"Bad threads order. Please fix!\n");
+				return -EINVAL;
+			}
+			threads[i].base = threads[i - 1].base;
+			continue;
+		}
+
+		dev_dbg(drv->dev, "Mapping resource for CID %d\n", cid);
+		threads[i].base = devm_platform_ioremap_resource(pdev, cid);
+		if (IS_ERR(threads[i].base))
+			return PTR_ERR(threads[i].base);
+		cid_mask |= BIT(cid);
+	}
+
+	return 0;
+}
+
+static int cpr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cpr_drv *drv;
+	const struct cpr_desc *desc;
+	const struct cpr_acc_desc *data;
+	struct device_node *np;
+	unsigned int i;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data || !data->cpr_desc)
+		return -EINVAL;
+
+	desc = data->cpr_desc;
+
+	/* CPRh disallows MEM-ACC access from the HLOS */
+	if (!data->acc_desc && desc->cpr_type < CTRL_TYPE_CPRH)
+		return -EINVAL;
+
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->dev = dev;
+	drv->desc = desc;
+	drv->num_threads = desc->num_threads;
+	drv->threads = devm_kcalloc(dev, drv->num_threads,
+				    sizeof(*drv->threads), GFP_KERNEL);
+	if (!drv->threads)
+		return -ENOMEM;
+
+	drv->cell_data.num_domains = desc->num_threads,
+	drv->cell_data.domains = devm_kcalloc(drv->dev,
+					      drv->cell_data.num_domains,
+					      sizeof(*drv->cell_data.domains),
+					      GFP_KERNEL);
+	if (!drv->cell_data.domains)
+		return -ENOMEM;
+
+	if (data->acc_desc)
+		drv->acc_desc = data->acc_desc;
+
+	mutex_init(&drv->lock);
+
+	if (desc->cpr_type < CTRL_TYPE_CPRH) {
+		np = of_parse_phandle(dev->of_node, "acc-syscon", 0);
+		if (!np)
+			return -ENODEV;
+
+		drv->tcsr = syscon_node_to_regmap(np);
+		of_node_put(np);
+		if (IS_ERR(drv->tcsr))
+			return PTR_ERR(drv->tcsr);
+	}
+
+	ret = cpr3_resources_init(pdev, drv);
+	if (ret)
+		return ret;
+
+	drv->irq = platform_get_irq_optional(pdev, 0);
+	if ((desc->cpr_type != CTRL_TYPE_CPRH) && (drv->irq < 0))
+		return -EINVAL;
+
+	/* On CPRhardened, vreg access it not allowed */
+	drv->vreg = devm_regulator_get_optional(dev, "vdd");
+	if (desc->cpr_type != CTRL_TYPE_CPRH && IS_ERR(drv->vreg))
+		return PTR_ERR(drv->vreg);
+
+	/*
+	 * On at least CPRhardened, vreg is unaccessible and there is no
+	 * way to read linear step from that regulator, hence it is hardcoded
+	 * in the driver;
+	 * When the vreg_step is not declared in the cpr data (or is zero),
+	 * then having access to the vreg regulator is mandatory, as this
+	 * will be retrieved through the regulator API.
+	 */
+	if (desc->vreg_step_fixed)
+		drv->vreg_step = desc->vreg_step_fixed;
+	else
+		drv->vreg_step = regulator_get_linear_step(drv->vreg);
+
+	if (!drv->vreg_step)
+		return -EINVAL;
+
+	/*
+	 * Initialize fuse corners, since it simply depends
+	 * on data in efuses.
+	 * Everything related to (virtual) corners has to be
+	 * initialized after attaching to the power domain,
+	 * since it depends on the CPU's OPP table.
+	 */
+	ret = cpr_read_efuse(dev, "cpr_fuse_revision", &drv->fusing_rev);
+	if (ret)
+		return ret;
+
+	ret = cpr_read_efuse(dev, "cpr_speed_bin", &drv->speed_bin);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the APM threshold and hysteresis params are specified,
+	 * reserve a corner for APM crossover, used by OSM and CPRh
+	 * HW to set the supply voltage during the APM switch routine
+	 */
+	if (desc->cpr_type == CTRL_TYPE_CPRH &&
+	    desc->apm_threshold && desc->apm_hysteresis)
+		drv->extra_corners++;
+
+	/* Initialize all threads */
+	for (i = 0; i < desc->num_threads; i++) {
+		ret = cpr_thread_init(drv, i);
+		if (ret)
+			return ret;
+	}
+
+	/* Initialize global parameters */
+	ret = cpr3_init_parameters(drv);
+	if (ret)
+		return ret;
+
+	/* Write initial configuration on all threads */
+	for (i = 0; i < desc->num_threads; i++) {
+		ret = cpr_configure(&drv->threads[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, &drv->cell_data);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, drv);
+	cpr3_debugfs_init(drv);
+
+	return 0;
+}
+
+static int cpr_remove(struct platform_device *pdev)
+{
+	struct cpr_drv *drv = platform_get_drvdata(pdev);
+	int i;
+
+	of_genpd_del_provider(pdev->dev.of_node);
+
+	for (i = 0; i < drv->num_threads; i++) {
+		cpr_ctl_disable(&drv->threads[i]);
+		cpr_irq_set(&drv->threads[i], 0);
+		pm_genpd_remove(&drv->threads[i].pd);
+	}
+
+	debugfs_remove_recursive(drv->debugfs);
+
+	return 0;
+}
+
+static const struct of_device_id cpr3_match_table[] = {
+	{ .compatible = "qcom,sdm630-cprh", .data = &sdm630_cpr_acc_desc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cpr3_match_table);
+
+static struct platform_driver cpr3_driver = {
+	.probe		= cpr_probe,
+	.remove		= cpr_remove,
+	.driver		= {
+		.name	= "qcom-cpr3",
+		.of_match_table = cpr3_match_table,
+	},
+};
+module_platform_driver(cpr3_driver)
+
+MODULE_DESCRIPTION("Core Power Reduction (CPR) v3/v4 driver");
+MODULE_LICENSE("GPL v2");
-- 
2.29.2

