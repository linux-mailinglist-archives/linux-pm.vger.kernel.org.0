Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7801121B61E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJNRV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJNRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:17:20 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06041C08C5CE
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:17:20 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g4so1799321uaq.10
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gw15wpGeqXvOX5aBsORUt4v0Otdb6NcrE1L0W9lqoOY=;
        b=VTyqqshO7y6iFpfrE9FP+pPw5ru7CSd1XDlPHUy0HvA/EzXytb8aANtsHmzwTA60a1
         ypR1HlyEyuawxLWvcZEhPLcTJRahhaKcqF8X8ixNCVoN991nE07LE9tBHlsy5M1gcyXc
         TD86TciXRtDvhqtcSTWAZQ4rdWuxPFsLEWwuYF3f4bAmqOqZ4qK1j2b6qt7N8IgjMzdS
         KEVMGSgASQESzXqarwZixnYLsxPKz6oFzlI66rQNBQqGobyvH9Q0WA5mR3yzraSpPvuk
         +lcRPPhj06P+InaT2vz4xyLuhB+JQtIYOKEK7h0+984/8uEP/LOS37q6FqX6YdxM6gTD
         N8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gw15wpGeqXvOX5aBsORUt4v0Otdb6NcrE1L0W9lqoOY=;
        b=qz+c1yUHygKg87sgh3B12B9ta1ZMvRx9LF6r1KDZZuY1HZA1drQfCrd7W9XJh7CqkF
         ecnc5RKG1nmnY/J9uSI3b7GBortJm9DpOazJusUzvDI6sFS9Wy4HFeVxzLW7j9yvXXmI
         nJQcRT9613awFWtyJEuRO3JtyWw//xgYBNF6mSpU5OpD7Gjba+k+M6hleigDq5s2BLvx
         vXB1c8KgKXMGeMIGNl6qE/dMXDgOZFPsDHNM3/WRwxnJEW04qPfLWtyut/a5EUyhU5b3
         AEwLsIyaWmiHWWqCHXUHsvvh86eKjPr6NRtHa/cvSpEAMJrHFha3A49bjXfMPCJ1IvwT
         12Eg==
X-Gm-Message-State: AOAM531htDxpHQxi0431aVUZk90tneuKDgAVdk/5daGG9eYBubqEt3Us
        uKcRO1qALeUscnwjfVOTP8ZOo/v/fRmRGu2kx1KwaQ==
X-Google-Smtp-Source: ABdhPJxH7GbW627uL5ArejPZUyq7i1OZWRVDKtkC8qCQ8r5pG0qUTUs3iXp71HXuaSfa9KnokWdV3VSsXTP9gewU1bg=
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr49272675uan.19.1594387039080;
 Fri, 10 Jul 2020 06:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200610193156.20363-1-gustav.wiklander@axis.com>
 <CAPDyKFr_-ayyxAuzj92TwQmbcAVDrR6GSEQfD4HhWuUnseB0GA@mail.gmail.com>
 <20200710103734.GC1203263@kroah.com> <CAPDyKFqUZwOMRv5537k2N8xiwjKgk3Fi8MB364+wVUaT-rHuEw@mail.gmail.com>
 <20200710123737.GA1546682@kroah.com>
In-Reply-To: <20200710123737.GA1546682@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Jul 2020 15:16:42 +0200
Message-ID: <CAPDyKFp=KRXXmiUJa-U++46i=GjpmAJ2x5Y-fUx9a2MWQ4Z_bQ@mail.gmail.com>
Subject: Re: [PATCHv2] PM / Domains: Add module ref count for each consumer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gustav Wiklander <gustav.wiklander@axis.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        kernel@axis.com, Gustav Wiklander <gustavwi@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 10 Jul 2020 at 14:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 10, 2020 at 02:01:15PM +0200, Ulf Hansson wrote:
> > On Fri, 10 Jul 2020 at 12:37, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Jul 10, 2020 at 12:18:57PM +0200, Ulf Hansson wrote:
> > > > On Wed, 10 Jun 2020 at 21:32, Gustav Wiklander
> > > > <gustav.wiklander@axis.com> wrote:
> > > > >
> > > > > From: Gustav Wiklander <gustavwi@axis.com>
> > > > >
> > > > > Currently a pm_domain can be unloaded without regard for consumers.
> > > > > This patch adds a module dependecy for every registered consumer.
> > > > > Now a power domain driver can only be unloaded if no consumers are
> > > > > registered.
> > > >
> > > > According to the comments from Rafael, yes, this needs some further
> > > > clarifications.
> > > >
> > > > Moreover, we also need to deal with module reference counters when
> > > > adding/removing subdomains. Also pointed out by Rafael.
> > > >
> > > > >
> > > > > Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
> > > > > ---
> > > > > Automated setting genpd->owner when calling pm_genpd_init.
> > > > > Similar to how usb_register_driver does it.
> > > > >
> > > > >  drivers/base/power/domain.c | 22 +++++++++++++++++-----
> > > > >  include/linux/pm_domain.h   | 10 ++++++++--
> > > > >  2 files changed, 25 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > > index 0a01df608849..70c8b59bfed9 100644
> > > > > --- a/drivers/base/power/domain.c
> > > > > +++ b/drivers/base/power/domain.c
> > > > > @@ -1499,11 +1499,18 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> > > > >         if (IS_ERR(gpd_data))
> > > > >                 return PTR_ERR(gpd_data);
> > > > >
> > > > > +       if (!try_module_get(genpd->owner)) {
> > > > > +               ret = -ENODEV;
> > > > > +               goto out;
> > > > > +       }
> > > > > +
> > > > >         gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
> > > > >
> > > > >         ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
> > > > > -       if (ret)
> > > > > +       if (ret) {
> > > > > +               module_put(genpd->owner);
> > > > >                 goto out;
> > > > > +       }
> > > > >
> > > > >         genpd_lock(genpd);
> > > > >
> > > > > @@ -1579,6 +1586,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
> > > > >
> > > > >         genpd_free_dev_data(dev, gpd_data);
> > > > >
> > > > > +       module_put(genpd->owner);
> > > > > +
> > > > >         return 0;
> > > > >
> > > > >   out:
> > > > > @@ -1755,15 +1764,17 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
> > > > >  }
> > > > >
> > > > >  /**
> > > > > - * pm_genpd_init - Initialize a generic I/O PM domain object.
> > > > > + * __pm_genpd_init - Initialize a generic I/O PM domain object.
> > > > >   * @genpd: PM domain object to initialize.
> > > > >   * @gov: PM domain governor to associate with the domain (may be NULL).
> > > > >   * @is_off: Initial value of the domain's power_is_off field.
> > > > > + * @owner: module owner of this power domain object.
> > > > >   *
> > > > >   * Returns 0 on successful initialization, else a negative error code.
> > > > >   */
> > > > > -int pm_genpd_init(struct generic_pm_domain *genpd,
> > > > > -                 struct dev_power_governor *gov, bool is_off)
> > > > > +int __pm_genpd_init(struct generic_pm_domain *genpd,
> > > > > +                 struct dev_power_governor *gov, bool is_off,
> > > > > +                 struct module *owner)
> > > >
> > > > Please drop this new interface altogether. Instead we can just let the
> > > > caller of pm_genpd_init() to assign genpd->owner, rather than passing
> > > > it as a parameter.
> > >
> > > No, I asked for this type of interface because it does not require any
> > > developer to "remember" to set this value or not, and it does not
> > > require you to go and fix the whole kernel.  This is the correct way to
> > > do this, see the many other driver subsystems that do this today for
> > > that reason.
> >
> > Well, in many cases I would agree with you, but not for genpd.
> >
> > We have and are still, continuously finding new configurations that
> > are needed for a genpd. And we don't want a new in-parameter to be
> > added each time that happens.
>
> THIS_MODULE is "special", other config options you need should go in a
> structure as you say.  This way we get the compiler to fix the option to
> always be the correct one, no need for a developer to remember it,
> totally different from all other driver/subsystem options.

Right. I didn't consider that THIS_MODULE is special, that's a good point.

In that case, I am okay with it (moving it to an static inline
function is also preferred by me, as pointed out by Rafael)

Kind regards
Uffe
