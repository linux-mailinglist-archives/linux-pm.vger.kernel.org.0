Return-Path: <linux-pm+bounces-22208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D421A384DA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5345E16DCEF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18321CA0E;
	Mon, 17 Feb 2025 13:39:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9155028C;
	Mon, 17 Feb 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799555; cv=none; b=cCAwBTHw0dI13H4ii9P3jv6kPH6n6XW/3iVNV1dHYy+vS0UqMY4hsG4XQs0e8/nSe4NxcCQAhTWyJw326fA8LdISKHz+heVbgMNB6JEr1ihP6CB0cS3VK1B/8DT8JhjUi1ubXZ1QZSarj+MqqaZUm0JsD1U/KT72K9X0+Upe0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799555; c=relaxed/simple;
	bh=aj8DaIOuqHpHQ1w5i8X1HUdJ0j22lLabCTNqGcBBVBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQAFDl5q2HITi7f8rpy8fgIRG4Pg6QQQoVYuNhoRpA5vuLrVba+jSZl91UiVF+tm8eDdxLuZeSdCUHAwF6kYDsnguxV8GUfluQ0c9jfIQAm8/stf4ygnkoq8wBv8BuAmviXMQQQWFfM0b8hwOQpKbiGsaRQgtTpmisQkkP/U66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52F6213D5;
	Mon, 17 Feb 2025 05:39:32 -0800 (PST)
Received: from [10.1.35.42] (e127648.arm.com [10.1.35.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDB3D3F6A8;
	Mon, 17 Feb 2025 05:39:11 -0800 (PST)
Message-ID: <20f09309-bd96-4b29-9602-4f969547dc51@arm.com>
Date: Mon, 17 Feb 2025 13:39:09 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 5/5] cpuidle: menu: Avoid discarding useful
 information
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
 <7770672.EvYhyI6sBW@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <7770672.EvYhyI6sBW@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 14:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When giving up on making a high-confidence prediction,
> get_typical_interval() always returns UINT_MAX which means that the
> next idle interval prediction will be based entirely on the time till
> the next timer.  However, the information represented by the most
> recent intervals may not be completely useless in those cases.
> 
> Namely, the largest recent idle interval is an upper bound on the
> recently observed idle duration, so it is reasonable to assume that
> the next idle duration is unlikely to exceed it.  Moreover, this is
> still true after eliminating the suspected outliers if the sample
> set still under consideration is at least as large as 50% of the
> maximum sample set size.
> 
> Accordingly, make get_typical_interval() return the current maximum
> recent interval value in that case instead of UINT_MAX.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -190,8 +190,19 @@
>  	 * This can deal with workloads that have long pauses interspersed
>  	 * with sporadic activity with a bunch of short pauses.
>  	 */
> -	if ((divisor * 4) <= INTERVALS * 3)
> +	if (divisor * 4 <= INTERVALS * 3) {
> +		/*
> +		 * If there are sufficiently many data points still under
> +		 * consideration after the outliers have been eliminated,
> +		 * returning without a prediction would be a mistake because it
> +		 * is likely that the next interval will not exceed the current
> +		 * maximum, so return the latter in that case.
> +		 */
> +		if (divisor >= INTERVALS / 2)
> +			return max;
> +
>  		return UINT_MAX;
> +	}
>  
>  	/* Update the thresholds for the next round. */
>  	if (avg - min > max - avg)
> 

You might want to amend the description at the top of menu.c then given that
this now returns something without any meaning in a statistical significance
way. Similar to admin-guide doc.
As reported by the tests, this does improve performance a lot in scenarios of
short intervals (where passing the statistical test is hard).
Teo exploits the idle state residencies for this (i.e. as long as they fall
into the same bin, they are equal for our means), this can be viewed as the
menu equivalent to it, without relying on idle states.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


