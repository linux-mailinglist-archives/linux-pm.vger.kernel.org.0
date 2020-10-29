Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5746B29E92C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 11:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgJ2KnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 06:43:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34962 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgJ2KnK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 06:43:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id n11so1853204ota.2;
        Thu, 29 Oct 2020 03:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwJ38VzBMmI3Ef757/3PaRmPBncmzMloPmX0ZrpiY2k=;
        b=Rs+xzNJoZ9XpzmVqQIxJKoPx3B2QmVc6YFlnIeJGMv0lTVedI6hr184xiY3wMZ5FfU
         vz5pyT9CDexPsFTKAvK0pL71rUCsTYcMt+VHQj9eSjhXV5E2G8kyAmV8ROvdQ0hM0zS5
         u7tJArOEBcLpNbjIOESb1Lz/l//x+afcQ1FesvmqhPvug2IAHhUzguSAURxbaZNrJWd1
         13FeozjKkwuFqwmUNKhqkw52GqIq51ANb1yUaBUmpWy2aWUIJ93ql6mPhtFDAE8SJ12T
         2c2PIw5w48BAfnS+7ZFx+cjLwEO3noCDFrQ/I7eCQYqCedMMTZyzb0Y9CWM2Pvjr1ozh
         KZFg==
X-Gm-Message-State: AOAM530Ab7noVjoWLmJtKft3a0DqbvOEZBnZig+bt8pIdklgQYB9PmTX
        Y4emRHb4xxfVXlOaTk3aO101RIw20qEMA8qG9J0=
X-Google-Smtp-Source: ABdhPJzGVASLyoTNxz/W4r70+FS+l8cUY6j/29admB6g2x1bV8CsV9aGCfDVmfjdg8DsT+rTv+hQdOBTwRgs9Ufs4R4=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr2855310ote.206.1603968188569;
 Thu, 29 Oct 2020 03:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <2183878.gTFULuzKx9@kreacher> <1905098.zDJocX6404@kreacher>
 <12275472.W5IoEtXICo@kreacher> <20201028035702.75f6rnbkvfaic4si@vireshk-i7>
In-Reply-To: <20201028035702.75f6rnbkvfaic4si@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Oct 2020 11:42:56 +0100
Message-ID: <CAJZ5v0ikw9M4-NOEqtoxqs_948iqaX4P5euiXD+VmpaDHd91vg@mail.gmail.com>
Subject: Re: [PATCH v2.1 4/4] cpufreq: schedutil: Always call driver if
 need_freq_update is set
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 29, 2020 at 12:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 27-10-20, 16:35, Rafael J. Wysocki wrote:
> > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > @@ -102,11 +102,12 @@ static bool sugov_should_update_freq(str
> >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >                                  unsigned int next_freq)
> >  {
> > -     if (sg_policy->next_freq == next_freq)
> > +     if (sg_policy->next_freq == next_freq && !sg_policy->need_freq_update)
> >               return false;
> >
> >       sg_policy->next_freq = next_freq;
> >       sg_policy->last_freq_update_time = time;
> > +     sg_policy->need_freq_update = false;
> >
> >       return true;
> >  }
> > @@ -161,10 +162,12 @@ static unsigned int get_next_freq(struct
> >
> >       freq = map_util_freq(util, freq, max);
> >
> > -     if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > +     if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> > +             sg_policy->need_freq_update = true;
> > +     else if (freq == sg_policy->cached_raw_freq &&
> > +              !sg_policy->need_freq_update)
> >               return sg_policy->next_freq;
> >
> > -     sg_policy->need_freq_update = false;
> >       sg_policy->cached_raw_freq = freq;
> >       return cpufreq_driver_resolve_freq(policy, freq);
> >  }
>
> What about just this instead ?
>
>   static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>                                    unsigned int next_freq)
>   {
>  -      if (sg_policy->next_freq == next_freq)
>  +      if (sg_policy->next_freq == next_freq &&
>  +          !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
>                 return false;
>
>         sg_policy->next_freq = next_freq;
>         sg_policy->last_freq_update_time = time;
>
>         return true;
>   }
>

Without any changes in get_next_freq() this is not sufficient, because
get_next_freq() may skip the update too.

If the intention is to always let the driver callback run when
CPUFREQ_NEED_UPDATE_LIMITS is set, then both get_next_freq() and
sugov_update_next_freq() need to be modified.
