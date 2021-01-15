Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7006E2F82AA
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 18:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhAORly (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 12:41:54 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42876 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbhAORlx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 12:41:53 -0500
Received: by mail-oi1-f171.google.com with SMTP id l200so10339788oig.9;
        Fri, 15 Jan 2021 09:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PddaAUHsLywGYrsB34FK5TVfFnFm3N3OSnt+B2L3scA=;
        b=Y4woEJsQ91sCsqYQ31y7DYohinP6fGf3GYx7P/wjfbWo8ah2MULcW2dOm0GUg3mlpv
         5jDc0joinbs8PiyKOnSiaGdrlXpzr7P6XDzswQyS2reITLu7Iz5FYAvvt3P7IV+JUqj3
         7nkQRg5vlXksjOvYQ6j7gsajwHXQoVAZmbFtHgk78hZPHLH5+3THvCGcpZVhaPhy4aCw
         DiCbHX0ITiWc52zI/uNWAjZgsbzVQJobiUdAGpMmGilUmv6yWDi/7RHAoaq4+DNHADRi
         nNUgYHn3icsa7Y+3JKXZrlTUfon79p3t5RBbZaZ4YUUlEPv6QSy8YDZ4pnJ6N677uWB/
         dfKg==
X-Gm-Message-State: AOAM531v8qSiPS5KcNe7k1dBX5j3BBMEWCqLzv39mZ/8//bnvJK0cEWi
        1rhh2XjRqlTHEWH+kAO5yBzW9B/p20KxbMBeOKk=
X-Google-Smtp-Source: ABdhPJxaptPV2vING/8W4sXvumYZ2Uxbsf+D78dU1jCPUHJC3RZaliFaqEPpq842BA6fOyl3F6TWSbiAxMDUminxq2M=
X-Received: by 2002:aca:4892:: with SMTP id v140mr6467886oia.71.1610732472571;
 Fri, 15 Jan 2021 09:41:12 -0800 (PST)
MIME-Version: 1.0
References: <2073294.4OfjquceTg@kreacher> <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
 <YAFmoinbKocE9Jf5@gerhold.net> <CAJZ5v0hgmrN_zWBrX7FsfP=7mZHf_BYm+Qe+E3Ti4k0mK7t2MA@mail.gmail.com>
 <CAGETcx_A9YLmiMeizsrJEcdTMSZpJU03twAdRSdGeco83Z5uCQ@mail.gmail.com>
In-Reply-To: <CAGETcx_A9YLmiMeizsrJEcdTMSZpJU03twAdRSdGeco83Z5uCQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jan 2021 18:41:01 +0100
Message-ID: <CAJZ5v0hFwXE+8GFqgByBEtPMS5w=hCT+2wmwQZR0LfoSA9xWRA@mail.gmail.com>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 15, 2021 at 6:21 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, Jan 15, 2021 at 5:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Jan 15, 2021 at 11:03 AM Stephan Gerhold <stephan@gerhold.net> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Jan 14, 2021 at 11:31:12AM -0800, Saravana Kannan wrote:
> > > > On Thu, Jan 14, 2021 at 10:41 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > When adding a new device link, device_is_dependent() is used to
> > > > > check whether or not the prospective supplier device does not
> > > > > depend on the prospective consumer one to avoid adding loops
> > > > > to the graph of device dependencies.
> > > > >
> > > > > However, device_is_dependent() does not take the ancestors of
> > > > > the target device into account, so it may not detect an existing
> > > > > reverse dependency if, for example, the parent of the target
> > > > > device depends on the device passed as its first argument.
> > > > >
> > > > > For this reason, extend device_is_dependent() to also check if
> > > > > the device passed as its first argument is an ancestor of the
> > > > > target one and return 1 if that is the case.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > > > > ---
> > > > >  drivers/base/core.c |   12 +++++++++++-
> > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > >
> > > > > Index: linux-pm/drivers/base/core.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/base/core.c
> > > > > +++ linux-pm/drivers/base/core.c
> > > > > @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
> > > > >  #endif
> > > > >  #endif /* !CONFIG_SRCU */
> > > > >
> > > > > +static bool device_is_ancestor(struct device *dev, struct device *target)
> > > > > +{
> > > > > +       while (target->parent) {
> > > > > +               target = target->parent;
> > > > > +               if (dev == target)
> > > > > +                       return true;
> > > > > +       }
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * device_is_dependent - Check if one device depends on another one
> > > > >   * @dev: Device to check dependencies for.
> > > > > @@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
> > > > >         struct device_link *link;
> > > > >         int ret;
> > > > >
> > > > > -       if (dev == target)
> > > > > +       if (dev == target || device_is_ancestor(dev, target))
> > > > >                 return 1;
> > > > >
> > > > >         ret = device_for_each_child(dev, target, device_is_dependent);
> > > > >
> > > >
> > >
> > > Thanks for the patch, Rafael! I tested it and it seems to avoid the
> > > circular device link (and therefore also the crash). FWIW:
> > >
> > > Tested-by: Stephan Gerhold <stephan@gerhold.net>
> >
> > Thanks!
> >
> > > > The code works, but it's not at all obvious what it's doing. Because,
> > > > at first glance, it's easy to mistakenly think that it's trying to
> > > > catch this case:
> > > > dev <- child1 <- child2 <- target
> > > >
> > >
> > > Isn't this pretty much the case we are trying to catch? I have:
> > >
> > >   78d9000.usb <- ci_hdrc.0 <- ci_hdrc.0.ulpi <- phy-ci_hdrc.0.ulpi.0
> > >
> > > then something attempts to create a device link with
> > > consumer = 78d9000.usb, supplier = phy-ci_hdrc.0.ulpi.0, and to check if
> > > that is allowed we call device_is_dependent() with dev = 78d9000.usb,
> > > target = phy-ci_hdrc.0.ulpi.0.
> > >
> > > Note that this case would normally be covered by the device_for_each_child().
> > > It's not in this case because the klist_children of 78d9000.usb
> > > is updated too late.
> >
> > Exactly.
>
> Stephan,
>
> What device/driver is this? Is this a dwc3 device/driver? That driver
> does some weird/incorrect stuff the last time I checked.
>
> >
> > The supplier has been initialized, which is why device_is_dependent()
> > is invoked at all, but it has not been fully registered yet, so
> > device_for_each_child() cannot be relied on to catch all of the
> > possible dependencies.
>
> Rafael,
>
> Ok, I understand this additional case now.
>
> What functions does one call to get the device to this state?

device_initialize() followed by device_link_add() (with the device
passed as the supplier) and device_add().

> AFAIR, device_add() does both the "initialization" and adding to the
> parent's children list.

device_register() does that.

>
> I'm okay with this, but I want to make sure the driver isn't doing weird stuff.

So the purpose of the change is to make device_link_add() catch that. :-)
