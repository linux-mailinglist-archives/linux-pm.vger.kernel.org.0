Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507F1333AED
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhCJLCs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhCJLCV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:02:21 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94407C061761
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:02:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j2so22801046wrx.9
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGAdxc5Fb2RB7pZV+JmXUvhQNnyRCNFzDkDAeSmuI2Q=;
        b=HRcp200V8cJIq/KIQKB5usXavn2eG6oRm3TNQK1E41SRfEqvOPo3Z7WG3uKfTZjOrn
         ZjJYq5xQypTHV5YbppkC897cTQhzONM/+pmW5HQeVDVwg50OFm93Wab6VFfeb4aP8rGk
         deABqcK+FMItibPkAP61eOdbBWhdZw9k5lFPWzyFOhJ7EZpPVyyIDJOsvpWFN9TuInwL
         6ZjuWt+YBnWVErrkH2FDABdDYV+RAtRbNiNQ2Zc75h5bdvHpJwF88/KSnhEVFqmc1Kvj
         2BLCIRGvGRA+vjK1qHK0MRnl0PE+1H+Co+h7RTlupS0Y9VyjbHfRf5QDJtBZZJIYa7AA
         hKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGAdxc5Fb2RB7pZV+JmXUvhQNnyRCNFzDkDAeSmuI2Q=;
        b=McDFS9td/NopLbr+RM57EbHaSniNvh0ISEn6nT2R/dW+h2Kzdm2JRKbwYxan3BxNWX
         tgcGyzCMMNi7wmDVGrzoFAtT2+7KoST0pWXfnNNt/xZJrJ+21w9EsmW/cg0bAtYKo7xM
         hZUCDIhdv1MG5FEkrN1+qKztSJFiJwO4WNi4H+pUZHQMydL7Pinrwnpe/1+bO54hr5Bb
         pcMMbg/6esM8KatjyOcsQ+5WiHwGTzgZlspyBaxcLDWwmopsBa2UUd234HixIbUZHFvJ
         decIcHizz6ih34hnruJdI7H5LzZa//oXrFpBi6LnuPL41npOqQud4+EOf/d0TdXVg1KB
         jFjQ==
X-Gm-Message-State: AOAM530lwN8v9CdKV/a75iZJVOu2lzKbud0D9V6McNFvt1Bkoo4IButl
        Du+B5UgEZZFDtcj4tzAHayrhLE+sXva6Ig==
X-Google-Smtp-Source: ABdhPJzYybw6Rt3Z4eqBI3TLxjqiZUjF8QXPrYwDkfezD6N6sdWi0UvsC8wfFRi3Dod4aE8qGCSOUA==
X-Received: by 2002:a5d:52c2:: with SMTP id r2mr3024382wrv.40.1615374139204;
        Wed, 10 Mar 2021 03:02:19 -0800 (PST)
Received: from localhost.localdomain ([82.142.0.212])
        by smtp.gmail.com with ESMTPSA id k4sm36193902wrd.9.2021.03.10.03.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 03:02:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: [PATCH v3 4/5] powercap/drivers/dtpm: Use container_of instead of a private data field
Date:   Wed, 10 Mar 2021 12:02:11 +0100
Message-Id: <20210310110212.26512-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310110212.26512-1-daniel.lezcano@linaro.org>
References: <20210310110212.26512-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dtpm framework provides an API to allocate a dtpm node. However
when a backend dtpm driver needs to allocate a dtpm node it must
define its own structure and store the pointer of this structure in
the private field of the dtpm structure.

It is more elegant to use the container_of macro and add the dtpm
structure inside the dtpm backend specific structure. The code will be
able to deal properly with the dtpm structure as a generic entity,
making all this even more self-encapsulated.

The dtpm_alloc() function does no longer make sense as the dtpm
structure will be allocated when allocating the device specific dtpm
structure. The dtpm_init() is provided instead.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/powercap/dtpm.c     | 27 ++++++++++------------
 drivers/powercap/dtpm_cpu.c | 46 ++++++++++++++++++-------------------
 include/linux/dtpm.h        |  3 +--
 3 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 74d9603bd42a..a4784ac2f79b 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -191,10 +191,13 @@ struct dtpm *dtpm_get(const char *name)
 
 	mutex_lock(&dtpm_lock);
 	dtpm = __dtpm_lookup(name);
-	if (!dtpm)
-		dtpm = dtpm_alloc(NULL);
-	else
+	if (!dtpm) {
+		dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
+		if (dtpm)
+			dtpm_init(dtpm, NULL);
+	} else {
 		kref_get(&dtpm->kref);
+	}
 	mutex_unlock(&dtpm_lock);
 
 	return dtpm;
@@ -498,16 +501,12 @@ static struct powercap_zone_ops zone_ops = {
 };
 
 /**
- * dtpm_alloc - Allocate and initialize a dtpm struct
- * @name: a string specifying the name of the node
- *
- * Return: a struct dtpm pointer, NULL in case of error
+ * dtpm_init - Allocate and initialize a dtpm struct
+ * @dtpm: The dtpm struct pointer to be initialized
+ * @ops: The dtpm device specific ops, NULL for a virtual node
  */
-struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
+void dtpm_init(struct dtpm *dtpm, struct dtpm_ops *ops)
 {
-	struct dtpm *dtpm;
-
-	dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
 	if (dtpm) {
 		INIT_LIST_HEAD(&dtpm->children);
 		INIT_LIST_HEAD(&dtpm->sibling);
@@ -515,8 +514,6 @@ struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
 		dtpm->weight = 1024;
 		dtpm->ops = ops;
 	}
-
-	return dtpm;
 }
 
 /**
@@ -608,7 +605,7 @@ int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	return 0;
 }
 
-static int __init dtpm_init(void)
+static int __init init_dtpm(void)
 {
 	struct dtpm_descr *dtpm_descr;
 
@@ -623,4 +620,4 @@ static int __init dtpm_init(void)
 
 	return 0;
 }
-late_initcall(dtpm_init);
+late_initcall(init_dtpm);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 983f1ca27dc3..ac7f2e7e262f 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -25,16 +25,22 @@
 #include <linux/slab.h>
 #include <linux/units.h>
 
-static DEFINE_PER_CPU(struct dtpm *, dtpm_per_cpu);
-
 struct dtpm_cpu {
+	struct dtpm dtpm;
 	struct freq_qos_request qos_req;
 	int cpu;
 };
 
+static DEFINE_PER_CPU(struct dtpm_cpu *, dtpm_per_cpu);
+
+static struct dtpm_cpu *to_dtpm_cpu(struct dtpm *dtpm)
+{
+	return container_of(dtpm, struct dtpm_cpu, dtpm);
+}
+
 static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 {
-	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
 	struct cpumask cpus;
 	unsigned long freq;
@@ -64,7 +70,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 
 static u64 get_pd_power_uw(struct dtpm *dtpm)
 {
-	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd;
 	struct cpumask cpus;
 	unsigned long freq;
@@ -90,7 +96,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 
 static int update_pd_power_uw(struct dtpm *dtpm)
 {
-	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
 	struct cpumask cpus;
 	int nr_cpus;
@@ -111,7 +117,7 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 
 static void pd_release(struct dtpm *dtpm)
 {
-	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 
 	if (freq_qos_request_active(&dtpm_cpu->qos_req))
 		freq_qos_remove_request(&dtpm_cpu->qos_req);
@@ -129,20 +135,19 @@ static struct dtpm_ops dtpm_ops = {
 static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 {
 	struct em_perf_domain *pd;
-	struct dtpm *dtpm;
+	struct dtpm_cpu *dtpm_cpu;
 
 	pd = em_cpu_get(cpu);
 	if (!pd)
 		return -EINVAL;
 
-	dtpm = per_cpu(dtpm_per_cpu, cpu);
+	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
 
-	return dtpm_update_power(dtpm);
+	return dtpm_update_power(&dtpm_cpu->dtpm);
 }
 
 static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 {
-	struct dtpm *dtpm;
 	struct dtpm_cpu *dtpm_cpu;
 	struct cpufreq_policy *policy;
 	struct em_perf_domain *pd;
@@ -157,27 +162,23 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	if (!pd)
 		return -EINVAL;
 
-	dtpm = per_cpu(dtpm_per_cpu, cpu);
-	if (dtpm)
-		return dtpm_update_power(dtpm);
-
-	dtpm = dtpm_alloc(&dtpm_ops);
-	if (!dtpm)
-		return -EINVAL;
+	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm_cpu)
+		return dtpm_update_power(&dtpm_cpu->dtpm);
 
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
 	if (!dtpm_cpu)
-		goto out_kfree_dtpm;
+		return -ENOMEM;
 
-	dtpm->private = dtpm_cpu;
+	dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
 	dtpm_cpu->cpu = cpu;
 
 	for_each_cpu(cpu, policy->related_cpus)
-		per_cpu(dtpm_per_cpu, cpu) = dtpm;
+		per_cpu(dtpm_per_cpu, cpu) = dtpm_cpu;
 
 	sprintf(name, "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_register(name, dtpm);
+	ret = dtpm_register(name, &dtpm_cpu->dtpm);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
@@ -192,15 +193,12 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 out_dtpm_unregister:
 	dtpm_unregister(name);
 	dtpm_cpu = NULL;
-	dtpm = NULL;
 
 out_kfree_dtpm_cpu:
 	for_each_cpu(cpu, policy->related_cpus)
 		per_cpu(dtpm_per_cpu, cpu) = NULL;
 	kfree(dtpm_cpu);
 
-out_kfree_dtpm:
-	kfree(dtpm);
 	return ret;
 }
 
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 5f71ddc18ee9..4f7ad21291e6 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -24,7 +24,6 @@ struct dtpm {
 	u64 power_max;
 	u64 power_min;
 	int weight;
-	void *private;
 };
 
 struct dtpm_ops {
@@ -66,7 +65,7 @@ int dtpm_update_power(struct dtpm *dtpm);
 
 int dtpm_release_zone(struct powercap_zone *pcz);
 
-struct dtpm *dtpm_alloc(struct dtpm_ops *ops);
+void dtpm_init(struct dtpm *dtpm, struct dtpm_ops *ops);
 
 void dtpm_destroy(struct dtpm *dtpm);
 
-- 
2.17.1

