Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449C43E9023
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhHKMHN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbhHKMHH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:07:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDA8C061798
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a5so2414360plh.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lWMPxMr+0+XtByl7tZGdcG2GFI54dtlZAQg+hT8HCaQ=;
        b=kNo51Ty287+Kf3xWLJBGIhyPm4y4DKiLm98i3Pq848jWbLqTuUdKifktM6kOb8qJw0
         F/sq6JVvy/bWf1cOTxFySRV4rHJLp+UX64TZypAKdYtU3JkS7zkMYq95K1YmsZOZIXzT
         p1rPaHOcyg8Rrm/Y/j3JC6D4bK9jmywwIxlIaGa+a2SByYNW9PkjDxnkDg0CypZrn+em
         rfZHy34KzjrzNllk+I0kOIjPH8Ror6DiLlRUOOkn2vA5bKpfw4Tsq+QfLy1MeZepCUQ5
         gOlaSUNNiqSlbAbLb5CvD5r/f6Bm2r/Nhqod+ejhJFCOfHndYqhyTyN7gYra+c46BSff
         9O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lWMPxMr+0+XtByl7tZGdcG2GFI54dtlZAQg+hT8HCaQ=;
        b=LXsu95pkNW928a/jDYNrolusfJYqvQlpdgIS35v9GQXHD5rQeXJhknkl7bvK9kqhLm
         tKgBtpIdKluF9mOCUFaE3j9i0JnDBDYoRl5H2ZvwraYLuurpeGcupVD8fO6SV2rwVCZS
         bMsYbh4BtdhhULkzwOyYCUvIlYPCYKdvAmBsZ20boWJ6+vB1JMaZVrNLS4WKm4uAhw27
         HERTqlrEBjThVfFT/jR+VeiGXTQmGHvkMkf0gakRjMOBgtC62DxiRlB+N9oe/6ccHzG6
         xdCD3kyq143pIMH0H5ihfyM6aBRoMW22M3OaMSwXhu4Slo1G3MEZfjYJdvTIXxonCcqE
         L0fg==
X-Gm-Message-State: AOAM530PfKMDuffl2bbsh/eIZfYVr+eAz3JBS8nPd6w3nECzfdw0dZTQ
        9d41WHK3SdDe8OzXtTH45AY+msAGnMQ4Ig==
X-Google-Smtp-Source: ABdhPJzuhNq2gHC1rhespgT1ixci1XjdDZ6D/VCU7fl35v7DEuY2tOp/P3ptzOMUU1RI1LiFg0J9YQ==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr744726pgu.82.1628683603490;
        Wed, 11 Aug 2021 05:06:43 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c9sm26616579pgq.58.2021.08.11.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:43 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 9/9] cpufreq: scmi: Use .register_em() callback
Date:   Wed, 11 Aug 2021 17:28:47 +0530
Message-Id: <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628682874.git.viresh.kumar@linaro.org>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the newly added .register_em() callback to register with the EM
after the cpufreq policy is properly initialized.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 55 ++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 75f818d04b48..b916c9e22921 100644
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
@@ -244,11 +240,23 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 
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
+	em_dev_register_perf_domain(get_cpu_device(policy->cpu), priv->nr_opp,
+				    &em_cb, priv->opp_shared_cpus,
+				    power_scale_mw);
+}
+
 static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
 	.flags	= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
@@ -261,6 +269,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
+	.register_em	= scmi_cpufreq_register_em,
 };
 
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
-- 
2.31.1.272.g89b43f80a514

