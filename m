Return-Path: <linux-pm+bounces-23854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88FA5C47E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA31D173B81
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9225EFB3;
	Tue, 11 Mar 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h51z9ruA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284525E833;
	Tue, 11 Mar 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705395; cv=none; b=ccBz6Kn54n81iklLY6djKaM21XydUXJrbNFklyji1QfXQUPaFg1aapjwSK6tNXBLemNA2nMufN/q8MI5mX+XKCztNg90SYCY8OIr0eW/ICsxQKBlQ524TegZgTqs0Jsj7lwHRURhJTHyKO0rrTr5dTHz2hifcDT/ViVU9730PVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705395; c=relaxed/simple;
	bh=BBNjOQP4CmwaTxuMkTvDmx+aoMhLUR9wQq+c3rEV3ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0aueHQOg5mbpgN7NYpBa8PXKy1UJpKBw6ZpP1XQwP32gZm3dm9nM9Wkzx8pK+ud/uLw6OqA/yPKLa9EgxrD+/cgI3B4F8yMrreVoEb/O4g4OzGR1tDZxMb00YIV/GBCgJC6P+vDgJhDxpoDvHnHOmGsseIG0Htfv3YzMobG/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h51z9ruA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741705393; x=1773241393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BBNjOQP4CmwaTxuMkTvDmx+aoMhLUR9wQq+c3rEV3ww=;
  b=h51z9ruAorpoYZYvh5+0GKQ2N6Lkhwp4PtaHJHaSH3u50ZdG/P4d99Yy
   siDEu/kM0c/wJEF/6zXlt2x+dgsEmkYxJoC+QfMYCOeY6SSvutT+hEfBT
   wIYQ2fuOrXcZOkOSek8RckN19w7FRCwzR9pGqiWrm/DEoQXH6iFZC7qJL
   UFaMvjEej0DHMq+L8NnlpimzfXtEm37mBAFDBNb0SIydTeD2JIU6KUw1J
   mEGqP5v8M3VH6WR7SVWXXXTVgpqhfX/YxBF9R1uZD2VOu2gt3fR9ZqJnb
   373jbdoP932YWSMAV1bq/o1JH7Nc22yc1TLfMcUvRgL0LS/QtmlezRQdm
   w==;
X-CSE-ConnectionGUID: R2OZ5TyJQvaF2O8tkWKSJw==
X-CSE-MsgGUID: PAZnEcDvTE6duNpSW3K39A==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42624789"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="42624789"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:03:10 -0700
X-CSE-ConnectionGUID: cJ+j8wTwTbq8zuGjrlxa7A==
X-CSE-MsgGUID: 0imJHXiJRxS95eLQXhg/Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120297721"
Received: from ghakimel-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.184])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:03:09 -0700
Date: Tue, 11 Mar 2025 08:03:08 -0700
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
Subject: [PATCH v8 5/5] x86/rfds: Exclude P-only parts from the RFDS affected
 list
Message-ID: <20250311-add-cpu-type-v8-5-e8514dcaaff2@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20250311-add-cpu-type-v8-0-e8514dcaaff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-add-cpu-type-v8-0-e8514dcaaff2@linux.intel.com>

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



