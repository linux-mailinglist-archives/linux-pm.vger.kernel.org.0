Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE5E604BF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfGEKwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 06:52:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfGEKwM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 06:52:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so4163156pgk.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIDYV8mZhZsD7MlUb6ge3Loy8e0Hvg52Npd39IL8pBk=;
        b=A6r3FjjXpjXEra/w1mO6d/azgSTIXPFpkrC3kjmoXr6TETjU1NBUuxK0tPNZUHkDCq
         L7xFSO1phgxh23m7mxBPI84+W38lrUfesquSP7KwpOz06ipAwT/OlE6u00/19uwql5EA
         8+V8tqZLmFBLMtmVlbTzy0iFSEJMQ/hE2tAW6i3jfSSn7JMkM6sa1hyih3Y2La5AuvZE
         8q3Oj5pLxSkhbPJ+y9PEPpDnDH+uvvGfLBA1trT5mW9bpcvOgrQwMOZ08swM9/hAOVhh
         unRUc/mQrg1+pTrTg+WyqqTjkeoiSg/bgHh93SGs1hAWV9OgbJyIGsslYo6+SnYa8N0f
         KUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIDYV8mZhZsD7MlUb6ge3Loy8e0Hvg52Npd39IL8pBk=;
        b=eigSm5Sp3YM9I6uaf0QXhMdtItmLMGM7z8baZFean1sVhTpwwgbpByPhZZkhcpZIuu
         2W1Vdye2pOolCH660mB5yG4cOWlHMUSYYSpo8tYrcu0phYFZrJuPc499oVnsabZ3UTp/
         rXlX2hBktciqxylI7ouXMg0VyAwQDMfEIntdVlfBYBh+kkadMq5C59VKRuGqgpfUGklD
         osTxWRUozC0rjvdsJiD/OoylIymVBhNSk6fyYIyySnPP/2C+0WicPqAoeF6EuYEBLYjP
         23VkUXsWLMI8tQNRt99LtGZsu1fRPHmQ1zmRhQEOVnRFBdqztVnAAGV7lUXJXQadNsYG
         Y9yg==
X-Gm-Message-State: APjAAAXOm5QywqDzRt8WbxXUfXev++dnz8osM8kNCt92uVxDLMnnyyOA
        pnos7L5MX0bDKAqi2cdoXlJH4/Uf+z8=
X-Google-Smtp-Source: APXvYqy+PnEw3OXHK/bWTHHeqhQEqzjrlagWcaChljxZseu9UrJkcCUAQj6aPDplPOalXGy90QaE6g==
X-Received: by 2002:a63:221c:: with SMTP id i28mr4832526pgi.114.1562323931337;
        Fri, 05 Jul 2019 03:52:11 -0700 (PDT)
Received: from localhost ([223.226.51.128])
        by smtp.gmail.com with ESMTPSA id i124sm22458799pfe.61.2019.07.05.03.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 03:52:10 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 7/7] cpufreq: Add QoS requests for userspace constraints
Date:   Fri,  5 Jul 2019 16:21:24 +0530
Message-Id: <7589f158a5522ff04ba2b63daca77bcdd4952f74.1562323803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <0d4c2a013b32bf18d45817011b028918220580f5.1562210705.git.viresh.kumar@linaro.org>
References: <0d4c2a013b32bf18d45817011b028918220580f5.1562210705.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This implements QoS requests to manage userspace configuration of min
and max frequency.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
V6->V7:
- We can't call dev_pm_qos_remove_request() for a request which was
  never added. This happened in one of the error paths. Fixed that by
  allocating the requests only right before we try to add them and also
  take care of things properly during errors.

@Rafael: Please apply this version instead of the diff I supplied on the
WARN email earlier. This has proper protection in place at many places.

 drivers/cpufreq/cpufreq.c | 98 ++++++++++++++++++++++-----------------
 include/linux/cpufreq.h   |  8 +---
 2 files changed, 57 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 091789e868ee..a46abd738cfd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -718,23 +718,15 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_##file_name					\
 (struct cpufreq_policy *policy, const char *buf, size_t count)		\
 {									\
-	int ret, temp;							\
-	struct cpufreq_policy new_policy;				\
+	unsigned long val;						\
+	int ret;							\
 									\
-	memcpy(&new_policy, policy, sizeof(*policy));			\
-	new_policy.min = policy->user_policy.min;			\
-	new_policy.max = policy->user_policy.max;			\
-									\
-	ret = sscanf(buf, "%u", &new_policy.object);			\
+	ret = sscanf(buf, "%lu", &val);					\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	temp = new_policy.object;					\
-	ret = cpufreq_set_policy(policy, &new_policy);		\
-	if (!ret)							\
-		policy->user_policy.object = temp;			\
-									\
-	return ret ? ret : count;					\
+	ret = dev_pm_qos_update_request(policy->object##_freq_req, val);\
+	return ret >= 0 ? count : ret;					\
 }
 
 store_one(scaling_min_freq, min);
@@ -1126,8 +1118,6 @@ void refresh_frequency_limits(struct cpufreq_policy *policy)
 		new_policy = *policy;
 		pr_debug("updating policy for CPU %u\n", policy->cpu);
 
-		new_policy.min = policy->user_policy.min;
-		new_policy.max = policy->user_policy.max;
 		cpufreq_set_policy(policy, &new_policy);
 	}
 
@@ -1283,6 +1273,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
+	dev_pm_qos_remove_request(policy->max_freq_req);
+	dev_pm_qos_remove_request(policy->min_freq_req);
+	kfree(policy->min_freq_req);
 
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
@@ -1361,16 +1354,50 @@ static int cpufreq_online(unsigned int cpu)
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
-		policy->user_policy.min = policy->min;
-		policy->user_policy.max = policy->max;
+		struct device *dev = get_cpu_device(cpu);
 
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j);
 		}
-	} else {
-		policy->min = policy->user_policy.min;
-		policy->max = policy->user_policy.max;
+
+		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
+					       GFP_KERNEL);
+		if (!policy->min_freq_req)
+			goto out_destroy_policy;
+
+		ret = dev_pm_qos_add_request(dev, policy->min_freq_req,
+					     DEV_PM_QOS_MIN_FREQUENCY,
+					     policy->min);
+		if (ret < 0) {
+			/*
+			 * So we don't call dev_pm_qos_remove_request() for an
+			 * uninitialized request.
+			 */
+			kfree(policy->min_freq_req);
+			policy->min_freq_req = NULL;
+
+			dev_err(dev, "Failed to add min-freq constraint (%d)\n",
+				ret);
+			goto out_destroy_policy;
+		}
+
+		/*
+		 * This must be initialized right here to avoid calling
+		 * dev_pm_qos_remove_request() on uninitialized request in case
+		 * of errors.
+		 */
+		policy->max_freq_req = policy->min_freq_req + 1;
+
+		ret = dev_pm_qos_add_request(dev, policy->max_freq_req,
+					     DEV_PM_QOS_MAX_FREQUENCY,
+					     policy->max);
+		if (ret < 0) {
+			policy->max_freq_req = NULL;
+			dev_err(dev, "Failed to add max-freq constraint (%d)\n",
+				ret);
+			goto out_destroy_policy;
+		}
 	}
 
 	if (cpufreq_driver->get && has_target()) {
@@ -2344,7 +2371,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_governor *old_gov;
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2352,24 +2378,12 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuinfo));
 
-	/*
-	* This check works well when we store new min/max freq attributes,
-	* because new_policy is a copy of policy with one field updated.
-	*/
-	if (new_policy->min > new_policy->max)
-		return -EINVAL;
-
 	/*
 	 * PM QoS framework collects all the requests from users and provide us
 	 * the final aggregated value here.
 	 */
-	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
-	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
-
-	if (min > new_policy->min)
-		new_policy->min = min;
-	if (max < new_policy->max)
-		new_policy->max = max;
+	new_policy->min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
+	new_policy->max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
 
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
@@ -2458,10 +2472,9 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
  * @cpu: CPU to re-evaluate the policy for.
  *
  * Update the current frequency for the cpufreq policy of @cpu and use
- * cpufreq_set_policy() to re-apply the min and max limits saved in the
- * user_policy sub-structure of that policy, which triggers the evaluation
- * of policy notifiers and the cpufreq driver's ->verify() callback for the
- * policy in question, among other things.
+ * cpufreq_set_policy() to re-apply the min and max limits, which triggers the
+ * evaluation of policy notifiers and the cpufreq driver's ->verify() callback
+ * for the policy in question, among other things.
  */
 void cpufreq_update_policy(unsigned int cpu)
 {
@@ -2521,10 +2534,9 @@ static int cpufreq_boost_set_sw(int state)
 			break;
 		}
 
-		down_write(&policy->rwsem);
-		policy->user_policy.max = policy->max;
-		cpufreq_governor_limits(policy);
-		up_write(&policy->rwsem);
+		ret = dev_pm_qos_update_request(policy->max_freq_req, policy->max);
+		if (ret)
+			break;
 	}
 
 	return ret;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 1fa37b675a80..afc683021ac5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -50,11 +50,6 @@ struct cpufreq_cpuinfo {
 	unsigned int		transition_latency;
 };
 
-struct cpufreq_user_policy {
-	unsigned int		min;    /* in kHz */
-	unsigned int		max;    /* in kHz */
-};
-
 struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
@@ -84,7 +79,8 @@ struct cpufreq_policy {
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
 
-	struct cpufreq_user_policy user_policy;
+	struct dev_pm_qos_request *min_freq_req;
+	struct dev_pm_qos_request *max_freq_req;
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
-- 
2.21.0.rc0.269.g1a574e7a288b

