Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BD43F84BB
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 11:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhHZJrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 05:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhHZJri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 05:47:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC2C061757
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 02:46:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j187so2299018pfg.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMzukFENIUtmqtYvy01dGTBsSM9VMnHek1CqmZco4MI=;
        b=URej3oUZ6sJJJkwF8BxfMPmhUSuJORzCQlSUnku/cpy4oly8aBKxYRWkGmGKOvYn9o
         4XmTfzcDgjap9ON9Zua7wQHhfSsTmUwCmBG/tzPGgVIiIdUt5UfwE0Km3uYgSbVtJnXg
         TJZMIp3htCB61RWRi6LD+KdSyeAVWdykY68rbZ6HTbdi0AgjdyMT/m+g1t6gV+Lty4y1
         VleFpgI2KT+a+rIt1i2Lw0Ec6RZzg5s8L4Wah6rNEJmLYgM7AOxPfJQ5He//Ezw5ah7q
         pR9TrOWC7xM9AxVAhuP3MYIlwLFkEVIhTZk5mVGF6Sdfci3xknigssKyPN3jCw4ZfMLO
         SjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMzukFENIUtmqtYvy01dGTBsSM9VMnHek1CqmZco4MI=;
        b=l9TkYQhMLNXY4PUQCqC4rAFyCTasLFVj2KamohuuuElTwa+6bLvFLcUw+brO/DGvd6
         w726+oJ+4gXQYrkrVCN5pyzjIpLFtv5yzsaUYSBpAIdhTjF2R8QGTENufwtHTpWrMoEA
         e/lNOksawmwSvbFDJNVAuuKrJgo9Pe1S2kqb62rysLm85Xyo6onbNhmGcEhul95myvHJ
         KkSDttwqWEmH5CadO0hHC1ditfby5VjBRDigSXosoQgt1pxxejTd2Vdy6XkXgvO13r1v
         8/fpKQNaw69XctNSjpM7swXpgVLbBN4DalmzfrogRzuCO31OyJt7bI7mhdoU4zHjyBh9
         gsHQ==
X-Gm-Message-State: AOAM533UprQAaO16Dzi5675FGq1Fwi1iVxav23kE2zp1Ox/1DLxyhZvg
        V4j4q6dLuIr/+fT8yhuoHBg9nw==
X-Google-Smtp-Source: ABdhPJw+4m25XrW8q3sgFl4T+RprGiUS4yJl3IkQza8KOExsD1lQAPASG9pJzloAblKV+JqrT1Eswg==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr2571736pgb.127.1629971211471;
        Thu, 26 Aug 2021 02:46:51 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id u10sm2328227pfg.168.2021.08.26.02.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:46:51 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:16:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH v5 7/8] cpufreq: Read inefficiencies from EM
Message-ID: <20210826094649.y3fuohsjlc4c7ada@vireshk-i7>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
 <1629966944-439570-8-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629966944-439570-8-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-21, 09:35, Vincent Donnefort wrote:
> The Energy Model has a 1:1 mapping between OPPs and performance states
> (em_perf_state). If a CPUFreq driver registers an Energy Model,
> inefficiencies found by the latter can be applied to CPUFreq.
> 
> This applies to all drivers using the generic callback
> cpufreq_register_em_with_opp() for .register_em.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 2554dd1ec09d..50bf38ea2539 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1104,9 +1104,38 @@ void cpufreq_generic_init(struct cpufreq_policy *policy,
>  		struct cpufreq_frequency_table *table,
>  		unsigned int transition_latency);
>  
> +static inline void
> +cpufreq_read_inefficiencies_from_em(struct cpufreq_policy *policy,
> +				    struct em_perf_domain *em_pd)
> +{
> +	struct em_perf_state *em_table;
> +	int i;
> +
> +	if (!em_pd)
> +		return;
> +
> +	/* Inefficiencies support needs a sorted table */
> +	if (!policy->freq_table ||
> +	    policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)
> +		return;
> +
> +	em_table = em_pd->table;
> +
> +	for (i = 0; i < em_pd->nr_perf_states; i++) {
> +		if (!(em_table[i].flags & EM_PERF_STATE_INEFFICIENT))
> +			continue;
> +
> +		cpufreq_table_set_inefficient(policy,
> +					      em_table[i].frequency);
> +		em_pd->flags |= EM_PERF_DOMAIN_SKIP_INEFFICIENCIES;
> +	}
> +}
> +
>  static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
>  {
> -	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
> -				  policy->related_cpus);
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +
> +	dev_pm_opp_of_register_em(cpu_dev, policy->related_cpus);
> +	cpufreq_read_inefficiencies_from_em(policy, em_pd_get(cpu_dev));

This should happen from em_dev_register_perf_domain() instead of here.

>  }
>  #endif /* _LINUX_CPUFREQ_H */
> -- 
> 2.7.4

-- 
viresh
