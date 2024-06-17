Return-Path: <linux-pm+bounces-9300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA190A935
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A06F287FC9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A200719308B;
	Mon, 17 Jun 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TT1W0lpv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0A19148B;
	Mon, 17 Jun 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615495; cv=none; b=rdZ9pT3MeuG1CdqzezCWzVHhF/p1PU3QXKz1xV5g3uYRxnVSdnzuHVXXsN3yt/7I6q/3Y++3FcbSWIJ9E00C5OwwLF25UhFlHHU5a4abt6apW8UXgqTfFQfUHpXlsDsrbjqpfssdB4DVYXkqnG4wCVnlvjAs/0aUCQlE6YJbLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615495; c=relaxed/simple;
	bh=GKC80AskjgIH1oTAvyBvjh1n9L5xZNA5S+uO3/gNb5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGpWILszo/KoifxL/3ZgWybtzHTqoD75lYAAIcyGfvkSJWHR86B+W+hir0p4lJhDAk8nnKUHigvgk37v+bFrU2PSuUbGIm25Mt+VzbRcGmDZLOWZINYwXu4GeTr3MN7NNF5hb9ww8pKV/LRzU37uS+C2WnHPgEXt2h7QvFViJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TT1W0lpv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718615494; x=1750151494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKC80AskjgIH1oTAvyBvjh1n9L5xZNA5S+uO3/gNb5Y=;
  b=TT1W0lpvY5XLSCskHJIY/wMXGRy0rfmaFidx4hexqpVKU3W9cP7THrI9
   ZS9aXO+SubdTs/VLbUeBzelqEPfE9Awdp3ipFEEv4uBCjuomD+nk8j96P
   +UGbUhv0pMJUPXroYNjGAyvB74IXofrT5pXKc8AOW/Q3wviaHH9sl3SBy
   34nir+IzJHhT3xOO7y++eE4IY+jAtW9f+qQI5maleRTXcBXGhcHvzssss
   87ZW4AiSpcmq16RAC9m3KSVQsDwcQI24ICrygH33EfRnRZWYYzTV4YVAX
   ZkOvD2ZLnbYkr7JhKKXYWVeao+GbuT9aT4nNKk4l4IWqYSU4M/j9lhvYs
   w==;
X-CSE-ConnectionGUID: JavX3WjORAqw9z32VMc7kg==
X-CSE-MsgGUID: vt7+SXh5Se20nFykyofURg==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19257195"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="19257195"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:33 -0700
X-CSE-ConnectionGUID: YI5I6kmtS7iaFryFOelWYA==
X-CSE-MsgGUID: mHxU0YLlS7mxpiTz5kcGdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41260324"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:33 -0700
Date: Mon, 17 Jun 2024 02:11:32 -0700
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
Subject: [PATCH PATCH 2/9] cpufreq: intel_pstate: Use topology_cpu_type() to
 get cpu-type
Message-ID: <20240617-add-cpu-type-v1-2-b88998c01e76@linux.intel.com>
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

Intel pstate driver uses hybrid_get_type() to get the cpu-type of a given
CPU. It uses smp_call_function_single() which is sub-optimal and can be
avoided as cpu-type is also available in the per-cpu topology structure.

Use topology_cpu_type() to get the cpu-type.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 65d3f79104bd..40f5e5b0b45e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1951,24 +1951,16 @@ static int knl_get_turbo_pstate(int cpu)
 	return ret;
 }
 
-static void hybrid_get_type(void *data)
-{
-	u8 *cpu_type = data;
-
-	*cpu_type = get_this_hybrid_cpu_type();
-}
-
 static int hwp_get_cpu_scaling(int cpu)
 {
-	u8 cpu_type = 0;
+	u8 cpu_type = topology_cpu_type(cpu);
 
-	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 	/* P-cores have a smaller perf level-to-freqency scaling factor. */
-	if (cpu_type == 0x40)
+	if (cpu_type == X86_CPU_TYPE_INTEL_CORE)
 		return hybrid_scaling_factor;
 
 	/* Use default core scaling for E-cores */
-	if (cpu_type == 0x20)
+	if (cpu_type == X86_CPU_TYPE_INTEL_ATOM)
 		return core_get_scaling();
 
 	/*

-- 
2.34.1



