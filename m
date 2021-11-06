Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94461446BDA
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 02:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhKFBgs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 21:36:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:44847 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233668AbhKFBgo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 21:36:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="230732038"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="230732038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 18:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="502194843"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2021 18:34:02 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 4/7] thermal: intel: hfi: Handle CPU hotplug events
Date:   Fri,  5 Nov 2021 18:33:09 -0700
Message-Id: <20211106013312.26698-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All CPUs in a package are represented in an HFI table. There exists an
HFI table per package. Thus, CPUs in a package need to coordinate to
initialize and access the table. Do such coordination during CPU hotplug.
Use the first CPU to come online in a package to initialize the HFI table
and the data structure representing it. Other CPUs in the same package need
only to register or unregister themselves in that data structure.

The HFI depends on both the package-level thermal management and the local
APIC thermal local vector. Thus, ensure that both are properly configured
before calling intel_hfi_online(). The CPU hotplug callbacks of the thermal
throttle events code already meet these conditions. Enable the HFI from
thermal_throttle_online().

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c   | 211 ++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h   |   4 +
 drivers/thermal/intel/therm_throt.c |   8 ++
 3 files changed, 223 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index edfe343507b3..6a3adfd57d72 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -21,6 +21,7 @@
 
 #define pr_fmt(fmt)  "intel-hfi: " fmt
 
+#include <linux/io.h>
 #include <linux/slab.h>
 
 #include "intel_hfi.h"
@@ -52,16 +53,26 @@ struct hfi_hdr {
 
 /**
  * struct hfi_instance - Representation of an HFI instance (i.e., a table)
+ * @table_base:		Base of the local copy of the HFI table
  * @ts_counter:		Time stamp of the last update of the table
  * @hdr:		Base address of the table header
  * @data:		Base address of the table data
+ * @die_id:		Logical die ID this HFI table instance
+ * @cpus:		CPUs represented in this HFI table instance
+ * @hw_table:		Pointer to the HFI table of this instance
+ * @initialized:	True if this HFI instance has bee initialized
  *
  * A set of parameters to parse and navigate a specific HFI table.
  */
 struct hfi_instance {
+	void			*table_base;
 	u64			*ts_counter;
 	void			*hdr;
 	void			*data;
+	u16			die_id;
+	struct cpumask		*cpus;
+	void			*hw_table;
+	bool			initialized;
 };
 
 /**
@@ -83,10 +94,210 @@ struct hfi_features {
 	bool		parsed;
 };
 
+/**
+ * struct hfi_cpu_info - Per-CPU attributes to consume HFI data
+ * @index:		Row of this CPU in its HFI table
+ * @hfi_instance:	Attributes of the HFI table to which this CPU belongs
+ *
+ * Parameters to link a logical processor to an HFI table and a row within it.
+ */
+struct hfi_cpu_info {
+	s16			index;
+	struct hfi_instance	*hfi_instance;
+};
+
+static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) = { .index = -1 };
+
 static int max_hfi_instances;
 static struct hfi_instance *hfi_instances;
 
 static struct hfi_features hfi_features;
+static DEFINE_MUTEX(hfi_lock);
+
+static void init_hfi_cpu_index(unsigned int cpu)
+{
+	s16 hfi_idx;
+	u32 edx;
+
+	/* Do not re-read @cpu's index if it has already been initialized. */
+	if (per_cpu(hfi_cpu_info, cpu).index > -1)
+		return;
+
+	edx = cpuid_edx(CPUID_HFI_LEAF);
+	hfi_idx = (edx & CPUID_HFI_CPU_INDEX_MASK) >> CPUID_HFI_CPU_INDEX_SHIFT;
+
+	per_cpu(hfi_cpu_info, cpu).index = hfi_idx;
+}
+
+/*
+ * The format of the HFI table depends on the number of capabilities that the
+ * hardware supports. Keep a data structure to navigate the table.
+ */
+static void init_hfi_instance(struct hfi_instance *hfi_instance)
+{
+	/* The HFI time-stamp is located at the base of the table. */
+	hfi_instance->ts_counter = hfi_instance->table_base;
+
+	/* The HFI header is below the time-stamp. */
+	hfi_instance->hdr = hfi_instance->table_base +
+			    sizeof(*hfi_instance->ts_counter);
+
+	/* The HFI data starts below the header. */
+	hfi_instance->data = hfi_instance->hdr + hfi_features.hdr_size;
+}
+
+/**
+ * intel_hfi_online() - Enable HFI on @cpu
+ * @cpu:	CPU in which the HFI will be enabled
+ *
+ * Enable the HFI to be used in @cpu. The HFI is enabled at the die/package
+ * level. The first CPU in the die/package to come online does the full HFI
+ * initialization. Subsequent CPUs will just link themselves to the HFI
+ * instance of their die/package.
+ */
+void intel_hfi_online(unsigned int cpu)
+{
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
+	u16 die_id = topology_logical_die_id(cpu);
+	struct hfi_instance *hfi_instance;
+	phys_addr_t hw_table_pa;
+	u64 msr_val;
+
+	if (!boot_cpu_has(X86_FEATURE_INTEL_HFI))
+		return;
+
+	init_hfi_cpu_index(cpu);
+
+	/*
+	 * The HFI instance of this @cpu may exist already but they have not
+	 * been linked to @cpu.
+	 */
+	hfi_instance = info->hfi_instance;
+	if (!hfi_instance) {
+		if (!hfi_instances)
+			return;
+
+		if (die_id >= 0 && die_id < max_hfi_instances)
+			hfi_instance = &hfi_instances[die_id];
+
+		if (!hfi_instance)
+			return;
+	}
+
+	/*
+	 * Now check if the HFI instance of the package/die of this CPU has
+	 * been initialized. In such case, all we have to do is link @cpu's info
+	 * to the HFI instance of its die/package.
+	 */
+	mutex_lock(&hfi_lock);
+	if (hfi_instance->initialized) {
+		info->hfi_instance = hfi_instance;
+
+		/*
+		 * @cpu is the first one in its die/package to come back online.
+		 * Use it to track the CPUs in the die/package.
+		 */
+		if (!hfi_instance->cpus)
+			hfi_instance->cpus = topology_core_cpumask(cpu);
+
+		mutex_unlock(&hfi_lock);
+		return;
+	}
+
+	/*
+	 * Hardware is programmed with the physical address of the first page
+	 * frame of the table. Hence, the allocated memory must be page-aligned.
+	 */
+	hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
+						   GFP_KERNEL | __GFP_ZERO);
+	if (!hfi_instance->hw_table)
+		goto err_out;
+
+	hw_table_pa = virt_to_phys(hfi_instance->hw_table);
+
+	hfi_instance->table_base = kzalloc(hfi_features.nr_table_pages << PAGE_SHIFT,
+					   GFP_KERNEL);
+	if (!hfi_instance->table_base)
+		goto free_hw_table;
+
+	/*
+	 * Program the address of the feedback table of this die/package. On
+	 * some processors, hardware remembers the old address of the HFI table
+	 * even after having been reprogrammed and re-enabled. Thus, do not free
+	 * pages allocated for the table or reprogram the hardware with a new
+	 * base address. Namely, program the hardware only once.
+	 */
+	msr_val = hw_table_pa | HFI_PTR_VALID_BIT;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
+
+	init_hfi_instance(hfi_instance);
+
+	hfi_instance->die_id = die_id;
+
+	/*
+	 * We can use the core cpumask of any cpu in the die/package. Any of
+	 * them will reflect all the CPUs the same package that are online.
+	 */
+	hfi_instance->cpus = topology_core_cpumask(cpu);
+	info->hfi_instance = hfi_instance;
+	hfi_instance->initialized = true;
+
+	mutex_unlock(&hfi_lock);
+
+	return;
+
+free_hw_table:
+	free_pages_exact(hfi_instance->hw_table, hfi_features.nr_table_pages);
+err_out:
+	mutex_unlock(&hfi_lock);
+}
+
+/**
+ * intel_hfi_offline() - Disable HFI on @cpu
+ * @cpu:	CPU in which the HFI will be disabled
+ *
+ * Remove @cpu from those covered by its HFI instance.
+ *
+ * On some processors, hardware remembers previous programming settings even
+ * after being reprogrammed. Thus, keep HFI enabled even if all CPUs in the
+ * die/package of @cpu are offline. See note in intel_hfi_online().
+ */
+void intel_hfi_offline(unsigned int cpu)
+{
+	struct cpumask *die_cpumask = topology_core_cpumask(cpu);
+	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
+	struct hfi_instance *hfi_instance;
+
+	if (!boot_cpu_has(X86_FEATURE_INTEL_HFI))
+		return;
+
+	hfi_instance = info->hfi_instance;
+	if (!hfi_instance)
+		return;
+
+	if (!hfi_instance->initialized)
+		return;
+
+	mutex_lock(&hfi_lock);
+
+	/*
+	 * We were using the core cpumask of @cpu to track CPUs in the same
+	 * die/package. Now it is going offline and we need to find another
+	 * CPU we can use.
+	 */
+	if (die_cpumask == hfi_instance->cpus) {
+		int new_cpu;
+
+		new_cpu = cpumask_any_but(hfi_instance->cpus, cpu);
+		if (new_cpu >= nr_cpu_ids)
+			/* All other CPUs in the package are offline. */
+			hfi_instance->cpus = NULL;
+		else
+			hfi_instance->cpus = topology_core_cpumask(new_cpu);
+	}
+
+	mutex_unlock(&hfi_lock);
+}
 
 static __init int hfi_parse_features(void)
 {
diff --git a/drivers/thermal/intel/intel_hfi.h b/drivers/thermal/intel/intel_hfi.h
index 42529d3ac92d..d87c3823bb76 100644
--- a/drivers/thermal/intel/intel_hfi.h
+++ b/drivers/thermal/intel/intel_hfi.h
@@ -27,8 +27,12 @@
 
 #if defined(CONFIG_INTEL_HFI)
 void __init intel_hfi_init(void);
+void intel_hfi_online(unsigned int cpu);
+void intel_hfi_offline(unsigned int cpu);
 #else
 static inline void intel_hfi_init(void) { }
+static inline void intel_hfi_online(unsigned int cpu) { }
+static inline void intel_hfi_offline(unsigned int cpu) { }
 #endif
 
 #endif /* _INTEL_HFI_H */
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index ac408714d52b..2a79598a7f7a 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -480,6 +480,12 @@ static int thermal_throttle_online(unsigned int cpu)
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
 
+	/*
+	 * Enable the package-level HFI interrupt. By now the local APIC is
+	 * ready to get thermal interrupts.
+	 */
+	intel_hfi_online(cpu);
+
 	return thermal_throttle_add_dev(dev, cpu);
 }
 
@@ -489,6 +495,8 @@ static int thermal_throttle_offline(unsigned int cpu)
 	struct device *dev = get_cpu_device(cpu);
 	u32 l;
 
+	intel_hfi_offline(cpu);
+
 	/* Mask the thermal vector before draining evtl. pending work */
 	l = apic_read(APIC_LVTTHMR);
 	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
-- 
2.17.1

