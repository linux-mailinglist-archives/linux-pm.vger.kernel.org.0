Return-Path: <linux-pm+bounces-38417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0251C7E220
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDAB3AAED4
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCA42C15A5;
	Sun, 23 Nov 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3WuEg3J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB226ED30;
	Sun, 23 Nov 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763910259; cv=none; b=DvBfqkJHozH2lcIgx2YXLSz94n5JL8jHa56yDSqxJ8X84YDTwig1LfTmR8bDwd84OP44ZfJr4KWmxtqmQuJsh6wpLPbjUdVTbcoybPMaSSPqXgmqmGzemsZGyx/fX6cTbSOKk3u5R9UxwWFPG/fvsU8x6pFOP9Le9o8TszVNpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763910259; c=relaxed/simple;
	bh=vfDemgsSOh8hZVga0CwxcpI9I7Peo9Ak7E9A0MObeRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4PAnqvKHPwHfzfChnmdIYAJhaLTh8XtmV+feuCdN/xj8o+mBFwHrO/vvjVOaOs6ssYty6WVCYSWhUMTD9S/7wnaD0QAMWBht3QOTmEcdJt3iInwDgh/tMB61VBYUULVABlWW+dQDNhLxKf8L0MGIAfPuaETWYtIqzqMGOt3604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3WuEg3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5305C113D0;
	Sun, 23 Nov 2025 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763910258;
	bh=vfDemgsSOh8hZVga0CwxcpI9I7Peo9Ak7E9A0MObeRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I3WuEg3JTb+i84tcsg5QD2Cf9xSL11tGPDwlGWKfBjWjM37vWaCTPaUA7CtrdXMdp
	 XgjTUWuusSRZ5eg2KEsudFUIPGn89iKOxurG4FdZm2kMB9ndyWcbzqRvs7gJkZ+Cut
	 zj5MNv7UNylAi9pmBvjzqfKVX7tz4lti6wZ7jPMxaBn6btMm+CRnOenDTvXbLXIs4T
	 U1C+dfY9s6sHcDupypQSaA6y6C6zuyXDihY442bPxE0zdOE744sNz96j2+v82i+ggr
	 0yupb9wUxsEVneYQarQwojxmhwjh3ELJquGrXYxd/nKiULpQKisdXst9fcBknSQFrz
	 Vp+TuAyYElezQ==
Message-ID: <9330a6ac-7655-4255-884c-b440d312f2ae@kernel.org>
Date: Mon, 24 Nov 2025 00:04:15 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] PM / devfreq: tegra30: use min to simplify
 actmon_cpu_to_emc_rate
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Dmitry Osipenko <digetx@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251112172121.3741-2-thorsten.blum@linux.dev>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20251112172121.3741-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Applied it. Thanks,

25. 11. 13. 02:21에 Thorsten Blum 이(가) 쓴 글:
> Use min() to improve the readability of actmon_cpu_to_emc_rate() and
> remove any unnecessary curly braces.
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 4a4f0106ab9d..2c9813bd697e 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -326,14 +327,9 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
>  	unsigned int i;
>  	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
>  
> -	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
> -		if (cpu_freq >= ratio->cpu_freq) {
> -			if (ratio->emc_freq >= tegra->max_freq)
> -				return tegra->max_freq;
> -			else
> -				return ratio->emc_freq;
> -		}
> -	}
> +	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++)
> +		if (cpu_freq >= ratio->cpu_freq)
> +			return min(ratio->emc_freq, tegra->max_freq);
>  
>  	return 0;
>  }

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


