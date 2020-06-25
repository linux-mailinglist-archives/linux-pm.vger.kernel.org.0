Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D87209D0E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404069AbgFYKtQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 06:49:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34894 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403997AbgFYKtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 06:49:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id d4so4831329otk.2;
        Thu, 25 Jun 2020 03:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZu/M5tJwBdIo0B6sXLRIqOmUPTGDQ/TGIkvQTgc7h0=;
        b=mL0fGY8GHhNlapXLWoFPgwzalGmF8tadYFl7vrkUkud5UIYVk/g1IO1EIf2OCYadC8
         1ikMSWoqiP7Mpp4HwGc5kAgZA1BI1+k+7vXGU5/Lvr6k5nPUwfPwGxvnoZdhxiIJPSG6
         Q+nAQqo6v4cGfDM86nk9VV9HqYVkHR4TaAYqvQhZ5+R7DTCMe07di9aWxgqGx8Lt3W7e
         EgsrlGoEdBcOVTiwQpeE9aiQ3h8upzeZ3AFZXxFph7tmzw1P77b6cOmTZB+6Yp0RG9RG
         H+zY9LVC51JXzWf2CicbHkA20tHC+f2t2NKHdU6rFZZPDhFnBQ4HK6cVZWxmlx/kuhhw
         +WDg==
X-Gm-Message-State: AOAM532oNI/JAqogGlvJ2ApBjSkeBpLwdwmCpmap348DGFDSFe8gWkvu
        IrqE/PDJBLTWb3NvKrRCqDeojR5Pw2t+c6vtnsn/mgIF
X-Google-Smtp-Source: ABdhPJwrQr5//gVc0ELyf88cZQxAHM9XCWiHAO0o0Kh+Q10IjdC6lMByq2eY2qoubCvnyit0RIK68azXSCAZbKDsrno=
X-Received: by 2002:a4a:3402:: with SMTP id b2mr1985335ooa.75.1593082153413;
 Thu, 25 Jun 2020 03:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592892767.git.yu.c.chen@intel.com> <a00278cc5db9f4845006cff130fd91a58c0d92d1.1592892767.git.yu.c.chen@intel.com>
 <15473183.xuek0xzqYe@kreacher> <20200625051534.GA22907@chenyu-office.sh.intel.com>
In-Reply-To: <20200625051534.GA22907@chenyu-office.sh.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 12:49:02 +0200
Message-ID: <CAJZ5v0jD__jK_tkNHk_ZqKEfdGiDa_afL5f65k3=z-8ZSq_UFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2][v3] PM / s2idle: Code cleanup to make s2idle
 consistent with normal idle path
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 25, 2020 at 7:14 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Hi Rafael,
> On Tue, Jun 23, 2020 at 07:57:59PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpuidle: Rearrange s2idle-specific idle state entry code
> >
> > Implement call_cpuidle_s2idle() in analogy with call_cpuidle()
> > for the s2idle-specific idle state entry and invoke it from
> > cpuidle_idle_call() to make the s2idle-specific idle entry code
> > path look more similar to the "regular" idle entry one.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/cpuidle.c |    6 +++---
> >  kernel/sched/idle.c       |   15 +++++++++++----
> >  2 files changed, 14 insertions(+), 7 deletions(-)
> >
> > Index: linux-pm/kernel/sched/idle.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/idle.c
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -96,6 +96,15 @@ void __cpuidle default_idle_call(void)
> >       }
> >  }
> >
> > +static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> > +                            struct cpuidle_device *dev)
> > +{
> > +     if (current_clr_polling_and_test())
> > +             return -EBUSY;
> > +
> > +     return cpuidle_enter_s2idle(drv, dev);
> > +}
> > +
> >  static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >                     int next_state)
> >  {
> > @@ -171,11 +180,9 @@ static void cpuidle_idle_call(void)
> >               if (idle_should_enter_s2idle()) {
> >                       rcu_idle_enter();
> >
> > -                     entered_state = cpuidle_enter_s2idle(drv, dev);
> > -                     if (entered_state > 0) {
> > -                             local_irq_enable();
> > +                     entered_state = call_cpuidle_s2idle(drv, dev);
> I guess this changes the context a little bit that(comparing to [1/2 patch],
> after this modification, when we found that TIF_NEED_RESCHED is set we can have
> a second chance in the following call_cpuidle to do a second s2idle try. However
> in [1/2 patch], it might exit the s2idle phase directly once when we see
> TIF_NEED_RESCHED is set(because entered_state is postive we treat it as a successful
> s2idle). In summary I think the change (patch [2/2]) is more robust.

Yeah, good point.

> Acked-by: Chen Yu <yu.c.chen@intel.com>

OK, thanks!

I'll queue up this one too along with the [1/2] for -rc4 then.

Thanks!
