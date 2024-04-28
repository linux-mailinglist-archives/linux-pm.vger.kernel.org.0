Return-Path: <linux-pm+bounces-7236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D858B4AF7
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 11:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314A21F21605
	for <lists+linux-pm@lfdr.de>; Sun, 28 Apr 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8583655E58;
	Sun, 28 Apr 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXLQqcLb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B76B54F92;
	Sun, 28 Apr 2024 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714296284; cv=none; b=tXAhxqBieQXozV7fwj9d1UcYWgBr5j1rAS5+vsEUxqbppaokmay1Pbka6YAQSQwSPgRbZsiVCo5CWwAKVFY4KhvQY9qhK+m1zMqdttUtMCpNcG7AzTFFJuLAsxd1v2xRllS4OJsgKUTCBkwAGRx/8FPwJ9UaUFwoNDsT3J5Uajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714296284; c=relaxed/simple;
	bh=fOVMViRCowtYGdb6HcvJ1U2ynRATs1uHSMV4msG24P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bo+xfSo7DqiiQahcyHDhAB0zi/9aRDQ/yqmqTQoHWgKkHSKoFc3buFORlELh3kenWnXJ1Nmp9n2/4znfDWFGXbjQGzUbl6eSSM30Op+DjCI7i/cgW5K4Ddfp3+L2BpTEWMLO8gqzqOcTlXoPaVvQtIZn5xwj8p++dSTaZ+/MHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXLQqcLb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714296282; x=1745832282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fOVMViRCowtYGdb6HcvJ1U2ynRATs1uHSMV4msG24P8=;
  b=aXLQqcLbIggT1o8BMUQM3XMIpVduFd4GRsRLkLVrAHGMCQyTKyVXpbm1
   DFjjoNSZ+ABBrQPWzsHD5IUiFlvZEstPBEqffiLK3uBZXwoAMhy217+hk
   LE4dDqU+aAZCemmjZdhv+PpbEV6F7W2wB7Ebors02fjEmY/JbAF/rG1yq
   2VRUAKc2eT/iNGje6VXRIE63pElSom/H9p1E38zAWE/WmV/eSAVEfQx3H
   ioAXiFYy3r95TqfHEA59udxYgsatebekLQtoVOVXfGVA+86BBubCwdE2X
   src3Hi7MCh6rSEiPct9jxaHoGiRNGSaDDJBnbijRXwgvwBWXY7K9iZkmV
   A==;
X-CSE-ConnectionGUID: chA7dMSxRY2K9lLEi5TRKQ==
X-CSE-MsgGUID: Fr1gsgCFTMKit05VFJ8I+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21127807"
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="21127807"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 02:24:42 -0700
X-CSE-ConnectionGUID: DcuGUl1HTniK+c+t8XByZw==
X-CSE-MsgGUID: dRfV9WcwQJKyY1eErMWCJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="63303779"
Received: from xingyeyu-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.169.4])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 02:24:38 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH V4 1/2] powercap: intel_rapl: Introduce APIs for PMU support
Date: Sun, 28 Apr 2024 17:24:26 +0800
Message-Id: <20240428092427.24959-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428092427.24959-1-rui.zhang@intel.com>
References: <20240428092427.24959-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two new APIs rapl_package_add_pmu()/rapl_package_remove_pmu().

RAPL driver can invoke these APIs to expose its supported energy
counters via perf PMU. The new RAPL PMU is fully compatible with current
MSR RAPL PMU, including using the same PMU name and events
name/id/unit/scale, etc.

For example, use below command
 perf stat -e power/energy-pkg/ -e power/energy-ram/ FOO
to get the energy consumption if power/energy-pkg/ and power/energy-ram/
events are available in the "perf list" output.

This does not introduce any conflict because TPMI RAPL is the only user
of these APIs currently, and it never co-exists with MSR RAPL.

Note that RAPL Packages can be probed/removed dynamically, and the
events supported by each TPMI RAPL device can be different. Thus the
RAPL PMU support is done on demand, which means
1. PMU is registered only if it is needed by a RAPL Package. PMU events
   for unsupported counters are not exposed.
2. PMU is unregistered and registered when a new RAPL Package is probed
   and supports new counters that are not supported by current PMU.
   For example, on a dual-package system using TPMI RAPL, it is possible
   that Package 1 behaves as TPMI domain root and supports Psys domain.
   In this case, register PMU without Psys event when probing Package 0,
   and re-register the PMU with Psys event when probing Package 1.
3. PMU is unregistered when all registered RAPL Packages don't need PMU.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 582 +++++++++++++++++++++++++++
 include/linux/intel_rapl.h           |  32 ++
 2 files changed, 614 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index c4302caeb631..aac0744011a3 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -15,6 +15,8 @@
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
+#include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/powercap.h>
 #include <linux/processor.h>
@@ -1507,6 +1509,586 @@ static int rapl_detect_domains(struct rapl_package *rp)
 	return 0;
 }
 
+#ifdef CONFIG_PERF_EVENTS
+
+/*
+ * Support for RAPL PMU
+ *
+ * Register a PMU if any of the registered RAPL Packages have the requirement
+ * of exposing its energy counters via Perf PMU.
+ *
+ * PMU Name:
+ *	power
+ *
+ * Events:
+ *	Name		Event id	RAPL Domain
+ *	energy_cores	0x01		RAPL_DOMAIN_PP0
+ *	energy_pkg	0x02		RAPL_DOMAIN_PACKAGE
+ *	energy_ram	0x03		RAPL_DOMAIN_DRAM
+ *	energy_gpu	0x04		RAPL_DOMAIN_PP1
+ *	energy_psys	0x05		RAPL_DOMAIN_PLATFORM
+ *
+ * Unit:
+ *	Joules
+ *
+ * Scale:
+ *	2.3283064365386962890625e-10
+ *	The same RAPL domain in different RAPL Packages may have different
+ *	energy units. Use 2.3283064365386962890625e-10 (2^-32) Joules as
+ *	the fixed unit for all energy counters, and covert each hardware
+ *	counter increase to N times of PMU event counter increases.
+ *
+ * This is fully compatible with the current MSR RAPL PMU. This means that
+ * userspace programs like turbostat can use the same code to handle RAPL Perf
+ * PMU, no matter what RAPL Interface driver (MSR/TPMI, etc) is running
+ * underlying on the platform.
+ *
+ * Note that RAPL Packages can be probed/removed dynamically, and the events
+ * supported by each TPMI RAPL device can be different. Thus the RAPL PMU
+ * support is done on demand, which means
+ * 1. PMU is registered only if it is needed by a RAPL Package. PMU events for
+ *    unsupported counters are not exposed.
+ * 2. PMU is unregistered and registered when a new RAPL Package is probed and
+ *    supports new counters that are not supported by current PMU.
+ * 3. PMU is unregistered when all registered RAPL Packages don't need PMU.
+ */
+
+struct rapl_pmu {
+	struct pmu pmu;			/* Perf PMU structure */
+	u64 timer_ms;			/* Maximum expiration time to avoid counter overflow */
+	unsigned long domain_map;	/* Events supported by current registered PMU */
+	bool registered;		/* Whether the PMU has been registered or not */
+};
+
+static struct rapl_pmu rapl_pmu;
+
+/* PMU helpers */
+
+static int get_pmu_cpu(struct rapl_package *rp)
+{
+	int cpu;
+
+	if (!rp->has_pmu)
+		return nr_cpu_ids;
+
+	/* Only TPMI RAPL is supported for now */
+	if (rp->priv->type != RAPL_IF_TPMI)
+		return nr_cpu_ids;
+
+	/* TPMI RAPL uses any CPU in the package for PMU */
+	for_each_online_cpu(cpu)
+		if (topology_physical_package_id(cpu) == rp->id)
+			return cpu;
+
+	return nr_cpu_ids;
+}
+
+static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
+{
+	if (!rp->has_pmu)
+		return false;
+
+	/* Only TPMI RAPL is supported for now */
+	if (rp->priv->type != RAPL_IF_TPMI)
+		return false;
+
+	/* TPMI RAPL uses any CPU in the package for PMU */
+	return topology_physical_package_id(cpu) == rp->id;
+}
+
+static struct rapl_package_pmu_data *event_to_pmu_data(struct perf_event *event)
+{
+	struct rapl_package *rp = event->pmu_private;
+
+	return &rp->pmu_data;
+}
+
+/* PMU event callbacks */
+
+static u64 event_read_counter(struct perf_event *event)
+{
+	struct rapl_package *rp = event->pmu_private;
+	u64 val;
+	int ret;
+
+	/* Return 0 for unsupported events */
+	if (event->hw.idx < 0)
+		return 0;
+
+	ret = rapl_read_data_raw(&rp->domains[event->hw.idx], ENERGY_COUNTER, false, &val);
+
+	/* Return 0 for failed read */
+	if (ret)
+		return 0;
+
+	return val;
+}
+
+static void __rapl_pmu_event_start(struct perf_event *event)
+{
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+		return;
+
+	event->hw.state = 0;
+
+	list_add_tail(&event->active_entry, &data->active_list);
+
+	local64_set(&event->hw.prev_count, event_read_counter(event));
+	if (++data->n_active == 1)
+		hrtimer_start(&data->hrtimer, data->timer_interval,
+			      HRTIMER_MODE_REL_PINNED);
+}
+
+static void rapl_pmu_event_start(struct perf_event *event, int mode)
+{
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	__rapl_pmu_event_start(event);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static u64 rapl_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+	u64 prev_raw_count, new_raw_count;
+	s64 delta, sdelta;
+
+	/*
+	 * Follow the generic code to drain hwc->prev_count.
+	 * The loop is not expected to run for multiple times.
+	 */
+	prev_raw_count = local64_read(&hwc->prev_count);
+	do {
+		new_raw_count = event_read_counter(event);
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+		&prev_raw_count, new_raw_count));
+
+
+	/*
+	 * Now we have the new raw value and have updated the prev
+	 * timestamp already. We can now calculate the elapsed delta
+	 * (event-)time and add that to the generic event.
+	 */
+	delta = new_raw_count - prev_raw_count;
+
+	/*
+	 * Scale delta to smallest unit (2^-32)
+	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
+	 * or use ldexp(count, -32).
+	 * Watts = Joules/Time delta
+	 */
+	sdelta = delta * data->scale[event->hw.flags];
+
+	local64_add(sdelta, &event->count);
+
+	return new_raw_count;
+}
+
+static void rapl_pmu_event_stop(struct perf_event *event, int mode)
+{
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+
+	/* Mark event as deactivated and stopped */
+	if (!(hwc->state & PERF_HES_STOPPED)) {
+		WARN_ON_ONCE(data->n_active <= 0);
+		if (--data->n_active == 0)
+			hrtimer_cancel(&data->hrtimer);
+
+		list_del(&event->active_entry);
+
+		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+		hwc->state |= PERF_HES_STOPPED;
+	}
+
+	/* Check if update of sw counter is necessary */
+	if ((mode & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		/*
+		 * Drain the remaining delta count out of a event
+		 * that we are disabling:
+		 */
+		rapl_event_update(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static int rapl_pmu_event_add(struct perf_event *event, int mode)
+{
+	struct rapl_package_pmu_data *data = event_to_pmu_data(event);
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (mode & PERF_EF_START)
+		__rapl_pmu_event_start(event);
+
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static void rapl_pmu_event_del(struct perf_event *event, int flags)
+{
+	rapl_pmu_event_stop(event, PERF_EF_UPDATE);
+}
+
+/* RAPL PMU event ids, same as shown in sysfs */
+enum perf_rapl_events {
+	PERF_RAPL_PP0 = 1,	/* all cores */
+	PERF_RAPL_PKG,		/* entire package */
+	PERF_RAPL_RAM,		/* DRAM */
+	PERF_RAPL_PP1,		/* gpu */
+	PERF_RAPL_PSYS,		/* psys */
+	PERF_RAPL_MAX
+};
+#define RAPL_EVENT_MASK GENMASK(7, 0)
+
+static const int event_to_domain[PERF_RAPL_MAX] = {
+	[PERF_RAPL_PP0]		= RAPL_DOMAIN_PP0,
+	[PERF_RAPL_PKG]		= RAPL_DOMAIN_PACKAGE,
+	[PERF_RAPL_RAM]		= RAPL_DOMAIN_DRAM,
+	[PERF_RAPL_PP1]		= RAPL_DOMAIN_PP1,
+	[PERF_RAPL_PSYS]	= RAPL_DOMAIN_PLATFORM,
+};
+
+static int rapl_pmu_event_init(struct perf_event *event)
+{
+	struct rapl_package *pos, *rp = NULL;
+	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
+	int domain, idx;
+
+	/* Only look at RAPL events */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* Check for supported events only */
+	if (!cfg || cfg >= PERF_RAPL_MAX)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	/* Find out which Package the event belongs to */
+	list_for_each_entry(pos, &rapl_packages, plist) {
+		if (is_rp_pmu_cpu(pos, event->cpu)) {
+			rp = pos;
+			break;
+		}
+	}
+	if (!rp)
+		return -ENODEV;
+
+	/* Find out which RAPL Domain the event belongs to */
+	domain = event_to_domain[cfg];
+
+	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
+	event->pmu_private = rp;	/* Which package */
+	event->hw.flags = domain;	/* Which domain */
+
+	event->hw.idx = -1;
+	/* Find out the index in rp->domains[] to get domain pointer */
+	for (idx = 0; idx < rp->nr_domains; idx++) {
+		if (rp->domains[idx].id == domain) {
+			event->hw.idx = idx;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static void rapl_pmu_event_read(struct perf_event *event)
+{
+	rapl_event_update(event);
+}
+
+static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
+{
+	struct rapl_package_pmu_data *data =
+		container_of(hrtimer, struct rapl_package_pmu_data, hrtimer);
+	struct perf_event *event;
+	unsigned long flags;
+
+	if (!data->n_active)
+		return HRTIMER_NORESTART;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+
+	list_for_each_entry(event, &data->active_list, active_entry)
+		rapl_event_update(event);
+
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+
+	hrtimer_forward_now(hrtimer, data->timer_interval);
+
+	return HRTIMER_RESTART;
+}
+
+/* PMU sysfs attributes */
+
+/*
+ * There are no default events, but we need to create "events" group (with
+ * empty attrs) before updating it with detected events.
+ */
+static struct attribute *attrs_empty[] = {
+	NULL,
+};
+
+static struct attribute_group pmu_events_group = {
+	.name = "events",
+	.attrs = attrs_empty,
+};
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct rapl_package *rp;
+	cpumask_var_t cpu_mask;
+	int cpu;
+	int ret;
+
+	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpus_read_lock();
+
+	cpumask_clear(cpu_mask);
+
+	/* Choose a cpu for each RAPL Package */
+	list_for_each_entry(rp, &rapl_packages, plist) {
+		cpu = get_pmu_cpu(rp);
+		if (cpu < nr_cpu_ids)
+			cpumask_set_cpu(cpu, cpu_mask);
+	}
+	cpus_read_unlock();
+
+	ret = cpumap_print_to_pagebuf(true, buf, cpu_mask);
+
+	free_cpumask_var(cpu_mask);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static struct attribute_group pmu_cpumask_group = {
+	.attrs = pmu_cpumask_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-7");
+static struct attribute *pmu_format_attr[] = {
+	&format_attr_event.attr,
+	NULL
+};
+
+static struct attribute_group pmu_format_group = {
+	.name = "format",
+	.attrs = pmu_format_attr,
+};
+
+static const struct attribute_group *pmu_attr_groups[] = {
+	&pmu_events_group,
+	&pmu_cpumask_group,
+	&pmu_format_group,
+	NULL
+};
+
+#define RAPL_EVENT_ATTR_STR(_name, v, str)					\
+static struct perf_pmu_events_attr event_attr_##v = {				\
+	.attr		= __ATTR(_name, 0444, perf_event_sysfs_show, NULL),	\
+	.event_str	= str,							\
+}
+
+RAPL_EVENT_ATTR_STR(energy-cores,	rapl_cores,	"event=0x01");
+RAPL_EVENT_ATTR_STR(energy-pkg,		rapl_pkg,	"event=0x02");
+RAPL_EVENT_ATTR_STR(energy-ram,		rapl_ram,	"event=0x03");
+RAPL_EVENT_ATTR_STR(energy-gpu,		rapl_gpu,	"event=0x04");
+RAPL_EVENT_ATTR_STR(energy-psys,	rapl_psys,	"event=0x05");
+
+RAPL_EVENT_ATTR_STR(energy-cores.unit,	rapl_unit_cores,	"Joules");
+RAPL_EVENT_ATTR_STR(energy-pkg.unit,	rapl_unit_pkg,		"Joules");
+RAPL_EVENT_ATTR_STR(energy-ram.unit,	rapl_unit_ram,		"Joules");
+RAPL_EVENT_ATTR_STR(energy-gpu.unit,	rapl_unit_gpu,		"Joules");
+RAPL_EVENT_ATTR_STR(energy-psys.unit,	rapl_unit_psys,		"Joules");
+
+RAPL_EVENT_ATTR_STR(energy-cores.scale,	rapl_scale_cores,	"2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-pkg.scale,	rapl_scale_pkg,		"2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-ram.scale,	rapl_scale_ram,		"2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-gpu.scale,	rapl_scale_gpu,		"2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-psys.scale,	rapl_scale_psys,	"2.3283064365386962890625e-10");
+
+#define RAPL_EVENT_GROUP(_name, domain)			\
+static struct attribute *pmu_attr_##_name[] = {		\
+	&event_attr_rapl_##_name.attr.attr,		\
+	&event_attr_rapl_unit_##_name.attr.attr,	\
+	&event_attr_rapl_scale_##_name.attr.attr,	\
+	NULL						\
+};							\
+static umode_t is_visible_##_name(struct kobject *kobj, struct attribute *attr, int event)	\
+{											\
+	return rapl_pmu.domain_map & BIT(domain) ? attr->mode : 0;	\
+}							\
+static struct attribute_group pmu_group_##_name = {	\
+	.name  = "events",				\
+	.attrs = pmu_attr_##_name,			\
+	.is_visible = is_visible_##_name,		\
+}
+
+RAPL_EVENT_GROUP(cores,	RAPL_DOMAIN_PP0);
+RAPL_EVENT_GROUP(pkg,	RAPL_DOMAIN_PACKAGE);
+RAPL_EVENT_GROUP(ram,	RAPL_DOMAIN_DRAM);
+RAPL_EVENT_GROUP(gpu,	RAPL_DOMAIN_PP1);
+RAPL_EVENT_GROUP(psys,	RAPL_DOMAIN_PLATFORM);
+
+static const struct attribute_group *pmu_attr_update[] = {
+	&pmu_group_cores,
+	&pmu_group_pkg,
+	&pmu_group_ram,
+	&pmu_group_gpu,
+	&pmu_group_psys,
+	NULL
+};
+
+static int rapl_pmu_update(struct rapl_package *rp)
+{
+	int ret = 0;
+
+	/* Return if PMU already covers all events supported by current RAPL Package */
+	if (rapl_pmu.registered && !(rp->domain_map & (~rapl_pmu.domain_map)))
+		goto end;
+
+	/* Unregister previous registered PMU */
+	if (rapl_pmu.registered)
+		perf_pmu_unregister(&rapl_pmu.pmu);
+
+	rapl_pmu.registered = false;
+	rapl_pmu.domain_map |= rp->domain_map;
+
+	memset(&rapl_pmu.pmu, 0, sizeof(struct pmu));
+	rapl_pmu.pmu.attr_groups = pmu_attr_groups;
+	rapl_pmu.pmu.attr_update = pmu_attr_update;
+	rapl_pmu.pmu.task_ctx_nr = perf_invalid_context;
+	rapl_pmu.pmu.event_init = rapl_pmu_event_init;
+	rapl_pmu.pmu.add = rapl_pmu_event_add;
+	rapl_pmu.pmu.del = rapl_pmu_event_del;
+	rapl_pmu.pmu.start = rapl_pmu_event_start;
+	rapl_pmu.pmu.stop = rapl_pmu_event_stop;
+	rapl_pmu.pmu.read = rapl_pmu_event_read;
+	rapl_pmu.pmu.module = THIS_MODULE;
+	rapl_pmu.pmu.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT;
+	ret = perf_pmu_register(&rapl_pmu.pmu, "power", -1);
+	if (ret) {
+		pr_info("Failed to register PMU\n");
+		return ret;
+	}
+
+	rapl_pmu.registered = true;
+end:
+	rp->has_pmu = true;
+	return ret;
+}
+
+int rapl_package_add_pmu(struct rapl_package *rp)
+{
+	struct rapl_package_pmu_data *data = &rp->pmu_data;
+	int idx;
+
+	if (rp->has_pmu)
+		return -EEXIST;
+
+	guard(cpus_read_lock)();
+
+	for (idx = 0; idx < rp->nr_domains; idx++) {
+		struct rapl_domain *rd = &rp->domains[idx];
+		int domain = rd->id;
+		u64 val;
+
+		if (!test_bit(domain, &rp->domain_map))
+			continue;
+
+		/*
+		 * The RAPL PMU granularity is 2^-32 Joules
+		 * data->scale[]: times of 2^-32 Joules for each ENERGY COUNTER increase
+		 */
+		val = rd->energy_unit * (1ULL << 32);
+		do_div(val, ENERGY_UNIT_SCALE * 1000000);
+		data->scale[domain] = val;
+
+		if (!rapl_pmu.timer_ms) {
+			struct rapl_primitive_info *rpi = get_rpi(rp, ENERGY_COUNTER);
+
+			/*
+			 * Calculate the timer rate:
+			 * Use reference of 200W for scaling the timeout to avoid counter
+			 * overflows.
+			 *
+			 * max_count = rpi->mask >> rpi->shift + 1
+			 * max_energy_pj = max_count * rd->energy_unit
+			 * max_time_sec = (max_energy_pj / 1000000000) / 200w
+			 *
+			 * rapl_pmu.timer_ms = max_time_sec * 1000 / 2
+			 */
+			val = (rpi->mask >> rpi->shift) + 1;
+			val *= rd->energy_unit;
+			do_div(val, 1000000 * 200 * 2);
+			rapl_pmu.timer_ms = val;
+
+			pr_debug("%llu ms overflow timer\n", rapl_pmu.timer_ms);
+		}
+
+		pr_debug("Domain %s: hw unit %lld * 2^-32 Joules\n", rd->name, data->scale[domain]);
+	}
+
+	/* Initialize per package PMU data */
+	raw_spin_lock_init(&data->lock);
+	INIT_LIST_HEAD(&data->active_list);
+	data->timer_interval = ms_to_ktime(rapl_pmu.timer_ms);
+	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	data->hrtimer.function = rapl_hrtimer_handle;
+
+	return rapl_pmu_update(rp);
+}
+EXPORT_SYMBOL_GPL(rapl_package_add_pmu);
+
+void rapl_package_remove_pmu(struct rapl_package *rp)
+{
+	struct rapl_package *pos;
+
+	if (!rp->has_pmu)
+		return;
+
+	guard(cpus_read_lock)();
+
+	list_for_each_entry(pos, &rapl_packages, plist) {
+		/* PMU is still needed */
+		if (pos->has_pmu && pos != rp)
+			return;
+	}
+
+	perf_pmu_unregister(&rapl_pmu.pmu);
+	memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
+}
+EXPORT_SYMBOL_GPL(rapl_package_remove_pmu);
+#endif
+
 /* called from CPU hotplug notifier, hotplug lock held */
 void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 {
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index f3196f82fd8a..c0397423d3a8 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -158,6 +158,26 @@ struct rapl_if_priv {
 	void *rpi;
 };
 
+#ifdef CONFIG_PERF_EVENTS
+/**
+ * struct rapl_package_pmu_data: Per package data for PMU support
+ * @scale:		Scale of 2^-32 Joules for each energy counter increase.
+ * @lock:		Lock to protect n_active and active_list.
+ * @n_active:		Number of active events.
+ * @active_list:	List of active events.
+ * @timer_interval:	Maximum timer expiration time before counter overflow.
+ * @hrtimer:		Periodically update the counter to prevent overflow.
+ */
+struct rapl_package_pmu_data {
+	u64 scale[RAPL_DOMAIN_MAX];
+	raw_spinlock_t lock;
+	int n_active;
+	struct list_head active_list;
+	ktime_t timer_interval;
+	struct hrtimer hrtimer;
+};
+#endif
+
 /* maximum rapl package domain name: package-%d-die-%d */
 #define PACKAGE_DOMAIN_NAME_LENGTH 30
 
@@ -176,6 +196,10 @@ struct rapl_package {
 	struct cpumask cpumask;
 	char name[PACKAGE_DOMAIN_NAME_LENGTH];
 	struct rapl_if_priv *priv;
+#ifdef CONFIG_PERF_EVENTS
+	bool has_pmu;
+	struct rapl_package_pmu_data pmu_data;
+#endif
 };
 
 struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
@@ -188,4 +212,12 @@ struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv,
 struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 void rapl_remove_package(struct rapl_package *rp);
 
+#ifdef CONFIG_PERF_EVENTS
+int rapl_package_add_pmu(struct rapl_package *rp);
+void rapl_package_remove_pmu(struct rapl_package *rp);
+#else
+static inline int rapl_package_add_pmu(struct rapl_package *rp) { return 0; }
+static inline void rapl_package_remove_pmu(struct rapl_package *rp) { }
+#endif
+
 #endif /* __INTEL_RAPL_H__ */
-- 
2.34.1


