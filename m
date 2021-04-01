Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91F351FB2
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhDATY6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 15:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbhDATYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 15:24:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C330C0319DC
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 11:37:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so3349642wmc.0
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uwNzOty3eBxNeuagxO2LQDxnjzwQ2p6EJivjUhMa5vU=;
        b=lPOgDaPFIBlbRUC8Pzy/T/tkdThYFu5XRLs1q3chxemhB/rfthPnUv9UmDYT0xdf1n
         mltTvAMZnXRboOBvqrBdSEmiGdiRNzAgklPVZ9EL64qQu7g0a/80DNKNGy4uXdmG4j0V
         k2paKJ7rS6qfRx2JlJjyyGJoSXjGP2aC0FmNum5qGAqOYiUFEbUe2ZGiSXVVoc3l3IhY
         pt3SFvdIiH0eh1Jdu7ho5lFzcsjlKrXz4cZvJdp7igU/rPzpEqFFQsKQWVK4FAlIoBbd
         a50alfMUtlv+ogWZEnbk0kQh4x3j7btuIik+ulN5xjYEDVnP6emu/Q9wJDVr8q/bL7iX
         YFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uwNzOty3eBxNeuagxO2LQDxnjzwQ2p6EJivjUhMa5vU=;
        b=MTAh5dafBFfjYEJx5SlMWQmg3lGnc+QWwjKgzhqn3yt7p64lk4mLBnF8acyGLGTYIs
         kpZGPAKSgdrCfNqtzAnSMjO20tMB+d8ATotoSSGSUEVc6BbTelIhr1Wap+Q5aPJl8bRd
         3tFSA8mDL9JwEdusjhK5Lq2j9+5uodU5vl70YRON8HDVg/N6JIkyF9GcRG3IXuGCkOBU
         fKnPueRekwLSM/6SjMbV6McroeQuY5H17B+mcmOUjLLTMFF7hVudHzbnjNcT6L47fKGh
         0Zx6aOtxgr9Jo/cntTrdo+0/A7BChU4TxIGRf/MvMuCrKYibumhT2Oz+tBC43ZCGP3N0
         4ObA==
X-Gm-Message-State: AOAM532prCHb/h2jTU/aZ1AJWnw+RILfAgBft10uCP5nRxcP4NSkpNys
        Gjc6OPPjM8CKoyHfy7zk+wi0RmOh8liTWw==
X-Google-Smtp-Source: ABdhPJxVvLukiZV/7iFXb2qX+I4ksysrdREJyjsnn08BzMZDdpBC2wNWVdGc5DkYeQW4BnErfXNOEA==
X-Received: by 2002:a05:600c:4f89:: with SMTP id n9mr9506151wmq.133.1617302232194;
        Thu, 01 Apr 2021 11:37:12 -0700 (PDT)
Received: from localhost.localdomain ([82.142.26.252])
        by smtp.gmail.com with ESMTPSA id b131sm9111490wmb.34.2021.04.01.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 11:37:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v6 4/7] powercap/drivers/dtpm: Use container_of instead of a private data field
Date:   Thu,  1 Apr 2021 20:36:51 +0200
Message-Id: <20210401183654.27214-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401183654.27214-1-daniel.lezcano@linaro.org>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
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
 drivers/powercap/dtpm.c     | 18 +++++----------
 drivers/powercap/dtpm_cpu.c | 46 ++++++++++++++++++-------------------
 include/linux/dtpm.h        |  3 +--
 3 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index d9aac107c927..b389bc397cdf 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -473,24 +473,18 @@ static struct powercap_zone_ops zone_ops = {
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
 		dtpm->weight = 1024;
 		dtpm->ops = ops;
 	}
-
-	return dtpm;
 }
 
 /**
@@ -581,7 +575,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	return 0;
 }
 
-static int __init dtpm_init(void)
+static int __init init_dtpm(void)
 {
 	struct dtpm_descr *dtpm_descr;
 
@@ -596,4 +590,4 @@ static int __init dtpm_init(void)
 
 	return 0;
 }
-late_initcall(dtpm_init);
+late_initcall(init_dtpm);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 74b39a1082e5..f4092d1b01d7 100644
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
 
 	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_add(name, dtpm);
+	ret = dtpm_add(name, &dtpm_cpu->dtpm);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
@@ -192,15 +193,12 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 out_dtpm_del:
 	dtpm_del(name);
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
index 2ec2821111d1..e47bd5bbf56e 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -23,7 +23,6 @@ struct dtpm {
 	u64 power_max;
 	u64 power_min;
 	int weight;
-	void *private;
 };
 
 struct dtpm_ops {
@@ -65,7 +64,7 @@ int dtpm_update_power(struct dtpm *dtpm);
 
 int dtpm_release_zone(struct powercap_zone *pcz);
 
-struct dtpm *dtpm_alloc(struct dtpm_ops *ops);
+void dtpm_init(struct dtpm *dtpm, struct dtpm_ops *ops);
 
 void dtpm_unregister(struct dtpm *dtpm);
 
-- 
2.17.1

