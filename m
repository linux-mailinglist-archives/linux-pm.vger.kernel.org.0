Return-Path: <linux-pm+bounces-17212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDA9C2189
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21546282B4D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85792194082;
	Fri,  8 Nov 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mz0MVSQh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D83175D5E;
	Fri,  8 Nov 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081833; cv=none; b=sqPFZIv5KdSSuX0BkFxC+2UFUtnrvH2+7VjmYFJDZ/X2gFuyFE83xen3mTYG4zF+kU1++0WpVI47Py4UOTCDLBqIlLWOI7k3BN90uxWSBJ7KatEznL3hhkyoyZDGLXdl6MqAzfU6SXhaCxAzf54+bcYhjoLK2Q4Mxol0Hm0Mqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081833; c=relaxed/simple;
	bh=JiJxHReBqMK9UNZ2KYua6oCaKZ/5t/gQybxaVed8W50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POg7JJwTvKIlPVWWAiZiUCiCZ9JmkKB1n+PO+5/DX+GT3YrutX9RHOcJg4MBKGzcGnrb2ATuyhDi5KOEmQfKxAwjZnXncDOI9llr6IdqhBfqK1O/vlLrTPtaDH6sx2AwF2I644Mx1gZUh1XoS3jsZeV5EJ+wxaHte+ycKHPSXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mz0MVSQh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731081832; x=1762617832;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JiJxHReBqMK9UNZ2KYua6oCaKZ/5t/gQybxaVed8W50=;
  b=Mz0MVSQhdFX6TTqjZLrdc44Y7DRfTIpr71zQLbVXf5jGNn2acTAyX+CM
   tlQGBKshHpRtDGOUJQ6nBn/Ykprb66jX3PDK6RpR8wtqvAxCHT6pqKf23
   9kXfAjT3FViuLcG1HV8SlulmoDWGPKOEQxv2pFg3CiZBT7vfGxNYYnVDg
   2MeR5qqhiBEItksQi086v+WR8fAR+jU2ouqdPus6MC1S4bxBGhNuBoczU
   fffAV8MMrOBIb+b/2qqtI5SgfXuQMGUhwWbvdUH5VZlcROazpmYqkk8i4
   AV3oEdejVvwQMh1DT559q4+26RfegS0kAYVC0W8kKrKVXIzf01nsxGHL1
   A==;
X-CSE-ConnectionGUID: Ne+v9e1WQO63W/cpD3y1tg==
X-CSE-MsgGUID: CTYEQwD8T66Z4CPFyROIFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="31198661"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="31198661"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:03:51 -0800
X-CSE-ConnectionGUID: IW9qaDxVTWmyqWP9kQGE2w==
X-CSE-MsgGUID: IkfmL614Q2GyooaPT3FPaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="90440959"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.124.223.66]) ([10.124.223.66])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:03:51 -0800
Message-ID: <dfe36107-1397-4401-b8fd-86cafe871866@intel.com>
Date: Fri, 8 Nov 2024 08:03:49 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/smp: Allow calling mwait_play_dead with
 arbitrary hint
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-2-patryk.wlazlyn@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20241108122909.763663-2-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 04:29, Patryk Wlazlyn wrote:
> The current implementation for looking up the mwait hint for the deepest
> cstate depends on them to be continuous in range [0, NUM_SUBSTATES-1].
> While that is correct on most Intel x86 platforms, it is not documented
> and may not result in reaching the most optimized idle state on some of
> them.

First, it is not clear what code this refers to.  It needs to be more clear.

Second, this is not clear about the bug.  Start with being crystal clear
about the problem and the impact:

	MWAIT needs different hints on different CPUs to reach the most
	efficient idle states. The hint calculation* works in practice
	on current hardware, but it fails on newer ones. Those newer
	CPUs' battery life really suffers when the system is suspended
	like when a laptop lid is closed.

	 * The current calculation is the for loop inspecting edx in
	   mwait_play_dead()

Then you can go into detail about what the bad implementation does.

> For example Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
>     C6S  (hint 0x22)
>     C6SP (hint 0x23)
> 
> Hints 0x20 and 0x21 are skipped entirely,

Why does it start at 0x20?  Giving the example on new, broken hardware
is also a bit weak without an example from old, fully functional hardware.

> causing the current
> implementation to compute the wrong hint, when looking for the deepest
> cstate for offlined CPU to enter. As a result, package with an offlined
> CPU can never reach PC6.

I don't think the PC6 detail matters enough to mention here.

> Allow the idle driver to call mwait_play_dead() code with the forced
> mwait hint, skipping the cpuid based computation.
> 
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  arch/x86/include/asm/smp.h |  6 ++++++
>  arch/x86/kernel/smpboot.c  | 25 ++++++++++++++++++-------
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index ca073f40698f..fbd275d6661a 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
>  
>  void smp_kick_mwait_play_dead(void);
> +int mwait_play_dead_with_hint(unsigned long hint);
>  
>  void native_smp_send_reschedule(int cpu);
>  void native_send_call_func_ipi(const struct cpumask *mask);
> @@ -164,6 +165,11 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>  {
>  	return (struct cpumask *)cpumask_of(0);
>  }
> +
> +static inline int mwait_play_dead_with_hint(unsigned long eax_hint)
> +{
> +	return 1;
> +}
>  #endif /* CONFIG_SMP */
>  
>  #ifdef CONFIG_DEBUG_NMI_SELFTEST
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 0c35207320cb..44c40781bad6 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1270,13 +1270,14 @@ void play_dead_common(void)
>  	local_irq_disable();
>  }
>  
> +int mwait_play_dead_with_hint(unsigned long eax_hint);

We generally prefer these get a declaration in a header or get moved
around in the file, not declared like this.

>  /*
>   * We need to flush the caches before going to sleep, lest we have
>   * dirty data in our caches when we come back up.
>   */
> -static inline void mwait_play_dead(void)
> +static inline int mwait_play_dead(void)
>  {
> -	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
>  	unsigned int eax, ebx, ecx, edx;
>  	unsigned int highest_cstate = 0;
>  	unsigned int highest_subcstate = 0;
> @@ -1284,13 +1285,13 @@ static inline void mwait_play_dead(void)
>  
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>  	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> -		return;
> +		return 1;
>  	if (!this_cpu_has(X86_FEATURE_MWAIT))
> -		return;
> +		return 1;
>  	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
> -		return;
> +		return 1;
>  	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
> -		return;
> +		return 1;

If you're going to use an 'int' for a fail/nofail return type, please
just use -ERRNO's. It makes it *MUCH* more clear that these are error
returns and not something else.

That's what cpuidle_play_dead() does, for instance,  Please follow its lead.

>  	eax = CPUID_MWAIT_LEAF;
>  	ecx = 0;
> @@ -1314,6 +1315,13 @@ static inline void mwait_play_dead(void)
>  			(highest_subcstate - 1);
>  	}
>  
> +	return mwait_play_dead_with_hint(eax);
> +}
> +
> +int mwait_play_dead_with_hint(unsigned long eax_hint)
> +{
> +	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
> +
>  	/* Set up state for the kexec() hack below */
>  	md->status = CPUDEAD_MWAIT_WAIT;
>  	md->control = CPUDEAD_MWAIT_WAIT;
> @@ -1333,7 +1341,7 @@ static inline void mwait_play_dead(void)
>  		mb();
>  		__monitor(md, 0, 0);
>  		mb();
> -		__mwait(eax, 0);
> +		__mwait(eax_hint, 0);
>  
>  		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
>  			/*
> @@ -1353,6 +1361,9 @@ static inline void mwait_play_dead(void)
>  				native_halt();
>  		}
>  	}
> +
> +	/* Never reached */
> +	return 0;
>  }

I think the preferred way to do this is to add a __noreturn annotation.


