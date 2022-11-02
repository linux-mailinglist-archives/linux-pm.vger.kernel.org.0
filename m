Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61BC615E97
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 10:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKBJBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 05:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKBJBF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 05:01:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E43F27FE3
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 02:01:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g129so15682971pgc.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4icR5rrMlbnmLSHVx88xxoNFuB2MV+Zjs91Y6tbEUk=;
        b=T3DvZJsHZQjtgjAfTE2nvPaLd85CAsBY3bscddRny4i4YWvOojadfu4TA/gt/y5hDJ
         2JAGp1hiMC8XAeBX46ZCS/DX9I0alyp/MUMQ2BkEwju/H08shAbCbeBvdmBQdFrWvSXq
         MQM/MNk4FYMIyul/6O81kRim/29Mg8TJfxCSABiwdJcdJEHotr8MKUTrNOSchk9SRLA2
         QhCau9l2m5o0LvlGr2thRST3AyqFxRymIbhQ75aUuaoUWQkRaB2FWZO1m772f5D/ABYT
         XODCWnMZWehX1PMj66+E29f3ilcOmQZjO9TrJGPL10/5NCaijK+xbLLcF0kgrlhvVhzh
         PKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4icR5rrMlbnmLSHVx88xxoNFuB2MV+Zjs91Y6tbEUk=;
        b=A8C+3D63VlR19zjHd1mgk/9Nty0z+x8oKZrkeiy2BoYFiWwXMLFEZMmTkcQO3L4NWV
         hdROsvcYO8RYBv01I2kY/BH6zAezB0PL9B22fu0NqcTJamqA1RVshEQ8Y5xmjnmnNdsQ
         A5R8CrhGrViPEFnG0tcqQyNdTxmVMWbVja4lC+gJM73MSe4AaKA1OvwmC1KKnSq/Fzla
         QTNLRy5o4VzC40QH7v5v9BFv2qJM5A6wtpkJxVVzQShmYgQjygRZM7pq+r07dGlkn9sR
         OjExo8/ptuDPT4xBEMSKzlJud+FRQ/ee/1F4mYnlFvOCXOFzhUcly1ftS9k+Q7jAJh91
         IDEQ==
X-Gm-Message-State: ACrzQf2ehJNdY9dCKYPG7HQuq1Ny1mmJJnCnpkqLlkVT0H3UjsUlko+S
        8SYgeQNMWvL7VQklEma7ewxW
X-Google-Smtp-Source: AMsMyM4bole62R9yeNLFEehA28dZezHCL/oEoRoe34yyJGkBuzWTtYXYAGeuag/0C+/d9BaGOG63QQ==
X-Received: by 2002:a63:4f4c:0:b0:46f:c464:9f66 with SMTP id p12-20020a634f4c000000b0046fc4649f66mr12163079pgl.247.1667379660027;
        Wed, 02 Nov 2022 02:01:00 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id z10-20020a63d00a000000b0046f7b0f504esm7136389pgf.58.2022.11.02.02.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:00:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] cpufreq: qcom-hw: Use cached dev pointer in probe()
Date:   Wed,  2 Nov 2022 14:30:37 +0530
Message-Id: <20221102090038.64541-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102090038.64541-1-manivannan.sadhasivam@linaro.org>
References: <20221102090038.64541-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are multiple instances of dev pointer used in the probe() function.
Instead of referencing pdev->dev all the time, let's use a cached dev
pointer to simplify the code.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 25951a32b9d5..6d807956aaf6 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -618,18 +618,19 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device *cpu_dev;
 	struct clk *clk;
 	int ret, i, num_domains;
 
-	clk = clk_get(&pdev->dev, "xo");
+	clk = clk_get(dev, "xo");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
 	xo_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	clk = clk_get(&pdev->dev, "alternate");
+	clk = clk_get(dev, "alternate");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -648,11 +649,11 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Allocate qcom_cpufreq_data based on the available frequency domains in DT */
-	num_domains = of_property_count_elems_of_size(pdev->dev.of_node, "reg", sizeof(u32) * 4);
+	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * 4);
 	if (num_domains <= 0)
 		return num_domains;
 
-	qcom_cpufreq.data = devm_kzalloc(&pdev->dev, sizeof(struct qcom_cpufreq_data) * num_domains,
+	qcom_cpufreq.data = devm_kzalloc(dev, sizeof(struct qcom_cpufreq_data) * num_domains,
 					 GFP_KERNEL);
 	if (!qcom_cpufreq.data)
 		return -ENOMEM;
@@ -664,7 +665,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 		base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
 		if (IS_ERR(base)) {
-			dev_err(&pdev->dev, "Failed to map resource %pR\n", res);
+			dev_err(dev, "Failed to map resource %pR\n", res);
 			return PTR_ERR(base);
 		}
 
@@ -674,9 +675,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret)
-		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
+		dev_err(dev, "CPUFreq HW driver failed to register\n");
 	else
-		dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
+		dev_dbg(dev, "QCOM CPUFreq HW driver initialized\n");
 
 	return ret;
 }
-- 
2.25.1

