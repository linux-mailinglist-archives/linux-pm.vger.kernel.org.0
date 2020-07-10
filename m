Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CB21B499
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 14:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJMBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 08:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgGJMBx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 08:01:53 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA314C08C5CE
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 05:01:52 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id u133so2835903vsc.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzhnlPIIRMmU11ag8z5k4KmhsfXRqC/ByH3i5kzGD5E=;
        b=NqX9lshTTKQ1DalDogOzrv0ilbJ4bQSNpAP7abUA/4W+awaSoL1T6jEcEb0P1qUnBp
         Tz4MCKFEHjIaHw+N27I5pGZfyJ5yZwEHP0N5sywfh77Uz0Jaza2UP5xWdGxPsLgsVcTy
         rvwuOwf5oCJNuw/Y7SMqjet7NJ2BMl71PW/ZL3TVvrrM4iGtl32SB/ZfSRDafrtQCjXe
         1X9W9kXQEf6AV0R1imhUk16ca2XYQ7fslYEPhlbrqdUUfJ6pER6l/rzgEUnD0SU8cqu8
         qPNd4Yagk7xMUqrhWsVoIj8sJllA9O2JMcY+Scwm2aQ9Brn1Osc1Yud/CZlHCLZRdww1
         bThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzhnlPIIRMmU11ag8z5k4KmhsfXRqC/ByH3i5kzGD5E=;
        b=SGwPfCNaBYiPNr1d5FSJW5VC9VD1Ch4BJK6w8ckXlZL/lnwqRv4IDhHB8rDplpFInF
         pTKBwtTMenlS3Gan6uEgdHuWowpBJ2jgWit9T5ch4ID8V8iIMfID/dUqpI9Pg+tFET9/
         6vhmcnanDyXZK8mt0qdgesAN2xWOoudipseRolJA2INLc0ReJGYtJAtgaOf0DycovET+
         s/NjpyRCvMFXxpyeepPO7iEgpDUVWnXu6OVTJdzlWOVpJg650laOgHxW+aCbd57PaLKj
         oCrC/lINT2kiajzZM4/5dstHp6MdunpMbLxNWWsRHiG9AsZFBaqMI9LdIFgnQkgV7aI2
         p7Uw==
X-Gm-Message-State: AOAM533MQJDXtvK/tACEKpM3cXW2shkaGvdun35INO7TLEvJEdclo17W
        +zSpcSLT8CRz7plTkUzAuDbU7G7L4wAubjhp2ghmAg==
X-Google-Smtp-Source: ABdhPJyhFZCOi3nGD/GK5a6shrhjvGt+sCSqi9x330iUa5KCiCJfFFhlQ3eBPgov1KJkO9OBqUHBk+qhyh4XYAfbfak=
X-Received: by 2002:a05:6102:22f3:: with SMTP id b19mr5123214vsh.191.1594382511695;
 Fri, 10 Jul 2020 05:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200610193156.20363-1-gustav.wiklander@axis.com>
 <CAPDyKFr_-ayyxAuzj92TwQmbcAVDrR6GSEQfD4HhWuUnseB0GA@mail.gmail.com> <20200710103734.GC1203263@kroah.com>
In-Reply-To: <20200710103734.GC1203263@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Jul 2020 14:01:15 +0200
Message-ID: <CAPDyKFqUZwOMRv5537k2N8xiwjKgk3Fi8MB364+wVUaT-rHuEw@mail.gmail.com>
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

On Fri, 10 Jul 2020 at 12:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 10, 2020 at 12:18:57PM +0200, Ulf Hansson wrote:
> > On Wed, 10 Jun 2020 at 21:32, Gustav Wiklander
> > <gustav.wiklander@axis.com> wrote:
> > >
> > > From: Gustav Wiklander <gustavwi@axis.com>
> > >
> > > Currently a pm_domain can be unloaded without regard for consumers.
> > > This patch adds a module dependecy for every registered consumer.
> > > Now a power domain driver can only be unloaded if no consumers are
> > > registered.
> >
> > According to the comments from Rafael, yes, this needs some further
> > clarifications.
> >
> > Moreover, we also need to deal with module reference counters when
> > adding/removing subdomains. Also pointed out by Rafael.
> >
> > >
> > > Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
> > > ---
> > > Automated setting genpd->owner when calling pm_genpd_init.
> > > Similar to how usb_register_driver does it.
> > >
> > >  drivers/base/power/domain.c | 22 +++++++++++++++++-----
> > >  include/linux/pm_domain.h   | 10 ++++++++--
> > >  2 files changed, 25 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 0a01df608849..70c8b59bfed9 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -1499,11 +1499,18 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
> > >         if (IS_ERR(gpd_data))
> > >                 return PTR_ERR(gpd_data);
> > >
> > > +       if (!try_module_get(genpd->owner)) {
> > > +               ret = -ENODEV;
> > > +               goto out;
> > > +       }
> > > +
> > >         gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
> > >
> > >         ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
> > > -       if (ret)
> > > +       if (ret) {
> > > +               module_put(genpd->owner);
> > >                 goto out;
> > > +       }
> > >
> > >         genpd_lock(genpd);
> > >
> > > @@ -1579,6 +1586,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
> > >
> > >         genpd_free_dev_data(dev, gpd_data);
> > >
> > > +       module_put(genpd->owner);
> > > +
> > >         return 0;
> > >
> > >   out:
> > > @@ -1755,15 +1764,17 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
> > >  }
> > >
> > >  /**
> > > - * pm_genpd_init - Initialize a generic I/O PM domain object.
> > > + * __pm_genpd_init - Initialize a generic I/O PM domain object.
> > >   * @genpd: PM domain object to initialize.
> > >   * @gov: PM domain governor to associate with the domain (may be NULL).
> > >   * @is_off: Initial value of the domain's power_is_off field.
> > > + * @owner: module owner of this power domain object.
> > >   *
> > >   * Returns 0 on successful initialization, else a negative error code.
> > >   */
> > > -int pm_genpd_init(struct generic_pm_domain *genpd,
> > > -                 struct dev_power_governor *gov, bool is_off)
> > > +int __pm_genpd_init(struct generic_pm_domain *genpd,
> > > +                 struct dev_power_governor *gov, bool is_off,
> > > +                 struct module *owner)
> >
> > Please drop this new interface altogether. Instead we can just let the
> > caller of pm_genpd_init() to assign genpd->owner, rather than passing
> > it as a parameter.
>
> No, I asked for this type of interface because it does not require any
> developer to "remember" to set this value or not, and it does not
> require you to go and fix the whole kernel.  This is the correct way to
> do this, see the many other driver subsystems that do this today for
> that reason.

Well, in many cases I would agree with you, but not for genpd.

We have and are still, continuously finding new configurations that
are needed for a genpd. And we don't want a new in-parameter to be
added each time that happens.

What I have been thinking of, is to introduce a "genpd init data
struct" that we can pass as an in-parameter at registration point
instead. Although, I think that means a bit more work and it would not
be fair to force Gustav to implement this.

Kind regards
Uffe
