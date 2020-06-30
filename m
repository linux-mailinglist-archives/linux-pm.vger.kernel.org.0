Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B785320FBE5
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgF3Siy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 14:38:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42919 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgF3Six (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2020 14:38:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id 76so4810781otu.9;
        Tue, 30 Jun 2020 11:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4CE/0puyHhDFR+hvTXHPqKihS4zRWzdZIBdwpMjjPI=;
        b=OxbORm8dMOWa4dr6NIJr8n/khyXOT8tZbcVt4tBZjIJg3uoo7XuzmaRdRGzsseTjyY
         VvQZizZjWqW5XTR9fn0s9mlVfYRIDBrQybz6OkzJ8xTavAymm+7x6rJahUA79YltJjqd
         5M3F4W/5s2AC78HS/PjCJWvlrybfClJpdqOUjhkg+oXOJu8xvvQ/gpwH0TgR4xLBHw1n
         asCR1VizOWlpawo9A8JwqosuYFU5EqOFTFpm7TEe8LZFrw00BCuUkt56opkF+i8jJnNs
         VCoVE9FPWjwt19XK28GY08ITsQMZRFgn+z6VOc8oFBo9A6PiycVT9DGZ8D6y8VHZvj2Q
         hIzw==
X-Gm-Message-State: AOAM530DDhAGDJTI0KRG6F4ry9AzH6RFx7FNsPpbKZLz9tVFiUzlXnwE
        QZzAZcLMH4QmsFuWMTHXtCqgfofz1KHOH/cua8g=
X-Google-Smtp-Source: ABdhPJySOGPpCYIMPEpa4NqaFUumrZMT0Y1q+t1uhnyYXYD7Q0zC+lTmDJBQPsveJWJkDKW5dW8oyRZX6fbr/yadk7A=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr1714092ota.167.1593542332362;
 Tue, 30 Jun 2020 11:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593418662.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1593418662.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 20:38:41 +0200
Message-ID: <CAJZ5v0jmYDmSRX4UkXGH7HrnrRX-9ZGF6G-Z2LQuVyTWMp8eww@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] cpufreq: Allow default governor on cmdline and fix
 locking issues
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Todd Kjos <tkjos@google.com>, adharmap@codeaurora.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 29, 2020 at 10:58 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> I have picked Quentin's series over my patch, modified both and tested.
>
> V3->V4:
> - Do __module_get() for cpufreq_default_governor() case as well and get
>   rid of an extra variable.
> - Use a single character array, default_governor, instead of two of them.
>
> V2->V3:
> - default_governor is a string now and we don't set it on governor
>   registration or unregistration anymore.
> - Fixed locking issues in cpufreq_init_policy().
>
> --
> Viresh
>
> Original cover letter fro Quentin:
>
> This series enables users of prebuilt kernels (e.g. distro kernels) to
> specify their CPUfreq governor of choice using the kernel command line,
> instead of having to wait for the system to fully boot to userspace to
> switch using the sysfs interface. This is helpful for 2 reasons:
>   1. users get to choose the governor that runs during the actual boot;
>   2. it simplifies the userspace boot procedure a bit (one less thing to
>      worry about).
>
> To enable this, the first patch moves all governor init calls to
> core_initcall, to make sure they are registered by the time the drivers
> probe. This should be relatively low impact as registering a governor
> is a simple procedure (it gets added to a llist), and all governors
> already load at core_initcall anyway when they're set as the default
> in Kconfig. This also allows to clean-up the governors' init/exit code,
> and reduces boilerplate.
>
> The second patch introduces the new command line parameter, inspired by
> its cpuidle counterpart. More details can be found in the respective
> patch headers.
>
> Changes in v2:
>  - added Viresh's ack to patch 01
>  - moved the assignment of 'default_governor' in patch 02 to the governor
>    registration path instead of the driver registration (Viresh)
>
> Quentin Perret (2):
>   cpufreq: Register governors at core_initcall
>   cpufreq: Specify default governor on command line
>
> Viresh Kumar (1):
>   cpufreq: Fix locking issues with governors
>
>  .../admin-guide/kernel-parameters.txt         |  5 ++
>  Documentation/admin-guide/pm/cpufreq.rst      |  6 +-
>  .../platforms/cell/cpufreq_spudemand.c        | 26 +-----
>  drivers/cpufreq/cpufreq.c                     | 87 ++++++++++++-------
>  drivers/cpufreq/cpufreq_conservative.c        | 22 ++---
>  drivers/cpufreq/cpufreq_ondemand.c            | 24 ++---
>  drivers/cpufreq/cpufreq_performance.c         | 14 +--
>  drivers/cpufreq/cpufreq_powersave.c           | 18 +---
>  drivers/cpufreq/cpufreq_userspace.c           | 18 +---
>  include/linux/cpufreq.h                       | 14 +++
>  kernel/sched/cpufreq_schedutil.c              |  6 +-
>  11 files changed, 100 insertions(+), 140 deletions(-)
>
> --

All three patches applied as 5.9 material, thanks!
