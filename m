Return-Path: <linux-pm+bounces-12297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DD95407A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A9F1F2600D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EDC84A4E;
	Fri, 16 Aug 2024 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2ex/iQg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C814F12F;
	Fri, 16 Aug 2024 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781231; cv=none; b=a2CjU/D/c3p1U801qMJCsHMGT6k0ts/CaAR1W/OzXPqw5KwD0bI/BJIEf82QQHAb3ExgYWuOK21ZHimbD3ko8TKIfAC1hzVrYouR2yUy+/MKu2QBYtMWdhUmoRbcTINIT2d+56Bx8hAo8zVpcZrqYZGMiXTSIj/hkDSs7+BMD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781231; c=relaxed/simple;
	bh=5S2A3uPwKrWieZIT+1sjtnHd8vxNUzhPVdB+Ij7jH78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui7ul8uZ+ySqmiU/cvNbEf0asuavlxXz9jLrAI2b2G4Ezk2Hk8RasXb5cupwiPXGKJWVLvCtaV9l09oxBwwuVok1iEXIrdgpmsVeOliBBBnrFg6wLUIbUrKpA/8Sa5ucI6PJvOc5l0FAGMqpXZ1LEDGuBLIXbVtNOPMh7PSACtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2ex/iQg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781230; x=1755317230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5S2A3uPwKrWieZIT+1sjtnHd8vxNUzhPVdB+Ij7jH78=;
  b=I2ex/iQghd8LPS/EFm1O20hhBkAwrIvmvgLjy7mzfqlLE9bB+l8Wu3Ct
   Z9kprtxBlmurrqS2KFVYNmpatp4ZC2DC7cvjhhF9KDS2fkitk2UehFGew
   jAyng+7FQsXcN2EAFrgmB5mhAyCqd//plFIQtMfB0NLMk43bBMpP0hnYL
   bTwRhuKchpffF+RMrHDjvPUsGHH0+vf84GqwATdEyt/L4vuy5HHPuxmnf
   Te6nrKKr96rVvd/r35lqyQM/5KuCG+THcTkiRLvOQRzuD8RGrHqe8S102
   T7w2vrCmY69QQv/RQu2+N/u+su+EAkgrF64yTD6prytiIDzrhR4FfiS0P
   A==;
X-CSE-ConnectionGUID: UPfattgGRD2c3BDeOt4EdA==
X-CSE-MsgGUID: gJ8+q/jpTUufCIPti6oaBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21617838"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21617838"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:07:07 -0700
X-CSE-ConnectionGUID: xTmaydNcRpS6KTiA01cs6A==
X-CSE-MsgGUID: iygSvXvgTEe+IpUGY1jE4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="82758956"
Received: from kerandaa-mobl.amr.corp.intel.com (HELO desk) ([10.125.112.221])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:07:05 -0700
Date: Thu, 15 Aug 2024 21:07:04 -0700
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
Subject: [PATCH v3 09/10] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20240815-add-cpu-type-v3-9-234162352057@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>

The affected processor table has a lot of repetition and redundant
information that can be omitted. For example:

  VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),

can easily be simplified to:

  VULNBL_INTEL(IVYBRIDGE,	SRBDS),

Apply this to all the entries in the affected processor table.

No functional change.

Disassembly of cpu_vuln_blacklist:

  objdump -j .init.data --disassemble=cpu_vuln_blacklist vmlinux

doesn't show any difference before and after the change.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 143 ++++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 70 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..68115240eea9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1128,7 +1128,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, whitelist)
 
 #define VULNWL_INTEL(vfm, whitelist)		\
-	X86_MATCH_VFM(vfm, whitelist)
+	X86_MATCH_VFM(INTEL_##vfm, whitelist)
 
 #define VULNWL_AMD(family, whitelist)		\
 	VULNWL(AMD, family, X86_MODEL_ANY, whitelist)
@@ -1145,32 +1145,32 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
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
 
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_AIRMONT_MID,		NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(ATOM_AIRMONT_NP,		NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
-	VULNWL_INTEL(INTEL_ATOM_GOLDMONT,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_D,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_PLUS,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
+	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_INTEL(ATOM_GOLDMONT_D,		NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
+	VULNWL_INTEL(ATOM_GOLDMONT_PLUS,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO | NO_EIBRS_PBRSB),
 
 	/*
 	 * Technically, swapgs isn't serializing on AMD (despite it previously
@@ -1180,9 +1180,9 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
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
@@ -1203,8 +1203,11 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
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
@@ -1229,49 +1232,49 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
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



