Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0652A14AAEA
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2020 21:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgA0UFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jan 2020 15:05:08 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:21884 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgA0UFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2020 15:05:07 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580155506; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vXpcj24gh8Hf2SF5qmdc6zSo0d57MQ7C6Pr/nZ9vIMU=; b=hsWriNRt2+srRNdY5l3hPkIgfbkU5jlNuZOjr2IU1FejPwZPflP3qSc6u6jcDopGkL6pTu4x
 W0kIAjO2Nk2brY/g/i05o5dZLjBykQSwCaO57u7MRVcyfLC6+fddjKsleYoirEnROQmgNXhl
 bQjfjrrUwZKWkL3ukJzX/rDSol4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2f426e.7fd3cd82ac00-smtp-out-n03;
 Mon, 27 Jan 2020 20:05:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D2B4C447A1; Mon, 27 Jan 2020 20:05:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBA6CC447A2;
        Mon, 27 Jan 2020 20:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBA6CC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [RFC v3 08/10] cpufreq: qcom: Update the bandwidth levels on frequency change
Date:   Tue, 28 Jan 2020 01:33:48 +0530
Message-Id: <20200127200350.24465-9-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200127200350.24465-1-sibis@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support to parse and update OPP tables attached to the cpu device
when the required OPP bandwidth values are populated to enable scaling
of DDR/L3 bandwidth levels with frequency change.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 246 +++++++++++++++++++++++++++---
 1 file changed, 225 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index fc92a8842e252..348eb2fdaccaf 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -6,6 +6,7 @@
 #include <linux/bitfield.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
+#include <linux/interconnect.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -28,17 +29,194 @@
 #define REG_VOLT_LUT			0x114
 #define REG_PERF_STATE			0x920
 
+#define QCOM_ICC_TAG_ACTIVE_ONLY	1
+
 static unsigned long cpu_hw_rate, xo_rate;
 static struct platform_device *global_pdev;
 
+/* opp table indices */
+enum {
+	QCOM_CPU_OPP_TABLE_INDEX,
+	QCOM_CPU_DDR_OPP_TABLE_INDEX,
+	QCOM_CPU_L3_OPP_TABLE_INDEX,
+};
+
+/* icc path indices */
+enum {
+	ICC_DDR_PATH,
+	ICC_L3_PATH,
+};
+
+struct qcom_cpufreq_hw_res {
+	void __iomem *base;
+
+	struct device *cpu_dev;
+
+	/* ddr/l3 icc paths */
+	struct icc_path *path[2];
+
+	/* cpu/ddr/l3 opp tables */
+	struct opp_table *opp_table[3];
+};
+
+struct cpufreq_hw_icc_info {
+	const char *icc_path_name;
+	u8 table_index;
+	u32 tag;
+};
+
+static const struct cpufreq_hw_icc_info icc_info[] = {
+	{
+		.icc_path_name = "cpu-ddr",
+		.table_index = QCOM_CPU_DDR_OPP_TABLE_INDEX,
+		.tag = QCOM_ICC_TAG_ACTIVE_ONLY,
+	},
+	{
+		.icc_path_name = "cpu-l3",
+		.table_index = QCOM_CPU_L3_OPP_TABLE_INDEX,
+		.tag = 0,
+	},
+};
+
+static int qcom_cpufreq_hw_add_opp_table(struct qcom_cpufreq_hw_res *res)
+{
+	struct opp_table **table = res->opp_table;
+	struct device_node *opp_table_np, *np;
+	struct device *dev = res->cpu_dev;
+	int ret, i;
+	u64 rate;
+
+	for (i = 0; i <= QCOM_CPU_L3_OPP_TABLE_INDEX; i++) {
+		ret = dev_pm_opp_of_add_table_indexed(dev, i);
+		if (ret) {
+			dev_dbg(dev, "Add OPP table failed index %d: %d\n",
+				i, ret);
+			goto err;
+		}
+
+		table[i] = dev_pm_opp_get_opp_table_indexed(dev, i);
+		if (!table[i]) {
+			dev_dbg(dev, "Get OPP table failed index %d\n", i);
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	/* Disable all cpu opps and cross-validate against LUT */
+	opp_table_np = dev_pm_opp_of_get_opp_desc_node(dev);
+	for_each_available_child_of_node(opp_table_np, np) {
+		ret = of_property_read_u64(np, "opp-hz", &rate);
+		if (ret)
+			continue;
+
+		dev_pm_opp_disable(dev, rate);
+	}
+	of_node_put(opp_table_np);
+
+	return 0;
+
+err:
+	for (; i >= 0; i--) {
+		if (table[i]) {
+			dev_pm_opp_put_opp_table(table[i]);
+			table[i] = NULL;
+		}
+	}
+
+	dev_pm_opp_remove_table(dev);
+	return ret;
+}
+
+static int qcom_cpufreq_hw_icc_init(struct qcom_cpufreq_hw_res *res, u8 index)
+{
+	const struct cpufreq_hw_icc_info *info = &icc_info[index];
+	struct icc_path **path = res->path;
+	struct device *dev = res->cpu_dev;
+
+	path[index] = of_icc_get(dev, info->icc_path_name);
+	if (IS_ERR(path[index])) {
+		dev_dbg(dev, "ICC %s path get failed ret: %ld\n",
+			info->icc_path_name, PTR_ERR(path[index]));
+		return PTR_ERR(path[index]);
+	}
+
+	icc_set_tag(path[index], info->tag);
+
+	return 0;
+}
+
+static void qcom_cpufreq_hw_icc_set(struct qcom_cpufreq_hw_res *res,
+				    unsigned long freq)
+{
+	struct opp_table **table = res->opp_table;
+	const struct cpufreq_hw_icc_info *info;
+	unsigned long freq_hz = freq * 1000;
+	struct icc_path **path = res->path;
+	struct device *dev = res->cpu_dev;
+	struct dev_pm_opp *cpu_opp, *opp;
+	struct opp_table *cpu_opp_table;
+	unsigned long peak_bw, avg_bw;
+	int ret;
+	int i;
+
+	cpu_opp_table = table[QCOM_CPU_OPP_TABLE_INDEX];
+	if (!cpu_opp_table)
+		return;
+
+	cpu_opp = dev_pm_opp_find_freq_exact(dev, freq_hz, true);
+	if (IS_ERR_OR_NULL(cpu_opp))
+		return;
+
+	for (i = 0; i <= ICC_L3_PATH; i++) {
+		if (IS_ERR(path[i])) {
+			if (PTR_ERR(path[i]) != -EPROBE_DEFER)
+				continue;
+
+			ret = qcom_cpufreq_hw_icc_init(res, i);
+			if (ret)
+				continue;
+		}
+
+		info = &icc_info[i];
+
+		opp = dev_pm_opp_xlate_required_opp(cpu_opp_table,
+						    table[info->table_index],
+						    cpu_opp);
+		if (IS_ERR_OR_NULL(opp))
+			continue;
+
+		peak_bw = dev_pm_opp_get_bw(opp, &avg_bw);
+		dev_pm_opp_put(opp);
+
+		icc_set_bw(res->path[i], avg_bw, peak_bw);
+	}
+	dev_pm_opp_put(cpu_opp);
+}
+
+static int qcom_cpufreq_update_opp(struct device *dev,
+				   unsigned long freq_khz,
+				   unsigned long volt)
+{
+	unsigned long freq_hz = freq_khz * 1000;
+
+	if (dev_pm_opp_update_voltage(dev, freq_hz, volt))
+		return dev_pm_opp_add(dev, freq_hz, volt);
+
+	/* Enable the opp after voltage update*/
+	return dev_pm_opp_enable(dev, freq_hz);
+}
+
 static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
-	void __iomem *perf_state_reg = policy->driver_data;
+	struct qcom_cpufreq_hw_res *res = policy->driver_data;
+	void __iomem *perf_state_reg = res->base + REG_PERF_STATE;
 	unsigned long freq = policy->freq_table[index].frequency;
 
 	writel_relaxed(index, perf_state_reg);
 
+	qcom_cpufreq_hw_icc_set(res, freq);
+
 	arch_set_freq_scale(policy->related_cpus, freq,
 			    policy->cpuinfo.max_freq);
 	return 0;
@@ -46,6 +224,7 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 
 static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 {
+	struct qcom_cpufreq_hw_res *res;
 	void __iomem *perf_state_reg;
 	struct cpufreq_policy *policy;
 	unsigned int index;
@@ -54,7 +233,8 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 	if (!policy)
 		return 0;
 
-	perf_state_reg = policy->driver_data;
+	res = policy->driver_data;
+	perf_state_reg = res->base + REG_PERF_STATE;
 
 	index = readl_relaxed(perf_state_reg);
 	index = min(index, LUT_MAX_ENTRIES - 1);
@@ -65,7 +245,8 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 						unsigned int target_freq)
 {
-	void __iomem *perf_state_reg = policy->driver_data;
+	struct qcom_cpufreq_hw_res *res = policy->driver_data;
+	void __iomem *perf_state_reg = res->base + REG_PERF_STATE;
 	int index;
 	unsigned long freq;
 
@@ -82,18 +263,24 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	return freq;
 }
 
-static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
-				    struct cpufreq_policy *policy,
-				    void __iomem *base)
+static int qcom_cpufreq_hw_read_lut(struct cpufreq_policy *policy,
+				    struct qcom_cpufreq_hw_res *res)
 {
 	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
 	u32 volt;
 	struct cpufreq_frequency_table	*table;
+	struct device *cpu_dev = res->cpu_dev;
+	void __iomem *base = res->base;
+	int ret;
 
 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
+	ret = qcom_cpufreq_hw_add_opp_table(res);
+	if (ret)
+		dev_dbg(cpu_dev, "Add OPP tables failed from dt\n");
+
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
 		data = readl_relaxed(base + REG_FREQ_LUT +
 				      i * LUT_ROW_SIZE);
@@ -112,7 +299,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 
 		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
 			table[i].frequency = freq;
-			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
+			qcom_cpufreq_update_opp(cpu_dev, freq, volt);
 			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
 		} else if (core_count == LUT_TURBO_IND) {
@@ -133,7 +320,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
 				prev->frequency = prev_freq;
 				prev->flags = CPUFREQ_BOOST_FREQ;
-				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
+				qcom_cpufreq_update_opp(cpu_dev, prev_freq,
+							volt);
 			}
 
 			break;
@@ -175,11 +363,10 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct device *dev = &global_pdev->dev;
+	struct qcom_cpufreq_hw_res *res;
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
 	struct device *cpu_dev;
-	struct resource *res;
-	void __iomem *base;
 	int ret, index;
 
 	cpu_dev = get_cpu_device(policy->cpu);
@@ -201,16 +388,17 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	index = args.args[0];
 
-	res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
+	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
 	if (!res)
-		return -ENODEV;
-
-	base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!base)
 		return -ENOMEM;
 
+	res->cpu_dev = cpu_dev;
+	res->base = devm_platform_ioremap_resource(global_pdev, index);
+	if (IS_ERR(res->base))
+		return PTR_ERR(res->base);
+
 	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
+	if (!(readl_relaxed(res->base + REG_ENABLE) & 0x1)) {
 		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
 		ret = -ENODEV;
 		goto error;
@@ -223,9 +411,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
-	policy->driver_data = base + REG_PERF_STATE;
+	policy->driver_data = res;
 
-	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy, base);
+	ret = qcom_cpufreq_hw_read_lut(policy, res);
 	if (ret) {
 		dev_err(dev, "Domain-%d failed to read LUT\n", index);
 		goto error;
@@ -240,22 +428,38 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	dev_pm_opp_of_register_em(policy->cpus);
 
-	policy->fast_switch_possible = true;
+	if (!res->opp_table[QCOM_CPU_OPP_TABLE_INDEX]) {
+		policy->fast_switch_possible = true;
+	} else {
+		qcom_cpufreq_hw_icc_init(res, ICC_DDR_PATH);
+		qcom_cpufreq_hw_icc_init(res, ICC_L3_PATH);
+	}
 
 	return 0;
 error:
-	devm_iounmap(dev, base);
+	devm_iounmap(dev, res->base);
+	devm_kfree(&global_pdev->dev, res);
 	return ret;
 }
 
 static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
+	struct qcom_cpufreq_hw_res *res = policy->driver_data;
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	void __iomem *base = policy->driver_data - REG_PERF_STATE;
+	struct opp_table **table = res->opp_table;
+	void __iomem *base = res->base;
+	int i;
+
+	for (i = 0; i <= QCOM_CPU_L3_OPP_TABLE_INDEX; i++) {
+		if (table[i])
+			dev_pm_opp_put_opp_table(table[i]);
+	}
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	kfree(policy->freq_table);
+	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	devm_iounmap(&global_pdev->dev, base);
+	devm_kfree(&global_pdev->dev, res);
 
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
