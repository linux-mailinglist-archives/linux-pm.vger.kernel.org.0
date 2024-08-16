Return-Path: <linux-pm+bounces-12291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2295405C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32691F24FBD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C13770E1;
	Fri, 16 Aug 2024 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zids3swb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9C13CFA5;
	Fri, 16 Aug 2024 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781194; cv=none; b=ew5PaEonDFLz2Qkst1/BqQ+5NV8G6W8JLhs7LtJue9CPuRR86IKgHMNcan66WKPWru0GwwXWCNMRZUUQ0V5UnpmYbJVJk54AetnfBsdAnjRr+zdedqsZggBhU30u/s3Rk8JILvKgTu92To5CX3wt4MYk2Cm+5qM5sEOgtkKOMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781194; c=relaxed/simple;
	bh=Exn6IbYfVXDxGcqCe/b6TH8T+b6+3Z9dfEuR7SuZcsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkoxdykL+qU09CsIPkt6bdNH2pfjOMLhb64zv4rGzHO02UNp9vYNcMT/Zg1lccfoKJ6u34WeELvbNjzT+LiV3xNkJLk2RW/P8C1RH6O7NssUZUxxLGouvJx3Z+dHzXWXQbzvq0xE/RRdMgZ2TTggK9X7jInNFbg3TlK7ogEMr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zids3swb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781193; x=1755317193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Exn6IbYfVXDxGcqCe/b6TH8T+b6+3Z9dfEuR7SuZcsk=;
  b=Zids3swbhAjMT6ovUk22KLlNbN/vMv5p0bXPZpl9U0vFa/Q9iZICF+M+
   HVdJMrHzbHsH0ImVWDz/BfJ07U7sle/79nFoo2EpQVHCZyZ5RtpDAu3mO
   KuVINGtE6z1A+KPLEGayYjQEcpzAP9/bgSBiaGULF9QoPS9r4XKorUenb
   iD0bnApfo68J+GF5+HiPZ4w6IjtAczuB3TPA2v0XLgkBg+QwyT18cgtUl
   CjM5bqImorxNUehYeRYyEyfyC8fCRHoHB6QJ1Spo4nforqBAHdniSZuOQ
   qJUu55IxLLIYa+RVzU/LsKw7YvauVFVIiVPUNe7bKHeiYR62+Gd8BUDi6
   A==;
X-CSE-ConnectionGUID: 3dbHhVOiTuWncs8jA/vmGw==
X-CSE-MsgGUID: bAcOyMFoTEmHE/Mbiwx+Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39521760"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39521760"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:31 -0700
X-CSE-ConnectionGUID: 6P8t+7/aSL6pUYpCsJduSw==
X-CSE-MsgGUID: bEMLXJYgQBuCcQrGIVajrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="97070329"
Received: from kerandaa-mobl.amr.corp.intel.com (HELO desk) ([10.125.112.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:26 -0700
Date: Thu, 15 Aug 2024 21:06:25 -0700
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
Subject: [PATCH v3 03/10] cpufreq: intel_pstate: Use topology_hw_cpu_type()
Message-ID: <20240815-add-cpu-type-v3-3-234162352057@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>

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
index c0278d023cfc..b3df766ef029 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1971,24 +1971,16 @@ static int knl_get_turbo_pstate(int cpu)
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



