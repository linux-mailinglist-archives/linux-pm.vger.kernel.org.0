Return-Path: <linux-pm+bounces-23586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB2A55D8B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 03:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901463B47E5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 02:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD57183CA6;
	Fri,  7 Mar 2025 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LY36tASg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45117BB35;
	Fri,  7 Mar 2025 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313919; cv=none; b=sq/Nc1b9431SLyHR4VX4gUwsIEw7lReM+qX//bkg0KvAce3HhoJChyYBwf+2qYHkf0lxn6w3o73XMFJ1jMaFupZvB25yt/DYMwslPf8MRz62n6m7IKhtkqA+DtPGZ3WXiH64VDAJpYOTPEDLlhPlEIvqbzwyid9ErqBh3I85BFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313919; c=relaxed/simple;
	bh=iJvFa/7K5dAtQaIXR9nA65sdMTeAt66cxKMWMtQuwTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3B4SCv2/icWOXnyvUUwpNU59K7sAlL9NiAI02nmjkRQE4nbjp0XhPC+Zgv/LrBYyg2nPXk/94x8Qczgc+zkNGiv2MKWy1m1oiSZ/7SeetKIbodUSX587+CpHfK9punDgwDpt5Ne+Q8f9xZP/l70zsrI/P27coR5TeDzkiPQTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LY36tASg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741313918; x=1772849918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iJvFa/7K5dAtQaIXR9nA65sdMTeAt66cxKMWMtQuwTo=;
  b=LY36tASg5TDeaTXHaOar7JLPaiicwDP1K5GhgJry8SIPLbP3eW3n+WVj
   ntK9tXJ6eXIznE4x01McAvNkqmAI/2+VzzTnaf2f1Vd4IpM/1COGUy9+J
   cww9bp9H9wnnMIR2jrBXlVzp4gqdNDREgRnoIlJrU65CjhA6v/8MqClMp
   CLkvsY9dFIvcr2xy2k0zZF0U9NIDrxFzvL/YOwLR3n7HEDlpnJhpIGWMN
   UAmFjfmOW8GbOda0zCdhYrf2f3/QVXTzWmscGzji887eZh8aMU6TYxgHG
   aQFVxUMmYKKdTveIH4RPLiybt1NzOmu1HVv9+3U3Pnojd09YJiYbCgVUX
   g==;
X-CSE-ConnectionGUID: YOYvzSnvQLCuoZIMVeiYag==
X-CSE-MsgGUID: 20BsXR2tTNOg2nKETd5P0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41524380"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="41524380"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:18:37 -0800
X-CSE-ConnectionGUID: FCymcFLrRHe5XGOv5rNScA==
X-CSE-MsgGUID: AIws8rcqSGe6bMmngT0XLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="119203342"
Received: from ylan1-mobl.amr.corp.intel.com (HELO desk) ([10.125.145.179])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 18:18:36 -0800
Date: Thu, 6 Mar 2025 18:18:36 -0800
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
Subject: [PATCH v7 3/4] x86/cpu: Update x86_match_cpu() to also use cpu-type
Message-ID: <20250306-add-cpu-type-v7-3-f903fb022fd4@linux.intel.com>
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
index 4f3c65429f82..4b052860b774 100644
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



