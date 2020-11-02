Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E62A23CE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 05:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgKBEnQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 23:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgKBEnQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 23:43:16 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3445CC061A04
        for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2020 20:43:16 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id n16so9694064pgv.13
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 20:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=srks28iO1gRpgZNbb5QK/SCn40SAhZrPX4c/7fjgLFw=;
        b=ub+qiSgSbfLn/SnED3PuPrLhmyL3iqBvzfQlSF6LEuubARqPGjU1EmwDT+CDViGRn3
         vYweN7kq/UsFjLrUSYgoylXCBBbmu3Dsq1+JRYCYuvclcvBjaoWto+WJmOoyCotvGsGD
         Nua1Jbwl2lg4SycCfIUVR81iMH27j2fz6AINkdxhrZOUJpGyWnbSl2Q4sM2LPFeTeVqa
         opZzMqO6BHppw16XNgtJ6fOOBCb0Cj4hUU94aWB/IvLoXRdpgwe6Xk2lsYTODdeCpWbp
         tq8jblB9dPPcKkE8k4x85piEWR3z7+uJMueoYzFqSj6JyOjiSXMdtLIQSyHRv5OXJvSZ
         t0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=srks28iO1gRpgZNbb5QK/SCn40SAhZrPX4c/7fjgLFw=;
        b=lJvOA+F4ouQB2K19BqVwjttd56hrECDgoQxSQIKIsavBsHIylcUkrJSEIwZB+zGz1s
         HEaY46YYz9Wzr4RKyNeOhyQfbbVfiVFm6x9+43UmyS4uzlEhju4CnGgjnweTMakPfjDc
         TZB93IDrs9U7HAnHqzovLqmWIlPiVc6V+9cm6RuU3tnN1bcsUc2c0eUm1RCo/pK99yuN
         GnR3cHaZ8BrkmlGpEfwFB5MEy/TPoAGkJ07zKv9shsui2lS/mpIQcSX9mO3jdTZzkyaX
         /oNLkf2JjRStbGIekHI1ZWmzZZrQh6woFBs41n0af0HX2sSQ2jXeOvddi6oZk+TNPACF
         D2cQ==
X-Gm-Message-State: AOAM533k6ZwQwPC6s9UI6HR/j9VeDo9/1AqnVFCdnGBdN7QupTL6aCNx
        XKSWti/BzLDyn87Ua4kFdzyUdg==
X-Google-Smtp-Source: ABdhPJzB0gXN96d2Cn26PfuyUNHTdRvWXx2RkTUfk896bSkcgYtqKXoBjXilU5ZKHVPR0IeRPc9DzQ==
X-Received: by 2002:a62:55c6:0:b029:160:1c33:a0f7 with SMTP id j189-20020a6255c60000b02901601c33a0f7mr20050354pfb.35.1604292195495;
        Sun, 01 Nov 2020 20:43:15 -0800 (PST)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id r19sm10162020pjo.23.2020.11.01.20.43.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 20:43:14 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:13:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        zhuguangqing <zhuguangqing@xiaomi.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: Don't skip freq update if
 need_freq_update is set
Message-ID: <20201102044312.4oxgfsmx3v5raq6d@vireshk-i7>
References: <2954009.kBar6x9KXa@kreacher>
 <207ae817a778d79a99c30cb48f2ea1f527416519.1604042421.git.viresh.kumar@linaro.org>
 <CAJZ5v0j2uoaUdSr1-OonPkR6QapjOm4RE2Ya=LBpV1KDrLF3gw@mail.gmail.com>
 <CAJZ5v0gURd-dcAWj0KdmodM3MfU_DQ_HEiX-CCcd+fHpRikSyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gURd-dcAWj0KdmodM3MfU_DQ_HEiX-CCcd+fHpRikSyA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-10-20, 16:23, Rafael J. Wysocki wrote:
> On Fri, Oct 30, 2020 at 4:07 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Oct 30, 2020 at 8:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > The cpufreq policy's frequency limits (min/max) can get changed at any
> > > point of time, while schedutil is trying to update the next frequency.
> > > Though the schedutil governor has necessary locking and support in place
> > > to make sure we don't miss any of those updates, there is a corner case
> > > where the governor will find that the CPU is already running at the
> > > desired frequency and so may skip an update.
> > >
> > > For example, consider that the CPU can run at 1 GHz, 1.2 GHz and 1.4 GHz
> > > and is running at 1 GHz currently. Schedutil tries to update the
> > > frequency to 1.2 GHz, during this time the policy limits get changed as
> > > policy->min = 1.4 GHz. As schedutil (and cpufreq core) does clamp the
> > > frequency at various instances, we will eventually set the frequency to
> > > 1.4 GHz, while we will save 1.2 GHz in sg_policy->next_freq.
> > >
> > > Now lets say the policy limits get changed back at this time with
> > > policy->min as 1 GHz. The next time schedutil is invoked by the
> > > scheduler, we will reevaluate the next frequency (because
> > > need_freq_update will get set due to limits change event) and lets say
> > > we want to set the frequency to 1.2 GHz again. At this point
> > > sugov_update_next_freq() will find the next_freq == current_freq and
> > > will abort the update, while the CPU actually runs at 1.4 GHz.
> > >
> > > Until now need_freq_update was used as a flag to indicate that the
> > > policy's frequency limits have changed, and that we should consider the
> > > new limits while reevaluating the next frequency.
> > >
> > > This patch fixes the above mentioned issue by extending the purpose of
> > > the need_freq_update flag. If this flag is set now, the schedutil
> > > governor will not try to abort a frequency change even if next_freq ==
> > > current_freq.
> > >
> > > As similar behavior is required in the case of
> > > CPUFREQ_NEED_UPDATE_LIMITS flag as well, need_freq_update will never be
> > > set to false if that flag is set for the driver.
> > >
> > > We also don't need to consider the need_freq_update flag in
> > > sugov_update_single() anymore to handle the special case of busy CPU, as
> > > we won't abort a frequency update anymore.
> > >
> > > Reported-by: zhuguangqing <zhuguangqing@xiaomi.com>
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Thanks for following my suggestion!
> >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c | 22 ++++++++++------------
> > >  1 file changed, 10 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index c03a5775d019..c6861be02c86 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -102,9 +102,12 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> > >                                    unsigned int next_freq)
> > >  {
> > > -       if (sg_policy->next_freq == next_freq &&
> > > -           !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> > > -               return false;
> > > +       if (!sg_policy->need_freq_update) {
> > > +               if (sg_policy->next_freq == next_freq)
> > > +                       return false;
> > > +       } else if (!cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS)) {
> > > +               sg_policy->need_freq_update = false;
> 
> One nit, though.
> 
> This can be changed into
> 
> } else {
>       sg_policy->need_freq_update =
> cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> }
> 
> to save a branch and because need_freq_update is there in the cache
> already, this should be a fast update.

Nice.

-- 
viresh
