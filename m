Return-Path: <linux-pm+bounces-23853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B62FA5C470
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5419B7A3694
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E68625E81A;
	Tue, 11 Mar 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bu84eCFy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335025D8E8;
	Tue, 11 Mar 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705376; cv=none; b=mezcAvm3WiiE0TZtYw1UBCzZyAyzz5XzWr/kjOFvBBZBDpjra7NVkFZ1/TXnv9ObBxjeVA+30Wox7aw/+O+mRJLDDPfFsR6A69ss9empeIPP87w9q3AzmuPz2cf2T1aZ0qdaDqJ7v0ZYK5N1i1FPSrxoFvVHytJ5KteA+rtlgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705376; c=relaxed/simple;
	bh=mxJf1kp4ViaD2arBJYw/68nBhcshUVhAMv/hUp21Mqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad1ZzPHKSgGNxcDXhIsXSOOULUqACbnGzoWR5MvG0LRBBYebeHDrLyl0RT2ehEWAFpnHUP5ASMWtDBPPF7qN9bgfweBtMIbQA0483hYxeuH9qB5yhslQCezxppyLTfwHLuQ5iSgrdZJG5c/LYdaykmX/DNDKIBFJL3/0NEXGLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bu84eCFy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741705374; x=1773241374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mxJf1kp4ViaD2arBJYw/68nBhcshUVhAMv/hUp21Mqs=;
  b=bu84eCFy8CriduFmAbFVV4eiJ/y92fD4t1ayAbaSTHwYcNZfoJEmRKWM
   38MTiGhKkGwiz4j96UAC6YwBknK+pqcylnK5XJsBEzTy5/miUhSN/wprG
   EvPxUBIekxSChPQ2lbGc5Po2badMmJdw5l+67KGmZUpkX0CrOCSgFgpC1
   BHPa4nTN98G2qmRmuFi+Oe7FWWKbPW6GrcdLB+TTfbr8nZYENxyZOZBCC
   TcmUAGbb/Axz0ag4BGEt4yZSKxzfR2wqb63NMe5gRbzEFPG7kbNB8pGD+
   gz66y9+zzQr1tmI5t1LpTSq/uOdmwJNVNXX+SL4wnDYpuKjaQI7oruTDl
   Q==;
X-CSE-ConnectionGUID: x288dQ2kSPaqukeWNAKRlA==
X-CSE-MsgGUID: EFimYKbiTQybL+9wneW8DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42624665"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="42624665"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:53 -0700
X-CSE-ConnectionGUID: apCygz93SiKCyso39/YEJA==
X-CSE-MsgGUID: n1Go5hoNRheB+/2GCOHbxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120297618"
Received: from ghakimel-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.184])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:02:54 -0700
Date: Tue, 11 Mar 2025 08:02:52 -0700
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
Subject: [PATCH v8 4/5] x86/cpu: Update x86_match_cpu() to also use cpu-type
Message-ID: <20250311-add-cpu-type-v8-4-e8514dcaaff2@linux.intel.com>
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
index 4f3c65429f82..6af1e8baeb0f 100644
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
+	if (m->type == X86_CPU_TYPE_ANY)
+		return true;
+
+	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return true;
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return m->type == c->topo.intel_type;
+	if (c->x86_vendor == X86_VENDOR_AMD)
+		return m->type == c->topo.amd_type;
+
+	return false;
+}
+
 /**
  * x86_match_cpu - match current CPU against an array of x86_cpu_ids
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



