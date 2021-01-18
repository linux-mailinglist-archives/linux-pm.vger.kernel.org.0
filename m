Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8572FA0BC
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 14:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392049AbhARNHI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 08:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391868AbhARNG7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 08:06:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DFC061574
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 05:06:18 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j12so854305pjy.5
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 05:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BoSBnxjMyyHzFvdw+IKIalzlP1OM8AZYV3P2GXb8a60=;
        b=ihX8NYmAyFhi6oGl9XblUkolWfCbb3eic+NOtQufiy9AA6uFY2djru0n4AZ7JURqh/
         CG9FehGi/L8uDZ5hheYLMvxrefZIOaLK0Cn+CWGNDlpgV4WmR+wr7KRpUWLkjvdNySgL
         rf/ejttbzq+kOrmuXUNkWlBS5faW6ospjL0rRilBstXVXBwftKwsv/bAXHgtJ3oOcbOa
         DHIxvv6JnnF9jJwQeQ2VSwBBQwXN+fTcGtAJQcidiAmUyJQhB08fkeV7zpkKgqvmnOi5
         CW4DhwsD1sPbo0B1wOkAxTPq3NS31Chvw2HN9LDvlBYkolCrwxD2PnOP6JmIclYJgh5H
         1WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BoSBnxjMyyHzFvdw+IKIalzlP1OM8AZYV3P2GXb8a60=;
        b=Pky9hu88eGfCwz0KT9K+WyKVzmb9EZK5NQxGCFdW5BrBPY4W0Cns6rvTBq7+saCuPK
         MjeoV4OerAZ09FNm90Bm+RiyAwMmssAYzhXp2knCmkB7Qgl0o96y8LnVUU1axyiYr/ak
         odEgmhlMz780ThVTl/zIxoW+D+0AcAvGtQ5fc7zdQBHG+FE6/+UIsMGDPN0hdHGu8MKV
         0DoB/ntsI7YPRwDnP528aYMaBV4EilIqtKz1kKOVj59dS8EbN5Pe/2gxeJjlWCW/oqBW
         be+l3TEgtRqFsKZPxctuojJb+Tim6HQ/X4zrRT/3cyKwC5I1S26LsVQ8ZG9zTFXSboCr
         Dkww==
X-Gm-Message-State: AOAM532JG9ojUEFBHZ3ocEHqp2kcz9ptZcNuAKW+9ITyItIt47EEA3pv
        QW0aa3CDyncjYMEdohB6sv9lcA==
X-Google-Smtp-Source: ABdhPJwGKZ/8tq9uNPj22LoFzuSlgZiw5RTmf/CiHkVIoqQSpvLwxd97UiclJ5ojrzu99tMKXhY6fQ==
X-Received: by 2002:a17:902:7086:b029:dc:8d:feab with SMTP id z6-20020a1709027086b02900dc008dfeabmr26580034plk.22.1610975178380;
        Mon, 18 Jan 2021 05:06:18 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 21sm15938147pfx.84.2021.01.18.05.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 05:06:17 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks
Date:   Mon, 18 Jan 2021 21:06:03 +0800
Message-Id: <20210118130603.16176-1-shawn.guo@linaro.org>
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

I took some of the commit log from Ionela.

 drivers/cpufreq/qcom-cpufreq-hw.c | 43 ++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 9ed5341dc515..b529b49649e0 100644
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
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto error;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (!res) {
+		dev_err(dev, "failed to get mem resource %d\n", index);
+		ret = -ENODEV;
+		goto free_data;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), res->name)) {
+		dev_err(dev, "failed to request resource %pR\n", res);
+		ret = -EBUSY;
+		goto free_data;
+	}
+
+	base = ioremap(res->start, resource_size(res));
+	if (IS_ERR(base)) {
+		dev_err(dev, "failed to map resource %pR\n", res);
+		ret = PTR_ERR(base);
+		goto release_region;
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
+	iounmap(data->base);
+release_region:
+	release_mem_region(res->start, resource_size(res));
+free_data:
+	kfree(data);
 	return ret;
 }
 
@@ -357,12 +378,14 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	struct qcom_cpufreq_data *data = policy->driver_data;
-	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct resource *res = data->res;
 
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	kfree(policy->freq_table);
-	devm_iounmap(&pdev->dev, data->base);
+	iounmap(data->base);
+	release_mem_region(res->start, resource_size(res));
+	kfree(data);
 
 	return 0;
 }
-- 
2.17.1

