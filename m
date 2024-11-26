Return-Path: <linux-pm+bounces-18125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E524E9D9718
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF93AB2334F
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F376A1CCEF8;
	Tue, 26 Nov 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYLIougP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAA1A260;
	Tue, 26 Nov 2024 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622782; cv=none; b=UNMK4MNOv/Y0oRBTwaBWX/I92tfPxXSZpO1TPrL8x5tlKAXpkwVGHp68nq+3A3Pr3A7mZHF4CfVAiEWudZdbo0yHcto01vQ71wtFkjoB3aLjJEHtz3GyWrTTx9Es7tUVlNsfo/Z2AXZEIgQb0N/OdZra+rRRva7eaWa3ka9VMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622782; c=relaxed/simple;
	bh=7hzaEAE+XF35vgDtfXlTie6DfRk1VlC8RVCUcr/U5lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgHM+7bkmHdCdXVtBK/Wwtj7EZgE35LW8+jJ1QQWqb6ufmOtnH58G3kO5/G2gaamXN88Ee3WZ18/OVQAwy5MAdIVv+NlRlrQFqwJFXFMu/UWZOEUatm+x6H09uNv5IV+bHcNkYCPB2ElUdnWJHLI5cJowL08gQyGe2uzfNWHVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYLIougP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732622782; x=1764158782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7hzaEAE+XF35vgDtfXlTie6DfRk1VlC8RVCUcr/U5lc=;
  b=hYLIougPhnHtTzvUsRc6VyvZCU3CtWDSqQiCJWQF4HqE466sVNHv/wQ7
   Y6u8NCBiLZK9mJi3IOt80KkuBo1xoxpOYmtY3nMMR1d2XDYMwlWNxfJPB
   ccPg9EQ2siXU9+1HCXvWgwdHEhuavIJ3K++KEw/NKoN101nf/k9sZlNLn
   ijAvKB/A2kVOTpEr1M+sUNJ0K6sfoeIXoJTaLca8XFQEFXgRre39lyLPM
   cZj+blCQNH4Nn6bDelYGlOL4vdSQm/fi08ELxGLMHm4uodYmy6fKPgnKu
   +pQlFXi7/vlLmmJPMxRECLlDI/Y0FG40eeM3JhJxK/DKiSQgBP+PBiieM
   A==;
X-CSE-ConnectionGUID: J+y5TohIR2KtFqgrlHJ0KA==
X-CSE-MsgGUID: kaSY15GcSOKJyoQkbb7nvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="20369134"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="20369134"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 04:05:50 -0800
X-CSE-ConnectionGUID: JU+KPEM5Q8G+cNJ3PzSHoA==
X-CSE-MsgGUID: ApWcon4pTGy81tEYGYoaJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="122445107"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.245.172]) ([10.245.245.172])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 04:05:47 -0800
Message-ID: <3f764538-eaa5-4446-995c-d6b32c891b66@linux.intel.com>
Date: Tue, 26 Nov 2024 13:05:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 8/8] acpi_idle: Disallow play_dead with FFH cstate
 on AMD platforms
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
 <Z0SUnYECQ8ePq1q9@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <Z0SUnYECQ8ePq1q9@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/24 4:15 PM, Gautham R. Shenoy wrote:
> On Mon, Nov 25, 2024 at 02:20:28PM +0100, Patryk Wlazlyn wrote:
>> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
>> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>
> You can drop this patch. It is very rare to find a platform that
> supports FFH based C1 and doesn't have a IOPORT based C2.
>
> --
> Thanks and Regards
> gautham.
>
>
>> ---
>>  drivers/acpi/processor_idle.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index 586cc7d1d8aa..4b4ac8d55b55 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -803,7 +803,11 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>>  
>>          state->flags = 0;
>>  
>> -        state->enter_dead = acpi_idle_play_dead;
>> +        /* AMD doesn't want to use mwait for play dead. */
>> +        bool amd_or_hygon = boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> +                    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON;
>> +        if (!(cx->entry_method == ACPI_CSTATE_FFH && amd_or_hygon))
>> +            state->enter_dead = acpi_idle_play_dead;
>>  
>>          if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
>>              drv->safe_state_index = count;
>> --
>> 2.47.0
>>

ACK, thanks!

