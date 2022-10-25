Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6660C54C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJYHeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 03:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiJYHda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 03:33:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0102158D50
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 00:33:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so11128223pjl.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2nlS3XahONFZFIAHmPH/AavNAlCb2gKg69yTobdo08=;
        b=QCY1FpXs5WO6Zoq7B22DvZ1pZWwGCMuIxC+78tY69RBgPRC5LFHcu6q4WjcR4WPFlK
         t7kpFICtt4+YWJQwpBeWdZyX8VO73OnZMcX8VrQkKPkQe2JBNZuaaynnW6uMZ6IEV8WV
         E6kTvCg8jJreqbNhu5EXq92YSS0A8RBVWMvG9L2Q/k/+VE6M60+xRcEE6qYGT12oI7Sl
         GAwi0ZobnHBmv1QbZacs9IEUCTJY+sH0W50YGlg8okH9nQX2LxFMh2mve91qUDqIWXgg
         LLoaJTA0usHfCwDgaabp+9U4kjGhNhT27EtF3liLMnuyCab9tlaSN7mmam3XDqmRv8EU
         ZV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2nlS3XahONFZFIAHmPH/AavNAlCb2gKg69yTobdo08=;
        b=c6KGko/UBrrQlNy6CHhBEMMaBzFspUPQfo+IG0HdN4ualTlQKV8hutIEnYOqX90tOy
         wA7jTDkMv0jUA/QBkzNGZVipANeit0NkOOYOkXi/mppEfc9nn76+6LwXfliu+AFjGxR9
         TK9qDSM75mhO2QeCzEdJ61oaenakLWffcZS9+r2gbJkI/fPasjS57i1DZ9cKSI4DjeF1
         0ylPd9P4mjqnI1CnfrzR1q68YErNEYlQqmna460aB7WSm8OGY7BvU6bOTWFnVcXFgV73
         faj9GmamUYcGg1RRF2ulLFzFHevBVnDRJb3Y4+sJ+4ys8LuBDryaxs4poPaYenxa4YlA
         +S5A==
X-Gm-Message-State: ACrzQf2aK21YFx7mZcwljWtH9yDxpyr+3P+ZV/Tr5p29TlTKZQAESeAY
        IunpczmG7zpNmvnMzwx3ghQB
X-Google-Smtp-Source: AMsMyM6Lyxu4C8r07ItG9E0ag22O+BWY2awNjYOtomIMytiks/zHPyHKsDZcism4d8QEdth6YnFgdg==
X-Received: by 2002:a17:902:7c97:b0:17f:5abf:9450 with SMTP id y23-20020a1709027c9700b0017f5abf9450mr36016087pll.19.1666683209309;
        Tue, 25 Oct 2022 00:33:29 -0700 (PDT)
Received: from localhost.localdomain ([117.193.211.146])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a4d0100b0020dda7efe61sm5048369pjg.5.2022.10.25.00.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:33:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/7] cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
Date:   Tue, 25 Oct 2022 13:02:51 +0530
Message-Id: <20221025073254.1564622-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
References: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

qcom_cpufreq_data is allocated based on the number of frequency domains
defined in DT which is static and won't change during runtime. There is
no real reason to allocate it during the CPU init() callback and deallocate
it during exit(). Hence, move the allocation to probe() and use the
allocated memory during init().

This also allows us to use devm_platform_get_and_ioremap_resource() helper
for acquiring the freq-domain resources from DT.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 86 +++++++++++++------------------
 1 file changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a5b3b8d0e164..1842e9facaa1 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -58,6 +58,10 @@ struct qcom_cpufreq_data {
 	bool per_core_dcvs;
 };
 
+static struct {
+	struct qcom_cpufreq_data *data;
+} qcom_cpufreq;
+
 static unsigned long cpu_hw_rate, xo_rate;
 static bool icc_scaling_enabled;
 
@@ -489,8 +493,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
 	struct device *cpu_dev;
-	struct resource *res;
-	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	int ret, index;
 
@@ -512,43 +514,16 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 
 	index = args.args[0];
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	if (!res) {
-		dev_err(dev, "failed to get mem resource %d\n", index);
-		return -ENODEV;
-	}
-
-	if (!request_mem_region(res->start, resource_size(res), res->name)) {
-		dev_err(dev, "failed to request resource %pR\n", res);
-		return -EBUSY;
-	}
-
-	base = ioremap(res->start, resource_size(res));
-	if (!base) {
-		dev_err(dev, "failed to map resource %pR\n", res);
-		ret = -ENOMEM;
-		goto release_region;
-	}
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto unmap_base;
-	}
-
 	data->soc_data = of_device_get_match_data(&pdev->dev);
-	data->base = base;
-	data->res = res;
+	data = &qcom_cpufreq.data[index];
 
 	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
+	if (!(readl_relaxed(data->base + data->soc_data->reg_enable) & 0x1)) {
 		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
-		ret = -ENODEV;
-		goto error;
+		return -ENODEV;
 	}
 
-	if (readl_relaxed(base + data->soc_data->reg_dcvs_ctrl) & 0x1)
+	if (readl_relaxed(data->base + data->soc_data->reg_dcvs_ctrl) & 0x1)
 		data->per_core_dcvs = true;
 
 	qcom_get_related_cpus(index, policy->cpus);
@@ -559,14 +534,13 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
 		dev_err(dev, "Domain-%d failed to read LUT\n", index);
-		goto error;
+		return ret;
 	}
 
 	ret = dev_pm_opp_get_opp_count(cpu_dev);
 	if (ret <= 0) {
 		dev_err(cpu_dev, "Failed to add OPPs\n");
-		ret = -ENODEV;
-		goto error;
+		return -ENODEV;
 	}
 
 	if (policy_has_boost_freq(policy)) {
@@ -575,18 +549,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
 	}
 
-	ret = qcom_cpufreq_hw_lmh_init(policy, index);
-	if (ret)
-		goto error;
-
-	return 0;
-error:
-	kfree(data);
-unmap_base:
-	iounmap(base);
-release_region:
-	release_mem_region(res->start, resource_size(res));
-	return ret;
+	return qcom_cpufreq_hw_lmh_init(policy, index);
 }
 
 static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
@@ -643,7 +606,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
 	struct device *cpu_dev;
 	struct clk *clk;
-	int ret;
+	int ret, i, num_domains;
 
 	clk = clk_get(&pdev->dev, "xo");
 	if (IS_ERR(clk))
@@ -670,6 +633,31 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Allocate qcom_cpufreq_data based on the available frequency domains in DT */
+	num_domains = of_property_count_elems_of_size(pdev->dev.of_node, "reg", sizeof(u32) * 4);
+	if (num_domains <= 0)
+		return num_domains;
+
+	qcom_cpufreq.data = devm_kzalloc(&pdev->dev, sizeof(struct qcom_cpufreq_data) * num_domains,
+					 GFP_KERNEL);
+	if (!qcom_cpufreq.data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_domains; i++) {
+		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
+		struct resource *res;
+		void __iomem *base;
+
+		base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
+		if (IS_ERR(base)) {
+			dev_err(&pdev->dev, "Failed to map resource %pR\n", res);
+			return PTR_ERR(base);
+		}
+
+		data->base = base;
+		data->res = res;
+	}
+
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret)
 		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
-- 
2.25.1

