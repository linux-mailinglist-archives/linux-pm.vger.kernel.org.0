Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74641114074
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 13:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfLEMCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 07:02:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43548 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfLEMCj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 07:02:39 -0500
Received: by mail-oi1-f194.google.com with SMTP id t25so2449992oij.10;
        Thu, 05 Dec 2019 04:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4JBrJi4italcxK/kzI1J1A3u7tKS51hMCOK7qyK8eo=;
        b=F3DEMr99Al8FPSdcIoKkUXHu5xCy588SuaLkYCgD0qUdDU7wCLnqnh9dw2E4unrPM7
         DnNVzlDTJ3fnryabG+4eAMAzS9ASfTV13GvXRSW3i93HXZLETE7UWfCPm3V9WHkO3rQq
         VMZry/vc8bESLSqVMrvIM/h2X6pZXW/KP1xnUszpee2GtBHGzxQ7FWkMiK6uBPuuNqMz
         TWrWGzIadbpMtbiwji7PWu5rt5VEUBaTlXVXZ6q6SqQv07KILu3PjjH/MgapBFeBUf7i
         Z20ZY4SchUxEg8WGzJqcmrLjljJuTgGxxtuiQ4jwT+sTVuZM5cTErVj5noDDdPllXPy+
         Nslw==
X-Gm-Message-State: APjAAAW/GB35EC5sy6Fx1a9HFJCr06QG4TNgJlPpdTnyY5OW/sDXELVU
        /MleQph+yekMeWTV6fjbHoHB47B5JHt/epjlyl8=
X-Google-Smtp-Source: APXvYqw0NIqxRA57oNXeV+MvVIqGh9BQND6B0pTyBYHoN+ZmJXKGo8Oq2lIjQv7g2g1RsP3GbRXIkJfuUnlwDchRcX4=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr1049809oih.57.1575547358310;
 Thu, 05 Dec 2019 04:02:38 -0800 (PST)
MIME-Version: 1.0
References: <5961586.ml7s97geqL@kreacher> <3690440.Wzkxfdnirm@kreacher> <6c7863ab-8efc-ab2c-cab0-3cd68e415a57@linaro.org>
In-Reply-To: <6c7863ab-8efc-ab2c-cab0-3cd68e415a57@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Dec 2019 13:02:27 +0100
Message-ID: <CAJZ5v0iPyY0075NeAZnguLJfQZSHjgMiLAi4YHwyfwd7a8E_uQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: Drop disabled field from struct cpuidle_state
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 5, 2019 at 12:15 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/11/2019 19:41, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After recent cpuidle updates the "disabled" field in struct
> > cpuidle_state is only used by two drivers (intel_idle and shmobile
> > cpuidle) for marking unusable idle states, but that may as well be
> > achieved with the help of a state flag, so define an "unusable" idle
> > state flag, CPUIDLE_FLAG_UNUSABLE, make the drivers in question use
> > it instead of the "disabled" field and make the core set
> > CPUIDLE_STATE_DISABLED_BY_DRIVER for the idle states with that flag
> > set.
> >
> > After the above changes, the "disabled" field in struct cpuidle_state
> > is not used any more, so drop it.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Changes from RFC:
> >
> >  - Do not add extra braces (unrelated to the rest of the patch).
> >
> > ---
> >  arch/sh/kernel/cpu/shmobile/cpuidle.c |    8 ++++----
> >  drivers/cpuidle/cpuidle.c             |    2 +-
> >  drivers/cpuidle/poll_state.c          |    1 -
> >  drivers/idle/intel_idle.c             |    6 +++---
> >  include/linux/cpuidle.h               |    2 +-
> >  5 files changed, 9 insertions(+), 10 deletions(-)
> >
> > Index: linux-pm/drivers/idle/intel_idle.c
> > ===================================================================
> > --- linux-pm.orig/drivers/idle/intel_idle.c
> > +++ linux-pm/drivers/idle/intel_idle.c
> > @@ -1291,8 +1291,8 @@ static void sklh_idle_state_table_update
> >                       return;
> >       }
> >
> > -     skl_cstates[5].disabled = 1;    /* C8-SKL */
> > -     skl_cstates[6].disabled = 1;    /* C9-SKL */
> > +     skl_cstates[5].flags |= CPUIDLE_FLAG_UNUSABLE;  /* C8-SKL */
> > +     skl_cstates[6].flags |= CPUIDLE_FLAG_UNUSABLE;  /* C9-SKL */
> >  }
> >  /*
> >   * intel_idle_state_table_update()
> > @@ -1355,7 +1355,7 @@ static void __init intel_idle_cpuidle_dr
> >                       continue;
> >
> >               /* if state marked as disabled, skip it */
> > -             if (cpuidle_state_table[cstate].disabled != 0) {
> > +             if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
> >                       pr_debug("state %s is disabled\n",
> >                                cpuidle_state_table[cstate].name);
> >                       continue;
> > Index: linux-pm/include/linux/cpuidle.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/cpuidle.h
> > +++ linux-pm/include/linux/cpuidle.h
> > @@ -54,7 +54,6 @@ struct cpuidle_state {
> >       unsigned int    exit_latency; /* in US */
> >       int             power_usage; /* in mW */
> >       unsigned int    target_residency; /* in US */
> > -     bool            disabled; /* disabled on all CPUs */
> >
> >       int (*enter)    (struct cpuidle_device *dev,
> >                       struct cpuidle_driver *drv,
> > @@ -77,6 +76,7 @@ struct cpuidle_state {
> >  #define CPUIDLE_FLAG_POLLING BIT(0) /* polling state */
> >  #define CPUIDLE_FLAG_COUPLED BIT(1) /* state applies to multiple cpus */
> >  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
> > +#define CPUIDLE_FLAG_UNUSABLE        BIT(3) /* avoid using this state */
> >
> >  struct cpuidle_device_kobj;
> >  struct cpuidle_state_kobj;
> > Index: linux-pm/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > ===================================================================
> > --- linux-pm.orig/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > +++ linux-pm/arch/sh/kernel/cpu/shmobile/cpuidle.c
> > @@ -67,7 +67,7 @@ static struct cpuidle_driver cpuidle_dri
> >                       .enter = cpuidle_sleep_enter,
> >                       .name = "C2",
> >                       .desc = "SuperH Sleep Mode [SF]",
> > -                     .disabled = true,
> > +                     .flags = CPUIDLE_FLAG_UNUSABLE,
> >               },
> >               {
> >                       .exit_latency = 2300,
> > @@ -76,7 +76,7 @@ static struct cpuidle_driver cpuidle_dri
> >                       .enter = cpuidle_sleep_enter,
> >                       .name = "C3",
> >                       .desc = "SuperH Mobile Standby Mode [SF]",
> > -                     .disabled = true,
> > +                     .flags = CPUIDLE_FLAG_UNUSABLE,
> >               },
> >       },
> >       .safe_state_index = 0,
> > @@ -86,10 +86,10 @@ static struct cpuidle_driver cpuidle_dri
> >  int __init sh_mobile_setup_cpuidle(void)
> >  {
> >       if (sh_mobile_sleep_supported & SUSP_SH_SF)
> > -             cpuidle_driver.states[1].disabled = false;
> > +             cpuidle_driver.states[1].flags = CPUIDLE_FLAG_NONE;
>
> That will overwrite other flags value, bit operation should be used here
> to remove CPUIDLE_FLAG_UNUSABLE.

This is based on the observation that the other flags are not set by
this driver anyway.
