Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079D4341EBB
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 14:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCSNtC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 09:49:02 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46842 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSNsc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 09:48:32 -0400
Received: by mail-oi1-f175.google.com with SMTP id m13so4812860oiw.13;
        Fri, 19 Mar 2021 06:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyxmBD5QFWJov1qxfz5NcKpIUbGP33CxQ8bf3idEHVU=;
        b=bQKUEJpXBmm4Y4coeRtoJisXKd7aM9KIQmmTyT2bHJePO7eGW2JGJg8szp4XP4Pwuz
         KQY72ZilFRxCfe7+AHZ9vDcG6QE6kJ1rB9ObbVYkUZvqwIK62gnj72OAzBUXg0qf2VTC
         TD6WAJWlvElNR+h7MN5bdv2seCkvCFMOM82SJ1iL2RpDDK1Y9Dz6/Y2Rzn+y5ebEI832
         Q3kv6qt9MyrZbbtkN49D2hIW5j3V30WtsdnZfzLO1sGqvc3GP01oNxzdLkpnX6tAQfJz
         G9ZtRAjr3PO9wsIgXYQ5y/rBR1vjyrEIiDLQ2QCgms4I0g+uDlqN+luCcoj3NSQL5BgD
         HqtQ==
X-Gm-Message-State: AOAM533wKB6beMPACGnWNYP5mBaIBIZ1EFVaisGFdIJ8jSjo0bzLSOvt
        jN6p0/7Tid+5t2OYKx/cJx7tF81qEjp2PaBEhMs=
X-Google-Smtp-Source: ABdhPJymNhnbBa4J5vBQBANZNb2oFehD3NiaNiSj3VKa+GDhwVj0KTFNW4nEkcJI5mZC/CeUNWj8eCksUAgBa3T9IuA=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr1090954oie.157.1616161711393;
 Fri, 19 Mar 2021 06:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <5448054.DvuYhMxLoT@kreacher> <2060154.irdbgypaU6@kreacher> <CAPDyKFpK46raH4DqmTjYm1a1sQtss3BEM3BfVGYsYvNThj1b-g@mail.gmail.com>
In-Reply-To: <CAPDyKFpK46raH4DqmTjYm1a1sQtss3BEM3BfVGYsYvNThj1b-g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 14:48:17 +0100
Message-ID: <CAJZ5v0hVCiseoytOoNpt-9OWFt9xwHE_xfOHcWx3V_vYSrK8=A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PM: runtime: Defer suspending suppliers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "elaine.zhang" <zhangqing@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 19, 2021 at 2:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 18 Mar 2021 at 19:15, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because the PM-runtime status of the device is not updated in
> > __rpm_callback(), attempts to suspend the suppliers of the given
> > device triggered by the rpm_put_suppliers() call in there may fail.
> >
> > To fix this (1) modify __rpm_callback() to avoid attempting to
> > actually suspend the suppliers, but only decrease their PM-runtime
> > usage counters and (2) make rpm_suspend() try to suspend the suppliers
> > after changing the device's PM-runtime status, in analogy with the
> > handling of the device's parent.
> >
> > Link: https://lore.kernel.org/linux-pm/CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com/
> > Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> > Reported-by: elaine.zhang <zhangqing@rock-chips.com>
> > Diagnosed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Just a minor nitpick, see below. In any case:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

>
> > ---
> >  drivers/base/power/runtime.c |   45 +++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 39 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -305,7 +305,7 @@ static int rpm_get_suppliers(struct devi
> >         return 0;
> >  }
> >
> > -static void rpm_put_suppliers(struct device *dev)
> > +static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
> >  {
> >         struct device_link *link;
> >
> > @@ -313,10 +313,30 @@ static void rpm_put_suppliers(struct dev
> >                                 device_links_read_lock_held()) {
> >
> >                 while (refcount_dec_not_one(&link->rpm_active))
> > -                       pm_runtime_put(link->supplier);
> > +                       pm_runtime_put_noidle(link->supplier);
> > +
> > +               if (try_to_suspend)
> > +                       pm_request_idle(link->supplier);
> >         }
> >  }
> >
> > +static void rpm_put_suppliers(struct device *dev)
> > +{
> > +       __rpm_put_suppliers(dev, true);
> > +}
> > +
> > +static void rpm_try_to_suspend_suppliers(struct device *dev)
>
> Maybe "rpm_suspend_suppliers" is sufficient for the name of the
> function, but I have no strong opinion.

OK

In addition to this, spin_unlock_irq()/spin_lock_irq() need to be used
around the call to it in rpm_suspend(), so I'll send a v2.  I guess
that the R-by still applies, though. :-)

> > +{
> > +       struct device_link *link;
> > +       int idx = device_links_read_lock();
> > +
> > +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> > +                               device_links_read_lock_held())
> > +               pm_request_idle(link->supplier);
> > +
> > +       device_links_read_unlock(idx);
> > +}
> > +
