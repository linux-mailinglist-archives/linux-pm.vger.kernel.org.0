Return-Path: <linux-pm+bounces-22207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CA3A384B5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71483A8BD2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB7121C9EF;
	Mon, 17 Feb 2025 13:26:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138721C16D;
	Mon, 17 Feb 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798807; cv=none; b=tVOWqgRcHK0Pv1jT9pHcUcvT473B+12Tvu/Uo486BgQv41ISVE2cfzGcXivA9Etj9U9s6RFT92LfMiAPL4WCHRUlfsKeb5tbKwS592LfLEKKmB6r24z0oy6C267yrPwY5pT8wOoB41NBNTqo7sdfUct/oNDdGwa3+bkXIFh0XGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798807; c=relaxed/simple;
	bh=BZ/tkCRz/PxzCPngn4Ht5qx0+CAlN1NkPVrEsWM5/tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSuasWHLn4SGuDmJYDBzz2ikgvAUOL7APyFKLUoJHqwkydq89//THeay4321EfGnZkdEcmunW1cAdOg92x3W7t5XDZ7yybw288al5LAZqTetHmZFSittYmPFT3hH63TMkTkNmYAkuu5zFdnpHF2LOUx4eS2M3kMzQkCTbNicVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 653FF13D5;
	Mon, 17 Feb 2025 05:27:03 -0800 (PST)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D07CA3F6A8;
	Mon, 17 Feb 2025 05:26:42 -0800 (PST)
Message-ID: <3bbd1ada-0d26-4c91-b1f3-a947caf5abd0@arm.com>
Date: Mon, 17 Feb 2025 13:26:40 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 4/5] cpuidle: menu: Eliminate outliers on both
 ends of the sample set
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <2301940.iZASKD2KPV@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2301940.iZASKD2KPV@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 14:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, get_typical_interval() attempts to eliminate outliers at the
> high end of the sample set only (probably in order to bias the prediction
> toward lower values), but this it problematic because if the outliers are
> present at the low end of the sample set, discarding the highest values
> will not help to reduce the variance.
> 
> Since the presence of outliers at the low end of the sample set is
> generally as likely as their presence at the high end of the sample
> set, modify get_typical_interval() to treat samples at the largest
> distances from the average (on both ends of the sample set) as outliers.
> 
> This should increase the likelihood of making a meaningful prediction
> in some cases.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |   32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -116,30 +116,37 @@
>   */
>  static unsigned int get_typical_interval(struct menu_device *data)
>  {
> -	unsigned int max, divisor, thresh = UINT_MAX;
> +	s64 value, min_thresh = -1, max_thresh = UINT_MAX;
> +	unsigned int max, min, divisor;
>  	u64 avg, variance, avg_sq;
>  	int i;
>  
>  again:
>  	/* Compute the average and variance of past intervals. */
>  	max = 0;
> +	min = UINT_MAX;
>  	avg = 0;
>  	variance = 0;
>  	divisor = 0;
>  	for (i = 0; i < INTERVALS; i++) {
> -		unsigned int value = data->intervals[i];
> -
> -		/* Discard data points above or at the threshold. */
> -		if (value >= thresh)
> +		value = data->intervals[i];
> +		/*
> +		 * Discard the samples outside the interval between the min and
> +		 * max thresholds.
> +		 */
> +		if (value <= min_thresh || value >= max_thresh)
>  			continue;
>  
>  		divisor++;
>  
>  		avg += value;
> -		variance += (u64)value * value;
> +		variance += value * value;
>  
>  		if (value > max)
>  			max = value;
> +
> +		if (value < min)
> +			min = value;
>  	}
>  
>  	if (!max)
> @@ -175,10 +182,10 @@
>  	}
>  
>  	/*
> -	 * If we have outliers to the upside in our distribution, discard
> -	 * those by setting the threshold to exclude these outliers, then
> +	 * If there are outliers, discard them by setting thresholds to exclude
> +	 * data points at a large enough distance from the average, then
>  	 * calculate the average and standard deviation again. Once we get
> -	 * down to the bottom 3/4 of our samples, stop excluding samples.
> +	 * down to the last 3/4 of our samples, stop excluding samples.
>  	 *
>  	 * This can deal with workloads that have long pauses interspersed
>  	 * with sporadic activity with a bunch of short pauses.
> @@ -186,7 +193,12 @@
>  	if ((divisor * 4) <= INTERVALS * 3)
>  		return UINT_MAX;
>  
> -	thresh = max;
> +	/* Update the thresholds for the next round. */
> +	if (avg - min > max - avg)
> +		min_thresh = min;
> +	else
> +		max_thresh = max;
> +
>  	goto again;
>  }

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


