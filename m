Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1FB209CC3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbgFYKXy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403983AbgFYKXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 06:23:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B1C0613ED
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 03:23:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so2829882pfe.4
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aD0Mm08bVawc8uNEZ8jOYlVBKSND1d88I7GODmq3fsk=;
        b=ubk1HqqiONXNwRyZOSAqaegZ688nbffSZAhNPWm5ubGgemju0MhV7Zj+Qw0nPU2Kr4
         ymfAXK71pWR5Q0VooRWKs2fi5wA3sCheKoM7d9I64mgi3UdQEAYRmKhwMGarOGxnJsUv
         5SSUGfPO3q7yVF5xhRnPNvPocbDqKEM2Lp4AZYSSIAJJlgmG4d3nDchw2oncY3HZ9LOR
         4tyxLyAnWh0oWIhRtt9kB2dodpKcxX+zgs5A3B/FYyB8BTPBpQEgdfBW3nMoOsZwoCKr
         /7FSSntstxKukbfkBRLkjswV/ZwYBQ7A8y0mZpDbzrf4Xp9k20mT4GJhbPjc78m3I15a
         LtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aD0Mm08bVawc8uNEZ8jOYlVBKSND1d88I7GODmq3fsk=;
        b=BFpBPUVQ3w/4CCzXZtKqL6CGVLXFny7eo6jP8+BaixjPjxUKJMcFWhZQ+4E+9e4Yd/
         iwb36MbgZqlXaO3gG6uBUPcy7ysXSMvgG6rYBf5F8fiq9M/SSjezslZH1oB7d6B+m4P/
         6P11Pzbc239X4TakU9lZCbU6a3MVgAgF/2w/h8AmxxPtKhIQa+xXraHH4sk2KMBg9uw5
         Rj8HgRIh4RIEKJm4GY/+U5irBVUvJd4vcWLvUjUtyemKtDnZonNTFk3EphxouATDTbqd
         WUs0b/N7DbRm5F02RSY/qNDCt0hXaTvO6lhUWzWwn43xxm2fXrswsZ4xJypBz9vovVAe
         oADg==
X-Gm-Message-State: AOAM530/LTw33PvDBGQ671rHcg6ELuvtWD1lDmQIIwtI2Z7L+/6hrmO1
        gquRtK3npAqmCiTKiN3X8V00nQ==
X-Google-Smtp-Source: ABdhPJz+vvs7ucfRpTcH9x/tx9udaUViA11z9lggnKo40W0iLSSK71beKRar6taPK95ziaUYxrA7rg==
X-Received: by 2002:a63:7f17:: with SMTP id a23mr19440822pgd.3.1593080587955;
        Thu, 25 Jun 2020 03:23:07 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id 4sm19566182pgk.68.2020.06.25.03.23.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 03:23:07 -0700 (PDT)
Date:   Thu, 25 Jun 2020 15:53:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, dsmythies@telus.net,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: force frequency update when limits
 change
Message-ID: <20200625102305.gu3xo4ovcqyd35vd@vireshk-i7>
References: <20200625064614.101183-1-wvw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625064614.101183-1-wvw@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-06-20, 23:46, Wei Wang wrote:
> To avoid reducing the frequency of a CPU prematurely, we skip reducing
> the frequency if the CPU had been busy recently.
> 
> This should not be done when the limits of the policy are changed, for
> example due to thermal throttling. We should always get the frequency
> within the new limits as soon as possible.
> 
> There was a fix in
> commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when
> limits change") upstream which introduced another flag. However, the
> fix didn't address the case when next_freq is the same as previously
> voted, which is then checked in sugov_update_next_freq. As a result, the
> frequency would be stuck at low until the high demanding workload quits.
> 
> test trace:
>   kworker/u19:0-1872  ( 1872) [002] ....   347.878871: cpu_frequency_limits: min=600000 max=2348000 cpu_id=6
>          dhry64-11525 (11525) [007] d.h2   347.880012: sugov_should_update_freq: thermal limit on policy6
>          dhry64-11525 (11525) [007] d.h2   347.880012: sugov_deferred_update: policy6 skipped update
>          dhry64-11525 (11525) [007] d.h2   347.884040: sugov_deferred_update: policy6 skipped update

I am not sure these are helpful in the logs as the code which
generated them isn't there in the kernel.

> ...
> 
> This patch fixes this by skipping the check and forcing an update in
> this case. The second flag was kept as the limits_change flag could be
> updated in thermal kworker from another CPU.

I am sorry but I am not fully sure of what the problem is. Can you
describe that by giving an example with some random frequency, and
tell the expected and actual behavior ?

> Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7fbaee24c824..dc2cd768022e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -102,11 +102,12 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>  				   unsigned int next_freq)
>  {
> -	if (sg_policy->next_freq == next_freq)
> +	if (!sg_policy->need_freq_update && sg_policy->next_freq == next_freq)

AFAIU, if the next freq is same as currently programmed one, there is
no need to force update it.

>  		return false;
>  
>  	sg_policy->next_freq = next_freq;
>  	sg_policy->last_freq_update_time = time;
> +	sg_policy->need_freq_update = false;
>  
>  	return true;
>  }
> @@ -178,7 +179,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;
>  
> -	sg_policy->need_freq_update = false;
>  	sg_policy->cached_raw_freq = freq;
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
> -- 
> 2.27.0.212.ge8ba1cc988-goog

-- 
viresh
