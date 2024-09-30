Return-Path: <linux-pm+bounces-14945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9170598A7A1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EED1C22F57
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502BA193418;
	Mon, 30 Sep 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cssxK2ZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0A1922E3;
	Mon, 30 Sep 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707661; cv=none; b=Pd8wqZSeEVsGeJk5xz94fBP4mLYIZtOCQXo4k5N0qXR1mLyq7Z3zsSuPJSr1xlO5ApFR+p8MLlmzM82h4RpUmehzJUwzean8iFLgMiewsG0LKhwcKp3NyZxNeedlbWPDLfwCSobzE019iMBNC4iAqy9FPc6yz2M7FbZUr/AVdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707661; c=relaxed/simple;
	bh=3H0Pv2AbKSkzILLHKezcebKGMxIoddDIM8V1OM1U4F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNOAXNlFH06jxLF59cm73mtTIcpHBle8PzIgQdiGkhRJGUPjK1u3sqGJko/jickJFlXIlGBngJJXSfVNClaRlFizQYPCLz8pbaHRpqZsyj5n69hX7llEa/HKJIrf3Q/2VZvAm4gqje6hU/LdkV4XROnZ2ASfdAA1f8CpyqetVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cssxK2ZV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707659; x=1759243659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3H0Pv2AbKSkzILLHKezcebKGMxIoddDIM8V1OM1U4F4=;
  b=cssxK2ZVR2X1bSJ6LCI+1eSU5IdxnUdsR2ojrK+UfXm96O6t3QuC9Jl3
   P0z7l7p/diEl7gDsDmeGgGZliHDqw8Ubju8fgB5otqmweoy05XC0u4Xj9
   351YwVVqUayA8S3g0lZEoaiTx9zPDrhUQ+jBD3PT8oA5UjH93LH0owLfB
   5A77zmdWpBjryGOnggLZhP15cxxSIU6jWid1rPzOa0Et9qzLIOu6xkunO
   rQebdWufbd5nr8nO5W2Xn4J5Z6CpKN6m6kFVwliZMis7q1uNqveBA4xNa
   iRuHVOABEhGGHa60RRtY0n8Iw/eN6MzRs15TdXoV80JEKkesqeWx8gpeV
   A==;
X-CSE-ConnectionGUID: XM1ZMwmvTRufpPiF0OjYUA==
X-CSE-MsgGUID: SDCGXDPsQSebhrcg1Z9V2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="38187341"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="38187341"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:39 -0700
X-CSE-ConnectionGUID: y+ir90N3RSCEp1HS206bSA==
X-CSE-MsgGUID: t3XfTM1JRXO+aoviowi8/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72996083"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:38 -0700
Date: Mon, 30 Sep 2024 07:47:37 -0700
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
Subject: [PATCH v4 04/10] perf/x86/intel: Use topology_hw_cpu_type()
Message-ID: <20240930-add-cpu-type-v4-4-104892b7ab5f@linux.intel.com>
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

get_this_hybrid_cpu_type() misses a case when cpu-type is populated
regardless of X86_FEATURE_HYBRID_CPU. This is particularly true for hybrid
variants that have P or E cores fused off.

Instead use topology_hw_cpu_type() as it does not rely on hybrid feature to
enumerate cpu-type. This can also help avoid the model-specific fixup
get_hybrid_cpu_type().

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d879478db3f5..80a2a307e678 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4906,7 +4906,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
-	u8 cpu_type = get_this_hybrid_cpu_type();
+	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+	u8 cpu_type = topology_hw_cpu_type(c);
 	int i;
 
 	/*

-- 
2.34.1



