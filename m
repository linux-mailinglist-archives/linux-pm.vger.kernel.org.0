Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4829EA73
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 12:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgJ2L0a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2L03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 07:26:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8777AC0613D2
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 04:26:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so2068816pfa.9
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=khkMOr7THRvGQFJeYkxJ0/lSpk8ERoKlhcPz/3RiD+4=;
        b=eDVfOXu2fTM+NF4r6AwbHzmwFZ27VzLcPHb1NlE1UOGHdfuoNzZArXJuFTWy7WjpOZ
         U4SknfcioVkD9XPMlFORuZqfGmDCIdBC6jE5XhrakwWkYKVk8/WBtpLdsOrnid19Txke
         EQl/iCFP+i5hoYlUe7paIP8GUP18RzLF8ca8p/CZZbovon1UpCOaLEU+altH3wKZvagF
         /NwBgBqP0tgPriGqKEL2o+39PHMw1CEGE41MwXiLGq3LXGePdwFT9996ROPSh63ymVHw
         84zc6InAsWvsHMtc4hBT87qKV/H+ByZZNvk5DiQIkOXQBqNsQg/5GdEXL3oIe9CczdMO
         k6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=khkMOr7THRvGQFJeYkxJ0/lSpk8ERoKlhcPz/3RiD+4=;
        b=ry8hMqV4s0EUHI9nF44IqUsuncZdGJKDxLBLCPGveL1P9R42xxKyDqM/VQK4LGbq1r
         C1Ud4elGpbymeY7aH0cJeurvhjtDvZB1AKIHJijzUu6TYkgY7xzRjxD47ewK5W4sWGbE
         CMEHkE45wCeuwcjiYYW/4v5yZsE15aToLa7oVosju8O4AzUkXFNMv57OtdBhdhkEuVQy
         p+x245ijv6fsnZ7thRzHNamVk/Ni4dPdZPbXo57Y0TuzNdX8igYOIyYtEwKaCf0m0Pp2
         StlcFddLdcE5UZ3/bE3C81V65icf1Os35RADRNm2WBh082sSn3V4axXP71epPux0vtP2
         G9Yg==
X-Gm-Message-State: AOAM530ejs8F0w5X1CXjq6/uAbuEiG5f62gemk+PL74elCZsJwVoToxJ
        Wv64pVC1bg8OY+T5YSGRxIwZIA==
X-Google-Smtp-Source: ABdhPJxLnEVbXPMNfvAkhFJjXaEB7qnMK0EZlPyqE5kN3ZRrBE+rA62Y1fQbQxaH2CwUCUx6tPO30w==
X-Received: by 2002:aa7:8bd7:0:b029:160:9db:d8bc with SMTP id s23-20020aa78bd70000b029016009dbd8bcmr4019961pfd.69.1603970787031;
        Thu, 29 Oct 2020 04:26:27 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id u124sm2799091pfc.21.2020.10.29.04.26.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 04:26:26 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:56:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhuguangqing83 <zhuguangqing83@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'zhuguangqing' <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the
 final cpufreq
Message-ID: <20201029112624.zvl6yh7fgqautzry@vireshk-i7>
References: <004001d6ade5$0f8dde00$2ea99a00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004001d6ade5$0f8dde00$2ea99a00$@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-10-20, 19:17, zhuguangqing83 wrote:
> I think your patch is ok for tackling this problem.

Great.

> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 0c5c61a095f6..8991cc31b011 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -121,13 +121,8 @@ static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
> >  static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
> >                                   unsigned int next_freq)
> >  {
> > -       if (!sugov_update_next_freq(sg_policy, time, next_freq))
> > -               return;
> > -
> > -       if (!sg_policy->work_in_progress) {
> > -               sg_policy->work_in_progress = true;
> > +       if (sugov_update_next_freq(sg_policy, time, next_freq))
> >                 irq_work_queue(&sg_policy->irq_work);
> > -       }
> >  }
> > 
> >  /**
> > @@ -159,6 +154,15 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >         unsigned int freq = arch_scale_freq_invariant() ?
> >                                 policy->cpuinfo.max_freq : policy->cur;
> > 
> > +       /*
> > +        * The previous frequency update didn't go as we expected it to be. Lets
> > +        * start again to make sure we don't miss any updates.
> > +        */
> > +       if (unlikely(policy->cur != sg_policy->next_freq)) {
> > +               sg_policy->next_freq = 0;
> > +               sg_policy->cached_raw_freq = 0;
> > +       }
> > +
> >         freq = map_util_freq(util, freq, max);
> > 
> >         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > @@ -337,8 +341,14 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> > 
> >         ignore_dl_rate_limit(sg_cpu, sg_policy);
> > 
> > +       if (!sg_policy->policy->fast_switch_enabled) {
> > +               raw_spin_lock(&sg_policy->update_lock);
> > +               if (sg_policy->work_in_progress)
> > +                       goto unlock;
> > +       }
> > +
> 
> Maybe it's better to bring the following code before the code above.
>          if (!sugov_should_update_freq(sg_policy, time))
>                return;

Maybe not. We want to avoid everything in case a freq-update is on the
way elsewhere as there are other flags we are touching in
sugov_should_update_freq().

I will send a proper patch for this shortly. It would be helpful if
you can give it a go and provide your tested-by.

-- 
viresh
