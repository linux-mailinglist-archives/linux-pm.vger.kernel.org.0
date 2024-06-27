Return-Path: <linux-pm+bounces-10153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4866591B0CE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 22:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE331C24AF9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518631AB8ED;
	Thu, 27 Jun 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhzJ8g5t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB21AB526;
	Thu, 27 Jun 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521098; cv=none; b=g1ldIADuxwmYnG/45EVX1WWMcohxVjyqn15HIuJl7/a+n1UYrZ88vkL7jg7zFWfCJufXHrw7ZMZwAxC74dLnsgznbW/ERuPJb1NMiVSKo0idYs208dXf3Hv2bs30VB+a0A+VFY0G5L656tCwN3an35eThPn/VMX7fTWFUXi2BVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521098; c=relaxed/simple;
	bh=Z4q+zpMXd0kJ8jYYaQfZ8MixUXEGYXZEREi91EWfp04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0+2xI8eSB+2iF0zj++BptTbehFr9hiZqXenT9NWdzsCGl/wK5ArhRdVOKTG6rZ0j0aZkT8wrGD4QBWdhkZmH5RyR0HAngaEIzrJkroIRsRbijTC3JghbAFav3Ma1xpFusd+QtoioBE0AdRjatiO5fXpENlSkrY1AxlQzm6hbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhzJ8g5t; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719521097; x=1751057097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z4q+zpMXd0kJ8jYYaQfZ8MixUXEGYXZEREi91EWfp04=;
  b=QhzJ8g5t5knuGZz5MARzXRHQwjxp4zSwyLTwUary/FCpfN1DeKbqj+ht
   /NOYtSuVdVNjl0Bm2ZU2jIPsYcBU+WDSOD+2MizkDplto88UGVJLqHyyw
   Z7xnNsj3/d9HPm6tQh/hoMeUzn6HQ1ce8FHLok4oJyQ2QBMVFjU4Lp1pg
   vPEnBDQecAE69H49w9O7vlcv1mzSJ2cylaSZrLsp/5YkppRR3E45Ajq8F
   yhVfN10n5XJx9tVU6LJacRYTXrtpn2P/7vmYa+8kcw8jka6EMuvf87pVJ
   zqSL3E/ctJuFM/Z024A9mHAILUfGsGkVDeNrZohz2rtkhEbmkwIotwKpe
   A==;
X-CSE-ConnectionGUID: rDEn7FOQSBSiITeOUqZ+uA==
X-CSE-MsgGUID: l2MLB1ytROix8h8TvtyvAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16563661"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16563661"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:56 -0700
X-CSE-ConnectionGUID: wOzLDcVMTu2OYBg+UJfd7A==
X-CSE-MsgGUID: 2ffpSzJkQ8m/6HnQSujCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="67703836"
Received: from gbpfeiff-mobl.amr.corp.intel.com (HELO desk) ([10.255.229.132])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:56 -0700
Date: Thu, 27 Jun 2024 13:44:55 -0700
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
Subject: [PATCH PATCH v2 9/9] x86/rfds: Exclude P-only parts from the RFDS
 affected list
Message-ID: <20240627-add-cpu-type-v2-9-f927bde83ad0@linux.intel.com>
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

RFDS only affects Atom parts. Vendor/Family/Model matching in the affected
processor table makes Alderlake and Raptorlake P-only parts affected (which
are not affected in reality). This is because the affected hybrid and
E-only parts have the same Family/Model as the unaffected P-only parts.

Match CPU-type as Atom to exclude P-only parts as RFDS affected.

Note, a guest with the same Family/Model as the affected part may not have
leaf 1A enumerated to know its CPU-type, but it should not be a problem as
guest's Family/Model can anyways be inaccurate. Moreover, RFDS_NO or
RFDS_CLEAR enumeration by the VMM decides the affected status of the guest.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst | 8 --------
 arch/x86/kernel/cpu/common.c                                 | 9 +++++++--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
index 0585d02b9a6c..ad15417d39f9 100644
--- a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
@@ -29,14 +29,6 @@ Below is the list of affected Intel processors [#f1]_:
    RAPTORLAKE_S            06_BFH
    ===================  ============
 
-As an exception to this table, Intel Xeon E family parts ALDERLAKE(06_97H) and
-RAPTORLAKE(06_B7H) codenamed Catlow are not affected. They are reported as
-vulnerable in Linux because they share the same family/model with an affected
-part. Unlike their affected counterparts, they do not enumerate RFDS_CLEAR or
-CPUID.HYBRID. This information could be used to distinguish between the
-affected and unaffected parts, but it is deemed not worth adding complexity as
-the reporting is fixed automatically when these parts enumerate RFDS_NO.
-
 Mitigation
 ==========
 Intel released a microcode update that enables software to clear sensitive
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7e5cd14e509f..86e0c69a60f6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1209,6 +1209,11 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)	\
 	X86_MATCH_VFM_STEPPINGS(INTEL_##vfm, steppings, issues)
 
+#define VULNBL_INTEL_TYPE(vfm, cpu_type, issues)			\
+	X86_MATCH_VFM_CPU_TYPE(INTEL_##vfm,				\
+			       X86_HW_CPU_TYPE_INTEL_##cpu_type,	\
+			       issues)
+
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
 
@@ -1255,9 +1260,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL(TIGERLAKE,			GDS),
 	VULNBL_INTEL(LAKEFIELD,			MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL(ROCKETLAKE,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL(ALDERLAKE,			RFDS),
 	VULNBL_INTEL(ALDERLAKE_L,		RFDS),
-	VULNBL_INTEL(RAPTORLAKE,		RFDS),
 	VULNBL_INTEL(RAPTORLAKE_P,		RFDS),
 	VULNBL_INTEL(RAPTORLAKE_S,		RFDS),
 	VULNBL_INTEL(ATOM_GRACEMONT,		RFDS),
@@ -1271,6 +1274,8 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	/* Match more than Vendor/Family/Model */
 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
 	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_TYPE     (ALDERLAKE,	ATOM,				RFDS),
+	VULNBL_INTEL_TYPE     (RAPTORLAKE,	ATOM,				RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),

-- 
2.34.1



