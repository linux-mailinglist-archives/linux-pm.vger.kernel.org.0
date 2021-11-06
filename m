Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9F446BDC
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 02:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhKFBgs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 21:36:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:44844 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhKFBgp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 21:36:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="230732044"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="230732044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 18:34:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="502194854"
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
Subject: [PATCH 5/7] thermal: intel: hfi: Enable notification interrupt
Date:   Fri,  5 Nov 2021 18:33:10 -0700
Message-Id: <20211106013312.26698-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When hardware wants to inform the operating system about updates in the HFI
table, it issues a package-level thermal event interrupt. For this,
hardware has new interrupt and status bits in the IA32_PACKAGE_THERM_
INTERRUPT and IA32_PACKAGE_THERM_STATUS registers. The existing thermal
throttle driver already handles thermal event interrupts: it initializes
the thermal vector of the local APIC as well as per-CPU and package-level
interrupt reporting. It also provides routines to service such interrupts.
Extend its functionality to also handle HFI interrupts.

The frequency of the thermal HFI interrupt is specific to each processor
model. On some processors, a single interrupt happens as soon as the HFI is
enabled and hardware will never update HFI capabilities afterwards. On
other processors, thermal and power constraints may cause thermal HFI
interrupts every tens of milliseconds.

To not overwhelm consumers of the HFI data, use delayed work to throttle
the rate at which HFI updates are processed.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c   | 89 +++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h   |  2 +
 drivers/thermal/intel/therm_throt.c | 10 ++++
 3 files changed, 101 insertions(+)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 6a3adfd57d72..1df24b39f2e6 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -26,6 +26,9 @@
 
 #include "intel_hfi.h"
 
+#define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | \
+				     BIT(9) | BIT(11) | BIT(26))
+
 /**
  * struct hfi_cpu_data - HFI capabilities per CPU
  * @perf_cap:		Performance capability
@@ -60,6 +63,9 @@ struct hfi_hdr {
  * @die_id:		Logical die ID this HFI table instance
  * @cpus:		CPUs represented in this HFI table instance
  * @hw_table:		Pointer to the HFI table of this instance
+ * @update_work:	Delayed work to process HFI updates
+ * @event_lock:		Lock to protect HFI updates
+ * @timestamp:		Timestamp of the last HFI update
  * @initialized:	True if this HFI instance has bee initialized
  *
  * A set of parameters to parse and navigate a specific HFI table.
@@ -72,6 +78,9 @@ struct hfi_instance {
 	u16			die_id;
 	struct cpumask		*cpus;
 	void			*hw_table;
+	struct delayed_work	update_work;
+	raw_spinlock_t		event_lock;
+	u64			timestamp;
 	bool			initialized;
 };
 
@@ -114,6 +123,75 @@ static struct hfi_instance *hfi_instances;
 static struct hfi_features hfi_features;
 static DEFINE_MUTEX(hfi_lock);
 
+#define HFI_UPDATE_INTERVAL	HZ
+
+static void hfi_update_work_fn(struct work_struct *work)
+{
+	struct hfi_instance *hfi_instance;
+
+	hfi_instance = container_of(to_delayed_work(work), struct hfi_instance,
+				    update_work);
+	if (!hfi_instance)
+		return;
+
+	/* TODO: Consume update here. */
+}
+
+void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
+{
+	struct hfi_instance *hfi_instance;
+	int cpu = smp_processor_id();
+	struct hfi_cpu_info *info;
+	unsigned long flags;
+	u64 timestamp;
+
+	if (!pkg_therm_status_msr_val)
+		return;
+
+	info = &per_cpu(hfi_cpu_info, cpu);
+	if (!info)
+		return;
+
+	/*
+	 * It is possible that we get an HFI thermal interrupt on this CPU
+	 * before its HFI instance is initialized. This is not a problem. The
+	 * CPU that enabled the interrupt for this package will also get the
+	 * interrupt and is fully initialized.
+	 */
+	hfi_instance = info->hfi_instance;
+	if (!hfi_instance)
+		return;
+
+	raw_spin_lock_irqsave(&hfi_instance->event_lock, flags);
+
+	/*
+	 * On most systems, all CPUs in the package receive a package-level
+	 * thermal interrupt when there is an HFI update. Since they all are
+	 * dealing with the same update (as indicated by the update timestamp),
+	 * it is sufficient to let a single CPU to acknowledge the update and
+	 * schedule work to process it.
+	 */
+	timestamp = *(u64 *)hfi_instance->hw_table;
+	if (hfi_instance->timestamp >= timestamp)
+		goto unlock_spinlock;
+
+	hfi_instance->timestamp = timestamp;
+
+	memcpy(hfi_instance->table_base, hfi_instance->hw_table,
+	       hfi_features.nr_table_pages << PAGE_SHIFT);
+	/*
+	 * Let hardware and other CPUs know that we are done reading the HFI
+	 * table and it is free to update it again.
+	 */
+	pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
+				    ~PACKAGE_THERM_STATUS_HFI_UPDATED;
+	wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS, pkg_therm_status_msr_val);
+	schedule_delayed_work(&hfi_instance->update_work, HFI_UPDATE_INTERVAL);
+
+unlock_spinlock:
+	raw_spin_unlock_irqrestore(&hfi_instance->event_lock, flags);
+}
+
 static void init_hfi_cpu_index(unsigned int cpu)
 {
 	s16 hfi_idx;
@@ -232,6 +310,9 @@ void intel_hfi_online(unsigned int cpu)
 
 	init_hfi_instance(hfi_instance);
 
+	INIT_DELAYED_WORK(&hfi_instance->update_work, hfi_update_work_fn);
+	raw_spin_lock_init(&hfi_instance->event_lock);
+
 	hfi_instance->die_id = die_id;
 
 	/*
@@ -242,6 +323,14 @@ void intel_hfi_online(unsigned int cpu)
 	info->hfi_instance = hfi_instance;
 	hfi_instance->initialized = true;
 
+	/*
+	 * Enable the hardware feedback interface and never disable it. See
+	 * comment on programming the address of the table.
+	 */
+	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	msr_val |= HFI_CONFIG_ENABLE_BIT;
+	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+
 	mutex_unlock(&hfi_lock);
 
 	return;
diff --git a/drivers/thermal/intel/intel_hfi.h b/drivers/thermal/intel/intel_hfi.h
index d87c3823bb76..062e233a7b5d 100644
--- a/drivers/thermal/intel/intel_hfi.h
+++ b/drivers/thermal/intel/intel_hfi.h
@@ -29,10 +29,12 @@
 void __init intel_hfi_init(void);
 void intel_hfi_online(unsigned int cpu);
 void intel_hfi_offline(unsigned int cpu);
+void intel_hfi_process_event(__u64 pkg_therm_status_msr_val);
 #else
 static inline void intel_hfi_init(void) { }
 static inline void intel_hfi_online(unsigned int cpu) { }
 static inline void intel_hfi_offline(unsigned int cpu) { }
+static inline void intel_hfi_process_event(__u64 pkg_therm_status_msr_val) { }
 #endif
 
 #endif /* _INTEL_HFI_H */
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 2a79598a7f7a..9a73607a7df5 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -619,6 +619,10 @@ void intel_thermal_interrupt(void)
 					PACKAGE_THERM_STATUS_POWER_LIMIT,
 					POWER_LIMIT_EVENT,
 					PACKAGE_LEVEL);
+
+		if (this_cpu_has(X86_FEATURE_INTEL_HFI))
+			intel_hfi_process_event(msr_val &
+						PACKAGE_THERM_STATUS_HFI_UPDATED);
 	}
 }
 
@@ -728,6 +732,12 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
 			      l | (PACKAGE_THERM_INT_LOW_ENABLE
 				| PACKAGE_THERM_INT_HIGH_ENABLE), h);
+
+		if (cpu_has(c, X86_FEATURE_INTEL_HFI)) {
+			rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			      l | PACKAGE_THERM_INT_HFI_ENABLE, h);
+		}
 	}
 
 	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-- 
2.17.1

