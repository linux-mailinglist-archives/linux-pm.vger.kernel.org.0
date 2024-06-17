Return-Path: <linux-pm+bounces-9299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CBD90A931
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384AD1C2161D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535C19148A;
	Mon, 17 Jun 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUbbmTdI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5A19148B;
	Mon, 17 Jun 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615490; cv=none; b=Wqh+ftYBlrqbLoywpTSRarXLg12xb7I4SwlSJ2rXqpL4tTAvRJznHCwkewATNKKIPyCnxtBarCjpK3FP5exUN6QSQjhixh+hsXWWFYdEZtUYcKp0W8++Y446hpbbAvs4rUMG2JLvnVFb9Dm9gwYVxhFmE9yDzGlled3f3iJJE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615490; c=relaxed/simple;
	bh=55aFiixm2MiUW1iDk8Nvs7xIh7ZXfrnQ5T1cw9UfRvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv7nmLd7MyXoGGxbKvnevM/spOnplFPexf6tjg1aF5w+A6viWpmri1bqyqmqK+27VM9at2To1NDADm1CuJxS6hk5te2TRXy0ITTIAH2BK8ewCOubBbt1b2xtGp+6n+YbGPVRvPsB4ZIL+rqqSI1HiVB0iy7qJfAe8r+79jRpH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUbbmTdI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718615489; x=1750151489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=55aFiixm2MiUW1iDk8Nvs7xIh7ZXfrnQ5T1cw9UfRvs=;
  b=aUbbmTdINnMgm0mHY+VBvGP4EnVCLWw+/9QOroB92Ugz16C1dxJox0XW
   0b3/vGGsjegOHyd2/HswHPJlcTH53OhJ8RMWlsa2DeBbqKFyMcSZkT3OO
   dlryEkL3VUnwgddJxN/yQFcDG8wx55gG/inIlzLsU5KnNVJICAISvKtV2
   DK8qrJBQCmoEi38n3nZrLdu1ICjMtTQtIrnY/5suqKv6BZDA/PPu810nd
   4oXCW0i6Rqdb5eDEY/AfnD7MwnjvC1twOWQ6zg7A0RAtRYBzFr8SNBR4p
   DxmGkrN8X5AHzYyA8i2Jy5ydhZmYnCunGx2DQAed6c03+ujGofrk0bjr7
   g==;
X-CSE-ConnectionGUID: 4V1LvNaGRqSbqR7YJh/aTA==
X-CSE-MsgGUID: 3rYGPa4wT9W3W5Ykb5bWRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="32902522"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="32902522"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:28 -0700
X-CSE-ConnectionGUID: uxF7vehdR6Cte5mg/2vTvA==
X-CSE-MsgGUID: 2Upe+dJxT2+aRJAMbSkOdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72338836"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:27 -0700
Date: Mon, 17 Jun 2024 02:11:26 -0700
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
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
Message-ID: <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>

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

Add a new field cpu_type to struct cpuinfo_topology which can be used to
match a CPU based on its type.

The cpu_type is populated in the below debugfs file:

  # cat /sys/kernel/debug/x86/topo/cpus/N

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/processor.h      | 3 +++
 arch/x86/include/asm/topology.h       | 9 +++++++++
 arch/x86/kernel/cpu/debugfs.c         | 1 +
 arch/x86/kernel/cpu/topology_common.c | 9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cb4f6c513c48..f310a7fb4e00 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -95,6 +95,9 @@ struct cpuinfo_topology {
 	// Core ID relative to the package
 	u32			core_id;
 
+	// CPU-type e.g. performance, efficiency etc.
+	u8			cpu_type;
+
 	// Logical ID mappings
 	u32			logical_pkg_id;
 	u32			logical_die_id;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index abe3a8f22cbd..b28ad9422afb 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -41,6 +41,14 @@
 /* Mappings between logical cpu number and node number */
 DECLARE_EARLY_PER_CPU(int, x86_cpu_to_node_map);
 
+#define X86_CPU_TYPE_INTEL_SHIFT	24
+
+enum x86_topo_cpu_type {
+	X86_CPU_TYPE_UNKNOWN		= 0,
+	X86_CPU_TYPE_INTEL_ATOM		= 0x20,
+	X86_CPU_TYPE_INTEL_CORE		= 0x40,
+};
+
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
 /*
  * override generic percpu implementation of cpu_to_node
@@ -139,6 +147,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
+#define topology_cpu_type(cpu)			(cpu_data(cpu).topo.cpu_type)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
 #define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.amd_node_id)
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e435834..b1c9bafe6c39 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "cpu_type:            %x\n", c->topo.cpu_type);
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 9a6069e7133c..be82c8769bb2 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -140,6 +140,14 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	}
 }
 
+static void topo_set_cpu_type(struct cpuinfo_x86 *c)
+{
+	c->topo.cpu_type = X86_CPU_TYPE_UNKNOWN;
+
+	if (c->x86_vendor == X86_VENDOR_INTEL && cpuid_eax(0) >= 0x1a)
+		c->topo.cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
+}
+
 static void topo_set_ids(struct topo_scan *tscan, bool early)
 {
 	struct cpuinfo_x86 *c = tscan->c;
@@ -190,6 +198,7 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
 	}
 
 	topo_set_ids(&tscan, false);
+	topo_set_cpu_type(c);
 }
 
 void __init cpu_init_topology(struct cpuinfo_x86 *c)

-- 
2.34.1



