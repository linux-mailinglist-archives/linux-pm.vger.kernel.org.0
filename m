Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B9260CF9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 10:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgIHIE4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgIHH5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 03:57:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E42C061756
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 00:57:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o68so10303060pfg.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cDupOEGD43zOafkeHwpXvRZFRBLRl6C9wgjA2f07/F0=;
        b=QQYLtPYQds66Aq5sAInDKeb1drvHJt9XVWKwoRjvuCeNkRGx5+rFQiX+dSbfnvmPUQ
         +EdJT883lIKsSbWKYABvFjZ5eK7DhOsF540AZTY3Lh/sCCiSuQ5sE9f71hfSjND1BrYb
         /fRUds+4A7kgOKaPGN6xeDdnBeDpzTIyfwwEuN19BFcyhxX492wBYzXnibWeszqb+k/M
         xNi0n0FYMAm/2j9zF4nudmkX9Ae3RxGQgX62hcWZScGUwk3kY39muYL1NykdmwhEU0cM
         gPvxnLyYSeo9NrzD5eMpuSoYDDRkruY7GDkUxtEyfX7IthGRRkpmCCbiufQhWithfewm
         briw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cDupOEGD43zOafkeHwpXvRZFRBLRl6C9wgjA2f07/F0=;
        b=JF4BQf22Hg2SyyMOSBAj0Uh4/DCJ9D19epd9xxIO34fbw3sAUq5TsGSyzAcsMcN5GF
         gwh4K8WdjcUlTKKQzG8YPdKUtlYmJQIquBeSm/2/2D/UoXONGlyDk1FK+Gc70erIyc3E
         3jCmkez5+OvXPWfPfcF/wxIaKkj2Ob+0IH/eDAdL/C7F4fYKUjOmEx1M2bgKeWi+Vpmt
         dLB5fVTsVAmFFT19+j1vyJmIEeo01nCLRSREGItc1alX/qW593Z6ByAKuAEsilpnKOv7
         eGnbKMHC0io50jHlMbLnr8DPb2SRhN1vl5xKmFloX1CkQaT8WQaf19z6S7ctCIgkWqRz
         U5+w==
X-Gm-Message-State: AOAM530mZVb3cMt5a6js08U498Z78MaJy08T+i2HMKP7cC5oYsvzX0N2
        V90KIMIaX3VBRVnWEJDVey39
X-Google-Smtp-Source: ABdhPJxpx0HbYrcj8hGngV6Luqv87IDIEB9wAwcFjrONlar2oFhO8UsTm9X+3KW73Kg2fmgjpV0GGg==
X-Received: by 2002:a63:9d82:: with SMTP id i124mr19186323pgd.336.1599551870736;
        Tue, 08 Sep 2020 00:57:50 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m21sm7560154pfo.13.2020.09.08.00.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:50 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/7] cpufreq: qcom-hw: Use regmap for accessing hardware registers
Date:   Tue,  8 Sep 2020 13:27:14 +0530
Message-Id: <20200908075716.30357-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use regmap for accessing cpufreq registers in hardware.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 55 ++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 41853db7c9b8..de816bcafd33 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -12,6 +12,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #define LUT_MAX_ENTRIES			40U
@@ -32,6 +33,7 @@ struct qcom_cpufreq_soc_data {
 
 struct qcom_cpufreq_data {
 	void __iomem *base;
+	struct regmap *regmap;
 	const struct qcom_cpufreq_soc_data *soc_data;
 };
 
@@ -85,8 +87,11 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 	struct qcom_cpufreq_data *data = policy->driver_data;
 	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
 	unsigned long freq = policy->freq_table[index].frequency;
+	int ret;
 
-	writel_relaxed(index, data->base + soc_data->reg_perf_state);
+	ret = regmap_write(data->regmap, soc_data->reg_perf_state, index);
+	if (ret)
+		return ret;
 
 	if (icc_scaling_enabled)
 		qcom_cpufreq_set_bw(policy, freq);
@@ -102,6 +107,7 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 	const struct qcom_cpufreq_soc_data *soc_data;
 	struct cpufreq_policy *policy;
 	unsigned int index;
+	int ret;
 
 	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy)
@@ -110,7 +116,10 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 	data = policy->driver_data;
 	soc_data = data->soc_data;
 
-	index = readl_relaxed(data->base + soc_data->reg_perf_state);
+	ret = regmap_read(data->regmap, soc_data->reg_perf_state, &index);
+	if (ret)
+		return 0;
+
 	index = min(index, LUT_MAX_ENTRIES - 1);
 
 	return policy->freq_table[index].frequency;
@@ -123,9 +132,12 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
 	unsigned int index;
 	unsigned long freq;
+	int ret;
 
 	index = policy->cached_resolved_idx;
-	writel_relaxed(index, data->base + soc_data->reg_perf_state);
+	ret = regmap_write(data->regmap, soc_data->reg_perf_state, index);
+	if (ret)
+		return 0;
 
 	freq = policy->freq_table[index].frequency;
 	arch_set_freq_scale(policy->related_cpus, freq,
@@ -171,14 +183,24 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	}
 
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		data = readl_relaxed(drv_data->base + soc_data->reg_freq_lut +
-				      i * soc_data->lut_row_size);
+		ret = regmap_read(drv_data->regmap, soc_data->reg_freq_lut +
+				  i * soc_data->lut_row_size, &data);
+		if (ret) {
+			kfree(table);
+			return ret;
+		}
+
 		src = FIELD_GET(LUT_SRC, data);
 		lval = FIELD_GET(LUT_L_VAL, data);
 		core_count = FIELD_GET(LUT_CORE_COUNT, data);
 
-		data = readl_relaxed(drv_data->base + soc_data->reg_volt_lut +
-				      i * soc_data->lut_row_size);
+		ret = regmap_read(drv_data->regmap, soc_data->reg_volt_lut +
+				  i * soc_data->lut_row_size, &data);
+		if (ret) {
+			kfree(table);
+			return ret;
+		}
+
 		volt = FIELD_GET(LUT_VOLT, data) * 1000;
 
 		if (src)
@@ -248,6 +270,13 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	}
 }
 
+static struct regmap_config qcom_cpufreq_regmap = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
 static const struct qcom_cpufreq_soc_data qcom_soc_data = {
 	.reg_enable = 0x0,
 	.reg_freq_lut = 0x110,
@@ -274,6 +303,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct qcom_cpufreq_data *data;
 	const struct of_device_id *match;
 	int ret, index;
+	u32 val;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -316,9 +346,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	data->soc_data = match->data;
 	data->base = base;
+	data->regmap = devm_regmap_init_mmio(dev, base, &qcom_cpufreq_regmap);
+	if (IS_ERR(data->regmap)) {
+		ret = PTR_ERR(data->regmap);
+		goto error;
+	}
 
 	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
+	ret = regmap_read(data->regmap, data->soc_data->reg_enable, &val);
+	if (ret)
+		goto error;
+
+	if (!(val & 0x1)) {
 		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
 		ret = -ENODEV;
 		goto error;
-- 
2.17.1

