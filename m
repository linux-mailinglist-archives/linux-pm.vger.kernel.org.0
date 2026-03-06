Return-Path: <linux-pm+bounces-43854-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGgOMh0Iq2k/ZgEAu9opvQ
	(envelope-from <linux-pm+bounces-43854-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 18:00:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE00225994
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E632300F293
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230293A1E96;
	Fri,  6 Mar 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7/Ah/9A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D92336C0AA;
	Fri,  6 Mar 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816038; cv=none; b=d8a1wprMmG10mGr6oTp5NC905NVS8Be/qQEH50fv3QONITxycMHk93NnZ4zFxiWHsx6WIlBo8Whpd257wETXTHQayorxDU5osSZrbyY1S5bCfOeUmjEFdR/t4bF6R4zb5BEZQMZO1T4R+EtiRoMsql4Vv3Jhh/AMZuPiIe97AqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816038; c=relaxed/simple;
	bh=UxvDbFBGv9QgfcOx7y2B3JzBHpom2uaBOEnuzRuVfXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1ES4hsYHeruz9/192MZEBW0FcAkc5uKEXm+SMSyiMfgCR3XNk96IbkFWjdnV90YG/GSuIs1pHw0FAp4AxE0sDAxDoBAdjm15qZ2Du/cewHQXC3OUxIZXuJVUTAZcFA9IsOw3A3KuGYs3oUfBwmQdYiK8SZ6FlhbnEJY9qoQgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7/Ah/9A; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772816036; x=1804352036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UxvDbFBGv9QgfcOx7y2B3JzBHpom2uaBOEnuzRuVfXI=;
  b=k7/Ah/9AX9QdgoNDvOI0zMYyfo+kF6LC44sj0vBOds2EiKBN4ZX4lp1i
   dE21Doe5higOyQcapd2vSyeum2o7nsSvjD2r5cwLo9RDuZkL0/rEeEejw
   rRj3Hldv2Vh6YOnSMrjaI3211GvPfWrrvvAwM24Ce/Ek1+nUADM+Ur5tO
   jiAp140sPhNGu6JtZxdEUU2azuVNp5FNbGptdeksdp9yzLnT+DI4Mk0wy
   aqDnqTnT+NcG4geIF1EBTlCNt340jlCgZCbsISuolBOzu7nGlI+FbuWjK
   RFzYEMdeF6zO0KlJkutWosvQbCTO0ei1BFZFuElWzSc4RkfrUuSu3P43E
   A==;
X-CSE-ConnectionGUID: gZmWM1ZpSf60TfxCvIsi6Q==
X-CSE-MsgGUID: KIh/7enBS5eZjGi/yY9PDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="85403313"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="85403313"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 08:53:55 -0800
X-CSE-ConnectionGUID: Ndh+n2SPQeqwS9+sN39mDQ==
X-CSE-MsgGUID: ktFp3dtgQlSEmgYK/dgL/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="218293106"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.91]) ([10.125.109.91])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 08:53:55 -0800
Message-ID: <ffb7e798-e8c7-4728-b699-6c885be61136@intel.com>
Date: Fri, 6 Mar 2026 08:54:03 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/cpu/intel: Add EIST workaround for Lightning
 Mountain.
To: Martin Schiller <ms@dev.tdt.de>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Eckert <fe@dev.tdt.de>
References: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
 <20260306-cpufreq_lgm-v1-2-47f104aed7c2@dev.tdt.de>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260306-cpufreq_lgm-v1-2-47f104aed7c2@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAE00225994
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43854-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@intel.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

So what's weird about these systems? Do they not have a "normal" BIOS
based on the Intel reference one?

I don't know much about this specific feature, but this patch is doing
some unusual things. I'll elaborate below:

> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 98ae4c37c93eccf775d5632acf122603a19918a8..e49df04e8d491158cc48f8d8bef824c434256d09 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -466,6 +466,29 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
>  #else
>  static void intel_workarounds(struct cpuinfo_x86 *c)
>  {
> +	u64 misc_enable;
> +
> +	/*
> +	 * Intel / MaxLinear Lightning Mountain workaround to enable Enhanced
> +	 * Intel SpeedStep Technology (EIST) for each cpu. Otherwise, the
> +	 * frequency on some cpus is locked to the minimum value of 624 MHz.
> +	 * This usually would be the job of the BIOS / bootloader, but U-Boot
> +	 * only enables it on the cpu on which it is running.
> +	 */
> +	if (c->x86_vfm == INTEL_ATOM_AIRMONT_NP) {

Model checks area kinda a last resort. A quick search in the SDM found:

CPUID.01H:ECX[7]: If 1, supports Enhanced Intel SpeedStep® technology.

But there's other chit chat in the "Runtime Mutable CPUID Fields"
section that makes it seem that it's not a really feature enumeration
bit, but a flag to tell if the BIOS enabled it:

	CPUID.01H:ECX[7] -- This feature flag reflects the setting in
			    IA32_MISC_ENABLE[16]

But the plot thickens because the *existing* code does this:

static int centrino_cpu_init(struct cpufreq_policy *policy)
{
...
        /* Only Intel makes Enhanced Speedstep-capable CPUs */
        if (cpu->x86_vendor != X86_VENDOR_INTEL ||
            !cpu_has(cpu, X86_FEATURE_EST))
                return -ENODEV;
...
        if (!(l & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {

Which, again, makes it seem like X86_FEATURE_EST (aka. CPUID.01H:ECX[7])
tells you if the MSR bit is supported, not whether it is enabled.

I'd tend to trust the existing kernel code over quibbling with the SDM
wording in general. It's also possible the old code was just confused or
something was buggy.

> +		rdmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
> +		if (!(misc_enable & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
> +			misc_enable |= MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP;
> +			wrmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
> +
> +			/* check to see if it was enabled successfully */
> +			rdmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
> +			if (!(misc_enable & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP)) {
> +				pr_info("CPU%d: Can't enable Enhanced SpeedStep\n",
> +					c->cpu_index);
> +			}
> +		}
> +	}
>  }


This is also not written in the normal kernel style which minimizes
indentation. For instance, the function should have opened with:

	if (c->x86_vfm != INTEL_ATOM_AIRMONT_NP)
		return;

It also needs to be reconciled with centrino_cpu_init() (at least).
Having *a* single place to go in and say "If this CPU supports 'EST',
turn it on" would be a minimal refactoring that could be shared by your
new workaround and the old centrino code.

centrino_cpu_init() does look gated on X86_FEATURE_EST already, though
because of the centrino_ids[]. So, you still need to figure out the
interaction with X86_FEATURE_EST for when you call the workaround.

