Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E32D3A30
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 06:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgLIFR1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 00:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLIFR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 00:17:27 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77173C0613CF
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 21:16:47 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so340341plo.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 21:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7s4kC119p94cJiOPKTouFrtJW6rL09U1poRHP0YQlPA=;
        b=jUNLuq9d5v62cyLj5/x9dFkcMtuDu916d/Y+mUGSZXdS57FPxSWAgoonMXqsVtyMkd
         iKZ1Uldi+C/ZUIIE+Q0pfKLkHZNFX4nvDAmXsuQEpWbNlkPpX8sv0ilyjkJ+e6dhg51W
         YiDxN2BjJmbyOW+jAglPmokJqNVC/Az3vq7J6mIZDjY+CAf2OoPQ+FAaydjy7bu/taFn
         cXAWmL28FpPkO52/pobQpXpAUGt05qG3b4TmRVAQiheW0xEA/egJd9YZd1K+EbGWcB+H
         hj0XzN8v5IDhwQqdxoujRgEk/14teJ8pz5qL1kt+fq/rT73f62dDxrqY4AsGnf9hrOcF
         h6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7s4kC119p94cJiOPKTouFrtJW6rL09U1poRHP0YQlPA=;
        b=k0+z7DwQGeQFAyAxZaCzSqKIAq7XZodmyGFMS6hjlSRg/H6NbjXslkWDAYtlJcpIl3
         JPDe/iZUlHadW9rZ2JmLYQXUDLoi0izYt8hkWUtJF7IpITaTBzeyPqn7hOx6WgokCHDn
         L0MxPdB4rmRPVmDr/E0RmMSJhGDAqFdfzXdS5iVGgk/wdXJ2NepL6DnTBzle3Q7Dx6Vo
         wlj+uk+PCWcCaosVoBLxXarV5yGcMEx1b0Q+hiFghTPtfrow74RnLPZa7yqrS2ppMYy6
         oq36/kBrcymA4OU/NsK9D5pdnDEIItEl/gX+wmzaSEg+inacH3rDar2Le+LTI/RIkks6
         z6Ow==
X-Gm-Message-State: AOAM532FLpgKDzxBPwaPy0CeD2oW4vPGSFAhxut1uPFnk+2/kjs3fN/G
        qfcw+vBwA6AJPAAUYKyOn0tGZw==
X-Google-Smtp-Source: ABdhPJwWMnHn0wFBcM4+EKcGjlsUDRm3eAEo7zq3UocDk6LJb3GHWwfoG+zZv8sCXC+i2ckeCUaweA==
X-Received: by 2002:a17:902:7d8e:b029:da:cfcb:f4c4 with SMTP id a14-20020a1709027d8eb02900dacfcbf4c4mr525538plm.79.1607491006965;
        Tue, 08 Dec 2020 21:16:46 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id 193sm657904pfz.36.2020.12.08.21.16.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 21:16:45 -0800 (PST)
Date:   Wed, 9 Dec 2020 10:46:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [PATCH v1 2/4] cpufreq: schedutil: Adjust utilization instead of
 frequency
Message-ID: <20201209051642.ddwgds4gznxt3lfn@vireshk-i7>
References: <20360841.iInq7taT2Z@kreacher>
 <1916732.tSaCp9PeQq@kreacher>
 <20201208085146.pzem6t3mt44xwxkm@vireshk-i7>
 <CAJZ5v0idoNOPU5-toOw+uTRvjJz60Ddc2xV7rMQeufY_EW58uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0idoNOPU5-toOw+uTRvjJz60Ddc2xV7rMQeufY_EW58uQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-12-20, 18:01, Rafael J. Wysocki wrote:
> On Tue, Dec 8, 2020 at 9:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 07-12-20, 17:29, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > When avoiding reduction of the frequency after the target CPU has
> > > been busy since the previous frequency update, adjust the utilization
> > > instead of adjusting the frequency, because doing so is more prudent
> > > (it is done to counter a possible utilization deficit after all) and
> > > it will allow some code to be shared after a subsequent change.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c |   11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > >
> > > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > > @@ -437,7 +437,7 @@ static void sugov_update_single(struct u
> > >  {
> > >       struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> > >       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> > > -     unsigned int cached_freq = sg_policy->cached_raw_freq;
> > > +     unsigned long prev_util = sg_cpu->util;
> > >       unsigned int next_f;
> > >
> > >       sugov_iowait_boost(sg_cpu, time, flags);
> > > @@ -451,17 +451,14 @@ static void sugov_update_single(struct u
> > >       sugov_get_util(sg_cpu);
> > >       sugov_iowait_apply(sg_cpu, time);
> > >
> > > -     next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
> > >       /*
> > >        * Do not reduce the frequency if the CPU has not been idle
> > >        * recently, as the reduction is likely to be premature then.
> > >        */
> > > -     if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > > -             next_f = sg_policy->next_freq;
> > > +     if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> > > +             sg_cpu->util = prev_util;
> > >
> > > -             /* Restore cached freq as next_freq has changed */
> > > -             sg_policy->cached_raw_freq = cached_freq;
> > > -     }
> > > +     next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
> >
> > I don't think we can replace freq comparison by util, or at least it will give
> > us a different final frequency and the behavior is changed.
> >
> > Lets take an example, lets say current freq is 1 GHz and max is 1024.
> >
> > Round 1: Lets say util is 1000
> >
> > next_f = 1GHz * 1.25 * 1000/1024 = 1.2 GHz
> >
> > Round 2: Lets say util has come down to 900 here,
> >
> > before the patch:
> >
> > next_f = 1.2 GHz * 1.25 * 900/1024 = 1.31 GHz
> >
> > after the patch:
> >
> > next_f = 1.2 GHz * 1.25 * 1000/1024 = 1.45 GHz
> >
> > Or did I make a mistake here ?
> 
> I think so, if my understanding is correct.
> 
> Without the patch, next_f will be reset to the previous value
> (sq_policy->next_freq) if the CPU has been busy and the (new) next_f
> is less than that value.
> 
> So the "new" next_f before the patch is 1.31 GHz, but because it is
> less than the previous value (1.45 GHz), it will be reset to that
> value, unless I'm missing something.

The prev frequency here was 1.2 GHz (after Round 1). 1.45 GHz is the
value we get after this patch, as we take the earlier utilization
(1000) into account instead of 900.

> Overall, the patch doesn't change the logic AFAICS and because the
> util->freq mapping is linear, all of the inequalities map exactly from
> one to the other (both ways).

-- 
viresh
