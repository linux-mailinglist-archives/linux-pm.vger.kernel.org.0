Return-Path: <linux-pm+bounces-10269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBEA91D6A2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 05:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69B2B21718
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E3410A09;
	Mon,  1 Jul 2024 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKNO/RBg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3E125C1;
	Mon,  1 Jul 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805056; cv=none; b=hx4YhXOSidLQo1ObF602hiL+x4Kn5IHEeAPgsH6oqOasZKR+e6OeHk0sXawX7HTb32+ySnb7w9rH75+N07krdki6EkP2zaqYhC/e56kd3vmHyT90ACuQ860VOjxzqxKSaeI9BWz7fblPJiaQeuBHbJnesQVFViMxAintLONYmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805056; c=relaxed/simple;
	bh=QF8yLYIrhgSPgI4p5Ble/w6O5/IbzMLxngA0TSmBrYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8gWKn7hzccKqzqrWcc3nR5JDGB/nOJ8y5GLt0k3L34LlQX3+rNZsi1/HEDktHhV7xk0B4aqZsHuTBb3ihMhpyY8TGyafT6RNK46T5XIbG8PhS2FzbSq4JS080Vci4Pr+RoRvVjikJN/S0V2rl8qddPED8Q0WIbfNqCVR8I8YHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKNO/RBg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719805054; x=1751341054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QF8yLYIrhgSPgI4p5Ble/w6O5/IbzMLxngA0TSmBrYs=;
  b=UKNO/RBgmq3Tc7ihIVHvm/PGWb+LM+NR/bxKWSFCarTSXtVhSc6oDtb2
   hmp6JFbFilJygp3Zjtj5pHpssJF/A6GiGiWAdoX5/5isSoWrfDVoBk14K
   JAShEYDJcsxQ8bxUyMwp4czzXAYDcLax3ud91Fh9OEe/QzLbpODa3goyk
   Wtsenj7IeM72Lm9pZFqzWtxC8u1MCew6svr7J6xg1dR29ttElZilXO0cK
   zwk/IJcfHDa0C8Hmi4SLvCXePtvWUC1dGUWYCtB1UFLdZfXH+LwsceTXu
   XGpB2r9fbSUjjLRwY0O8+REi2ZwFVhKj3JlSkB1X1fTdgVUM46eZMTIHA
   w==;
X-CSE-ConnectionGUID: WYcWGoeFRNu4exLKkDhltg==
X-CSE-MsgGUID: qTB8R6/xSw6hD9fXLnaLNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="16858664"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="16858664"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 20:37:34 -0700
X-CSE-ConnectionGUID: Sq4oa5UgRGO0EqmAQh1j7Q==
X-CSE-MsgGUID: LtWulnvDTuG6izVH1UH3Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="49968737"
Received: from xfang-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 20:37:29 -0700
Message-ID: <d866215b-bffc-453f-9d92-232b729946d0@linux.intel.com>
Date: Mon, 1 Jul 2024 11:37:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] perf/x86/intel: Use topology_hw_cpu_type()
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, daniel.sneddon@linux.intel.com, tony.luck@intel.com,
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
 <09000f4e-f373-448f-afef-35d2a413929f@linux.intel.com>
 <20240628185136.6rl4x3no3vl3zben@desk>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20240628185136.6rl4x3no3vl3zben@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/29/2024 2:51 AM, Pawan Gupta wrote:
> On Fri, Jun 28, 2024 at 04:59:18PM +0800, Mi, Dapeng wrote:
>> On 6/28/2024 4:44 AM, Pawan Gupta wrote:
>>> get_this_hybrid_cpu_type() misses a case when cpu-type is populated
>>> regardless of X86_FEATURE_HYBRID_CPU. This is particularly true for hybrid
>>> variants that have P or E cores fused off.
>>>
>>> Instead use topology_hw_cpu_type() as it does not rely on hybrid feature to
>>> enumerate cpu-type. This can also help avoid the model-specific fixup
>>> get_hybrid_cpu_type().
>>>
>>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
>>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>>> ---
>>>  arch/x86/events/intel/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 38c1b1f1deaa..0da1fd14b0ea 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -4753,7 +4753,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
>>>  
>>>  static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
>>>  {
>>> -	u8 cpu_type = get_this_hybrid_cpu_type();
>>> +	u8 cpu_type = topology_hw_cpu_type(smp_processor_id());
>> As Kan said, ARL-H would have two different atom uarchs, so we have to use
>> the extra native model id to identify them for PMU enabling. I'm not sure
>> if we need a similar helper topology_hw_cpu_native_id(), it may depend on
>> if the native id needs to be exposed to user space? such as whether there
>> are different vulnerabilities between these two atom uarchs?
>>
>> For PMU enabling, we don't need to expose the native model ID to user
>> space, so we define a new helper get_this_hybrid_cpu_native_id() and
>> leverage it to identify the atom uarch.
> As CPUID.1A.EAX returns both the native model ID and core type, we can
> store it raw in topo->hw_cpu_type. Such that topo->hw_cpu_type contains
> both the native model ID and core-type. Then use accessors to get them
> separately?
>
> As per Intel SDM Vol 2A, table 3-8, combination of core-type and native
> model ID identifies the microarchitecture uniquely:
>
>   EAX Enumerates the native model ID and core type.
>
> 	Bits 31-24: Core type*
> 		10H: Reserved
> 		20H: Intel Atom®
> 		30H: Reserved
> 		40H: Intel® Core™
>
> 	Bits 23-00: Native model ID of the core. The core-type and native
> 	model ID can be used to uniquely identify the microarchitecture of
> 	the core.
>
> Let me know if below patch that implements intel_get_native_model_id()
> would work for your use case:

It looks good for me. Thanks.


>
> ---
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index 20e491c22b98..eaa84e4e4771 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -26,11 +26,13 @@ int mwait_usable(const struct cpuinfo_x86 *);
>  unsigned int x86_family(unsigned int sig);
>  unsigned int x86_model(unsigned int sig);
>  unsigned int x86_stepping(unsigned int sig);
> +enum x86_hw_topo_cpu_type x86_get_hw_cpu_type(struct cpuinfo_x86 *c);
>  #ifdef CONFIG_CPU_SUP_INTEL
>  extern void __init sld_setup(struct cpuinfo_x86 *c);
>  extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
>  extern bool handle_guest_split_lock(unsigned long ip);
>  extern void handle_bus_lock(struct pt_regs *regs);
> +u32 intel_get_native_model_id(struct cpuinfo_x86 *c);
>  #else
>  static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
>  static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> @@ -44,6 +46,7 @@ static inline bool handle_guest_split_lock(unsigned long ip)
>  }
>  
>  static inline void handle_bus_lock(struct pt_regs *regs) {}
> +u32 intel_get_native_model_id(struct cpuinfo_x86 *c)  { return 0; }
>  #endif
>  #ifdef CONFIG_IA32_FEAT_CTL
>  void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index d8d715fcc25c..08794668750f 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -107,7 +107,7 @@ struct cpuinfo_topology {
>  	u32			l2c_id;
>  
>  	// Hardware defined CPU-type
> -	u8			hw_cpu_type;
> +	u32			hw_cpu_type;

Since hw_cpu_type represents the whole EAX right now, it may need to be
changed to a more generic name, like hw_cpu_model, or others.


>  };
>  
>  struct cpuinfo_x86 {
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 717fdb928dc3..70f1a9661ce3 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -33,8 +33,6 @@
>  #include <linux/numa.h>
>  #include <linux/cpumask.h>
>  
> -#define X86_CPU_TYPE_INTEL_SHIFT	24
> -
>  enum x86_hw_topo_cpu_type {
>  	X86_HW_CPU_TYPE_UNKNOWN		= 0,
>  	X86_HW_CPU_TYPE_INTEL_ATOM	= 0x20,
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 86e0c69a60f6..151c2377df21 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1292,6 +1292,11 @@ static bool __init cpu_matches(const struct x86_cpu_id *table, unsigned long whi
>  	return m && !!(m->driver_data & which);
>  }
>  
> +enum x86_hw_topo_cpu_type __weak x86_get_hw_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	return X86_HW_CPU_TYPE_UNKNOWN;
> +}
> +
>  u64 x86_read_arch_cap_msr(void)
>  {
>  	u64 x86_arch_cap_msr = 0;
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index ac6c68a39051..3a951632d210 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1335,3 +1335,16 @@ void __init sld_setup(struct cpuinfo_x86 *c)
>  	sld_state_setup();
>  	sld_state_show();
>  }
> +
> +#define X86_INTEL_CPU_TYPE_SHIFT	24
> +#define X86_INTEL_NATIVE_MODEL_ID_MASK	((1 << X86_INTEL_CPU_TYPE_SHIFT) - 1)
> +
> +enum x86_hw_topo_cpu_type x86_get_hw_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	return c->topo.hw_cpu_type >> X86_INTEL_CPU_TYPE_SHIFT;
> +}
> +
> +u32 intel_get_native_model_id(struct cpuinfo_x86 *c)
> +{
> +	return c->topo.hw_cpu_type & X86_INTEL_NATIVE_MODEL_ID_MASK;
> +}
> diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
> index 85ef17325c06..8493bcd4db0b 100644
> --- a/arch/x86/kernel/cpu/match.c
> +++ b/arch/x86/kernel/cpu/match.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <asm/cpu_device_id.h>
>  #include <asm/cpufeature.h>
> +#include <asm/cpu.h>
>  #include <linux/cpu.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> @@ -22,7 +23,7 @@ static bool x86_match_hw_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id
>  	if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
>  		return true;
>  
> -	return c->topo.hw_cpu_type == m->cpu_type;
> +	return m->cpu_type == x86_get_hw_cpu_type(c);
>  }
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index 8b47bd6b0623..819f850b1960 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -87,6 +87,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>  		.cu_id			= 0xff,
>  		.llc_id			= BAD_APICID,
>  		.l2c_id			= BAD_APICID,
> +		.hw_cpu_type		= X86_HW_CPU_TYPE_UNKNOWN,
>  	};
>  	struct cpuinfo_x86 *c = tscan->c;
>  	struct {
> @@ -132,6 +133,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>  	case X86_VENDOR_INTEL:
>  		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
>  			parse_legacy(tscan);
> +		if (c->cpuid_level >= 0x1a)
> +			c->topo.hw_cpu_type = cpuid_eax(0x1a);
>  		break;
>  	case X86_VENDOR_HYGON:
>  		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))
> @@ -140,14 +143,6 @@ static void parse_topology(struct topo_scan *tscan, bool early)
>  	}
>  }
>  
> -static void topo_set_hw_cpu_type(struct cpuinfo_x86 *c)
> -{
> -	c->topo.hw_cpu_type = X86_HW_CPU_TYPE_UNKNOWN;
> -
> -	if (c->x86_vendor == X86_VENDOR_INTEL && c->cpuid_level >= 0x1a)
> -		c->topo.hw_cpu_type = cpuid_eax(0x1a) >> X86_CPU_TYPE_INTEL_SHIFT;
> -}
> -
>  static void topo_set_ids(struct topo_scan *tscan, bool early)
>  {
>  	struct cpuinfo_x86 *c = tscan->c;
> @@ -198,7 +193,6 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
>  	}
>  
>  	topo_set_ids(&tscan, false);
> -	topo_set_hw_cpu_type(c);
>  }
>  
>  void __init cpu_init_topology(struct cpuinfo_x86 *c)

