Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60B4260CFE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 10:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgIHIFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 04:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgIHH5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 03:57:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805AC06179F
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 00:57:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so4381483pjr.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XkY35dYrfb6kOY3/88nogNoAnqOtGqrRAgNhymlgIOc=;
        b=KL4F4iYiPVO8zYGsV53nzzW3wAnE6+mD/hPz1aCpZMxNkl9LT7joVcBmfLydjDfwuk
         ewqMgvr84ont/Um1Xe7/DBqs7r3VsKBymXRhEz3rhuPAjjDxSBvEQj97W1fkBJt+L7Rh
         F4yCa/LfZHDgUBbfZerjVDnAanAthDaE0GG4ILXxqE+TwxgNnvQ0pPXNWDBCzRNsEPcO
         Ad4CHHK4VpEZOln903EfW1EoCTkOFCauwFMKYnAxx2hvj1orw+g9cWIS4AQSp8D93YZa
         BZEijpTSl34Q6XVe6nIBhgJgZckKuTNNYKDudqGQlmLBZpyCKA52q/BO32IITJ1SAYMA
         3tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XkY35dYrfb6kOY3/88nogNoAnqOtGqrRAgNhymlgIOc=;
        b=GMerdwks9+bYkyX7Ge6vt8N71Ka78uTiHodPc4GKNm7PEQwYEiWZpgvJXHQbVY7Bcu
         q9D00Fii/LHvEVWHMMH37ar4Wf/PyE09Dtz04yZ2Dgvez1yHrO90+txQwbynxC3Tcd6D
         aPQJKSlXR10UCoyiUqht+kyUwWlgCgv8XlkBeW7g/oPcTN5FzOoylt42p6/V0A/Ouf00
         lHNr6GrcqruH3+fGexkPGdYuYGPQQtt44oOSKEm8eATIl/4duuOfpq36LcK40fd5PIfC
         SPN5B9N6yYohTWDxamfXawOsURCXYDviL8zH0ZMlSopMWiXb8MDAS5Xvt4azjiUKrtYa
         w4+Q==
X-Gm-Message-State: AOAM531iUwQJoWYmMuy4X+gQI2/hDs/nIceirr7KaiUG1IkszjsuJJyY
        YxHLMNo8/dyURhCF68n/wXjd
X-Google-Smtp-Source: ABdhPJzoL6xgZpy7qccHwCFbxhiqeJtcBbXsP9Wy6yhYSm1lpRUSY5131L2eoIVQvaf21oHgKiWeyQ==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr2758683pjq.95.1599551866724;
        Tue, 08 Sep 2020 00:57:46 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m21sm7560154pfo.13.2020.09.08.00.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/7] cpufreq: qcom-hw: Make use of of_match data for offsets and row size
Date:   Tue,  8 Sep 2020 13:27:13 +0530
Message-Id: <20200908075716.30357-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For preparing the driver to handle further SoC revisions, let's use the
of_match data for getting the device specific offsets and row size instead
of defining them globally.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 96 +++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index ccea34f61152..41853db7c9b8 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -19,15 +19,21 @@
 #define LUT_L_VAL			GENMASK(7, 0)
 #define LUT_CORE_COUNT			GENMASK(18, 16)
 #define LUT_VOLT			GENMASK(11, 0)
-#define LUT_ROW_SIZE			32
 #define CLK_HW_DIV			2
 #define LUT_TURBO_IND			1
 
-/* Register offsets */
-#define REG_ENABLE			0x0
-#define REG_FREQ_LUT			0x110
-#define REG_VOLT_LUT			0x114
-#define REG_PERF_STATE			0x920
+struct qcom_cpufreq_soc_data {
+	u32 reg_enable;
+	u32 reg_freq_lut;
+	u32 reg_volt_lut;
+	u32 reg_perf_state;
+	u8 lut_row_size;
+};
+
+struct qcom_cpufreq_data {
+	void __iomem *base;
+	const struct qcom_cpufreq_soc_data *soc_data;
+};
 
 static unsigned long cpu_hw_rate, xo_rate;
 static bool icc_scaling_enabled;
@@ -76,10 +82,11 @@ static int qcom_cpufreq_update_opp(struct device *cpu_dev,
 static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
-	void __iomem *perf_state_reg = policy->driver_data;
+	struct qcom_cpufreq_data *data = policy->driver_data;
+	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
 	unsigned long freq = policy->freq_table[index].frequency;
 
-	writel_relaxed(index, perf_state_reg);
+	writel_relaxed(index, data->base + soc_data->reg_perf_state);
 
 	if (icc_scaling_enabled)
 		qcom_cpufreq_set_bw(policy, freq);
@@ -91,7 +98,8 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 
 static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 {
-	void __iomem *perf_state_reg;
+	struct qcom_cpufreq_data *data;
+	const struct qcom_cpufreq_soc_data *soc_data;
 	struct cpufreq_policy *policy;
 	unsigned int index;
 
@@ -99,9 +107,10 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 	if (!policy)
 		return 0;
 
-	perf_state_reg = policy->driver_data;
+	data = policy->driver_data;
+	soc_data = data->soc_data;
 
-	index = readl_relaxed(perf_state_reg);
+	index = readl_relaxed(data->base + soc_data->reg_perf_state);
 	index = min(index, LUT_MAX_ENTRIES - 1);
 
 	return policy->freq_table[index].frequency;
@@ -110,12 +119,13 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 						unsigned int target_freq)
 {
-	void __iomem *perf_state_reg = policy->driver_data;
+	struct qcom_cpufreq_data *data = policy->driver_data;
+	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
 	unsigned int index;
 	unsigned long freq;
 
 	index = policy->cached_resolved_idx;
-	writel_relaxed(index, perf_state_reg);
+	writel_relaxed(index, data->base + soc_data->reg_perf_state);
 
 	freq = policy->freq_table[index].frequency;
 	arch_set_freq_scale(policy->related_cpus, freq,
@@ -125,8 +135,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 }
 
 static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
-				    struct cpufreq_policy *policy,
-				    void __iomem *base)
+				    struct cpufreq_policy *policy)
 {
 	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
 	u32 volt;
@@ -134,6 +143,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	struct dev_pm_opp *opp;
 	unsigned long rate;
 	int ret;
+	struct qcom_cpufreq_data *drv_data = policy->driver_data;
+	const struct qcom_cpufreq_soc_data *soc_data = drv_data->soc_data;
 
 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
@@ -160,14 +171,14 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	}
 
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		data = readl_relaxed(base + REG_FREQ_LUT +
-				      i * LUT_ROW_SIZE);
+		data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
+				      i * soc_data->lut_row_size);
 		src = FIELD_GET(LUT_SRC, data);
 		lval = FIELD_GET(LUT_L_VAL, data);
 		core_count = FIELD_GET(LUT_CORE_COUNT, data);
 
-		data = readl_relaxed(base + REG_VOLT_LUT +
-				      i * LUT_ROW_SIZE);
+		data = readl_relaxed(drv_data->base + soc_data->reg_volt_lut +
+				      i * soc_data->lut_row_size);
 		volt = FIELD_GET(LUT_VOLT, data) * 1000;
 
 		if (src)
@@ -237,6 +248,20 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	}
 }
 
+static const struct qcom_cpufreq_soc_data qcom_soc_data = {
+	.reg_enable = 0x0,
+	.reg_freq_lut = 0x110,
+	.reg_volt_lut = 0x114,
+	.reg_perf_state = 0x920,
+	.lut_row_size = 32,
+};
+
+static const struct of_device_id qcom_cpufreq_hw_match[] = {
+	{ .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
+
 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -246,6 +271,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct resource *res;
 	void __iomem *base;
+	struct qcom_cpufreq_data *data;
+	const struct of_device_id *match;
 	int ret, index;
 
 	cpu_dev = get_cpu_device(policy->cpu);
@@ -275,8 +302,23 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	if (!base)
 		return -ENOMEM;
 
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	match = of_match_device(qcom_cpufreq_hw_match, &pdev->dev);
+	if (!match) {
+		ret = -ENODEV;
+		goto error;
+	}
+
+	data->soc_data = match->data;
+	data->base = base;
+
 	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
+	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
 		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
 		ret = -ENODEV;
 		goto error;
@@ -289,9 +331,9 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		goto error;
 	}
 
-	policy->driver_data = base + REG_PERF_STATE;
+	policy->driver_data = data;
 
-	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy, base);
+	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
 		dev_err(dev, "Domain-%d failed to read LUT\n", index);
 		goto error;
@@ -315,13 +357,13 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	void __iomem *base = policy->driver_data - REG_PERF_STATE;
+	struct qcom_cpufreq_data *data = policy->driver_data;
 	struct platform_device *pdev = cpufreq_get_driver_data();
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	kfree(policy->freq_table);
-	devm_iounmap(&pdev->dev, base);
+	devm_iounmap(&pdev->dev, data->base);
 
 	return 0;
 }
@@ -391,12 +433,6 @@ static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
 	return cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
 }
 
-static const struct of_device_id qcom_cpufreq_hw_match[] = {
-	{ .compatible = "qcom,cpufreq-hw" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
-
 static struct platform_driver qcom_cpufreq_hw_driver = {
 	.probe = qcom_cpufreq_hw_driver_probe,
 	.remove = qcom_cpufreq_hw_driver_remove,
-- 
2.17.1

