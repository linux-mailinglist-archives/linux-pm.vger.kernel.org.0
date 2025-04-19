Return-Path: <linux-pm+bounces-25738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE3A94120
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 04:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D9E8E079F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC014901B;
	Sat, 19 Apr 2025 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4ORdicG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6B3A1CD;
	Sat, 19 Apr 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745030992; cv=none; b=KBNgY+GxhHPYpBaOsVxhbDglHT+vvDSIUdmubqvdcClIByoaZ7DWlsp+Rr9sOnQyw6AvTaEfgr+vdojUJPP0RNk4DKxug9E7WWCQM2lcKGBhhUC9xDDEmi3VjcmXdPli065juJRTQKezhhUNIVaDgGl21/SPkp2FQZkdHfSEOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745030992; c=relaxed/simple;
	bh=eR+kUnG/TXslK7OUwK7QkTBJMv1nyJJmD22Aym8QCXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m94mhveGvNUpB/LLU8bg2+DUYfdctPyA0TnRfqKRjkbCnOAFSIpoWlhV4pYGhCQ58SExd1Rf7oVvBFMdHAHTFT64nYfKUHe1Z3asyTkWzxnUUPgQwRfg/G7igemXe7Cesssg69wd3XPwJpWrjKClQmGCGA/c1jTWdZNg1P6SMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4ORdicG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745030991; x=1776566991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eR+kUnG/TXslK7OUwK7QkTBJMv1nyJJmD22Aym8QCXQ=;
  b=U4ORdicGQmQEhvzCszT2ebHFuL/Covkcr1OAQcHwu9+dKx0/CLPBPvjp
   m38DIZNlFT8W9cHA3OF6Y6RDpG5Ewh8KZSR65dZ6lB5i5XhR58AHk7FvM
   hx/z6Rn/n+VtC/FT4PeqPUxJTYHlMidm6lWOtA7Z8XCVxDupjAYxNrPtG
   RXUPOrr/Sjh+OrIOQVJPEyfiUXXr/skIevX4+6Wiexf1puK3ucP8oh4fe
   NcTHQwsklQ3KJH4hkI0Brn18s1hq6BHEOc22qDGhUs5bnRzzEgOs+Gcea
   WQiEtB2xpb1BRs7s/pC/yhixxX+isWVn9vvdxLTvNiHfyOjbq7Nnam+1U
   Q==;
X-CSE-ConnectionGUID: p6GA26juTXesbhzdVJaYgg==
X-CSE-MsgGUID: UxjZGBD9Rqe5dGi8WDQ1PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="50490436"
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="50490436"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 19:49:48 -0700
X-CSE-ConnectionGUID: HiYDBK0GRxWC12ioReK5ew==
X-CSE-MsgGUID: kmiB1qAUS6Cjbpk9QtpOVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,223,1739865600"; 
   d="scan'208";a="162308321"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa001.fm.intel.com with ESMTP; 18 Apr 2025 19:49:47 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 1/2] arch_topology: Relocate cpu_scale to topology.[h|c]
Date: Fri, 18 Apr 2025 19:55:03 -0700
Message-Id: <20250419025504.9760-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
References: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

arch_topology.c provides functionality to parse and scale CPU capacity. It
also provides a corresponding sysfs interface. Some architectures parse
and scale CPU capacity differently as per their own needs. On Intel
processors, for instance, it is responsibility of the Intel P-state driver.

Relocate the implementation of that interface to a common location in
topology.c. Architectures can use the interface and populate it using their
own mechanisms.

An alternative approach would be to compile arch_topology.c even if not
needed only to get this interface. This approach would create duplicated
and conflicting functionality and data structures.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/base/arch_topology.c  | 52 -----------------------------------
 drivers/base/topology.c       | 52 +++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h |  8 ------
 include/linux/topology.h      |  9 ++++++
 4 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index af0029d30dbe..1037169abb45 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -154,14 +154,6 @@ void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 		per_cpu(arch_freq_scale, i) = scale;
 }
 
-DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
-EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);
-
-void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
-{
-	per_cpu(cpu_scale, cpu) = capacity;
-}
-
 DEFINE_PER_CPU(unsigned long, hw_pressure);
 
 /**
@@ -207,53 +199,9 @@ void topology_update_hw_pressure(const struct cpumask *cpus,
 }
 EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
 
-static ssize_t cpu_capacity_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct cpu *cpu = container_of(dev, struct cpu, dev);
-
-	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
-}
-
 static void update_topology_flags_workfn(struct work_struct *work);
 static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
 
-static DEVICE_ATTR_RO(cpu_capacity);
-
-static int cpu_capacity_sysctl_add(unsigned int cpu)
-{
-	struct device *cpu_dev = get_cpu_device(cpu);
-
-	if (!cpu_dev)
-		return -ENOENT;
-
-	device_create_file(cpu_dev, &dev_attr_cpu_capacity);
-
-	return 0;
-}
-
-static int cpu_capacity_sysctl_remove(unsigned int cpu)
-{
-	struct device *cpu_dev = get_cpu_device(cpu);
-
-	if (!cpu_dev)
-		return -ENOENT;
-
-	device_remove_file(cpu_dev, &dev_attr_cpu_capacity);
-
-	return 0;
-}
-
-static int register_cpu_capacity_sysctl(void)
-{
-	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "topology/cpu-capacity",
-			  cpu_capacity_sysctl_add, cpu_capacity_sysctl_remove);
-
-	return 0;
-}
-subsys_initcall(register_cpu_capacity_sysctl);
-
 static int update_topology;
 
 int topology_update_cpu_topology(void)
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index b962da263eee..8b42df05feff 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -208,3 +208,55 @@ static int __init topology_sysfs_init(void)
 }
 
 device_initcall(topology_sysfs_init);
+
+DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);
+
+void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
+{
+	per_cpu(cpu_scale, cpu) = capacity;
+}
+
+static ssize_t cpu_capacity_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+
+	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
+}
+
+static DEVICE_ATTR_RO(cpu_capacity);
+
+static int cpu_capacity_sysctl_add(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!cpu_dev)
+		return -ENOENT;
+
+	device_create_file(cpu_dev, &dev_attr_cpu_capacity);
+
+	return 0;
+}
+
+static int cpu_capacity_sysctl_remove(unsigned int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+
+	if (!cpu_dev)
+		return -ENOENT;
+
+	device_remove_file(cpu_dev, &dev_attr_cpu_capacity);
+
+	return 0;
+}
+
+static int register_cpu_capacity_sysctl(void)
+{
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "topology/cpu-capacity",
+			  cpu_capacity_sysctl_add, cpu_capacity_sysctl_remove);
+
+	return 0;
+}
+subsys_initcall(register_cpu_capacity_sysctl);
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 2222e8b03ff4..d72d6e5aa200 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -14,14 +14,6 @@ int topology_update_cpu_topology(void);
 struct device_node;
 bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
-DECLARE_PER_CPU(unsigned long, cpu_scale);
-
-static inline unsigned long topology_get_cpu_scale(int cpu)
-{
-	return per_cpu(cpu_scale, cpu);
-}
-
-void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
 DECLARE_PER_CPU(unsigned long, capacity_freq_ref);
 
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 24e715f0f6d2..cd6b4bdc9cfd 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -332,4 +332,13 @@ sched_numa_hop_mask(unsigned int node, unsigned int hops)
 	     !IS_ERR_OR_NULL(mask);					       \
 	     __hops++)
 
+DECLARE_PER_CPU(unsigned long, cpu_scale);
+
+static inline unsigned long topology_get_cpu_scale(int cpu)
+{
+	return per_cpu(cpu_scale, cpu);
+}
+
+void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
+
 #endif /* _LINUX_TOPOLOGY_H */
-- 
2.43.0


