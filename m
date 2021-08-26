Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F5B3F84F0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 11:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbhHZKAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbhHZKAg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 06:00:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56FC061757
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 02:59:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c4so1473743plh.7
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rY/3kBCJD17gVbkRD3rlb89sqRjlYduPkTDJybPXGKM=;
        b=AIoU8rd/hUkgLJUMx7k6ztGarFuyNZyYN7Ic5MgXL6yQLDJ4dgO4de5Sskvj084Gg1
         VdYk7KtWmTqjN/jY8p+lgnpas7+pjcP8rtCW48c7ahkJf0+hfEIPq3/5lr/0Abz/AuTB
         gwWx2PlMtU6/mOi6OXYWln8P/z/t2fHEpPVhAzyHNx4BnorewHs71F+CNUwx8J/bqldQ
         OcAMTU7BvAX5xphKE7u+c5oV8UWs5MdgTdieT/ZoMA2rNb0cb0e7nArzh5UZIlrI71jd
         xzWKxLtdRH7UIN32sai8QL43vW7gjRF5SeVxDb8bqVbhRPGBlL5E73bFUf9uK1eCTR4e
         ADTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rY/3kBCJD17gVbkRD3rlb89sqRjlYduPkTDJybPXGKM=;
        b=cY+3WpXvJ++5e4rdDISo8Sx6p/mmhWsIloIOcF5syT/vart1QIoEv8FxvhIISP6I3O
         DL97taFlVXuWv7KjD4Br5sOccJghU08VBl/At8J+7J+rnevKFgjKhYmCz+NIn3U5SWr7
         XcYJsDyHDABOyEgNWfaAVn+0ugFdWBpkSrHf29iVbbqh8gLyac29qjBDv/VDxR4y4rnT
         63KBueKdqvcKYC4/Xqa2hJBbhtHMPXN28hJ175VrswXCMqgPpjWFt14DvjhoKn5VhwAd
         /vJgZyZRLGCGCA3GNpv4KLacxAawLwRUwo1ux3AjE4tpAJAKoWlaNci/JEzXybsQRUOC
         yaCw==
X-Gm-Message-State: AOAM531jeamzeCmHi4JtkiY1jdO7YQ5oBXVGOl1AaJVwJBnprNfaMd1v
        f912wNr4dtvS1cgi5d1+OIXGvhwj/XbIjQ==
X-Google-Smtp-Source: ABdhPJwJkYnI7Go5FggtK65SxzGdTfBAiGk8wlgfmXGo3wvyZVkXF+ApJnFu712SI/VOzOARczXCkg==
X-Received: by 2002:a17:90a:6a01:: with SMTP id t1mr3393919pjj.31.1629971988527;
        Thu, 26 Aug 2021 02:59:48 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z67sm2466457pfb.169.2021.08.26.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:59:48 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:29:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH v5 7/8] cpufreq: Read inefficiencies from EM
Message-ID: <20210826095946.qnkt6bvvf6frdijn@vireshk-i7>
References: <1629966944-439570-1-git-send-email-vincent.donnefort@arm.com>
 <1629966944-439570-8-git-send-email-vincent.donnefort@arm.com>
 <20210826094649.y3fuohsjlc4c7ada@vireshk-i7>
 <20210826095459.GA443176@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826095459.GA443176@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-08-21, 10:54, Vincent Donnefort wrote:
> On Thu, Aug 26, 2021 at 03:16:49PM +0530, Viresh Kumar wrote:
> > On 26-08-21, 09:35, Vincent Donnefort wrote:
> > > The Energy Model has a 1:1 mapping between OPPs and performance states
> > > (em_perf_state). If a CPUFreq driver registers an Energy Model,
> > > inefficiencies found by the latter can be applied to CPUFreq.
> > > 
> > > This applies to all drivers using the generic callback
> > > cpufreq_register_em_with_opp() for .register_em.
> > > 
> > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > > 
> > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > index 2554dd1ec09d..50bf38ea2539 100644
> > > --- a/include/linux/cpufreq.h
> > > +++ b/include/linux/cpufreq.h
> > > @@ -1104,9 +1104,38 @@ void cpufreq_generic_init(struct cpufreq_policy *policy,
> > >  		struct cpufreq_frequency_table *table,
> > >  		unsigned int transition_latency);
> > >  
> > > +static inline void
> > > +cpufreq_read_inefficiencies_from_em(struct cpufreq_policy *policy,
> > > +				    struct em_perf_domain *em_pd)
> > > +{
> > > +	struct em_perf_state *em_table;
> > > +	int i;
> > > +
> > > +	if (!em_pd)
> > > +		return;
> > > +
> > > +	/* Inefficiencies support needs a sorted table */
> > > +	if (!policy->freq_table ||
> > > +	    policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)
> > > +		return;
> > > +
> > > +	em_table = em_pd->table;
> > > +
> > > +	for (i = 0; i < em_pd->nr_perf_states; i++) {
> > > +		if (!(em_table[i].flags & EM_PERF_STATE_INEFFICIENT))
> > > +			continue;
> > > +
> > > +		cpufreq_table_set_inefficient(policy,
> > > +					      em_table[i].frequency);
> > > +		em_pd->flags |= EM_PERF_DOMAIN_SKIP_INEFFICIENCIES;
> > > +	}
> > > +}
> > > +
> > >  static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
> > >  {
> > > -	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
> > > -				  policy->related_cpus);
> > > +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> > > +
> > > +	dev_pm_opp_of_register_em(cpu_dev, policy->related_cpus);
> > > +	cpufreq_read_inefficiencies_from_em(policy, em_pd_get(cpu_dev));
> > 
> > This should happen from em_dev_register_perf_domain() instead of here.
> 
> Shall we then let em_dev_register_perf_domain() call
> cpufreq_table_update_efficiencies() too?

It should be better IMO, instead of hardcoding it in cpufreq_online(). This also
allows the same to be done irrespective of the initialization order of the
policy. i.e. some other framework can call it at a later point as well, not just
at the beginning.

> The complete interface for ineffiencies in CPUfreq would then be:
> 
>  1. Mark a frequency as inefficient with cpufreq_table_set_inefficient()
>  2. Update the table with cpufreq_table_update_efficiencies() 

Yeah, it will just provide the helpers.

-- 
viresh
