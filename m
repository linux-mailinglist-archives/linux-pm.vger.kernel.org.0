Return-Path: <linux-pm+bounces-10172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC991BA92
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 10:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B880728391B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078E14EC42;
	Fri, 28 Jun 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/cxFALA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24A14D2AB;
	Fri, 28 Jun 2024 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565168; cv=none; b=KgNOnUtofhLFpzmScEc9DKFUuuocLow3ZvCQ96GPWD2MYCUUlkamkTNwnmUrCpQ84G4ZaVnVzOlpKDy7++Yh9JF2Lxfxqdz+sLNvzX/wfpTD8k+v2V72d7VD9v7u8WeE8AAXns5fokKYxBCt2LFscld0JuENzp/k7ca6h1d2pa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565168; c=relaxed/simple;
	bh=fsn7DgqHae5MMi2nZcdrg3QK9TBqy66uY6pL4EIadqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+4X5Aw70O5s4R7PQUybqzNGMztIn8/q84gEnqtmB0xhCSdKvWAUSI3CIM1g9ZmZRPI9c61Y7ENbAMSD2YjJPgygCgQnzcEdBjOT908PBkXD4zYYkfjdA5aOB4amoBHFyh0Q7EaR3PomZxG7TrAlAx1I1rfVWApk+P41dAqyEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/cxFALA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565167; x=1751101167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fsn7DgqHae5MMi2nZcdrg3QK9TBqy66uY6pL4EIadqI=;
  b=L/cxFALAE+uLgcWl/XKi+Nq/H1ICiee0842NypSRqCflKWLTsOZDyCan
   LDOHNFXlR5Kg7IBVh4Zs05sIxcamihSOhRQAQ2gMpCTaoCfwsgKpSxRjg
   mdID4kIrvs8cSdESTfDOO0IwYrbdcCc7RaLzQvxfsASIciSzIaLGL642Q
   DHgrLMvG7ZlwMOLbNrQ0HQwuGmz93cD+qHeNDAt/Ey/jCsOdVDg+SO7JO
   /i+ytQJ58VKnm/EgQdZE1R10CCXkXv8xmHxOrrKZY5gH6HGqOply9gqRG
   82Sk0g/u0EcLb+jZ+KYKW9OsbH1E6MAJhGQzbVF1Ab6k3J0jlgzeCwe5e
   Q==;
X-CSE-ConnectionGUID: ysVfkcyKRoC7Bi2q0cBoSg==
X-CSE-MsgGUID: 8cryBuhgTmaWNNL9aaG61A==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16964150"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16964150"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 01:59:26 -0700
X-CSE-ConnectionGUID: a2q1RSkxRcSf3SQPaf8/7g==
X-CSE-MsgGUID: nm1Jb91lS9S6fqU3fDhm8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="49278962"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.203]) ([10.124.232.203])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 01:59:22 -0700
Message-ID: <09000f4e-f373-448f-afef-35d2a413929f@linux.intel.com>
Date: Fri, 28 Jun 2024 16:59:18 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH v2 3/9] perf/x86/intel: Use topology_hw_cpu_type()
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
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Brice Goglin <brice.goglin@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-3-f927bde83ad0@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20240627-add-cpu-type-v2-3-f927bde83ad0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/28/2024 4:44 AM, Pawan Gupta wrote:
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
>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 38c1b1f1deaa..0da1fd14b0ea 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4753,7 +4753,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
>  
>  static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
>  {
> -	u8 cpu_type = get_this_hybrid_cpu_type();
> +	u8 cpu_type = topology_hw_cpu_type(smp_processor_id());

As Kan said, ARL-H would have two different atom uarchs, so we have to use
the extra native model id to identify them for PMU enabling. I'm not sure
if we need a similar helper topology_hw_cpu_native_id(), it may depend on
if the native id needs to be exposed to user space? such as whether there
are different vulnerabilities between these two atom uarchs?

For PMU enabling, we don't need to expose the native model ID to user
space, so we define a new helper get_this_hybrid_cpu_native_id() and
leverage it to identify the atom uarch.


>  	int i;
>  
>  	/*
>

