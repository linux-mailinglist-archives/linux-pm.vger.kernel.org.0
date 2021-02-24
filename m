Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B89323724
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 07:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhBXGIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 01:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhBXGIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 01:08:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05157C061574;
        Tue, 23 Feb 2021 22:08:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k22so560862pll.6;
        Tue, 23 Feb 2021 22:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQ8HmhyVFRIgPGngY6Pdp4TolEjCuBVV8yWklhP2kzU=;
        b=QXLPiB/CEJBl20yQPUpotoyUi8Vybv36BXrZmOY4KiZmW94l0Jlw5by4IlvPYjsaO4
         W7pGfd1AI8lE5x535fmCVT+SeHh/ngaE5Tc0kl0aQg0mcloKM5gGzzAdfzE6ZT9Ar0lG
         ZECgbBLxscLzGFVNEG7mwacERo4LwQaT1ff9MDmO6TrQNOr0LaZslPGKTGVAh1lY+1ok
         J4Wc2Paw6elSMnsuz/tor/B/VuP8yWwrfm4J3y+Fipp/cMziWfqQsOrpK0fcUyTjUdNh
         /zVieSjXUfDSlMmxvdrG75eJQabcYJ3L2m65S2EkCudJH5D+CsCAPaaPYRAX0STdXuVV
         I6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQ8HmhyVFRIgPGngY6Pdp4TolEjCuBVV8yWklhP2kzU=;
        b=SYcPvslHKpGNEdTMuBJdtrvCKuYbGuS3IiDuVYIQOg2/shJSL7rhCN4lUhDcyZnPCZ
         JB9w60Rgg+FAN5Z0ekiIdAEhH3MXBW34NpZ6H/J7cgUUonyDlHrGsZPvL1Ufw73eygrM
         9Jbokf+xpZC2duwOnOZZGHRlLWJB764HgjQF8eQADIjx1XXnB2THW2aOQWbAZ/CcA7bL
         d8EY4lxvEQ7fndn63fABgRc06NzN2U46quIBGEHk4SwWCbThNnE8F0JuYgKE6UNjW+WH
         TyagpVJRdIQlVa7P+avoiMZ88qYb4vIjaybc6xYhgzI1kuftJJF1kG7ntdbue+2NnSTu
         Pcjw==
X-Gm-Message-State: AOAM530oonp7fC11VeqZyeqCsSenJmZdcNvGTzuEgzosLKKeU5M7sdC3
        8vB7PzsGMimqGAYGmjOvT4c=
X-Google-Smtp-Source: ABdhPJwYJzqGk7NVC/ovE0T0od48YMxevDn2pNwtPmDA6rXx4re11pKNJUReckisPvJKl+oC22errA==
X-Received: by 2002:a17:902:b68f:b029:e3:b18:7a48 with SMTP id c15-20020a170902b68fb02900e30b187a48mr31138371pls.65.1614146881539;
        Tue, 23 Feb 2021 22:08:01 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id z11sm851514pgk.65.2021.02.23.22.07.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Feb 2021 22:08:01 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:07:50 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Call sugov_update_next_freq()
 before check to fast_switch_enabled
Message-ID: <20210224140750.00004e38.zbestahu@gmail.com>
In-Reply-To: <20210224060236.xaviwqfsujjvwnne@vireshk-i7>
References: <20210224054232.1222-1-zbestahu@gmail.com>
        <20210224060236.xaviwqfsujjvwnne@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Feb 2021 11:32:36 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 24-02-21, 13:42, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Note that sugov_update_next_freq() may return false, that means the
> > caller sugov_fast_switch() will do nothing except fast switch check.
> > 
> > Similarly, sugov_deferred_update() also has unnecessary operations
> > of raw_spin_{lock,unlock} in sugov_update_single_freq() for that case.
> > 
> > So, let's call sugov_update_next_freq() before the fast switch check
> > to avoid unnecessary behaviors above. Update the related interface
> > definitions accordingly.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 41e498b..d23e5be 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -114,19 +114,13 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >  	return true;
> >  }
> >  
> > -static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> > -			      unsigned int next_freq)
> > +static void sugov_fast_switch(struct sugov_policy *sg_policy, unsigned int next_freq)
> >  {
> > -	if (sugov_update_next_freq(sg_policy, time, next_freq))
> > -		cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> > +	cpufreq_driver_fast_switch(sg_policy->policy, next_freq);  
> 
> I will call this directly instead, no need of the wrapper anymore.

To fix it in next version.

Thank you.

> 
> >  }
> >  
> > -static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> > -				  unsigned int next_freq)
> > +static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >  {
> > -	if (!sugov_update_next_freq(sg_policy, time, next_freq))
> > -		return;
> > -
> >  	if (!sg_policy->work_in_progress) {
> >  		sg_policy->work_in_progress = true;
> >  		irq_work_queue(&sg_policy->irq_work);
> > @@ -368,16 +362,19 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> >  		sg_policy->cached_raw_freq = cached_freq;
> >  	}
> >  
> > +	if (!sugov_update_next_freq(sg_policy, time, next_f))
> > +		return;
> > +
> >  	/*
> >  	 * This code runs under rq->lock for the target CPU, so it won't run
> >  	 * concurrently on two different CPUs for the same target and it is not
> >  	 * necessary to acquire the lock in the fast switch case.
> >  	 */
> >  	if (sg_policy->policy->fast_switch_enabled) {
> > -		sugov_fast_switch(sg_policy, time, next_f);
> > +		sugov_fast_switch(sg_policy, next_f);
> >  	} else {
> >  		raw_spin_lock(&sg_policy->update_lock);
> > -		sugov_deferred_update(sg_policy, time, next_f);
> > +		sugov_deferred_update(sg_policy);
> >  		raw_spin_unlock(&sg_policy->update_lock);
> >  	}
> >  }
> > @@ -456,12 +453,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> >  	if (sugov_should_update_freq(sg_policy, time)) {
> >  		next_f = sugov_next_freq_shared(sg_cpu, time);
> >  
> > +		if (!sugov_update_next_freq(sg_policy, time, next_f))
> > +			goto unlock;
> > +
> >  		if (sg_policy->policy->fast_switch_enabled)
> > -			sugov_fast_switch(sg_policy, time, next_f);
> > +			sugov_fast_switch(sg_policy, next_f);
> >  		else
> > -			sugov_deferred_update(sg_policy, time, next_f);
> > +			sugov_deferred_update(sg_policy);
> >  	}
> > -
> > +unlock:
> >  	raw_spin_unlock(&sg_policy->update_lock);
> >  }  
> 

