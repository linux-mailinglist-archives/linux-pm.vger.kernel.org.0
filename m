Return-Path: <linux-pm+bounces-8767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5BB90007F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 12:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191B8B22019
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D838313342F;
	Fri,  7 Jun 2024 10:17:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4A433C7;
	Fri,  7 Jun 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755457; cv=none; b=ktaDYYdf7z9HbWhSxkBNAdFZ2CsPjH/2bXMgrYgB9Bl6fQy1zl7XgnH41u5nsd/CQg4+NUvAi8G/XDwKsfFBylhsQwglsOlXDOo2Q3oH/Neq1meE7k/oml/TxUQADpcmkrVa9zfnz0ci+IKuAln8DwOfrsJfdqnaxaZy2uZOIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755457; c=relaxed/simple;
	bh=Ug6SkdkmrPmH963seVv21WpmPFtL12L/HiT6x52apt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEKzW49WJnkPGiK+1cXHjS5DTvIx7LcnAUVxJ32TsMS6XVsJCuyL5VN5dHl7Mq10GkLNNkGjwa+sjPHAK1wcfLXRInr06IIGwiRL2dhKBW9VTQooJDTeXYyBlA/sp2RUA50h+HydHY9QV/ywVTEW44tLDjH/zGWxZMfwqTldQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D5F2F4;
	Fri,  7 Jun 2024 03:17:59 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD7803F64C;
	Fri,  7 Jun 2024 03:17:33 -0700 (PDT)
Message-ID: <a71314e6-b248-44a4-8a82-0a8dfde9d44f@arm.com>
Date: Fri, 7 Jun 2024 12:17:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] cpuidle: teo: Don't count non-existent intercepts
To: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-7-christian.loehle@arm.com>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240606090050.327614-7-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 11:00, Christian Loehle wrote:
> When bailing out early, teo will not query the sleep length anymore
> since commit 6da8f9ba5a87 ("cpuidle: teo:
> Skip tick_nohz_get_sleep_length() call in some cases") with an
> expected sleep_length_ns value of KTIME_MAX.
> This lead to state0 accumulating lots of 'intercepts' because
> the actually measured sleep length was < KTIME_MAX, so count KTIME_MAX
> as a hit (we have to count them as something otherwise we are stuck).
> 
> Fundamentally we can only do one of the two:
> 1. Skip sleep_length_ns query when we think intercept is likely
> 2. Have accurate data if sleep_length_ns is actually intercepted when
> we believe it is currently intercepted.
> 
> This patch chooses that latter as I've found the additional time it
> takes to query the sleep length to be negligible and the variants of
> option 1 (count all unknowns as misses or count all unknown as hits)
> had significant regressions (as misses had lots of too shallow idle
> state selections and as hits had terrible performance in
> intercept-heavy workloads).

So '2.' is the 'if (prev_intercept_idx != idx && !idx)' case ?

[...]

> @@ -514,6 +521,14 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  			first_suitable_idx = i;
>  		}
>  	}
> +	if (prev_intercept_idx != idx && !idx) {

if (!idx && prev_intercept_idx) ?

> +		/*
> +		 * We have to query the sleep length here otherwise we don't
> +		 * know after wakeup if our guess was correct.
> +		 */
> +		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> +		cpu_data->sleep_length_ns = duration_ns;
> +	}
>  
>  	/*
>  	 * If there is a latency constraint, it may be necessary to select an


