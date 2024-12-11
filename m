Return-Path: <linux-pm+bounces-19009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFAE9ECB43
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3612811E7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA91A83FC;
	Wed, 11 Dec 2024 11:32:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF30238E27;
	Wed, 11 Dec 2024 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916769; cv=none; b=N/RQqwQxKr3SHb24xuCxjNKcogrLnYESOx5XiC8EY3FmOafEQYKGye1dTvHJCTWHvXA2J9ABcUjBv/MXqs4qqN+vrg4Z833PfSV1+QFWcacmN8apazOvsNTlNytNpFJrjBE/3mA2+M6cHbp8gi2HWk53QhdyP1OKkGes3/2QR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916769; c=relaxed/simple;
	bh=DZ4pXylS7BphvV1styX0AH2aLT8CphfgQWYaZaCuK7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kob+gPd7tLbFGnNPvxXQSlBlAbfw5TwwBHa/ayjQswMEn9bpLlCKgZmE9XFfBJ4bhCWl/zu2riw+xmJEyULG0qgQIhY7TX22VD+M2PgmTg9ZFwEbY37RC/0ozFZXzHCt1WmqrBVTRbFSZHMFWWv9fucayLFkYQIW805O/PPZkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A41651063;
	Wed, 11 Dec 2024 03:33:14 -0800 (PST)
Received: from [10.1.37.59] (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C70C03F5A1;
	Wed, 11 Dec 2024 03:32:43 -0800 (PST)
Message-ID: <3fab85df-371a-410b-a8de-40b6a62e9efe@arm.com>
Date: Wed, 11 Dec 2024 11:32:41 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] cpufreq: apple-soc: Set fallback transition latency
 to APPLE_DVFS_TRANSITION_TIMEOUT
To: Nick Chan <towinchenmi@gmail.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241211112244.18393-1-towinchenmi@gmail.com>
 <20241211112244.18393-7-towinchenmi@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241211112244.18393-7-towinchenmi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 11:19, Nick Chan wrote:
> The driver already assumes transitions will not take longer than
> APPLE_DVFS_TRANSITION_TIMEOUT in apple_soc_cpufreq_set_target(), so it
> makes little sense to set CPUFREQ_ETERNAL as the transition latency
> when the transistion latency is not given by the opp-table.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index 94e57f055a5f..0af36f911bea 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -291,7 +291,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
>  	if (!transition_latency)
> -		transition_latency = CPUFREQ_ETERNAL;
> +		transition_latency = APPLE_DVFS_TRANSITION_TIMEOUT;

transition_latency is in ns, APPLE_DVFS_TRANSITION_TIMEOUT in us.
LGTM otherwise.

>  
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;


