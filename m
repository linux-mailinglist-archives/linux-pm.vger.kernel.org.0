Return-Path: <linux-pm+bounces-14949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D098A7B1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69031C2341B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB2198E84;
	Mon, 30 Sep 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nN/f4tuW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210CC19258D;
	Mon, 30 Sep 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707686; cv=none; b=QuXbcD2eqyVCwb+2B3m0qJjhWg7qSnPo6sFVj2KBFygb0twTyhteWzWlnftDAfFkLYLQf5bBWJmDEuB/M7YyjxJrTy2PsKcByTcj5lSM6SWJ9Q5CrpGz9VUzgSYUMfGIZHo6j5Ujz/xdmDhbHhof9RDSVO7SPZvK0mf2fz6OiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707686; c=relaxed/simple;
	bh=xh6tIBAiefMUKKnq7Fug8Rp1DBToya0xZhE5aVNLtIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPqLV7DYzRkDpNMfZcJHUAIf15yBlFGYOkXP/dIWrWWGefn5cQGpjTfU+SOGMDiyms5hASLoNWrYDtLIrHD9wAwPdMZbuAv6yFRV0bs6z2mMiUGS7fR8ko2F61an0EDdHMYx43rvJbMUWC/RRPEmh5cTnhWDRhEhkNPwKuRcu94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nN/f4tuW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707685; x=1759243685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xh6tIBAiefMUKKnq7Fug8Rp1DBToya0xZhE5aVNLtIE=;
  b=nN/f4tuWsnjwqiJdlrqIoWn1NrKECH36oE57nxONNSe19fvb+0/EksmI
   9pdkQOpuoAWXwpfDXNshv1ds+9B0g/+G7EGl9TRAhc5M7D9JaAOU0Um8v
   PqOFNCnBLDwXvOAIVhr4kd+Unrdf7yuRgKUJruEVkK6fzVs7ipJzJtzhY
   XbPjRmuPDmkRql5IBy+v60xd1ucJL8x6v+l3GJKEBzvIjAgIhnKKYrsfv
   wDWVdZ/qnpJb1LoWkbBxszkpC91ZOxN6Ph2y0WP1ZwciRAVkluW2oLxSM
   7VWUgg9WuCTm2rQ53R0kLHaDJu/PcXNtKiwJo/s1y/dVr6L2ZY4DG+1yd
   w==;
X-CSE-ConnectionGUID: mGRGdVB9Tv28lZD8vKuy8w==
X-CSE-MsgGUID: xSY6zQNiS1aZYh4PnNsyHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44262294"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44262294"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:48:04 -0700
X-CSE-ConnectionGUID: qSCly8R3RjqKXRdUFqlC8Q==
X-CSE-MsgGUID: SH6ywn9bR2qHfpQ7KZvKdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="110804511"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:48:05 -0700
Date: Mon, 30 Sep 2024 07:48:04 -0700
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
Subject: [PATCH v4 08/10] x86/cpu: Update x86_match_cpu() to also use cpu-type
Message-ID: <20240930-add-cpu-type-v4-8-104892b7ab5f@linux.intel.com>
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
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/match.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 8e7de733320a..351b583cb9b5 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -5,6 +5,26 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 
+/**
+ * x86_match_hw_cpu_type - helper function to match the hardware defined
+ *                         cpu-type for a single entry in the x86_cpu_id table.
+ * @c: Pointer to the cpuinfo_x86 structure of the CPU to match.
+ * @m: Pointer to the x86_cpu_id entry to match against.
+ *
+ * Return: true if the cpu-type matches, false otherwise.
+ */
+static bool x86_match_hw_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
+{
+	if (m->cpu_type == X86_CPU_TYPE_ANY)
+		return true;
+
+	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
+	if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
+		return true;
+
+	return m->cpu_type == topology_hw_cpu_type(c);
+}
+
 /**
  * x86_match_cpu - match current CPU again an array of x86_cpu_ids
  * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
@@ -50,6 +70,8 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 			continue;
 		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
 			continue;
+		if (!x86_match_hw_cpu_type(c, m))
+			continue;
 		return m;
 	}
 	return NULL;

-- 
2.34.1



