Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BAB32939F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 22:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbhCAV30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Mar 2021 16:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbhCAV0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 16:26:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A00C061797
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 13:23:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so17683307wrx.4
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 13:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sdnHaT3I7vtPWrLDYXle+T3/u+KhICKSoOfF0Pa49SM=;
        b=tMEqfybU8jcTMuQYqHi/FVJEJEFJa1aXyPm5didxskFKVcEYE4qZ9dE+2LQzs2CN+f
         QNgpvyX3h4+MgI7hJ0rgtzYMSFxAG1XE4rm06kO2bV9gU2fZigBBzoBekyjb6sj9Fekk
         LIQCD7DvB3r9S+dqlYwsIoLlThvT+ei0bAiU8qh7A22SYWgGYHloITKtOLD3XC+lwsX7
         uQWo2KYJeRfJ17QkAy1SNJylRjLAJYgsMMRs97W+06m7mNDuCwCW7Tvhygcfo0CI/h90
         nht35jgrdiCP5/u90x71YJl2eH+XDeKU0fEhvRQmcDsQHg/FHZ3kXSaulAjAyRBf+EdW
         Euaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sdnHaT3I7vtPWrLDYXle+T3/u+KhICKSoOfF0Pa49SM=;
        b=cmHs7P7hLNCrcS33rStgqfz33gsovmgEOO28Vjm9rS+YE2XXnk/u5DMNvSz8jnKVuR
         TmmrQfYqh2yeaBcYEBVvsjVrdToRLK6PZFO1zRZGdKUJX2fsH8Vu/sEDc40BH6oSvYdJ
         GsvvYKxP/qSRDKkc0COpoi7LT2DWgIZq/nsIygNwW62Af2k9EW31g6c8eq0Ca2mlF1Dd
         EpRna1mODjxzfzdeYefxDzLScGbYnUiWLdEELZyWT+jzkWB2X1fejqFHSB0nUqeynheP
         ZPZ0mPtch9cRgeAtvTPrSJtoagILwrpkhwaw9xs41vUG4PdIHYtLDKRW7wtnohdwxGQE
         HVzQ==
X-Gm-Message-State: AOAM533orcHX1Bw0QGXLSfN1O4dnA4PuqU8qy52gUqD5wJtAu1LrHVzu
        0x6dxSaXDUj73RQqqZcgahmuhQ==
X-Google-Smtp-Source: ABdhPJybBLsigRNp+P/eLZwDvnkzDLaEdH6OP/s1k7DrsuiC6ffAIrQi6ok6YdEUvJF50QCLS2A46g==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr17155686wrr.30.1614633786486;
        Mon, 01 Mar 2021 13:23:06 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.gmail.com with ESMTPSA id o11sm6783866wrq.74.2021.03.01.13.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:23:06 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 4/5] powercap/drivers/dtpm: Use container_of instead of a private data field
Date:   Mon,  1 Mar 2021 22:21:48 +0100
Message-Id: <20210301212149.22877-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301212149.22877-1-daniel.lezcano@linaro.org>
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
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
---
 drivers/powercap/dtpm.c     | 27 ++++++++++------------
 drivers/powercap/dtpm_cpu.c | 46 ++++++++++++++++++-------------------
 include/linux/dtpm.h        |  3 +--
 3 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index a1a70dc48f63..40157e720263 100644
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
@@ -495,16 +498,12 @@ static struct powercap_zone_ops zone_ops = {
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
@@ -512,8 +511,6 @@ struct dtpm *dtpm_alloc(struct dtpm_ops *ops)
 		dtpm->weight = 1024;
 		dtpm->ops = ops;
 	}
-
-	return dtpm;
 }
 
 /**
@@ -605,7 +602,7 @@ int dtpm_create(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 	return 0;
 }
 
-static int __init dtpm_init(void)
+static int __init init_dtpm(void)
 {
 	struct dtpm_descr *dtpm_descr;
 
@@ -620,4 +617,4 @@ static int __init dtpm_init(void)
 
 	return 0;
 }
-late_initcall(dtpm_init);
+late_initcall(init_dtpm);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index c5fe98eeec52..e728ebd6d0ca 100644
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
 
 static int upt_pd_power_uw(struct dtpm *dtpm)
 {
-	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
 	struct cpumask cpus;
 	int nr_cpus;
@@ -111,7 +117,7 @@ static int upt_pd_power_uw(struct dtpm *dtpm)
 
 static void pd_release(struct dtpm *dtpm)
 {
-	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 
 	if (freq_qos_request_active(&dtpm_cpu->qos_req))
 		freq_qos_remove_request(&dtpm_cpu->qos_req);
@@ -130,7 +136,7 @@ static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 {
 	struct cpumask cpus;
 	struct em_perf_domain *pd;
-	struct dtpm *dtpm;
+	struct dtpm_cpu *dtpm_cpu;
 
 	pd = em_cpu_get(cpu);
 	if (!pd)
@@ -138,14 +144,13 @@ static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
 
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
@@ -160,27 +165,23 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
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
 
@@ -195,15 +196,12 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
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
index 8a2dbbc334b9..bebb1c9a94c7 100644
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

