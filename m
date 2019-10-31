Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16CEA9F7
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 05:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfJaEoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 00:44:08 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35703 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfJaEoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 00:44:08 -0400
Received: by mail-vs1-f66.google.com with SMTP id k15so3248199vsp.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSmWUE5CWichZhorX+55ZMLpjQalQ+giQWwoK8E5DBs=;
        b=uLXw2V904nlYKDyGs7+03vpTybp9imp69onWRxi5LnYo/gQ/0tRaV30wNRVWnbqzkR
         yi2cBc2+H/thF2p6ll4zVGL4SoWukUqJblmt0/6l56k0FqNASTUyqnEgAA1yeDlegI7o
         ep1Ph1/xVKjDP2yDo1I69libARWuTwjYkSv5iSkUfc0aEMTO/rcr4fRpLG8CUHjK8nob
         KNFueQNCpG7agYHiUD1f0qA7GEP/wfqr1+8DHEq8zwSzHbbpWh/CTpOAoLba1HYN0F8H
         2M9m94Qbhc6R/TzTKRgI9GkyayueiV+hwZmbpmQjFhCNZYpSgjFMhoWA+d5IilChshgK
         rj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSmWUE5CWichZhorX+55ZMLpjQalQ+giQWwoK8E5DBs=;
        b=FkLeRjopteDvWWpSKzbxrsfuh7/uZ7Tr38hfoqAeKpIvYaZ0z8k4SHOnAwB8YZrRcb
         pD9GKS9cUGloewi3cVN+pc+cpoydAN48j+2OPYkpxpAiqp3a0bzZGXgAaqUqBO0d5tpx
         uZFVYKtzhvaV0/9+Uwd9/dp9sjmhR31Q4B1PacWB7ZMP8Ytbf5PDruSAKrw7dtZsp0vJ
         qMvQuT1KmBixptiiaLlPFjAQmtx7nv56W9iCp8mt1ObPZuitBBYflDWi+jrTs3nCteIz
         eqL/UFzzvyASAg6grSEHoEPBU8RTQYaF4rH03dgTu57Nzsix3QPWQVkKmMyjsdYEl3rA
         eF1Q==
X-Gm-Message-State: APjAAAXadmdnUY55HI25lc9tsqKXMKvHdshlU9JJ11P2C8mGIUnXU5ez
        tolWn0v3pGx5+tHp1Cm+0+OhqaRPq7/6M8jFj/bB2g==
X-Google-Smtp-Source: APXvYqymGEbluLxhfYWqSz8igslfm5GCyFzNh+plgN1+M3mEWoUW2BmZ6Kvloy7vw2iDYKUG+MxHDSQGtVOBQzvkTpU=
X-Received: by 2002:a67:b60c:: with SMTP id d12mr1611322vsm.159.1572497046919;
 Wed, 30 Oct 2019 21:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571656014.git.amit.kucheria@linaro.org> <4efc55ad929dbb3432e72b96cb27876efa496242.camel@intel.com>
In-Reply-To: <4efc55ad929dbb3432e72b96cb27876efa496242.camel@intel.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 31 Oct 2019 10:13:55 +0530
Message-ID: <CAHLCerPNDJCjaUakCu-0woqy+kJM0LK9vieYKqncnNbAsH83qw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Initialise thermal framework and cpufreq earlier
 during boot
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rui,

I'm assuming that since Rafael acked it, he is ok with this going thru
the thermal tree.

Regards,
Amit

On Thu, Oct 31, 2019 at 8:12 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Hi,
>
> Given that all the patches in this series have got the ACK from the
> subsystem maintainers, I suppose we can take all the patches through
> thermal tree, right?
>
> thanks,
> rui
>
> On Mon, 2019-10-21 at 17:45 +0530, Amit Kucheria wrote:
> > Changes since v4:
> > - Collect Acks
> > - Pick the US spelling for 'initialis^Hze' consistently.
> >
> > Changes since v3:
> > - Init schedutil governor earlier too
> > - Simplified changes to thermal_init() error path
> > - Collects Acks
> >
> > Changes since v2:
> > - Missed one patch when posting v2. Respinning.
> >
> > Changes since v1:
> > - Completely get rid of netlink support in the thermal framework.
> > - This changes the early init patch to a single line - change to
> >   core_initcall. Changed authorship of patch since it is nothing like
> > the
> >   original. Lina, let me know if you feel otherwise.
> > - I've tested to make sure that the qcom-cpufreq-hw driver continues
> > to
> >   work correctly as a module so this won't impact Android's GKI
> > plans.
> > - Collected Acks
> >
> > Device boot needs to be as fast as possible while keeping under the
> > thermal
> > envelope. Now that thermal framework is built-in to the kernel, we
> > can
> > initialize it earlier to enable thermal mitigation during boot.
> >
> > We also need the cpufreq HW drivers to be initialised earlier to act
> > as the
> > cooling devices. This series only converts over the qcom-hw driver to
> > initialize earlier but can be extended to other platforms as well.
> >
> > Amit Kucheria (6):
> >   thermal: Remove netlink support
> >   thermal: Initialize thermal subsystem earlier
> >   cpufreq: Initialize the governors in core_initcall
> >   cpufreq: Initialize cpufreq-dt driver earlier
> >   clk: qcom: Initialize clock drivers earlier
> >   cpufreq: qcom-hw: Move driver initialization earlier
> >
> >  .../driver-api/thermal/sysfs-api.rst          |  26 +----
> >  drivers/clk/qcom/clk-rpmh.c                   |   2 +-
> >  drivers/clk/qcom/gcc-qcs404.c                 |   2 +-
> >  drivers/clk/qcom/gcc-sdm845.c                 |   2 +-
> >  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +-
> >  drivers/cpufreq/cpufreq_conservative.c        |   2 +-
> >  drivers/cpufreq/cpufreq_ondemand.c            |   2 +-
> >  drivers/cpufreq/cpufreq_performance.c         |   2 +-
> >  drivers/cpufreq/cpufreq_powersave.c           |   2 +-
> >  drivers/cpufreq/cpufreq_userspace.c           |   2 +-
> >  drivers/cpufreq/qcom-cpufreq-hw.c             |   2 +-
> >  drivers/thermal/thermal_core.c                | 103 +---------------
> > --
> >  include/linux/thermal.h                       |  11 --
> >  kernel/sched/cpufreq_schedutil.c              |   2 +-
> >  14 files changed, 19 insertions(+), 143 deletions(-)
> >
>
