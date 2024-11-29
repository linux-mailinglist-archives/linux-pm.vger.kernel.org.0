Return-Path: <linux-pm+bounces-18237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF39DC338
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96CE164273
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440D619B5A3;
	Fri, 29 Nov 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJfXO83S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5E14C5B0;
	Fri, 29 Nov 2024 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882192; cv=none; b=agtUbJqDFe+L2ZgeC1PgbrlWdRSeN05EVDIajxRSqQ+RUACFDWrsswzJ5Hfqr9SySfwMO9ja8LhfJrJYZTbpL+tTXCM6bnu1q4O1IiJAcLTfB8qfoZlfxykqBMEHOIaU2Z8DjzCEeM2Kh1FU7U6eBO/Z+BZ2rjp/GwHbUybfzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882192; c=relaxed/simple;
	bh=+9T5hDCUImgIsQR2tmkVDHCIFRYEKBBt7oXFAQYmXzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1yN+PmAj1fJEdFyKVYjmk5x1dGJiZyCJWs+EPerhsy1RbaFx717u6xVoamOJpF38pN9bWWSaXXpSaW8aFJUd8WokhhcHU4dorxai1k3wnJ5xOrvc7H4fDdfCbybDz/BQRhR7EX29+hszVo+iyCGMl53VvZLMw1XR07xvo+hZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJfXO83S; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732882191; x=1764418191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+9T5hDCUImgIsQR2tmkVDHCIFRYEKBBt7oXFAQYmXzs=;
  b=PJfXO83SLibjy7RhzRaeDDlC0FK0YTqgSTtpjlk7O9vTbEAVSNNtAqRz
   YAKOH3Qh10i54Pa8hNH1gHNbKCagkhR9ouRTnBi6hcEgmjIQiVj1jahyK
   oR8Qpyxnnv9JO6Ie/IjnTqhq6IU5dcTZWiNyo2N0mo0shw/1gHkACEn/c
   taWIO/R5fL9pKH6tN4TDuN2DzVeCSnmpQg6Mqm4s/nJfp/yjFG4FKBAnr
   uuK6nNBliLcmoOtduXeF5AIGg6cR0zxIrsecueA2QlxpGhj8GCy+d+NTp
   P6yTeXzY1vYVvDe0fU4xnpjcqJi6YdO0Qs/0mJWL1t3GVLCGaJPjxDdfk
   w==;
X-CSE-ConnectionGUID: luUSy2ZrTnSmbC1MiJ/o+A==
X-CSE-MsgGUID: M8JdrM31Q0eRKgDn47Rr5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="58524769"
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="58524769"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 04:09:49 -0800
X-CSE-ConnectionGUID: L224+3XaSS+/yyzPl/+ogQ==
X-CSE-MsgGUID: p51c/rr4SJibhokZHpbfVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,195,1728975600"; 
   d="scan'208";a="96892792"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.167]) ([10.245.245.167])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 04:09:47 -0800
Message-ID: <2d541e31-b5e0-41d9-9f08-8b6f0a20d716@linux.intel.com>
Date: Fri, 29 Nov 2024 13:09:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] x86/smp: Allow calling mwait_play_dead with an
 arbitrary hint
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, tglx@linutronix.de, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com
References: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
 <20241127161518.432616-2-patryk.wlazlyn@linux.intel.com>
 <Z0lCtdZKzZQXTWxF@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <Z0lCtdZKzZQXTWxF@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> The MWAIT instruction needs different hints on different CPUs to reach
>> specific idle states. The current hint calculation in mwait_play_dead()
>> code works in practice on current Intel hardware, but is not documented
>> and fails on a recent Intel's Sierra Forest and possibly some future
>> ones. Those newer CPUs' power efficiency suffers when the CPU is put
>> offline.
>>
>> Allow cpuidle code to provide mwait_play_dead with a known hint for
>> efficient play_dead code.
>
>
> Just a couple of minor nits:
>
> You could just reword this something along the lines of:
>
> "Introduce a helper function to allow offlined CPUs to enter FFh idle
> states with a specific MWAIT hint. The new helper will be used in
> subsequent patches by the acpi_idle and intel_idle drivers. This patch
> should not have any functional impact."
>
> There is no need to mention MWAIT hint calculation and the Sierra
> Forest failure in this patch, as this patch is not doing anything to
> fix the issue. Very likely you will be covering that in Patch 4.

Ok. I thought that giving some context on how the change originated might be
useful, but people doesn't seem to like that that much ;]

> "(...) This patch should not have any functional impact."

Yeah, forgot to put that no functional change intended.

>>
>> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
>> ---
>>  arch/x86/include/asm/smp.h |  4 +-
>>  arch/x86/kernel/smpboot.c  | 86 ++++++++++++++++++++------------------
>>  2 files changed, 49 insertions(+), 41 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
>> index ca073f40698f..ab90b95037f3 100644
>> --- a/arch/x86/include/asm/smp.h
>> +++ b/arch/x86/include/asm/smp.h
>> @@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
>>  int wbinvd_on_all_cpus(void);
>>  
>>  void smp_kick_mwait_play_dead(void);
>> +void mwait_play_dead_with_hint(unsigned int hint);

That actually is needed.

>>  
>>  void native_smp_send_reschedule(int cpu);
>>  void native_send_call_func_ipi(const struct cpumask *mask);
>> @@ -151,7 +152,6 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
>>  {
>>      return per_cpu(cpu_l2c_shared_map, cpu);
>>  }
>> -

Yeah, missed that one when submitting.

>>  #else /* !CONFIG_SMP */
>>  #define wbinvd_on_cpu(cpu)     wbinvd()
>>  static inline int wbinvd_on_all_cpus(void)
>
> This hunk is not relevant to this patch.


