Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00EA422EEF
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhJERTF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 13:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhJERTE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 13:19:04 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BB2C061749;
        Tue,  5 Oct 2021 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=Wew2RwQRuWp0xOeGxUW+24Kcrt1I9ESupnkXfF0tLJI=; b=mzR+
        Zvm7wpsXbDkkyMjsVY5N4dLp5BgzeOtDzj8W7ekrljcUJ1ad5z3huW8PYY5sI4QPf9os1kduGsDp5
        GCQYmJ8wy0whJpWleW5/6GW13utc314F92nVorAe96+Kunz/4midC58uZl1RC4YrtDmErWco+4P1I
        Wmm3L9h1cno3WZBBCNKQXs5sd9KJq73SG8CXMH8IyJWLlrW1FP5LDfIHiDa8hyOHRWoGWJdWru8Pd
        MTtYCfN7w7PLdtDLFCk0vurY2Ou7oAXfW4sgSAyRMP8WapIbK1GZWk8T5L+z2P2L7Q4x++pn21YND
        YdxqhayTxX8R26+NTBhSzH82ViamPg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mXo3v-0002f8-K4; Tue, 05 Oct 2021 18:17:07 +0100
Date:   Tue, 5 Oct 2021 18:17:06 +0100
From:   John Keeping <john@metanate.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RT] PM: runtime: avoid retry loops on RT
Message-ID: <20211005181706.66102578.john@metanate.com>
In-Reply-To: <CAJZ5v0gPwUQzGBa2VDeC3xAF9zJVm486BC0eue10-urJ8Xz+iw@mail.gmail.com>
References: <20211005155427.1591196-1-john@metanate.com>
        <CAJZ5v0gPwUQzGBa2VDeC3xAF9zJVm486BC0eue10-urJ8Xz+iw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 5 Oct 2021 18:38:27 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Oct 5, 2021 at 6:14 PM John Keeping <john@metanate.com> wrote:
> >
> > With PREEMPT_RT spin_unlock() is identical to spin_unlock_irq() so there
> > is no reason to have a special case using the former.  Furthermore,
> > spin_unlock() enables preemption meaning that a task in RESUMING or
> > SUSPENDING state may be preempted by a higher priority task running
> > pm_runtime_get_sync() leading to a livelock.
> >
> > Use the non-irq_safe path for all waiting so that the waiting task will
> > block.
> >
> > Note that this changes only the waiting behaviour of irq_safe, other
> > uses are left unchanged so that the parent device always remains active
> > in the same way as !RT.
> >
> > Signed-off-by: John Keeping <john@metanate.com>  
> 
> So basically, the idea is that the irq_safe flag should have no effect
> when CONFIG_PREEMPT_RT is set, right?
> 
> Wouldn't it be cleaner to make it not present at all in that case?

Yes, just replacing pm_runtime_irq_safe() with an empty function would
also fix it, but I'm not sure if that will have unexpected effects from
the parent device suspending/resuming, especially in terms of latency
for handling interrupts.

> > ---
> >  drivers/base/power/runtime.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 96972d5f6ef3..5e0d349fab4e 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -347,8 +347,9 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> >  {
> >         int retval = 0, idx;
> >         bool use_links = dev->power.links_count > 0;
> > +       bool irq_safe = dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT);
> >
> > -       if (dev->power.irq_safe) {
> > +       if (irq_safe) {
> >                 spin_unlock(&dev->power.lock);
> >         } else {
> >                 spin_unlock_irq(&dev->power.lock);
> > @@ -376,7 +377,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> >         if (cb)
> >                 retval = cb(dev);
> >
> > -       if (dev->power.irq_safe) {
> > +       if (irq_safe) {
> >                 spin_lock(&dev->power.lock);
> >         } else {
> >                 /*
> > @@ -596,7 +597,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> >                         goto out;
> >                 }
> >
> > -               if (dev->power.irq_safe) {
> > +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >                         spin_unlock(&dev->power.lock);
> >
> >                         cpu_relax();
> > @@ -777,7 +778,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
> >                         goto out;
> >                 }
> >
> > -               if (dev->power.irq_safe) {
> > +               if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >                         spin_unlock(&dev->power.lock);
> >
> >                         cpu_relax();
> > --
> > 2.33.0
> >  

