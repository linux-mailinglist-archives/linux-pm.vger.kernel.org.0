Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46476223989
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgGQKnU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 06:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQKnU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 06:43:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA9C061755
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 03:43:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so16357698wmf.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o/b+EmKne5gnDXstxW2uX3pxAh0IsbYMQdhSzdZxQ90=;
        b=ZrSA1VaWOJmimVTByiramfsqR+MhBH7LqpR7K5Hr/k/n8QyMRK7r6tC9igUDitBqvC
         JRzp7+NludnBgMWUF2N6afx/XAYbeuLU1jr6H/m65A5MgmvOdudw5+7gwTzmwwNMD2TG
         JwdmlhTIi/qpnB0pyVNcS+tU3AV6yQOaEAfJrlJu/staUrt+P8gWpwjGo16OEV7+oGha
         YbrGgRwob0UhXAtzH29ybIk34ZJ7F+OFKskSh+0Ob2vtkuuFEF9GadOmIKUa7NZ3A5o7
         Hcjhl6YnO3UUiDmp79cuspio9eSMAtZkUfDzgDbK0QYrVggj2ix7M2OoS+4KkE1Lg1zH
         EEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o/b+EmKne5gnDXstxW2uX3pxAh0IsbYMQdhSzdZxQ90=;
        b=o+cQF0dhTo3DTbC0zH6x0LHuUl8OX7T7QqIjUYQOoc7GaeX7wzlQw1leybPKqcwrh1
         bJ+dq1vsCkTCKLSi2f3RbhH4IttYPaJUnzqmS11pVwe+ujzK/UBHwtbaCrPVt4zEsL3f
         sUUPUIuAECMy6kjN0NEBJYNwXC81o2h1VjxUNonafHSV0zgDl2k0ANPnRMU6Efp0tIPx
         M26HKJLCilJZIHH3+JOnWJK15gpZmUxWAxNSxKTq4+2RaMYpJ/lztO2UywCgmTW7IkGX
         S2nIH9b+W9GcYUbf2/6vTrKivdkIs88PE6SpkvqIpta2jVd0snkegM48gNF/oW3LLBdf
         pM2w==
X-Gm-Message-State: AOAM532zUiGN4r3njLVXORj3Jp9Q2whsl0IzURtvByHuKjZEzE3Zuz+q
        IdNdNQ6PHIn7TauLbjf0sCSqzw==
X-Google-Smtp-Source: ABdhPJwdH3QTnBvXg3Z7gVZPAsOOybtbAb4sFkTkT/XqR+Td7VJeZEMZmlbMI1juTQ5o+1GVcwSmpQ==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr8711628wmh.68.1594982598532;
        Fri, 17 Jul 2020 03:43:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id a4sm15005117wrg.80.2020.07.17.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:43:17 -0700 (PDT)
Date:   Fri, 17 Jul 2020 11:43:14 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200717104314.GB2385870@google.com>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200717101438.GA2366103@google.com>
 <20200717103305.GA2385870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717103305.GA2385870@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 17 Jul 2020 at 11:33:05 (+0100), Quentin Perret wrote:
> On Friday 17 Jul 2020 at 11:14:38 (+0100), Quentin Perret wrote:
> > On Tuesday 14 Jul 2020 at 12:06:53 (+0530), Viresh Kumar wrote:
> > >  /**
> > > - * get_load() - get load for a cpu since last updated
> > > + * get_load() - get current load for a cpu
> > >   * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
> > >   * @cpu:	cpu number
> > > - * @cpu_idx:	index of the cpu in time_in_idle*
> > > + * @cpu_idx:	index of the cpu
> > >   *
> > > - * Return: The average load of cpu @cpu in percentage since this
> > > - * function was last called.
> > > + * Return: The current load of cpu @cpu in percentage.
> > >   */
> > >  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> > >  		    int cpu_idx)
> > >  {
> > > -	u32 load;
> > > -	u64 now, now_idle, delta_time, delta_idle;
> > > -	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> > > -
> > > -	now_idle = get_cpu_idle_time(cpu, &now, 0);
> > > -	delta_idle = now_idle - idle_time->time;
> > > -	delta_time = now - idle_time->timestamp;
> > > +	unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> > > +	unsigned long max = arch_scale_cpu_capacity(cpu);
> > 
> > Should we subtract the thermal PELT signal from max?
> 
> Actually, that or add it the ENERGY_UTIL case in effective_cpu_util() as
> this appears to be missing for EAS too ...

Scratch that. I do think there is something missing in the EAS path, but
not sure that would fix it. I'll have a think and stop spamming
everybody in the meantime ...

The first question is still valid, though :)

Sorry for the noise,
Quentin
