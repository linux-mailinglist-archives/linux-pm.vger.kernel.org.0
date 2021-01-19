Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1299D2FAEDA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 03:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbhASCkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 21:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbhASCkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 21:40:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680DC061573
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 18:39:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j12so2155938pjy.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 18:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2oB1hGunho6pX4DnLSBTnX8ePB+qmflG8rlxu9u4DUc=;
        b=Hn3mAounDTAqYGm/fLxPMbzdCUrisv8OARJb77iPI7I4awe6vyE7l29JsbImTXARpm
         DcDc0xCqiSb7t3OAhh2ZxnxuBBL/stIUxZDiP+Z9hfq6nx0aonDfK8RPQHz2nRldE2Vv
         WPmd4UCp6aM5ZnYG/YXc7rligHJw0N5yPZ0wzlpfSBMqFDm5fG1wwp1aAwSThV4LXcwv
         VdZoRdW8R67tEFRJ4YjV5+6l7E7/HTFMw1LIjM/Nq0diAZ5Mc9toPd2oezw0jen10cZ2
         yHZ6iu91s6QISc2PV6xdn8bc/2LLTACmdTs2zdqiqn8yYx9tBuvdY2Y6u+h5hUrGZrts
         IdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2oB1hGunho6pX4DnLSBTnX8ePB+qmflG8rlxu9u4DUc=;
        b=WlkMUcscnmJ8BPnelxilEJ0aaBPhJJ3EiXkJDosadFF8Ss+gz17mBQhCURq/RTm216
         GZEXk8iBeDcKDJSipgSEf3XMzePHUy1lwohs677lli8NNU9KmsWK+Q+4VRL6Nw+2wO0/
         GSAJsvSU657EVzzMhkKrZcv+0XpCBtglNoY6CJVjQjGhUCxE5t+2TvuD1xSNras0U4Fg
         YfP7joNYVgC1+yzZhDd9e6JpDyr8HwOwF88eWnASLNK14jmzC/NwOH2PEiVDhP30QJpe
         q/yQVn2igMQ+HkWRy/wRiaDL8pDpxEqR3MEV+XmiuVzgeJg4Is/3CPo0p9DM4pvWrobN
         b8vg==
X-Gm-Message-State: AOAM533pkrrySeqwl2Z3Dak4pUsKFhmWQ09ptVMck5r2nmvEL375vQms
        ZMX957idqHRV79SitOehif+7eA==
X-Google-Smtp-Source: ABdhPJz4OEiZXq4GnstBNfMgyYP21Tab4RCuB7wGWZHDwtseTlJv7Ad511Sf6NnSNDXOgc0CsbHUpQ==
X-Received: by 2002:a17:902:123:b029:dc:27b:3c62 with SMTP id 32-20020a1709020123b02900dc027b3c62mr2456953plb.16.1611023979186;
        Mon, 18 Jan 2021 18:39:39 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id i10sm17263504pgt.85.2021.01.18.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 18:39:38 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2] cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks
Date:   Tue, 19 Jan 2021 10:39:25 +0800
Message-Id: <20210119023925.22724-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit f17b3e44320b ("cpufreq: qcom-hw: Use
devm_platform_ioremap_resource() to simplify code") introduces
a regression on platforms using the driver, by failing to initialise
a policy, when one is created post hotplug.

When all the CPUs of a policy are hoptplugged out, the call to .exit()
and later to devm_iounmap() does not release the memory region that was
requested during devm_platform_ioremap_resource().  Therefore,
a subsequent call to .init() will result in the following error, which
will prevent a new policy to be initialised:

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

With that being said, the original code was tricky and skipping memory
region request intentionally to hide this issue.  The true cause is that
those devm_xxx() device managed functions shouldn't be used for cpufreq
init/exit hooks, because &pdev->dev is alive across the hooks and will
not trigger auto resource free-up.  Let's drop the use of device managed
functions and manually allocate/free resources, so that the issue can be
fixed properly.

Fixes: f17b3e44320b ("cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code")
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes for v2:
- Move kzalloc() around to respect the original sequence which makes
  the local variables use reasonable.

 drivers/cpufreq/qcom-cpufreq-hw.c | 40 ++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 9ed5341dc515..2726e77c9e5a 100644
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
@@ -303,18 +305,33 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	index = args.args[0];
 
-	base = devm_platform_ioremap_resource(pdev, index);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (!res) {
+		dev_err(dev, "failed to get mem resource %d\n", index);
+		return -ENODEV;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), res->name)) {
+		dev_err(dev, "failed to request resource %pR\n", res);
+		return -EBUSY;
+	}
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	base = ioremap(res->start, resource_size(res));
+	if (IS_ERR(base)) {
+		dev_err(dev, "failed to map resource %pR\n", res);
+		ret = PTR_ERR(base);
+		goto release_region;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
-		goto error;
+		goto unmap_base;
 	}
 
 	data->soc_data = of_device_get_match_data(&pdev->dev);
 	data->base = base;
+	data->res = res;
 
 	/* HW should be in enabled state to proceed */
 	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
@@ -349,7 +366,11 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	return 0;
 error:
-	devm_iounmap(dev, base);
+	kfree(data);
+unmap_base:
+	iounmap(data->base);
+release_region:
+	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
@@ -357,12 +378,15 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	struct qcom_cpufreq_data *data = policy->driver_data;
-	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct resource *res = data->res;
+	void __iomem *base = data->base;
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	kfree(policy->freq_table);
-	devm_iounmap(&pdev->dev, data->base);
+	kfree(data);
+	iounmap(base);
+	release_mem_region(res->start, resource_size(res));
 
 	return 0;
 }
-- 
2.17.1

