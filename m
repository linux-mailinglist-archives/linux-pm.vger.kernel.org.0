Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAB94D02F0
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 16:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbiCGPcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 10:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbiCGPcW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 10:32:22 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A1475E40
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 07:31:27 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u3so4487994ljd.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZOpZdLyL3HZ2X9zNORxvj4ZQfp0+dq2bVSFb321NTA=;
        b=OrvCJhFG3x4dAvAx2h6LkJU17MzPZcML+fTYymOPz6Pmk6Fh3w8GIfyMMbQGuIZMwR
         yKRdXcAjHNXGuhIwc2tDqWD/pKm2VAugE2N3KMManZaKSWLVQ9E5N/W0LXRdvQmlFfiX
         4sHevO1VCwMCndKUEqZIP9iNrUOKE9pYbC0Hw6QwJ9QX4EWeXbXrhO+7fBFCHvdY7IO2
         4rz0QbZaT3kcbLQiNfNgmfaF9D5xQxq4gZuW1DMwDjVAWHNOILE1xX6SY4ZYK5LH7/Gy
         BEr4rttzlKK4LoNdRbuSkp44NviL6hswQEfwgA3YHWCCgrbVzaS6bSqImQTZApj6QtTR
         9PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZOpZdLyL3HZ2X9zNORxvj4ZQfp0+dq2bVSFb321NTA=;
        b=ggkTd3hC8hxifF6RJFwdhQRSNXau8hqaj+Xo+ngHCzOv53/GPuEHIcVfi2WDnf2XMI
         /f7GuDVp5hvFkAH3RnGJQyScw/sYNRUas/Jh0urMeCjgn2mf4hWOMDOVF7zDt2tN9JlN
         qfYfqrHUMHW4/bpdAQn5+qjMDhHgtVONUoer6gMGVQwZg9Zb8khHXQYzJPSbwF0ZJJiu
         U4qCbXEq+HtEoGvaH7PiHp0GGZcmTH8QOcX4aK1uzQe2QTn1sMxgiNBWH2VtHwJCP2D2
         xfqXhh7d5NTk95/fSysDRWnsbjg20Mq5X+VtntMr+U8dxYlbXXy8YqytUIgM6XrsT2jy
         +Dsw==
X-Gm-Message-State: AOAM532WW+vSEMZ76M2LC3TE2rqti42EDP/6YsbSEzpc1GjMUVnUdLCB
        K/iiDBJswPomWB8ZThF7zJ4UXw==
X-Google-Smtp-Source: ABdhPJwu65zUpOQUplCwv4Rv0LDQD4DCoGGsu1HdhhPCADVl5sjoz4d6gXi9QTx5AbqEq70BjOJeWw==
X-Received: by 2002:a05:651c:1503:b0:244:c075:2103 with SMTP id e3-20020a05651c150300b00244c0752103mr7818254ljf.442.1646667082904;
        Mon, 07 Mar 2022 07:31:22 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e8e61000000b00247dd27e05bsm1662062ljk.100.2022.03.07.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:31:22 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 4/4] cpufreq: qcom-hw: provide online/offline operations
Date:   Mon,  7 Mar 2022 18:30:50 +0300
Message-Id: <20220307153050.3392700-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
References: <20220307153050.3392700-1-dmitry.baryshkov@linaro.org>
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 580520215ee7..12b67f16b78f 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -424,10 +424,26 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
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
@@ -435,6 +451,12 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 
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
2.34.1

