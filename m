Return-Path: <linux-pm+bounces-19097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C449EDFB5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB3F188BBB2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3849206273;
	Thu, 12 Dec 2024 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nY/NKtq/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633E204F6C;
	Thu, 12 Dec 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986695; cv=none; b=XEO+XQ21YXU5UFeAIYZwLVvZuIKSxGXhGa8rVERfJ/X3oivJJ2DBfvEu4CiH6wGs0DZlCbnuhUnmxetQjQvEvqPLs/0AbdCuh66bPGfx1HziK8wzBwD/gT/TWh27aQDgMllo4D9+YKO8yRFvCnouu+Al30FM/EfZrcvhdUfs5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986695; c=relaxed/simple;
	bh=Fx0ZCLqWOzQljs/MtxJYJD8s2HfC7ohosDnZj3Qo6xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQsjzv3kEijDfzjBOwsVHGVgLE6s/0mve+nBNkpN0+wvOxE1BglulMFu76KHq167mSLy5RhouC6cEjg7yhmD4cGbkeKc/q0YsJq3+bIjt2tvn44eyU3DaFtDCnhvhQSceBHT10iCiqW5BnX6JpIXwNfL6UgZgUao3+uk7APqP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nY/NKtq/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986694; x=1765522694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fx0ZCLqWOzQljs/MtxJYJD8s2HfC7ohosDnZj3Qo6xs=;
  b=nY/NKtq/CT5CKLtOeiOuDqIQPS+iGR/vZsNmC+wRfdGlY0pDaKhGztK8
   vJJiogQGIa7Mwssid+3Aa1+zjHKwUpIyKyE4NpwABzzime7vKk6v2AeLQ
   5C3v4oXYof95FfEylMfrJfkgSHVv6h88/RG8PMUhI4bneg5y24Dmsd+jh
   sGYdXyCLb0Rj4f+cGAF3G7GqAy1CBBRZ/rQilxjFp9G1nrPjbgld21U77
   6CEvHoQBgy7faiIjiWXb+I5/yucFq2E95hiNJlHZ8HONSiXgkkLJWw3Gz
   hZpi66z9jsFYnovX6URE6MKEUg4Q7vqJHMtreX/bSk/MP6pjYJENOPWpb
   w==;
X-CSE-ConnectionGUID: KiNAfjsXSkWAPCOSggv2qA==
X-CSE-MsgGUID: sd7jvndOSHC3PHVmHfP/mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38323894"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38323894"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:58:13 -0800
X-CSE-ConnectionGUID: Uj89yObIStaidYR3fAgnOg==
X-CSE-MsgGUID: M5YEAJM3QNeVxBYS36b0AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="126961270"
Received: from unknown (HELO desk) ([10.125.145.3])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:58:04 -0800
Date: Wed, 11 Dec 2024 22:58:03 -0800
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
Subject: [PATCH v5 8/9] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20241211-add-cpu-type-v5-8-2ae010f50370@linux.intel.com>
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

The affected processor table has a lot of repetition and redundant
information that can be omitted for brevity. Like:

  VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),

can easily be simplified to:

  VULNBL_INTEL(IVYBRIDGE,	SRBDS),

Apply this to all the entries in the affected processor table.

No functional change.

Disassembly of cpu_vuln_blacklist:

  objdump -j .init.data --disassemble=cpu_vuln_blacklist vmlinux

doesn't show any difference before and after the change.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 143 ++++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 70 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a5c28975c608..6c45b8bed9fc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1126,7 +1126,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, whitelist)
 
 #define VULNWL_INTEL(vfm, whitelist)		\
-	X86_MATCH_VFM(vfm, whitelist)
+	X86_MATCH_VFM(INTEL_##vfm, whitelist)
 
 #define VULNWL_AMD(family, whitelist)		\
 	VULNWL(AMD, family, X86_MODEL_ANY, whitelist)
@@ -1143,32 +1143,32 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL(VORTEX,	6, X86_MODEL_ANY,	NO_SPECULATION),
 
 	/* Intel Family 6 */
-	VULNWL_INTEL(INTEL_TIGERLAKE,		NO_MMIO),
-	VULNWL_INTEL(INTEL_TIGERLAKE_L,		NO_MMIO),
-	VULNWL_INTEL(INTEL_ALDERLAKE,		NO_MMIO),
-	VULNWL_INTEL(INTEL_ALDERLAKE_L,		NO_MMIO),
+	VULNWL_INTEL(TIGERLAKE,			NO_MMIO),
+	VULNWL_INTEL(TIGERLAKE_L,		NO_MMIO),
+	VULNWL_INTEL(ALDERLAKE,			NO_MMIO),
+	VULNWL_INTEL(ALDERLAKE_L,		NO_MMIO),
 
-	VULNWL_INTEL(INTEL_ATOM_SALTWELL,	NO_SPECULATION | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_SALTWELL_TABLET, NO_SPECULATION | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_SALTWELL_MID,	NO_SPECULATION | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_BONNELL,	NO_SPECULATION | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_BONNELL_MID,	NO_SPECULATION | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_SALTWELL,		NO_SPECULATION | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_SALTWELL_TABLET,	NO_SPECULATION | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_SALTWELL_MID,		NO_SPECULATION | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_BONNELL,		NO_SPECULATION | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_BONNELL_MID,		NO_SPECULATION | NO_ITLB_MULTIHIT),
 
-	VULNWL_INTEL(INTEL_ATOM_SILVERMONT,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_SILVERMONT_D,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_SILVERMONT_MID,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_XEON_PHI_KNL,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_XEON_PHI_KNM,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_SILVERMONT,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_SILVERMONT_D,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_SILVERMONT_MID,	NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_AIRMONT,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(XEON_PHI_KNL,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(XEON_PHI_KNM,		NO_SSB | NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
-	VULNWL_INTEL(INTEL_CORE_YONAH,		NO_SSB),
+	VULNWL_INTEL(CORE_YONAH,		NO_SSB),
 
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_AIRMONT_MID,		NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
+	VULNWL_INTEL(ATOM_AIRMONT_NP,		NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
-	VULNWL_INTEL(INTEL_ATOM_GOLDMONT,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_D,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_PLUS,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
+	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_INTEL(ATOM_GOLDMONT_D,		NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_INTEL(ATOM_GOLDMONT_PLUS,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
 
 	/*
 	 * Technically, swapgs isn't serializing on AMD (despite it previously
@@ -1178,9 +1178,9 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	 * good enough for our purposes.
 	 */
 
-	VULNWL_INTEL(INTEL_ATOM_TREMONT,	NO_EIBRS_PBRSB),
-	VULNWL_INTEL(INTEL_ATOM_TREMONT_L,	NO_EIBRS_PBRSB),
-	VULNWL_INTEL(INTEL_ATOM_TREMONT_D,	NO_ITLB_MULTIHIT | NO_EIBRS_PBRSB),
+	VULNWL_INTEL(ATOM_TREMONT,	NO_EIBRS_PBRSB),
+	VULNWL_INTEL(ATOM_TREMONT_L,	NO_EIBRS_PBRSB),
+	VULNWL_INTEL(ATOM_TREMONT_D,	NO_ITLB_MULTIHIT | NO_EIBRS_PBRSB),
 
 	/* AMD Family 0xf - 0x12 */
 	VULNWL_AMD(0x0f,	NO_MELTDOWN | NO_SSB | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_BHI),
@@ -1201,8 +1201,11 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL(vendor, family, model, blacklist)	\
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, blacklist)
 
-#define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)		   \
-	X86_MATCH_VFM_STEPPINGS(vfm, steppings, issues)
+#define VULNBL_INTEL(vfm, issues)			\
+	X86_MATCH_VFM(INTEL_##vfm, issues)
+
+#define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)	\
+	X86_MATCH_VFM_STEPPINGS(INTEL_##vfm, steppings, issues)
 
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
@@ -1227,49 +1230,49 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
-	VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_L,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_G,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_X,		X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_L,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_LAKEFIELD,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE,		X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GRACEMONT,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_D,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_PLUS, X86_STEPPING_ANY,		RFDS),
-
-	VULNBL_AMD(0x15, RETBLEED),
-	VULNBL_AMD(0x16, RETBLEED),
-	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_AMD(0x19, SRSO),
+	VULNBL_INTEL(		IVYBRIDGE,		SRBDS),
+	VULNBL_INTEL(		HASWELL,		SRBDS),
+	VULNBL_INTEL(		HASWELL_L,		SRBDS),
+	VULNBL_INTEL(		HASWELL_G,		SRBDS),
+	VULNBL_INTEL(		HASWELL_X,		MMIO),
+	VULNBL_INTEL(		BROADWELL_D,		MMIO),
+	VULNBL_INTEL(		BROADWELL_G,		SRBDS),
+	VULNBL_INTEL(		BROADWELL_X,		MMIO),
+	VULNBL_INTEL(		BROADWELL,		SRBDS),
+	VULNBL_INTEL(		SKYLAKE_X,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL(		SKYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL(		SKYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL(		KABYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL(		KABYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL(		CANNONLAKE_L,		RETBLEED),
+	VULNBL_INTEL(		ICELAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL(		ICELAKE_D,		MMIO | GDS),
+	VULNBL_INTEL(		ICELAKE_X,		MMIO | GDS),
+	VULNBL_INTEL(		COMETLAKE,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(	COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0), MMIO | RETBLEED),
+	VULNBL_INTEL(		COMETLAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL(		TIGERLAKE_L,		GDS),
+	VULNBL_INTEL(		TIGERLAKE,		GDS),
+	VULNBL_INTEL(		LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
+	VULNBL_INTEL(		ROCKETLAKE,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL(		ALDERLAKE,		RFDS),
+	VULNBL_INTEL(		ALDERLAKE_L,		RFDS),
+	VULNBL_INTEL(		RAPTORLAKE,		RFDS),
+	VULNBL_INTEL(		RAPTORLAKE_P,		RFDS),
+	VULNBL_INTEL(		RAPTORLAKE_S,		RFDS),
+	VULNBL_INTEL(		ATOM_GRACEMONT,		RFDS),
+	VULNBL_INTEL(		ATOM_TREMONT,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL(		ATOM_TREMONT_D,		MMIO | RFDS),
+	VULNBL_INTEL(		ATOM_TREMONT_L,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL(		ATOM_GOLDMONT,		RFDS),
+	VULNBL_INTEL(		ATOM_GOLDMONT_D,	RFDS),
+	VULNBL_INTEL(		ATOM_GOLDMONT_PLUS,	RFDS),
+
+	VULNBL_AMD(		0x15,			RETBLEED),
+	VULNBL_AMD(		0x16,			RETBLEED),
+	VULNBL_AMD(		0x17,			RETBLEED | SMT_RSB | SRSO),
+	VULNBL_HYGON(		0x18,			RETBLEED | SMT_RSB | SRSO),
+	VULNBL_AMD(		0x19,			SRSO),
 	{}
 };
 

-- 
2.34.1



