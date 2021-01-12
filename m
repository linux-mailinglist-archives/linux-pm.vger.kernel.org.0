Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6422F2BD7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 10:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392798AbhALJxg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 04:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392782AbhALJxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 04:53:35 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA30C061786
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 01:52:55 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so1083964pgl.10
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 01:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=srYJmug92j0OsKq39q/OswiRd1JmfW8IEDQEUNljHnU=;
        b=v6QHWUWmXwSiWv4vsGTQ7GLUJJSixC5ZJAFb0Ut+X0+S5gVu2soDHqYqyZSm9NdZ06
         TsQlgU5yqykIXGSkOMbu7FfpwdPG6VtkbbjfsDhA54xrd/RqXRr+2N5FD8JWLKpoYveJ
         mm9jkMf5XDGphd7fswb2vlhv5MFmordwqOBnBIQtwOQVtxtq+TIsNc9whBv2p+xTJ8EY
         kfcZigdbZs1g2f5PSev6nA9/cCnMKeqZEGXPK56wyRaLl8/ev5tx5qbHV2bCqSthIOk0
         xJ6Gnb4rz8lk6BGwViTNBqqT1ie/UZyl/D4KojcKuf3rSeOgFzSwxo6Kesv71i0D5VhQ
         AcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=srYJmug92j0OsKq39q/OswiRd1JmfW8IEDQEUNljHnU=;
        b=OASgRWMCYFDcpeCLiTN6u8a8BvZMDG34Y22778Sx2vD2GwNC58rJPNQbWhjfCYRLlv
         y8xMLJ7CqMI2wwbQV1rzz4g5NSgvVL9rFhJ6oXNYWWf3TJeJrhRW2nqFnXLqEviehtGF
         6Ymh9edqIWbvwFpJBhoTGLh9sb5OH3NuR1EoJjq0c1dZMQ3eNov/y2pQ3wMdLLsFB4pL
         WIaPBkl1CWLwIk0KcON2kxxKjvMddbCpFbh3Oxp9YrCCz0uTAc25Yjj3FiX+aj9S3RAg
         gTmAeHf5rUDnLZ1XDixOsItfeA0ZrD1kvupNZcQZKR4YB/44mGa2KEIldGUgs4QRzKGX
         hnoQ==
X-Gm-Message-State: AOAM530p3HtaeeTWWHFSAIc7StLXFk3Xke5lKXxB+St4W7zL2qRyCGO3
        qgE+7oTVyjgz5J/JtLI+TwzkpkFC1Yi0hg==
X-Google-Smtp-Source: ABdhPJwf6MAMibH7JkcYDhg522v1k8fc/WJIF0jy8Bi1ICycl/pYNANP29CdGpsl8dhddqc01bzmyw==
X-Received: by 2002:a62:64d2:0:b029:19e:662e:5e99 with SMTP id y201-20020a6264d20000b029019e662e5e99mr3845537pfb.17.1610445173548;
        Tue, 12 Jan 2021 01:52:53 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id b6sm2464174pfd.43.2021.01.12.01.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 01:52:52 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region() call
Date:   Tue, 12 Jan 2021 17:52:36 +0800
Message-Id: <20210112095236.20515-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On SDM845/850, running the following commands to put all cores in
freq-domain1 offline and then get one core back online, there will be
a request region error seen from qcom-hw driver.

$ echo 0 > /sys/devices/system/cpu/cpu4/online
$ echo 0 > /sys/devices/system/cpu/cpu5/online
$ echo 0 > /sys/devices/system/cpu/cpu6/online
$ echo 0 > /sys/devices/system/cpu/cpu7/online
$ echo 1 > /sys/devices/system/cpu/cpu4/online

[ 3395.915416] CPU4: shutdown
[ 3395.938185] psci: CPU4 killed (polled 0 ms)
[ 3399.071424] CPU5: shutdown
[ 3399.094316] psci: CPU5 killed (polled 0 ms)
[ 3402.139358] CPU6: shutdown
[ 3402.161705] psci: CPU6 killed (polled 0 ms)
[ 3404.742939] CPU7: shutdown
[ 3404.765592] psci: CPU7 killed (polled 0 ms)
[ 3411.492274] Detected VIPT I-cache on CPU4
[ 3411.492337] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
[ 3411.492448] CPU4: Booted secondary processor 0x0000000400 [0x516f802d]
[ 3411.503654] qcom-cpufreq-hw 17d43000.cpufreq: can't request region for resource [mem 0x17d45800-0x17d46bff]

The cause is that the memory region requested in .init hook doesn't get
released in .exit hook, and the subsequent call to .init will always fail
on this error.  Let's break down the devm_platform_ioremap_resource()
call a bit, so that we can have the resource pointer to release memory
region from .exit hook.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 9ed5341dc515..315ee987d2d3 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -32,6 +32,7 @@ struct qcom_cpufreq_soc_data {
 
 struct qcom_cpufreq_data {
 	void __iomem *base;
+	struct resource *res;
 	const struct qcom_cpufreq_soc_data *soc_data;
 };
 
@@ -280,6 +281,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
 	struct device *cpu_dev;
+	struct resource *res;
 	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	int ret, index;
@@ -303,7 +305,8 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	index = args.args[0];
 
-	base = devm_platform_ioremap_resource(pdev, index);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
@@ -315,6 +318,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	data->soc_data = of_device_get_match_data(&pdev->dev);
 	data->base = base;
+	data->res = res;
 
 	/* HW should be in enabled state to proceed */
 	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
@@ -358,11 +362,13 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	struct qcom_cpufreq_data *data = policy->driver_data;
 	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct resource *res = data->res;
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	kfree(policy->freq_table);
 	devm_iounmap(&pdev->dev, data->base);
+	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
 
 	return 0;
 }
-- 
2.17.1

