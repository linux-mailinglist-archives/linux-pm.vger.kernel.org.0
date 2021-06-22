Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F313B07C0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 16:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhFVOqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 10:46:40 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33606 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhFVOqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 10:46:38 -0400
Received: by mail-oi1-f170.google.com with SMTP id s17so1192275oij.0;
        Tue, 22 Jun 2021 07:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XceVVVWYSn/QRpaUtGZpz57/pqLlFwPeXc0ztXrJBhU=;
        b=dhDlnSd0Ci4c7Gg2feaHKRYY4OrFMNUHwO9AcjkKIwgutbqqpVluAczjoKDbnV+4ng
         tgob3vt1Fri8g3TWBqxFgUyeVm0fD8IRMBSRS5pHv+LI/FMns0/hAIEDmRUx/51Usk15
         SQvr0rdz8qVJ5a5rGuljyxqvg7tWbyPRo5D4FJfabNBzD94SG2Uyu2z4VJgJubPAwWKg
         vkRasWvePikbBiEwYdow8upwc7l9ofyxm9dxwOGvvW3MdGiYd/g3o4v2bFLz8bLxIUdk
         Sb7DtR3iFXUgSBFmALYL3pvtqk5zwO3m+DI4/jviUIqd4N5wSTVJHcHUpVoRtiHniqhr
         cZlw==
X-Gm-Message-State: AOAM5309UmOcLLRsz2LBAxFfacz9OgUP2gvceethbPdONI3P9XE6+B73
        TRTwTQ+YnJVSWvW0uHFDRPLjCfdvXL4wqZpz1sQ=
X-Google-Smtp-Source: ABdhPJw2I6CQjD4ZFyC8bfVz3kKsv7VIhyn3IJTy0qCNaM3JmP8dtkm56H6QsjfuqT3vQL8M9WS6UIT9hj+Hc+QizT0=
X-Received: by 2002:aca:f0d5:: with SMTP id o204mr3455379oih.71.1624373062707;
 Tue, 22 Jun 2021 07:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210622075925.16189-1-lukasz.luba@arm.com> <20210622075925.16189-3-lukasz.luba@arm.com>
 <CAJZ5v0iGv_1d3BT0HowLgecOfhNHNQdOwH6Kef5WE4-zeBbp2Q@mail.gmail.com> <2f7d855c-5232-ddbe-8403-db3596dcebc5@arm.com>
In-Reply-To: <2f7d855c-5232-ddbe-8403-db3596dcebc5@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 16:44:11 +0200
Message-ID: <CAJZ5v0jExEJRM=aJhEpKoVjvppDz_x+pYG2-HSQUuehccwnVTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] cpuidle: Add Active Stats calls tracking idle entry/exit
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>, Beata.Michalska@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kachhap <amit.kachhap@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 3:59 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/22/21 1:33 PM, Rafael J. Wysocki wrote:
> > On Tue, Jun 22, 2021 at 9:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> The Active Stats framework tracks and accounts the activity of the CPU
> >> for each performance level. It accounts the real residency,
> >
> > No, it doesn't.  It just measures the time between the entry and exit
> > and that's not the real residency (because it doesn't take the exit
> > latency into account, for example).
>
> It's 'just' a 'model' and as other models has limitations, but it's
> better than existing one, which IPA has to use:
> cpu_util + currect_freq_at_sampling_time

But the idle duration is already measured by cpuidle as
last_residency_ns.  Why does it need to be measured once more in
addition to that?

> >
> >> when the CPU was not idle, at a given performance level. This patch adds needed calls
> >> which provide the CPU idle entry/exit events to the Active Stats
> >> framework.
> >
> > And it adds overhead to overhead-sensitive code.
> >
> > AFAICS, some users of that code will not really get the benefit, so
> > adding the overhead to it is questionable.
> >
> > First, why is the existing instrumentation in the idle loop insufficient?
>
> The instrumentation (tracing) cannot be used at run time AFAIK. I need
> this idle + freq information combined in a running platform, not for
> post-processing (like we have in LISA). The thermal governor IPA would
> use them for used power estimation.

What about snapshotting last_residency_ns in the CPU wakeup path?

> >
> > Second, why do you need to add locking to this code?
>
> The idle entry/exit updates the CPU's accounting data structure.
> There is a reader of those data structures: thermal governor,
> run from different CPU, which is the reason why I put locking for them.

So please consider doing it in a lockless manner and avoid running
this code when it is not needed in the first place.
