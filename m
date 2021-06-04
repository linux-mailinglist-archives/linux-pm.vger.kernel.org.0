Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC83C39BFC1
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 20:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDSid (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 14:38:33 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34549 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFDSic (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 14:38:32 -0400
Received: by mail-pg1-f180.google.com with SMTP id l1so8577908pgm.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NLgF291KbWG0hRpijcDBpXSao5yqOMobtWFivJzcHMg=;
        b=XJjud+Cjc7VhDMPlqqw4ZK6lb6cXU4ZgPI4pOXIz6FtcCH1A0ZSwknFtsKzeoLttKA
         bLOZI1bmnbI2JUFg9mRi9cpQJiLGhVy9qOl3YqpYpVzJ5ZDWwYrwqhL1fJOzHtv4sFXX
         dARDQNXHqMQOQVANwyvEla/hvKQhM15tpIfXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NLgF291KbWG0hRpijcDBpXSao5yqOMobtWFivJzcHMg=;
        b=EQaztbML+ub6FLV4g98/3eXrUEeStgPx1VWICV9g8ck+YZ1+98CUwfjvDO0brsXbZI
         tPCsU+aOtbmV2k4515PH4u7yzAPT6T7Tqkfozts7eoUtw5fdoxC1QJUc/HFKyw5RpeyO
         QOgnXK8LOyeqt8UIHcEM9EN0IzaAX5CFeuyaqWKAsiJtJYdlKi5I+wEBl20YLhw1iG/N
         YkcO2OOyjMROUou/p7AyT+GaVhhDoGPonkI98RYoJyNFaODi2lyYYkHM+rrA43hhBbiI
         mc6JD8pRi6mmOpxEcGf8i3rOnaSsFkpYjNmauKoAooN7lLtmv6wAPCqMyXUYtAdf8/xx
         wF7g==
X-Gm-Message-State: AOAM532ZqNkC1UqolsuRGJoOW2ENTfzGICTNshn6KgpV3jVTpZEihdcS
        zRH4kiKVkXILNw+8L8sVxLBcbA==
X-Google-Smtp-Source: ABdhPJzhVL6dCVntKrHahpJMgtfysVXyEus6VJg5WLnqRGneFwKXgVIj3AYjTslcoM7wj81rDRZb/A==
X-Received: by 2002:aa7:82c6:0:b029:2d8:9160:5942 with SMTP id f6-20020aa782c60000b02902d891605942mr5874213pfn.78.1622831746228;
        Fri, 04 Jun 2021 11:35:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1cfa:4a0b:c513:8c09])
        by smtp.gmail.com with UTF8SMTPSA id p24sm245356pfh.17.2021.06.04.11.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 11:35:45 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:35:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 5/6] cpufreq: Mark inefficient frequencies using the
 Energy Model
Message-ID: <YLpygDPEYVUAjtQg@google.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-6-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622804761-126737-6-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 04, 2021 at 12:06:00PM +0100, Vincent Donnefort wrote:
> The Energy Model has a 1:1 mapping between OPPs and performance states
> (em_perf_state). We can then read which states are inefficient and use this
> information to mark the cpufreq table.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7431f40a..34d344d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -19,6 +19,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/energy_model.h>
>  #include <linux/init.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/module.h>
> @@ -1317,6 +1318,31 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	kfree(policy);
>  }
>  
> +static void cpufreq_inefficiencies_from_em(struct cpufreq_policy *policy,
> +					   struct em_perf_domain *em_pd)
> +{
> +	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
> +	struct em_perf_state *em_table;
> +	int i;
> +
> +	if (!em_pd)
> +		return;
> +
> +	em_table = em_pd->table;
> +
> +	for (i = 0; i < em_pd->nr_perf_states; i++) {
> +		if (!(em_table[i].flags & EM_PERF_STATE_INEFFICIENT))
> +			continue;
> +
> +		cpufreq_for_each_valid_entry(pos, table) {
> +			if (pos->frequency == em_table[i].frequency) {
> +				pos->flags |= CPUFREQ_INEFFICIENT_FREQ;
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>  static int cpufreq_online(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy;
> @@ -1371,6 +1397,12 @@ static int cpufreq_online(unsigned int cpu)
>  			goto out_free_policy;
>  		}
>  
> +		/*
> +		 * Sync potential inefficiencies with an Energy Model that the
> +		 * driver might have registered.
> +		 */
> +		cpufreq_inefficiencies_from_em(policy, em_cpu_get(cpu));
> +
>  		ret = cpufreq_table_validate_and_sort(policy);
>  		if (ret)
>  			goto out_exit_policy;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
