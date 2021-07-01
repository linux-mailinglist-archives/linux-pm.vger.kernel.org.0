Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846CD3B90D4
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhGALAS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 07:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbhGALAO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 07:00:14 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C67C0613A2;
        Thu,  1 Jul 2021 03:57:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id BA6473F64D;
        Thu,  1 Jul 2021 12:57:38 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v6 6/9] cpufreq: qcom-hw: Implement CPRh aware OSM programming
Date:   Thu,  1 Jul 2021 12:57:27 +0200
Message-Id: <20210701105730.322718-7-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On new SoCs (SDM845 onwards) the Operating State Manager (OSM) is
being programmed in the bootloader and write-protected by the
hypervisor, leaving to the OS read-only access to some of its
registers (in order to read the Lookup Tables and also some
status registers) and write access to the p-state register, for
for the OS to request a specific performance state to trigger a
DVFS switch on the CPU through the OSM hardware.

On old SoCs though (MSM8998, SDM630/660 and variants), the
bootloader will *not* initialize the OSM (and the CPRh, as it
is a requirement for it) before booting the OS, making any
request to trigger a performance state change ineffective, as
the hardware doesn't have any Lookup Table, nor is storing any
parameter to trigger a DVFS switch. In this case, basically all
of the OSM registers are *not* write protected for the OS, even
though some are - but write access is granted through SCM calls.

This commit introduces support for OSM programming, which has to
be done on these old SoCs that were distributed (almost?) always
with a bootloader that does not do any CPRh nor OSM init before
booting the kernel.
In order to program the OSM on these SoCs, it is necessary to
fullfill a "special" requirement: the Core Power Reduction
Hardened (CPRh) hardware block must be initialized, as the OSM
is "talking" to it in order to perform the Voltage part of DVFS;
here, we are calling initialization of this through Linux generic
power domains, specifically by requesting a genpd attach from the
qcom-cpufreq-hw driver, which will give back voltages associated
to each CPU frequency that has been declared in the OPPs, scaled
and interpolated with the previous one, and will also give us
parameters for the Array Power Mux (APM) and mem-acc, in order
for this driver to be then able to generate the Lookup Tables
that will be finally programmed to the OSM hardware.

After writing the parameters to the OSM and enabling it, all the
programming work will never happen anymore until a OS reboot, so
all of the allocations and "the rest" will be disposed-of: this
is done mainly to leave the code that was referred only to the
new SoCs intact, as to also emphasize on the fact that the OSM
HW is, in the end, the exact same; apart some register offsets
that are slightly different, the entire logic is the same.

This also adds the parameters to support CPU scaling on SDM630
and MSM8998.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 1078 ++++++++++++++++++++++++++++-
 1 file changed, 1057 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index af1b59310249..54b79fe772b6 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -1,33 +1,256 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * OSM hardware initial programming
+ * Copyright (C) 2020, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
  */
 
 #include <linux/bitfield.h>
 #include <linux/cpufreq.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/qcom_scm.h>
+#include <soc/qcom/cpr.h>
 
 #define LUT_MAX_ENTRIES			40U
-#define LUT_SRC				GENMASK(31, 30)
+#define LUT_SRC_845			GENMASK(31, 30)
+#define LUT_SRC_8998			GENMASK(27, 26)
+#define LUT_PLL_DIV			GENMASK(25, 24)
 #define LUT_L_VAL			GENMASK(7, 0)
 #define LUT_CORE_COUNT			GENMASK(18, 16)
+#define LUT_VOLT_VC			GENMASK(21, 16)
 #define LUT_VOLT			GENMASK(11, 0)
-#define CLK_HW_DIV			2
 #define LUT_TURBO_IND			1
+#define OSM_BOOT_TIME_US		5
+
+#define CYCLE_COUNTER_CLK_RATIO		GENMASK(5, 1)
+#define OSM_XO_RATIO_VAL		(10 - 1)
+#define CYCLE_COUNTER_USE_XO_EDGE	BIT(8)
+
+/* FSM Boost Control */
+#define CC_BOOST_EN			BIT(0)
+#define PS_BOOST_EN			BIT(1)
+#define DCVS_BOOST_EN			BIT(2)
+#define BOOST_TIMER_REG_HI		GENMASK(31, 16)
+#define BOOST_TIMER_REG_LO		GENMASK(15, 0)
+
+#define PLL_WAIT_LOCK_TIME_NS		2000
+#define SAFE_FREQ_WAIT_NS		1000
+#define DEXT_DECREMENT_WAIT_NS		200
+
+#define BOOST_SYNC_DELAY		5
+
+#define HYSTERESIS_UP_MASK		GENMASK(31, 16)
+#define HYSTERESIS_DN_MASK		GENMASK(15, 0)
+#define HYSTERESIS_CC_NS		200
+#define HYSTERESIS_LLM_NS		65535
+
+/* FSM Droop Control */
+#define PC_RET_EXIT_DROOP_EN		BIT(3)
+#define WFX_DROOP_EN			BIT(4)
+#define DCVS_DROOP_EN			BIT(5)
+#define DROOP_TIMER1			GENMASK(31, 16)
+#define DROOP_TIMER0			GENMASK(15, 0)
+#define DROOP_CTRL_VAL			(BIT(3) | BIT(17) | BIT(31))
+#define DROOP_TIMER_NS			100
+#define DROOP_WAIT_RELEASE_TIMER_NS	50
+#define DROOP_RELEASE_TIMER_NS		1
+
+/* PLL Override Control */
+#define PLL_OVERRIDE_DROOP_EN		BIT(0)
+
+/* Sequencer */
+#define SEQUENCER_REG(base, n)		(base + (n * 4))
+#define SEQ_APM_THRESH_VC		15
+#define SEQ_APM_THRESH_PREVC		31
+#define SEQ_MEM_ACC_LVAL		32
+#define SEQ_MEM_ACC_0			55
+#define SEQ_APM_CROSSOVER_VC		72
+#define SEQ_APM_PARAM			76
+#define SEQ_MEM_ACC_CROSSOVER_VC	88
+#define SEQ_MEM_ACC_MAX_LEVELS		4
+#define SEQ_MEMACC_REG(base, n)		SEQUENCER_REG(base, SEQ_MEM_ACC_0 + n)
+
+/* ACD */
+#define ACD_WRITE_CTL_UPDATE_EN		BIT(0)
+#define ACD_WRITE_CTL_SELECT_SHIFT	1
+
+/**
+ * struct qcom_cpufreq_soc_setup_data - Register offsets for OSM setup
+ *
+ * @reg_osm_sequencer:      OSM Sequencer (used to get physical address)
+ * @reg_override:           Override parameters
+ * @reg_spare:              Spare parameters (MEMACC-to-VC)
+ * @reg_cc_zero_behav:      Virtual Corner for cluster power collapse
+ * @reg_spm_cc_hyst:        DCVS-CC Wait time for frequency inc/decrement
+ * @reg_spm_cc_dcvs_dis:    DCVS-CC en/disable control
+ * @reg_spm_core_ret_map:   Treat cores in retention as active/inactive
+ * @reg_llm_freq_vote_hyst: DCVS-LLM Wait time for frequency inc/decrement
+ * @reg_llm_volt_vote_hyst: DCVS-LLM Wait time for voltage inc/decrement
+ * @reg_llm_intf_dcvs_dis:  DCVS-LLM en/disable control
+ * @reg_seq1:               Sequencer extra register
+ * @reg_pdn_fsm_ctrl:       Boost and Droop FSMs en/disable control
+ * @reg_cc_boost_timer:     CC-Boost FSM wait first timer register
+ * @reg_dcvs_boost_timer:   DCVS-Boost FSM wait first timer register
+ * @reg_ps_boost_timer:     PS-Boost FSM wait first timer register
+ * @boost_timer_reg_len:    Length of boost timer registers
+ * @reg_boost_sync_delay:   PLL signal timing control for Boost
+ * @reg_droop_ctrl:         Droop control value
+ * @reg_droop_release_ctrl: Wait for Droop release
+ * @reg_droop_unstall_ctrl: Wait for Droop unstall
+ * @reg_droop_wait_release_ctrl: Time to wait for state release
+ * @reg_droop_timer_ctrl:   Droop timer
+ * @reg_droop_sync_delay:   PLL signal timing control for Droop
+ * @reg_pll_override:       PLL Droop Override en/disable control
+ * @reg_cycle_counter:      OSM CPU cycle counter
+ *
+ * This structure holds the register offsets that are used to set-up
+ * the Operating State Manager (OSM) parameters, when it is not (or
+ * not entirely) configured from the bootloader and TrustZone.
+ *
+ * Acronyms used in this documentation:
+ * CC = Core Count
+ * PS = Power-Save
+ * VC = Virtual Corner
+ * LLM = Limits Load Management
+ * DCVS = Dynamic Clock and Voltage Scaling
+ */
+struct qcom_cpufreq_soc_setup_data {
+	/* OSM phys register offsets */
+	u16 reg_osm_sequencer;
+
+	/* Frequency domain register offsets */
+	u16 reg_override;
+	u16 reg_spare;
+	u16 reg_cc_zero_behav;
+	u16 reg_spm_cc_hyst;
+	u16 reg_spm_cc_dcvs_dis;
+	u16 reg_spm_core_ret_map;
+	u16 reg_llm_freq_vote_hyst;
+	u16 reg_llm_volt_vote_hyst;
+	u16 reg_llm_intf_dcvs_dis;
+	u16 reg_seq1;
+	u16 reg_pdn_fsm_ctrl;
+	u16 reg_cc_boost_timer;
+	u16 reg_dcvs_boost_timer;
+	u16 reg_ps_boost_timer;
+	u16 boost_timer_reg_len;
+	u16 reg_boost_sync_delay;
+	u16 reg_droop_ctrl;
+	u16 reg_droop_release_ctrl;
+	u16 reg_droop_unstall_ctrl;
+	u16 reg_droop_wait_release_ctrl;
+	u16 reg_droop_timer_ctrl;
+	u16 reg_droop_sync_delay;
+	u16 reg_pll_override;
+	u16 reg_cycle_counter;
+};
+
+/**
+ * struct qcom_cpufreq_soc_acd_data - Adaptive Clock Distribution data
+ *
+ * @tl_delay_reg:      Tunable-Length Delay (TLD) register offset
+ * @acd_ctrl_reg:      Control Register (CR) register offset
+ * @softstart_reg:     Soft Start Control Register (SSCR) register offset
+ * @ext_intf_reg:      External interface configuration register offset
+ * @auto_xfer_reg:     Auto Register-Transfer register offset
+ * @auto_xfer_cfg_reg: Auto Register-Transfer Configuration reg offset
+ * @auto_xfer_ctl_reg: Auto Register-Transfer Control register offset
+ * @auto_xfer_sts_reg: Auto Register-Transfer Status register offset
+ * @dcvs_sw_reg:       Software DCVS register offset
+ * @gfmux_cfg_reg:     Glitch-Free MUX configuration register offset
+ * @write_ctl_reg:     Write Control register
+ * @write_sts_reg:     Write Status register
+ * @tl_delay_val:      Tunable-Length Delay (TLD) value
+ * @acd_ctrl_val:      Control Register (CR) value
+ * @softstart_val:     Soft Start Control Register (SSCR) value
+ * @ext_intf0_val:     Initial external interface configuration value
+ * @ext_intf1_val:     Final external interface configuration value
+ * @auto_xfer_val:     Auto-register Transfer Control value
+ *
+ * This structure holds the register offsets (from the ACD iospace base)
+ * and the parameters that are required to configure the OSM to
+ * initialize the Adaptive Clock Distribution (ACD) system.
+ */
+struct qcom_cpufreq_soc_acd_data {
+	u8 tl_delay_reg;
+	u8 acd_ctrl_reg;
+	u8 softstart_reg;
+	u8 ext_intf_reg;
+	u8 auto_xfer_reg;
+	u8 auto_xfer_cfg_reg;
+	u8 auto_xfer_ctl_reg;
+	u8 auto_xfer_sts_reg;
+	u8 dcvs_sw_reg;
+	u8 gfmux_cfg_reg;
+	u8 write_ctl_reg;
+	u8 write_sts_reg;
+	u32 tl_delay_val;
+	u32 acd_ctrl_val;
+	u32 softstart_val;
+	u32 ext_intf0_val;
+	u32 ext_intf1_val;
+	u32 auto_xfer_val;
+};
+
+/**
+ * struct qcom_cpufreq_hw_params - Operating State Manager (OSM) Parameters
+ *
+ * @volt_lut_val: Value composed of: virtual corner (vc) and voltage in mV.
+ * @freq_lut_val: Value composed of: core count, clock source and output
+ *                frequency in MHz.
+ * @override_val: PLL parameters that the OSM uses to override the previous
+ *                setting coming from the bootloader, or when uninitialized.
+ * @spare_val:    Spare register, used by both this driver and the OSM HW
+ *                to identify MEM-ACC levels in relation to virtual corners.
+ *
+ * This structure holds the parameters to write to the OSM registers for
+ * one "Virtual Corner" (VC), or one Performance State (p-state).
+ */
+struct qcom_cpufreq_hw_params {
+	u32 volt_lut_val;
+	u32 freq_lut_val;
+	u32 override_val;
+	u32 spare_val;
+};
 
+/**
+ * struct qcom_cpufreq_soc_data - SoC specific register offsets of the OSM
+ *
+ * @reg_enable:            OSM enable status
+ * @reg_index:             Index of the Virtual Corner
+ * @reg_freq_lut:          Frequency Lookup Table
+ * @reg_freq_lut_src_mask: Frequency Lookup Table clock-source mask
+ * @reg_volt_lut:          Voltage Lookup Table
+ * @reg_perf_state:        Performance State request register
+ * @lut_row_size:          Lookup Table row size
+ * @clk_hw_div:            Divider for "alternate" OSM clock-source
+ * @uses_tz:               OSM already set-up and protected by TrustZone
+ * @setup_regs:            Register offsets for OSM setup
+ */
 struct qcom_cpufreq_soc_data {
 	u32 reg_enable;
+	u32 reg_index;
 	u32 reg_freq_lut;
+	u32 reg_freq_lut_src_mask;
 	u32 reg_volt_lut;
 	u32 reg_perf_state;
 	u8 lut_row_size;
+	u8 clk_hw_div;
+	bool uses_tz;
+	const struct qcom_cpufreq_soc_setup_data setup_regs;
+	const struct qcom_cpufreq_soc_acd_data acd_data;
 };
 
 struct qcom_cpufreq_data {
@@ -36,6 +259,7 @@ struct qcom_cpufreq_data {
 	const struct qcom_cpufreq_soc_data *soc_data;
 };
 
+static const char *cprh_genpd_names[] = { "cprh", NULL };
 static unsigned long cpu_hw_rate, xo_rate;
 static bool icc_scaling_enabled;
 
@@ -166,6 +390,574 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	return policy->freq_table[index].frequency;
 }
 
+/**
+ * qcom_cpufreq_hw_boost_setup() - Sets up OSM boost timer registers
+ * @timer0_addr: Start of boost timer0 register group
+ * @len: Length (size) of "sub" registers in timer0 group
+ */
+static void qcom_cpufreq_hw_boost_setup(void __iomem *timer0_addr, u32 len)
+{
+	u32 val;
+
+	/* timer_reg0 */
+	val = FIELD_PREP(BOOST_TIMER_REG_LO, PLL_WAIT_LOCK_TIME_NS);
+	val |= FIELD_PREP(BOOST_TIMER_REG_HI, SAFE_FREQ_WAIT_NS);
+	writel(val, timer0_addr);
+
+	/* timer_reg1 */
+	val = FIELD_PREP(BOOST_TIMER_REG_LO, PLL_WAIT_LOCK_TIME_NS);
+	val |= FIELD_PREP(BOOST_TIMER_REG_HI, PLL_WAIT_LOCK_TIME_NS);
+	writel(val, timer0_addr + len);
+
+	/* timer_reg2 */
+	val = FIELD_PREP(BOOST_TIMER_REG_LO, DEXT_DECREMENT_WAIT_NS);
+	writel(val, timer0_addr + (2 * len));
+}
+
+/**
+ * qcom_cpufreq_gen_params() - Generate parameters to send to the hardware
+ * @cpu_dev:     CPU device
+ * @data:        SoC specific register offsets
+ * @hw_tbl:      Pointer to return the array of parameters
+ * @apm_vc:      APM Virtual Corner crossover number, returned to the caller
+ * @acc_vc:      MEMACC Virtual Corner crossover number, returned to the caller
+ * @cpu_count:   Number of CPUs in the frequency domain
+ * @num_entries: Number of allocated (and filled) elements in the table,
+ *               returned to the caller
+ *
+ * This function allocates a 'qcom_cpufreq_hw_params' parameters table,
+ * fills it and returns it to the consumer, ready to get sent to the HW.
+ * Since the APM threshold is just one
+ * Freeing the table after usage is left to the caller.
+ *
+ * Returns: Zero for success, otherwise negative value on errors.
+ */
+static int qcom_cpufreq_gen_params(struct device *cpu_dev,
+				   struct qcom_cpufreq_data *data,
+				   struct qcom_cpufreq_hw_params **hw_tbl,
+				   int *apm_vc, int *acc_vc, int cpu_count,
+				   u8 *num_entries)
+{
+	struct device **genpd_cpr_vdev;
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
+	struct cpr_ext_data *cpr_data;
+	struct dev_pm_opp *genpd_opp;
+	unsigned long rate;
+	int apm_uV, acc_uV, i, gpd_opp_cnt, ret = 0;
+
+	ret = devm_pm_opp_attach_genpd(cpu_dev, cprh_genpd_names, &genpd_cpr_vdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not attach to pm_domain: %d\n", ret);
+		return ret;
+	}
+
+	if (IS_ERR_OR_NULL(*genpd_cpr_vdev))
+		return -EINVAL;
+
+	/*
+	 * In the CPR3 driver we have assigned data to the genpd newly created
+	 * virtual device: this contains MEMACC and APM thresholds, as passing
+	 * them through OPPs would be an API abuse.
+	 */
+	cpr_data = dev_get_drvdata(*genpd_cpr_vdev);
+	if (cpr_data == NULL) {
+		dev_err(&pdev->dev, "Cannot get CPR data\n");
+		return -ENODATA;
+	}
+
+	/* Get the count of available OPPs coming from the power domain */
+	gpd_opp_cnt = dev_pm_opp_get_opp_count(cpu_dev);
+	if (gpd_opp_cnt < 2) {
+		ret = gpd_opp_cnt > 0 ? -EINVAL : gpd_opp_cnt;
+		goto detach_gpd;
+	}
+
+	/* If we get no APM voltage, the system is going to be unstable */
+	apm_uV = cpr_data->apm_threshold_uV;
+	if (apm_uV <= 0) {
+		ret = -EINVAL;
+		goto detach_gpd;
+	}
+
+	/*
+	 * Set apm_vc to a less than zero value: this is used later in the
+	 * logic making sure that we're returning the right virtual corner
+	 * for APM switch.
+	 */
+	*apm_vc = -1;
+
+	/*
+	 * Get the ACC threshold voltage: this is optional and not every
+	 * SoC, or every SoC version, or every binning, needs it.
+	 */
+	if (cpr_data->mem_acc_threshold_uV <= 0) {
+		acc_uV = INT_MAX;
+		*acc_vc = U8_MAX;
+	} else {
+		acc_uV = cpr_data->mem_acc_threshold_uV;
+		*acc_vc = -1;
+	}
+
+	*hw_tbl = devm_kmalloc_array(&pdev->dev, gpd_opp_cnt,
+				     sizeof(**hw_tbl), GFP_KERNEL);
+	if (!hw_tbl) {
+		ret = -ENOMEM;
+		goto detach_gpd;
+	}
+
+	for (i = 0, rate = 1000; i <= gpd_opp_cnt ; rate++, i++) {
+		struct qcom_cpufreq_hw_params *entry = *hw_tbl + i;
+		struct device_node *np;
+		u32 pll_div, millivolts, f_src;
+
+		/*
+		 * Find the next enabled OPP's frequency (ignores APM/ACC).
+		 *
+		 * We expect to get an error when we try to go past the last
+		 * defined frequency, so we quit the loop gracefully without
+		 * signaling any error, as this is the expected behavior.
+		 */
+		genpd_opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+		if (IS_ERR(genpd_opp))
+			break;
+
+		/* Get mandatory and optional properties from the OPP DT */
+		np = dev_pm_opp_get_of_node(genpd_opp);
+		if (!np) {
+			ret = -ENOENT;
+			goto detach_gpd;
+		}
+
+		if (of_property_read_u32(np, "qcom,pll-override",
+					 &entry->override_val)) {
+			ret = -EINVAL;
+			of_node_put(np);
+			goto detach_gpd;
+		}
+
+		if (of_property_read_u32(np, "qcom,spare-data",
+					 &entry->spare_val))
+			entry->spare_val = 0;
+
+		if (of_property_read_u32(np, "qcom,pll-div", &pll_div))
+			pll_div = 0;
+
+		of_node_put(np);
+
+		/* Get voltage in microvolts, then convert to millivolts */
+		millivolts = dev_pm_opp_get_voltage(genpd_opp);
+		if (millivolts >= apm_uV && *apm_vc < 0)
+			*apm_vc = i;
+		if (millivolts >= acc_uV && *acc_vc < 0)
+			*acc_vc = i;
+
+		millivolts /= 1000;
+
+		if (millivolts < 150 || millivolts > 1400) {
+			dev_err(&pdev->dev,
+				"Read invalid voltage: %u.\n", millivolts);
+			return -EINVAL;
+		}
+
+		/* In the OSM firmware, "Virtual Corner" levels start from 0 */
+		entry->volt_lut_val = FIELD_PREP(LUT_VOLT_VC, i);
+		entry->volt_lut_val |= FIELD_PREP(LUT_VOLT, millivolts);
+
+		/*
+		 * Only the first frequency has alternate source, as it is
+		 * always that one that is used for low power idle states.
+		 */
+		f_src = i ? 1 : 0;
+		f_src <<= ffs(soc_data->reg_freq_lut_src_mask) - 1;
+		entry->freq_lut_val = f_src | div_u64(rate, xo_rate);
+		entry->freq_lut_val |= FIELD_PREP(LUT_CORE_COUNT, cpu_count);
+
+		/*
+		 * PLL divider is not always 0 and there is no way to determine
+		 * it automatically, as setting this value higher than DIV1
+		 * will make the OSM HW to effectively set the PLL at 2-4x
+		 * the CPU frequency and then divide the CPU clock by this div,
+		 * so this value is effectively used as both a multiplier and
+		 * divider.
+		 * This value cannot be calculated because it depends on
+		 * manual calibration and is (most probably) used to choose
+		 * a PLL frequency that gives the least possible jitter.
+		 */
+		entry->freq_lut_val |= FIELD_PREP(LUT_PLL_DIV, pll_div);
+
+		dev_dbg(&pdev->dev,
+			"[%d] freq=0x%x volt=0x%x override=0x%x spare=0x%x\n",
+			i, entry->freq_lut_val, entry->volt_lut_val,
+			entry->override_val, entry->spare_val);
+		dev_pm_opp_put(genpd_opp);
+		genpd_opp = NULL;
+	}
+
+	/*
+	 * If we've got a customized mem-acc corner but we couldn't
+	 * find any suitable crossover, or the corner is less than
+	 * the minimum amount of required corners for mem-acc scaling,
+	 * the values are not valid, hence fall back to LUT values.
+	 */
+	if (acc_uV != INT_MAX && *acc_vc < SEQ_MEM_ACC_MAX_LEVELS - 1) {
+		dev_dbg(&pdev->dev,
+			"MEM-ACC corner: invalid values VC%d %duV\n",
+			*acc_vc, acc_uV);
+		*acc_vc = U8_MAX;
+	}
+
+	/*
+	 * If we have probed less params than what we need, then the
+	 * OPP table that we got from the genpd is malformed for some
+	 * reason: in this case, do not apply the table to the HW.
+	 */
+	if (i < gpd_opp_cnt) {
+		dev_err(&pdev->dev, "Got bad OPP table from power domain.\n");
+		ret = -EINVAL;
+		goto detach_gpd;
+	}
+	*num_entries = i;
+
+detach_gpd:
+	return ret;
+}
+
+static inline u32 qcom_cpufreq_acd_regbit(u8 acd_reg_offset)
+{
+	return BIT(acd_reg_offset / 4);
+}
+
+static int qcom_cpufreq_hw_acd_write_autoxfer(struct qcom_cpufreq_data *data,
+					      void __iomem *acd_base, u32 val)
+{
+	const struct qcom_cpufreq_soc_data *sdata = data->soc_data;
+	const struct qcom_cpufreq_soc_acd_data *aregs = &sdata->acd_data;
+	u32 regval = 0;
+
+	writel(val, acd_base + aregs->auto_xfer_cfg_reg);
+
+	/* (Clear, then) Set AUTOXFER START */
+	writel(0, acd_base + aregs->auto_xfer_reg);
+	writel(1, acd_base + aregs->auto_xfer_reg);
+
+	/* Poll for status: if the first bit is set the transfer is done. */
+	return readl_poll_timeout(acd_base + aregs->auto_xfer_sts_reg, regval,
+				  regval & BIT(0), 1, 3);
+}
+
+static int qcom_cpufreq_hw_acd_write_xfer(struct qcom_cpufreq_data *data,
+					  void __iomem *acd_base, u8 reg,
+					  u32 val)
+{
+	const struct qcom_cpufreq_soc_data *sdata = data->soc_data;
+	const struct qcom_cpufreq_soc_acd_data *aregs = &sdata->acd_data;
+	u32 regval = 0;
+
+	/* Write to the register, then initiate manual transfer */
+	writel(val, acd_base + reg);
+
+	/* Clear write control register */
+	writel(0, acd_base + aregs->write_ctl_reg);
+
+	regval = (reg / 4) << ACD_WRITE_CTL_SELECT_SHIFT;
+	regval |= ACD_WRITE_CTL_UPDATE_EN;
+	writel(regval, acd_base + aregs->write_ctl_reg);
+
+	/* Wait until ACD Local Transfer is done */
+	return readl_poll_timeout(acd_base + aregs->write_sts_reg, regval,
+				  regval & qcom_cpufreq_acd_regbit(reg), 1, 3);
+}
+
+/**
+ * qcom_cpufreq_hw_acd_init() - Initialize ACD params in the OSM
+ * @cpu_dev:   CPU device
+ * @policy:    CPUFreq policy structure
+ * @index:     Instance number (CPU cluster number)
+ *
+ * On some SoCs it is required to send the ACD configuration parameters
+ * to the OSM. This function takes the parameters from the SoC specific
+ * configuration and writes them only if a "osm-acdN" iospace has been
+ * declared (hence, it's present).
+ *
+ * Returns: Zero for success, otherwise negative number on error.
+ */
+static int qcom_cpufreq_hw_acd_init(struct device *cpu_dev,
+				    struct cpufreq_policy *policy,
+				    int index)
+{
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct qcom_cpufreq_data *ddata = policy->driver_data;
+	const struct qcom_cpufreq_soc_data *sdata = ddata->soc_data;
+	const struct qcom_cpufreq_soc_acd_data *aregs = &sdata->acd_data;
+	char acd_resname[] = "osm-acdX";
+	void __iomem *acd_base;
+	u32 rmask;
+	int ret;
+
+	snprintf(acd_resname, sizeof(acd_resname), "osm-acd%d", index);
+
+	acd_base = devm_platform_ioremap_resource_byname(pdev, acd_resname);
+	if (IS_ERR(acd_base)) {
+		dev_vdbg(cpu_dev, "Skipping ACD initialization.\n");
+		return 0;
+	}
+
+	writel(aregs->tl_delay_val, acd_base + aregs->tl_delay_reg);
+	writel(aregs->acd_ctrl_val, acd_base + aregs->acd_ctrl_reg);
+	writel(aregs->softstart_val, acd_base + aregs->softstart_reg);
+	writel(aregs->ext_intf0_val, acd_base + aregs->ext_intf_reg);
+	writel(aregs->auto_xfer_val, acd_base + aregs->auto_xfer_ctl_reg);
+
+	rmask = qcom_cpufreq_acd_regbit(aregs->acd_ctrl_reg) |
+		qcom_cpufreq_acd_regbit(aregs->tl_delay_reg) |
+		qcom_cpufreq_acd_regbit(aregs->softstart_reg) |
+		qcom_cpufreq_acd_regbit(aregs->ext_intf_reg);
+	ret = qcom_cpufreq_hw_acd_write_autoxfer(ddata, acd_base, rmask);
+	if (ret)
+		return ret;
+
+	/* Switch CPUSS clock source to ACD clock */
+	ret = qcom_cpufreq_hw_acd_write_xfer(ddata, acd_base,
+					     aregs->gfmux_cfg_reg, 1);
+	if (ret)
+		return ret;
+
+	/* (Set, then) Clear DCVS_SW */
+	ret = qcom_cpufreq_hw_acd_write_xfer(ddata, acd_base,
+					     aregs->dcvs_sw_reg, 1);
+	if (ret)
+		return ret;
+	ret = qcom_cpufreq_hw_acd_write_xfer(ddata, acd_base,
+					     aregs->dcvs_sw_reg, 0);
+	if (ret)
+		return ret;
+
+	/* Wait for clock switch time */
+	udelay(1);
+
+	/* Program the final ACD external interface */
+	ret = qcom_cpufreq_hw_acd_write_xfer(ddata, acd_base,
+					     aregs->ext_intf_reg,
+					     aregs->ext_intf1_val);
+	if (ret)
+		return ret;
+
+	/* Initiate transfer of the final ACD value */
+	rmask |= qcom_cpufreq_acd_regbit(aregs->gfmux_cfg_reg);
+	writel(rmask, acd_base + aregs->auto_xfer_cfg_reg);
+
+	/* Wait for ACD to stabilize. Same wait as the OSM boot time... */
+	udelay(OSM_BOOT_TIME_US);
+	return 0;
+}
+
+/**
+ * qcom_cpufreq_hw_write_lut() - Write Lookup Table params to the OSM
+ * @cpu_dev:   CPU device
+ * @policy:    CPUFreq policy structure
+ * @cpu_count: Number of CPUs in the frequency domain
+ * @index:     Instance number (CPU cluster number)
+ *
+ * Program all the Lookup Table (LUT) entries and related thresholds
+ * to the Operating State Manager on platforms where the same hasn't
+ * been done already by the bootloader or TrustZone before booting
+ * the operating system's kernel;
+ * On these platforms, write access to the OSM is (obviously) not
+ * blocked by the hypervisor.
+ *
+ * Returns: Zero for success, otherwise negative number on error.
+ */
+static int qcom_cpufreq_hw_write_lut(struct device *cpu_dev,
+				     struct cpufreq_policy *policy,
+				     int cpu_count, int index)
+{
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct qcom_cpufreq_data *ddata = policy->driver_data;
+	const struct qcom_cpufreq_soc_data *sdata = ddata->soc_data;
+	const struct qcom_cpufreq_soc_setup_data *sregs = &sdata->setup_regs;
+	struct qcom_cpufreq_hw_params *hw_tbl;
+	struct resource *osm_rsrc;
+	char osm_resname[] = "osm-domainX";
+	u32 sreg, seq_addr, acc_lval = 0, last_spare = 1;
+	u8 num_entries = 0;
+	int apm_vc = INT_MAX, acc_vc = U8_MAX, acc_idx = 0;
+	int acc_val[SEQ_MEM_ACC_MAX_LEVELS], i, ret;
+
+	snprintf(osm_resname, sizeof(osm_resname), "osm-domain%d", index);
+
+	/*
+	 * On some SoCs the OSM is not getting programmed from bootloader
+	 * and needs to be done here: in this case, we need to retrieve
+	 * the base physical address for the "Sequencer", so we will get
+	 * the OSM base phys and apply the sequencer offset.
+	 *
+	 * Note: We are not remapping this iospace because we are really
+	 *       sending the physical address through SCM calls later.
+	 */
+	osm_rsrc = platform_get_resource_byname(pdev, IORESOURCE_MEM, osm_resname);
+	if (!osm_rsrc)
+		return -ENODEV;
+
+	seq_addr = osm_rsrc->start + sregs->reg_osm_sequencer;
+
+	ret = qcom_cpufreq_gen_params(cpu_dev, ddata, &hw_tbl, &apm_vc,
+				      &acc_vc, cpu_count, &num_entries);
+	if (ret)
+		return ret;
+
+	/* If we get less than 2 entries, scaling doesn't make sense */
+	if (num_entries < 2) {
+		dev_err(&pdev->dev, "Not enough LUT entries found (%u)\n", num_entries);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
+		struct qcom_cpufreq_hw_params *entry;
+		int pos = i * sdata->lut_row_size;
+
+		/*
+		 * If we have reached the end of the params table, write
+		 * the last valid entry until the end of the OSM table.
+		 */
+		if (i < num_entries)
+			entry = &hw_tbl[i];
+		else
+			entry = &hw_tbl[num_entries - 1];
+
+		writel(i, ddata->base + sdata->reg_index + pos);
+		writel(entry->volt_lut_val, ddata->base + sdata->reg_volt_lut + pos);
+		writel(entry->freq_lut_val, ddata->base + sdata->reg_freq_lut + pos);
+		writel(entry->override_val, ddata->base + sregs->reg_override + pos);
+		writel(entry->spare_val, ddata->base + sregs->reg_spare + pos);
+
+		dev_dbg(cpu_dev, "Writing [%d] v:0x%x f:0x%x ovr:0x%x s:0x%x\n", i,
+			entry->volt_lut_val, entry->freq_lut_val,
+			entry->override_val, entry->spare_val);
+
+		/*
+		 * MEM-ACC Virtual Corner threshold voltage: this gets set
+		 * as the pairs of corners in which there is a transition
+		 * between one MEM-ACC level and the next one.
+		 *
+		 * Notes: The spare_val can never be zero;
+		 *        The first spare_val is always 1;
+		 *        The maximum number of pairs is two (four registers).
+		 *
+		 * Example: (C = Corner Level - M = MEM-ACC Level)
+		 *          C0 M1 - C1 M1 - C2 M2 - C3 M2 - C4 M2 - C5 M3
+		 *          Pairs: 1-2, 4-5
+		 */
+		if (entry->spare_val <= last_spare ||
+		    acc_idx >= SEQ_MEM_ACC_MAX_LEVELS - 1)
+			continue;
+
+		/* Standard mem-acc pairs using spare_val LUT crossovers */
+		last_spare = entry->spare_val;
+		acc_val[acc_idx] = i - 1;
+		acc_idx++;
+		acc_val[acc_idx] = i;
+		acc_idx++;
+	}
+
+	/* Sanity check: we *must* have two mem-acc crossovers (four values) */
+	if (acc_idx < SEQ_MEM_ACC_MAX_LEVELS - 1)
+		return -EINVAL;
+
+	/*
+	 * Customized mem-acc corners, if any; in this case, the last corner
+	 * in the external (CPRh) LUT is this one, placed after the APM one.
+	 */
+	if (acc_vc > 0 && acc_vc != U8_MAX) {
+		sreg = SEQUENCER_REG(seq_addr, SEQ_MEM_ACC_CROSSOVER_VC);
+		ret = qcom_scm_io_writel(sreg, num_entries + 1);
+		if (ret)
+			return ret;
+
+		/*
+		 * At the price of very-slightly higher power consumption,
+		 * switch the ACC at one corner lower than what we've found,
+		 * as this seems to be needed on at least some MSM8998 chips
+		 * to achieve full system stability
+		 */
+		acc_vc--;
+
+		/* Change only if we have to move the corner down */
+		if (acc_vc < acc_val[3]) {
+			acc_val[2] = acc_vc - 1;
+			acc_val[3] = acc_vc;
+		}
+
+		/* If needed, sanitize previously stored vals from the LUT */
+		if (acc_val[2] <= acc_val[1])
+			acc_val[1] = acc_val[2] - 1;
+		if (acc_val[1] <= acc_val[0])
+			acc_val[0] = acc_val[1] - 1;
+	}
+
+	for (i = 0; i < SEQ_MEM_ACC_MAX_LEVELS; i++) {
+		ret = qcom_scm_io_writel(SEQ_MEMACC_REG(seq_addr, i), acc_val[i]);
+		if (ret)
+			return ret;
+	}
+	dev_dbg(cpu_dev, "Wrote MEM-ACC Pairs: [%u-%u] [%u-%u]\n",
+		 acc_val[0], acc_val[1], acc_val[2], acc_val[3]);
+
+	/*
+	 * Program the L_VAL of the first corner requesting MEM-ACC
+	 * voltage level 3 to the right sequencer register
+	 */
+	acc_lval = FIELD_GET(LUT_L_VAL, hw_tbl[acc_val[3]].freq_lut_val);
+	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_MEM_ACC_LVAL), acc_lval);
+	if (ret) {
+		dev_dbg(cpu_dev, "Cannot send memacc l_val\n");
+		return ret;
+	}
+	dev_dbg(cpu_dev, "MEM-ACC L-Val is %u\n", acc_lval);
+
+	/*
+	 * Array Power Mux threshold level: the first virtual corner
+	 * that requires a switch sequence of the APM from MX to APC.
+	 */
+	if (apm_vc == INT_MAX)
+		apm_vc = LUT_MAX_ENTRIES - 1;
+
+	/*
+	 * APM crossover virtual corner refers to CPRh: there, the APM corner
+	 * is always appended to the table (so, at the end of it, right after
+	 * the cluster dvfs entries).
+	 */
+	writel(num_entries, ddata->base + sregs->reg_seq1);
+	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_APM_CROSSOVER_VC), num_entries);
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_APM_THRESH_VC), apm_vc);
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_APM_THRESH_PREVC), apm_vc - 1);
+	if (ret)
+		return ret;
+
+	ret = qcom_scm_io_writel(SEQUENCER_REG(seq_addr, SEQ_APM_PARAM),
+				 (0x39 | apm_vc << 6));
+	if (ret)
+		return ret;
+	dev_dbg(cpu_dev, "Wrote APM Pair: [%u-%u]\n", apm_vc - 1, apm_vc);
+
+	/*
+	 * We succeeded! Dispose of the table that got allocated during
+	 * qcom_cpufreq_gen_params, as that contains parameters that are
+	 * relevant only to the context of OSM programming, which is done
+	 * only once.
+	 */
+	if (hw_tbl)
+		devm_kfree(&pdev->dev, hw_tbl);
+
+	return 0;
+}
+
 /**
  * qcom_cpufreq_hw_read_lut() - Read Lookup Table from the OSM
  * @cpu_dev:   CPU device
@@ -214,14 +1006,16 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	}
 
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
-				      i * soc_data->lut_row_size);
-		src = FIELD_GET(LUT_SRC, data);
+		data = readl(drv_data->base + soc_data->reg_freq_lut +
+			     i * soc_data->lut_row_size);
+		src = data & soc_data->reg_freq_lut_src_mask;
+		src >>= ffs(soc_data->reg_freq_lut_src_mask) - 1;
+
 		lval = FIELD_GET(LUT_L_VAL, data);
 		core_count = FIELD_GET(LUT_CORE_COUNT, data);
 
-		data = readl_relaxed(drv_data->base + soc_data->reg_volt_lut +
-				      i * soc_data->lut_row_size);
+		data = readl(drv_data->base + soc_data->reg_volt_lut +
+			     i * soc_data->lut_row_size);
 		volt = FIELD_GET(LUT_VOLT, data) * 1000;
 
 		if (src)
@@ -259,8 +1053,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 					prev->frequency = prev_freq;
 					prev->flags = CPUFREQ_BOOST_FREQ;
 				} else {
-					dev_warn(cpu_dev, "failed to update OPP for freq=%d\n",
-						 freq);
+					dev_warn(cpu_dev, "can't update OPP for freq=%u\n", freq);
 				}
 			}
 
@@ -281,11 +1074,14 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
  * qcom_get_related_cpus - Get mask of CPUs in the same frequency domain
  * @index: CPU number
  * @m:     Returned CPU mask
+ *
+ * Returns: Count of CPUs inserted in the cpumask or negative number for error.
  */
-static void qcom_get_related_cpus(int index, struct cpumask *m)
+static int qcom_get_related_cpus(int index, struct cpumask *m)
 {
 	struct device_node *cpu_np;
 	struct of_phandle_args args;
+	int count = 0;
 	int cpu, ret;
 
 	for_each_possible_cpu(cpu) {
@@ -294,40 +1090,236 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 			continue;
 
 		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
-						 "#freq-domain-cells", 0,
-						 &args);
+						 "#freq-domain-cells", 0, &args);
 		of_node_put(cpu_np);
 		if (ret < 0)
 			continue;
 
-		if (index == args.args[0])
+		if (index == args.args[0]) {
 			cpumask_set_cpu(cpu, m);
+			count++;
+		}
 	}
+
+	return count > 0 ? count : -EINVAL;
 }
 
 static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 	.reg_enable = 0x0,
 	.reg_freq_lut = 0x110,
+	.reg_freq_lut_src_mask = LUT_SRC_845,
 	.reg_volt_lut = 0x114,
 	.reg_perf_state = 0x920,
 	.lut_row_size = 32,
+	.clk_hw_div = 2,
+	.uses_tz = true,
+};
+
+static const struct qcom_cpufreq_soc_data msm8998_soc_data = {
+	.reg_enable = 0x4,
+	.reg_index = 0x150,
+	.reg_freq_lut = 0x154,
+	.reg_freq_lut_src_mask = LUT_SRC_8998,
+	.reg_volt_lut = 0x158,
+	.reg_perf_state = 0xf10,
+	.lut_row_size = 32,
+	.clk_hw_div = 1,
+	.uses_tz = false,
+	.setup_regs = {
+		/* Physical offset for sequencer scm calls */
+		.reg_osm_sequencer = 0x300,
+
+		/* Frequency domain offsets */
+		.reg_override = 0x15c,
+		.reg_spare = 0x164,
+		.reg_cc_zero_behav = 0x0c,
+		.reg_spm_cc_hyst = 0x1c,
+		.reg_spm_cc_dcvs_dis = 0x20,
+		.reg_spm_core_ret_map = 0x24,
+		.reg_llm_freq_vote_hyst = 0x2c,
+		.reg_llm_volt_vote_hyst = 0x30,
+		.reg_llm_intf_dcvs_dis = 0x34,
+		.reg_seq1 = 0x48,
+		.reg_pdn_fsm_ctrl = 0x70,
+		.reg_cc_boost_timer = 0x74,
+		.reg_dcvs_boost_timer = 0x84,
+		.reg_ps_boost_timer = 0x94,
+		.boost_timer_reg_len = 0x4,
+		.reg_boost_sync_delay = 0xa0,
+		.reg_droop_ctrl = 0xa4,
+		.reg_droop_release_ctrl = 0xa8,
+		.reg_droop_unstall_ctrl = 0xac,
+		.reg_droop_wait_release_ctrl = 0xb0,
+		.reg_droop_timer_ctrl = 0xb8,
+		.reg_droop_sync_delay = 0xbc,
+		.reg_pll_override = 0xc0,
+		.reg_cycle_counter = 0xf00,
+	},
+	.acd_data = {
+		.acd_ctrl_reg = 0x4,
+		.tl_delay_reg = 0x8,
+		.softstart_reg = 0x28,
+		.ext_intf_reg = 0x30,
+		.dcvs_sw_reg = 0x34,
+		.gfmux_cfg_reg = 0x3c,
+		.auto_xfer_cfg_reg = 0x80,
+		.auto_xfer_reg = 0x84,
+		.auto_xfer_ctl_reg = 0x88,
+		.auto_xfer_sts_reg = 0x8c,
+		.write_ctl_reg = 0x90,
+		.write_sts_reg = 0x94,
+		.tl_delay_val = 38417,
+		.acd_ctrl_val = 0x2b5ffd,
+		.softstart_val = 0x501,
+		.ext_intf0_val = 0x2cf9ae8,
+		.ext_intf1_val = 0x2cf9afe,
+		.auto_xfer_val = 0x15,
+	},
 };
 
 static const struct qcom_cpufreq_soc_data epss_soc_data = {
 	.reg_enable = 0x0,
 	.reg_freq_lut = 0x100,
+	.reg_freq_lut_src_mask = LUT_SRC_845,
 	.reg_volt_lut = 0x200,
 	.reg_perf_state = 0x320,
 	.lut_row_size = 4,
+	.clk_hw_div = 2,
+	.uses_tz = true,
 };
 
 static const struct of_device_id qcom_cpufreq_hw_match[] = {
 	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
+	{ .compatible = "qcom,cpufreq-hw-8998", .data = &msm8998_soc_data },
 	{ .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
 
+/**
+ * qcom_cpufreq_hw_osm_setup() - Setup and enable the OSM
+ * @cpu_dev:   CPU device
+ * @policy:    CPUFreq policy structure
+ * @cpu_count: Number of CPUs in the frequency domain
+ *
+ * On some platforms, the Operating State Manager (OSM) is not getting
+ * programmed by the bootloader, nor by TrustZone before booting the OS
+ * and its register space is not write-protected by the hypervisor.
+ * In this case, to achieve CPU DVFS, it is needed to program it from
+ * the OS itself, which includes setting LUT and all the various tunables
+ * that are required for it to manage the CPU frequencies and voltages
+ * on its own.
+ * Calling this function on a platform that had the OSM set-up by TZ
+ * will result in a hypervisor fault with system reboot in most cases.
+ *
+ * Returns: Zero for success, otherwise negative number on errors.
+ */
+static int qcom_cpufreq_hw_osm_setup(struct device *cpu_dev,
+				     struct cpufreq_policy *policy,
+				     int cpu_count, int index)
+{
+	struct qcom_cpufreq_data *drv_data = policy->driver_data;
+	const struct qcom_cpufreq_soc_setup_data *setup_regs;
+	u32 val;
+	int ret;
+
+	ret = qcom_cpufreq_hw_write_lut(cpu_dev, policy, cpu_count, index);
+	if (ret)
+		return ret;
+
+	setup_regs = &drv_data->soc_data->setup_regs;
+
+	/* Set OSM to XO clock ratio and use XO edge for the cycle counter */
+	val = FIELD_PREP(CYCLE_COUNTER_CLK_RATIO, OSM_XO_RATIO_VAL);
+	val |= CYCLE_COUNTER_USE_XO_EDGE;
+
+	/* Enable the CPU cycle counter */
+	val |= BIT(0);
+	writel(val, drv_data->base + setup_regs->reg_cycle_counter);
+
+	/* CoreCount DCVS Policy: Wait time for frequency inc/decrement */
+	val = FIELD_PREP(HYSTERESIS_UP_MASK, HYSTERESIS_CC_NS);
+	val |= FIELD_PREP(HYSTERESIS_DN_MASK, HYSTERESIS_CC_NS);
+	writel(val, drv_data->base + setup_regs->reg_spm_cc_hyst);
+
+	/* Set the frequency index 0 and override for cluster power collapse */
+	writel(BIT(0), drv_data->base + setup_regs->reg_cc_zero_behav);
+
+	/* Treat cores in retention as active */
+	writel(0, drv_data->base + setup_regs->reg_spm_core_ret_map);
+
+	/* Enable CoreCount based DCVS */
+	writel(0, drv_data->base + setup_regs->reg_spm_cc_dcvs_dis);
+
+	/* CoreCount DCVS-LLM Policy: Wait time for frequency inc/decrement */
+	val = FIELD_PREP(HYSTERESIS_UP_MASK, HYSTERESIS_LLM_NS);
+	val |= FIELD_PREP(HYSTERESIS_DN_MASK, HYSTERESIS_LLM_NS);
+	writel(val, drv_data->base + setup_regs->reg_llm_freq_vote_hyst);
+
+	/* CoreCount DCVS-LLM Policy: Wait time for voltage inc/decrement */
+	val = FIELD_PREP(HYSTERESIS_UP_MASK, HYSTERESIS_LLM_NS);
+	val |= FIELD_PREP(HYSTERESIS_DN_MASK, HYSTERESIS_LLM_NS);
+	writel(val, drv_data->base + setup_regs->reg_llm_volt_vote_hyst);
+
+	/* Enable LLM frequency+voltage voting */
+	writel(0, drv_data->base + setup_regs->reg_llm_intf_dcvs_dis);
+
+	/* Setup Boost FSM Timers */
+	qcom_cpufreq_hw_boost_setup(drv_data->base + setup_regs->reg_cc_boost_timer,
+				    setup_regs->boost_timer_reg_len);
+	qcom_cpufreq_hw_boost_setup(drv_data->base + setup_regs->reg_dcvs_boost_timer,
+				    setup_regs->boost_timer_reg_len);
+	qcom_cpufreq_hw_boost_setup(drv_data->base + setup_regs->reg_ps_boost_timer,
+				    setup_regs->boost_timer_reg_len);
+
+	/* PLL signal timing control for Boost */
+	writel(BOOST_SYNC_DELAY, drv_data->base + setup_regs->reg_boost_sync_delay);
+
+	/* Setup WFx and PC/RET droop unstall */
+	val = FIELD_PREP(DROOP_TIMER1, DROOP_TIMER_NS);
+	val |= FIELD_PREP(DROOP_TIMER0, DROOP_TIMER_NS);
+	writel(val, drv_data->base + setup_regs->reg_droop_unstall_ctrl);
+
+	/* Setup WFx and PC/RET droop wait-to-release */
+	val = FIELD_PREP(DROOP_TIMER1, DROOP_WAIT_RELEASE_TIMER_NS);
+	val |= FIELD_PREP(DROOP_TIMER0, DROOP_WAIT_RELEASE_TIMER_NS);
+	writel(val, drv_data->base + setup_regs->reg_droop_wait_release_ctrl);
+
+	/* PLL signal timing control for Droop */
+	writel(1, drv_data->base + setup_regs->reg_droop_sync_delay);
+
+	/* Setup DCVS timers */
+	writel(DROOP_RELEASE_TIMER_NS,
+	       drv_data->base + setup_regs->reg_droop_release_ctrl);
+	writel(DROOP_TIMER_NS, drv_data->base + setup_regs->reg_droop_timer_ctrl);
+
+	/* Setup Droop control */
+	val = readl(drv_data->base + setup_regs->reg_droop_ctrl);
+	val |= DROOP_CTRL_VAL;
+	writel(val, drv_data->base + setup_regs->reg_droop_ctrl);
+
+	/* Enable CC-Boost, DCVS-Boost, PS-Boost, WFx, PC/RET, DCVS FSM */
+	val = readl(drv_data->base + setup_regs->reg_pdn_fsm_ctrl);
+	val |= CC_BOOST_EN | PS_BOOST_EN | DCVS_BOOST_EN;
+	val |= WFX_DROOP_EN | PC_RET_EXIT_DROOP_EN | DCVS_DROOP_EN;
+	writel(val, drv_data->base + setup_regs->reg_pdn_fsm_ctrl);
+
+	/* Enable PLL Droop Override */
+	val = PLL_OVERRIDE_DROOP_EN;
+	writel(val, drv_data->base + setup_regs->reg_pll_override);
+
+	/* Initialize the Adaptive Clock Distribution */
+	ret = qcom_cpufreq_hw_acd_init(cpu_dev, policy, index);
+	if (ret)
+		return ret;
+
+	/* We're ready: enable the OSM and give it time to boot (5uS) */
+	writel(1, drv_data->base + drv_data->soc_data->reg_enable);
+	udelay(OSM_BOOT_TIME_US);
+
+	return 0;
+}
+
 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -338,7 +1330,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct resource *res;
 	void __iomem *base;
 	struct qcom_cpufreq_data *data;
-	int ret, index;
+	char fdom_resname[] = "freq-domainX";
+	int cpu_count, index, ret;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -359,7 +1352,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	index = args.args[0];
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	snprintf(fdom_resname, sizeof(fdom_resname), "freq-domain%d", index);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, fdom_resname);
 	if (!res) {
 		dev_err(dev, "failed to get mem resource %d\n", index);
 		return -ENODEV;
@@ -473,9 +1468,50 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
+	const struct qcom_cpufreq_soc_data *soc_data;
+	struct device_node *pd_node;
+	struct platform_device *pd_dev;
 	struct device *cpu_dev;
 	struct clk *clk;
-	int ret;
+	int clk_div, ret;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -EPROBE_DEFER;
+
+	soc_data = of_device_get_match_data(&pdev->dev);
+	if (!soc_data)
+		return -EINVAL;
+
+	if (!soc_data->uses_tz) {
+		/*
+		 * When the OSM is not pre-programmed from TZ, we will
+		 * need to program the sequencer through SCM calls.
+		 */
+		if (!qcom_scm_is_available())
+			return -EPROBE_DEFER;
+
+		/*
+		 * If there are no power-domains, OSM programming cannot be
+		 * performed, as in that case, we wouldn't know where to take
+		 * the params from...
+		 */
+		pd_node = of_parse_phandle(cpu_dev->of_node, "power-domains", 0);
+		if (!pd_node) {
+			ret = PTR_ERR(pd_node);
+			dev_err(cpu_dev, "power domain not found: %d\n", ret);
+			return ret;
+		}
+
+		/*
+		 * If the power domain device is not registered yet, then
+		 * defer probing this driver until that is available.
+		 */
+		pd_dev = of_find_device_by_node(pd_node);
+		if (!pd_dev || !pd_dev->dev.driver ||
+		    !device_is_bound(&pd_dev->dev))
+			return -EPROBE_DEFER;
+	}
 
 	clk = clk_get(&pdev->dev, "xo");
 	if (IS_ERR(clk))
@@ -488,16 +1524,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
+	clk_div = soc_data->clk_hw_div;
+	if (clk_div == 0)
+		clk_div++;
+
+	cpu_hw_rate = clk_get_rate(clk) / clk_div;
 	clk_put(clk);
 
 	cpufreq_qcom_hw_driver.driver_data = pdev;
 
 	/* Check for optional interconnect paths on CPU0 */
-	cpu_dev = get_cpu_device(0);
-	if (!cpu_dev)
-		return -EPROBE_DEFER;
-
 	ret = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
 	if (ret)
 		return ret;
-- 
2.32.0

