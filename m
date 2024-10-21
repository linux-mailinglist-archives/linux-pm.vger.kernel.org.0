Return-Path: <linux-pm+bounces-16106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBEE9A6B42
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195A3B28CC4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D21F707F;
	Mon, 21 Oct 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRFMDFiD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B801D4336;
	Mon, 21 Oct 2024 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518904; cv=none; b=kxCnWgyd8efvBhl49urEsmKa5g6OUBpuZB1uuVNJmhKD19gSxxLWNEQqq78IVF/oDhnGkESUITXma/qdPOTnelIXMpCbbqOkjbCwIe/ZyIUeTjakSpV7215lYwVZ4Q6ZtCcyqSiPVrGpLDrG3fNWDJBJcZ6k7GYOaIZSlD7T6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518904; c=relaxed/simple;
	bh=oRrVys6S7JyRpghjQILzNHcW3pfvWtk7uuRmS8b2obA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPgKykbFo0CEy0V6AYQpIQUIxEzCOpVslrhcds7DTvq5TWk5jyLA+t6u7nmUzHfAZjrYmJmzFofqenaHkXPZ4b646DXGgF4ohU4z8nyCl72ILsfX7ZOkxyXCSaUSveVt7exGeK9WpaFC+MgMRWhJDJZdTTai/kebdgkdRDlxpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRFMDFiD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729518902; x=1761054902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oRrVys6S7JyRpghjQILzNHcW3pfvWtk7uuRmS8b2obA=;
  b=IRFMDFiD3ZA9MGC+Abm9xXOPM3n2vYsgpb0+1QHmMESIvOxcL/pZcwJS
   lMAeqmPm5+rfyW6DiWYjT2B8blGDo0d/xshCzmCelSyiOyK6VdGSkQPkv
   h4KrwXinSnWta442LL2/75FUkYsoPXbZl12HKSWUUx6PuM+yrse050dlu
   i3aZBWY6p5daJ5RHFCJtv6l0kYtvE4VYRGWYmZkYyZYJXJ5Aj2nqVgaqD
   jdQrraI83FI/mjOCkvUlxVCGizYfwhp23BbJV8pduwwXvqtRFQ/bvls16
   AMo+5ZFtQhLjX2cK0DZXUnSKroM6wFUnuHZ2JzXgZ2NyrDZZUFj8t11O/
   w==;
X-CSE-ConnectionGUID: AAJ4IJr2TcWTfCXez63rCw==
X-CSE-MsgGUID: isgEZL0MTkSYSI2EqJttZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28443786"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="28443786"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:55:02 -0700
X-CSE-ConnectionGUID: VYBrYh/2Qk6ieStU8j6BRw==
X-CSE-MsgGUID: vaymWihdSxG1sPL8Nug1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84151031"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 06:55:01 -0700
Received: from [10.212.126.102] (kliang2-mobl1.ccr.corp.intel.com [10.212.126.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D80FA20CFEE2;
	Mon, 21 Oct 2024 06:54:58 -0700 (PDT)
Message-ID: <e7de0a73-23de-4b79-95e2-8a6dd9addfe7@linux.intel.com>
Date: Mon, 21 Oct 2024 09:54:57 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] perf/x86/intel: Use topology_hw_cpu_type()
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Brice Goglin <brice.goglin@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-4-104892b7ab5f@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240930-add-cpu-type-v4-4-104892b7ab5f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Pawan,

On 2024-09-30 10:47 a.m., Pawan Gupta wrote:
> get_this_hybrid_cpu_type() misses a case when cpu-type is populated
> regardless of X86_FEATURE_HYBRID_CPU. This is particularly true for hybrid
> variants that have P or E cores fused off.
> 
> Instead use topology_hw_cpu_type() as it does not rely on hybrid feature to
> enumerate cpu-type. This can also help avoid the model-specific fixup
> get_hybrid_cpu_type().
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index d879478db3f5..80a2a307e678 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4906,7 +4906,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
>  
>  static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
>  {
> -	u8 cpu_type = get_this_hybrid_cpu_type();
> +	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
> +	u8 cpu_type = topology_hw_cpu_type(c);
>  	int i;
>  
>  	/*
> 

Dapeng's patch to utilize the native model ID in perf has been merged.
Please replace the get_this_hybrid_cpu_native_id() as well when you spin
a new version.
https://lore.kernel.org/all/20240820073853.1974746-4-dapeng1.mi@linux.intel.com/

Thanks,
Kan

