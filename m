Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071BA3E9D9A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 06:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhHLEgj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 00:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhHLEgf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 00:36:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D0C061765
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:36:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c17so327852plz.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8K1U7FQdWn8Epzc/tTySkxl9YBi7lGLi/bEAhau8x6Q=;
        b=AAy+qkAkZITRW3NQ0AvJtgjN/N3Vhf/2ReAgijDisDJw5V++3rkcQcH3ofdyEGVkjk
         pCtSPd3+yFEl6Y0E8+o7QkHKZxxK+vcZ+fG10oUU8Z5HBma1y58ZkA/zIPp+bBkN2L8O
         txic0SyyzSshcK+Oe7M3kpHAbg68NY2is/AH5vf2O57B2Wq1MfU+ocINXCphcR5i0SoL
         8Nhuwxolf4hCahGJtOJGafAFsMU8nW7WVZgxUQeQ0AB2YMDvXFNMl9ks2/ykiIHSsfss
         Pbq+Bh5TqW3LZc6u7Qmy4/w392Yj70yjWop/ZVeB+xfcZK8BTeuvnRvIz/vl1Yz98DKu
         ml6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8K1U7FQdWn8Epzc/tTySkxl9YBi7lGLi/bEAhau8x6Q=;
        b=sB6pQwB6qTJYpLBvlRKL90Tvw6Ed/e23GPCpEpdQLvbg2dKvbWyCCePaaF5y8xN6OR
         TlfBGU/FlLvvMh5oX9o4yBATSjjXCs6jQCCYWc4ec+mpDIQrjHvmE++WDLOS/UhBKRyN
         ap4ZwVog+fs0k3vhf2EwNJLkpcCzpwvQT/byhiKyiKlYn2jjYvUloDrG9uG0qVeLgGsk
         JDwBiqubyFNbhcJ9pnUsctXZisj7d7r8JFk44nNzfHrdO9FmcXbWdVarNw/3abXjZrLZ
         6xJRTBZnJveMAimHL8jBm3BZSepVDJHl5hgsmqE/cqZxnW9xraa33VGNU5HZGrbnNLbM
         QEbQ==
X-Gm-Message-State: AOAM532uu/dyceTde1saenXCLAAQ7hflGmLiBmINBsob7qTucnuzE9YH
        fSYhb3fwp1/Jwq/AZ3UsslqU8w==
X-Google-Smtp-Source: ABdhPJzmPaH4tXdS//TrquYEJvA5D4OoIMoPa7TEAwd4zIZ7LFoOHNyYxmDwOTQsioHhrCwHd2qDGg==
X-Received: by 2002:a63:2024:: with SMTP id g36mr2092959pgg.213.1628742970741;
        Wed, 11 Aug 2021 21:36:10 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id x24sm8399795pjk.43.2021.08.11.21.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:36:10 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 9/9] cpufreq: scmi: Use .register_em() to register with energy model
Date:   Thu, 12 Aug 2021 10:05:22 +0530
Message-Id: <8158488baa1ea1aebd09c8d256db7420051d05ac.1628742634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628742634.git.viresh.kumar@linaro.org>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the newly added .register_em() callback to register with the EM
after the cpufreq policy is properly initialized.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 65 ++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 75f818d04b48..1e0cd4d165f0 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -22,7 +22,9 @@
 
 struct scmi_data {
 	int domain_id;
+	int nr_opp;
 	struct device *cpu_dev;
+	cpumask_var_t opp_shared_cpus;
 };
 
 static struct scmi_protocol_handle *ph;
@@ -123,9 +125,6 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
-	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
-	cpumask_var_t opp_shared_cpus;
-	bool power_scale_mw;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -133,9 +132,15 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
+	if (!zalloc_cpumask_var(&priv->opp_shared_cpus, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto out_free_priv;
+	}
+
 	/* Obtain CPUs that share SCMI performance controls */
 	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
@@ -148,14 +153,14 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	 * The OPP 'sharing cpus' info may come from DT through an empty opp
 	 * table and opp-shared.
 	 */
-	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, opp_shared_cpus);
-	if (ret || !cpumask_weight(opp_shared_cpus)) {
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, priv->opp_shared_cpus);
+	if (ret || !cpumask_weight(priv->opp_shared_cpus)) {
 		/*
 		 * Either opp-table is not set or no opp-shared was found.
 		 * Use the CPU mask from SCMI to designate CPUs sharing an OPP
 		 * table.
 		 */
-		cpumask_copy(opp_shared_cpus, policy->cpus);
+		cpumask_copy(priv->opp_shared_cpus, policy->cpus);
 	}
 
 	 /*
@@ -180,7 +185,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 			goto out_free_opp;
 		}
 
-		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, priv->opp_shared_cpus);
 		if (ret) {
 			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 				__func__, ret);
@@ -188,21 +193,13 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 			goto out_free_opp;
 		}
 
-		power_scale_mw = perf_ops->power_scale_mw_get(ph);
-		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb,
-					    opp_shared_cpus, power_scale_mw);
-	}
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out_free_opp;
+		priv->nr_opp = nr_opp;
 	}
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
-		goto out_free_priv;
+		goto out_free_opp;
 	}
 
 	priv->cpu_dev = cpu_dev;
@@ -223,17 +220,16 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible =
 		perf_ops->fast_switch_possible(ph, cpu_dev);
 
-	free_cpumask_var(opp_shared_cpus);
 	return 0;
 
-out_free_priv:
-	kfree(priv);
-
 out_free_opp:
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
 out_free_cpumask:
-	free_cpumask_var(opp_shared_cpus);
+	free_cpumask_var(priv->opp_shared_cpus);
+
+out_free_priv:
+	kfree(priv);
 
 	return ret;
 }
@@ -244,11 +240,33 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	free_cpumask_var(priv->opp_shared_cpus);
 	kfree(priv);
 
 	return 0;
 }
 
+static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
+{
+	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
+	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
+	struct scmi_data *priv = policy->driver_data;
+
+	/*
+	 * This callback will be called for each policy, but we don't need to
+	 * register with EM every time. Despite not being part of the same
+	 * policy, some CPUs may still share their perf-domains, and a CPU from
+	 * another policy may already have registered with EM on behalf of CPUs
+	 * of this policy.
+	 */
+	if (!priv->nr_opp)
+		return;
+
+	em_dev_register_perf_domain(get_cpu_device(policy->cpu), priv->nr_opp,
+				    &em_cb, priv->opp_shared_cpus,
+				    power_scale_mw);
+}
+
 static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
 	.flags	= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
@@ -261,6 +279,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
+	.register_em	= scmi_cpufreq_register_em,
 };
 
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
-- 
2.31.1.272.g89b43f80a514

