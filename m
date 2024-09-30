Return-Path: <linux-pm+bounces-14943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E007998A79D
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEE9283D77
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D1192D6F;
	Mon, 30 Sep 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAyfvKIq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB0192B61;
	Mon, 30 Sep 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707648; cv=none; b=isd5XCKhnpOD9UnunlznRa1ookXaX1+SDyxCuU9AMoFksvJt1yQadSGlCeFcG972IukroE5LbtM2VKyXf8gMDuu2bSi31e3KXT+ot+MqiEovTJbEUB5b1/3ArTZ/ZmQqFaoppcJgDwR2mBcbne44I5nUjcQZrrPC+++tk/b/AnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707648; c=relaxed/simple;
	bh=G8OtmEhVtATxkKEEZzFfB6L9t5MQyvm532qH9wBmlMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFH9soVguWfoq0dnGGzjU33EbRl0ThSe5N8gK07E4JaUbvr5YijTlSFOxctgd22vRRyxoV33rwfXdXPrSTloGKUWpIDhwly0JT9su12+DW2Ty9YARyManF6we/NFQprBQ6i/D+V39ZK0iSOfyeEIe6ANxhhnJRo6CB+B8mF55cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAyfvKIq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707646; x=1759243646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G8OtmEhVtATxkKEEZzFfB6L9t5MQyvm532qH9wBmlMg=;
  b=RAyfvKIqg36CgWFdL+9jg6TybekcppQa45AwVMYsgFbACbJ9BSkd9V50
   guvW60DzSwKc3ts0qqQzuwENGqqD2DzYxdDXjCnfi6BYD0puo3uekhylt
   /QaWccz/uvbDbqHWVVTkUL0shNbjwL/K5LqIoCVj+kgmjPnq5tgHUw5cH
   7i/PRvjlQihag44H1WV15cNVJfkeKmdbkQOmZph2PzEiaQWuRZiCap2D4
   JlGTFn+2c11hC/Kll//11FrJtjxPtaD8wBGJTJKBrv3fV4OKg5Q8WeqMk
   QOuufhyEvVRVJCiu1cqXXSIdfRPwiA3n4XBu8+nCvk30C6e64E9jdEaHv
   A==;
X-CSE-ConnectionGUID: 72NJhCbZReOgmsccaJrPMQ==
X-CSE-MsgGUID: /n4pRO47SLqLDJWYYu/Uxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="38187321"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="38187321"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:26 -0700
X-CSE-ConnectionGUID: EyY0dBzvR7+mwFbcE+UQ0Q==
X-CSE-MsgGUID: fU+19JXcSb6R3JKaVfxqEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72996010"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:25 -0700
Date: Mon, 30 Sep 2024 07:47:24 -0700
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
Subject: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>

Sometimes it is required to take actions based on if a CPU is a performance
or efficiency core. As an example, intel_pstate driver uses the Intel
core-type to determine CPU scaling. Also, some CPU vulnerabilities only
affect a specific CPU type, like RFDS only affects Intel Atom. Hybrid
systems that have variants P+E, P-only(Core) and E-only(Atom), it is not
straightforward to identify which variant is affected by a type specific
vulnerability.

Such processors do have CPUID field that can uniquely identify them. Like,
P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE identification, while
P+E additionally enumerates CPUID.7.HYBRID. Based on this information, it
is possible for boot CPU to identify if a system has mixed CPU types.

Add a new field hw_cpu_type to struct cpuinfo_topology that stores the
hardware specific CPU type. This saves the overhead of IPIs to get the CPU
type of a different CPU. CPU type is populated early in the boot process,
before vulnerabilities are enumerated.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu.h            |  6 ++++++
 arch/x86/include/asm/processor.h      | 11 +++++++++++
 arch/x86/include/asm/topology.h       |  8 ++++++++
 arch/x86/kernel/cpu/debugfs.c         |  1 +
 arch/x86/kernel/cpu/intel.c           |  5 +++++
 arch/x86/kernel/cpu/topology_common.c | 11 +++++++++++
 6 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index aa30fd8cad7f..2244dd86066a 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -32,6 +32,7 @@ extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
 u8 get_this_hybrid_cpu_type(void);
+u32 intel_native_model_id(struct cpuinfo_x86 *c);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
@@ -50,6 +51,11 @@ static inline u8 get_this_hybrid_cpu_type(void)
 {
 	return 0;
 }
+
+static u32 intel_native_model_id(struct cpuinfo_x86 *c)
+{
+	return 0;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf..61c8336bc99b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -105,6 +105,17 @@ struct cpuinfo_topology {
 	// Cache level topology IDs
 	u32			llc_id;
 	u32			l2c_id;
+
+	// Hardware defined CPU-type
+	union {
+		u32		hw_cpu_type;
+		struct {
+			/* CPUID.1A.EAX[23-0] */
+			u32	intel_core_native_model_id:24;
+			/* CPUID.1A.EAX[31-24] */
+			u32	intel_core_type:8;
+		};
+	};
 };
 
 struct cpuinfo_x86 {
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index aef70336d624..faf7cb7f7d7e 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,6 +114,12 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
 };
 
+enum x86_topology_hw_cpu_type {
+	TOPO_HW_CPU_TYPE_UNKNOWN	= 0,
+	TOPO_HW_CPU_TYPE_INTEL_ATOM	= 0x20,
+	TOPO_HW_CPU_TYPE_INTEL_CORE	= 0x40,
+};
+
 struct x86_topology_system {
 	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int	dom_size[TOPO_MAX_DOMAIN];
@@ -149,6 +155,8 @@ extern unsigned int __max_threads_per_core;
 extern unsigned int __num_threads_per_package;
 extern unsigned int __num_cores_per_package;
 
+enum x86_topology_hw_cpu_type topology_hw_cpu_type(struct cpuinfo_x86 *c);
+
 static inline unsigned int topology_max_packages(void)
 {
 	return __max_logical_packages;
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index ca373b990c47..d1731e0e36b0 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "hw_cpu_type:       0x%x\n", c->topo.hw_cpu_type);
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e7656cbef68d..e56401c5c050 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1299,3 +1299,8 @@ u8 get_this_hybrid_cpu_type(void)
 
 	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
 }
+
+u32 intel_native_model_id(struct cpuinfo_x86 *c)
+{
+	return c->topo.intel_core_native_model_id;
+}
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 9a6069e7133c..e4814cd3d8ae 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -27,6 +27,14 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 	}
 }
 
+enum x86_topology_hw_cpu_type topology_hw_cpu_type(struct cpuinfo_x86 *c)
+{
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return c->topo.intel_core_type;
+
+	return c->topo.hw_cpu_type;
+}
+
 static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
 {
 	struct {
@@ -87,6 +95,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		.cu_id			= 0xff,
 		.llc_id			= BAD_APICID,
 		.l2c_id			= BAD_APICID,
+		.hw_cpu_type		= TOPO_HW_CPU_TYPE_UNKNOWN,
 	};
 	struct cpuinfo_x86 *c = tscan->c;
 	struct {
@@ -132,6 +141,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
+		if (c->cpuid_level >= 0x1a)
+			c->topo.hw_cpu_type = cpuid_eax(0x1a);
 		break;
 	case X86_VENDOR_HYGON:
 		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))

-- 
2.34.1



