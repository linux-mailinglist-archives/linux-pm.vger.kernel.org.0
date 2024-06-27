Return-Path: <linux-pm+bounces-10147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43491B0BC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 22:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D91C232E3
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9019F49D;
	Thu, 27 Jun 2024 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHVIyyVa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E319F46C;
	Thu, 27 Jun 2024 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521061; cv=none; b=RdiMC0A38cMYcFiXW6i+I5BuMsyrUdgCvGpuAR/5SyMzf7zalj2CkYqSJZHtRT6mMYuFcqiUPzPH2rSE3lEIzRTxE/d6jLa4ndQQy3l1JlWxoU6Uuw9G/ChgLko0rwx7OtiH0l/CmovVdWtA5DNI8umFrJLcH7Vmt6WW2uy0UUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521061; c=relaxed/simple;
	bh=DVzDv4uACxxSDrFRLriFQUI7g0cXPdhDN1i3ovSARok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtLEq2sZVAznvAvF73sPSMA86xsc7k2pVZ6+q5xldLy7dDn9QZbjmoe0cP2+gzAxLQe+EmNZiuavRj/Zz12TClM+fsPVR2BfvSW0Fcpf6kg7zsiZtGR9XWQ8vWoWno2Df5E8SLXJN8KqrPYfsQdIaFiLVxhdiaGq0vUzuBsIFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHVIyyVa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719521060; x=1751057060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DVzDv4uACxxSDrFRLriFQUI7g0cXPdhDN1i3ovSARok=;
  b=CHVIyyVagqPt5zVoPOeT9a09XMjryzsSinXSSB/a0wngZH9/BVPn8gK4
   RrtJokgFzKG3+re6gh2V/Bvm5XWwcKJPqJIXeKTE4/PJkF+kSCyozkSdi
   jiXkWHuGhSo7c5YzshKIw9Id0kp6T04YDPVMDwS8fnqk4oZzec1xqELaa
   w3rrjZOr/RaVMxJWnyZ24uiRrPz0kThTzQReCgvKBkZ2l3bPINsYtQL1f
   dUvULImX8zjqJpaNdOIuP8jxv/WsfIozBY9Pj9Fp6Dvymui2N8p9b/Em6
   uJkz3dqN66E/Faxqxna10Os2f+T3zCa+qCzegkwjpPDFEKJqIJOF1B2b9
   A==;
X-CSE-ConnectionGUID: FBo8+E47RDW/Y3F6IooyFQ==
X-CSE-MsgGUID: oQBx7lM/T1SrPnakPv0Jgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="34132520"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="34132520"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:20 -0700
X-CSE-ConnectionGUID: w5mtiqysTy2FweArSpdLMg==
X-CSE-MsgGUID: tg+JUzvBTnOX6U1LGBxvSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="75708643"
Received: from gbpfeiff-mobl.amr.corp.intel.com (HELO desk) ([10.255.229.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:19 -0700
Date: Thu, 27 Jun 2024 13:44:18 -0700
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
Subject: [PATCH PATCH v2 3/9] perf/x86/intel: Use topology_hw_cpu_type()
Message-ID: <20240627-add-cpu-type-v2-3-f927bde83ad0@linux.intel.com>
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

get_this_hybrid_cpu_type() misses a case when cpu-type is populated
regardless of X86_FEATURE_HYBRID_CPU. This is particularly true for hybrid
variants that have P or E cores fused off.

Instead use topology_hw_cpu_type() as it does not rely on hybrid feature to
enumerate cpu-type. This can also help avoid the model-specific fixup
get_hybrid_cpu_type().

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f1deaa..0da1fd14b0ea 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4753,7 +4753,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
-	u8 cpu_type = get_this_hybrid_cpu_type();
+	u8 cpu_type = topology_hw_cpu_type(smp_processor_id());
 	int i;
 
 	/*

-- 
2.34.1



