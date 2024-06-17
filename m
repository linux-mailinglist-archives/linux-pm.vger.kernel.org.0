Return-Path: <linux-pm+bounces-9307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD290A967
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67774B2B6DF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF54194AEB;
	Mon, 17 Jun 2024 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOkF5Alu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76098194AF2;
	Mon, 17 Jun 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615537; cv=none; b=Ori/1gMtx5paxjX7qfQmW1KZfKi/3vCg+bnUv5Pk06wa9hpRvyLZBdns45RJ/x0+rdAWvkdXqwOdpW6hr4S7Qo0eDzKs0TQ4FmdvK4STAzxUVz27nwCnNWL1Rn1hPrq6TRRAjy152sxIFOJyEnKVo2GbF0RWu+AexkFHc1nOxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615537; c=relaxed/simple;
	bh=os5ebhwol7XkQChRWi2jxxkCPHPBHfQ9E9+GSsyzYjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/netxLngg0p7CSaMctfWoCZjFxO4RM3KUZLSoDlJxxMImPZb140a5vKDZuQ3ybjRPxDdtWVVQpTiPRODqVKXxXwIKqFbLqVPW5eZCtNVUhYZjmDUFCEKynApZM3VbKYV1RJRxPMLT73aHwO9fmQ4oItZTzntJ7wQuDJYYbFTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOkF5Alu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718615537; x=1750151537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=os5ebhwol7XkQChRWi2jxxkCPHPBHfQ9E9+GSsyzYjY=;
  b=QOkF5AluCywVhWKtzRTUfgiI7N3dhycUjwtoLrY6/7CBjwKJ2GbC1jBX
   17cZNmJGQNpfKsAYnjU5RsL5dxu0+tUyEUrmQzgGDOUrb84OGH15dDAO+
   QIuoakUOIP6Uev7NnnWiWPY5fIJV/JjbrqEeqn/EW4cLcH88XHJJyg2sC
   Y145ClpL4ab9VmY0PI7oU6PWXvSlBGDN/wCtpyvGd3mgKdn1Q6/qewKXh
   tdhqQNWZtEEHtHOGOFYY6Dq3X2t41wdJW3xLzzIY+wzPZkwJL0DQGt75q
   pc3h8i1deZyWeIJ8zyyEGg0fZTBsr3fEdSrpoVMLxcKAhwGYonepWzCen
   g==;
X-CSE-ConnectionGUID: flpYCcYMR2SrwlsjdRG8yQ==
X-CSE-MsgGUID: qUQ69PZjQ6WDRkyjZUnRBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="32902618"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="32902618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:12:16 -0700
X-CSE-ConnectionGUID: recinEz5RX2yfoeqD3qSuw==
X-CSE-MsgGUID: dtVnO4EtRe+etUL+7QEflg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72339686"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:12:15 -0700
Date: Mon, 17 Jun 2024 02:12:14 -0700
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
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH PATCH 9/9] x86/rfds: Exclude P-only parts from the RFDS
 affected list
Message-ID: <20240617-add-cpu-type-v1-9-b88998c01e76@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>

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
index 7e3b09b0f82c..73ec66321758 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1209,6 +1209,9 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)	\
 	X86_MATCH_VFM_STEPPINGS(INTEL_##vfm, steppings, issues)
 
+#define VULNBL_INTEL_CPU_TYPE(vfm, cpu_type, issues)	\
+	X86_MATCH_VFM_CPU_TYPE(INTEL_##vfm, cpu_type, issues)
+
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
 
@@ -1255,9 +1258,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL(TIGERLAKE,		GDS),
 	VULNBL_INTEL(LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL(ROCKETLAKE,	MMIO | RETBLEED | GDS),
-	VULNBL_INTEL(ALDERLAKE,		RFDS),
 	VULNBL_INTEL(ALDERLAKE_L,	RFDS),
-	VULNBL_INTEL(RAPTORLAKE,	RFDS),
 	VULNBL_INTEL(RAPTORLAKE_P,	RFDS),
 	VULNBL_INTEL(RAPTORLAKE_S,	RFDS),
 	VULNBL_INTEL(ATOM_GRACEMONT,	RFDS),
@@ -1271,6 +1272,8 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	/* Match more than Vendor/Family/Model */
 	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
 	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_CPU_TYPE (RAPTORLAKE,	X86_CPU_TYPE_INTEL_ATOM,	RFDS),
+	VULNBL_INTEL_CPU_TYPE (ALDERLAKE,	X86_CPU_TYPE_INTEL_ATOM,	RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),

-- 
2.34.1



