Return-Path: <linux-pm+bounces-12292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3195405E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D88D1C22A06
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B343413D297;
	Fri, 16 Aug 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9rfoDj4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F45513B587;
	Fri, 16 Aug 2024 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781196; cv=none; b=EHXE+FRyEIJEV5GnwK9QmWBPrR0ZCuiU5y+TE4f5MZ4dHZOWZIyBUxASEo/x2mQG2APPZz53ZPTX+oJWcSGSsecGCJEEKDMnPA7EenzsT1kTx4+k7bYZZ8EHd8ZGVi2l2anz6XRmjH7adsMHUjtOa6Q2QdHBAAyecNJLEHg2Gls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781196; c=relaxed/simple;
	bh=rlcnU7I+cacGWnA4n/kNXeF29EoXwvR1r/qmm+tFn3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okWOJ34iRI5x3rvV5R1OWciwXYlpbSh4P5IU3vh4qNt7hoRK90g5bQhWbhPPnAPI98vc2qYF3Yi8BPVLK7XRXjkHRvl+Lwek/mW/U7yVhvoDpVhS1nL/WJbSZxnTvaHkb4zeff/1zCpfhDtzG8PnpJtYaf5p6uNB+bOwcz5Yw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9rfoDj4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781195; x=1755317195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rlcnU7I+cacGWnA4n/kNXeF29EoXwvR1r/qmm+tFn3k=;
  b=M9rfoDj462wsz2inZHdmc1t9tzU2TnffEIaJ7JOd0kYKntP0tShQv+YW
   ySliYispNRHv29sucNVCftdeHG0NbJdWs1SyzRnt9VTqHYhi21hlCxiry
   T9upJcFQTM21MiRxwtsIjjZhG2epovURiS9iWczPyD/p/nwx4337EXwqi
   8Lh8fGwHkWGEqTB0b91Id0qy/739j1NrPYKZQjNYuNIerrcgW5piHBbIM
   cR95ClP7fYzAQ1eweimkhd9VU2YYjd++yExeBuTgsOLT667m6cATKeALW
   53p3++xqKojeeyXk9n5YeaGHtEzGrR6SG7yGD5j9BhvX5Q7eBCV39evOT
   A==;
X-CSE-ConnectionGUID: POHv7dXSSYeqpucuoP6x/w==
X-CSE-MsgGUID: wUEowLNOSymlucdYndd9vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="25826210"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="25826210"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:34 -0700
X-CSE-ConnectionGUID: a+WU7GzRRIG4lbsehIkADA==
X-CSE-MsgGUID: R6Nfotm0ScyuZb08+M79sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59571757"
Received: from kerandaa-mobl.amr.corp.intel.com (HELO desk) ([10.125.112.221])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:34 -0700
Date: Thu, 15 Aug 2024 21:06:32 -0700
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
Subject: [PATCH v3 04/10] perf/x86/intel: Use topology_hw_cpu_type()
Message-ID: <20240815-add-cpu-type-v3-4-234162352057@linux.intel.com>
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
index 0c9c2706d4ec..26906e50a06f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4884,7 +4884,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
-	u8 cpu_type = get_this_hybrid_cpu_type();
+	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+	u8 cpu_type = topology_hw_cpu_type(c);
 	int i;
 
 	/*

-- 
2.34.1



