Return-Path: <linux-pm+bounces-15415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0B1997246
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350AF281CD9
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5514A611;
	Wed,  9 Oct 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLiIokbe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A28489;
	Wed,  9 Oct 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492598; cv=none; b=e3xTs1FQzLCODZ5JpQk862hPdhzNFrubir4t8moGWeTM9xKqBJmTtK0TWRJHr3PNg7WQilbG5LL6ydmKBeY69ams8MEqLsvP0eeJG7pVStv3RwbCp1yNS2WHh4sgcVOd9fMQbPuN63FX7pkYb4FtRq4h+0jYbZPDwYgUQAiQLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492598; c=relaxed/simple;
	bh=xR7cr3YHIIdDnSthq+U+odRxm4lKOmefmGr7+WmtlQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hoa/OLUEARmizkbolJ+IFzd9ar38FnWtMuveKCrtfcARBn3troxitnNYIuTNZCcjP96qssqmh0qF7eoxFz68CNlhT+cSlJZ3VLTNIEy+ayTPtiJUJeqSuDSlsYzH6d6NTjK6OqL7frUxVNlCbc47VO/s47lFLL1CjAa88Rkfk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLiIokbe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728492597; x=1760028597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xR7cr3YHIIdDnSthq+U+odRxm4lKOmefmGr7+WmtlQM=;
  b=DLiIokbeOd4spsjH5NyYoWL5oKLD4x7NRdNrY87ERoIIm/7TQ8i/wgmZ
   AAFJUVMbBUd+Un9zBbJOtBC6GAKQNk+aCD1B+J8eA14/itnobk8EjEMP0
   wABxlHVMnqme+6Q692UYOh8/Rord9txL3EQ7BLVkQAXnaJ8dXoiC9A40v
   P+2o5vcGEI0zarPm4A00LYzxDKgMYGwiyxj5az7qZH+GeBAImahTduxY9
   jkoTzFp9Y/2S11BOp+epz3wEQPwv3xtg1bH82e5HQXxjze3649LgSoS7k
   cxfkxkrv2mZDeM6s1mKrlS9vEsj2vt2eyXoUTFXCgTCeFXyoU8NLW3lrK
   A==;
X-CSE-ConnectionGUID: 6PcMmZxxQ4mvV0s+0up+5A==
X-CSE-MsgGUID: 7+V5AbwUSWWcqX7JJ2USdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27286749"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27286749"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:49:56 -0700
X-CSE-ConnectionGUID: uP/gmcODSzq7LMdkFOT4Tw==
X-CSE-MsgGUID: mvoOfj8uRUmv++7yllleJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="76404502"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.223.14]) ([10.124.223.14])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:49:55 -0700
Message-ID: <ed43f0b5-0625-4a6b-b986-42583673d857@intel.com>
Date: Wed, 9 Oct 2024 09:49:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
To: Zhang Rui <rui.zhang@intel.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
 x86@kernel.org, linux-pm@vger.kernel.org
Cc: hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com,
 yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
 srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241009072001.509508-1-rui.zhang@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241009072001.509508-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 00:20, Zhang Rui wrote:
> This 12-year-old bug prevents some modern processors from achieving
> maximum power savings during suspend. For example, Lunar Lake systems
> gets 0% package C-states during suspend to idle and this causes energy
> star compliance tests to fail.

Why haven't we noticed or cared for the last 12 years?

Also, plain language really matters.  Is this as simple as: "you close
the lid on the laptop and the CPU doesn't power down at all"?

> According to Intel SDM, for the local APIC timer,
> 1. "The initial-count register is a read-write register. A write of 0 to
>    the initial-count register effectively stops the local APIC timer, in
>    both one-shot and periodic mode."
> 2. "In TSC deadline mode, writes to the initial-count register are
>    ignored; and current-count register always reads 0. Instead, timer
>    behavior is controlled using the IA32_TSC_DEADLINE MSR."
>    "In TSC-deadline mode, writing 0 to the IA32_TSC_DEADLINE MSR disarms
>    the local-APIC timer."

Is "stopping" and "disarming" the same thing?

Second, while quoting the SDM is great, it would be even better to
including the Linux naming for these things.  The Linux naming for the
APIC registers is completely missing from this changelog.  You could say:

	"In TSC deadline mode, writes to the initial-count register
	(APIC_TMICT) are ignored"

which makes it much easier to relate this code:

        apic_write(APIC_TMICT, 0);

back to the SDM language.  This is especially true because:

#define APIC_TMICT      0x380

doesn't make it obvious that "ICT" is the "Initial-Count Register".  I
had to go back to the SDM table to make 100% sure.

This also doesn't ever say which mode the kernel is running in.

> Stop the TSC Deadline timer in lapic_timer_shutdown() by writing 0 to
> MSR_IA32_TSC_DEADLINE.

This dances around the problem but never comes out and says it:

	The CPU package does not go into lower power modes (higher
	package C-states) unless all local-APIC timers are disabled.

Plus something to connect the old to the new:

	On older CPUs, setting APIC_TMICT=0 was sufficient for disabling
	the local-APIC timer, no matter the timer mode (deadline, one-
	shot or periodic).  But newer CPUs adhere to the strict letter
	of the law in the SDM and more fully ignore APIC_TMICT when in
	deadline mode.  Those CPUs also don't fully "disable" the timer
	when IA32_TSC_DEADLINE has passed.  They _require_ writing a 0.

Or am I missing something?

> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 6513c53c9459..d1006531729a 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -441,6 +441,10 @@ static int lapic_timer_shutdown(struct clock_event_device *evt)
>  	v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
>  	apic_write(APIC_LVTT, v);
>  	apic_write(APIC_TMICT, 0);
> +
> +	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
> +		wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
> +
>  	return 0;
>  }
>  


