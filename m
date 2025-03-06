Return-Path: <linux-pm+bounces-23541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55402A5436E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 08:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3450F7A9331
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28E1DDA00;
	Thu,  6 Mar 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cH7I1Xat"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB231A9B46;
	Thu,  6 Mar 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245243; cv=none; b=lRQdtmjtj4BNaogo8i50CZnzKIwBKDNg4SWkMuVwEl6zXDrkjv7B3vRwsw0lZNsXsK4uW3foB262XqKM5oX7SgMjWULWKTIQserXrnsUYdTHD+bX7yBqzZNe/3iPE/VISDFhztMlkm8ZHZUwvb7wmn+l0hK6AqrVq1+dm6Yye8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245243; c=relaxed/simple;
	bh=VWUjTJ6hjiWw/OpiSUY4KWfPPO29+RWYDQ4QHkKKBhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSlr25dLN9M85tHiwVI1dIGfSU+XbqX/8KCHjamZMQuLJx7d5FdmLHH5nvm5hFJwBXOpW8hgntmhj4MqEvcDlf+JzPPMesk4qvvKX3nhje8ETv1nEJ+OQsTo54c+oy6BcmeqWsOh9Yil7h8W445U3K9Ago/yluoXnI821PQ7nOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cH7I1Xat; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741245242; x=1772781242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VWUjTJ6hjiWw/OpiSUY4KWfPPO29+RWYDQ4QHkKKBhk=;
  b=cH7I1XatG7brTxptc5Fw1tonoKH/XEWHykSozmZrRHAizovnHWNCmwlg
   kD1SzzxPFTiDXHLbb1U5VJExqzV8PbfiIxJ8IXwmgwkB0YnYj/ftbyrcF
   rILO2/tly9pDRuUiVmctgqY1zx5lbqzHd4EscSmVUYXFfWS0iuxclTaZP
   rgeYFAwOP2Z8lF4+iOjR6Bd20GECm+8jx87CAEJ/Ccr0naHQP55onaO77
   KdLNbNwfCFkRDZlHKGw4EtHVdeO7S0YBR60HDrwuxiLw3fYuv7DJ1Y7nJ
   wnwlZ2e3WZYndyrsBqe8HYJWbkZtF+QxnMf6lzWOLIXYCY+6LDAgam9j/
   A==;
X-CSE-ConnectionGUID: QWabgWrsTuOttOiE3jDhGw==
X-CSE-MsgGUID: fJJ9++QARvuztWgLR6JNaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53225504"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="53225504"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:13:55 -0800
X-CSE-ConnectionGUID: a4bHtl76Sr+sDrcuO7l2UA==
X-CSE-MsgGUID: 3EgSTkWsTa+LxLjhUh4rJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149869248"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:13:53 -0800
Date: Wed, 5 Mar 2025 23:13:52 -0800
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
Subject: [PATCH v6 5/5] x86/rfds: Exclude P-only parts from the RFDS affected
 list
Message-ID: <20250305-add-cpu-type-v6-5-4741735bcd75@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20250305-add-cpu-type-v6-0-4741735bcd75@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-add-cpu-type-v6-0-4741735bcd75@linux.intel.com>

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
index 9d41f8f7267a..fa9773207175 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1206,6 +1206,11 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL_INTEL_STEPS(vfm, max_stepping, issues)		   \
 	X86_MATCH_VFM_STEPS(INTEL_##vfm, X86_STEP_MIN, max_stepping, issues)
 
+#define VULNBL_INTEL_TYPE(vfm, cpu_type, issues)			\
+	X86_MATCH_VFM_CPU_TYPE(INTEL_##vfm,				\
+			       INTEL_CPU_TYPE_##cpu_type,	\
+			       issues)
+
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
 
@@ -1254,9 +1259,9 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL(		TIGERLAKE,		GDS),
 	VULNBL_INTEL(		LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL(		ROCKETLAKE,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL(		ALDERLAKE,		RFDS),
+	VULNBL_INTEL_TYPE(	ALDERLAKE,	ATOM,	RFDS),
 	VULNBL_INTEL(		ALDERLAKE_L,		RFDS),
-	VULNBL_INTEL(		RAPTORLAKE,		RFDS),
+	VULNBL_INTEL_TYPE(	RAPTORLAKE,	ATOM,	RFDS),
 	VULNBL_INTEL(		RAPTORLAKE_P,		RFDS),
 	VULNBL_INTEL(		RAPTORLAKE_S,		RFDS),
 	VULNBL_INTEL(		ATOM_GRACEMONT,		RFDS),

-- 
2.34.1



