Return-Path: <linux-pm+bounces-36334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FACFBE7220
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 10:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE152347731
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54984280328;
	Fri, 17 Oct 2025 08:22:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52E427FB1E;
	Fri, 17 Oct 2025 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689378; cv=none; b=mSWuvat7sFwIMscCS8rj7ZOhs/AunpYm0drb0XQ5M86CemPyoNVuH5hx3X1PTxMLGnSgf3OoT1cYZfk+mVf/OQMTVmEowC2Fvl5jzhg+F9ymrZebikyeX2czy+x5ePBzEbv/CMCrHQP2RMM2Qb1PGVW2V00rKFK0fdEssJqG0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689378; c=relaxed/simple;
	bh=Y33sX9z6wohCICItsP2ZbZOBCRRm85TnYRsDA/wCAIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD86Z/bmqMFH4WOWvndUGS/xhnf0e2VfYvjvT1ryc4hyuc1Q0kSI2jKmtyhQHWFhYaWqZPt1pecc94IjeXHRfWvBarrpoLnwFVi61TXvbGqdKUo1Bi8FgiDb5suqiCKE/190dIV6iZmPiVNECn7NZqCOjpfd09nxWhLcwFbitkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31CD51595;
	Fri, 17 Oct 2025 01:22:47 -0700 (PDT)
Received: from [10.1.35.23] (e127648.arm.com [10.1.35.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 910843F59E;
	Fri, 17 Oct 2025 01:22:53 -0700 (PDT)
Message-ID: <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
Date: Fri, 17 Oct 2025 09:22:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Tomasz Figa <tfiga@chromium.org>, Doug Smythies <dsmythies@telus.net>
References: <4687373.LvFx2qVVIh@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4687373.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 17:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid discarding
> useful information") led to a performance regression on Intel Jasper Lake
> systems because it reduced the time spent by CPUs in idle state C7 which
> is correlated to the maximum frequency the CPUs can get to because of an
> average running power limit [1].
> 
> Before that commit, get_typical_interval() would have returned UINT_MAX
> whenever it had been unable to make a high-confidence prediction which
> had led to selecting the deepest available idle state too often and
> both power and performance had been inadequate as a result of that in
> some cases.  This was not a problem on systems with relatively
> aggressive average running power limits, like the Jasper Lake systems
> in question, because on those systems it was compensated by the ability
> to run CPUs at relatively higher frequencies.
> 
> Commit 85975daeaa4d addressed that by causing get_typical_interval() to
> return a number based on the recent idle duration information available
> to it in those cases, but that number is usually smaller than the
> maximum idle duration observed recently which may be regarded as an
> overly optimistic choice.
> 
> Namely, it may be argued that when the samples considered by
> get_typical_interval() are spread too much for a high-confidence
> prediction to be made, the function should fall back to returning a
> number that is likely to be an upper bound for the duration of the
> upcoming idle interval and that number needs to be at least equal to
> the maximum recently observed idle time.  Otherwise, the governor may
> miss an oportunity to reduce power without hurting performance in a
> noticeable way.  Of course, it may also be argued the other way around,
> but the available data indicate that get_typical_interval() should
> rather tend to return larger numbers as that causes the governor to
> behave more closely to its past behavior from before the problematic
> commit.
> 
> Accordingly, modify get_typical_interval() to return the maximum
> recently observed idle time when it is unable to make a high-
> confidence prediction.
> 
> Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
> Closes: https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/ [1]
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -116,6 +116,7 @@ static void menu_update(struct cpuidle_d
>  static unsigned int get_typical_interval(struct menu_device *data)
>  {
>  	s64 value, min_thresh = -1, max_thresh = UINT_MAX;
> +	unsigned int max_overall = 0;

nit: for reverse xmas this should be one further down?
Maybe s/max_overall/max_first_pass/?

>  	unsigned int max, min, divisor;
>  	u64 avg, variance, avg_sq;
>  	int i;
> @@ -151,6 +152,9 @@ again:
>  	if (!max)
>  		return UINT_MAX;
>  

Or alternatively a comment:
/* Save the max before we discard any intervals */
or something.

> +	if (max_overall < max)
> +		max_overall = max;
> +>  	if (divisor == INTERVALS) {
>  		avg >>= INTERVAL_SHIFT;
>  		variance >>= INTERVAL_SHIFT;
> @@ -198,7 +202,7 @@ again:
>  		 * maximum, so return the latter in that case.
>  		 */
>  		if (divisor >= INTERVALS / 2)
> -			return max;
> +			return max_overall;
>  
>  		return UINT_MAX;
>  	}
> 

Anyway, the patch makes sense, let me run some tests and get back.

