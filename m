Return-Path: <linux-pm+bounces-10047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDFD917E9C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294B91F26B17
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C643317D34C;
	Wed, 26 Jun 2024 10:44:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A8179957;
	Wed, 26 Jun 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398648; cv=none; b=ggDKtG0C86B+DnT9/FtxWzi8vyav9e9m8/Fk8EuI0BsDTpT8FR9F/PGCSRMdwVwTAtuXUi5hYS0bJrAEcFFcZ3nxJ3OGEITGtiH0rK/2EWfwnd5rG5w8/5LG8fAE+oKQvm7mo6DrKvA/Idtr3gOB9L23BObb1ozR0PfKyJSavWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398648; c=relaxed/simple;
	bh=I60E58+WFYY9o6jPKnlfqcOca3KNiFUdpYHNT52AkpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiNdnJpwU+mtpt7JfhS8+lK1L6nvvh2LohUFQq9boJZ2WVWnNw1SAN3rt3NGW2lH7PkqNyO1ORd4NCPIvdCyUzHeQFh6/bhA7QZiNobF1/+8r/GhXYNk9hkwWc5sNwDzN9GCl5ujAhIi2P0no3Ap9j+ciUwd2ixLSV59trCmj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCCB7339;
	Wed, 26 Jun 2024 03:44:29 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 427313F766;
	Wed, 26 Jun 2024 03:44:03 -0700 (PDT)
Message-ID: <06231a07-c470-4156-bada-41b346b280cb@arm.com>
Date: Wed, 26 Jun 2024 12:44:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] cpuidle: teo: Remove recent intercepts metric
To: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240611112413.1241352-1-christian.loehle@arm.com>
 <20240611112413.1241352-3-christian.loehle@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240611112413.1241352-3-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2024 13:24, Christian Loehle wrote:
> The logic for recent intercepts didn't work, there is an underflow
> of the 'recent' value that can be observed during boot already, which
> teo usually doesn't recover from, making the entire logic pointless.
> Furthermore the recent intercepts also were never reset, thus not
> actually being very 'recent'.
> 
> Having underflowed 'recent' values lead to teo always acting as if
> we were in a scenario were expected sleep length based on timers is
> too high and it therefore unnecessarily selecting shallower states.
> 
> Experiments show that the remaining 'intercept' logic is enough to
> quickly react to scenarios in which teo cannot rely on the timer
> expected sleep length.
> 
> See also here:
> https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/

So the fixes proposed in teo_update() there:

(1) add '&& cpu_data->state_bins[cpu_data->recent_idx[i]].recent' to the 
    if condition to decrement 'cpu_data->state_bins[].recent' or

(2) Set 'cpu_data->state_bins[].recent' = 0 instead of decrement

didn't work?

> Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpuidle/governors/teo.c | 73 ++++++---------------------------
>  1 file changed, 12 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index d8554c20cf10..cc7df59f488d 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -59,10 +59,6 @@
>   * shallower than the one whose bin is fallen into by the sleep length (these
>   * situations are referred to as "intercepts" below).
>   *
> - * In addition to the metrics described above, the governor counts recent
> - * intercepts (that is, intercepts that have occurred during the last
> - * %NR_RECENT invocations of it for the given CPU) for each bin.
> - *
>   * In order to select an idle state for a CPU, the governor takes the following
>   * steps (modulo the possible latency constraint that must be taken into account
>   * too):
> @@ -81,20 +77,15 @@

 66  * 1. Find the deepest CPU idle state whose target residency does not exceed
 67  *    the current sleep length (the candidate idle state) and compute 3 sums as

s/3/2 ?

[...]

> @@ -320,8 +288,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  	unsigned int tick_intercept_sum = 0;
>  	unsigned int idx_intercept_sum = 0;
>  	unsigned int intercept_sum = 0;
> -	unsigned int idx_recent_sum = 0;
> -	unsigned int recent_sum = 0;
>  	unsigned int idx_hit_sum = 0;
>  	unsigned int hit_sum = 0;
>  	int constraint_idx = 0;

Looks like 'bool alt_intercepts, alt_recent' have to go here already and
not in 3/3.

[...]

