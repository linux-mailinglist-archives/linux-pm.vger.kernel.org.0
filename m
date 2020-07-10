Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E500F21B534
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGJMhf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 08:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJMhd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 08:37:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE3120772;
        Fri, 10 Jul 2020 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594384653;
        bh=3mgL0Xsw7l3dWlF8A5C8xZNqhhZYlFQyQbk+6H5ZBhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOhMiqOOY82yZH2/LKZZ+cRuW/4wwKZ2xggMy+wdNV1S9rchyVzy16KGF9z1CawmX
         Ouw34qWppih6X44wdil/Ra+Ea47QrW3DcP8Bu9G0BsvChXWZzAQ/t8pgqOCqX+8JkZ
         b6GrDRm5O4Rnhhw+w0v4l1RnkSM8ZVxRWCs14nw8=
Date:   Fri, 10 Jul 2020 14:37:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Gustav Wiklander <gustav.wiklander@axis.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        kernel@axis.com, Gustav Wiklander <gustavwi@axis.com>
Subject: Re: [PATCHv2] PM / Domains: Add module ref count for each consumer
Message-ID: <20200710123737.GA1546682@kroah.com>
References: <20200610193156.20363-1-gustav.wiklander@axis.com>
 <CAPDyKFr_-ayyxAuzj92TwQmbcAVDrR6GSEQfD4HhWuUnseB0GA@mail.gmail.com>
 <20200710103734.GC1203263@kroah.com>
 <CAPDyKFqUZwOMRv5537k2N8xiwjKgk3Fi8MB364+wVUaT-rHuEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqUZwOMRv5537k2N8xiwjKgk3Fi8MB364+wVUaT-rHuEw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 02:01:15PM +0200, Ulf Hansson wrote:
> On Fri, 10 Jul 2020 at 12:37, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jul 10, 2020 at 12:18:57PM +0200, Ulf Hansson wrote:
> > > On Wed, 10 Jun 2020 at 21:32, Gustav Wiklander
> > > <gustav.wiklander@axis.com> wrote:
> > > >
> > > > From: Gustav Wiklander <gustavwi@axis.com>
> > > >
> > > > Currently a pm_domain can be unloaded without regard for consumers.
> > > > This patch adds a module dependecy for every registered consumer.
> > > > Now a power domain driver can only be unloaded if no consumers are
> > > > registered.
> > >
> > > According to the comments from Rafael, yes, this needs some further
> > > clarifications.
> > >
> > > Moreover, we also need to deal with module reference counters when
> > > adding/removing subdomains. Also pointed out by Rafael.
> > >
> > > >
> > > > Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
> > > > ---
> > > > Automated setting genpd->owner when calling pm_genpd_init.
> > > > Similar to how usb_register_driver does it.
> > > >
> > > >  drivers/base/power/domain.c | 22 +++++++++++++++++-----
> > > >  include/linux/pm_domain.h   | 10 ++++++++--
> > > >  2 files changed, 25 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > index 0a01df608849..70c8b59bfed9 100644
> > > > --- a/drivers/base/power/domain.c
> > > > +++ b/drivers/base/power/domain.c
> > > > @@ -1499,11 +1499,18 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> > > >         if (IS_ERR(gpd_data))
> > > >                 return PTR_ERR(gpd_data);
> > > >
> > > > +       if (!try_module_get(genpd->owner)) {
> > > > +               ret = -ENODEV;
> > > > +               goto out;
> > > > +       }
> > > > +
> > > >         gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
> > > >
> > > >         ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
> > > > -       if (ret)
> > > > +       if (ret) {
> > > > +               module_put(genpd->owner);
> > > >                 goto out;
> > > > +       }
> > > >
> > > >         genpd_lock(genpd);
> > > >
> > > > @@ -1579,6 +1586,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
> > > >
> > > >         genpd_free_dev_data(dev, gpd_data);
> > > >
> > > > +       module_put(genpd->owner);
> > > > +
> > > >         return 0;
> > > >
> > > >   out:
> > > > @@ -1755,15 +1764,17 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
> > > >  }
> > > >
> > > >  /**
> > > > - * pm_genpd_init - Initialize a generic I/O PM domain object.
> > > > + * __pm_genpd_init - Initialize a generic I/O PM domain object.
> > > >   * @genpd: PM domain object to initialize.
> > > >   * @gov: PM domain governor to associate with the domain (may be NULL).
> > > >   * @is_off: Initial value of the domain's power_is_off field.
> > > > + * @owner: module owner of this power domain object.
> > > >   *
> > > >   * Returns 0 on successful initialization, else a negative error code.
> > > >   */
> > > > -int pm_genpd_init(struct generic_pm_domain *genpd,
> > > > -                 struct dev_power_governor *gov, bool is_off)
> > > > +int __pm_genpd_init(struct generic_pm_domain *genpd,
> > > > +                 struct dev_power_governor *gov, bool is_off,
> > > > +                 struct module *owner)
> > >
> > > Please drop this new interface altogether. Instead we can just let the
> > > caller of pm_genpd_init() to assign genpd->owner, rather than passing
> > > it as a parameter.
> >
> > No, I asked for this type of interface because it does not require any
> > developer to "remember" to set this value or not, and it does not
> > require you to go and fix the whole kernel.  This is the correct way to
> > do this, see the many other driver subsystems that do this today for
> > that reason.
> 
> Well, in many cases I would agree with you, but not for genpd.
> 
> We have and are still, continuously finding new configurations that
> are needed for a genpd. And we don't want a new in-parameter to be
> added each time that happens.

THIS_MODULE is "special", other config options you need should go in a
structure as you say.  This way we get the compiler to fix the option to
always be the correct one, no need for a developer to remember it,
totally different from all other driver/subsystem options.

thanks,

greg k-h
