Return-Path: <linux-pm+bounces-25324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64100A87179
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C42F177ADC
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04F19CCEA;
	Sun, 13 Apr 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH2Oizqp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC24189905;
	Sun, 13 Apr 2025 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744538552; cv=none; b=U57EsfXiHzug73nXqizbqDM1iQfvJZ8MM2f+PJV+ba4t98PDtTFhRcyTlcdKXnah2Xrfe8fD7+FpLyQf6xrsOJ/9911Cpyt3ICQcO0quZyGbVo9zgXQlFx2ZEMW6px12iuAdxVEXm7Yl6KFTOKw8LJzNateHQ/HVszJ0+fdezyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744538552; c=relaxed/simple;
	bh=GLcXtzkyEcqkVe79D0YOof25hce64lkHGEFRIYwzgqs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRAYRMO7a4Yom6JPLcVCqHExbamtffmfF2/b5bFa1WNjFza8237yaj4ETthuo9DCO3Tb+RSSybgn+/a9ybOHdNhgDxKLxBa3YMglcCmeMB7BBd1amfYK0d2UzrZh9GXVjnQNmix3KjuNlQkqduTAFycPw2f31Xk+ihjdeH17jmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH2Oizqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DFCC4CEDD;
	Sun, 13 Apr 2025 10:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744538551;
	bh=GLcXtzkyEcqkVe79D0YOof25hce64lkHGEFRIYwzgqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AH2Oizqp3xiY82mebN3ewYsQ2Ma+gdSQ9TXAaP9GiHtkiOlYYoe9ZXrSVIeCeOIuY
	 yHhkIlbFUMnm57QONmK7hKwE8pKY53OGhaF6BI73DgJGXESalh4FN7bPFP6yOaqa1S
	 tESWCq4wrdcWoptf/w4phsX04z6o0oWmdHzdnw5PS6TM0W/SjwsQOJp8HsO/AvunnM
	 2Jhd8afBcnSBsQs+sPTYoLsH9m8zllRJ9wZb2USYPfjHCa4P3kfM0b97VB+QBGlKJy
	 HIEbr+N+RQ114exZRon0Hxon0YWEzak+VVGP/B6TZJRc2G6oAwkevNdhIYWwDrYfjd
	 TnItTsDcyzCAQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u3uAW-004w7g-UD;
	Sun, 13 Apr 2025 11:02:29 +0100
Date: Sun, 13 Apr 2025 11:02:27 +0100
Message-ID: <86bjt0l6q4.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: sven@svenpeter.dev,
	j@jannau.net,
	alyssa@rosenzweig.io,
	neal@gompa.dev,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	marcan@marcan.st,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: apple-soc: Fix possible null pointer dereference
In-Reply-To: <20250412160518.1824538-1-chenyuan0y@gmail.com>
References: <20250412160518.1824538-1-chenyuan0y@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: chenyuan0y@gmail.com, sven@svenpeter.dev, j@jannau.net, alyssa@rosenzweig.io, neal@gompa.dev, rafael@kernel.org, viresh.kumar@linaro.org, marcan@marcan.st, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 12 Apr 2025 17:05:18 +0100,
Chenyuan Yang <chenyuan0y@gmail.com> wrote:
> 
> Check if policy is NULL before dereferencing it.
> 
> This is similar to the commit cf7de25878a1
> ("cppc_cpufreq: Fix possible null pointer dereference").
>

No, it's not similar. The patch you refer to actually introduces bugs
by returning -ENODEV in functions that have an unsigned return type.

> This is found by our static analysis tool KNighter.

I'm surprised that your tool hasn't found the above, because it should
be a pretty easy thing to do.

Irrespective of this, it would be good to describe under which
circumstances this can occur, because I can't see *how* this can
trigger. The policy is directly provided by the core code and provide
its association with a cpu, and is never NULL at the point of init.

And if it can trigger, why only fix this one particular case?
Dereferences of policy are all over the map, and would be just as
wrong.

> 
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 6286bbb40576 ("cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states")
> ---
>  drivers/cpufreq/apple-soc-cpufreq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> index 4994c86feb57..3de9bb2b0f22 100644
> --- a/drivers/cpufreq/apple-soc-cpufreq.c
> +++ b/drivers/cpufreq/apple-soc-cpufreq.c
> @@ -135,10 +135,14 @@ static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
>  static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> -	struct apple_cpu_priv *priv = policy->driver_data;
> +	struct apple_cpu_priv *priv;
>  	struct cpufreq_frequency_table *p;
>  	unsigned int pstate;
>  
> +	if (!policy)
> +		return 0;
> +	priv = policy->driver_data;
> +
>  	if (priv->info->cur_pstate_mask) {
>  		u32 reg = readl_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
>  

So while this is not wrong, I don't think this serves any real
purpose.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

