Return-Path: <linux-pm+bounces-9301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212A90A93F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FF6B2A30B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7BB19412A;
	Mon, 17 Jun 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I36YKfkC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74E194122;
	Mon, 17 Jun 2024 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615500; cv=none; b=lsr3Qw4X75MSn0uVdI8kh7UAX07H+2fTpnR0wEAOi40L1LWNWca/9EbFueg5aifOqz1P+JvOmigbAZeyC0D8CxLartlMhXHHWBxplIFukCxcfNZxkEw0g2Yy1c1IPCmWwuPdSymTyTKNIfReLodfKE29YcJFQ7HPljrgY6IqtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615500; c=relaxed/simple;
	bh=d/jAdioXM51F0WR6fWtrUjnIKIKYP2/LOVSFiVsdcq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgEo2TvOivXZEZTwkSii/ihHZDylmq304usAQR5O1MqRfnkLipCuRn/uHmcnjSvOrpubr/qfyOudY+VqOVcl80a7PyA7xWijGCKV3LB+kVAnpNczuRsISRbfYGATWvIjpdCen+gmXz/lMFaBnapzxY5Jjwhza4aA57uQpiXykL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I36YKfkC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718615499; x=1750151499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/jAdioXM51F0WR6fWtrUjnIKIKYP2/LOVSFiVsdcq8=;
  b=I36YKfkCkICwUqPm4hVvVLFjhZaZ7Rn8XCB2TbM5Mk90EozF9PfGNEEs
   3+FcDjeft9/n6eqGiUzYBExTXnCeaEh/4eOvGF75/nn/M9/+yJ5j2DvWQ
   jWb/mzzep/QL+mQzcSNx9shjs5iG5nr+MWTNdc+th+4kFT5F34IM5smZz
   zbF92H2hLonP65zXhRHg+2jr49vFazrTAfOpFMx/OqxY01CRBgraeSdn8
   v/6K5vTQ26sCDJf4Me275J7tl+mPorwVxsCgicKyycDaIv/OUbU6QyaNE
   4MljijBsovXdUSqgQZKb7kgb+1BGA5kwpMk3MTUkEMIQ4k5+wGJXV3VZx
   w==;
X-CSE-ConnectionGUID: sCTyDIeMSuOIlhlqWITVmg==
X-CSE-MsgGUID: JoXs2L3aQ2+a6Nu9caXmPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19257204"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="19257204"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:39 -0700
X-CSE-ConnectionGUID: kCcfN7uySlKaJx1u/xU9Kw==
X-CSE-MsgGUID: MkDVGiYiSe6JV9+YCb7ZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41260337"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:39 -0700
Date: Mon, 17 Jun 2024 02:11:38 -0700
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
Subject: [PATCH PATCH 3/9] perf/x86/intel: Use topology_cpu_type() to get
 cpu-type
Message-ID: <20240617-add-cpu-type-v1-3-b88998c01e76@linux.intel.com>
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

find_hybrid_pmu_for_cpu() uses get_this_hybrid_cpu_type() to get the CPU
type, but it returns an invalid cpu-type when X86_FEATURE_HYBRID_CPU is not
set. Some hybrid variants do enumerate cpu-type regardless of
X86_FEATURE_HYBRID_CPU.

Replace get_this_hybrid_cpu_type() with topology_cpu_type() to get cpu-type
irrespective of hybrid status. Moreover, get_this_hybrid_cpu_type()
executes the CPUID instruction to get the cpu-type, which is slower than
using the per-cpu value.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f1deaa..8067a735705a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4753,7 +4753,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
-	u8 cpu_type = get_this_hybrid_cpu_type();
+	u8 cpu_type = topology_cpu_type(smp_processor_id());
 	int i;
 
 	/*

-- 
2.34.1



