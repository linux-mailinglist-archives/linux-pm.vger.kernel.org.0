Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A541437E6
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 08:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAUHwB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 02:52:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35267 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgAUHwB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 02:52:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id k4so1742404oik.2;
        Mon, 20 Jan 2020 23:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDgz85X+/B08T8yz6srovuNqFf4QQmdWLURf7KUyCg4=;
        b=DX7yvMs6jtv6wWHAQqV+zTc3NJwn9ypoxqilXVkC8KM0zva8i489rLvnu93IhQ/RzV
         +rGcycDLij8o201FCJRtTWiO5tbv0tIJ4LtPnIyUE8zxIGU5XVemCPuXtdFCDCKYPx1j
         cBBMVi4eIVgmibt8YNwRO1gIm0ulZjHZ0b+bGhvqLvfLu01dHwb951mdKK+srQ0Nm7u2
         qIcdNDAfu7wHVlUUoB+pgiAnPW9yGGB+em4S6zg6zqUKxgwBsfR7xBelB+pc45zZYgzr
         VgYO2IkHpJfG4Ae3QR+NWALbhHmAIsBgm5IpColswbBkYr83XPvHZbq52L49lMKvQ/IO
         YAmA==
X-Gm-Message-State: APjAAAULxKMm6KGbIK3HmGbf5F1QVxWBx/wrXkcllt9pB7CVWUPK2QbM
        CpWSEf3TP5sTjlLXXOdY1vUDs1urXBIYOR/YL9g=
X-Google-Smtp-Source: APXvYqyEbiPJtyFwuk87U9zx0TmCGKo8t1J113p1j6w4+uDnAhXGqiiKQtaWsyvl7UxuVjAHkm7/BGrTOtclPJ+xaoc=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr1990188oia.148.1579593120705;
 Mon, 20 Jan 2020 23:52:00 -0800 (PST)
MIME-Version: 1.0
References: <201911151357.A9MjGImg%lkp@intel.com> <CAMuHMdX6-jb1W8uC2_237m8ctCpsnGp=JCxqt8pCWVqNXHmkVg@mail.gmail.com>
 <CAJZ5v0i4nezntZJRSpv-LOwE_ZkE5Vr+YHkwJ8tX5GgG64gB=Q@mail.gmail.com> <22577568.Kaohy42qHH@kreacher>
In-Reply-To: <22577568.Kaohy42qHH@kreacher>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Jan 2020 08:51:49 +0100
Message-ID: <CAMuHMdVDmdhEQKkkw9Ap5nSwMNH-jGb1TcMRgoQjPk44RwdY5w@mail.gmail.com>
Subject: Re: drivers/acpi/processor_thermal.c:66:1: warning: the frame size of
 2160 bytes is larger than 2048 bytes
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Tue, Jan 21, 2020 at 1:40 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, January 20, 2020 11:16:12 AM CET Rafael J. Wysocki wrote:
> > On Fri, Jan 17, 2020 at 4:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Nov 15, 2019 at 6:23 AM kbuild test robot <lkp@intel.com> wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   96b95eff4a591dbac582c2590d067e356a18aacb
> > > > commit: 3000ce3c52f8b8db093e4dc649cd172390f71137 cpufreq: Use per-policy frequency QoS
> > > > date:   4 weeks ago
> > > > config: ia64-randconfig-a001-20191115 (attached as .config)
> > > > compiler: ia64-linux-gcc (GCC) 7.4.0
> > > > reproduce:
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         git checkout 3000ce3c52f8b8db093e4dc649cd172390f71137
> > > >         # save the attached .config to linux build tree
> > > >         GCC_VERSION=7.4.0 make.cross ARCH=ia64
> > > >
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > Seeing similar warnings on arm64, so this triggered my attention.
> > >
> > > > --
> > > >    drivers/cpufreq/cpufreq.c: In function 'refresh_frequency_limits.part.33':
> > > > >> drivers/cpufreq/cpufreq.c:1116:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> > >
> > > |       struct cpufreq_policy new_policy;
> > >
> > > That's a large struct on the stack...
> > >
> > > |       if (!policy_is_inactive(policy)) {
> > > |               new_policy = *policy;
> > >
> > > Let's make a copy?
> > > How well does this work, given struct cpufreq_policy contains a
> > > work_struct, list_head, kobject, completion, semaphore, spinlock_t,
> > > wait_queue_head_t, and two notifier_blocks, which are all objects you
> > > cannot just copy and reuse?
> > >
> > > |               pr_debug("updating policy for CPU %u\n", policy->cpu);
> > > |
> > > |               cpufreq_set_policy(policy, &new_policy);
> > >
> > > If cpufreq_set_policy() uses only a few fields from new_policy,
> >
> > That's really the case.
> >
> > > it might be a good idea to extract those into its own structure.
> >
> > Or organize the code differently.
> >
> > This is old code that hasn't been change, but I'll look at it since it
> > is problematic.
>
> So what about the patch below (untested)?
>
> It should be mostly self-explanatory, and the point is basically that
> cpufreq_set_policy() gets the limits values from freq QoS, so it only
> needs to get the new governor/policy value from the caller and more
> data need to be passed to the driver's ->verify() callback.

Thanks, LGTM!
No Rb, as I'm not that familiar with the code, and only browsed through
the core parts.

I can confirm it gets rids of the -Wframe-larger-than warnings on arm64,
though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
