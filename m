Return-Path: <linux-pm+bounces-19091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7E39EDFA7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394BC2849EC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FE204F66;
	Thu, 12 Dec 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vws8QZ/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA81204F60;
	Thu, 12 Dec 2024 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986659; cv=none; b=EYeNM9pv456A0Vc5zQQBGxRm7JcunTq7VekO+eXHt0IFn5rLD7kfECSFJ3l2O2ZtHrPCNRohD8E8+yqO114M88pWmGFH0N5OVgvkgWC3Dcr1ZIfO7OpuH6+YU7Y2c+mQHdLilE3qeiaoajUfrIKvLB0S8RrXWCQwix2V/nB0Xqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986659; c=relaxed/simple;
	bh=SK/+JtQICpEJjfQtv2u02HuEDGoEPxUqFzCzGowfj88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTduDxwd6NNRbNZZqeoXROQ1x0pjkGlBC/+jFBTIUHmZJ5tDZfwUJvyxsRjbCx4b49nuLf707IvtAdk2NarhsM2NON2A3gFFa+ZLYN9y4TydyHwWks00ivVx557h3PlE/ocYah9R42lXVUI+5kL0pV7b7wjN1U07DpVpcFEha+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vws8QZ/t; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986658; x=1765522658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SK/+JtQICpEJjfQtv2u02HuEDGoEPxUqFzCzGowfj88=;
  b=Vws8QZ/t1iwUKjvQ2abBplxCXgep1ZQJirhlNf+gKLJdcqDyU6Sec1n6
   rnEgLvGLoQ3Vnk/+nX6bksudZ9ixLDuKQ63aCbjuQZsVRlwOoZvOcrpXH
   7x3BwqT/GLCK5uLMyoi4LhCDtMvRf+MzIxj9ozR7kaQEYqal1DN9f4odA
   GY1Od4dqqXILkwSQ6Hb0J5iMXY9a8RNEak7YvilMoujULVSb1AWBnSwYU
   MnE/LSBv2GgUTkS6znuuOAIHrOn/crBr71Bs0ARiG6RN9k2vMnILUFMxu
   I55LC/TPHQKW30nW3+CKghCb8Dgz2gtv+E7ULeJ2vew5bG4ORc9aLKjZC
   Q==;
X-CSE-ConnectionGUID: hFOzFKBySkmaeZAb/lk4zQ==
X-CSE-MsgGUID: fsdk6Hb4Q+uctdefZOaL4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34533430"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34533430"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:37 -0800
X-CSE-ConnectionGUID: HGZ+w1bbSw+w1norqgHTmQ==
X-CSE-MsgGUID: bNlpoya6R5GVxi5VQVXvqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96223518"
Received: from unknown (HELO desk) ([10.125.145.3])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:37 -0800
Date: Wed, 11 Dec 2024 22:57:36 -0800
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
Subject: [PATCH v5 3/9] perf/x86/intel: Use cache cpu-type for hybrid PMU
 selection
Message-ID: <20241211-add-cpu-type-v5-3-2ae010f50370@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>

get_this_hybrid_cpu_type() misses a case when cpu-type is populated
regardless of X86_FEATURE_HYBRID_CPU. This is particularly true for hybrid
variants that have P or E cores fused off.

Instead use the cpu-type cached in struct x86_topology, as it does not rely
on hybrid feature to enumerate cpu-type. This can also help avoid the
model-specific fixup get_hybrid_cpu_type(). Also replace the
get_this_hybrid_cpu_native_id() with its cached value in struct
x86_topology.

While at it, remove enum hybrid_cpu_type as it serves no purpose when we
have the exact cpu-types defined in enum intel_cpu_type. Also rename
atom_native_id to intel_native_id and move it to intel-family.h where
intel_cpu_type lives.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/events/intel/core.c        | 19 ++++++++++---------
 arch/x86/events/perf_event.h        | 19 +------------------
 arch/x86/include/asm/intel-family.h | 15 ++++++++++++++-
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bb284aff7bfd..9e9ab9d1938e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4588,9 +4588,9 @@ static int adl_hw_config(struct perf_event *event)
 	return -EOPNOTSUPP;
 }
 
-static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
+static enum intel_cpu_type adl_get_hybrid_cpu_type(void)
 {
-	return HYBRID_INTEL_CORE;
+	return INTEL_CPU_TYPE_CORE;
 }
 
 static inline bool erratum_hsw11(struct perf_event *event)
@@ -4928,7 +4928,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
-	u8 cpu_type = get_this_hybrid_cpu_type();
+	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+	enum intel_cpu_type cpu_type = c->topo.intel_type;
 	int i;
 
 	/*
@@ -4937,7 +4938,7 @@ static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 	 * on it. There should be a fixup function provided for these
 	 * troublesome CPUs (->get_hybrid_cpu_type).
 	 */
-	if (cpu_type == HYBRID_INTEL_NONE) {
+	if (cpu_type == INTEL_CPU_TYPE_UNKNOWN) {
 		if (x86_pmu.get_hybrid_cpu_type)
 			cpu_type = x86_pmu.get_hybrid_cpu_type();
 		else
@@ -4954,16 +4955,16 @@ static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 		enum hybrid_pmu_type pmu_type = x86_pmu.hybrid_pmu[i].pmu_type;
 		u32 native_id;
 
-		if (cpu_type == HYBRID_INTEL_CORE && pmu_type == hybrid_big)
+		if (cpu_type == INTEL_CPU_TYPE_CORE && pmu_type == hybrid_big)
 			return &x86_pmu.hybrid_pmu[i];
-		if (cpu_type == HYBRID_INTEL_ATOM) {
+		if (cpu_type == INTEL_CPU_TYPE_ATOM) {
 			if (x86_pmu.num_hybrid_pmus == 2 && pmu_type == hybrid_small)
 				return &x86_pmu.hybrid_pmu[i];
 
-			native_id = get_this_hybrid_cpu_native_id();
-			if (native_id == skt_native_id && pmu_type == hybrid_small)
+			native_id = c->topo.intel_native_model_id;
+			if (native_id == INTEL_ATOM_SKT_NATIVE_ID && pmu_type == hybrid_small)
 				return &x86_pmu.hybrid_pmu[i];
-			if (native_id == cmt_native_id && pmu_type == hybrid_tiny)
+			if (native_id == INTEL_ATOM_CMT_NATIVE_ID && pmu_type == hybrid_tiny)
 				return &x86_pmu.hybrid_pmu[i];
 		}
 	}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 82c6f45ce975..3c7d2ef5963a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -668,18 +668,6 @@ enum {
 #define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
 #define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
 
-/*
- * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
- * of the core. Bits 31-24 indicates its core type (Core or Atom)
- * and Bits [23:0] indicates the native model ID of the core.
- * Core type and native model ID are defined in below enumerations.
- */
-enum hybrid_cpu_type {
-	HYBRID_INTEL_NONE,
-	HYBRID_INTEL_ATOM	= 0x20,
-	HYBRID_INTEL_CORE	= 0x40,
-};
-
 #define X86_HYBRID_PMU_ATOM_IDX		0
 #define X86_HYBRID_PMU_CORE_IDX		1
 #define X86_HYBRID_PMU_TINY_IDX		2
@@ -696,11 +684,6 @@ enum hybrid_pmu_type {
 	hybrid_big_small_tiny	= hybrid_big   | hybrid_small_tiny,
 };
 
-enum atom_native_id {
-	cmt_native_id           = 0x2,  /* Crestmont */
-	skt_native_id           = 0x3,  /* Skymont */
-};
-
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
@@ -993,7 +976,7 @@ struct x86_pmu {
 	 */
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
-	enum hybrid_cpu_type (*get_hybrid_cpu_type)	(void);
+	enum intel_cpu_type (*get_hybrid_cpu_type)	(void);
 };
 
 struct x86_perf_task_context_opt {
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 6d7b04ffc5fd..8c7076445893 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -182,10 +182,23 @@
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
-/* CPU core types */
+/*
+ * Intel CPU core types
+ *
+ * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
+ * of the core. Bits 31-24 indicates its core type (Core or Atom)
+ * and Bits [23:0] indicates the native model ID of the core.
+ * Core type and native model ID are defined in below enumerations.
+ */
 enum intel_cpu_type {
+	INTEL_CPU_TYPE_UNKNOWN,
 	INTEL_CPU_TYPE_ATOM = 0x20,
 	INTEL_CPU_TYPE_CORE = 0x40,
 };
 
+enum intel_native_id {
+	INTEL_ATOM_CMT_NATIVE_ID = 0x2,  /* Crestmont */
+	INTEL_ATOM_SKT_NATIVE_ID = 0x3,  /* Skymont */
+};
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */

-- 
2.34.1



