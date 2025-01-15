Return-Path: <linux-pm+bounces-20504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F8A12BF3
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 20:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCDB3A6DF1
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63911990C8;
	Wed, 15 Jan 2025 19:46:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0498F1D6199;
	Wed, 15 Jan 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970379; cv=none; b=tjRSktOjFyXmSUQENaJIxATEvcSKC7L1z22LWjpsRy5RZQxcuo1k+e0PGtEOG/Nh4Li+OLAhcX5CXo2GOh1mgUmEgnht2xHNAJRQcG4nuXu+xq7t7UIOcGAX/dqG+dD5AYf0dVwk8KTJgUMlV8TGlXrceiIGzpe1ma37mdXX0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970379; c=relaxed/simple;
	bh=d7SZakxEAte8afGiY6XOIna5i5JzzEeVByLCOKlRNcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a71LV6d2nfPmc5CvbefDfR/dfQYDUjcHlyggm/xD5uLYq00CSF293Bnu4IVjsoam0JnWfjqMa4lan5u1wNQFqvGbowlxB6t9O0S90E51h205XWSVz2S3Qh4L7DzowPuisG2nQWDlFp/8fPZCj+HY9YS3zJSVXh529jglU0f7Prk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91CE912FC;
	Wed, 15 Jan 2025 11:46:45 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 061F63F73F;
	Wed, 15 Jan 2025 11:46:15 -0800 (PST)
Message-ID: <d4bcd083-11fd-48b6-9dab-30717f3080d4@arm.com>
Date: Wed, 15 Jan 2025 19:46:14 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] cpuidle: teo: Drop local variable
 prev_intercept_idx
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <3327997.aeNJFYEL58@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3327997.aeNJFYEL58@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Local variable prev_intercept_idx in teo_select() is redundant becase

s/becase/because

> it cannot be 0 when candidate state index is 0.
> 
> The prev_intercept_idx value is the index of the deepest enabled idle
> state, so if it is 0, state 0 is the deepest enabled idle state, in
> which case it must be the only enabled idle state, but then teo_select()
> would have returned early before initializing prev_intercept_idx.
> 
> Thus prev_intercept_idx must be nonzero and the check of it against 0
> always passes, so it can be dropped altogether.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -292,7 +292,6 @@
>  	unsigned int hit_sum = 0;
>  	int constraint_idx = 0;
>  	int idx0 = 0, idx = -1;
> -	int prev_intercept_idx;
>  	s64 duration_ns;
>  	int i;
>  
> @@ -370,7 +369,6 @@
>  	 * all of the deeper states, a shallower idle state is likely to be a
>  	 * better choice.
>  	 */
> -	prev_intercept_idx = idx;
>  	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>  		int first_suitable_idx = idx;
>  
> @@ -437,14 +435,11 @@
>  		idx = constraint_idx;
>  
>  	if (!idx) {
> -		if (prev_intercept_idx) {
> -			/*
> -			 * Query the sleep length to be able to count the wakeup
> -			 * as a hit if it is caused by a timer.
> -			 */
> -			duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> -			cpu_data->sleep_length_ns = duration_ns;
> -		}
> +		/*
> +		 * Query the sleep length to be able to count the wakeup as a
> +		 * hit if it is caused by a timer.
> +		 */
> +		cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
>  		goto out_tick;

Just like the previous one:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>


