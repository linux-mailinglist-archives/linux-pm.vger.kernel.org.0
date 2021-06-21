Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA4F3AE1C9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 05:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFUDMG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 23:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFUDMG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 23:12:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49B9C061574
        for <linux-pm@vger.kernel.org>; Sun, 20 Jun 2021 20:09:52 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g22so12986838pgk.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Jun 2021 20:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m3qVLmPqXTkn2QcO19eSXMz6mJEyfIae5C0oRCwTDbw=;
        b=CNIyupoYyrLVei4yPnyB4/Fv9SicuTjksAdw3wdy6B/wiCoIifqizrppLUsmOJX9iq
         V/EJopL6ZI+zv9TNYFh+BlVq9GD601W+4uJvDfReSSSLjSMJI6/ff9KXf4HlP5YUb1T2
         L5LgbPjCWaiqVxmjrbvhSJ+hYEHTs5Sl/Jq475VtgIGAbjSBumqI8BwRvarHScN/i957
         UWQKcC32pOXuQs1pGNgdx4QmkgE6+LFIWxqPSUYHBvd95vw6JaOKNyVADdHZt+Eu3ffr
         YzjZDFgI6MLRJ+bqPhlebRViBme5hhplaY8WZCczTDHfObZs3dhC2j+jm9C4DDTCVIrK
         OzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m3qVLmPqXTkn2QcO19eSXMz6mJEyfIae5C0oRCwTDbw=;
        b=KcJAf/hoyzm/EZ3XA4vKzksS02UqD8OrzCy8qROP/WSiEIVcvYeaLsUGiYAzLu3qA5
         Hwb+sPdd8StMsE3uYeMRjnFMtscoi40m3JrCDomop+DeEAk1oJF+nO+RYtxQ52srLIza
         SLpQdj7LYUVnU9PiQfdigiBiKNcGzKwxf+mtSAYzHg94nB7AMGnqECGSEQnm9DP1HBOe
         DDpZcwO9hDCyuXn2HK2JWoWM9slgs303N9t6HII2au/FVAiseMFLP+EV2faHbOobnm5b
         PrDHdAhunkHzCEcGL9B20hqmeXnp6f4pP81OxUSKmxm++p84utw9qDhU6HV2NeCW1NCh
         J5eA==
X-Gm-Message-State: AOAM531/9jB0JaWFrz7IwHQAraDO1XpIM+XonQt+AuuUrvPkzKAr8+dA
        AYuXvkCZFfWKMJUFxwSdsD2SRg==
X-Google-Smtp-Source: ABdhPJwF6IXIpvn79W6lsrkAV4uspeJ32tJfUC85SDsv+qGcI7ddlZuDOpXAB6E6Sm6z2XbSlJNFng==
X-Received: by 2002:a63:1324:: with SMTP id i36mr21597068pgl.44.1624244992132;
        Sun, 20 Jun 2021 20:09:52 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id j10sm10610139pjz.36.2021.06.20.20.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 20:09:51 -0700 (PDT)
Date:   Mon, 21 Jun 2021 08:39:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/3] cpufreq: intel_pstate: Migrate away from
 ->stop_cpu() callback
Message-ID: <20210621030949.tng5xzq7dm7ngaez@vireshk-i7>
References: <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
 <c31424b7962608eb13f946a665ba6848c4986856.1623986349.git.viresh.kumar@linaro.org>
 <CAJZ5v0h37bs0xLUCeD7ZuZfXLPBx=6Mpr-Y+Ef=qcnDA4aoLbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h37bs0xLUCeD7ZuZfXLPBx=6Mpr-Y+Ef=qcnDA4aoLbQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-06-21, 14:00, Rafael J. Wysocki wrote:
> On Fri, Jun 18, 2021 at 5:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
> > interface") added the stop_cpu() callback to allow the drivers to do
> > clean up before the CPU is completely down and its state can't be
> > modified.
> >
> > At that time the CPU hotplug framework used to call the cpufreq core's
> > registered notifier for different events like CPU_DOWN_PREPARE and
> > CPU_POST_DEAD. The stop_cpu() callback was called during the
> > CPU_DOWN_PREPARE event.
> >
> > This is no longer the case, cpuhp_cpufreq_offline() is called only once
> > by the CPU hotplug core now and we don't really need to separately
> > call stop_cpu() for cpufreq drivers.
> >
> > Migrate to using the exit() and offline() callbacks instead of
> > stop_cpu().
> >
> > We need to clear util hook from both the callbacks, exit() and
> > offline(), since it is possible that only exit() gets called sometimes
> > (specially on errors) or both get called at other times.
> > intel_pstate_clear_update_util_hook() anyway have enough protection in
> > place if it gets called a second time and will return early then.
> >
> > Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2->V3:
> > - Update intel_pstate_cpu_offline() as well.
> > - Improved commit log.
> >
> >  drivers/cpufreq/intel_pstate.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 0e69dffd5a76..8f8a2d9d7daa 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2335,6 +2335,8 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
> >
> >         pr_debug("CPU %d going offline\n", cpu->cpu);
> >
> > +       intel_pstate_clear_update_util_hook(policy->cpu);
> > +
> >         if (cpu->suspended)
> >                 return 0;
> >
> > @@ -2374,17 +2376,12 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
> >         return 0;
> >  }
> >
> > -static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
> > -{
> > -       pr_debug("CPU %d stopping\n", policy->cpu);
> > -
> > -       intel_pstate_clear_update_util_hook(policy->cpu);
> > -}
> > -
> >  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> >  {
> >         pr_debug("CPU %d exiting\n", policy->cpu);
> >
> > +       intel_pstate_clear_update_util_hook(policy->cpu);
> 
> This change is not needed now, because ->offline always runs before
> ->exit if present.

Not necessarily, we don't call ->offline() for many error paths in
cpufreq_online(). offline() only comes into play after driver is registered
properly once.

-- 
viresh
