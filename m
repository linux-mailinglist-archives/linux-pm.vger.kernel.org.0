Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB8129E9BB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 11:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJ2Kyp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgJ2Kyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 06:54:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811BC0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 03:54:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z24so2031170pgk.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/IA93lh4Lo9Ev83453PFjMJYOWrNuSohoD4R/Qf7h+g=;
        b=qpZ40ZBNm2WL8PgWyRonOOxc12GbaFU3Ow5DXPA8JGmpuQWACGPoRYA3r/IPm8ZUZ6
         +Nt9ajxu6hljelx41t/eZ6wROT62k8OknOKEJEgCWv95rG+pwqdQsHAM5Gu0xWsDrLXK
         UxnkHucGi8eeOC6JpN7CtSju69TtFoNgfAT2KxobKWaux2cuK/awQle/XUvNpuPrth3p
         QwGrua3WEPKf9txCJm3+b/O3vPhMShWFSJyYSLX+quyEAgqxSE5VUy3GcoFnFyv+QUrs
         Ld50D4VtProBuNkOChZOZ5rxXQBNsErWQHyk0SBi9Y8PR3vNAh4mcGXZaTOX9MrVHR2L
         305A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/IA93lh4Lo9Ev83453PFjMJYOWrNuSohoD4R/Qf7h+g=;
        b=I/5g9mA1c7Gpu/je3J4FvimnL2Tn7WLKg53kApmOfLva5g94HQN2qCQKrcWdJsOUxw
         hLzM3vd5Y8iA5sR09kxlwb7F9FUF39CgTeDfMXZ54VOsvyJHAK0KqTEwrzNFRvpZUsUr
         9zEYL+8IoDlQ51SI6EgRBNFH9DURP6rQCzvglBrnVyrb0hjoeajGCF7TOlqYu555hOQQ
         HuAZu7hgBsKsUL6+glHi2y2uzmshoqNNexaqjfUgB+ApzGYy6NG3GtpK84mEeeBY7rnH
         /hTw7Mj5YThBmwGSXq/IFNDjZEH82d5JTlGSpV8P3lnhnrmcjRf3YJbTMSY8KpttGlNM
         FFwA==
X-Gm-Message-State: AOAM533JjBwF6OJNPkujGlL85o5Y2hLW6Ez4qXErzCZnHb1OqNVhs6pa
        1oddvWsddjG0em4gdgkM9ePLjw==
X-Google-Smtp-Source: ABdhPJxSguzvzWaoco54Zkd8E93SML/FmBfwW9LWBVavhKlWKfAgVE/uENIufgb7AnVyLOYvUXoXtQ==
X-Received: by 2002:a65:5c02:: with SMTP id u2mr3507681pgr.173.1603968884849;
        Thu, 29 Oct 2020 03:54:44 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id b4sm2566726pfi.208.2020.10.29.03.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 03:54:42 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:24:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2.1 4/4] cpufreq: schedutil: Always call driver if
 need_freq_update is set
Message-ID: <20201029105440.gcaizotprhloxiih@vireshk-i7>
References: <2183878.gTFULuzKx9@kreacher>
 <1905098.zDJocX6404@kreacher>
 <12275472.W5IoEtXICo@kreacher>
 <20201028035702.75f6rnbkvfaic4si@vireshk-i7>
 <CAJZ5v0ikw9M4-NOEqtoxqs_948iqaX4P5euiXD+VmpaDHd91vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ikw9M4-NOEqtoxqs_948iqaX4P5euiXD+VmpaDHd91vg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-10-20, 11:42, Rafael J. Wysocki wrote:
> On Thu, Oct 29, 2020 at 12:10 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 27-10-20, 16:35, Rafael J. Wysocki wrote:
> > > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > > @@ -102,11 +102,12 @@ static bool sugov_should_update_freq(str
> > >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> > >                                  unsigned int next_freq)
> > >  {
> > > -     if (sg_policy->next_freq == next_freq)
> > > +     if (sg_policy->next_freq == next_freq && !sg_policy->need_freq_update)
> > >               return false;
> > >
> > >       sg_policy->next_freq = next_freq;
> > >       sg_policy->last_freq_update_time = time;
> > > +     sg_policy->need_freq_update = false;
> > >
> > >       return true;
> > >  }
> > > @@ -161,10 +162,12 @@ static unsigned int get_next_freq(struct
> > >
> > >       freq = map_util_freq(util, freq, max);
> > >
> > > -     if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > > +     if (cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> > > +             sg_policy->need_freq_update = true;
> > > +     else if (freq == sg_policy->cached_raw_freq &&
> > > +              !sg_policy->need_freq_update)
> > >               return sg_policy->next_freq;
> > >
> > > -     sg_policy->need_freq_update = false;
> > >       sg_policy->cached_raw_freq = freq;
> > >       return cpufreq_driver_resolve_freq(policy, freq);
> > >  }
> >
> > What about just this instead ?
> >
> >   static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >                                    unsigned int next_freq)
> >   {
> >  -      if (sg_policy->next_freq == next_freq)
> >  +      if (sg_policy->next_freq == next_freq &&
> >  +          !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> >                 return false;
> >
> >         sg_policy->next_freq = next_freq;
> >         sg_policy->last_freq_update_time = time;
> >
> >         return true;
> >   }
> >
> 
> Without any changes in get_next_freq() this is not sufficient, because
> get_next_freq() may skip the update too.
> 
> If the intention is to always let the driver callback run when
> CPUFREQ_NEED_UPDATE_LIMITS is set, then both get_next_freq() and
> sugov_update_next_freq() need to be modified.

Right, my mistake. I was just suggesting that we may not need to touch
need_freq_update at all but just check the flag.

-- 
viresh
