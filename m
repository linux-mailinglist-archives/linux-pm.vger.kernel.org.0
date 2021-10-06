Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276424245DE
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 20:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJFSUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhJFSUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 14:20:13 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE8C061746;
        Wed,  6 Oct 2021 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=urshKh+SwpZcgjJQKF+ekx0TFaMUV+98Ijr/33Ev1eM=; b=0D5f
        xtfdBqCkDe6ygsBJLmkcLH3eaizC0+v3QhR8wg6/Uj8qL1e0drc8gHFhTXIrId+XIOKrT3BYiS8/8
        NeLIdfIsqkX/29dMhPitJsLOppRAMTX65hsArZT8Yk/Fi2SlltuwleovBj93eKsjkoEyr+r44+Gq0
        1KjU9xMpSMcHIU+AiZDjRlUC2WIg04q42Q7tfZzXKP1cfeFMFrFSKwrJgEezq8vMife9SUGT3bPu6
        B4WcIIg5uCVV3lVJbS47rTWkosfqPNbFkprrIVEEiADyM9a8sTLHGfED6f3JpGE9LrhKeDgKcb0Kc
        o4YGAUqPqfVN3+W/vydh7Bs8F2KQLg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mYBUc-0004oQ-GP; Wed, 06 Oct 2021 19:18:14 +0100
Date:   Wed, 6 Oct 2021 19:18:13 +0100
From:   John Keeping <john@metanate.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RT] PM: runtime: avoid retry loops on RT
Message-ID: <20211006191813.0e097b9f.john@metanate.com>
In-Reply-To: <CAJZ5v0iFKYvM+rn68VaAbM4=ZLAQBR_UPzvAuKqVLQuP=ZJPew@mail.gmail.com>
References: <20211005155427.1591196-1-john@metanate.com>
        <CAJZ5v0gPwUQzGBa2VDeC3xAF9zJVm486BC0eue10-urJ8Xz+iw@mail.gmail.com>
        <20211005181706.66102578.john@metanate.com>
        <CAJZ5v0iFKYvM+rn68VaAbM4=ZLAQBR_UPzvAuKqVLQuP=ZJPew@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 6 Oct 2021 19:05:50 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Oct 5, 2021 at 7:17 PM John Keeping <john@metanate.com> wrote:
> >
> > On Tue, 5 Oct 2021 18:38:27 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >  
> > > On Tue, Oct 5, 2021 at 6:14 PM John Keeping <john@metanate.com> wrote:  
> > > >
> > > > With PREEMPT_RT spin_unlock() is identical to spin_unlock_irq() so there
> > > > is no reason to have a special case using the former.  Furthermore,
> > > > spin_unlock() enables preemption meaning that a task in RESUMING or
> > > > SUSPENDING state may be preempted by a higher priority task running
> > > > pm_runtime_get_sync() leading to a livelock.
> > > >
> > > > Use the non-irq_safe path for all waiting so that the waiting task will
> > > > block.
> > > >
> > > > Note that this changes only the waiting behaviour of irq_safe, other
> > > > uses are left unchanged so that the parent device always remains active
> > > > in the same way as !RT.
> > > >
> > > > Signed-off-by: John Keeping <john@metanate.com>  
> > >
> > > So basically, the idea is that the irq_safe flag should have no effect
> > > when CONFIG_PREEMPT_RT is set, right?
> > >
> > > Wouldn't it be cleaner to make it not present at all in that case?  
> >
> > Yes, just replacing pm_runtime_irq_safe() with an empty function would
> > also fix it, but I'm not sure if that will have unexpected effects from
> > the parent device suspending/resuming, especially in terms of latency
> > for handling interrupts.  
> 
> Well, the code as is doesn't work with CONFIG_PREEMPT_RT set anyway in general.
> 
> Also this is not just pm_runtime_irq_safe(), but every access to this
> flag (and there's more  of them than just the ones changed below).
> 
> What about putting the flag under #ifdef CONFIG_PREEMPT_RT and
> providing read/write accessor helpers for it that will be empty in
> RT-enabled kernels?

That's the other approach I considered, but there are really two things
that irq_safe means here:

1) Call the suspend/resume hooks with interrupts disabled

2) Keep the parent device running and make other changes that allow (1)
   on non-RT systems (for example in amba_pm_runtime_suspend() leave the
   clock prepared when irq_safe is set, but unprepare it otherwise)

In the approach of leaving the flag unset on PREEMPT_RT we solve the
primary problem which is that (1) is irrelevant on RT, but that would
also affect (2) and I'm not sure whether that's desirable or not.

It's quite possible the answer is that the other changes don't matter
and we should take the simpler approach of just removing irq_safe under
CONFIG_PREEMPT_RT.  I'm becoming convinced that this is the right
answer, but I'm not confident that I fully understand the wider
ramifications.

> > > > ---
> > > >  drivers/base/power/runtime.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > index 96972d5f6ef3..5e0d349fab4e 100644
> > > > --- a/drivers/base/power/runtime.c
> > > > +++ b/drivers/base/power/runtime.c
> > > > @@ -347,8 +347,9 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> > > >  {
> > > >         int retval = 0, idx;
> > > >         bool use_links = dev->power.links_count > 0;
> > > > +       bool irq_safe = dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT);
> > > >
> > > > -       if (dev->power.irq_safe) {
> > > > +       if (irq_safe) {
> > > >                 spin_unlock(&dev->power.lock);
> > > >         } else {
> > > >                 spin_unlock_irq(&dev->power.lock);
> > > > @@ -376,7 +377,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> > > >         if (cb)
> > > >                 retval = cb(dev);
> > > >
> > > > -       if (dev->power.irq_safe) {
> > > > +       if (irq_safe) {
> > > >                 spin_lock(&dev->power.lock);
> > > >         } else {
> > > >                 /*
> > > > @@ -596,7 +597,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> > > >                         goto out;
> > > >                 }
> > > >
> > > > -               if (dev->power.irq_safe) {
> > > > +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > >                         spin_unlock(&dev->power.lock);
> > > >
> > > >                         cpu_relax();
> > > > @@ -777,7 +778,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > > >                         goto out;
> > > >                 }
> > > >
> > > > -               if (dev->power.irq_safe) {
> > > > +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > > >                         spin_unlock(&dev->power.lock);
> > > >
> > > >                         cpu_relax();
> > > > --
> > > > 2.33.0
> > > >  
> >  

