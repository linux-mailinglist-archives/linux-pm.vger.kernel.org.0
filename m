Return-Path: <linux-pm+bounces-22803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9120A41F5B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFB4188F24E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CA23BCF2;
	Mon, 24 Feb 2025 12:41:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556C523BCE9;
	Mon, 24 Feb 2025 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400898; cv=none; b=LbdN4F/4duB22kqkSI2hi/vpaIljpXoIQ984vp2dmLwYtYeu64JMSNeIomFfq6fiwSndCua3ILNJccx2RyEOWboesbokiE09nbYUmI8wQ0owRpHIO1CIZ0JHLGN3VRLjcgDE05XX8qGWCfPHl1m6Vzxje5HiKT8LHl7LL6f2Epg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400898; c=relaxed/simple;
	bh=kJZjwClM/abFmBmNJE5WKeYjNO/OodcLkhc8SQd9mxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=si4KPZ7Z+ons7b2FmmooQKj7Ab9kt7eWFaysQqN5NzrXn4lPMTnWAMP1VlVbeAFdP9RLtQTk5eIZEXxua3ScKMKqy4Zp+mIO5TQ1BeS/IfskMi02075n9wzdpTv7amJKld/KBV/CSJ2mTEKfhCP2I6bD8kpiDAvZPdjH5S00fkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2231756;
	Mon, 24 Feb 2025 04:41:52 -0800 (PST)
Received: from [10.1.25.52] (e127648.arm.com [10.1.25.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 376BE3F6A8;
	Mon, 24 Feb 2025 04:41:33 -0800 (PST)
Message-ID: <86756d5c-ce47-4a91-afff-480b82207516@arm.com>
Date: Mon, 24 Feb 2025 12:41:31 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: menu: Update documentation after previous
 changes
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>
References: <4998484.31r3eYUQgx@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <4998484.31r3eYUQgx@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 20:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The documentaion of the menu cpuidle governor needs to be updated
s/documentaion/documentation/
> to match the code bevavior after some changes made recently.

s/bevavior/behavior/

> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/admin-guide/pm/cpuidle.rst |   27 ++++++++++++++++-----------
>  drivers/cpuidle/governors/menu.c         |   29 ++++++++++-------------------
>  2 files changed, 26 insertions(+), 30 deletions(-)
> 
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -275,20 +275,25 @@
>  and variance of them.  If the variance is small (smaller than 400 square
>  milliseconds) or it is small relative to the average (the average is greater
>  that 6 times the standard deviation), the average is regarded as the "typical
> -interval" value.  Otherwise, the longest of the saved observed idle duration
> +interval" value.  Otherwise, either the longest or the shortest (depending on
> +which one is farther from the average) of the saved observed idle duration
>  values is discarded and the computation is repeated for the remaining ones.
> +
>  Again, if the variance of them is small (in the above sense), the average is
>  taken as the "typical interval" value and so on, until either the "typical
> -interval" is determined or too many data points are disregarded, in which case
> -the "typical interval" is assumed to equal "infinity" (the maximum unsigned
> -integer value).
> +interval" is determined or too many data points are disregarded.  In the latter
> +case, if the size of the set of data points still under consideration is
> +sufficiently large, the next idle duration is not likely to be above the largest
> +idle duration value still in that set, so that value is taken as the predicted
> +next idle duration.  Finally, if the set of data points still under
> +consideration is too small, no prediction is made.
>  
> -If the "typical interval" computed this way is long enough, the governor obtains
> -the time until the closest timer event with the assumption that the scheduler
> -tick will be stopped.  That time, referred to as the *sleep length* in what follows,
> -is the upper bound on the time before the next CPU wakeup.  It is used to determine
> -the sleep length range, which in turn is needed to get the sleep length correction
> -factor.
> +If the preliminary prediction of the next idle duration computed this way is
> +long enough, the governor obtains the time until the closest timer event with
> +the assumption that the scheduler tick will be stopped.  That time, referred to
> +as the *sleep length* in what follows, is the upper bound on the time before the
> +next CPU wakeup.  It is used to determine the sleep length range, which in turn
> +is needed to get the sleep length correction factor.
>  
>  The ``menu`` governor maintains an array containing several correction factor
>  values that correspond to different sleep length ranges organized so that each
> @@ -302,7 +307,7 @@
>  The sleep length is multiplied by the correction factor for the range that it
>  falls into to obtain an approximation of the predicted idle duration that is
>  compared to the "typical interval" determined previously and the minimum of
> -the two is taken as the idle duration prediction.
> +the two is taken as the final idle duration prediction.
>  
>  If the "typical interval" value is small, which means that the CPU is likely
>  to be woken up soon enough, the sleep length computation is skipped as it may
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -41,7 +41,7 @@
>   * the  C state is required to actually break even on this cost. CPUIDLE
>   * provides us this duration in the "target_residency" field. So all that we
>   * need is a good prediction of how long we'll be idle. Like the traditional
> - * menu governor, we start with the actual known "next timer event" time.
> + * menu governor, we take the actual known "next timer event" time.
>   *
>   * Since there are other source of wakeups (interrupts for example) than
>   * the next timer event, this estimation is rather optimistic. To get a
> @@ -50,30 +50,21 @@
>   * duration always was 50% of the next timer tick, the correction factor will
>   * be 0.5.
>   *
> - * menu uses a running average for this correction factor, however it uses a
> - * set of factors, not just a single factor. This stems from the realization
> - * that the ratio is dependent on the order of magnitude of the expected
> - * duration; if we expect 500 milliseconds of idle time the likelihood of
> - * getting an interrupt very early is much higher than if we expect 50 micro
> - * seconds of idle time. A second independent factor that has big impact on
> - * the actual factor is if there is (disk) IO outstanding or not.
> - * (as a special twist, we consider every sleep longer than 50 milliseconds
> - * as perfect; there are no power gains for sleeping longer than this)
> - *
> - * For these two reasons we keep an array of 12 independent factors, that gets
> - * indexed based on the magnitude of the expected duration as well as the
> - * "is IO outstanding" property.
> + * menu uses a running average for this correction factor, but it uses a set of
> + * factors, not just a single factor. This stems from the realization that the
> + * ratio is dependent on the order of magnitude of the expected duration; if we
> + * expect 500 milliseconds of idle time the likelihood of getting an interrupt
> + * very early is much higher than if we expect 50 micro seconds of idle time.
> + * For this reason, menu keeps an array of 6 independent factors, that gets
> + * indexed based on the magnitude of the expected duration.
>   *
>   * Repeatable-interval-detector
>   * ----------------------------
>   * There are some cases where "next timer" is a completely unusable predictor:
>   * Those cases where the interval is fixed, for example due to hardware
> - * interrupt mitigation, but also due to fixed transfer rate devices such as
> - * mice.
> + * interrupt mitigation, but also due to fixed transfer rate devices like mice.
>   * For this, we use a different predictor: We track the duration of the last 8
> - * intervals and if the stand deviation of these 8 intervals is below a
> - * threshold value, we use the average of these intervals as prediction.
> - *
> + * intervals and use them to estimate the duration of the next one.
>   */

Assuming you fix up the typos in the commit message when applying:
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

