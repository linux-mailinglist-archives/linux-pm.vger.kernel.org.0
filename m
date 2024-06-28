Return-Path: <linux-pm+bounces-10211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A2091C61A
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CFC284B5C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218024D9EA;
	Fri, 28 Jun 2024 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JK3dczMm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB253362;
	Fri, 28 Jun 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600708; cv=none; b=t56HQ1O8R/w902YIPwyz+AQkT34xDxY3+n3bxTi3t5ndwDwx+fbCk9bUwSLd+D0e4yvPli3X+9ZIS5Ia8kvVBuP3KQOTl6q3KnLPerZeL90t3loQxYnS/B6567r8wh1UyvgtkAx34kbT3yMZAB8+51xxs3CeNVQfZC+qQ9kw0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600708; c=relaxed/simple;
	bh=0mVwVb8/wsP6Qrhr+3pzhUVx26tygX+NY6MLT5uQ/ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbujOd+p+k9r4PK9RkP+eV+ESoGJIpB0y9ldYfc4jwQTKXzr/b0oJowUbdpT12dbv7+AT8SQ1xg+9CG3EdskkjpHaJMPt4A1evyX7c8aly6szuyuXUUNB+jQKxONwZT92454Tvj4zJ+uXcigXudcW7t2sWd3JkG43FBe9WsAzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JK3dczMm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719600706; x=1751136706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0mVwVb8/wsP6Qrhr+3pzhUVx26tygX+NY6MLT5uQ/ZA=;
  b=JK3dczMmrgjqTfs/Gz4esrLaWePRjIvlr9WrH7OjvceDu4AhU1amyJOl
   UmxwkTGA9gdgIKXeN7NXu+rn8p/7IOsrKppqR+CAI4vjcGogDsUBqxQJJ
   pIqEX1y44vWAIwGpX5O9eP8rKRCtdqYNSe6BEQTr1lsoHT7MtSK7NzaSr
   u/SdfIZa8/OX+/XQvMWQE5ttBCiso8pfeQZjGCYBosYtZGDJGjyLVDYda
   NBFVG558db7AWrGOBoh5S9Y+mld197rXUE28eqFQVppd3UyJ5NtS5eFsg
   Q9sbStBXX0Yt/NTXtfThBwB962nxp09a8W8DW47vJWHZDvjGxKBgWY8t7
   A==;
X-CSE-ConnectionGUID: 2kodwAz3Tn6Z8Q0nOjpQLw==
X-CSE-MsgGUID: nZE3YfUcTlmrTxBvDvHigA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="27928125"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="27928125"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 11:51:45 -0700
X-CSE-ConnectionGUID: qsaLQJSdR9u+clY8lKiLFA==
X-CSE-MsgGUID: YKLOq80NR8ienoXA7Lcz/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="45243745"
Received: from tensaeke-mobl1.amr.corp.intel.com (HELO desk) ([10.209.8.52])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 11:51:45 -0700
Date: Fri, 28 Jun 2024 11:51:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
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
	Perry Yuan <Perry.Yuan@amd.com>
Subject: Re: [PATCH v2 3/9] perf/x86/intel: Use topology_hw_cpu_type()
Message-ID: <20240628185136.6rl4x3no3vl3zben@desk>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-3-f927bde83ad0@linux.intel.com>
 <09000f4e-f373-448f-afef-35d2a413929f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09000f4e-f373-448f-afef-35d2a413929f@linux.intel.com>

On Fri, Jun 28, 2024 at 04:59:18PM +0800, Mi, Dapeng wrote:
> 
> On 6/28/2024 4:44 AM, Pawan Gupta wrote:
> > get_this_hybrid_cpu_type() misses a case when cpu-type is populated
> > regardless of X86_FEATURE_HYBRID_CPU. This is particularly true for hybrid
> > variants that have P or E cores fused off.
> >
> > Instead use topology_hw_cpu_type() as it does not rely on hybrid feature to
> > enumerate cpu-type. This can also help avoid the model-specific fixup
> > get_hybrid_cpu_type().
> >
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  arch/x86/events/intel/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 38c1b1f1deaa..0da1fd14b0ea 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -4753,7 +4753,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
> >  
> >  static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
> >  {
> > -	u8 cpu_type = get_this_hybrid_cpu_type();
> > +	u8 cpu_type = topology_hw_cpu_type(smp_processor_id());
> 
> As Kan said, ARL-H would have two different atom uarchs, so we have to use
> the extra native model id to identify them for PMU enabling. I'm not sure
> if we need a similar helper topology_hw_cpu_native_id(), it may depend on
> if the native id needs to be exposed to user space? such as whether there
> are different vulnerabilities between these two atom uarchs?
> 
> For PMU enabling, we don't need to expose the native model ID to user
> space, so we define a new helper get_this_hybrid_cpu_native_id() and
> leverage it to identify the atom uarch.

As CPUID.1A.EAX returns both the native model ID and core type, we can
store it raw in topo->hw_cpu_type. Such that topo->hw_cpu_type contains
both the native model ID and core-type. Then use accessors to get them
separately?

As per Intel SDM Vol 2A, table 3-8, combination of core-type and native
model ID identifies the microarchitecture uniquely:

  EAX Enumerates the native model ID and core type.

	Bits 31-24: Core type*
		10H: Reserved
		20H: Intel Atom®
		30H: Reserved
		40H: Intel® Core™

	Bits 23-00: Native model ID of the core. The core-type and native
	model ID can be used to uniquely identify the microarchitecture of
	the core.

Let me know if below patch that implements intel_get_native_model_id()
would work for your use case:

---
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 20e491c22b98..eaa84e4e4771 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -26,11 +26,13 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+enum x86_hw_topo_cpu_type x86_get_hw_cpu_type(struct cpuinfo_x86 *c);
 #ifdef CONFIG_CPU_SUP_INTEL
 extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
+u32 intel_get_native_model_id(struct cpuinfo_x86 *c);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
@@ -44,6 +46,7 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 }
 
 static inline void handle_bus_lock(struct pt_regs *regs) {}
+u32 intel_get_native_model_id(struct cpuinfo_x86 *c)  { return 0; }
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d8d715fcc25c..08794668750f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -107,7 +107,7 @@ struct cpuinfo_topology {
 	u32			l2c_id;
 
 	// Hardware defined CPU-type
-	u8			hw_cpu_type;
+	u32			hw_cpu_type;
 };
 
 struct cpuinfo_x86 {
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 717fdb928dc3..70f1a9661ce3 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -33,8 +33,6 @@
 #include <linux/numa.h>
 #include <linux/cpumask.h>
 
-#define X86_CPU_TYPE_INTEL_SHIFT	24
-
 enum x86_hw_topo_cpu_type {
 	X86_HW_CPU_TYPE_UNKNOWN		= 0,
 	X86_HW_CPU_TYPE_INTEL_ATOM	= 0x20,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 86e0c69a60f6..151c2377df21 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1292,6 +1292,11 @@ static bool __init cpu_matches(const struct x86_cpu_id *table, unsigned long whi
 	return m && !!(m->driver_data & which);
 }
 
+enum x86_hw_topo_cpu_type __weak x86_get_hw_cpu_type(struct cpuinfo_x86 *c)
+{
+	return X86_HW_CPU_TYPE_UNKNOWN;
+}
+
 u64 x86_read_arch_cap_msr(void)
 {
 	u64 x86_arch_cap_msr = 0;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index ac6c68a39051..3a951632d210 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1335,3 +1335,16 @@ void __init sld_setup(struct cpuinfo_x86 *c)
 	sld_state_setup();
 	sld_state_show();
 }
+
+#define X86_INTEL_CPU_TYPE_SHIFT	24
+#define X86_INTEL_NATIVE_MODEL_ID_MASK	((1 << X86_INTEL_CPU_TYPE_SHIFT) - 1)
+
+enum x86_hw_topo_cpu_type x86_get_hw_cpu_type(struct cpuinfo_x86 *c)
+{
+	return c->topo.hw_cpu_type >> X86_INTEL_CPU_TYPE_SHIFT;
+}
+
+u32 intel_get_native_model_id(struct cpuinfo_x86 *c)
+{
+	return c->topo.hw_cpu_type & X86_INTEL_NATIVE_MODEL_ID_MASK;
+}
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 85ef17325c06..8493bcd4db0b 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu.h>
 #include <linux/cpu.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -22,7 +23,7 @@ static bool x86_match_hw_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id
 	if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
 		return true;
 
-	return c->topo.hw_cpu_type == m->cpu_type;
+	return m->cpu_type == x86_get_hw_cpu_type(c);
 }
 
 /**
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 8b47bd6b0623..819f850b1960 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -87,6 +87,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		.cu_id			= 0xff,
 		.llc_id			= BAD_APICID,
 		.l2c_id			= BAD_APICID,
+		.hw_cpu_type		= X86_HW_CPU_TYPE_UNKNOWN,
 	};
 	struct cpuinfo_x86 *c = tscan->c;
 	struct {
@@ -132,6 +133,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
+		if (c->cpuid_level >= 0x1a)
+			c->topo.hw_cpu_type = cpuid_eax(0x1a);
 		break;
 	case X86_VENDOR_HYGON:
 		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))
@@ -140,14 +143,6 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	}
 }
 
-static void topo_set_hw_cpu_type(struct cpuinfo_x86 *c)
-{
-	c->topo.hw_cpu_type = X86_HW_CPU_TYPE_UNKNOWN;
-
-	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 0x1a)
-		c->topo.hw_cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
-}
-
 static void topo_set_ids(struct topo_scan *tscan, bool early)
 {
 	struct cpuinfo_x86 *c = tscan->c;
@@ -198,7 +193,6 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
 	}
 
 	topo_set_ids(&tscan, false);
-	topo_set_hw_cpu_type(c);
 }
 
 void __init cpu_init_topology(struct cpuinfo_x86 *c)

