Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45D62FBA31
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 15:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbhASOqD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 09:46:03 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35991 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389267AbhASNZT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 08:25:19 -0500
Received: by mail-oi1-f176.google.com with SMTP id 9so21130460oiq.3;
        Tue, 19 Jan 2021 05:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Idlx9RREqweSUD8lcoD8wW/tGcOzRTqi7qMTCAE3Qko=;
        b=LP0j9td4/h/qiWWMUW/rQuu6r90kvreGW2E4JPLasy23bl2IWJyl8pYtzLBXHgvSKm
         7kyuNVSacByAgw4WeoAPGxnW6RVqo5TvF/2RHxaToiXUoNZRZILwNsc8YQjbtgOu7zXb
         QLVmhAbkq85HFOEDd2Vc9JOPg31tQWGg/XvjyMxA792wG4hxwjekxF7H8/bMzjcu764S
         oMGhupjSpMFhIQKtnVg4Dlq4s2A/thPNZ0zqUMdRDTc2C3MTCY8WSi1DThZlROIXEP0f
         jrDKyKPWjlyxhcsBypuealUpDeDRDzdF8fbuCHuiJ3O+9+C9O88Y2T0YKr0ZwTaWewoK
         ezrw==
X-Gm-Message-State: AOAM5312FMEw4TCLhZsTbz32jkv8KrN+zYWlEo4Y7QS9hbVZt6xY5rzy
        NTnxabb+SlHnMz9xseJOyE6p3TCLhd71CW2EaJ8=
X-Google-Smtp-Source: ABdhPJxZKTE21Z1XKEJRaORsKkBXwppVd0J7GH8X1+iaPGmeyQUSVxwzJG3dhbhqhxFD9wSDdc17wENeX3UpaLU8vd8=
X-Received: by 2002:aca:5c05:: with SMTP id q5mr2566295oib.157.1611062636064;
 Tue, 19 Jan 2021 05:23:56 -0800 (PST)
MIME-Version: 1.0
References: <17705994.d592GUb2YH@kreacher> <CAGETcx9Bk0-nF+wnNXyLpgx7Ny-EchdUpXOYeBmhxTNF+mCR2A@mail.gmail.com>
In-Reply-To: <CAGETcx9Bk0-nF+wnNXyLpgx7Ny-EchdUpXOYeBmhxTNF+mCR2A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jan 2021 14:23:44 +0100
Message-ID: <CAJZ5v0iJeZYDMoub1u4CMs8ciZkAPkZKVYg6+OS4XxPRaPYhjQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Extend device_is_dependent()
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 18, 2021 at 11:03 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, Jan 15, 2021 at 10:30 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the device passed as the target (second argument) to
> > device_is_dependent() is not completely registered (that is, it has
> > been initialized, but not added yet), but the parent pointer of it
> > is set, it may be missing from the list of the parent's children
> > and device_for_each_child() called by device_is_dependent() cannot
> > be relied on to catch that dependency.
> >
> > For this reason, modify device_is_dependent() to check the ancestors
> > of the target device by following its parent pointer in addition to
> > the device_for_each_child() walk.
> >
> > Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > Tested-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >
> > -> v2:
> >    * Improve the changelog.
> >    * Add a comment to explain the reason for the extra check.
> >    * Add tags.
> >
> >    No code changes.
> >
> > ---
> >  drivers/base/core.c |   17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/base/core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/core.c
> > +++ linux-pm/drivers/base/core.c
> > @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
> >  #endif
> >  #endif /* !CONFIG_SRCU */
> >
> > +static bool device_is_ancestor(struct device *dev, struct device *target)
> > +{
> > +       while (target->parent) {
> > +               target = target->parent;
> > +               if (dev == target)
> > +                       return true;
> > +       }
> > +       return false;
> > +}
> > +
> >  /**
> >   * device_is_dependent - Check if one device depends on another one
> >   * @dev: Device to check dependencies for.
> > @@ -221,7 +231,12 @@ int device_is_dependent(struct device *d
> >         struct device_link *link;
> >         int ret;
> >
> > -       if (dev == target)
> > +       /*
> > +        * The "ancestors" check is needed to catch the case when the target
> > +        * device has not been completely initialized yet and it is still
> > +        * missing from the list of children of its parent device.
> > +        */
> > +       if (dev == target || device_is_ancestor(dev, target))
> >                 return 1;
> >
> >         ret = device_for_each_child(dev, target, device_is_dependent);
> >
>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
>
> fw_devlink_relax_cycle() needs a similar fix. Want me to handle that
> as a separate patch to driver-core-next? Or do you want to combine
> that in this patch?

I would prefer that to be a different patch because of the Fixes: tag.

Also fw_devlink_relax_cycle() is in linux-next only for now, so it is
better to avoid mixing a mainline fix with updating that one.
