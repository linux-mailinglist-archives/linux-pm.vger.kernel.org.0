Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11403BE914
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhGGN4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhGGN4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 09:56:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2105C061574
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 06:54:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q18so4191646lfc.7
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcEZkwLs+Fpl1nceNhi+IHsXytH/BS7pSdCOP46nwS8=;
        b=J9l+mpUMTfvqLDmLvM31KUzyWqn+aq4ujZ6cHj2NZYTanNHIyhxkbIPp9I5M2um5dp
         jl1a4d/W+zh/syUSDqZjU5/U6kVIbodiqpGXOU7IjWI2k5Y7MD6N5qiNePj9pCihw7kN
         jHul16Ap7QaZrHNkM7GEPRtJjAnWR4YtHwVGj7rA5G7WoLYmFlSCqlGRV2EeHcgGigk4
         JOgmf/bg6nkQM3Qj1HGrpY6wuUqz4RujD9vzN+5gFGujq1UEpxVpQyGGpcf1nm8boQZV
         1pKwikP/goLJ/yeQOTuDfMAo4DDOYo333jmUEgWMzpqxPsks/qWOKc1iG/sxQRXeUHki
         uZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcEZkwLs+Fpl1nceNhi+IHsXytH/BS7pSdCOP46nwS8=;
        b=O3VcmBPT0QBBlxOLtGExPFrz7GIC8Ltt+0z5XxrUrrOXKDnpphtxuCFvNC1d1DGPfZ
         ApF3F+Jr1qQg9nA1jLB7WOW1R7nhFuvE2fAV1ISbr61P06BVpgz1jLI5sb2Tl9dbWSQQ
         4EOQmSWAHA7+wT9B548bEjkZAoQOLwccCZLgI6gjAMlYyGVivfS4ItxBrs9JftKfze2N
         rphbUgRUYB1PR7E2DKwlmKYF7cCEwQaUoqKUQMPBV4i++8CKjZnkDMikYz40SYBbEtVx
         x+bSFZ0r9N5X6WBpifNglWp9P6OuQJTIZQSQ2cVI+CX4xvWuEGji2QpY1XcMyqDs/wMb
         FdJg==
X-Gm-Message-State: AOAM533KUXujnk+8HCgn6xHWa7Z/5R0Co/BwM8KLO656ABuK9exaXnQP
        zcFu4W27JH5c5Z1m2lxfKXnb1HV810RqMSX9GcbXQQ==
X-Google-Smtp-Source: ABdhPJziIHuDk3QTEhNkB8QyPJVN8Tj7rlHy8SnXjNs5Bc05mgG+iHNERzVY//0Dd0SbxT4DXAD+Bsn5Qo7oEv4rbh4=
X-Received: by 2002:a05:6512:3c99:: with SMTP id h25mr7823582lfv.277.1625666039231;
 Wed, 07 Jul 2021 06:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com> <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com> <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
 <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com> <CAKfTPtCEo+gkV2TMhOHSnuUyu5BC54o-B4Hb=QbzgT6Dft-PhQ@mail.gmail.com>
 <27916860-33b1-f0a0-acff-4722a733c81b@arm.com> <CAKfTPtB2ogGbGBjJNRBB5jvN24q-tXFR+BpJ31fzsTd2=pDTHQ@mail.gmail.com>
 <ee3ebbaa-7b6d-416d-2caa-197c2713dd4e@arm.com> <CAKfTPtAN6-ytxa2Qj3=z27e8ZBoqGrWAZce9CojL3wbZSotUsQ@mail.gmail.com>
 <58cb7ad3-ffff-8940-4c8e-2c46dcc86d54@arm.com> <CAKfTPtCy-dbo0xnW8iKaQy94_iV=JYbMU-X4qanzL6RXcL7xEw@mail.gmail.com>
 <e3b11a84-9a26-9a7d-cf90-12a7a8fbcc3f@arm.com>
In-Reply-To: <e3b11a84-9a26-9a7d-cf90-12a7a8fbcc3f@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 15:53:48 +0200
Message-ID: <CAKfTPtD-i0K=ofKEekoCzAm2eXR+vVzFxR-uc6Em4LMO8W=RFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 7 Jul 2021 at 13:02, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 11:50 AM, Vincent Guittot wrote:
> > On Wed, 7 Jul 2021 at 12:41, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 7/7/21 11:32 AM, Vincent Guittot wrote:
> >>> On Wed, 7 Jul 2021 at 12:29, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/7/21 11:11 AM, Vincent Guittot wrote:
> >>>>> On Wed, 7 Jul 2021 at 12:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>>>
> >>>>
> >>>> [snip]
> >>>>
> >>>>>> No. It's in 0.1uW scale, so 800Watts. Which is 16 CPUs * 64Watts
> >>>>>
> >>>>> Oh! you want 0.1uW precision .... This doesn't seem realistic at all.
> >>>>> I'm not even sure that the power model can even reach an accuracy of
> >>>>> 1mW
> >>>>>
> >>>>
> >>>> True, the EM is registering platform with 1mW precision, but 1uW
> >>>
> >>> Do you mean 1uW or 0.1uW ?
> >>
> >> In this patch set I've proposed 0.1uW, but I'm open to drop one
> >> order of magnitude. The 1uW still be good.
> >
> > I don't want to underestimate the capabilities of the power model but
> > I don't see which benefit you will get with 0.1uW precision
> > With a 1uW precision the long type currently used for the returned
> > value is fine for 32bits machine AFAICT
> >
>
> For 1uW and 1.2Watts for one core, 4 CPUs in cluster we get:
> (1200 * 1000) * (4 * 1024) = ~4.9bln
> so it would need div 64 version

But as stated before, this is an internal computation step and doesn't
have to be reflected in the returned value which can stay a long
