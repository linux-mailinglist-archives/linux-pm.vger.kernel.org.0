Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0BD5BAA1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 13:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfGAL0v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 07:26:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36881 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbfGAL0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 07:26:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so7197061plb.4
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2019 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dROVlj93TTPLRT6uezx74xZihEexZU3Wg3j3xsC8+gY=;
        b=BT1t96iSEupEstafHaM5OcOpOWJq1jh6RunK3V02KL+5vTHFuY7mV0T52uezzND5pr
         tJAIWIgl/d5+ZMRY91f3lrIIEMcbN2oNws5MzY0cth7XAiOb8j9SVHMA/CCybXvykRe0
         zjJ6r8tbvjyw1x6SHVvW2pHwrZe1Dx8fjNpA3eKI3Xvf2tu2XR8M3M3ZGpEkZjuzv3dV
         XWWpmE1RmoCgSsJBW+hHngT44vHFmi0RNJBwMu9BxWXak2b1eZ8tRZSTSmzTPQ08vGCj
         HUI2PBl9HUQhUKGK1HufdiDKLPjtxPzE3JaGi0hsZeyGhZTnzl1UDE6C7SJX2DFiHGSb
         OcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dROVlj93TTPLRT6uezx74xZihEexZU3Wg3j3xsC8+gY=;
        b=qgRUwNHysSRnaK4T6+qLwxHoXKtkZWxyEaVBo9ZmiZutydAhfHlAwb24xi30uWOJfl
         UIExpjT1vEzsrDAgPtjuIWnCqjqScoq2gWW9LhCxDUgUUrm22eoKmHh1Yzzk722jzNNF
         Sy13yF3hpvCUErgoAMrPcoWirx3hDlnl3x93uplVOuiUVoJdq+mH1a/eIZTHFhsTvq27
         TIMJ+yjtU01Njb3+bkSwHAbtLHOaTeOGnCcxzfUoeqmAi/dAaLkovTlbqODLiwRSxCNh
         GQZe9dDc3aEbZq1Ik05/vUKFNm4lcEq7pDELp/xB/m7dsd+yEyRum65h7OlP0YR137lk
         fgjQ==
X-Gm-Message-State: APjAAAWs7Ykk8bCFT/aMD+iO1q45Eqx0nF5Qx7IKuEEwQ718K6RAA6LL
        WaOCbX3wyBnqUOwU3CaPe/CRkg==
X-Google-Smtp-Source: APXvYqwOrcthHmhW6hbMnZ4fL6BdbNmfms+7ZG6Tucu5lNiz05Y5fAX4ecHVtruw929TT9F9lscEOQ==
X-Received: by 2002:a17:902:aa8a:: with SMTP id d10mr29046097plr.154.1561980404844;
        Mon, 01 Jul 2019 04:26:44 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id q126sm15303848pfq.123.2019.07.01.04.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:26:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 7/7] cpufreq: Add QoS requests for userspace constraints
Date:   Mon,  1 Jul 2019 16:56:15 +0530
Message-Id: <b97baed927ec309e8061ce2897e891a4420888a6.1561979715.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561979715.git.viresh.kumar@linaro.org>
References: <cover.1561979715.git.viresh.kumar@linaro.org>
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
---
 drivers/cpufreq/cpufreq.c | 87 ++++++++++++++++++++-------------------
 include/linux/cpufreq.h   |  8 +---
 2 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 091789e868ee..13c2f119cc0c 100644
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
 
@@ -1238,6 +1228,12 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_min_qos_notifier;
 	}
 
+	policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
+				       GFP_KERNEL);
+	if (!policy->min_freq_req)
+		goto err_max_qos_notifier;
+
+	policy->max_freq_req = policy->min_freq_req + 1;
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
@@ -1248,6 +1244,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
+err_max_qos_notifier:
+	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
+				   DEV_PM_QOS_MAX_FREQUENCY);
 err_min_qos_notifier:
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
@@ -1283,6 +1282,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
+	dev_pm_qos_remove_request(policy->max_freq_req);
+	dev_pm_qos_remove_request(policy->min_freq_req);
+	kfree(policy->min_freq_req);
 
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
@@ -1361,16 +1363,30 @@ static int cpufreq_online(unsigned int cpu)
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
+		ret = dev_pm_qos_add_request(dev, policy->min_freq_req,
+					     DEV_PM_QOS_MIN_FREQUENCY,
+					     policy->min);
+		if (ret < 0) {
+			dev_err(dev, "Failed to add min-freq constraint (%d)\n",
+				ret);
+			goto out_destroy_policy;
+		}
+
+		ret = dev_pm_qos_add_request(dev, policy->max_freq_req,
+					     DEV_PM_QOS_MAX_FREQUENCY,
+					     policy->max);
+		if (ret < 0) {
+			dev_err(dev, "Failed to add max-freq constraint (%d)\n",
+				ret);
+			goto out_destroy_policy;
+		}
 	}
 
 	if (cpufreq_driver->get && has_target()) {
@@ -2344,7 +2360,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 {
 	struct cpufreq_governor *old_gov;
 	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2352,24 +2367,12 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 
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
@@ -2458,10 +2461,9 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
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
@@ -2521,10 +2523,9 @@ static int cpufreq_boost_set_sw(int state)
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

