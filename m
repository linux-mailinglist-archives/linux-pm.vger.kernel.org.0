Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C621422063D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGOHc3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgGOHc3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 03:32:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56711C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:32:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so2660413pjb.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4OsIUVSYPyrRBJnsIHSNweFvUVPy8DN6WHV/h0JW1HY=;
        b=d/wxQUmfO7mFlzm6UnvUYbNfBLuFtPnXPzOGfzO9wep4pbugMO+DCuUX5+KtBFcgGq
         tj46xZkuAiZJGhsMqE7qLAgDAYOLBitUJtoXGWBQFUabUCSCrDX/ivjHdBhuNfmREsY4
         c+/8OjTORUG7gmzycEJUwXO8+2u8DySsuFSkk7BCTf+/kZfo993Jm655GX1C88KeWBI+
         FvPBbOJBs6xQ5kpJJb9mEP2iNGHfinxFvOmNvevmM6fjhMM9in+32t5lZIRz0pdDSizG
         N2T72gEIWKgNQJVLPljyL71neakkCEcfp6wAJN2/T/en9chwkBsXukvpZnbhVTCoeIV7
         RCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4OsIUVSYPyrRBJnsIHSNweFvUVPy8DN6WHV/h0JW1HY=;
        b=CX6pCq5aDsa7itT0vzPQfh2CR6FNEdkpb7lALClkz9RV37zhOHm7mHrxLkC1/y+OdJ
         9cMqstAf3KJMlSAmJOCAnB9Tq2PXSk7+T5hH4ODNc7wwsntUUqB361iH5rAyhElD/Vwv
         SCuBJXciRS4xFgVA2f0Uq8ZnpmD7LULFy8MDtqQw/WX1U4gKv3g1eaqj9iiFup4juf4p
         CsrQuRDCl9R5BS7IseBpHn4CHmidw03NhBQJ4H4vqy+ret+82Le5sGX9h9tW/jkGSeiF
         6f5TXvVjEzDPffIBT+uCGYl5ZjHt3U5Am/vmrAfk69CAF6Hvo7dV3yn4gExoqoKY4twI
         Qopg==
X-Gm-Message-State: AOAM531uPn8wPgakdMroLilmDOlgUZvwavj1kasq0quR3VBQACtlXzID
        p9zsx0AEn1Au+k7galykqr2LNQ==
X-Google-Smtp-Source: ABdhPJxP4SJkna3co164j25CPi6XJ15P8c46yWyq/M49ZsI5ixD17SZJMXHabbFXMfe7c3PXKuKl8A==
X-Received: by 2002:a17:902:7448:: with SMTP id e8mr7017856plt.311.1594798348685;
        Wed, 15 Jul 2020 00:32:28 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id x7sm1074972pfp.96.2020.07.15.00.32.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 00:32:27 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:02:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200715073225.vnf6dibfca3oc2h4@vireshk-i7>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <CAJZ5v0i=yNH9pGkty2QdeQLcqJcuY=pLx_XcY4VXs8bSqXL=dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i=yNH9pGkty2QdeQLcqJcuY=pLx_XcY4VXs8bSqXL=dg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-07-20, 15:05, Rafael J. Wysocki wrote:
> On Tue, Jul 14, 2020 at 8:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> >                     int cpu_idx)
> >  {
> > -       u32 load;
> > -       u64 now, now_idle, delta_time, delta_idle;
> > -       struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> > -
> > -       now_idle = get_cpu_idle_time(cpu, &now, 0);
> > -       delta_idle = now_idle - idle_time->time;
> > -       delta_time = now - idle_time->timestamp;
> > +       unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> > +       unsigned long max = arch_scale_cpu_capacity(cpu);
> >
> > -       if (delta_time <= delta_idle)
> > -               load = 0;
> > -       else
> > -               load = div64_u64(100 * (delta_time - delta_idle), delta_time);
> > -
> > -       idle_time->time = now_idle;
> > -       idle_time->timestamp = now;
> > -
> > -       return load;
> > +       util = effective_cpu_util(cpu, util, max, ENERGY_UTIL, NULL);
> 
> Hmm.
> 
> It doesn't look like cpufreq_cdev and cpu_idx are needed any more in
> this function, so maybe drop them from the arg list?

Right.

> And then there
> won't be anything specific to CPU cooling in this function, so maybe
> move it to sched and export it from there properly?

There isn't a lot happening in this routine right now TBH and am not
sure if it is really worth it to have a separate routine for this
(unless we can get rid of something for all the callers, like avoiding
a call to arch_scale_cpu_capacity() and then naming it
effective_cpu_load().

> Also it looks like max could be passed to it along with the CPU number
> instead of being always taken as arch_scale_cpu_capacity(cpu).

I am not sure what you are suggesting here. What will be the value of
max if not arch_scale_cpu_capacity() ?

-- 
viresh
