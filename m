Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161D4E81DA
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiCZPxj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Mar 2022 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiCZPxi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Mar 2022 11:53:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883FDEDD
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:52:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 5so18020816lfp.1
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lyl1W6wKqtyKB0huqnjGmmgWTKJ3Eh0knQy19kaAlKw=;
        b=Li8C0VkJ04oW5QoWZMZYBwVbSX3yZOtaLyHtGbCt2USVLLJ30uhzQavxx8HXRjAvp0
         hSEnh2gtwiGrr8GYQtF5pwN38IeabcU/m3i/ieOP1HbIrdHs4Wccygy6jpdNSOEzAzDL
         SdRpjbhf6SYpK8RPa6OxKUguxZCAwqrBhg8AMK9cjCdDOpmrVuz7W53GzOZc7itL6cw2
         I4PjpQ868di8YZ6ROkGYWhQm9m63wG2g7ChHbW9n6RFAxBszfz9DzCZGMPdiX3bcW5Sj
         /u+fdeW5wCLYqL6iDxn5PhgSewGvWIf0SOyca2T4heWt/g0I18dm1LI90CSNzfmDf7C/
         LBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lyl1W6wKqtyKB0huqnjGmmgWTKJ3Eh0knQy19kaAlKw=;
        b=njk8uU8kJo0HI7CtU+PkFG/OBLdWYv9+Kj6omFZVaVf+PhokPbCbkeVtzv7qyc9kc4
         j/0a0AtKPCZ4eXwSVtuP/0kCJzahGDCNA+A9N0VBlNIk4RMICoJJ8/XAW8wnOLx+61zq
         6TSTCZMU7FEpDqmrB3h2Giv/NAj/ZwSnXys/gl7wXlWL8NDRagtXKosRX/fkFQvVlBw4
         3x+Q7l/6KlkiqH/WNNk9Au9bJ2vichmKg6o3ehGOuiotIuO486VITGK3WaCX2ZeJCxtz
         9oRmMvmfvNL+PkG8QBxVGdlOFsX5RY0Aa6rKAL+V1Zc2e9lptp0KTahm+FzMDYPkT2Hu
         1r5Q==
X-Gm-Message-State: AOAM531Ej4N7dx3O/69KJ3oJe3a96oT1/sDBdQ0V4eOH80sQ+hBzbPzW
        SDbi4DHig11eSQde4V4xGN3mLA==
X-Google-Smtp-Source: ABdhPJy3U8/INt1qIpVyEF3mcSR5UdtZbEmeLz+KiiN/4y3B2cUUlyG/pW7VT7YZqCVL3zgJlrCKJQ==
X-Received: by 2002:a05:6512:ea7:b0:44a:2d87:fffc with SMTP id bi39-20020a0565120ea700b0044a2d87fffcmr12224140lfb.290.1648309919549;
        Sat, 26 Mar 2022 08:51:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id o17-20020a05651238b100b00443c898b598sm1097992lft.112.2022.03.26.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 08:51:58 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v4 4/4] cpufreq: qcom-hw: provide online/offline operations
Date:   Sat, 26 Mar 2022 18:51:53 +0300
Message-Id: <20220326155153.7377-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326155153.7377-1-dmitry.baryshkov@linaro.org>
References: <20220326155153.7377-1-dmitry.baryshkov@linaro.org>
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
index db67daed99a3..b0282898168e 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -423,10 +423,26 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
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
@@ -434,6 +450,12 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 
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
 
@@ -590,6 +612,8 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
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

