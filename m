Return-Path: <linux-pm+bounces-17214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7189C21F7
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9B61C20815
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA81922F8;
	Fri,  8 Nov 2024 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+5hJ0KK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A31917F4;
	Fri,  8 Nov 2024 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082889; cv=none; b=SI7BtwOOekGKTISkdQQJlh2HnKKAwPxmjCUJJXiTuDFvmedG8l88kuGTbWBRLhh2UsgEQ/dzo97kK6fBH2dOc4y//BQcg8qp+SOQaB/jm1iV02UJmkhCQ1CfeYv7P5+HAEjbnXzTNgkE3MCH60iGPtn4ApiumHI9JiKbCg1kerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082889; c=relaxed/simple;
	bh=SIFUI2KPYBeRlWqno9FC1kLW+WIHiqFVJ6q4hBonfvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTuQKXMRz4KL348t8fogXQ+WkSXYnKx59gJGucbOkEG6PCAEIB2Dr7hLN+VzXClsiyIt5/Kfjue2KEOgtZF0pbCb1Y7X4IlV/DrIu07BkF/pb3We0kUD0nm6JrYWm49PnmHJemBLbCchZ8wUADCFQ7zZbtApTHCWqJKAW+/HP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+5hJ0KK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731082887; x=1762618887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SIFUI2KPYBeRlWqno9FC1kLW+WIHiqFVJ6q4hBonfvs=;
  b=H+5hJ0KKWmYuW6t6wUD7LIDSuRAgc4DU1/HnnN9jDC/rdjdzMvCRGIH1
   8FZ3QMvuVibDGXWoq6ppmCGicCas0FNSLNT3IuIlB1pwy8zFJX6OWn6AC
   0jIovrVuafEXGIf919gEFmoqjxfZNFpuqSeLExf51nsBV6nn5bhCP6sDs
   AAWHaS2spDh6Xat2+ZaKPTkysmY8ylQOhzJO78ezEhajlfc7ZxX5+Fgqb
   xwK8Y6vqWkR7F6i75yOuLmS0Mr7HbL5klE2YJ9eYC/5F6q03PtAeu/I+7
   wg5P3Hb/00M3kaq/y7iRPOjWkyJOqRZoHENtn7ghp4fe44LYTbdaORc4l
   A==;
X-CSE-ConnectionGUID: 7gz1xMR4QPapvoDG9cuJCA==
X-CSE-MsgGUID: wyZzz6b0TM62KfjWv764zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="30370459"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="30370459"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:21:25 -0800
X-CSE-ConnectionGUID: QlA99iofTtewEy5KcFmZVg==
X-CSE-MsgGUID: Z+tzhDwYSo+qdURlrNj8Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="116492488"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.124.223.66]) ([10.124.223.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 08:21:24 -0800
Message-ID: <b6ab357c-1562-4035-ad3a-2159d2c8c1fa@intel.com>
Date: Fri, 8 Nov 2024 08:21:24 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] intel_idle: Provide enter_dead() handler for SRF
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 04:29, Patryk Wlazlyn wrote:
> Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
>     C6S  (hint 0x22)
>     C6SP (hint 0x23)
> 
> Hints 0x20 and 0x21 are skipped entirely, causing the generic
> implementation in mwait_play_dead() to compute the wrong hint, when
> looking for the deepest cstate. As a result, package with an offlined
> CPU can never reach PC6.

This series has said multiple times how the old algorithm is wrong.  But
it never actually _fixed_ the bad algorithm, only worked around it.

Does mwait_play_dead() itself need to get fixed?

> Define the enter_dead() handler for SRF.

This effectively gets the mwait hints from ______ instead of using the
calculation in mwait_play_dead().

> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 9aab7abc2ae9..bd67959e5e8b 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -56,6 +56,7 @@
>  #include <asm/mwait.h>
>  #include <asm/spec-ctrl.h>
>  #include <asm/fpu/api.h>
> +#include <asm/smp.h>
>  
>  #define INTEL_IDLE_VERSION "0.5.1"
>  
> @@ -221,6 +222,17 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
>  	return 0;
>  }
>  
> +static __cpuidle int intel_idle_enter_dead(struct cpuidle_device *dev,
> +					   int index)
> +{
> +	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +	struct cpuidle_state *state = &drv->states[index];
> +	unsigned long eax = flg2MWAIT(state->flags);
> +
> +	/* Retruns only in case of an error. */

		^ returns?

> +	return mwait_play_dead_with_hint(eax);
> +}
> +
>  /*
>   * States are indexed by the cstate number,
>   * which is also the index into the MWAIT hint array.
> @@ -1303,6 +1315,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
>  		.exit_latency = 1,
>  		.target_residency = 1,
>  		.enter = &intel_idle,
> +		.enter_dead = &intel_idle_enter_dead,
>  		.enter_s2idle = intel_idle_s2idle, },
>  	{
>  		.name = "C1E",
> @@ -1311,6 +1324,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
>  		.exit_latency = 2,
>  		.target_residency = 10,
>  		.enter = &intel_idle,
> +		.enter_dead = &intel_idle_enter_dead,
>  		.enter_s2idle = intel_idle_s2idle, },
>  	{
>  		.name = "C6S",
> @@ -1319,6 +1333,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
>  		.exit_latency = 270,
>  		.target_residency = 700,
>  		.enter = &intel_idle,
> +		.enter_dead = &intel_idle_enter_dead,
>  		.enter_s2idle = intel_idle_s2idle, },
>  	{
>  		.name = "C6SP",
> @@ -1327,6 +1342,7 @@ static struct cpuidle_state srf_cstates[] __initdata = {
>  		.exit_latency = 310,
>  		.target_residency = 900,
>  		.enter = &intel_idle,
> +		.enter_dead = &intel_idle_enter_dead,
>  		.enter_s2idle = intel_idle_s2idle, },
>  	{
>  		.enter = NULL }


