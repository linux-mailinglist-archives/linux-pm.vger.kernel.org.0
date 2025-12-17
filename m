Return-Path: <linux-pm+bounces-39657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85816CC877F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492C4301141E
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BDB38E168;
	Wed, 17 Dec 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxYTTKIm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766737C0E7;
	Wed, 17 Dec 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985716; cv=none; b=WPtwBocW4Uxaey9OFqVtHACIbNSuPoX4Bb8SmvlXMLHBP2IJHbd2mpCoSn7+3bZASOtI0BtgnXugYCNKXn86diNp0oZqyXwXqRZ4dHuav4KcRignwFxyNfHnc2nYAf2PfILrHieU+WSyP/os+E1FP2mToxhRqvht/pY/0A9CLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985716; c=relaxed/simple;
	bh=rsvW0F/99KkweA4eP9/pit8zUtwZ65GB07yMa60aOEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScUkr4Hv3smkWnTxZ6+D8sH5uWIoVzgMUQWYk8AVtpGyFr9HtFK/OHWApEWRQeHL46fKx48OfqfSbpH6VVybZteaf+Mw+vB0KzaYV5786/NPWZeto8AqfWzzA46y0EN7tHkL8IbAo9wPjCNnpep31NF7SfI8KULraw+A8i8zUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxYTTKIm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765985713; x=1797521713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rsvW0F/99KkweA4eP9/pit8zUtwZ65GB07yMa60aOEc=;
  b=cxYTTKIm2n/4pFx1dBHwZRKdGEEuGL5EdZg3H57uNdqCJajoslAKLeFf
   v91/uYLHAQlByltrNdqrEuOncmrXFi7GezVYHuTYS8nns/b/3eZX0qtxB
   iqjdWmb4IXfCPfSZ/JPtk1Zuh6146/NudoXv00OL2eu3/pYXzKx0VS9lH
   lmY6e+ZYMkIx29juQHtU/s8KPJYi75EuCDwJ78BP3l4tz9CDXEr5blOqt
   C0A2kFdQwNzpOrYCwdxX3wUbMOqPr1UqqMrgj7mfTaA8RcEzwZVgCHdxy
   HbJU9DCOuNMGaDZUufc1hlH/7mHVh0hMfjv4Tafyac3z0bew+2hcLj2PJ
   A==;
X-CSE-ConnectionGUID: CbsBYGGFSXKfZhcdH0z/IQ==
X-CSE-MsgGUID: tlROyHfkQyGPxfR5K/LZAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67891321"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67891321"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 07:35:13 -0800
X-CSE-ConnectionGUID: KtIKqAKFTj+N06A7oPaw/w==
X-CSE-MsgGUID: sWGrSkiNTYmEBODkKhK0aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="197449367"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa006.jf.intel.com with ESMTP; 17 Dec 2025 07:35:13 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	RavitejaX Veesam <ravitejax.veesam@intel.com>
Subject: [PATCH] powercap: intel_rapl: Fix possible recursive lock warning
Date: Wed, 17 Dec 2025 07:34:55 -0800
Message-ID: <20251217153455.3560176-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the RAPL PMU addition, there is a recursive locking when CPU online
callback function calls rapl_package_add_pmu(). Here cpu_hotplug_lock
is already acquired by cpuhp_thread_fun() and rapl_package_add_pmu()
tries to acquire again.

<4>[ 8.197433] ============================================
<4>[ 8.197437] WARNING: possible recursive locking detected
<4>[ 8.197440] 6.19.0-rc1-lgci-xe-xe-4242-05b7c58b3367dca84+ #1 Not tainted
<4>[ 8.197444] --------------------------------------------
<4>[ 8.197447] cpuhp/0/20 is trying to acquire lock:
<4>[ 8.197450] ffffffff83487870 (cpu_hotplug_lock){++++}-{0:0}, at:
rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
<4>[ 8.197463]
but task is already holding lock:
<4>[ 8.197466] ffffffff83487870 (cpu_hotplug_lock){++++}-{0:0}, at:
cpuhp_thread_fun+0x6d/0x290
<4>[ 8.197477]
other info that might help us debug this:
<4>[ 8.197480] Possible unsafe locking scenario:

<4>[ 8.197483] CPU0
<4>[ 8.197485] ----
<4>[ 8.197487] lock(cpu_hotplug_lock);
<4>[ 8.197490] lock(cpu_hotplug_lock);
<4>[ 8.197493]
*** DEADLOCK ***
..
..
<4>[ 8.197542] __lock_acquire+0x146e/0x2790
<4>[ 8.197548] lock_acquire+0xc4/0x2c0
<4>[ 8.197550] ? rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
<4>[ 8.197556] cpus_read_lock+0x41/0x110
<4>[ 8.197558] ? rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
<4>[ 8.197561] rapl_package_add_pmu+0x37/0x370 [intel_rapl_common]
<4>[ 8.197565] rapl_cpu_online+0x85/0x87 [intel_rapl_msr]
<4>[ 8.197568] ? __pfx_rapl_cpu_online+0x10/0x10 [intel_rapl_msr]
<4>[ 8.197570] cpuhp_invoke_callback+0x41f/0x6c0
<4>[ 8.197573] ? cpuhp_thread_fun+0x6d/0x290
<4>[ 8.197575] cpuhp_thread_fun+0x1e2/0x290
<4>[ 8.197578] ? smpboot_thread_fn+0x26/0x290
<4>[ 8.197581] smpboot_thread_fn+0x12f/0x290
<4>[ 8.197584] ? __pfx_smpboot_thread_fn+0x10/0x10
<4>[ 8.197586] kthread+0x11f/0x250
<4>[ 8.197589] ? __pfx_kthread+0x10/0x10
<4>[ 8.197592] ret_from_fork+0x344/0x3a0
<4>[ 8.197595] ? __pfx_kthread+0x10/0x10
<4>[ 8.197597] ret_from_fork_asm+0x1a/0x30
<4>[ 8.197604] </TASK>

Fix this issue in the same way as rapl powercap package domain is added
from the same CPU online callback by introducing another interface which
doesn't call cpus_read_lock(). Add rapl_package_add_pmu_locked() and
rapl_package_remove_pmu_locked() which don't call cpus_read_lock().

Fixes: 748d6ba43afd ("powercap: intel_rapl: Enable MSR-based RAPL PMU support")
Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/linux-pm/5427ede1-57a0-43d1-99f3-8ca4b0643e82@intel.com/T/#u
Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: RavitejaX Veesam <ravitejax.veesam@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 24 ++++++++++++++++++------
 drivers/powercap/intel_rapl_msr.c    |  4 ++--
 include/linux/intel_rapl.h           |  4 ++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index b9d87e56cbbc..3ff6da3bf4e6 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -2032,7 +2032,7 @@ static int rapl_pmu_update(struct rapl_package *rp)
 	return ret;
 }
 
-int rapl_package_add_pmu(struct rapl_package *rp)
+int rapl_package_add_pmu_locked(struct rapl_package *rp)
 {
 	struct rapl_package_pmu_data *data = &rp->pmu_data;
 	int idx;
@@ -2040,8 +2040,6 @@ int rapl_package_add_pmu(struct rapl_package *rp)
 	if (rp->has_pmu)
 		return -EEXIST;
 
-	guard(cpus_read_lock)();
-
 	for (idx = 0; idx < rp->nr_domains; idx++) {
 		struct rapl_domain *rd = &rp->domains[idx];
 		int domain = rd->id;
@@ -2091,17 +2089,23 @@ int rapl_package_add_pmu(struct rapl_package *rp)
 
 	return rapl_pmu_update(rp);
 }
+EXPORT_SYMBOL_GPL(rapl_package_add_pmu_locked);
+
+int rapl_package_add_pmu(struct rapl_package *rp)
+{
+	guard(cpus_read_lock)();
+
+	return rapl_package_add_pmu_locked(rp);
+}
 EXPORT_SYMBOL_GPL(rapl_package_add_pmu);
 
-void rapl_package_remove_pmu(struct rapl_package *rp)
+void rapl_package_remove_pmu_locked(struct rapl_package *rp)
 {
 	struct rapl_package *pos;
 
 	if (!rp->has_pmu)
 		return;
 
-	guard(cpus_read_lock)();
-
 	list_for_each_entry(pos, &rapl_packages, plist) {
 		/* PMU is still needed */
 		if (pos->has_pmu && pos != rp)
@@ -2111,6 +2115,14 @@ void rapl_package_remove_pmu(struct rapl_package *rp)
 	perf_pmu_unregister(&rapl_pmu.pmu);
 	memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
 }
+EXPORT_SYMBOL_GPL(rapl_package_remove_pmu_locked);
+
+void rapl_package_remove_pmu(struct rapl_package *rp)
+{
+	guard(cpus_read_lock)();
+
+	rapl_package_remove_pmu_locked(rp);
+}
 EXPORT_SYMBOL_GPL(rapl_package_remove_pmu);
 #endif
 
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 0ce1096b6314..9a7e150b3536 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -82,7 +82,7 @@ static int rapl_cpu_online(unsigned int cpu)
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 		if (rapl_msr_pmu)
-			rapl_package_add_pmu(rp);
+			rapl_package_add_pmu_locked(rp);
 	}
 	cpumask_set_cpu(cpu, &rp->cpumask);
 	return 0;
@@ -101,7 +101,7 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	lead_cpu = cpumask_first(&rp->cpumask);
 	if (lead_cpu >= nr_cpu_ids) {
 		if (rapl_msr_pmu)
-			rapl_package_remove_pmu(rp);
+			rapl_package_remove_pmu_locked(rp);
 		rapl_remove_package_cpuslocked(rp);
 	} else if (rp->lead_cpu == cpu) {
 		rp->lead_cpu = lead_cpu;
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index e9ade2ff4af6..f479ef5b3341 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -214,10 +214,14 @@ void rapl_remove_package(struct rapl_package *rp);
 
 #ifdef CONFIG_PERF_EVENTS
 int rapl_package_add_pmu(struct rapl_package *rp);
+int rapl_package_add_pmu_locked(struct rapl_package *rp);
 void rapl_package_remove_pmu(struct rapl_package *rp);
+void rapl_package_remove_pmu_locked(struct rapl_package *rp);
 #else
 static inline int rapl_package_add_pmu(struct rapl_package *rp) { return 0; }
+static inline int rapl_package_add_pmu_locked(struct rapl_package *rp) { return 0; }
 static inline void rapl_package_remove_pmu(struct rapl_package *rp) { }
+static inline void rapl_package_remove_pmu_locked(struct rapl_package *rp) { }
 #endif
 
 #endif /* __INTEL_RAPL_H__ */
-- 
2.48.1


