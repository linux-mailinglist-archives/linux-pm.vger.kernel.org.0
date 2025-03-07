Return-Path: <linux-pm+bounces-23587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B028A55D8D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985727A9EA0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 02:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2449216C854;
	Fri,  7 Mar 2025 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+Ue42MS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44718168B1;
	Fri,  7 Mar 2025 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313935; cv=none; b=o9E9nJlJoUDNtH80epLs6cahnC5oWb1nmXgSELyf8H8v9tX57nr2yyqDnMu2ekCDFxwo3mi/4MGb4sb0GceYtrHFnZMPaq8gLSAfujZJRoP2FvcJAhldN5e9ZoPZFdzDFPvx0rQ0hVULPvFwzStpFhVUjLDHfRTpNanuvdGH2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313935; c=relaxed/simple;
	bh=BBNjOQP4CmwaTxuMkTvDmx+aoMhLUR9wQq+c3rEV3ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQA6Jli8Z+JWj3RLgZx0CDif/M+E//hZNDaKG0pgiRr3xJc35jswFWZHMTlTEgfabFcDqOb1YxqxN0tPpc2xyVhqAyTW1gUKbJQi2v+tVFSeg395CbwdRQKDwqirdeQE/TDH8w7OmIPP7s5iIlL1Mf9deZgWA5yQfXmTStGJrns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+Ue42MS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741313933; x=1772849933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BBNjOQP4CmwaTxuMkTvDmx+aoMhLUR9wQq+c3rEV3ww=;
  b=L+Ue42MScfb2d0wyOHYljdx62XtmQCyvo/UO+42JwGPW3YYk0F1E2DyR
   ggcigOL7a/xPj69xVcjCjSH/4wxnzhRl3Xy4BPvwW5O3VomfJfIzsVZVK
   vqbOD+SoqlOZtYw4ZBnBAVw2H2YTn9zwn7em0f7cet3awzOhMGKt8ldbi
   RPdodCKmDMwnD3jjRwVYaTIWbZXEbJ0GSCyInHnZsqmT2H+ToQMCBuJ2J
   /oHO0vQzyYaFSmAmOz3dZWRNWa0XoXsNCjWF3YGT2VO/jf0xwyIcqkOe+
   sf3fCCMZZfalUQaJiS3aV3ZpuWiqsdMSv9U2/eQgTmRsvpaCAHkfljJ7T
   Q==;
X-CSE-ConnectionGUID: dH17PXiWTGOnOnf7wr19Tg==
X-CSE-MsgGUID: ydnFBydiTtW6JXgjABRVZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="29934717"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="29934717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:18:53 -0800
X-CSE-ConnectionGUID: JKkJIdLWS3aHKIzOWwTvEg==
X-CSE-MsgGUID: pKiglwHkQFuC3tt+rfvhrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="124122710"
Received: from ylan1-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.179])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:18:53 -0800
Date: Thu, 6 Mar 2025 18:18:52 -0800
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
Subject: [PATCH v7 4/4] x86/rfds: Exclude P-only parts from the RFDS affected
 list
Message-ID: <20250306-add-cpu-type-v7-4-f903fb022fd4@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>

The affected CPU table (cpu_vuln_blacklist) marks Alderlake and Raptorlake
P-only parts affected by RFDS. This is not true because only E-cores are
affected by RFDS. With the current family/model matching it is not possible
to differentiate the unaffected parts, as the affected and unaffected
hybrid variants have the same model number.

Add a cpu-type match as well for such parts so as to exclude P-only parts
being marked as affected.

Note, family/model and cpu-type enumeration could be inaccurate in
virtualized environments. In a guest affected status is decided by RFDS_NO
and RFDS_CLEAR bits exposed by VMMs.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst | 8 --------
 arch/x86/kernel/cpu/common.c                                 | 7 +++++--
 2 files changed, 5 insertions(+), 10 deletions(-)

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
index 5f81c553e733..92fe56c40238 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1203,6 +1203,9 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL_INTEL_STEPS(vfm, max_stepping, issues)		   \
 	X86_MATCH_VFM_STEPS(vfm, X86_STEP_MIN, max_stepping, issues)
 
+#define VULNBL_INTEL_TYPE(vfm, cpu_type, issues)	\
+	X86_MATCH_VFM_CPU_TYPE(vfm, INTEL_CPU_TYPE_##cpu_type, issues)
+
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
 
@@ -1251,9 +1254,9 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS),
 	VULNBL_INTEL_STEPS(INTEL_LAKEFIELD,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,		     ATOM,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS),
-	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,		     ATOM,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_P,	     X86_STEP_MAX,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_S,	     X86_STEP_MAX,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ATOM_GRACEMONT,     X86_STEP_MAX,	RFDS),

-- 
2.34.1



