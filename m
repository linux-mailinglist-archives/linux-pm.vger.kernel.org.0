Return-Path: <linux-pm+bounces-34338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4084DB50EC9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E5E54300C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591F4306B3A;
	Wed, 10 Sep 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Hcv50php"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8411302CBA;
	Wed, 10 Sep 2025 07:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488298; cv=none; b=MEivGjQy+yfvHxq1JZ2WqGcKN+CjpgUhjXlDBuLaDbd9GDU8LQxAKBC6sAv+UXRfFV1TXOC/YzMnBM53S6Zao3iLhfABT8nwy3s/K7Ekzlw7khNG0s290cUlyoNZ3lONXfJyrp1M6MdiW8QQ9VYOO4JbvX3SeTnuf8cUeZeplWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488298; c=relaxed/simple;
	bh=MKPZxIH3taedtreJ88sBf96nUf/AxnC4Xzi7CyUCBfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIP1l5Z+e7MCpaNYz2UTIRthkuYIL0H8EExQflHLfpcdEALasEsGjnZ4LZSn3N5A/rOA9BtsjIuqhncM1VWHKikMialhE5+GFR3pXZyVpzTx0Yfo3LiiBXz2KdzwmaCBR/RpWDOCkxTGMc8YKOCc/HcX7s2dgfHUTFN24Z8ZnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Hcv50php; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=t7wTohui/fSOqceO9w1DSGUSUx0VNZ73a2duW9lrSKo=;
	b=Hcv50phpoOajJxbARmNcO0WvCsTJtq4C7IfOmJ8OZLgyW0IFhyB0A4Y6ItRei6
	Xf4lkIMHdU+qed1jSS0LjNJQoZ54W+anj2ZwoSxIoUbkCRPYBxvErNceISvMERK2
	DmicX94zFN4bLE0jsNRicBQoOl9wybl7xt8Gz34Z7qIgo=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBHBW+MJMFo0Ow7BA--.40818S3;
	Wed, 10 Sep 2025 15:11:10 +0800 (CST)
Date: Wed, 10 Sep 2025 15:11:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
Message-ID: <aMEkjGN9HlwURISR@dragon>
References: <20250910065312.176934-1-shawnguo2@yeah.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910065312.176934-1-shawnguo2@yeah.net>
X-CM-TRANSID:M88vCgBHBW+MJMFo0Ow7BA--.40818S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryfKF13JF17Jw4rWw48WFg_yoW8Kr4kpF
	W5uay2yr48Xayqywn2kw48ua4Fva1DA3y2kFyqywnYv3y3J3WF93WUKayUK3yrAr4DGa15
	XF1Ut3ZrJF48ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut9N3UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQ62HGjBJI49ZAAA3f

On Wed, Sep 10, 2025 at 02:53:12PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawnguo@kernel.org>
> 
> A regression is seen with 6.6 -> 6.12 kernel upgrade on platforms where
> cpufreq-dt driver sets cpuinfo.transition_latency as CPUFREQ_ETERNAL (-1),
> due to that platform's DT doesn't provide the optional property
> 'clock-latency-ns'.  The dbs sampling_rate was 10000 us on 6.6 and
> suddently becomes 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these
> platforms, because that the 10 ms cap for transition_delay_us was
> accidentally dropped by the commits below.
> 
>   commit 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
>   commit a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
>   commit e13aa799c2a6 ("cpufreq: Change default transition delay to 2ms")
> 
> It slows down dbs governor's reacting to CPU loading change
> dramatically.  Also, as transition_delay_us is used by schedutil governor
> as rate_limit_us, it shows a negative impact on device idle power
> consumption, because the device gets slightly less time in the lowest OPP.
> 
> Fix the regressions by adding the 10 ms cap on transition delay back.
> 
> Cc: stable@vger.kernel.org
> Fixes: 37c6dccd6837 ("cpufreq: Remove LATENCY_MULTIPLIER")
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
>  drivers/cpufreq/cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..36e0c85cb4e0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -551,8 +551,13 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>  
>  	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>  	if (latency)
> -		/* Give a 50% breathing room between updates */
> -		return latency + (latency >> 1);
> +		/*
> +		 * Give a 50% breathing room between updates.
> +		 * And cap the transition delay to 10 ms for platforms
> +		 * where the latency is too high to be reasonable for
> +		 * reevaluating frequency.
> +		 */
> +		return min(latency + (latency >> 1), 10 * MSEC_PER_SEC);

I guess it's more correct to use USEC_PER_MSEC instead, even if both
have the value 1000.  Will fix in v2.

Shawn

>  
>  	return USEC_PER_MSEC;
>  }
> -- 
> 2.43.0
> 


