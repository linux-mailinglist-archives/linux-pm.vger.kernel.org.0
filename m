Return-Path: <linux-pm+bounces-40253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E4FCF6B09
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 05:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2397302E734
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 04:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBF129ACDD;
	Tue,  6 Jan 2026 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlG+w4eZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676912989B5
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767675060; cv=none; b=juT7GP9+8ZydqS6+AZNZyPs5l+m4eVWH4REf9GwbFjFhHhNli99Emo/YayKSi7/GUxryvD2SsVuiX0TeP60njP2LVINwK2YoxK5NS2aUEGmny5MSsIL97bTaONWAHyiqZdKOHyN/x9WvDMziUNwoQFavdPTJdAI2DOvDi5C/50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767675060; c=relaxed/simple;
	bh=zjPYNxmajYhPjKoIJvB+R6amUBX67WJmtLEqSSOw3Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+ARSSu9Zzn/+HwQo/Ld96epSKRgLRKcODRklaSZzCseusIOXtvUDZgyN/HP/XTHb6bmEzNzA9f2/iZl+5H8yNPJjLcZ+tbb0T5nyREeT/zjDeI5i6Htt0gVBB39gF9oXTMjgUP5W2bc7rrLlMex14GSOog1K7n/snaVc8QX4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xlG+w4eZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0c09bb78cso4457165ad.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 20:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767675058; x=1768279858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcnSq5Vqa7AfaoyvtTG5pEljQPUW2tYZ/qgiGvVC63k=;
        b=xlG+w4eZxAI/K/Qa2vCnK0qHGY0ySs01skO8P9WGLaes58pcYQxJCEXVlogPhHWKSi
         oFb4+3CSlDXSxnYRQ72aEDsvqJYXGiCHizzHDvenYjK7U87BtwVK2wsuDzOLksxo9Jnp
         09tXhXc102LafmNqRcyRg6Y+9PKijhBywPL7rYvwSdt+Hn/eTnFo5qntAZeNaZVWme5/
         I7satgoOSQ6Qj26LXev59XZb3WapbciO9v6/gMfQ/LcNhRYlOjsnwIWocaRJQQsT+Jty
         Cij4CvQ+t3kiFL7eFo0NIsDtCSQXra7BluROCapBKZk0E08gZASWQoSZxrlnTMLBdCgh
         +k4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767675058; x=1768279858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcnSq5Vqa7AfaoyvtTG5pEljQPUW2tYZ/qgiGvVC63k=;
        b=oZJOJ5d4xf/9lgL0FeGGcDsmeLNGjjg/SR6MXN2yXfMnbG8y9igK6/gaGp/Y+HJ13f
         RikUADoSc/v6XClqFUtzOuOSw6cafsBiOnxf9O0Z/GkiuOjGfBx16rXTfaJrmwkq312G
         hMDwniG8jI8K10w87lwjJPQ3I6OHsimheKzcEGnRZkmAH2RTdiuVVeWrojO22NCHE8Re
         CDeyDyM6XekUgdaqIhLs8txXY3Ne9qQHCVVYWF3fzRDJiCiDZY+Hwf3C+5ymlHhK0T0F
         QOi2A0WeCKDC7jUZfAC4n4+7O1rCJOgNhXVpXT/Uj/s5FTnf8r+gc4T6nrize6X+rOTr
         +6xA==
X-Forwarded-Encrypted: i=1; AJvYcCUDkEYeQNT1PSEJ7Oqhrki0rjWF5E6KGblwoKyUUjYqCn2mfvus6XLBzyR8xag6FSbwzJOodhGM6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKpCdl1hs0nc6BKi386uUtdM37dHaIGJ5/c8oewwAhNPTWS+IB
	Kv6RwyszqAHx+hFEShmnK8G8tzY4zrOtYSXQPR9bwoNf894Su4bs8ePGDi/zGs3cIy8=
X-Gm-Gg: AY/fxX4r1FvADZV729tCQvTIABRRHyzrbLpfRBv8YrccWOCClHgKd6OlNdEirIXjcUu
	dPw9OSHYfM0CeFu5cTO42HL/jNq/ltwL1Bwi4MZlrLM9N4qZqzGWLYM5HslETPJj1gLT1Lst3x4
	I8ZWeL7A8/H8KqNxx1tCPlkFFMX3GQ3anjTK3/NjfvngjggUbP16o/h+Nh41x5N+sU/Fg436Bk+
	wqYp4h3TNPjDtwKueAju183/PMQAF6F+OEmjAGheWBBaDEDaa59U66O1fBiEoVBS/C3CLcbQxif
	Zv/OcKiyzw8aCZmaZL1xO1PsbmRauSLMg/eGZqyUC5hQD+0oDHaR6kjQ9SLI8/Ftky1KKm51JOu
	TBUPG65uVn4stCg3A9+kcVc7A5KkoUtKGvTddYAPDjdBB9Lj0n6h0/OWIXt3QnMGMbbpfmVLxPk
	MAzgsKtmzFsr4=
X-Google-Smtp-Source: AGHT+IG8vnLNY1Up4XLJ+SVzG/80508CQ1sd1KLx54kwlP44pxp6uMDJfK5DN9N2AoiAWanRJhnlNw==
X-Received: by 2002:a17:903:1967:b0:29f:175b:1ec7 with SMTP id d9443c01a7336-2a3e39baff0mr14097735ad.16.1767675058282;
        Mon, 05 Jan 2026 20:50:58 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48be5sm7686555ad.30.2026.01.05.20.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 20:50:57 -0800 (PST)
Date: Tue, 6 Jan 2026 10:20:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, Kevin Hilman <khilman@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap-cpufreq: Fix regulator resource leak in probe()
Message-ID: <pjmwnxp6wae3bbmzmzys4r5szw6ywxphi4qtmpmg7jsqadc5fm@fvozoujr4mi5>
References: <20251215030327.1771-1-vulab@iscas.ac.cn>
 <20260105101412.0ac7baa7@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105101412.0ac7baa7@kemnade.info>

On 05-01-26, 10:14, Andreas Kemnade wrote:
> On Mon, 15 Dec 2025 11:03:27 +0800
> Haotian Zhang <vulab@iscas.ac.cn> wrote:
> 
> > The current omap_cpufreq_probe() uses regulator_get() to obtain the MPU
> > regulator but does not release it in omap_cpufreq_remove() or when
> > cpufreq_register_driver() fails, leading to a potential resource leak.
> > 
> > Use devm_regulator_get() instead of regulator_get() so that the regulator
> > resource is automatically released.
> > 
> > Fixes: 53dfe8a884e6 ("cpufreq: OMAP: scale voltage along with frequency")
> > Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> > ---
> >  drivers/cpufreq/omap-cpufreq.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> > index bbb01d93b54b..f83f85996b36 100644
> > --- a/drivers/cpufreq/omap-cpufreq.c
> > +++ b/drivers/cpufreq/omap-cpufreq.c
> > @@ -157,7 +157,7 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	mpu_reg = regulator_get(mpu_dev, "vcc");
> > +	mpu_reg = devm_regulator_get(mpu_dev, "vcc");
> >  	if (IS_ERR(mpu_reg)) {
> >  		pr_warn("%s: unable to get MPU regulator\n", __func__);
> >  		mpu_reg = NULL;
> > @@ -169,7 +169,6 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
> >  		if (regulator_get_voltage(mpu_reg) < 0) {
> >  			pr_warn("%s: physical regulator not present for MPU\n",
> >  				__func__);
> > -			regulator_put(mpu_reg);
> 
> so it it not useable and could be released which is not done anymare 
> with your patch. It is not an error path here.

Right. Perhaps devm_regulator_put() here would be good enough.

> >  			mpu_reg = NULL;
> 
> And this should happen after removal, too. I feel some discomfort with
> variables pointing to freed ressources. So I think rather add
> the regulator_put and the = NULL to the remove function.

I don't see a reason why this extra step should be performed after the driver is
removed. `mpu_reg` can't be used after that.

-- 
viresh

