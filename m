Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4C34FF0A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 13:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhCaLBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 07:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhCaLBE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 07:01:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DFAC061763
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 04:01:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so19217850wrc.3
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Sv35hqDzF6q3d0fFvqaS34YxJ0dsD6UI4ML9lDyS//s=;
        b=xPf2PUAolqhID4ks4fj3HU1QmbatvDZlL+87QpS0Id15KXTIG6uZqAL2FXKSpb+rT+
         kjyrDRF2c9VQkeOC0hKE+pz0w7NCuwv/jtdBSu0o8FtmhC5oKBXWkXnD40l1Xbi0x+LB
         6wJc+hBG2k5koPZ6VabN+9oz24O9wbqWZZWD0X9xEvXsXPLXVSBsqx86QSuNmA22ddY4
         cbowrH4XAGVTyP1/l8yWH1n+TD6/XAlWRDx93KfG2oHj7fi/SYP67BwNS9guGw2ogDWj
         5JkvMTkM9sdscM4Qpg72J+Vu2Q+7WdaMLqchTKhRQ5T/gNtEpOOnJtzRy+ZM9KjvOm0l
         Ga/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sv35hqDzF6q3d0fFvqaS34YxJ0dsD6UI4ML9lDyS//s=;
        b=Ik85Wo3DmHPD7GVC+ioOkcY9nr7/+c4szaXxfl9XmthnHjqgXS4rH+EgTqyP7/O2lA
         KSOz+E50EKGSATpnbQCCJQwwPl6rnS9UmmemfpK/nB14k2ztk88THcnWzUWAQQpIVdaI
         Z5YsWQi2ZqE/k9PMb4zcvRAWpN178ZdFBjwmYMKR+bHGVaQL4kN2e7W82KPu5/i7hWsL
         8I02/LRgMOZ1i1SaegC7xAuL/i1LKtFKjYCUmmcothhzLuGpaMnbiy/F/8/X0A2PMQ2Q
         K2OeqdTNBZRDSfdQ3ud7nmVz9x1/KQ34Mm2Ti0zp0Woejerq03e7Lu0kAYS4UrFpbd3q
         Z5vw==
X-Gm-Message-State: AOAM533AUygNBmOQhbeIVyvP+pn0PYVlMnoUdPYztj88irwqM1Y8TLsn
        XOBirYWr0lbb61bmO82Bynd73A==
X-Google-Smtp-Source: ABdhPJx8/3DGkbnCkcW92IuhBjmMKJNZrm+WKi8w1Knqc/3ofBMIqJ4383fHAUUSPVGBnFn0Sud6qA==
X-Received: by 2002:a05:6000:221:: with SMTP id l1mr3008668wrz.370.1617188462593;
        Wed, 31 Mar 2021 04:01:02 -0700 (PDT)
Received: from localhost.localdomain ([82.142.26.252])
        by smtp.gmail.com with ESMTPSA id u23sm3376275wmn.26.2021.03.31.04.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 04:01:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v5 1/5] powercap/drivers/dtpm: Encapsulate even more the code
Date:   Wed, 31 Mar 2021 13:00:44 +0200
Message-Id: <20210331110048.24956-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to increase the self-encapsulation of the dtpm generic code,
the following changes are adding a power update ops to the dtpm
ops. That allows the generic code to call directly the dtpm backend
function to update the power values.

The power update function does compute the power characteristics when
the function is invoked. In the case of the CPUs, the power
consumption depends on the number of online CPUs. The online CPUs mask
is not up to date at CPUHP_AP_ONLINE_DYN state in the tear down
callback. That is the reason why the online / offline are at separate
state. As there is already an existing state for DTPM, this one is
only moved to the DEAD state, so there is no addition of new state
with these changes. The dtpm node is not removed when the cpu is
unplugged.

That simplifies the code for the next changes and results in a more
self-encapsulated code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
V4:
 - Replaced s/sprintf/snprintf/ for the dtpm node name
V2:
 - Updated the changelog with the CPU node not being removed
 - Commented the cpu hotplug callbacks to explain why there are two callbacks
 - Changed 'upt_power_uw' to 'update_power_uw'
 - Removed unused cpumask variable
---
 drivers/powercap/dtpm.c     |  54 ++++++-------
 drivers/powercap/dtpm_cpu.c | 148 ++++++++++++++++--------------------
 include/linux/cpuhotplug.h  |   2 +-
 include/linux/dtpm.h        |   3 +-
 4 files changed, 97 insertions(+), 110 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index c2185ec5f887..58433b8ef9a1 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -116,8 +116,6 @@ static void __dtpm_sub_power(struct dtpm *dtpm)
 		parent->power_limit -= dtpm->power_limit;
 		parent = parent->parent;
 	}
-
-	__dtpm_rebalance_weight(root);
 }
 
 static void __dtpm_add_power(struct dtpm *dtpm)
@@ -130,45 +128,45 @@ static void __dtpm_add_power(struct dtpm *dtpm)
 		parent->power_limit += dtpm->power_limit;
 		parent = parent->parent;
 	}
+}
+
+static int __dtpm_update_power(struct dtpm *dtpm)
+{
+	int ret;
+
+	__dtpm_sub_power(dtpm);
 
-	__dtpm_rebalance_weight(root);
+	ret = dtpm->ops->update_power_uw(dtpm);
+	if (ret)
+		pr_err("Failed to update power for '%s': %d\n",
+		       dtpm->zone.name, ret);
+
+	if (!test_bit(DTPM_POWER_LIMIT_FLAG, &dtpm->flags))
+		dtpm->power_limit = dtpm->power_max;
+
+	__dtpm_add_power(dtpm);
+
+	if (root)
+		__dtpm_rebalance_weight(root);
+
+	return ret;
 }
 
 /**
  * dtpm_update_power - Update the power on the dtpm
  * @dtpm: a pointer to a dtpm structure to update
- * @power_min: a u64 representing the new power_min value
- * @power_max: a u64 representing the new power_max value
  *
  * Function to update the power values of the dtpm node specified in
  * parameter. These new values will be propagated to the tree.
  *
  * Return: zero on success, -EINVAL if the values are inconsistent
  */
-int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max)
+int dtpm_update_power(struct dtpm *dtpm)
 {
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&dtpm_lock);
-
-	if (power_min == dtpm->power_min && power_max == dtpm->power_max)
-		goto unlock;
-
-	if (power_max < power_min) {
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	__dtpm_sub_power(dtpm);
-
-	dtpm->power_min = power_min;
-	dtpm->power_max = power_max;
-	if (!test_bit(DTPM_POWER_LIMIT_FLAG, &dtpm->flags))
-		dtpm->power_limit = power_max;
-
-	__dtpm_add_power(dtpm);
-
-unlock:
+	ret = __dtpm_update_power(dtpm);
 	mutex_unlock(&dtpm_lock);
 
 	return ret;
@@ -436,6 +434,7 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 
 	if (dtpm->ops && !(dtpm->ops->set_power_uw &&
 			   dtpm->ops->get_power_uw &&
+			   dtpm->ops->update_power_uw &&
 			   dtpm->ops->release))
 		return -EINVAL;
 
@@ -455,7 +454,8 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 		root = dtpm;
 	}
 
-	__dtpm_add_power(dtpm);
+	if (dtpm->ops && !dtpm->ops->update_power_uw(dtpm))
+		__dtpm_add_power(dtpm);
 
 	pr_info("Registered dtpm node '%s' / %llu-%llu uW, \n",
 		dtpm->zone.name, dtpm->power_min, dtpm->power_max);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 51c366938acd..f6076de39540 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -14,6 +14,8 @@
  * The CPU hotplug is supported and the power numbers will be updated
  * if a CPU is hot plugged / unplugged.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/cpumask.h>
 #include <linux/cpufreq.h>
 #include <linux/cpuhotplug.h>
@@ -23,8 +25,6 @@
 #include <linux/slab.h>
 #include <linux/units.h>
 
-static struct dtpm *__parent;
-
 static DEFINE_PER_CPU(struct dtpm *, dtpm_per_cpu);
 
 struct dtpm_cpu {
@@ -32,57 +32,16 @@ struct dtpm_cpu {
 	int cpu;
 };
 
-/*
- * When a new CPU is inserted at hotplug or boot time, add the power
- * contribution and update the dtpm tree.
- */
-static int power_add(struct dtpm *dtpm, struct em_perf_domain *em)
-{
-	u64 power_min, power_max;
-
-	power_min = em->table[0].power;
-	power_min *= MICROWATT_PER_MILLIWATT;
-	power_min += dtpm->power_min;
-
-	power_max = em->table[em->nr_perf_states - 1].power;
-	power_max *= MICROWATT_PER_MILLIWATT;
-	power_max += dtpm->power_max;
-
-	return dtpm_update_power(dtpm, power_min, power_max);
-}
-
-/*
- * When a CPU is unplugged, remove its power contribution from the
- * dtpm tree.
- */
-static int power_sub(struct dtpm *dtpm, struct em_perf_domain *em)
-{
-	u64 power_min, power_max;
-
-	power_min = em->table[0].power;
-	power_min *= MICROWATT_PER_MILLIWATT;
-	power_min = dtpm->power_min - power_min;
-
-	power_max = em->table[em->nr_perf_states - 1].power;
-	power_max *= MICROWATT_PER_MILLIWATT;
-	power_max = dtpm->power_max - power_max;
-
-	return dtpm_update_power(dtpm, power_min, power_max);
-}
-
 static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 {
 	struct dtpm_cpu *dtpm_cpu = dtpm->private;
-	struct em_perf_domain *pd;
+	struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
 	struct cpumask cpus;
 	unsigned long freq;
 	u64 power;
 	int i, nr_cpus;
 
-	pd = em_cpu_get(dtpm_cpu->cpu);
-
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
-
 	nr_cpus = cpumask_weight(&cpus);
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
@@ -113,6 +72,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
 	freq = cpufreq_quick_get(dtpm_cpu->cpu);
+
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
 	nr_cpus = cpumask_weight(&cpus);
 
@@ -128,6 +88,27 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
 	return 0;
 }
 
+static int update_pd_power_uw(struct dtpm *dtpm)
+{
+	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
+	struct cpumask cpus;
+	int nr_cpus;
+
+	cpumask_and(&cpus, cpu_online_mask, to_cpumask(em->cpus));
+	nr_cpus = cpumask_weight(&cpus);
+
+	dtpm->power_min = em->table[0].power;
+	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
+	dtpm->power_min *= nr_cpus;
+
+	dtpm->power_max = em->table[em->nr_perf_states - 1].power;
+	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
+	dtpm->power_max *= nr_cpus;
+
+	return 0;
+}
+
 static void pd_release(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = dtpm->private;
@@ -139,39 +120,24 @@ static void pd_release(struct dtpm *dtpm)
 }
 
 static struct dtpm_ops dtpm_ops = {
-	.set_power_uw = set_pd_power_limit,
-	.get_power_uw = get_pd_power_uw,
-	.release = pd_release,
+	.set_power_uw	 = set_pd_power_limit,
+	.get_power_uw	 = get_pd_power_uw,
+	.update_power_uw = update_pd_power_uw,
+	.release	 = pd_release,
 };
 
 static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 {
-	struct cpufreq_policy *policy;
 	struct em_perf_domain *pd;
 	struct dtpm *dtpm;
 
-	policy = cpufreq_cpu_get(cpu);
-
-	if (!policy)
-		return 0;
-
 	pd = em_cpu_get(cpu);
 	if (!pd)
 		return -EINVAL;
 
 	dtpm = per_cpu(dtpm_per_cpu, cpu);
 
-	power_sub(dtpm, pd);
-
-	if (cpumask_weight(policy->cpus) != 1)
-		return 0;
-
-	for_each_cpu(cpu, policy->related_cpus)
-		per_cpu(dtpm_per_cpu, cpu) = NULL;
-
-	dtpm_unregister(dtpm);
-
-	return 0;
+	return dtpm_update_power(dtpm);
 }
 
 static int cpuhp_dtpm_cpu_online(unsigned int cpu)
@@ -184,7 +150,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	int ret = -ENOMEM;
 
 	policy = cpufreq_cpu_get(cpu);
-
 	if (!policy)
 		return 0;
 
@@ -194,7 +159,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 	dtpm = per_cpu(dtpm_per_cpu, cpu);
 	if (dtpm)
-		return power_add(dtpm, pd);
+		return dtpm_update_power(dtpm);
 
 	dtpm = dtpm_alloc(&dtpm_ops);
 	if (!dtpm)
@@ -210,27 +175,20 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	for_each_cpu(cpu, policy->related_cpus)
 		per_cpu(dtpm_per_cpu, cpu) = dtpm;
 
-	sprintf(name, "cpu%d", dtpm_cpu->cpu);
+	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_register(name, dtpm, __parent);
+	ret = dtpm_register(name, dtpm, NULL);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
-	ret = power_add(dtpm, pd);
-	if (ret)
-		goto out_dtpm_unregister;
-
 	ret = freq_qos_add_request(&policy->constraints,
 				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
 				   pd->table[pd->nr_perf_states - 1].frequency);
 	if (ret)
-		goto out_power_sub;
+		goto out_dtpm_unregister;
 
 	return 0;
 
-out_power_sub:
-	power_sub(dtpm, pd);
-
 out_dtpm_unregister:
 	dtpm_unregister(dtpm);
 	dtpm_cpu = NULL;
@@ -248,10 +206,38 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 int dtpm_register_cpu(struct dtpm *parent)
 {
-	__parent = parent;
+	int ret;
+
+	/*
+	 * The callbacks at CPU hotplug time are calling
+	 * dtpm_update_power() which in turns calls update_pd_power().
+	 *
+	 * The function update_pd_power() uses the online mask to
+	 * figure out the power consumption limits.
+	 *
+	 * At CPUHP_AP_ONLINE_DYN, the CPU is present in the CPU
+	 * online mask when the cpuhp_dtpm_cpu_online function is
+	 * called, but the CPU is still in the online mask for the
+	 * tear down callback. So the power can not be updated when
+	 * the CPU is unplugged.
+	 *
+	 * At CPUHP_AP_DTPM_CPU_DEAD, the situation is the opposite as
+	 * above. The CPU online mask is not up to date when the CPU
+	 * is plugged in.
+	 *
+	 * For this reason, we need to call the online and offline
+	 * callbacks at different moments when the CPU online mask is
+	 * consistent with the power numbers we want to update.
+	 */
+	ret = cpuhp_setup_state(CPUHP_AP_DTPM_CPU_DEAD, "dtpm_cpu:offline",
+				NULL, cpuhp_dtpm_cpu_offline);
+	if (ret < 0)
+		return ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "dtpm_cpu:online",
+				cpuhp_dtpm_cpu_online, NULL);
+	if (ret < 0)
+		return ret;
 
-	return cpuhp_setup_state(CPUHP_AP_DTPM_CPU_ONLINE,
-				 "dtpm_cpu:online",
-				 cpuhp_dtpm_cpu_online,
-				 cpuhp_dtpm_cpu_offline);
+	return 0;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f14adb882338..b9c50c1b5948 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -61,6 +61,7 @@ enum cpuhp_state {
 	CPUHP_LUSTRE_CFS_DEAD,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
 	CPUHP_PADATA_DEAD,
+	CPUHP_AP_DTPM_CPU_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
@@ -195,7 +196,6 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
-	CPUHP_AP_DTPM_CPU_ONLINE,
 	CPUHP_AP_ACTIVE,
 	CPUHP_ONLINE,
 };
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index e80a332e3d8a..acf8d3638988 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -29,6 +29,7 @@ struct dtpm {
 struct dtpm_ops {
 	u64 (*set_power_uw)(struct dtpm *, u64);
 	u64 (*get_power_uw)(struct dtpm *);
+	int (*update_power_uw)(struct dtpm *);
 	void (*release)(struct dtpm *);
 };
 
@@ -62,7 +63,7 @@ static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
 	return container_of(zone, struct dtpm, zone);
 }
 
-int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max);
+int dtpm_update_power(struct dtpm *dtpm);
 
 int dtpm_release_zone(struct powercap_zone *pcz);
 
-- 
2.17.1

