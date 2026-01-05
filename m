Return-Path: <linux-pm+bounces-40179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BACF2A72
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62AB5300D66D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE7832B99C;
	Mon,  5 Jan 2026 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="m09SNTMS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8D32573A;
	Mon,  5 Jan 2026 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604466; cv=none; b=mRvV3feCJIadlPvFnW+FpbvA02JSjzfOh7/2TC9dxv4kOEH7hGo+smipJKSW8gHFkKe50WpwZu/J+Sj73STFDgemCxdrZo9gK2CvmjLAFBLNbPaHKsfAjMaeb1ixWHPBwlywX+/7nOqc+zusvByB1GmnCjvosyeIjATn5DUqxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604466; c=relaxed/simple;
	bh=6gLEdhZvcQ8eY26ai+dpxvKO/Np0kZ2O161aQzCkSFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEHJZyV2UQmsNozVKjrVLJr847A01zZbeG+FHZJ+0/yv+Bopr+YpvH1lxxkP47eorooiPpYfWGncpfg8um2UmI0x6iSgbm2kd3Cv1evKTAE/d9LnkAoOact3lmQOdwLnAFm1n77YFVSwgcm1+X202M//OZgATB4K8dxM3luUfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=m09SNTMS; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zoA01OWoNPX+QO76V5EPzTn2Rmdvp86aihrC/IvyJj4=; b=m09SNTMSHVn9Ac8LM2ZXYiSTRr
	kpD4M2M/zX63h14MXxhQ6WPnyGmKkzYo26Si7iG9AIn/5CAVK2cDxPY7yKMTDlqqhWoepHb+RDoPI
	uOV41t3RXw6QelNwJypOJQlFhftes/BPiXoas8bl1EIK7jb/Ab0X9Dl8ASqvrq+aSHQQ7fV7nmjwr
	ScO3CS1krH4cwNezBcet5gnQEQ4hKVebY1xGxcRUB5sm/3+XBpbeS/RfsTMsF9/BUBPLGPujpi2Wp
	kGx6eeQ266Ezn1FXf9R7BTQlqr2OtHRZr887YdFsv4EpyxdQlwvntD8Xgn+zfzjmD0kTTnN424ole
	TnzGIWIA==;
Date: Mon, 5 Jan 2026 10:14:12 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap-cpufreq: Fix regulator resource leak in probe()
Message-ID: <20260105101412.0ac7baa7@kemnade.info>
In-Reply-To: <20251215030327.1771-1-vulab@iscas.ac.cn>
References: <20251215030327.1771-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 11:03:27 +0800
Haotian Zhang <vulab@iscas.ac.cn> wrote:

> The current omap_cpufreq_probe() uses regulator_get() to obtain the MPU
> regulator but does not release it in omap_cpufreq_remove() or when
> cpufreq_register_driver() fails, leading to a potential resource leak.
> 
> Use devm_regulator_get() instead of regulator_get() so that the regulator
> resource is automatically released.
> 
> Fixes: 53dfe8a884e6 ("cpufreq: OMAP: scale voltage along with frequency")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/cpufreq/omap-cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index bbb01d93b54b..f83f85996b36 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -157,7 +157,7 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	mpu_reg = regulator_get(mpu_dev, "vcc");
> +	mpu_reg = devm_regulator_get(mpu_dev, "vcc");
>  	if (IS_ERR(mpu_reg)) {
>  		pr_warn("%s: unable to get MPU regulator\n", __func__);
>  		mpu_reg = NULL;
> @@ -169,7 +169,6 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
>  		if (regulator_get_voltage(mpu_reg) < 0) {
>  			pr_warn("%s: physical regulator not present for MPU\n",
>  				__func__);
> -			regulator_put(mpu_reg);

so it it not useable and could be released which is not done anymare 
with your patch. It is not an error path here.

>  			mpu_reg = NULL;

And this should happen after removal, too. I feel some discomfort with
variables pointing to freed ressources. So I think rather add
the regulator_put and the = NULL to the remove function.

Regards,
Andreas

