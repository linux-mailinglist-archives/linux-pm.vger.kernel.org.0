Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3886421B344
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGJKh6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 06:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgGJKhx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 06:37:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF2720767;
        Fri, 10 Jul 2020 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594377450;
        bh=NyVHUKUKqlIxF5m3vLQzfv7RokHp5Hd2UtR/oSs8sTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5Qhv0XXv2QfyMLqukJD8k2q10i0TlKV7RExhxCN0j7hSTcVcK1UdQQBhI4Ghj95x
         llMcaZWiZHJNuS3P7qfE7pj2V+Li01tA9z+1Enz6we64oJxdBEpHsvYdoiqv0UuBwm
         uDBEZOpwOy9W3jX2eDiKdJZKD1iXZIBDB4Yd1dsE=
Date:   Fri, 10 Jul 2020 12:37:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Gustav Wiklander <gustav.wiklander@axis.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        kernel@axis.com, Gustav Wiklander <gustavwi@axis.com>
Subject: Re: [PATCHv2] PM / Domains: Add module ref count for each consumer
Message-ID: <20200710103734.GC1203263@kroah.com>
References: <20200610193156.20363-1-gustav.wiklander@axis.com>
 <CAPDyKFr_-ayyxAuzj92TwQmbcAVDrR6GSEQfD4HhWuUnseB0GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr_-ayyxAuzj92TwQmbcAVDrR6GSEQfD4HhWuUnseB0GA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 12:18:57PM +0200, Ulf Hansson wrote:
> On Wed, 10 Jun 2020 at 21:32, Gustav Wiklander
> <gustav.wiklander@axis.com> wrote:
> >
> > From: Gustav Wiklander <gustavwi@axis.com>
> >
> > Currently a pm_domain can be unloaded without regard for consumers.
> > This patch adds a module dependecy for every registered consumer.
> > Now a power domain driver can only be unloaded if no consumers are
> > registered.
> 
> According to the comments from Rafael, yes, this needs some further
> clarifications.
> 
> Moreover, we also need to deal with module reference counters when
> adding/removing subdomains. Also pointed out by Rafael.
> 
> >
> > Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
> > ---
> > Automated setting genpd->owner when calling pm_genpd_init.
> > Similar to how usb_register_driver does it.
> >
> >  drivers/base/power/domain.c | 22 +++++++++++++++++-----
> >  include/linux/pm_domain.h   | 10 ++++++++--
> >  2 files changed, 25 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 0a01df608849..70c8b59bfed9 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1499,11 +1499,18 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> >         if (IS_ERR(gpd_data))
> >                 return PTR_ERR(gpd_data);
> >
> > +       if (!try_module_get(genpd->owner)) {
> > +               ret = -ENODEV;
> > +               goto out;
> > +       }
> > +
> >         gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
> >
> >         ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
> > -       if (ret)
> > +       if (ret) {
> > +               module_put(genpd->owner);
> >                 goto out;
> > +       }
> >
> >         genpd_lock(genpd);
> >
> > @@ -1579,6 +1586,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
> >
> >         genpd_free_dev_data(dev, gpd_data);
> >
> > +       module_put(genpd->owner);
> > +
> >         return 0;
> >
> >   out:
> > @@ -1755,15 +1764,17 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
> >  }
> >
> >  /**
> > - * pm_genpd_init - Initialize a generic I/O PM domain object.
> > + * __pm_genpd_init - Initialize a generic I/O PM domain object.
> >   * @genpd: PM domain object to initialize.
> >   * @gov: PM domain governor to associate with the domain (may be NULL).
> >   * @is_off: Initial value of the domain's power_is_off field.
> > + * @owner: module owner of this power domain object.
> >   *
> >   * Returns 0 on successful initialization, else a negative error code.
> >   */
> > -int pm_genpd_init(struct generic_pm_domain *genpd,
> > -                 struct dev_power_governor *gov, bool is_off)
> > +int __pm_genpd_init(struct generic_pm_domain *genpd,
> > +                 struct dev_power_governor *gov, bool is_off,
> > +                 struct module *owner)
> 
> Please drop this new interface altogether. Instead we can just let the
> caller of pm_genpd_init() to assign genpd->owner, rather than passing
> it as a parameter.

No, I asked for this type of interface because it does not require any
developer to "remember" to set this value or not, and it does not
require you to go and fix the whole kernel.  This is the correct way to
do this, see the many other driver subsystems that do this today for
that reason.

thanks,

greg k-h
