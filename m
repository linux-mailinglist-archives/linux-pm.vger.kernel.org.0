Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C603C1C4807
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEDUYj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:24:39 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:51515 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727911AbgEDUYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:24:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588623878; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=f3fnVP2eTuTvZIhUofcog6FkJ9NCRpXs7tEgTvSb670=; b=LLShVk4R9CAxIxDIlBbjtrWgdPNp8EmksOxYl10VZ2OSbNl+h7VRsyUSXyYJMoAlP3BTNuxn
 Xa5Z4FyveAoiPoeR8Gm3oC5+YHp4uOlgzcWJmVGc1M6tff3GgHPjVlfAAzb4ejMd/VRdNHJt
 8wHsw7RtgJxsjPtLgOBbkHSTVgA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb07a04.7f97a59c5420-smtp-out-n03;
 Mon, 04 May 2020 20:24:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1CB3BC58A2E; Mon,  4 May 2020 20:24:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BAEEC44793;
        Mon,  4 May 2020 20:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BAEEC44793
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 06/12] cpufreq: qcom: Update the bandwidth levels on frequency change
Date:   Tue,  5 May 2020 01:52:37 +0530
Message-Id: <20200504202243.5476-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200504202243.5476-1-sibis@codeaurora.org>
References: <20200504202243.5476-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support to parse optional OPP table attached to the cpu node when
the OPP bandwidth values are populated. This allows for scaling of
DDR/L3 bandwidth levels with frequency change.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v4:
 * Split fast switch disable into another patch [Lukasz]

 drivers/cpufreq/qcom-cpufreq-hw.c | 85 ++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index fc92a8842e252..4fb489b69bc61 100644
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
@@ -31,6 +32,63 @@
 static unsigned long cpu_hw_rate, xo_rate;
 static struct platform_device *global_pdev;
 
+static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
+			       unsigned long freq_khz)
+{
+	unsigned long freq_hz = freq_khz * 1000;
+	struct dev_pm_opp *opp;
+	struct device *dev;
+	int ret;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		return -ENODEV;
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq_hz, true);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	ret = dev_pm_opp_set_bw(dev, opp);
+	dev_pm_opp_put(opp);
+	return ret;
+}
+
+static int qcom_cpufreq_update_opp(struct device *cpu_dev,
+				   unsigned long freq_khz,
+				   unsigned long volt)
+{
+	unsigned long freq_hz = freq_khz * 1000;
+
+	if (dev_pm_opp_update_voltage(cpu_dev, freq_hz, volt))
+		return dev_pm_opp_add(cpu_dev, freq_hz, volt);
+
+	/* Enable the opp after voltage update*/
+	return dev_pm_opp_enable(cpu_dev, freq_hz);
+}
+
+/* Check for optional interconnect paths on CPU0 */
+static int qcom_cpufreq_verify_icc_paths(struct device *dev)
+{
+	struct device *cpu_dev;
+	struct icc_path *path;
+	int ret;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -EPROBE_DEFER;
+
+	path = of_icc_get(cpu_dev, NULL);
+	ret = PTR_ERR_OR_ZERO(path);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(cpu_dev, "Failed to get paths ddr/l3 scaling off\n");
+		return ret;
+	}
+
+	icc_put(path);
+	return ret;
+}
+
 static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
@@ -39,6 +97,8 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 
 	writel_relaxed(index, perf_state_reg);
 
+	qcom_cpufreq_set_bw(policy, freq);
+
 	arch_set_freq_scale(policy->related_cpus, freq,
 			    policy->cpuinfo.max_freq);
 	return 0;
@@ -88,12 +148,27 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 {
 	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
 	u32 volt;
+	u64 rate;
 	struct cpufreq_frequency_table	*table;
+	struct device_node *opp_table_np, *np;
+	int ret;
 
 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
+	ret = dev_pm_opp_of_add_table(cpu_dev);
+	if (!ret) {
+		/* Disable all opps and cross-validate against LUT */
+		opp_table_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+		for_each_available_child_of_node(opp_table_np, np) {
+			ret = of_property_read_u64(np, "opp-hz", &rate);
+			if (!ret)
+				dev_pm_opp_disable(cpu_dev, rate);
+		}
+		of_node_put(opp_table_np);
+	}
+
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
 		data = readl_relaxed(base + REG_FREQ_LUT +
 				      i * LUT_ROW_SIZE);
@@ -112,7 +187,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 
 		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
 			table[i].frequency = freq;
-			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
+			qcom_cpufreq_update_opp(cpu_dev, freq, volt);
 			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
 				freq, core_count);
 		} else if (core_count == LUT_TURBO_IND) {
@@ -133,7 +208,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
 				prev->frequency = prev_freq;
 				prev->flags = CPUFREQ_BOOST_FREQ;
-				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
+				qcom_cpufreq_update_opp(cpu_dev, prev_freq,
+							volt);
 			}
 
 			break;
@@ -254,6 +330,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	void __iomem *base = policy->driver_data - REG_PERF_STATE;
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	kfree(policy->freq_table);
 	devm_iounmap(&global_pdev->dev, base);
 
@@ -301,6 +378,10 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	global_pdev = pdev;
 
+	ret = qcom_cpufreq_verify_icc_paths(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret)
 		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
