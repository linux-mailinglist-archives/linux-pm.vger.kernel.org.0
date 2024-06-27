Return-Path: <linux-pm+bounces-10146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1431E91B0BA
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 22:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F1E285C53
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9CE1A2562;
	Thu, 27 Jun 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dnhd4s0+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1419F46D;
	Thu, 27 Jun 2024 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521055; cv=none; b=ZxNqvcIgtnNOgOYdklSbez67SgR02+ZQOla1XMEwA8AQ+Fqo3WPA904NG592wsiQ74JyqWBeQKIKdbEfRG8fo8W5yM6t8NOQ5QVlYv6R+rYPj2u4gp9cpL0TI124eLt+ipIN9OvifRucLFc2kocErOnEasPmuNVAyNUZf+HlXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521055; c=relaxed/simple;
	bh=WWEGL8llrzPO9U6cEMHLUdGN09d4ZNQFv7tRiYccFcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRo6Xlv1uj/JpGC+diilZ4dGAl1pJOmEpyLbPzdHRf9XcM2bcq79TJ7ynhjB4ksFlxpgstFfhBPJoUgbsjpv1WvDCl0dQZbt/E2qW6ZL4KpW/Nlxyu4G/CgVnvBVUUl5VYq8eOBFtGf4UpNzgYjoQhCRaGphnsj8zfwF89BORSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dnhd4s0+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719521054; x=1751057054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WWEGL8llrzPO9U6cEMHLUdGN09d4ZNQFv7tRiYccFcY=;
  b=Dnhd4s0+TtI9QnbdzgfxE/q06E9NRryTSDTY7KG6NJSHN+S+KZ8r+VE0
   mNTuFwmNUdFcDLAqnHxFXq7+P77kEoP31atZnATKiulZr44AUK6ob0xad
   BLaVhzrtlY9NSUiOyde6HnkOFuOPaaNw6H6neuoFJCrmwNd55MuBqxJbN
   0cw2N1KH0ke6C+xMyKT0gdJVb5st3ZIYbTKx/ACIZWjN/tPWqBgsPii/8
   jlxiiTEi3pb/gQmVaVKIE+oIU3W5fhsBdIjR7Gf4fRW8tTrKx2Eba4CUY
   nRh9LH5Ek5QfS/PW2WILjBEEWycJFZoYYyiiQ8UObqZUq0RA5bO0Bnr0e
   Q==;
X-CSE-ConnectionGUID: ECmBtKa3S2KnbH9TO4WUlw==
X-CSE-MsgGUID: QjyGIfCrSvC0tzgezuSKpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="34132505"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="34132505"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:13 -0700
X-CSE-ConnectionGUID: Mg/mQqb7ScmVeA4Bu0gsBQ==
X-CSE-MsgGUID: zgddO2GCQyS+WVb1tTFg1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="75708598"
Received: from gbpfeiff-mobl.amr.corp.intel.com (HELO desk) ([10.255.229.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:13 -0700
Date: Thu, 27 Jun 2024 13:44:12 -0700
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
Subject: [PATCH PATCH v2 2/9] cpufreq: intel_pstate: Use topology_cpu_type()
Message-ID: <20240627-add-cpu-type-v2-2-f927bde83ad0@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>

Intel pstate driver uses hybrid_get_type() to get the cpu-type of a given
CPU. It uses smp_call_function_single() which is sub-optimal. Avoid it by
using topology_hw_cpu_type(cpu) that returns the cached cpu-type.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 15de5e3d96fd..0a1e832c7536 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1956,24 +1956,16 @@ static int knl_get_turbo_pstate(int cpu)
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
+	u8 cpu_type = topology_hw_cpu_type(cpu);
 
-	smp_call_function_single(cpu, hybrid_get_type, &cpu_type, 1);
 	/* P-cores have a smaller perf level-to-freqency scaling factor. */
-	if (cpu_type == 0x40)
+	if (cpu_type == X86_HW_CPU_TYPE_INTEL_CORE)
 		return hybrid_scaling_factor;
 
 	/* Use default core scaling for E-cores */
-	if (cpu_type == 0x20)
+	if (cpu_type == X86_HW_CPU_TYPE_INTEL_ATOM)
 		return core_get_scaling();
 
 	/*

-- 
2.34.1



