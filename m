Return-Path: <linux-pm+bounces-20236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B37A0934D
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D973A6F29
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1220D513;
	Fri, 10 Jan 2025 14:19:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E77D205ABD;
	Fri, 10 Jan 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518789; cv=none; b=DQ3Ck0psCI9G7T6J3mLHZgOI+eIMNjyhwQK0brAv0SKbOVHKnRcgydIfgaNqQSM5eX3nHhizs20UyrYOo9qX+IN3T5C+w2czl/rMiOgLv3PskJBhzeOUfRgmyC9XXmOW0K8KVWJvNhNPL+YkyTW9JyRNnF5NA5cSrTci3+kfNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518789; c=relaxed/simple;
	bh=7vLgKD05H58aNoIlnSNffdlPOVqMbboEF+aIiZhFTVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZdhQflhZrmPdNcHYPkRr9nqQvvNMGuEMXlrvKVwzF1mrB21ZeIjL14E1qeci7l2sWx+sYlILtS5MVSEFn1YxY+leAvIE3hY85iPpgQc0hYYkZMURGzAdXJGEx47Px4kWcdYBnL5kY7+DvV2JBUWsiNNfRdILhmh8kUO5L66w40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5E461477;
	Fri, 10 Jan 2025 06:20:14 -0800 (PST)
Received: from [10.57.6.52] (unknown [10.57.6.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 548893F59E;
	Fri, 10 Jan 2025 06:19:45 -0800 (PST)
Message-ID: <fb5db9b4-397e-4a21-b145-f19758fa35dc@arm.com>
Date: Fri, 10 Jan 2025 14:19:43 +0000
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
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <12589281.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <12589281.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 12:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") and
> other previous changes, the description of the menu governor in the
> documentation does not match the code any more, so update it as
> appropriate.
> 
> Fixes: 38f83090f515 ("cpuidle: menu: Remove iowait influence")
> Fixes: 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases")
> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/admin-guide/pm/cpuidle.rst |   72 +++++++++++++------------------
>  1 file changed, 31 insertions(+), 41 deletions(-)
> 
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -269,27 +269,7 @@
>  the CPU will ask the processor hardware to enter), it attempts to predict the
>  idle duration and uses the predicted value for idle state selection.
>  
> -It first obtains the time until the closest timer event with the assumption
> -that the scheduler tick will be stopped.  That time, referred to as the *sleep
> -length* in what follows, is the upper bound on the time before the next CPU
> -wakeup.  It is used to determine the sleep length range, which in turn is needed
> -to get the sleep length correction factor.
> -
> -The ``menu`` governor maintains two arrays of sleep length correction factors.
> -One of them is used when tasks previously running on the given CPU are waiting
> -for some I/O operations to complete and the other one is used when that is not
> -the case.  Each array contains several correction factor values that correspond
> -to different sleep length ranges organized so that each range represented in the
> -array is approximately 10 times wider than the previous one.
> -
> -The correction factor for the given sleep length range (determined before
> -selecting the idle state for the CPU) is updated after the CPU has been woken
> -up and the closer the sleep length is to the observed idle duration, the closer
> -to 1 the correction factor becomes (it must fall between 0 and 1 inclusive).
> -The sleep length is multiplied by the correction factor for the range that it
> -falls into to obtain the first approximation of the predicted idle duration.
> -
> -Next, the governor uses a simple pattern recognition algorithm to refine its
> +It first uses a simple pattern recognition algorithm to obtain a preliminary
>  idle duration prediction.  Namely, it saves the last 8 observed idle duration
>  values and, when predicting the idle duration next time, it computes the average
>  and variance of them.  If the variance is small (smaller than 400 square
> @@ -301,29 +281,39 @@
>  taken as the "typical interval" value and so on, until either the "typical
>  interval" is determined or too many data points are disregarded, in which case
>  the "typical interval" is assumed to equal "infinity" (the maximum unsigned
> -integer value).  The "typical interval" computed this way is compared with the
> -sleep length multiplied by the correction factor and the minimum of the two is
> -taken as the predicted idle duration.
> -
> -Then, the governor computes an extra latency limit to help "interactive"
> -workloads.  It uses the observation that if the exit latency of the selected
> -idle state is comparable with the predicted idle duration, the total time spent
> -in that state probably will be very short and the amount of energy to save by
> -entering it will be relatively small, so likely it is better to avoid the
> -overhead related to entering that state and exiting it.  Thus selecting a
> -shallower state is likely to be a better option then.   The first approximation
> -of the extra latency limit is the predicted idle duration itself which
> -additionally is divided by a value depending on the number of tasks that
> -previously ran on the given CPU and now they are waiting for I/O operations to
> -complete.  The result of that division is compared with the latency limit coming
> -from the power management quality of service, or `PM QoS <cpu-pm-qos_>`_,
> -framework and the minimum of the two is taken as the limit for the idle states'
> -exit latency.
> +integer value).
> +
> +If the "typical interval" computed this way is long enough, the governor obtains
> +the time until the closest timer event with the assumption that the scheduler
> +tick will be stopped.  That time, referred to as the *sleep length* in what follows,
> +is the upper bound on the time before the next CPU wakeup.  It is used to determine
> +the sleep length range, which in turn is needed to get the sleep length correction
> +factor.

The sleep length of course isn't really an upper bound before the next CPU wakeup,
we just treat it as such, but I guess the doc doesn't need to be too pedantic.

> +
> +The ``menu`` governor maintains an array containing several correction factor
> +values that correspond to different sleep length ranges organized so that each
> +range represented in the array is approximately 10 times wider than the previous
> +one.
> +
> +The correction factor for the given sleep length range (determined before
> +selecting the idle state for the CPU) is updated after the CPU has been woken
> +up and the closer the sleep length is to the observed idle duration, the closer
> +to 1 the correction factor becomes (it must fall between 0 and 1 inclusive).
> +The sleep length is multiplied by the correction factor for the range that it
> +falls into to obtain an approximation of the predicted idle duration that is
> +compared to the "typical interval" determined previously and the minimum of
> +the two is taken as the idle duration prediction.
> +
> +If the "typical interval" value is small, which means that the CPU is likely
> +to be woken up soon enough, the sleep length computation is skipped as it may
> +be costly and the idle duration is simply predicted to equal the "typical
> +interval" value.
>  
>  Now, the governor is ready to walk the list of idle states and choose one of
>  them.  For this purpose, it compares the target residency of each state with
> -the predicted idle duration and the exit latency of it with the computed latency
> -limit.  It selects the state with the target residency closest to the predicted
> +the predicted idle duration and the exit latency of it with the with the latency
> +limit coming from the power management quality of service, or `PM QoS <cpu-pm-qos_>`_,
> +framework.  It selects the state with the target residency closest to the predicted
>  idle duration, but still below it, and exit latency that does not exceed the
>  limit.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>


