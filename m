Return-Path: <linux-pm+bounces-22205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FA7A3840F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05433B8A68
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34C21B1B9;
	Mon, 17 Feb 2025 13:03:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10169193084;
	Mon, 17 Feb 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797388; cv=none; b=LdmwTV3tOVjUdweHqXJw9Vn8B+XYgci0ZgTCv4I8+5buKidTzSFSOzkrAaGvtqLQMjg7n5GSR6XHe81F51XaclYlU23wzPIgELW+YdahOO+1qHDoC7FlQMTBWVEcOpoIIKN8BL/XJ7eE4HuUwOIKN2DHHTuDP33U3u5G9xz1inE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797388; c=relaxed/simple;
	bh=qrmOkaVLkCWivZRjK6eeyFEaTtgFT3AnfYzGBM29WPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjoBHalo7tO3fTSNOEJkNoq/9bKm5Bd6Hg7o5OPCwXyskAj08LQXzDkA8calSgtoXOW1XIKlx35EbSi9qJH/OddeGMcKzlWs1LJH+a9mk87Vsg17o60xQnw9GEzun4JuOsfnyuMBkmkBHSnbdzW/uR38qoVbBuZ/ygDs//lzZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BD9413D5;
	Mon, 17 Feb 2025 05:03:24 -0800 (PST)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABE313F6A8;
	Mon, 17 Feb 2025 05:03:03 -0800 (PST)
Message-ID: <4ccf81b2-fa1e-479d-91f4-1c518594f877@arm.com>
Date: Mon, 17 Feb 2025 13:03:01 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 2/5] cpuidle: menu: Use one loop for average and
 variance computations
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <3339073.aeNJFYEL58@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3339073.aeNJFYEL58@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 14:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use the observation that one loop is sufficient to compute the average
> of an array of values and their variance to eliminate one of the loops
> from get_typical_interval().
> 
> While at it, make get_typical_interval() consistently use u64 as the
> 64-bit unsigned integer data type and rearrange some white space and the
> declarations of local variables in it (to make them follow the reverse
> X-mas tree pattern).
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |   61 +++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 33 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -116,49 +116,45 @@
>   */
>  static unsigned int get_typical_interval(struct menu_device *data)
>  {
> -	int i, divisor;
> -	unsigned int max, thresh, avg;
> -	uint64_t sum, variance;
> -
> -	thresh = INT_MAX; /* Discard outliers above this value */
> +	unsigned int max, divisor, thresh = INT_MAX;
> +	u64 avg, variance, avg_sq;
> +	int i;
>  
>  again:
> -
> -	/* First calculate the average of past intervals */
> +	/* Compute the average and variance of past intervals. */
>  	max = 0;
> -	sum = 0;
> +	avg = 0;
> +	variance = 0;
>  	divisor = 0;
>  	for (i = 0; i < INTERVALS; i++) {
>  		unsigned int value = data->intervals[i];
> -		if (value <= thresh) {
> -			sum += value;
> -			divisor++;
> -			if (value > max)
> -				max = value;
> -		}
> +
> +		/* Discard data points above the threshold. */
> +		if (value > thresh)
> +			continue;
> +
> +		divisor++;
> +
> +		avg += value;
> +		variance += (u64)value * value;
> +
> +		if (value > max)
> +			max = value;
>  	}
>  
>  	if (!max)
>  		return UINT_MAX;
>  
> -	if (divisor == INTERVALS)
> -		avg = sum >> INTERVAL_SHIFT;
> -	else
> -		avg = div_u64(sum, divisor);
> -
> -	/* Then try to determine variance */
> -	variance = 0;
> -	for (i = 0; i < INTERVALS; i++) {
> -		unsigned int value = data->intervals[i];
> -		if (value <= thresh) {
> -			int64_t diff = (int64_t)value - avg;
> -			variance += diff * diff;
> -		}
> -	}
> -	if (divisor == INTERVALS)
> +	if (divisor == INTERVALS) {
> +		avg >>= INTERVAL_SHIFT;
>  		variance >>= INTERVAL_SHIFT;
> -	else
> +	} else {
> +		do_div(avg, divisor);
>  		do_div(variance, divisor);
> +	}
> +
> +	avg_sq = avg * avg;
> +	variance -= avg_sq;
>  
>  	/*
>  	 * The typical interval is obtained when standard deviation is
> @@ -173,10 +169,9 @@
>  	 * Use this result only if there is no timer to wake us up sooner.
>  	 */
>  	if (likely(variance <= U64_MAX/36)) {
> -		if ((((u64)avg*avg > variance*36) && (divisor * 4 >= INTERVALS * 3))
> -							|| variance <= 400) {
> +		if ((avg_sq > variance * 36 && divisor * 4 >= INTERVALS * 3) ||
> +		    variance <= 400)
>  			return avg;
> -		}
>  	}
>  
>  	/*
> 

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


