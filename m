Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2279839BF78
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 20:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDSVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 14:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDSVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 14:21:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCBAC061766
        for <linux-pm@vger.kernel.org>; Fri,  4 Jun 2021 11:19:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i22so6042514pju.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpdYVS4AV0ANUonJf8I8PDyBYj43aT66sBD6UzFfXmY=;
        b=HXBsQsvmUJL6h6TSKlmix3duwp540vhnd5EN4qEVUGMAMBX2mVYjV6sbYvpkcezjoE
         SRogUdfoNj3VW0parGdXRBOk4a/+/eFbKLsaJFYg18yWOsBhDv0EPuHrwHfaYDglvbxh
         MTx6OaCFP4sHaY+mn+S4MrdKWpH/pUFXPvVxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpdYVS4AV0ANUonJf8I8PDyBYj43aT66sBD6UzFfXmY=;
        b=PYrRHouR3DxDO3HNA4J6s9JOuQkLLZWz06/COn9toH1xxuo49w+j3for6cPrOGwysI
         ib/g7Oa94vFDzhbgfxtn1Ld/PqGZFMYAOaTXBZrYsXKoZLwfHhNlkhcIwJLU6tYvdreE
         1Rm4asv58O/QFzDU+KyXtF5EQ4vuDkI5GcQHVZGgI7FvwI/GGkNHFFL+4+LSfU1gR6c/
         JUrxjr/H2xIzNGdX6U/cE81lYUA/c87UyG3BBVyYKvZlcBgCXKg3mxFUTfp8QW/Hg/gB
         BvEHljl9jevmOjv9/6noBFKv5cMLOzQGYlr+U92RAlYefAPVhKJ38Z1WpLmHc560tNqh
         H/mg==
X-Gm-Message-State: AOAM530KHtQm+xR7lj/9+fRfhg/Mjci3+1ZSe7IDCiUutwr6WhjHb5yM
        Q+t6NJws8KHiQleg2zq1m8tW5w==
X-Google-Smtp-Source: ABdhPJy537fqH3R6AElwN18HlxyJO8DSm4eNfNmNW0CaMZUjDeNghRj1wHjYvc4cSL2rDrx7KDUDjw==
X-Received: by 2002:a17:902:e04f:b029:eb:66b0:6d08 with SMTP id x15-20020a170902e04fb02900eb66b06d08mr5586904plx.50.1622830777641;
        Fri, 04 Jun 2021 11:19:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1cfa:4a0b:c513:8c09])
        by smtp.gmail.com with UTF8SMTPSA id w1sm2365427pfi.162.2021.06.04.11.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 11:19:37 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:19:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <YLput6k5NIJKsy6v@google.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 04, 2021 at 12:05:58PM +0100, Vincent Donnefort wrote:
> Some SoCs such as the sd855 have OPPs within the same policy whose cost is
> higher than others with a higher frequency. Those OPPs are inefficients and
> it might be interesting for a governor to not use them.
> 
> Adding a flag, CPUFREQ_INEFFICIENT_FREQ, to mark such OPPs into the
> frequency table, as well as a new cpufreq_frequency_table member
> "efficient". This new member will allow a governor to quickly resolve an
> inefficient frequency to an efficient one.
> 
> Efficient OPPs point to themselves. Governors must also ensure that the
> efficiency resolution does not break the policy maximum.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 67e56cf..0756d7d6 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -351,6 +351,53 @@ static int set_freq_table_sorted(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static void set_freq_table_efficiencies(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
> +	enum cpufreq_table_sorting sort = policy->freq_table_sorted;
> +	int efficient, idx;
> +
> +	/* Not supported */
> +	if (sort == CPUFREQ_TABLE_UNSORTED) {
> +		cpufreq_for_each_entry_idx(pos, table, idx)
> +			pos->efficient = idx;
> +		return;
> +	}
> +
> +	/* The highest frequency is always efficient */
> +	cpufreq_for_each_entry_idx(pos, table, idx) {
> +		if (pos->frequency == CPUFREQ_ENTRY_INVALID)
> +			continue;
> +
> +		efficient = idx;
> +
> +		if (sort == CPUFREQ_TABLE_SORTED_DESCENDING)
> +			break;
> +	}
> +
> +	for (;;) {
> +		pos = &table[idx];
> +
> +		if (pos->frequency == CPUFREQ_ENTRY_INVALID)
> +			continue;

That would result in an infinite loop, you still want to execute the code
at the bottom of the loop which increments/decrements 'idx' and exits the
loop when the end of the table is reached.

> +
> +		if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
> +			pos->efficient = efficient;
> +		} else {
> +			pos->efficient = idx;
> +			efficient = idx;
> +		}
> +
> +		if (sort == CPUFREQ_TABLE_SORTED_ASCENDING) {
> +			if (--idx < 0)
> +				break;
> +		} else {
> +			if (table[++idx].frequency == CPUFREQ_TABLE_END)
> +				break;
> +		}
> +	}
> +}
> +
>  int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -362,7 +409,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
>  	if (ret)
>  		return ret;
>  
> -	return set_freq_table_sorted(policy);
> +	ret = set_freq_table_sorted(policy);
> +	if (ret)
> +		return ret;
> +
> +	set_freq_table_efficiencies(policy);
> +
> +	return ret;
>  }
>  
>  MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 353969c..d10784c 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -666,13 +666,15 @@ struct governor_attr {
>  #define CPUFREQ_ENTRY_INVALID	~0u
>  #define CPUFREQ_TABLE_END	~1u
>  /* Special Values of .flags field */
> -#define CPUFREQ_BOOST_FREQ	(1 << 0)
> +#define CPUFREQ_BOOST_FREQ	 (1 << 0)
> +#define CPUFREQ_INEFFICIENT_FREQ (1 << 1)
>  
>  struct cpufreq_frequency_table {
>  	unsigned int	flags;
>  	unsigned int	driver_data; /* driver specific data, not used by core */
>  	unsigned int	frequency; /* kHz - doesn't need to be in ascending
>  				    * order */
> +	unsigned int	efficient; /* idx of an efficient frequency */
>  };
>  
>  #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
> -- 
> 2.7.4
> 
