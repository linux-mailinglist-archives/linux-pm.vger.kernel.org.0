Return-Path: <linux-pm+bounces-14944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE94998A79F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BB2B20B66
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6832192B61;
	Mon, 30 Sep 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7e973h9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632D1922D6;
	Mon, 30 Sep 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707655; cv=none; b=CBw9LkQ0Tlcl09L0tSMKCWKJ+5wvpoCSrJ2rzFzDstxtnANwa4oFuT5YC5NAixhoPNZZh7enZZ5skKo23CtncrNoSMjwkDE50kr+KSCrSNQ9qEFauEhAmCHsaG6dn7LUbDkKAlITT6/ROUPmYHRu6Z+iqoAsXbNXxQ8DMWQocQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707655; c=relaxed/simple;
	bh=XHKlNIXRIq4IdHRu0Q44cu+CjulekUVEmPagZVXkEs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhLtfkcgJs1j71oPF5BcXL/EhWKSH9tYCGluvmze0aDpX8OsRuQ6pgKTZqkYW+D9Mv11Xmbw2frz6gdwEQbfAiIrDpImaOrTt62kBt4i6rXb987OPdz42F+8vlFH7qi0oF+nQh52RBIy72MOp1GPV+mkIq9Oezq/C0Ag78NDqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7e973h9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707654; x=1759243654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XHKlNIXRIq4IdHRu0Q44cu+CjulekUVEmPagZVXkEs8=;
  b=S7e973h98Pwa2iG/q1OG5IS9iC6pS71HSaEt4jD4n5+IwgjBr9L05EoW
   FixCxdyuz0sX+dWRawy5OJXuej9RLCA1sz65hq/yEvyIz2XnCOacJEJNf
   Tjzg+R7OGAkvmEPzcsLfB/MfoVbIJSlvbc/H5WV54fuqOHwY+CSnFChA7
   9FizXHYFmKsyOr5XjnOAfoJKZhOjpegrtNvkr+5niLYoJ7JHDN8Tb9ZQF
   vDmBHBvfPd3BQmCvv6VpvwZ7wiPtEJ1s2aXkDaQb8QG2+CcvPnU4vxgk/
   j6D1TYZIz4PxZR8pjebRDi+X8RFO1s3xusS+UQK3STKBlqU8hB83VVYMo
   w==;
X-CSE-ConnectionGUID: WNpSy3RYRuCgcAyUdAxe2w==
X-CSE-MsgGUID: nLlr3nSRSxmO8yviA7kQzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26752814"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26752814"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:33 -0700
X-CSE-ConnectionGUID: r8iA/HK8Tgy/8ZE/+lpEgw==
X-CSE-MsgGUID: QV8bP4FXR+2zIIPKYJLKaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77867417"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:31 -0700
Date: Mon, 30 Sep 2024 07:47:30 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 03/10] cpufreq: intel_pstate: Use topology_hw_cpu_type()
Message-ID: <20240930-add-cpu-type-v4-3-104892b7ab5f@linux.intel.com>
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

Intel pstate driver relies on SMP calls to get the cpu-type of a given CPU.
Replace the SMP calls with more efficient topology_hw_cpu_type(cpu) that
returns the per-cpu cached value.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index aaea9a39eced..1d37b2a7b3b1 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2193,24 +2193,16 @@ static int knl_get_turbo_pstate(int cpu)
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
+	u8 cpu_type = topology_hw_cpu_type(&cpu_data(cpu));
 
-	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 	/* P-cores have a smaller perf level-to-freqency scaling factor. */
-	if (cpu_type == 0x40)
+	if (cpu_type == TOPO_HW_CPU_TYPE_INTEL_CORE)
 		return hybrid_scaling_factor;
 
 	/* Use default core scaling for E-cores */
-	if (cpu_type == 0x20)
+	if (cpu_type == TOPO_HW_CPU_TYPE_INTEL_ATOM)
 		return core_get_scaling();
 
 	/*

-- 
2.34.1



