Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ECF38CCF7
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhEUSLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 14:11:13 -0400
Received: from muru.com ([72.249.23.125]:58594 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhEUSLN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 May 2021 14:11:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9CEF880C0;
        Fri, 21 May 2021 18:09:53 +0000 (UTC)
Date:   Fri, 21 May 2021 21:09:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM / wakeirq: move to use request_irq by IRQF_NO_AUTOEN
 flag
Message-ID: <YKf3aY4Mj/4Nl1v3@atomide.com>
References: <1621496098-50271-1-git-send-email-tiantao6@hisilicon.com>
 <CAJZ5v0ie_ijC4XVBxnS9tid-q_vbMm6zXwvvOoMMEe20E_mLUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ie_ijC4XVBxnS9tid-q_vbMm6zXwvvOoMMEe20E_mLUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Rafael J. Wysocki <rafael@kernel.org> [210521 16:57]:
> On Thu, May 20, 2021 at 9:35 AM Tian Tao <tiantao6@hisilicon.com> wrote:
> >
> > request_irq() after setting IRQ_NOAUTOEN as below
> > irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > request_irq(dev, irq...);
> > can be replaced by request_irq() with IRQF_NO_AUTOEN flag.
> >
> > this change is just to simplify the code, no actual functional changes.
> >
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> Tony, what do you think?

Sounds good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>

> > ---
> >  drivers/base/power/wakeirq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> > index 8e02108..3bad326 100644
> > --- a/drivers/base/power/wakeirq.c
> > +++ b/drivers/base/power/wakeirq.c
> > @@ -182,7 +182,6 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
> >
> >         wirq->dev = dev;
> >         wirq->irq = irq;
> > -       irq_set_status_flags(irq, IRQ_NOAUTOEN);
> >
> >         /* Prevent deferred spurious wakeirqs with disable_irq_nosync() */
> >         irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
> > @@ -192,7 +191,8 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
> >          * so we use a threaded irq.
> >          */
> >         err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
> > -                                  IRQF_ONESHOT, wirq->name, wirq);
> > +                                  IRQF_ONESHOT | IRQF_NO_AUTOEN,
> > +                                  wirq->name, wirq);
> >         if (err)
> >                 goto err_free_name;
> >
> > --
> > 2.7.4
> >
