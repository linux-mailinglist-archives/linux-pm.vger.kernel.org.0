Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3825F3EA
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 09:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfGDHgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 03:36:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34849 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfGDHgq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 03:36:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so1345192pfn.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2019 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucpldABbW8/3jH3u+faZEWtKvMNLILFWVMZ6DzJhvvI=;
        b=wG8etO7Yt1bBZuwRtL6oYyKvU5eSay0J+oDqZ+r4qC14aa7P3aNMTqV2JQiccaxzyA
         75vIiSj0uWHz+NcO50TBcru2hp0wGBe0aJXRI2gRXYYcS4XQM+CUuTgPWgDP2zYZTnG3
         VHxGMj4unTfXFsFHJLAHrXYWp/cEciVO3y4P6Ol1vVxZhKyETemVIciuggIgmT4fBOnY
         uCVb1q0Z1ld4NQhD7Cz38yWPsUjtZY8dcTISXE5GMt3AhLbkMSkHNzPvWOyAu5rJXUwj
         2hmZMlBtt0RG4kEzaXQnvJQWvgtgO37N9qLKN/fdpSzC0fLaPSFeqreBZhRxdOcQcNl5
         McmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucpldABbW8/3jH3u+faZEWtKvMNLILFWVMZ6DzJhvvI=;
        b=q3zC+hq/O5/2C5JR29FM1DyOAQti/J4GXQUQyoXYlEwsUFKJsrb/+xzVGuQNLo7Y2p
         BtATyZTAgAAZUObVCY9VpHFhgFRFUgkKV7oCkSSXeJXKRqQ+5RvUqmCzd6Hazx4lJ8So
         lM+wNK3Lf5sQXJaOlHw+H4XEVjmHKfmP4Dx5ufpLbPz3E8hhD1D7sZnE301uWV+eFPDI
         YdcSA8G+E6Jmo+s7a7gHHPpj4M8pWysIX53qrwbTKoxy/uWdHAdiVPeBnKY2ARyQsHC8
         4cwbmxq4s6T5uyx1p0VH9LQuioV+GMudLfVRt357LHrWfJZXbsRyIXyhDc67ERc3eOZU
         3cGg==
X-Gm-Message-State: APjAAAUh+UCNt4lAtC02zvsJmHiNvYZTwT8/lTfWEbEL9STorYg/vGf5
        BHxZFt++BlCFQy0x7n6+TVXfNg==
X-Google-Smtp-Source: APXvYqwGNzaow4yrRBjuAw1sIwc+zQYsGajrqQdSLeHRPC6lo6DSfqIXtciCbCnEz3qZ2/grfsYXZQ==
X-Received: by 2002:a63:5964:: with SMTP id j36mr39448142pgm.428.1562225804520;
        Thu, 04 Jul 2019 00:36:44 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id x14sm5926822pfq.158.2019.07.04.00.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 00:36:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 5/7] cpufreq: Register notifiers with the PM QoS framework
Date:   Thu,  4 Jul 2019 13:06:21 +0530
Message-Id: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1562210705.git.viresh.kumar@linaro.org>
References: <cover.1562210705.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This registers the notifiers for min/max frequency constraints with the
PM QoS framework. The constraints are also taken into consideration in
cpufreq_set_policy().

This also relocates cpufreq_policy_put_kobj() as it is required to be
called from cpufreq_policy_alloc() now.

refresh_frequency_limits() is updated to have proper locking in place and
avoid calling cpufreq_set_policy() for inactive policies.

No constraints are added until now though.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c | 135 ++++++++++++++++++++++++++++++--------
 include/linux/cpufreq.h   |   3 +
 2 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ceb57af15ca0..81117e4d43cc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
@@ -999,7 +1000,7 @@ static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	if (!dev)
+	if (unlikely(!dev))
 		return;
 
 	if (cpumask_test_and_set_cpu(cpu, policy->real_cpus))
@@ -1117,14 +1118,20 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 
 static void refresh_frequency_limits(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy new_policy = *policy;
+	struct cpufreq_policy new_policy;
 
-	pr_debug("updating policy for CPU %u\n", policy->cpu);
+	down_write(&policy->rwsem);
+
+	if (!policy_is_inactive(policy)) {
+		new_policy = *policy;
+		pr_debug("updating policy for CPU %u\n", policy->cpu);
 
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
+		new_policy.min = policy->user_policy.min;
+		new_policy.max = policy->user_policy.max;
+		cpufreq_set_policy(policy, &new_policy);
+	}
 
-	cpufreq_set_policy(policy, &new_policy);
+	up_write(&policy->rwsem);
 }
 
 static void handle_update(struct work_struct *work)
@@ -1136,11 +1143,55 @@ static void handle_update(struct work_struct *work)
 	refresh_frequency_limits(policy);
 }
 
+static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
+				void *data)
+{
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
+
+	schedule_work(&policy->update);
+	return 0;
+}
+
+static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
+				void *data)
+{
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
+
+	schedule_work(&policy->update);
+	return 0;
+}
+
+static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
+{
+	struct kobject *kobj;
+	struct completion *cmp;
+
+	down_write(&policy->rwsem);
+	cpufreq_stats_free_table(policy);
+	kobj = &policy->kobj;
+	cmp = &policy->kobj_unregister;
+	up_write(&policy->rwsem);
+	kobject_put(kobj);
+
+	/*
+	 * We need to make sure that the underlying kobj is
+	 * actually not referenced anymore by anybody before we
+	 * proceed with unloading.
+	 */
+	pr_debug("waiting for dropping of refcount\n");
+	wait_for_completion(cmp);
+	pr_debug("wait complete\n");
+}
+
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
+	struct device *dev = get_cpu_device(cpu);
 	int ret;
 
+	if (!dev)
+		return NULL;
+
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
 		return NULL;
@@ -1157,7 +1208,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
-		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		dev_err(dev, "%s: failed to init policy->kobj: %d\n", __func__, ret);
 		/*
 		 * The entire policy object will be freed below, but the extra
 		 * memory allocated for the kobject name needs to be freed by
@@ -1167,6 +1218,25 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
+	policy->nb_min.notifier_call = cpufreq_notifier_min;
+	policy->nb_max.notifier_call = cpufreq_notifier_max;
+
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
+				      DEV_PM_QOS_MIN_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
+			ret, cpumask_pr_args(policy->cpus));
+		goto err_kobj_remove;
+	}
+
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
+				      DEV_PM_QOS_MAX_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
+			ret, cpumask_pr_args(policy->cpus));
+		goto err_min_qos_notifier;
+	}
+
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
@@ -1177,6 +1247,11 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
+err_min_qos_notifier:
+	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+				   DEV_PM_QOS_MIN_FREQUENCY);
+err_kobj_remove:
+	cpufreq_policy_put_kobj(policy);
 err_free_real_cpus:
 	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
@@ -1189,30 +1264,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	return NULL;
 }
 
-static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
-{
-	struct kobject *kobj;
-	struct completion *cmp;
-
-	down_write(&policy->rwsem);
-	cpufreq_stats_free_table(policy);
-	kobj = &policy->kobj;
-	cmp = &policy->kobj_unregister;
-	up_write(&policy->rwsem);
-	kobject_put(kobj);
-
-	/*
-	 * We need to make sure that the underlying kobj is
-	 * actually not referenced anymore by anybody before we
-	 * proceed with unloading.
-	 */
-	pr_debug("waiting for dropping of refcount\n");
-	wait_for_completion(cmp);
-	pr_debug("wait complete\n");
-}
-
 static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
+	struct device *dev = get_cpu_device(policy->cpu);
 	unsigned long flags;
 	int cpu;
 
@@ -1224,6 +1278,11 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
+				   DEV_PM_QOS_MAX_FREQUENCY);
+	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+				   DEV_PM_QOS_MIN_FREQUENCY);
+
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
@@ -2283,6 +2342,8 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 		       struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2297,11 +2358,27 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (new_policy->min > new_policy->max)
 		return -EINVAL;
 
+	/*
+	 * PM QoS framework collects all the requests from users and provide us
+	 * the final aggregated value here.
+	 */
+	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
+	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
+
+	if (min > new_policy->min)
+		new_policy->min = min;
+	if (max < new_policy->max)
+		new_policy->max = max;
+
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
 	if (ret)
 		return ret;
 
+	/*
+	 * The notifier-chain shall be removed once all the users of
+	 * CPUFREQ_ADJUST are moved to use the QoS framework.
+	 */
 	/* adjust if necessary - all reasons */
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 			CPUFREQ_ADJUST, new_policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a1467aa7f58b..95425941f46d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -147,6 +147,9 @@ struct cpufreq_policy {
 
 	/* Pointer to the cooling device if used for thermal mitigation */
 	struct thermal_cooling_device *cdev;
+
+	struct notifier_block nb_min;
+	struct notifier_block nb_max;
 };
 
 struct cpufreq_freqs {
-- 
2.21.0.rc0.269.g1a574e7a288b

