Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEB446BDE
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 02:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhKFBgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 21:36:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:44849 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233686AbhKFBgq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 21:36:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="230732047"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="230732047"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 18:34:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="502194861"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2021 18:34:05 -0700
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] thermal: intel: hfi: Notify user space for HFI events
Date:   Fri,  5 Nov 2021 18:33:12 -0700
Message-Id: <20211106013312.26698-8-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When the hardware issues an HFI event, relay a notification to user space.
This allows user space to respond by reading performance and efficiency of
each CPU and take appropriate action.

For example, when performance and efficiency of a CPU is 0, user space can
either offline the CPU or inject idle. Also, if user space notices a
downward trend in performance, it may proactively adjust power limits to
avoid future situations in which performance drops to 0.

To avoid excessive notifications, the rate is limited by one HZ per event.
To limit netlink message size, parameters for only 16 CPUs at max are sent
in one message. If there are more than 16 CPUs, issue as many messages as
needed to notify the status of all CPUs.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/Kconfig     |  1 +
 drivers/thermal/intel/intel_hfi.c | 55 ++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index d4c6bdcacddb..b6a1f777b8e7 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -104,6 +104,7 @@ config INTEL_HFI
 	bool "Intel Hardware Feedback Interface"
 	depends on CPU_SUP_INTEL
 	depends on SCHED_MC && X86_THERMAL_VECTOR
+	select THERMAL_NETLINK
 	help
 	  Select this option to enable the Hardware Feedback Interface. If
 	  selected, hardware provides guidance to the operating system on
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 1df24b39f2e6..c669a037704e 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
+#include "../thermal_core.h"
 #include "intel_hfi.h"
 
 #define THERM_STATUS_CLEAR_PKG_MASK (BIT(1) | BIT(3) | BIT(5) | BIT(7) | \
@@ -124,6 +125,58 @@ static struct hfi_features hfi_features;
 static DEFINE_MUTEX(hfi_lock);
 
 #define HFI_UPDATE_INTERVAL	HZ
+#define HFI_MAX_THERM_NOTIFY_COUNT	16
+
+static int get_one_hfi_cap(struct hfi_instance *hfi_instance, int cpu,
+			   struct hfi_cpu_data *hfi_caps)
+{
+	struct hfi_cpu_data *caps;
+	unsigned long flags;
+	s16 index;
+
+	index = per_cpu(hfi_cpu_info, cpu).index;
+	if (index < 0)
+		return -EINVAL;
+
+	/* Find the capabilities of @cpu */
+	raw_spin_lock_irqsave(&hfi_instance->event_lock, flags);
+	caps = hfi_instance->data + index * hfi_features.cpu_stride;
+	memcpy(hfi_caps, caps, sizeof(*hfi_caps));
+	raw_spin_unlock_irqrestore(&hfi_instance->event_lock, flags);
+
+	return 0;
+}
+
+/*
+ * Call update_capabilities() when there are changes in the HFI table.
+ */
+static void update_capabilities(struct hfi_instance *hfi_instance)
+{
+	struct cpu_capability cpu_caps[HFI_MAX_THERM_NOTIFY_COUNT];
+	int i = 0, cpu;
+
+	for_each_cpu(cpu, hfi_instance->cpus) {
+		struct hfi_cpu_data caps;
+		int ret;
+
+		ret = get_one_hfi_cap(hfi_instance, cpu, &caps);
+		if (ret)
+			continue;
+
+		cpu_caps[i].cpu = cpu;
+		cpu_caps[i].perf = caps.perf_cap;
+		cpu_caps[i].eff = caps.ee_cap;
+		++i;
+		if (i >= HFI_MAX_THERM_NOTIFY_COUNT) {
+			thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_COUNT,
+							  cpu_caps);
+			i = 0;
+		}
+	}
+
+	if (i)
+		thermal_genl_cpu_capability_event(i, cpu_caps);
+}
 
 static void hfi_update_work_fn(struct work_struct *work)
 {
@@ -134,7 +187,7 @@ static void hfi_update_work_fn(struct work_struct *work)
 	if (!hfi_instance)
 		return;
 
-	/* TODO: Consume update here. */
+	update_capabilities(hfi_instance);
 }
 
 void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
-- 
2.17.1

