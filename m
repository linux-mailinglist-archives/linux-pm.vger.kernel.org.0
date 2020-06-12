Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B631F7789
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jun 2020 13:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgFLLzh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 07:55:37 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39148 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLLzh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2020 07:55:37 -0400
Received: by mail-oi1-f181.google.com with SMTP id d67so8390979oig.6;
        Fri, 12 Jun 2020 04:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bicOXJoaBdeTIG0+nGNRFjA7MnO99BifAFXX4dFEZGQ=;
        b=fzNOlKeEaahF/qKcL2cRfkb3SLT6Y2dBTKwUWZl8TP+K45uRchNGbYb+/KtmMRF3mD
         flalqFEk8nmedSzEQbt3IbMVWRbGAZBF0hWMaehkQ5TUDlqODkjsvr0hfOGPfvnxyN53
         OtMMLlrTIaAqg5h+dWJIrWgXJW49WhbjgsqX+ltdb/qobx5hHSAHLJ3MQleHIq6YobuU
         0YCZm+O3wsfuNpBVzAARG2jktvg+eEPRi3+b8vEtOX9AhQ5j77tD+rrvLIhlUNaSyMRL
         WCOoRs1WuSADn9rxOBfECrSdqJ5lRIdZzAtTd0LTw7M2B8H1WDKYz3MoYw5F2NwrCMzx
         0uMg==
X-Gm-Message-State: AOAM531Io86SY+OwvyPCNaZO+6bFDsVTkzq+c4D2EDf0xAlwjTUv8guu
        5jC2pmhgPByJ9MGJY+mu7+0khIHvlX2dcHGvqKc=
X-Google-Smtp-Source: ABdhPJxPxwjjyP2s9AnGNeNs28+BIfHw1D31gCdTaiwZvHPe3mQh6f1XaWVCeLy4+bEyj9Nim5cvrVAXJ8cIoUMCLY0=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr1897354oie.103.1591962935897;
 Fri, 12 Jun 2020 04:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7> <CAJZ5v0iR3H+PFnJiroNmZcj-a4bCkvT6xB-nd2ntMvakWFOvAg@mail.gmail.com>
 <39d37e1b-7959-9a8f-6876-f2ed4c1dbc37@huawei.com> <20200604044140.xlv7h62jfowo3rxe@vireshk-i7>
 <CAJZ5v0jj5OS4oB7MYBqKeYejy_3Vz_2oy0hn-Xm=D7XAszM_vg@mail.gmail.com>
 <20200604125822.GB12397@bogus> <20200610094057.GA28144@arm.com> <9d715cb0-0a94-0008-5653-e8d9ad1c5332@huawei.com>
In-Reply-To: <9d715cb0-0a94-0008-5653-e8d9ad1c5332@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Jun 2020 13:55:20 +0200
Message-ID: <CAJZ5v0h1-AE31axGJXmDgc22-jMZ6vWTc1K7b2BmbO8JTwX7tg@mail.gmail.com>
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 11, 2020 at 3:52 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> Hi Ionela,
>
> Thanks for your reply !
>
> On 2020/6/10 17:40, Ionela Voinescu wrote:
> > Hi guys,
> >
> > Sorry for showing up late to the party, I was on holiday last week.
> >
> > On Thursday 04 Jun 2020 at 13:58:22 (+0100), Sudeep Holla wrote:
> >> On Thu, Jun 04, 2020 at 12:42:06PM +0200, Rafael J. Wysocki wrote:
> >>> On Thu, Jun 4, 2020 at 6:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>>>
> >>>> On 04-06-20, 09:32, Xiongfeng Wang wrote:
> >>>>> On 2020/6/3 21:39, Rafael J. Wysocki wrote:
> >>>>>> The frequency value obtained by kicking the CPU out of idle
> >>>>>> artificially is bogus, though.  You may as well return a random number
> >>>>>> instead.
> >>>>>
> >>>>> Yes, it may return a randowm number as well.
> >>>>>
> >>>>>>
> >>>>>> The frequency of a CPU in an idle state is in fact unknown in the case
> >>>>>> at hand, so returning 0 looks like the cleanest option to me.
> >>>>>
> >>>>> I am not sure about how the user will use 'cpuinfo_cur_freq' in sysfs. If I
> >>>>> return 0 when the CPU is idle, when I run a light load on the CPU, I will get a
> >>>>> zero value for 'cpuinfo_cur_freq' when the CPU is idle. When the CPU is not
> >>>>> idle, I will get a non-zero value. The user may feel odd about
> >>>>> 'cpuinfo_cur_frreq' switching between a zero value and a non-zero value. They
> >>>>> may hope it can return the frequency when the CPU execute instructions, namely
> >>>>> in C0 state. I am not so sure about the user will look at 'cpuinfo_cur_freq'.
> >>>>
> >>>> This is what I was worried about as well. The interface to sysfs needs
> >>>> to be robust. Returning frequency on some readings and 0 on others
> >>>> doesn't look right to me as well. This will break scripts (I am not
> >>>> sure if some scripts are there to look for these values) with the
> >>>> randomness of values returned by it.
> >>>
> >>> The only thing the scripts need to do is to skip zeros (or anything
> >>> less than the minimum hw frequency for that matter) coming from that
> >>> attribute.
> >>>
> >>>> On reading values locally from the CPU, I thought about the case where
> >>>> userspace can prevent a CPU going into idle just by reading its
> >>>> frequency from sysfs (and so waste power), but the same can be done by
> >>>> userspace to run arbitrary load on the CPUs.
> >>>>
> >>>> Can we do some sort of caching of the last frequency the CPU was
> >>>> running at before going into idle ? Then we can just check if cpu is
> >>>> idle and so return cached value.
> >>>
> >>> That is an option, but it looks like in this case the cpuinfo_cur_freq
> >>> attribute should not be present at all, as per the documentation.
> >>>
> >>
> >> +1 for dropping the attribute.
> >>
> >
> > I've been experimenting with some code quite recently that uses the
> > scheduler frequency scale factor to compute this hardware current rate
> > for CPPC.
> >
> > On the scheduler tick, the scale factor is computed in
> > arch_scale_freq_tick() to give an indication on delivered performance,
> > using AMUs on arm64 [1] and APERF/MPERF on x86 [2]. Basically, this scale
> > factor has the cached value of the average delivered performance between
> > the last two scheduler ticks, on a capacity scale: 0-1024. All that would
> > be needed is to convert from the scheduler frequency scale to the CPPC
> > expected performance scale.
> >
> > The gist of the code would be:
> >
> > delivered_perf = topology_get_freq_scale(cpu);
> > delivered_perf *= fb_ctrs.reference_perf;
> > delivered_perf = div64_u64(delivered_perf << SCHED_CAPACITY_SHIFT,
> >                          per_cpu(arch_max_freq_scale, cpu));
> >
> > While this solution is not perfect, it would provide the best view of
> > the hardware "current" rate without the cost of waking up the CPU when
> > idle, scheduling additional work on the CPU, doing checks on whether
> > the CPU is idle and/or providing other caching mechanisms.
>
> I think it's a good idea. It's just that the value is a average frequency in the
> last two scheduler ticks, not an instantaneous frequency. What
> 'cppc_cpufreq_get_rate()' get is also not an  instantaneous frequency. It's a
> average frequency in 2us. I check the interval between two frequency updates on
> my machine. It's about 10ms. So the frequency will change at least one time in
> two scheduler ticks if HZ is 1000.
>
> I am not sure how people will use 'cpuinfo_cur_freq'. They may not expect a very
> accurate frequency. How about we return this value when CPU is idle? Or just
> return 0 in idle is better ?

According to the documentation, if this attribute is present, it
should return the exact frequency of the CPU (with a caveat that it
may change already when user space is able to consume the value), and
which is what the users may expect.

As I said before, IMO the CPPC driver should not cause the core to
expose cpuinfo_cur_freq at all.

Thanks!
