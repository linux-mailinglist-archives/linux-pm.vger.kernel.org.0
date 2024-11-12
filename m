Return-Path: <linux-pm+bounces-17394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE89C568F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 12:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059A9B41AD0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24E0213EC1;
	Tue, 12 Nov 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cj9U8nnS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041712139D8;
	Tue, 12 Nov 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408904; cv=none; b=Qdm7PSxQTB+4H7PBKHjcz4g1pozmSaqWHlA0ZPmdVwyqwQOw1dqPKfy2wObH+gmFgS168MyiyAUzZZ9SaAQ9OJ3hyhk5XjkGplqM1lhasonh5ZWJDALJ2Vbb0+g2QEbwo5SO+7EtpB5IdEKutW/rX6GZBakPmYlkH9TQZKx8tgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408904; c=relaxed/simple;
	bh=5hm6cRCf3A4dsk72yYd1IGdms+5/nAnLnzx5OyeYExM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9sjFcV5yPexoMNazKqcZBuBdUp9FJnfUISQFXRScKbkMco5/BxTvS+xTec2eTCfsKu7BULp3LNcR/74KnvUJWT6XSRbcgkjthiHLAxAG8iUqOY4bY2o6x8KjJYHfjgZ1AV1eZsbLI+ck8ezO9aV4cHD9ie+6nUs3fY/TMhwBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cj9U8nnS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731408903; x=1762944903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5hm6cRCf3A4dsk72yYd1IGdms+5/nAnLnzx5OyeYExM=;
  b=cj9U8nnStM5bEIjpXFncvAVhSCAvcxp/kuhIUBgpFEN8StFmso/Z6p0F
   IYN6wqeKT/3tlbIPv0XAgXay47vdbsvT2LOPHGud6pXeW9zDKlPBSkIi2
   2652R/oJfEGmJmBz7mE3fahuNKd2bdk5F9BE41RD36rYIlPDnAG76ughF
   3ONUwb+lLaTGAeH5QZu5+0SvXGz8aP1jUpsw1R/riy4RNkL/uK7CYKLey
   NR2tNmY/zO5H/2IclTH5gJpPR26vsPyrPgLIhSIet8AaogBgOjrZ5Niz2
   cOKqfZQigeoKctYSn/wL0J6UbLUjVws4wn9y7caAEzEQf5eIldEexaq4C
   g==;
X-CSE-ConnectionGUID: fukqBK0/RH+J4huBEnPeSA==
X-CSE-MsgGUID: japnR2u2S5uKcqJgIphS/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="56625867"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="56625867"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:55:02 -0800
X-CSE-ConnectionGUID: LDvoqFvUTyeYYZsF8EMURA==
X-CSE-MsgGUID: v3O5qL68RZixlmf3nfnlsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="118335281"
Received: from opintica-mobl1 (HELO [10.245.244.216]) ([10.245.244.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:55:00 -0800
Message-ID: <91e96978-7c40-4883-85ef-8cae0aa04ea2@linux.intel.com>
Date: Tue, 12 Nov 2024 11:54:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] x86/smp: Allow calling mwait_play_dead with
 arbitrary hint
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-2-patryk.wlazlyn@linux.intel.com>
 <dfe36107-1397-4401-b8fd-86cafe871866@intel.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <dfe36107-1397-4401-b8fd-86cafe871866@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> First, it is not clear what code this refers to.  It needs to be more clear.

ACK. I thought that code changes serve that purpose, but I can explicitly quote
the code I am reffering to.

> Second, this is not clear about the bug.  Start with being crystal clear
> about the problem and the impact:
>
>     MWAIT needs different hints on different CPUs to reach the most
>     efficient idle states. The hint calculation* works in practice
>     on current hardware, but it fails on newer ones. Those newer
>     CPUs' battery life really suffers when the system is suspended
>     like when a laptop lid is closed.
>
>      * The current calculation is the for loop inspecting edx in
>        mwait_play_dead()
>
> Then you can go into detail about what the bad implementation does.

It would kind of get into the bussiness of documenting the mwait instruction
itself. I am modifying behavior of already existing code.

Should I be more clear in the commit message or you also meant adding more code
comments?

>> For example Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
>>     C6S  (hint 0x22)
>>     C6SP (hint 0x23)
>>
>> Hints 0x20 and 0x21 are skipped entirely,
>
> Why does it start at 0x20?  Giving the example on new, broken hardware
> is also a bit weak without an example from old, fully functional hardware.

It's just how mwait hints work on Intel hardware:
    EAX[3:0] # Sub C-state
    EAX[7:4] # C-state

CPUID leaf 0x5 report how many sub c-states are there for any c-state.
Old code assumes that you can derive the actual hints from that, but you can
only do that if available hints are continuous, which is not guaranteed and is
not true on SRF and possibly future platforms.

Hint 0x20 (C6) was given as an example, because it's where the problem is.

Mwait hints themselves are processor-specific and so the same hint may mean
different thing on different hardware.

>> causing the current
>> implementation to compute the wrong hint, when looking for the deepest
>> cstate for offlined CPU to enter. As a result, package with an offlined
>> CPU can never reach PC6.
>
> I don't think the PC6 detail matters enough to mention here.

I can simplify the commit message, but the PC6 problem is the reason this change
was proposed.

>> Allow the idle driver to call mwait_play_dead() code with the forced
>> mwait hint, skipping the cpuid based computation.
>>
>> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
>> ---
>>  arch/x86/include/asm/smp.h |  6 ++++++
>>  arch/x86/kernel/smpboot.c  | 25 ++++++++++++++++++-------
>>  2 files changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
>> index ca073f40698f..fbd275d6661a 100644
>> --- a/arch/x86/include/asm/smp.h
>> +++ b/arch/x86/include/asm/smp.h
>> @@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
>>  int wbinvd_on_all_cpus(void);
>>  
>>  void smp_kick_mwait_play_dead(void);
>> +int mwait_play_dead_with_hint(unsigned long hint);
>>  
>>  void native_smp_send_reschedule(int cpu);
>>  void native_send_call_func_ipi(const struct cpumask *mask);
>> @@ -164,6 +165,11 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>>  {
>>      return (struct cpumask *)cpumask_of(0);
>>  }
>> +
>> +static inline int mwait_play_dead_with_hint(unsigned long eax_hint)
>> +{
>> +    return 1;
>> +}
>>  #endif /* CONFIG_SMP */
>>  
>>  #ifdef CONFIG_DEBUG_NMI_SELFTEST
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 0c35207320cb..44c40781bad6 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1270,13 +1270,14 @@ void play_dead_common(void)
>>      local_irq_disable();
>>  }
>>  
>> +int mwait_play_dead_with_hint(unsigned long eax_hint);
>
> We generally prefer these get a declaration in a header or get moved
> around in the file, not declared like this.

If forward declared and defined after mwait_play_dead, it makes the git
diff/blame simpler. As an alternative I could define it above, but the resulting
diff is harder to read and I didn't want to include whole smp header just for
that, but perhaps I should.

>>  /*
>>   * We need to flush the caches before going to sleep, lest we have
>>   * dirty data in our caches when we come back up.
>>   */
>> -static inline void mwait_play_dead(void)
>> +static inline int mwait_play_dead(void)
>>  {
>> -    struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
>>      unsigned int eax, ebx, ecx, edx;
>>      unsigned int highest_cstate = 0;
>>      unsigned int highest_subcstate = 0;
>> @@ -1284,13 +1285,13 @@ static inline void mwait_play_dead(void)
>>  
>>      if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>>          boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> -        return;
>> +        return 1;
>>      if (!this_cpu_has(X86_FEATURE_MWAIT))
>> -        return;
>> +        return 1;
>>      if (!this_cpu_has(X86_FEATURE_CLFLUSH))
>> -        return;
>> +        return 1;
>>      if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
>> -        return;
>> +        return 1;
>
> If you're going to use an 'int' for a fail/nofail return type, please
> just use -ERRNO's. It makes it *MUCH* more clear that these are error
> returns and not something else.
>
> That's what cpuidle_play_dead() does, for instance,  Please follow its lead.

ACK. Makes sense.

>>      eax = CPUID_MWAIT_LEAF;
>>      ecx = 0;
>> @@ -1314,6 +1315,13 @@ static inline void mwait_play_dead(void)
>>              (highest_subcstate - 1);
>>      }
>>  
>> +    return mwait_play_dead_with_hint(eax);
>> +}
>> +
>> +int mwait_play_dead_with_hint(unsigned long eax_hint)
>> +{
>> +    struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
>> +
>>      /* Set up state for the kexec() hack below */
>>      md->status = CPUDEAD_MWAIT_WAIT;
>>      md->control = CPUDEAD_MWAIT_WAIT;
>> @@ -1333,7 +1341,7 @@ static inline void mwait_play_dead(void)
>>          mb();
>>          __monitor(md, 0, 0);
>>          mb();
>> -        __mwait(eax, 0);
>> +        __mwait(eax_hint, 0);
>>  
>>          if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
>>              /*
>> @@ -1353,6 +1361,9 @@ static inline void mwait_play_dead(void)
>>                  native_halt();
>>          }
>>      }
>> +
>> +    /* Never reached */
>> +    return 0;
>>  }
>
> I think the preferred way to do this is to add a __noreturn annotation.

OK.


