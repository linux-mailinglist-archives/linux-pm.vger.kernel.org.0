Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925B118A703
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 22:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgCRVaG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 17:30:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35087 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRVaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 17:30:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id k26so233761otr.2;
        Wed, 18 Mar 2020 14:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLiBZtpr4e56p2g/o11hfAKRe9jeKBAJwiRBOQ3WAnY=;
        b=BECAOQbJs7Cy+AZvv/gInHpkqj/nY6B/SO4zEjo9swMB39IZwShfeXaUI5UtK2biOP
         vcmu85QGwCfcwZ4gFfmjmU/zCPsUiaXRdLMGFete/uEkJ019x38W1rRVcFkPwRza0YXO
         bBgzAk5cvd8KE4B78vWOb/Lo9HTRhSjzxt2yQFwhz/abFJ5t79gMVDKcgaDvz5xSH0Eu
         P2nQ3QyEbBfv7TazaMDGD3wZZsOjfzqwGTBvE9D2HHi95Sg3lCmh9NspTj33924Upsto
         dZi4X/gIWtUw89D6RHH88HYAvpxC0kEqsQd3FYpBop0ksNT2pSOEuAnkcLnOQ+l8eOvo
         ejNg==
X-Gm-Message-State: ANhLgQ1wHxptzfSEyj0uUj3496uZaOpBXvWnlX6RU+dyvUhgJC4IyBkw
        EsnGqPe+oNVwRVFtBjDfiPmYS8KtzjG6wfaM3J8=
X-Google-Smtp-Source: ADFU+vuxickbFyRcIty7lM9IaclCHNf1VAH/8QnH6PATSgt1jsbljLQUn/9lceImpYF6c+RmcTIg7Ei6qm1POuD/8pY=
X-Received: by 2002:a05:6830:1e96:: with SMTP id n22mr5524399otr.189.1584567005337;
 Wed, 18 Mar 2020 14:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200316210843.11678-1-daniel.lezcano@linaro.org>
 <2605374.f08NWHE4iP@kreacher> <669fe03f-0d65-8ca9-53dc-1323e0397c53@linaro.org>
 <93da445f-ebfd-4d2e-c8b4-cd81e54892c0@linaro.org>
In-Reply-To: <93da445f-ebfd-4d2e-c8b4-cd81e54892c0@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Mar 2020 22:29:53 +0100
Message-ID: <CAJZ5v0g6fPu5mhUgy9ADb7fo7Q_WngVcADewVY9Pii3R=SMzZg@mail.gmail.com>
Subject: Re: [PATCH RFC] cpuidle: consolidate calls to time capture
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 18, 2020 at 3:32 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 18/03/2020 12:04, Daniel Lezcano wrote:
> >
> > Hi Rafael,
> >
> > On 18/03/2020 11:17, Rafael J. Wysocki wrote:
> >> On Monday, March 16, 2020 10:08:43 PM CET Daniel Lezcano wrote:
> >>> A few years ago, we changed the code in cpuidle to replace ktime_get()
> >>> by a local_clock() to get rid of potential seq lock in the path and an
> >>> extra latency.
> >>>
> >>> Meanwhile, the code evolved and we are getting the time in some other
> >>> places like the power domain governor and in the future break even
> >>> deadline proposal.
> >>
> >> Hmm?
> >>
> >> Have any patches been posted for that?
> >
> > https://lkml.org/lkml/2020/3/11/1113
> >
> > https://lkml.org/lkml/2020/3/13/466
> >
> > but there is no consensus yet if that has a benefit or not.
> >
> >>> Unfortunately, as the time must be compared across the CPU, we have no
> >>> other option than using the ktime_get() again. Hopefully, we can
> >>> factor out all the calls to local_clock() and ktime_get() into a
> >>> single one when the CPU is entering idle as the value will be reuse in
> >>> different places.
> >>
> >> So there are cases in which it is not necessary to synchronize the time
> >> between CPUs and those would take the overhead unnecessarily.
> >>
> >> This change looks premature to me at least.
> >
> > The idea is to call one time ktime_get() when entering idle and store
> > the result in the struct cpuidle_device, so we have the information when
> > we entered idle.
> >
> > Moreover, ktime_get() is called in do_idle() via:
> >
> > tick_nohz_idle_enter()
> >   tick_nohz_start_idle()
> >     ts->idle_entrytime = ktime_get();
> >
> > This is called at the first loop level. The idle loop is exiting and
> > re-entering again without passing through tick_nohz_idle_enter() in the
> > second loop level in case of interrupt processing, thus the
> > idle_entrytime is not updated and the return of
> > tick_nohz_get_sleep_length() will be greater than what is expected.
> >
> > May be we can consider ktime_get_mono_fast_ns() which is lockless with a
> > particular care of the non-monotonic aspect if needed. Given the
> > description at [1] the time jump could a few nanoseconds in case of NMI.
> >
> > The local_clock() can no be inspected across CPUs, the gap is too big
> > and continues to increase during system lifetime.
>
> I took the opportunity to measure the duration to a call to ktime_get,
> ktime_get_mono_fast_ns and local_clock.

The results you get depend a good deal on the conditions of the test,
the system on which they were obtained and so on.  Without this
information it is hard to draw any conclusions from those results.  In
particular, ktime_get() is not significantly slower than local_clock()
if there is no contention AFAICS, and the lack of contention cannot be
guaranteed here.

Generally speaking, the problem is that it is not sufficient to
measure the time before running the governor and after the CPU wakes
up, because in the cases that really care about the latency of that
operation the time needed to run the governor may be a significant
fraction of the entire overhead.  So it is necessary to take time
stamps in several places and putting ktime_get() in all of them
doesn't sound particularly attractive.

Anyway, there is no real need to make this change AFAICS, so I'm not
really sure what the entire argument is about.
