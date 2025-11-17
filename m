Return-Path: <linux-pm+bounces-38111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD7C63105
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 10:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 735FA4EF24B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B08329E61;
	Mon, 17 Nov 2025 09:06:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25E329C46;
	Mon, 17 Nov 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370378; cv=none; b=X7dEKnert/NcurKbvowHDIrDYq9toC8gax004/LBHhW4K41jdITm79/y4b7zgX3ngxOdbvRzH2AumlT1XGcxXzbXEAKJ0GL9Po64hUapst9uXxhB/299FYqo/LkM/E8Q8LdoGXpY7nT7i+pcds/xRO8AYwARE6k9yUZN4YoNphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370378; c=relaxed/simple;
	bh=/gfF8wZ1haKGkKn9DAFRZLMwsAFjnZN86AZ9G0CCsiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJpmFvltJqA0uJve2sN6yBs9jYOPW38wwlGmA1qXjhA9qKwhYPagM6mM/kNIIPzIB6ADcxMJcGuQYOMzLDIo7uLpHo86pg2srUwIIzHiYT+lli+mBgx/ZssmSOypt7Xx0BSl6gBko0vb7BkQUQGOSTu4oCL0EdsYgo1yPlutjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6985DFEC;
	Mon, 17 Nov 2025 01:06:07 -0800 (PST)
Received: from [10.57.74.7] (unknown [10.57.74.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93BA43F66E;
	Mon, 17 Nov 2025 01:06:13 -0800 (PST)
Message-ID: <8a9482f3-d8f4-4dcf-b7eb-51a2e1bd4d3b@arm.com>
Date: Mon, 17 Nov 2025 09:06:10 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] cpuidle: governors: teo: Fix tick_intercepts
 handling in teo_update()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <12810244.O9o76ZdvQC@rafael.j.wysocki>
 <5085160.31r3eYUQgx@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5085160.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/25 12:34, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The condition deciding whether or not to increase cpu_data->tick_intercepts
> in teo_update() is reverse, so fix it.
> 
> Fixes: d619b5cc6780 ("cpuidle: teo: Simplify counting events used for tick management")
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> I'm planning to apply this for 6.19 on top of
> 
> https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysocki/
> 
> because that patch (indirectly) depends on commit d619b5cc6780.
> 
> ---
>  drivers/cpuidle/governors/teo.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -251,7 +251,7 @@ static void teo_update(struct cpuidle_dr
>  		cpu_data->state_bins[idx_timer].hits += PULSE;
>  	} else {
>  		cpu_data->state_bins[idx_duration].intercepts += PULSE;
> -		if (TICK_NSEC <= measured_ns)
> +		if (measured_ns <= TICK_NSEC)

nit: Why <= instead of <?
I guess it really doesn't matter with measured_ns only being a rough approximation
with an error in the order of wakeup-latency.

Reviewed-by:
Christian Loehle <christian.loehle@arm.com>

Let me go write some tests for all these edge cases :/

IIRC Aboorva's power systems have no idle state deeper than TICK_NSEC, so
this might make a big difference here, hence CCed.

