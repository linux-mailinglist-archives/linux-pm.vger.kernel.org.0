Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8044E7B8C
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 01:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiCYT65 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Mar 2022 15:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiCYT6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2022 15:58:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFEE2A85D2
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2022 12:47:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k21so15084026lfe.4
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2022 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+XCrIAyYDkgTz/DidtvlvSnQAA1xIZjhXOzszg4D7hE=;
        b=LWLdyTFOysWxnISbdMfivzdBiq60M9batOrhdLOhC/InTOG2+CZdk4u1OjaMU9xGvH
         iz6Gr2eXihj0g1qKzo5uPcH2pmlXA9ltmWyFoyCIyX6KBHWUe9/5BLPxbDSH+xPzH+RH
         UvIY6fPdYvCpQJVMYCaQYAWzgyufPD3XUVbfKcc0xaf6h8Yic7SeBst2XqokzRgRpdv4
         D1Pf1BbrDwK7BRytlK2SGW5sdXUhvISN/hZSO6mzQ+Ck4NS4pHrQkS7Kz7ER+5fo7To9
         /RlQ/dXVRAre4O8EsydhSljZGI97fMHEgHsClu7MgBmitSEsnbPpYTC8I4XY3MKKgKk6
         b7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XCrIAyYDkgTz/DidtvlvSnQAA1xIZjhXOzszg4D7hE=;
        b=AxdOOQuqQ5pUX6RzJLzUNeg/4boIzMjj4A6oEy5wr09xumyYw/xW4Hqdrx3ndQItqY
         5+cK+4TOi0wVX5Rn2H2Oc/xto/S97U1PKmBa9/nYfyKUWtQckgORT16mXIeu2ltge9pO
         aUFP86cyibDew2CmwQdU9IrB9DT/8TRguuhdbIhdKbLoiJgVX5H7UHQa5hiz41S0P3hx
         DkbCVlVWqOybRo5SnutRBTuW4tDXsNVozhQqhpikthwsx+VBJ/SRhJ2oDRxSN84xV5yy
         hUUBQmlSN7l7INOqXi6yOP8O1c/YXZbOrc4sR+UivyYNhspZ7/V7DEUsYqaD+uEm68j5
         wtTg==
X-Gm-Message-State: AOAM531/NHQOabx8Jkfzdbq4hp5oYNHfVzp356/R34LPK8csmyWqT5SG
        VCOSYJG/2BSRxvNkcrr5XYxqqQ==
X-Google-Smtp-Source: ABdhPJxKgv6x3rfj72N7e6R0s+yc5U3E9Q7S1lHfRYOLlI4nNWu3fX+Am0oo8Iipj3AlDREfSqdRBA==
X-Received: by 2002:a05:6512:321c:b0:44a:2109:201f with SMTP id d28-20020a056512321c00b0044a2109201fmr8960693lfe.26.1648237646648;
        Fri, 25 Mar 2022 12:47:26 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25190000000b004433b80c1d3sm802014lfi.182.2022.03.25.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:47:26 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v3 4/4] cpufreq: qcom-hw: provide online/offline operations
Date:   Fri, 25 Mar 2022 22:47:21 +0300
Message-Id: <20220325194721.2263571-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325194721.2263571-1-dmitry.baryshkov@linaro.org>
References: <20220325194721.2263571-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Provide lightweight online and offline operations. This saves us from
parsing and tearing down the OPP tables each time the CPU is put online
or offline.

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 35f993d2deea..4f4fe05225b6 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -421,10 +421,26 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 	return 0;
 }
 
-static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
+static int qcom_cpufreq_hw_cpu_online(struct cpufreq_policy *policy)
 {
+	struct qcom_cpufreq_data *data = policy->driver_data;
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	int ret;
+
+	ret = irq_set_affinity_hint(data->throttle_irq, policy->cpus);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to set CPU affinity of %s[%d]\n",
+			data->irq_name, data->throttle_irq);
+
+	return ret;
+}
+
+static int qcom_cpufreq_hw_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct qcom_cpufreq_data *data = policy->driver_data;
+
 	if (data->throttle_irq <= 0)
-		return;
+		return 0;
 
 	mutex_lock(&data->throttle_lock);
 	data->cancel_throttle = true;
@@ -432,6 +448,12 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 
 	cancel_delayed_work_sync(&data->throttle_work);
 	irq_set_affinity_hint(data->throttle_irq, NULL);
+
+	return 0;
+}
+
+static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
+{
 	free_irq(data->throttle_irq, data);
 }
 
@@ -588,6 +610,8 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.get		= qcom_cpufreq_hw_get,
 	.init		= qcom_cpufreq_hw_cpu_init,
 	.exit		= qcom_cpufreq_hw_cpu_exit,
+	.online		= qcom_cpufreq_hw_cpu_online,
+	.offline	= qcom_cpufreq_hw_cpu_offline,
 	.register_em	= cpufreq_register_em_with_opp,
 	.fast_switch    = qcom_cpufreq_hw_fast_switch,
 	.name		= "qcom-cpufreq-hw",
-- 
2.35.1

