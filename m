Return-Path: <linux-pm+bounces-10145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965A91B0B8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 22:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE321C22DC0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228441A2C01;
	Thu, 27 Jun 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGMxtzd1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C61A2562;
	Thu, 27 Jun 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521049; cv=none; b=RR/BQpfSkH9hjjzU6yZqVrwPD6YyAsVsRF7Xhr0WR0wgx6YKv2mSturM2R0ZTHpvkiMkTpxhi9yYqcAXMe17oUfFJVc9BlOE2eotpHPkGHrkCoSh7rSk4TB408SPhY8C7r/FSjBfNHcAS/Bu8kchg0FjyIkpAEewvQryqgZTtkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521049; c=relaxed/simple;
	bh=GSnYrv2tIngbGP7UO6mPjG1VZqxU7RfQH2ltGkwIMPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhPShrzNG4hR3dDJUVJiZl5MLBYL6CQKO6OR8HNTh1lKve35S3Vun7J8kRid4SKxOb7Upn0su1g8p9C0JOYX1LeF3mJfDA4qkISCa0+Jvjy6KFRYaUDp7Eu2xxV1Nz9Tbp+fjShPhkwiyd/oRcAOBgGvnSvZzpz7uuZWljJ6ET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGMxtzd1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719521047; x=1751057047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GSnYrv2tIngbGP7UO6mPjG1VZqxU7RfQH2ltGkwIMPI=;
  b=YGMxtzd1evtldTeTHbZmUua3j3Xp0iM2GuRGSRnuM53v5lkeeBgae/Aw
   FYJ3kSQw8oOKzbooLtjB4SZo2jp8ynp1yFc4EnFLn1JtFrC/aMk7NEOGh
   hhcYIFQ+MsDAt0f59eituyZoY6AUaloijMMH08fe3HuoL7KIMXwTAxqAY
   IfKKDocbAB47tVf5GhBF3fWPZF7K5/0sC5jBvfJiIGn+hJ/+cK9nHTzXS
   KecWMMxXGF+OKc/UvAZLajyD+q7BXSlvZvDsPcIFiA1JwDMGVWZliI2PY
   qKNGOuW7WZzMJ5u1A2rkwxxS7QbqK/pJkbQC5Qw7GHZgwh0n2sFd3emMR
   g==;
X-CSE-ConnectionGUID: tJBV7g8hT2OMXy9q6/ptaQ==
X-CSE-MsgGUID: g2sdqLsZSNGKuuEGnUsCqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27816191"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="27816191"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:07 -0700
X-CSE-ConnectionGUID: thV0zFdERkyaHSqWflpazw==
X-CSE-MsgGUID: 0hUuORO4THG75FcnuN/UhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44913242"
Received: from gbpfeiff-mobl.amr.corp.intel.com (HELO desk) ([10.255.229.132])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:07 -0700
Date: Thu, 27 Jun 2024 13:44:06 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH PATCH v2 1/9] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20240627-add-cpu-type-v2-1-f927bde83ad0@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>

Sometimes it is required to identify the type of a core for taking specific
actions e.g. intel_pstate driver uses the core type to determine CPU
scaling. Also, some CPU vulnerabilities only affect a specific CPU type
e.g. RFDS only affects Intel Atom. For hybrid systems that have variants
P+E, P-only(Core) and E-only(Atom), it gets challenging to identify which
variant is vulnerable to a specific vulnerability, as these variants share
the same family, model and stepping.

Such processors do have CPUID fields that uniquely identify them. Like,
P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE, while P+E
additionally enumerates CPUID.7.HYBRID. Linux does not currently use this
field.

Add a new field hw_cpu_type to struct cpuinfo_topology which can be used to
match a CPU based on its type.

The hw_cpu_type is populated in the below debugfs file:

  # cat /sys/kernel/debug/x86/topo/cpus/#

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/processor.h      | 3 +++
 arch/x86/include/asm/topology.h       | 9 +++++++++
 arch/x86/kernel/cpu/debugfs.c         | 1 +
 arch/x86/kernel/cpu/topology_common.c | 9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cb4f6c513c48..d8d715fcc25c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -105,6 +105,9 @@ struct cpuinfo_topology {
 	// Cache level topology IDs
 	u32			llc_id;
 	u32			l2c_id;
+
+	// Hardware defined CPU-type
+	u8			hw_cpu_type;
 };
 
 struct cpuinfo_x86 {
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index abe3a8f22cbd..717fdb928dc3 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -33,6 +33,14 @@
 #include <linux/numa.h>
 #include <linux/cpumask.h>
 
+#define X86_CPU_TYPE_INTEL_SHIFT	24
+
+enum x86_hw_topo_cpu_type {
+	X86_HW_CPU_TYPE_UNKNOWN		= 0,
+	X86_HW_CPU_TYPE_INTEL_ATOM	= 0x20,
+	X86_HW_CPU_TYPE_INTEL_CORE	= 0x40,
+};
+
 #ifdef CONFIG_NUMA
 
 #include <asm/mpspec.h>
@@ -139,6 +147,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
+#define topology_hw_cpu_type(cpu)		(cpu_data(cpu).topo.hw_cpu_type)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
 #define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.amd_node_id)
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e435834..8082e03a5976 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "hw_cpu_type:         %x\n", c->topo.hw_cpu_type);
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 9a6069e7133c..8b47bd6b0623 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -140,6 +140,14 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	}
 }
 
+static void topo_set_hw_cpu_type(struct cpuinfo_x86 *c)
+{
+	c->topo.hw_cpu_type = X86_HW_CPU_TYPE_UNKNOWN;
+
+	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 0x1a)
+		c->topo.hw_cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
+}
+
 static void topo_set_ids(struct topo_scan *tscan, bool early)
 {
 	struct cpuinfo_x86 *c = tscan->c;
@@ -190,6 +198,7 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
 	}
 
 	topo_set_ids(&tscan, false);
+	topo_set_hw_cpu_type(c);
 }
 
 void __init cpu_init_topology(struct cpuinfo_x86 *c)

-- 
2.34.1



