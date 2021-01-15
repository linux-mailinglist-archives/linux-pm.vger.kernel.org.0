Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3372F821C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 18:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbhAORWL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 12:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbhAORWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 12:22:11 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F430C061793
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2021 09:21:31 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x78so1230728ybe.11
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2021 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxzZ/Qnk01z8zwtpMZ9daSSidnxxWHeejrhyAXZTEZ0=;
        b=B/JFFOqPcdmIVqzwDgXE0hlp/xt4YiAvZDH4o37IhMsO9suJO1zDtHktpIQRUb3i5k
         s+RehkDhXK/Na1fU9Hj8BseNqmr3w0mTf+rXKlqhVGUaONcZXUTe7wPkCZQYf8OE6oft
         zUihAEBfmhy+WKOnoSK97uKESGxUltJvzkj8NVvWmol4Cou2pgZptrgwavn/prC4rAZX
         iV8zOitkv47PMHGv9VCNBqeICz0P7Vmm8i6YBGVgl18/LH0SxkL8sCGkBrxzygBMDdOh
         FY3WasN6GFQQ6sBoDMG5ENMeaptkNHIdvqJ8pyZRdg5L2wkl2yw+Lg4nbCIBvziZe4Dj
         8p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxzZ/Qnk01z8zwtpMZ9daSSidnxxWHeejrhyAXZTEZ0=;
        b=Njiz76PRsTQMZxYDvCQwcJCvU5Qu4+akS5ZBVc3ooKPxTEfmL0lea97kNvJmLSt3w1
         nrbZy3N9soTJGbm3k0xXcD0ELH0nBgjLXuha81cAG0roF+pcN4lXjTuJMcH1EVQm1TVD
         /l/KSA4SyLAGHDQWemdCZmTmQIBiEgl/UNVhETQAd4zqgeJ7zOb6o26OV6Jbe0Bh9lcf
         x4YXmuQwNXnffYUNhMlsZkaMt1nM9OM/AlFDYjdDrEenXUjWjJbRGrb+pDdoQ/h/Gqtf
         M40QTbiDfYq8nFCBDwLW64NTjzE2TY0WWXmRkUT6q42CaG3eQ2cWCTvfzLY1easZslxL
         bfrQ==
X-Gm-Message-State: AOAM533zVkwCt+jtVEsxYd1IXRfW7+Hlur9ag/lJJasMxSvU5DFgbtOT
        SoDRTg9lOeHhKlJ28zBun3Bsnal1rd4p0Z4gRq/PSg==
X-Google-Smtp-Source: ABdhPJykBRVp7LYsfZTEJVItUl00D79akqbLnAw5J5tYIz1pIIpe8i5dDV+tdNuGKsED41d2fNXu6vEIptgM5ZIqRlg=
X-Received: by 2002:a25:6604:: with SMTP id a4mr20116318ybc.412.1610731290143;
 Fri, 15 Jan 2021 09:21:30 -0800 (PST)
MIME-Version: 1.0
References: <2073294.4OfjquceTg@kreacher> <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
 <YAFmoinbKocE9Jf5@gerhold.net> <CAJZ5v0hgmrN_zWBrX7FsfP=7mZHf_BYm+Qe+E3Ti4k0mK7t2MA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hgmrN_zWBrX7FsfP=7mZHf_BYm+Qe+E3Ti4k0mK7t2MA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 15 Jan 2021 09:20:54 -0800
Message-ID: <CAGETcx_A9YLmiMeizsrJEcdTMSZpJU03twAdRSdGeco83Z5uCQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 15, 2021 at 5:03 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jan 15, 2021 at 11:03 AM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > Hi,
> >
> > On Thu, Jan 14, 2021 at 11:31:12AM -0800, Saravana Kannan wrote:
> > > On Thu, Jan 14, 2021 at 10:41 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > When adding a new device link, device_is_dependent() is used to
> > > > check whether or not the prospective supplier device does not
> > > > depend on the prospective consumer one to avoid adding loops
> > > > to the graph of device dependencies.
> > > >
> > > > However, device_is_dependent() does not take the ancestors of
> > > > the target device into account, so it may not detect an existing
> > > > reverse dependency if, for example, the parent of the target
> > > > device depends on the device passed as its first argument.
> > > >
> > > > For this reason, extend device_is_dependent() to also check if
> > > > the device passed as its first argument is an ancestor of the
> > > > target one and return 1 if that is the case.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > > > ---
> > > >  drivers/base/core.c |   12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > Index: linux-pm/drivers/base/core.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/base/core.c
> > > > +++ linux-pm/drivers/base/core.c
> > > > @@ -208,6 +208,16 @@ int device_links_read_lock_held(void)
> > > >  #endif
> > > >  #endif /* !CONFIG_SRCU */
> > > >
> > > > +static bool device_is_ancestor(struct device *dev, struct device *target)
> > > > +{
> > > > +       while (target->parent) {
> > > > +               target = target->parent;
> > > > +               if (dev == target)
> > > > +                       return true;
> > > > +       }
> > > > +       return false;
> > > > +}
> > > > +
> > > >  /**
> > > >   * device_is_dependent - Check if one device depends on another one
> > > >   * @dev: Device to check dependencies for.
> > > > @@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
> > > >         struct device_link *link;
> > > >         int ret;
> > > >
> > > > -       if (dev == target)
> > > > +       if (dev == target || device_is_ancestor(dev, target))
> > > >                 return 1;
> > > >
> > > >         ret = device_for_each_child(dev, target, device_is_dependent);
> > > >
> > >
> >
> > Thanks for the patch, Rafael! I tested it and it seems to avoid the
> > circular device link (and therefore also the crash). FWIW:
> >
> > Tested-by: Stephan Gerhold <stephan@gerhold.net>
>
> Thanks!
>
> > > The code works, but it's not at all obvious what it's doing. Because,
> > > at first glance, it's easy to mistakenly think that it's trying to
> > > catch this case:
> > > dev <- child1 <- child2 <- target
> > >
> >
> > Isn't this pretty much the case we are trying to catch? I have:
> >
> >   78d9000.usb <- ci_hdrc.0 <- ci_hdrc.0.ulpi <- phy-ci_hdrc.0.ulpi.0
> >
> > then something attempts to create a device link with
> > consumer = 78d9000.usb, supplier = phy-ci_hdrc.0.ulpi.0, and to check if
> > that is allowed we call device_is_dependent() with dev = 78d9000.usb,
> > target = phy-ci_hdrc.0.ulpi.0.
> >
> > Note that this case would normally be covered by the device_for_each_child().
> > It's not in this case because the klist_children of 78d9000.usb
> > is updated too late.
>
> Exactly.

Stephan,

What device/driver is this? Is this a dwc3 device/driver? That driver
does some weird/incorrect stuff the last time I checked.

>
> The supplier has been initialized, which is why device_is_dependent()
> is invoked at all, but it has not been fully registered yet, so
> device_for_each_child() cannot be relied on to catch all of the
> possible dependencies.

Rafael,

Ok, I understand this additional case now.

What functions does one call to get the device to this state? AFAIR,
device_add() does both the "initialization" and adding to the
parent's children list.

I'm okay with this, but I want to make sure the driver isn't doing weird stuff.

-Saravana
