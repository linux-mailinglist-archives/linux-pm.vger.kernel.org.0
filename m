Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6A3BA3B3
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 19:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGBRlA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Jul 2021 13:41:00 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45733 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBRk7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jul 2021 13:40:59 -0400
Received: by mail-oi1-f175.google.com with SMTP id w127so12136120oig.12
        for <linux-pm@vger.kernel.org>; Fri, 02 Jul 2021 10:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8yCYOftTNdDxai21gJ3SRTtG4Oc7qpng9RUOAeJqak=;
        b=aQL057sMMvRw5KiiORqJfupm7IBWF67XHgLV/qs10nlpmjwqliGoNfwofT7VHZ0xfc
         yZr8EbOmzRW/W3yKErp58hHsfdMtgir9Ot2MyLFJBAQR4TCwATJl1oIoqpRmC0ar4Me7
         N/yUi6jWsjKkfm4/xJAiXdI7dCF7X7iYmX2XKsHVagXg79rv2fRE3zp1M7pkMqdRTqDC
         hMcjtsvTjZldN8AfCcuLOI5wAEQL4uip73a5fpzD9lUyGZG5SZ+6Bb7cpeJhI8QPw52n
         +fDt11fO5G8IJiKfCLJ0YEiFsfUDKm41QifRk5W6wPqFaylLujuOWagiHzN7WntbkQRS
         5s/A==
X-Gm-Message-State: AOAM533t9j0YLWnJ6hXR/jD479AI0vae+AtXlzf0CxmHputQXHP2IsSe
        +N9mgvJTnYxjZkQy3iO8HsoSZx7bUKsWic20usw=
X-Google-Smtp-Source: ABdhPJygmce/q1/Fl515WOVOIc5WAjjr7tl4sedEbxkttImJPmGFmICm/g/UgrzH/iELTcoD6V/AOfoxIeGGv3UuxdA=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr728804oiw.157.1625247507231;
 Fri, 02 Jul 2021 10:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210615101706.mabloqrmakeiwcf5@vireshk-i7> <20210615171530.GA277695@e120877-lin.cambridge.arm.com>
 <20210616073500.b5wazdssoa5djp5o@vireshk-i7> <a4971ab0-87d7-4457-49ec-ce20106be358@arm.com>
 <20210616093127.lfpi4rje56b3dhwx@vireshk-i7> <ff9a9daa-7d25-ea08-2cd9-fc56f778acde@arm.com>
 <20210616105327.wnppsau4gg5ihrlv@vireshk-i7> <4d975236-943c-ea82-547b-04f2bead9f48@arm.com>
 <0a930559-a648-c20d-f3f6-09e4974a031d@arm.com> <CAJZ5v0iMHeAOpDStN_qZLbM7-My4rQuAC9nEcT3sHCC33bH3NA@mail.gmail.com>
 <20210702161351.GA102441@e120877-lin.cambridge.arm.com>
In-Reply-To: <20210702161351.GA102441@e120877-lin.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Jul 2021 19:38:16 +0200
Message-ID: <CAJZ5v0jzZRHx8urrJrigmpjoz7nqjGJYiy2Thy1ESaiQrSFHVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient frequencies
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 2, 2021 at 6:14 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> Hi Rafael,
>
> > >
> > > It would be great if you could have a look.
> > > I will be grateful for your time spend on it and opinion.
> >
> > First of all, IMO checking whether or not a given frequency is
> > "efficient" doesn't belong to cpufreq governors.  The governor knows
> > what the min and max supported frequencies are and selects one from
> > that range and note that it doesn't even check whether or not the
> > selected frequency is present in the frequency table.  That part
> > belongs to the driver or the general frequency table handling in the
> > cpufreq core.
> >
> > So the governor doesn't care and it shouldn't care IMO.
>
> A governor such as userspace should probably be able select any frequency
> with no regard to efficiency.

You seem to be arguing that the decision whether or not to use
inefficient frequencies needs to be made at the governor level,
because the driver must use whatever frequency is selected by the
userspace governor, since the user process driving it may be assuming
that to be the case.

That's why you want to hack schedutil to filter out the inefficient
frequencies, so you don't need to worry about them below that level.

That would be putting driver knowledge into the governor which cpufreq
was specifically designed to avoid.

There is a way to do that, though, which is to put a governor into the
driver and use ->setoplicy(), but the good news is that you don't even
need to do that.

So there are those CPUFREQ_RELATION_* symbols used by governors to
tell drivers what to do next (I wonder what they would be good for
after your changes for that matter) and you can add more of them.  For
example, you can define a CPUFREQ_RELATION_EFFICIENT bit to tell the
driver to avoid inefficient frequencies and pass that from schedutil.

Besides, I'm not sure why you still want to use inefficient
frequencies if they are selected by the ondemand or conservative
governors.

> >
> > Besides, in the cpufreq_driver_fast_switch() case the driver's
> > ->fast_switch() callback is entirely responsible for applying the
> > selected frequency, so I'm not sure how this "efficient" thing is
> > going to work then?
>
> This shouldn't be a problem if a governor that leverages inefficient OPPs
> resolves an inefficient one to an efficient one. The target_freq would simply
> point to a frequency known as efficient.

No, that doesn't help.  Moreover, it is harmful, because it changes
the interface between this particular governor and drivers in a subtle
and potentially confusing way.

Namely, drivers now can expect that the frequency passed to
->fast_switch() is the one corresponding to the current utilization
demand as seen by the governor, subject to the policy limits, not
the-closest-efficient-one-present-in-the-frequency-table.

> > Anyway, since we are talking about frequency tables, that would be the
> > __cpufreq_driver_target() case only and specifically in the
> > __target_index() case only (note how far away this is from the
> > governor).
> >
> > Now, you may think about modifying cpufreq_frequency_table_target() to
> > skip "inefficient" frequencies, but then the question is why those
> > frequencies need to be there in the frequency table in the first
> > place?
>
> Cpufreq_cooling needs those frequencies, even inefficients,

I've already figured that out.

> also there's probably no reason to hide them from the userspace.
