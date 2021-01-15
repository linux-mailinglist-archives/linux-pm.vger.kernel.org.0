Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120502F7BBC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbhAONEk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 08:04:40 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34057 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733133AbhAONEj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 08:04:39 -0500
Received: by mail-ot1-f54.google.com with SMTP id a109so8460396otc.1;
        Fri, 15 Jan 2021 05:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfjWETeidop360v2z5Os9N6k2FYG3GkdQgvxI2qXOp8=;
        b=o9t1brVVRaYLL1W5ScnK1HeleKDKYneZFpzFFHOiwapTJ2h9W3wa1s31kpzwBCxK5k
         GMziTz0uT246G77owlTesQjwGQ7FXwByv9+WCC/GH28cW/yNgsP2DnRK/8ZVO8NVxEWv
         PoKQrUGu8E62/Qc35alYbB+t/hucl5TarIiEF0P6xNa9qXdlRngO5fo1pLoEuU5/d//4
         DtBWcp++8Cj+LelwRyCp2MrzTSBdw/rT/ygq0IprAQtkfZMK2CxS0etjXZJztojy3DTq
         3zX/pXtsCATela/0CRVvJlulQ32cz+AH/25k+Y6Esgbt73LcmY63rTJcx1qlxQJY1fpk
         WSew==
X-Gm-Message-State: AOAM531ar1FC2czAVPAdSlR6DjkTrb1Ap8UxmsJoYsGXEJaSU5f1bEL3
        1RhYMQTRL4AhnrGBgDO1MnRyzjZ3yjUO6oYm8r4=
X-Google-Smtp-Source: ABdhPJy3GccdI1Kjl8kx1Dn1OnmG20hjMOUcdFuH32YzvaLbkZ3+5gfE/+FCicnfkuJQ5e8L2QyC9eda0GKJYtv8uds=
X-Received: by 2002:a05:6830:4b5:: with SMTP id l21mr8351768otd.321.1610715838378;
 Fri, 15 Jan 2021 05:03:58 -0800 (PST)
MIME-Version: 1.0
References: <2073294.4OfjquceTg@kreacher> <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
 <YAFmoinbKocE9Jf5@gerhold.net>
In-Reply-To: <YAFmoinbKocE9Jf5@gerhold.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jan 2021 14:03:47 +0100
Message-ID: <CAJZ5v0hgmrN_zWBrX7FsfP=7mZHf_BYm+Qe+E3Ti4k0mK7t2MA@mail.gmail.com>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 15, 2021 at 11:03 AM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Hi,
>
> On Thu, Jan 14, 2021 at 11:31:12AM -0800, Saravana Kannan wrote:
> > On Thu, Jan 14, 2021 at 10:41 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > When adding a new device link, device_is_dependent() is used to
> > > check whether or not the prospective supplier device does not
> > > depend on the prospective consumer one to avoid adding loops
> > > to the graph of device dependencies.
> > >
> > > However, device_is_dependent() does not take the ancestors of
> > > the target device into account, so it may not detect an existing
> > > reverse dependency if, for example, the parent of the target
> > > device depends on the device passed as its first argument.
> > >
> > > For this reason, extend device_is_dependent() to also check if
> > > the device passed as its first argument is an ancestor of the
> > > target one and return 1 if that is the case.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > > ---
> > >  drivers/base/core.c |   12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-pm/drivers/base/core.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/core.c
> > > +++ linux-pm/drivers/base/core.c
> > > @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
> > >  #endif
> > >  #endif /* !CONFIG_SRCU */
> > >
> > > +static bool device_is_ancestor(struct device *dev, struct device *target)
> > > +{
> > > +       while (target->parent) {
> > > +               target = target->parent;
> > > +               if (dev == target)
> > > +                       return true;
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > >  /**
> > >   * device_is_dependent - Check if one device depends on another one
> > >   * @dev: Device to check dependencies for.
> > > @@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
> > >         struct device_link *link;
> > >         int ret;
> > >
> > > -       if (dev == target)
> > > +       if (dev == target || device_is_ancestor(dev, target))
> > >                 return 1;
> > >
> > >         ret = device_for_each_child(dev, target, device_is_dependent);
> > >
> >
>
> Thanks for the patch, Rafael! I tested it and it seems to avoid the
> circular device link (and therefore also the crash). FWIW:
>
> Tested-by: Stephan Gerhold <stephan@gerhold.net>

Thanks!

> > The code works, but it's not at all obvious what it's doing. Because,
> > at first glance, it's easy to mistakenly think that it's trying to
> > catch this case:
> > dev <- child1 <- child2 <- target
> >
>
> Isn't this pretty much the case we are trying to catch? I have:
>
>   78d9000.usb <- ci_hdrc.0 <- ci_hdrc.0.ulpi <- phy-ci_hdrc.0.ulpi.0
>
> then something attempts to create a device link with
> consumer = 78d9000.usb, supplier = phy-ci_hdrc.0.ulpi.0, and to check if
> that is allowed we call device_is_dependent() with dev = 78d9000.usb,
> target = phy-ci_hdrc.0.ulpi.0.
>
> Note that this case would normally be covered by the device_for_each_child().
> It's not in this case because the klist_children of 78d9000.usb
> is updated too late.

Exactly.

The supplier has been initialized, which is why device_is_dependent()
is invoked at all, but it has not been fully registered yet, so
device_for_each_child() cannot be relied on to catch all of the
possible dependencies.

And I say "possible", because the dependency in question is only
partially recorded in the data structures, but IMV device_link_add()
should refuse to create the device link in this case too.
