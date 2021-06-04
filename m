Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F32239BFDD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 20:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDSvJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDSvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 14:51:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E45C061766
        for <linux-pm@vger.kernel.org>; Fri,  4 Jun 2021 11:49:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f22so8154964pfn.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pmAWoxDVmOjcH5BWUa9AdLrmHMa5aJ0HrXCEveRGJQ4=;
        b=ReTe0qhEP8InmXwnFN1ZPE3OeN3v2JNZYpwq8MA/0HB8tEGmr3vLdOOocAycnP6W1q
         /OtagFivg2nUiUCSXwwTYKmwfL6iEX4cIs5s6vQvV5h4pmeDfDrVRR/y9W/kwEX1ptEv
         Ox3A4AY8Ell5LpF42LtVqsgaPy3upJ5KozQqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pmAWoxDVmOjcH5BWUa9AdLrmHMa5aJ0HrXCEveRGJQ4=;
        b=K9j3WKYid48d8ysDpRL/0CMrVudYY4BmAO7HHDLOOm/JH/N7qDnNMSTef+BkNWm9IS
         ZvhpPboydYks9Yq3Rr53quyJEbUgX/Vlxs084wte0pFNw98xnGEaRRZIIiWAp4mmtkd7
         BJEvK4O1RhXuDvYMiVpNfphQYjt0MvJkbXTp/nzF4pIeB4rLF/CWtNE3rWc7/1ggV7sE
         Rn2YcTbz5iugqOYw02pDYxFhVf3io/D8f+ayFyqQRLXfdiuxBBan96mv2Xvk9TL2BGkF
         R3YKpwPQcgLKPTO5Rgy6Ssw9ooXQNuDIqRVQhQ2fNKbg6ulOHb3sqDs9mF6i4x8WQSmV
         /ecw==
X-Gm-Message-State: AOAM530jW38gaB7KHc+c6cE/+VDGaabsx05tAH6YUq9b/3PZTa/MBwtY
        9VcxON2bSAd52nYSndARMsiOpQ==
X-Google-Smtp-Source: ABdhPJxwelmnWBj0BBoECzL7hgbH72SAH0EfgR7I1+74ntRyS81d1eaXALvyGks5P/+LRExvpmef7A==
X-Received: by 2002:a05:6a00:be6:b029:2ec:967c:137b with SMTP id x38-20020a056a000be6b02902ec967c137bmr3389266pfu.44.1622832562418;
        Fri, 04 Jun 2021 11:49:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1cfa:4a0b:c513:8c09])
        by smtp.gmail.com with UTF8SMTPSA id l70sm2758659pgd.20.2021.06.04.11.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 11:49:22 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:49:20 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 6/6] PM / EM: Skip inefficient states
Message-ID: <YLp1sMPRRNG+m1sR@google.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-7-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622804761-126737-7-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 04, 2021 at 12:06:01PM +0100, Vincent Donnefort wrote:
> Now that Schedutil can leverage the inefficiency identification from the
> Energy Model, we can skip inefficient states when estimating the energy
> consumption.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 2531325..d20f6afe 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -98,6 +98,36 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  void em_dev_unregister_perf_domain(struct device *dev);
>  
>  /**
> + * em_pd_get_efficient_state() - Get an efficient performance state from the EM
> + * @pd   : Performance domain for which we want an efficient frequency
> + * @freq : Frequency to map with the EM
> + *
> + * It is called from the scheduler code quite frequently and as a consequence
> + * doesn't implement any check.
> + *
> + * Return: An efficient performance state, high enough to meet @freq
> + * requirement.
> + */
> +static inline
> +struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> +						unsigned long freq)
> +{
> +	struct em_perf_state *ps;
> +	int i;
> +
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +		ps = &pd->table[i];
> +		if (ps->frequency >= freq) {
> +			if (ps->flags & EM_PERF_STATE_INEFFICIENT)
> +				continue;
> +			break;
> +		}
> +	}
> +
> +	return ps;
> +}
> +
> +/**
>   * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
>  		performance domain
>   * @pd		: performance domain for which energy has to be estimated
> @@ -116,7 +146,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  {
>  	unsigned long freq, scale_cpu;
>  	struct em_perf_state *ps;
> -	int i, cpu;
> +	int cpu;
>  
>  	if (!sum_util)
>  		return 0;
> @@ -135,11 +165,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	 * Find the lowest performance state of the Energy Model above the
>  	 * requested frequency.
>  	 */
> -	for (i = 0; i < pd->nr_perf_states; i++) {
> -		ps = &pd->table[i];
> -		if (ps->frequency >= freq)
> -			break;
> -	}
> +	ps = em_pd_get_efficient_state(pd, freq);
>  
>  	/*
>  	 * The capacity of a CPU in the domain at the performance state (ps)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
