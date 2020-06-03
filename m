Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945B51ED103
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFCNkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 09:40:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46329 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgFCNkC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 09:40:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id 25so899009oiy.13;
        Wed, 03 Jun 2020 06:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtRjhLaAAXrKs3rcG85ERI4DR22fXXuoilSjsbEiHeg=;
        b=fxH11YFr76LFMpYXBHGs8JZ6LozbXxhqQ8niywQHPznjnQQ3gyDWyoeQ5WlkJdVOBT
         ZuNmeafBTSvXH3Lg3BmmzdpCAL3aAQLCfKe5Hbwyi4BJ+14mBhPZUZO/0HhvxGzbnk3X
         HLv36Miuat40mkksoJt+tXQ0CW6r/7Qf3Etrwj1a/3tp32nGbCw/+CWlfrRL+xEwSesS
         eQkgdMPEGCltntto848scIqS7xlT+HlFobfodSaz6e8hXd4ywQXgCi3Zgx5quwVivQ6j
         6S/za8z90qUtJKdl8d5I7v8UxvgkO2/XRDqYCuKC+zXd7mhua61o9grIrJPDpjyfjG1z
         m7wA==
X-Gm-Message-State: AOAM532Hz6jsBOJd67DpZTKQ6ttlauHd5CCUy1Mi4FrjhQUZoYRuSx4h
        AhEfckdjibiQ1goQ31jerlSE+3XrgGmmoOA3naY=
X-Google-Smtp-Source: ABdhPJw2Ggs2UAYrV1Zmdg+DmF9enY2HudhpmMbzKPc6AAo+xShivMecWM1sRR3PTOj/anHdgZiDRHEDySOecdlpZJE=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr6530787oie.103.1591191601127;
 Wed, 03 Jun 2020 06:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com> <20200603075200.hbyofgcyiwocl565@vireshk-i7>
In-Reply-To: <20200603075200.hbyofgcyiwocl565@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 15:39:46 +0200
Message-ID: <CAJZ5v0iR3H+PFnJiroNmZcj-a4bCkvT6xB-nd2ntMvakWFOvAg@mail.gmail.com>
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 3, 2020 at 9:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-06-20, 11:34, Xiongfeng Wang wrote:
> > Hi Viresh,
> >
> > Sorry to disturb you about another problem as follows.
> >
> > CPPC use the increment of Desired Performance counter and Reference Performance
> > counter to get the CPU frequency and show it in sysfs through
> > 'cpuinfo_cur_freq'. But ACPI CPPC doesn't specifically define the behavior of
> > these two counters when the CPU is in idle state, such as stop incrementing when
> > the CPU is in idle state.
> >
> > ARMv8.4 Extension inctroduced support for the Activity Monitors Unit (AMU). The
> > processor frequency cycles and constant frequency cycles in AMU can be used as
> > Delivered Performance counter and Reference Performance counter. These two
> > counter in AMU does not increase when the PE is in WFI or WFE. So the increment
> > is zero when the PE is in WFI/WFE. This cause no issue because
> > 'cppc_get_rate_from_fbctrs()' in cppc_cpufreq driver will check the increment
> > and return the desired performance if the increment is zero.
> >
> > But when the CPU goes into power down idle state, accessing these two counters
> > in AMU by memory-mapped address will return zero. Such as CPU1 went into power
> > down idle state and CPU0 try to get the frequency of CPU1. In this situation,
> > will display a very big value for 'cpuinfo_cur_freq' in sysfs. Do you have some
> > advice about this problem ?
> >
> > I was thinking about an idea as follows. We can run 'cppc_cpufreq_get_rate()' on
> > the CPU to be measured, so that we can make sure the CPU is in C0 state when we
> > access the two counters. Also we can return the actual frequency rather than
> > desired performance when the CPU is in WFI/WFE. But this modification will
> > change the existing logical and I am not sure if this will cause some bad effect.
> >
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 257d726..ded3bcc 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -396,9 +396,10 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
> >         return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
> >  }
> >
> > -static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> > +static int cppc_cpufreq_get_rate_cpu(void *info)
> >  {
> >         struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> > + unsigned int cpunum = *(unsigned int *)info;
> >         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> >         int ret;
> >
> > @@ -418,6 +419,22 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> >         return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
> >  }
> >
> > +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> > +{
> > + unsigned int ret;
> > +
> > + ret = smp_call_on_cpu(cpunum, cppc_cpufreq_get_rate_cpu, &cpunum, true);
> > +
> > + /*
> > +  * convert negative error code to zero, otherwise we will display
> > +  * an odd value for 'cpuinfo_cur_freq' in sysfs
> > +  */
> > + if (ret < 0)
> > +         ret = 0;
> > +
> > + return ret;
> > +}
> > +
> >  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> >  {
> >         struct cppc_cpudata *cpudata;
>
> I don't see any other sane solution, even if this brings the CPU back
> to normal state and waste power. We should be able to reliably provide
> value to userspace.
>
> Rafael / Sudeep: What you do say ?

The frequency value obtained by kicking the CPU out of idle
artificially is bogus, though.  You may as well return a random number
instead.

The frequency of a CPU in an idle state is in fact unknown in the case
at hand, so returning 0 looks like the cleanest option to me.

Thanks!
