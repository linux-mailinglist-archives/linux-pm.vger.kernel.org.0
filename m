Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374B12174E2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 19:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGRPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 13:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGGRPH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 13:15:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32ABC061755
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 10:15:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so34748559wrl.8
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fsknguNoZ07OoFgJVvUKLRv6z8mZoUKYL4RqNUVZ7W8=;
        b=oDnQRNKejXpefTAv1Mu/maBHrGFh6PZw9UoRBMsqsUlsVAhriYzTQbqctAgtrG0CpU
         DhR5gQIKEA10m+1Hkg4hqXi8H+JcL/npW8WXib44VHmv6wssSlv+XlkMIdvfyVrSjFEi
         BChZaDrTUJAc2furwO6/K+/h3wKfwNlScjeZcxUAchK6vax7JBmjWJi3o+rlNu+YEFbD
         TBHGNk7/8kusnBJ5k+3uAVCIjCM5laCjF+R22ZgMJiq0ZPxw28zabrQctF6+3xl1a0fE
         OGQOA+jzk0Xc2ySnWrh30Ap55+MIjpziVYbM0VnPjGIHZcpqKHg3hvnJG5Yti3+w+feh
         34yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fsknguNoZ07OoFgJVvUKLRv6z8mZoUKYL4RqNUVZ7W8=;
        b=krgsUWJvPx4L1gbwLOyH2fXGgyATaabALxl2XUJlZFVqVx18buCo42wlSRh/ORFsJP
         fvGcwhKvBUa3M/JszCMZiG4NMoHipJQBa64dLFqg6412WjaMAyW2wIoKCA5PFF4jkMCT
         siF1B9i6s/vMgv/zHCVdgbD5KPHH/CMRV2OzEY8BdI0k1vE5B4MjpDsKtknvtd9gIXL7
         aJk0AHBtuvuCsn4DYDvdklkelQfuI+7hrkpaLvdOxrbZqg38GLxwUWanaLwUpToVRzTh
         KqIYXUk6Wd/RWRxjCtb8cWYWhia8fENEA8DnWnZUEvXcQqktxSFLL99MFFCW9JFWs81K
         xfxg==
X-Gm-Message-State: AOAM533p2ZBgvWfx/kKo+Sfh8rW1ouaizKxE+9MStJcCvbCI4UGP3XbF
        jnKHB82kf8NG+Wg5V72M3MnKqQ==
X-Google-Smtp-Source: ABdhPJwPHuJj6lewHF14r9syR3uPj4ORQXiDmSFnOg8KJD8E/ETdp57lspatmrGj+NHaJTgXSGC0sw==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr19194826wrv.328.1594142105103;
        Tue, 07 Jul 2020 10:15:05 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id w128sm2237575wmb.19.2020.07.07.10.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:15:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, lukasz.luba@arm.com
Cc:     amit.kucheria@linaro.org, srinivas.pandruvada@linux.intel.com,
        rkumbako@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH RFC] powercap/drivers/energy_model: protocode: Add powercap energy model based
Date:   Tue,  7 Jul 2020 19:14:57 +0200
Message-Id: <20200707171457.31540-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On the embedded world, the complexity of the SoC leads to an
increasing number of hotspots which need to be monitored and mitigated
as a whole in order to prevent the temperature to go above the
normative and legally stated 'skin temperature'.

Another aspect is to sustain the performance for a given power budget,
for example virtual reality where the user can feel dizziness if the
GPU performance is capped while a big CPU is processing something
else. Or reduce the battery charging because the dissipated power is
too high compared with the power consumed by other devices.

Nowadays, the current thermal daemons are abusing the thermal
framework cooling device state to force a specific and arbitraty state
without taking care of the governor decisions. Given the closed loop
of some governors that can confuse the logic or directly enter in
a decision conflict.

As the number of cooling device support is limited today to the CPU
and the GPU, the thermal daemons have little control on the power
dissipation of the system. The out of tree solutions are hacking
around here and there in the drivers, in the frameworks to have
control on the devices.

The recent introduction of the energy model allows to get power
information related to a gpu or a cpu device with a limited support.

Thanks of the current work of Lukasz Luba:

       https://lkml.org/lkml/2020/5/27/406

The energy model is now being improved to be generic and extended to
all devices, so giving the opportunity to SoC vendor to define the
device energy model.

On the other side, the powercap infrastructure is a perfect fit to define
power constraints in a hierarchical way.

The proposal is to use the powercap framework with the energy model in
order to create a hierarchy of constraints the SoC vendor is able to
define and assign a power budget on some nodes to cap the power.

Example of constraints hierarchy:

Soc
  |
  |-- gpu
  |
  `-- package
        |
	|-- perfdomain0
	|         |
	|         |-- cpu0
	|         |
	|         |-- cpu1
	|         |
	|         |-- cpu2
	|         |
	|         `-- cpu3
	|
	`-- perfdomain1
	          |
		  |-- cpu4
		  |
		  `-- cpu5

The leaves of the tree are the real devices, the intermediate nodes
are virtual, aggregating the children constraints and power
characteristics.

For example: cpu[0-3] have 179mW max, 'perfdomain0' has 716mW max,
cpu[4-5] have 1130mw max each, 'perfordomain1' has 2260mW. It results
'package' has 2260 + 716 = 2976mW max.

Each node have a weight on a 2^10 basis, in order to reflect the
percentage of power distribution of the children's node. This
percentage is used to dispatch the power limit to the children.

For example: package has 2976mW max, the weigths for the children are:

  perfdomain0: (716 * 1024) / 2976 = 246
  perfdomain1: (2260 * 1024) / 2976 = 778

If we want to apply a power limit constraint of 1500mW at the package
level, the power limit will be distributed along the children as:

  perfdomain0: (1500 * 246) / 1024 = 360mW
  perfdomain1: (1500 * 778) / 1024 = 1140mW

This simple approach allows to do a fair distribution of the power
limit but it will be replaced by a more complex mechanism where the
power limit will be dynamically adjusted depending on the power
consumption of the different devices. This is an algorithm with auto
power balancing with unused power. When an allocated power budget is
not used by a device, the siblings can share this free power until the
device needs more power.

The algorithm was presented during the ELC:

https://ossna2020.sched.com/event/c3Wf/ideas-for-finer-grained-control-over-your-heat-budget-amit-kucheria-daniel-lezcano-linaro

Given the complexity of the code, it sounds reasonable to provide a
first stone of the edifice allowing at least the thermal daemons to
stop abusing the thermal framework where the primary goal is to
protect the silicone, not cap the power.

However, one question remains: how do we describe the hierarchy?

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig       |   8 +
 drivers/powercap/Makefile      |   1 +
 drivers/powercap/powercap_em.c | 485 +++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h     |   1 +
 4 files changed, 495 insertions(+)
 create mode 100644 drivers/powercap/powercap_em.c

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index ebc4d4578339..57f2e9f31560 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -43,4 +43,12 @@ config IDLE_INJECT
 	  CPUs for power capping. Idle period can be injected
 	  synchronously on a set of specified CPUs or alternatively
 	  on a per CPU basis.
+
+config POWERCAP_EM
+        bool "Energy model based power capping"
+	depends on ENERGY_MODEL
+	default y
+	help
+	  This enables support for the power capping using the energy
+	  model and the associated per device performance state.
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 7255c94ec61c..d9fa1255a499 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
+obj-$(CONFIG_POWERCAP_EM) += powercap_em.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
 obj-$(CONFIG_IDLE_INJECT) += idle_inject.o
diff --git a/drivers/powercap/powercap_em.c b/drivers/powercap/powercap_em.c
new file mode 100644
index 000000000000..a5252d32c4e9
--- /dev/null
+++ b/drivers/powercap/powercap_em.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpumask.h>
+#include <linux/cpufreq.h>
+#include <linux/cpuhotplug.h>
+#include <linux/device.h>
+#include <linux/energy_model.h>
+#include <linux/hrtimer.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm_qos.h>
+#include <linux/powercap.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
+#include <linux/units.h>
+
+struct powercap_em {
+	struct powercap_zone zone;
+	struct powercap_em *parent;
+	struct list_head sibling;
+	struct list_head children;
+	struct freq_qos_request qos_req;
+	spinlock_t lock;
+	bool mode;
+	u64 power_limit;
+	u64 power_max;
+	u64 power_min;
+	int weight;
+	int cpu;
+};
+
+static const char *constraint_name[] = {
+	"Performance capping",
+};
+
+static struct powercap_control_type *pct;
+static struct powercap_em *pc_soc;
+static struct powercap_em *pc_package;
+
+struct powercap_em *to_powercap_em(struct powercap_zone *zone)
+{
+	return container_of(zone, struct powercap_em, zone);
+}
+
+/*
+ * Browse the powercap nodes of the tree and rebalance their
+ * weigths. This function is called when a node is inserted or
+ * deleted.
+ */
+static void powercap_em_rebalance_weight(struct powercap_em *pcem)
+{
+	struct powercap_em *child;
+
+	spin_lock(&pcem->lock);
+	list_for_each_entry(child, &pcem->children, sibling) {
+
+		child->weight = (child->power_max * 1024) / pcem->power_max;
+
+		powercap_em_rebalance_weight(child);
+	}
+	spin_unlock(&pcem->lock);
+}
+
+/*
+ * Initialize the energy model powercap zone by calling the underlying
+ * powercap register function followed by the specific allocations.
+ */
+static struct powercap_em *
+powercap_em_register(struct powercap_control_type *control_type,
+		     const char *name,
+		     struct powercap_em *parent,
+		     const struct powercap_zone_ops *ops,
+		     int nr_constraints,
+		     const struct powercap_zone_constraint_ops *const_ops)
+{
+	struct powercap_em *pcem;
+	struct powercap_zone *pcz;
+
+	pcem = kzalloc(sizeof(*pcem), GFP_KERNEL);
+	if (!pcem)
+		return NULL;
+
+	INIT_LIST_HEAD(&pcem->children);
+	INIT_LIST_HEAD(&pcem->sibling);
+	spin_lock_init(&pcem->lock);
+
+	pcz = powercap_register_zone(&pcem->zone, control_type, name,
+				     parent ? &parent->zone : NULL,
+				     ops, nr_constraints, const_ops);
+	if (IS_ERR(pcz)) {
+		kfree(pcem);
+		return NULL;
+	}
+
+	/*
+	 * The root node does not have a parent
+	 */
+	if (parent) {
+		spin_lock(&parent->lock);
+		list_add_tail(&pcem->sibling, &parent->children);
+		spin_unlock(&parent->lock);
+		pcem->parent = parent;
+	}
+
+	return pcem;
+}
+
+/*
+ * When a new powercap zone is inserted, propagate its power numbers
+ * to the parents.
+ */
+static int powercap_em_set_power_range(struct powercap_em *pcem,
+				       struct em_perf_domain *em)
+{
+	struct powercap_em *parent = pcem->parent;
+	int nr_cpus = cpumask_weight(to_cpumask(em->cpus));
+
+	if (pcem->power_min || pcem->power_max)
+		return -EINVAL;
+
+	pcem->power_min = em->table[0].power;
+	pcem->power_min *= MICROWATT_PER_MILLIWATT;
+	pcem->power_min *= nr_cpus;
+
+	pcem->power_max = em->table[em->nr_cap_states - 1].power;
+	pcem->power_max *= MICROWATT_PER_MILLIWATT;
+	pcem->power_max *= nr_cpus;
+
+	while (parent) {
+		spin_lock(&parent->lock);
+		parent->power_min += pcem->power_min;
+		parent->power_max += pcem->power_max;
+		spin_unlock(&parent->lock);
+		parent = parent->parent;
+	}
+
+	return 0;
+}
+
+static int get_max_power_range_uw(struct powercap_zone *pcz, u64 *max_power_uw)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+
+	spin_lock(&pcem->lock);
+	*max_power_uw = pcem->power_max;
+	spin_unlock(&pcem->lock);
+
+	return 0;
+}
+
+static int get_pd_power_uw(struct powercap_zone *pcz, u64 *power_uw)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+	struct em_perf_domain *pd;
+	unsigned long freq;
+	int i, nr_cpus;
+
+	freq = cpufreq_quick_get(pcem->cpu);
+	pd = em_cpu_get(pcem->cpu);
+	nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
+
+	for (i = 0; i < pd->nr_cap_states; i++) {
+
+		if (pd->table[i].frequency < freq)
+			continue;
+
+		*power_uw = pd->table[i].power *
+			MICROWATT_PER_MILLIWATT * nr_cpus;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int get_children_power_uw(struct powercap_zone *pcz, u64 *power_uw)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+	struct powercap_em *child;
+	u64 power;
+	int ret = 0;
+
+	*power_uw = 0;
+
+	spin_lock(&pcem->lock);
+	list_for_each_entry(child, &pcem->children, sibling) {
+		ret = child->zone.ops->get_power_uw(&child->zone, &power);
+		if (ret)
+			break;
+		*power_uw += power;
+	}
+	spin_unlock(&pcem->lock);
+
+	return ret;
+}
+
+static int set_domain_enable(struct powercap_zone *pcz, bool mode)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+	struct cpufreq_policy *policy;
+	struct em_perf_domain *pd;
+	int ret;
+
+	if (mode) {
+		policy = cpufreq_cpu_get(pcem->cpu);
+		if (!policy)
+			return -EINVAL;
+
+		pd = em_cpu_get(pcem->cpu);
+		if (!pd)
+			return -EINVAL;
+
+		ret = freq_qos_add_request(&policy->constraints,
+					   &pcem->qos_req, FREQ_QOS_MAX,
+					   pd->table[pd->nr_cap_states - 1].frequency);
+		if (ret)
+			return ret;
+
+	} else {
+		freq_qos_remove_request(&pcem->qos_req);
+	}
+
+	pcem->mode = mode;
+
+	powercap_em_rebalance_weight(pc_soc);
+
+	return 0;
+}
+
+static int get_domain_enable(struct powercap_zone *pcz, bool *mode)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+
+	*mode = pcem->mode;
+
+	return 0;
+}
+
+static int release_zone(struct powercap_zone *pcz)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+
+	if (!list_empty(&pcem->children))
+		return -EBUSY;
+
+	freq_qos_remove_request(&pcem->qos_req);
+	list_del(&pcem->sibling);
+	kfree(pcem);
+	powercap_em_rebalance_weight(pc_soc);
+
+	return 0;
+}
+
+/*
+ * Set the power limit on the nodes, the power limit is distributed
+ * given the weight of the children.
+ */
+static int set_children_power_limit(struct powercap_zone *pcz, int cid,
+				    u64 power_limit)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+	struct powercap_em *child;
+	u64 power;
+	int ret = 0;
+
+	/*
+	 * Don't allow values outside of the power range previously
+	 * set when initiliazing the powercap energy model zone
+	 */
+	pcem->power_limit = clamp_val(power_limit,
+				      pcem->power_min,
+				      pcem->power_max);
+
+	spin_lock(&pcem->lock);
+	list_for_each_entry(child, &pcem->children, sibling) {
+
+		power = (pcem->power_limit * child->weight) / 1024;
+
+		ret = child->zone.constraints->ops->set_power_limit_uw(
+			&child->zone, cid, power);
+		if (ret)
+			break;
+	}
+	spin_unlock(&pcem->lock);
+
+
+	return ret;
+}
+
+static int get_children_power_limit(struct powercap_zone *pcz, int cid, u64 *data)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+	struct powercap_em *child;
+	u64 power;
+	int ret = 0;
+
+	*data = 0;
+
+	spin_lock(&pcem->lock);
+	list_for_each_entry(child, &pcem->children, sibling) {
+		ret = child->zone.constraints->ops->get_power_limit_uw(
+			&child->zone, cid, &power);
+		if (ret)
+			break;
+		*data += power;
+	}
+	spin_unlock(&pcem->lock);
+
+	return ret;
+}
+
+static const char *get_constraint_name(struct powercap_zone *pcz, int cid)
+{
+	return constraint_name[cid];
+}
+
+static int set_pd_power_limit(struct powercap_zone *pcz, int cid,
+			       u64 power_limit)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+	struct em_perf_domain *pd;
+	unsigned long frequency;
+	int i, nr_cpus;
+
+	spin_lock(&pcem->lock);
+
+	power_limit = clamp_val(power_limit, pcem->power_min, pcem->power_max);
+
+	pd = em_cpu_get(pcem->cpu);
+
+	nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
+
+	for (i = 0, frequency = pd->table[0].frequency; i < pd->nr_cap_states; i++) {
+
+		u64 power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+
+		if ((power * nr_cpus) > power_limit)
+			break;
+
+		frequency = pd->table[i].frequency;
+	}
+
+	freq_qos_update_request(&pcem->qos_req, frequency);
+
+	pcem->power_limit = power_limit;
+
+	spin_unlock(&pcem->lock);
+
+	return 0;
+}
+
+static int get_pd_power_limit(struct powercap_zone *pcz, int cid, u64 *data)
+{
+	struct powercap_em *pcem = to_powercap_em(pcz);
+
+	spin_lock(&pcem->lock);
+	*data = pcem->power_limit ? pcem->power_limit : pcem->power_max;
+	spin_unlock(&pcem->lock);
+
+	return 0;
+}
+
+static int set_time_window(struct powercap_zone *pcz, int cid, u64 window)
+{
+	return -ENOSYS;
+}
+
+
+static int get_time_window(struct powercap_zone *pcz, int cid, u64 *data)
+{
+	*data = 0;
+
+	return 0;
+}
+
+static int get_max_power_uw(struct powercap_zone *pcz, int id, u64 *data)
+{
+	return get_max_power_range_uw(pcz, data);
+}
+
+static const struct powercap_zone_constraint_ops constraint_ops = {
+	.set_power_limit_uw = set_children_power_limit,
+	.get_power_limit_uw = get_children_power_limit,
+	.set_time_window_us = set_time_window,
+	.get_time_window_us = get_time_window,
+	.get_max_power_uw = get_max_power_uw,
+	.get_name = get_constraint_name,
+};
+
+static const struct powercap_zone_constraint_ops pd_constraint_ops = {
+	.set_power_limit_uw = set_pd_power_limit,
+	.get_power_limit_uw = get_pd_power_limit,
+	.set_time_window_us = set_time_window,
+	.get_time_window_us = get_time_window,
+	.get_max_power_uw = get_max_power_uw,
+	.get_name = get_constraint_name,
+};
+
+static const struct powercap_zone_ops zone_ops = {
+	.get_max_power_range_uw = get_max_power_range_uw,
+	.get_power_uw = get_children_power_uw,
+	.set_enable = set_domain_enable,
+	.get_enable = get_domain_enable,
+	.release = release_zone,
+};
+
+static const struct powercap_zone_ops pd_zone_ops = {
+	.get_max_power_range_uw = get_max_power_range_uw,
+	.get_power_uw = get_pd_power_uw,
+	.set_enable = set_domain_enable,
+	.get_enable = get_domain_enable,
+	.release = release_zone,
+};
+
+static int cpuhp_powercap_em_online(unsigned int cpu)
+{
+        struct powercap_em *pcem;
+	struct cpufreq_policy *policy;
+	struct em_perf_domain *pd;
+	char name[CPUFREQ_NAME_LEN];
+	int ret;
+
+	policy = cpufreq_cpu_get(cpu);
+
+	if (!policy || cpumask_first(policy->related_cpus) != cpu)
+		return 0;
+
+	pd = em_cpu_get(cpu);
+	if (!pd)
+		return -EINVAL;
+
+	sprintf(name, "policy%d", cpu);
+
+	pcem = powercap_em_register(pct, name, pc_package,
+				    &pd_zone_ops, 1, &pd_constraint_ops);
+	if (!pcem)
+		return -EINVAL;
+
+	ret = powercap_em_set_power_range(pcem, pd);
+	if (ret)
+		return ret;
+
+	pcem->cpu = cpu;
+
+	ret = freq_qos_add_request(&policy->constraints,
+				   &pcem->qos_req, FREQ_QOS_MAX,
+				   pd->table[pd->nr_cap_states - 1].frequency);
+
+	powercap_em_rebalance_weight(pc_soc);
+
+	return ret;
+}
+
+static int __init powercap_em_init(void)
+{
+	pct = powercap_register_control_type(NULL, "energy_model", NULL);
+	if (!pct) {
+		pr_err("Failed to register control type\n");
+		return -EINVAL;
+	}
+
+	pc_soc = powercap_em_register(pct, "soc", NULL,
+				      &zone_ops, 1, &constraint_ops);
+	if (!pc_soc)
+		return -EINVAL;
+
+	pc_package = powercap_em_register(pct, "package", pc_soc,
+					  &zone_ops, 1, &constraint_ops);
+	if (!pc_package)
+		return -EINVAL;
+
+	return cpuhp_setup_state(CPUHP_AP_POWERCAP_EM_ONLINE,
+				 "powercap_em:online",
+				 cpuhp_powercap_em_online, NULL);
+}
+late_initcall(powercap_em_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 191772d4a4d7..09fe4e1b430e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -189,6 +189,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
+	CPUHP_AP_POWERCAP_EM_ONLINE,
 	CPUHP_AP_ACTIVE,
 	CPUHP_ONLINE,
 };
-- 
2.17.1

