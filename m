Return-Path: <linux-pm+bounces-14950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB798A7B3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1981C2348B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FDB1990CE;
	Mon, 30 Sep 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nghQakj5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413519258D;
	Mon, 30 Sep 2024 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707693; cv=none; b=NqbrV1zsb38cl31fZzgGxLmzUrmr1LN7pHbiqQHSYioyS149xQTdGQaEhcxoUh/k0hVvKRt+dV2HRP3YdC5QowH25uphCWEnbzT+zV1slsyzD+/FD+E2rz636fZJjBNCcSivo5r5YIECBJZSlHIGwJvMRaQldqmHdptY1W/Ynes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707693; c=relaxed/simple;
	bh=r3Cq3T8h20K4RfKNWRSrXezrzW/2J5IwhygS9pghReI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVPz84vboUN2kqr8BiE926x5GP8GYwwiSVDZTy7D3SAhHU8Yy2s503SS3D7OeiOfD+elQRhBTnZqqfM36d3NA+E+nKagzoGNhLILA8+QuWNfT+CzCc8b14ZCZLD56R1536J7TG7dCPWuXi0RQ4F/LqI0mT0Vp0h3A8S6fKyzjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nghQakj5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707691; x=1759243691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r3Cq3T8h20K4RfKNWRSrXezrzW/2J5IwhygS9pghReI=;
  b=nghQakj51EzwAVZvV8Bx5Gpjxrm5YQu1+Kq5ZhMQnQb2rbIrARzS4px6
   eN/xgpaUF46YI3Me9XbVfrcntCfdjFGFjh2tJ2lNbHl9yt9swEmI1KVrq
   OTbz6n0lhLtakRKScb2t2Qq0iD5MQBec8RQSyaO+on+DyRd4DNMuBT6OH
   J76rgYwr+gmDitBlNiczKYz9y3FMsHWweSlDpaAVErEYySmw2bxT/rtho
   kKhgroklhJtlx1HJgAONZ0gkQoEhiYovv7Bh8sWYTaq+/uZu3m4BNBv6D
   b1QPzgh8U8ZrS672yv8Z7CErOvpNUuktH21CsNmFQDJON6mcTK8iPYH2x
   Q==;
X-CSE-ConnectionGUID: RxFPoJlpTmqDKrDHqpYoDQ==
X-CSE-MsgGUID: 0oQvhNK6Rt+BHAfL71bR4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44262314"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44262314"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:48:11 -0700
X-CSE-ConnectionGUID: 3e2jhm63T1WfVxaCLO7lNw==
X-CSE-MsgGUID: 2xdWKCiVS2iMqIhac+sXog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73455178"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:48:10 -0700
Date: Mon, 30 Sep 2024 07:48:09 -0700
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
Subject: [PATCH v4 09/10] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20240930-add-cpu-type-v4-9-104892b7ab5f@linux.intel.com>
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
index 07a34d723505..66f691db5ec6 100644
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



