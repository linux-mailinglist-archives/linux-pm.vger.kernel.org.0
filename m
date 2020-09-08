Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D618260CB3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 09:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgIHH56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 03:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729775AbgIHH5s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 03:57:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4345AC061797
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 00:57:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so9469095pgb.8
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JGfwbA2hMX/PUVpH89svS+V4Ld5w43WoS4VhDZ1+uvE=;
        b=pJO2glLcWONMCZxzk++7qzEcyoK2rePLlHNeofmiirHWh9yz0rixKMU4YYLAImgiYp
         O/Glo7upyvln7QHfW1GLAIWWmw8mENdE4QXXuvlfh/M4KmtzVm0ERJ4YVjDXJnFIrrZE
         2y3CH5O+NooqYIeggydwNGkxErOu3EKUGYdPX5bj9TFXKKBnHT1MJyrtqk/DYo0FMqu7
         MK8++Fqvu1MRd0oTlYdTqIOpTh50MiMjcBdKuoqt0EczUr7D8D83tcEDL3zuFI1Vy1GD
         MM1V4WBh+3eVxrn+najs/OsxLtZoXYWND6kZ1KMfD7FAaXNtUSae3k7FRZpj5hfib2hM
         9SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JGfwbA2hMX/PUVpH89svS+V4Ld5w43WoS4VhDZ1+uvE=;
        b=qzJbRbs1SrjqE1zIUUxeiE2s1PzXSvo+e6FDOw+78Rtj1qRCT8cZo3hesuSXV4Q0cY
         mq+N+lC5qc/HQF1GLStL/f35j/eDCK9+B/tF0veEhDi3gPf2XS+5DUuK3E5Fxx8OHb+E
         z1BlSwiNqfZE25yAcE5HrExaFmfEkWf1hwuFzpcUi3JzrfJms6An5tPiU81yEa2kXZbB
         SenCLa7U9dr8Ih0jrX1/y2zvC0JSMt6SxzbmXYm0YQNJu2HBA8V7oFsWYIEVLTJ/dWcD
         ZiWhViv7p6jbNtyFkyJuuWHK/VN6UuA5wfQI7oxDlgobHWbN6EtBnWB1ODQWvC3G5nTF
         COZA==
X-Gm-Message-State: AOAM533vnoQnyF/xVhNeJuCLNUUddIWnkv6x9g4H5822TW9MVkFa6iC6
        Pqd2s2qrWEq7B8ykZX18c8dx
X-Google-Smtp-Source: ABdhPJxnL7Hl8Z71y7U9kzxKmM0X1d5HaMDs6sYG80MtVWkyH65fYgMxHVkXWSSR0aAaS+C/7LmLfA==
X-Received: by 2002:a17:902:8342:: with SMTP id z2mr21724921pln.3.1599551862494;
        Tue, 08 Sep 2020 00:57:42 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m21sm7560154pfo.13.2020.09.08.00.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/7] cpufreq: qcom-hw: Make use of cpufreq driver_data for passing pdev
Date:   Tue,  8 Sep 2020 13:27:12 +0530
Message-Id: <20200908075716.30357-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Get rid of global_pdev pointer and make use of cpufreq driver_data for
passing the reference of pdev. This aligns with what other cpufreq drivers
are doing.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 3fb044b907a8..ccea34f61152 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -30,7 +30,6 @@
 #define REG_PERF_STATE			0x920
 
 static unsigned long cpu_hw_rate, xo_rate;
-static struct platform_device *global_pdev;
 static bool icc_scaling_enabled;
 
 static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
@@ -240,7 +239,8 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 
 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
-	struct device *dev = &global_pdev->dev;
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct device *dev = &pdev->dev;
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
 	struct device *cpu_dev;
@@ -267,7 +267,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	index = args.args[0];
 
-	res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	if (!res)
 		return -ENODEV;
 
@@ -316,11 +316,12 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	void __iomem *base = policy->driver_data - REG_PERF_STATE;
+	struct platform_device *pdev = cpufreq_get_driver_data();
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	kfree(policy->freq_table);
-	devm_iounmap(&global_pdev->dev, base);
+	devm_iounmap(&pdev->dev, base);
 
 	return 0;
 }
@@ -365,7 +366,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
 	clk_put(clk);
 
-	global_pdev = pdev;
+	cpufreq_qcom_hw_driver.driver_data = pdev;
 
 	/* Check for optional interconnect paths on CPU0 */
 	cpu_dev = get_cpu_device(0);
-- 
2.17.1

