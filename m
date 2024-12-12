Return-Path: <linux-pm+bounces-19090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED449EDFA4
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8354A168C3B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AD204C36;
	Thu, 12 Dec 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7AbxUcc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6311F37C5;
	Thu, 12 Dec 2024 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986653; cv=none; b=qde2L0+fqpeV2v7PSYHFK6e/6A4U2lw3BdH0Ke3c/SWEh1vtZ3LT3gjxIVErzY2C0dp4a4qW1aPrwYEBqo0bU37jJrk+Yu/n0x5mCeQwPc2VHDFK49NM0yPgsFsDXHRqqeEbEbcxhOqugfNr5TPja66LaD9Rv9qkO/x7K2zf9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986653; c=relaxed/simple;
	bh=Lo7FysfxpdbAhJ5Br5uh/0z/2AfqddNm+WK8FwzxFkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4nHKnoSyc8fEUr2/F4HbCgE6Qc9sXeyVl7hSPr+TMEDDZpp11D6drjvZmnJeBF9oZpjQaJodK232zstgTSt9naf6adtcJIjLDzbhiDJK7Bi19zT1M0iiPatuKi6NrW6hx3qzobSIycu2aQdARf6kPRWC2/49dxBvuL1uIAZhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7AbxUcc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986652; x=1765522652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lo7FysfxpdbAhJ5Br5uh/0z/2AfqddNm+WK8FwzxFkg=;
  b=C7AbxUccXAXPLXNECuiGHV4XVa0zpxKt3yjS2mq9D9i/Q9bgi80KuvWz
   B+KSGOBTxLNQlQ5zCawWIWSvy+YYDwbwaTm1WXdymDjtz1DGq1aFtF6b6
   Y5A2x5vF1Sc91tbeNW25m/Ilac8shLcEv9QWkSEo/3wYA00ZqIQK7aLS4
   EghcTZJlJWCrq+AF1POx5tFp6j1dGcCbFa1nlJp8IheC111JTpgtIvvYS
   gKbPxaVx9ee1m9W7yNqQyZGK4cHE2YC8F3SAf3iAfGFYJFBlA7v7PqdUT
   HmIigxYS3slB1ABSd1WoY2L001atll2okPOlr22A7YstEk6sX1YbnGwiF
   Q==;
X-CSE-ConnectionGUID: dy7Stwg2Si2Yefk188Kqow==
X-CSE-MsgGUID: 3C2ePYppRFKZichQ7yOm7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="59786328"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="59786328"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:32 -0800
X-CSE-ConnectionGUID: 19zjN0qVRpujMghuBWxiAw==
X-CSE-MsgGUID: ty9UeVlPQmalsexxyNZcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96372377"
Received: from unknown (HELO desk) ([10.125.145.3])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:31 -0800
Date: Wed, 11 Dec 2024 22:57:30 -0800
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
Subject: [PATCH v5 2/9] cpufreq: intel_pstate: Avoid SMP calls to get cpu-type
Message-ID: <20241211-add-cpu-type-v5-2-2ae010f50370@linux.intel.com>
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

Intel pstate driver relies on SMP calls to get the cpu-type of a given CPU.
Remove the SMP calls and instead use the cached value of cpu-type which is
more efficient.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b8e2396a708a..c767680daa03 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2202,24 +2202,17 @@ static int knl_get_turbo_pstate(int cpu)
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
+	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+	u8 cpu_type = c->topo.intel_type;
 
-	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 	/* P-cores have a smaller perf level-to-freqency scaling factor. */
-	if (cpu_type == 0x40)
+	if (cpu_type == INTEL_CPU_TYPE_CORE)
 		return hybrid_scaling_factor;
 
 	/* Use default core scaling for E-cores */
-	if (cpu_type == 0x20)
+	if (cpu_type == INTEL_CPU_TYPE_ATOM)
 		return core_get_scaling();
 
 	/*

-- 
2.34.1



