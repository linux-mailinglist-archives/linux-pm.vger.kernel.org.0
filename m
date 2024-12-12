Return-Path: <linux-pm+bounces-19095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC459EDFB1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B32168EAD
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B5B205E2E;
	Thu, 12 Dec 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDVB1BTs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E440205E28;
	Thu, 12 Dec 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986680; cv=none; b=lZuS1xQngNhLhKCMyKg0rseu++FcYfaPbejudAiz0H1I800ukgKIXj4/a6Q2BAQQZMspGqJd8Tpp3YXJfr/BPa3vXL6ywKqyhB1jeCY13OX6L8PrguUS4v2zlLOm/xMxW4f6bTa5VRBF/jZjHT40lZkQpD3Q4fzRBefmIOJ4pZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986680; c=relaxed/simple;
	bh=EIZUvKqIFOZlsJjHo1QZ59gk3mq4LRTwoS5V4zFZIWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgMCSN3fx0NZhb6oEKwNgTDWcMGoJGjPkbjj6sqwBgNftf3aXRhw1eT+7HUwaFLZptSLAXbLJjnuIRhYGpI29chDdDJaB7vLNX236/b8XfPOvxO/433uiPLtLu9teWxp2Lsw+k1TFkByhaevAfdDl1eOCGicin4uQaEojicy+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDVB1BTs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986680; x=1765522680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EIZUvKqIFOZlsJjHo1QZ59gk3mq4LRTwoS5V4zFZIWA=;
  b=oDVB1BTsmIZsUBeoGU7L60MVtvvXjYGrbJpC+ftCe51BLgSMdbMc72se
   mSSU1txJeNRM5jdW5k3RsUpE/eihQFXog5ZFFFxs5RjiF3KhaS69lu8ze
   UG/W48JJ+ULmC1XKiLJXZcgt5Gr12VvkGBtEX5TaJJu5qMobUtXoP94bQ
   UHzFHa+nCF8MoyLxvtxdHvOLHbe0o2Q5oCxwI3VPrmWeoy6BHsMqxLVzT
   WirQ1O8cMCJpv9mJg5C28uRFyKn8cbtLdp4I+aWt+JtiCMk84sPudqFdP
   U77IP4s0QfjjUN1cQ+O3+1mSLDMGqVruSct/pdo8ZjXY6BlLIIGVCCodr
   Q==;
X-CSE-ConnectionGUID: LXZ8ztIwSESr9mcMJIjSHA==
X-CSE-MsgGUID: Q4u/G8U5S5WubA9el4lA6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34533475"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34533475"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:59 -0800
X-CSE-ConnectionGUID: mboVaAFcQNKh2pZ0cjpDjA==
X-CSE-MsgGUID: LCChu4EfROu8pcbgRPAkyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96223559"
Received: from unknown (HELO desk) ([10.125.145.3])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:59 -0800
Date: Wed, 11 Dec 2024 22:57:58 -0800
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
Subject: [PATCH v5 7/9] x86/cpu: Update x86_match_cpu() to also use cpu-type
Message-ID: <20241211-add-cpu-type-v5-7-2ae010f50370@linux.intel.com>
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

Non-hybrid CPU variants that share the same Family/Model could be
differentiated by their cpu-type. x86_match_cpu() currently does not use
cpu-type for CPU matching.

Dave Hansen suggested to use below conditions to match CPU-type:

  1. If CPU_TYPE_ANY (the wildcard), then matched
  2. If hybrid, then matched
  3. If !hybrid, look at the boot CPU and compare the cpu-type to determine
     if it is a match.

  This special case for hybrid systems allows more compact vulnerability
  list.  Imagine that "Haswell" CPUs might or might not be hybrid and that
  only Atom cores are vulnerable to Meltdown.  That means there are three
  possibilities:

  	1. P-core only
  	2. Atom only
  	3. Atom + P-core (aka. hybrid)

  One might be tempted to code up the vulnerability list like this:

  	MATCH(     HASWELL, X86_FEATURE_HYBRID, MELTDOWN)
  	MATCH_TYPE(HASWELL, ATOM,               MELTDOWN)

  Logically, this matches #2 and #3. But that's a little silly. You would
  only ask for the "ATOM" match in cases where there *WERE* hybrid cores in
  play. You shouldn't have to _also_ ask for hybrid cores explicitly.

  In short, assume that processors that enumerate Hybrid==1 have a
  vulnerable core type.

Update x86_match_cpu() to also match cpu-type. Also treat hybrid systems as
special, and match them to any cpu-type.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/match.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 8e7de733320a..0c259efff490 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -5,6 +5,34 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 
+/**
+ * x86_match_vendor_cpu_type - helper function to match the hardware defined
+ *                             cpu-type for a single entry in the x86_cpu_id
+ *                             table. Note, this function does not match the
+ *                             generic cpu-types TOPO_CPU_TYPE_EFFICIENCY and
+ *                             TOPO_CPU_TYPE_PERFORMANCE.
+ * @c: Pointer to the cpuinfo_x86 structure of the CPU to match.
+ * @m: Pointer to the x86_cpu_id entry to match against.
+ *
+ * Return: true if the cpu-type matches, false otherwise.
+ */
+static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
+{
+	if (m->cpu_type == X86_CPU_TYPE_ANY)
+		return true;
+
+	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
+	if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
+		return true;
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return m->cpu_type == c->topo.intel_type;
+	if (c->x86_vendor == X86_VENDOR_AMD)
+		return m->cpu_type == c->topo.amd_type;
+
+	return false;
+}
+
 /**
  * x86_match_cpu - match current CPU again an array of x86_cpu_ids
  * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
@@ -50,6 +78,8 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 			continue;
 		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
 			continue;
+		if (!x86_match_vendor_cpu_type(c, m))
+			continue;
 		return m;
 	}
 	return NULL;

-- 
2.34.1



