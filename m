Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597793B1750
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhFWJ6T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 05:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJ6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 05:58:19 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5DC061756
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 02:56:01 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id u10so1084294vsu.12
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEF0pU+j9W7QEF7ZKp/0JDvB0o4iInh63yAG3OtQCpE=;
        b=UvDmlu72FFUpf0mmRF+8z/NdlKNhw4j6ynPqTbNuEmDiHP0k+XuX8ZOeLZ6lHtkgBz
         GWiREDhHP9Y4Pja1YIzt9jD9YkWY9PQURhPazPZ2POmrguE1NzXkV6rqfM5RQA9fFC07
         +bT/NGdokVqp7AMLE621icSDRF6+YnQRusTnieMbo21RPAWRWpSm/orAbdJmbBqLq0lc
         0J6dsJzkr/0agydrGcOJuQu3hK8X+DygP0lTiLQRyqCxidUZs7p7mFqJSFy71/9kYxOC
         cGWQE0gyVDzVp1Deu11EOeVWZctoWb1NzzblKSSzp4ypm2nyTH3a5aVf9lfBIQSg0Tcm
         FCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEF0pU+j9W7QEF7ZKp/0JDvB0o4iInh63yAG3OtQCpE=;
        b=j0UjVkrdBoqr0j0rDZ3M2navu1GSzfXY9WdFnjWh93zemhjbd3Ol0UsIqPeyG4kgBb
         NNan6pwErYSTkDsvOJDxmdqeYrS/oIu7zcw3a0UGhEHGbToLDSwBzKroer+xaEQbFCZc
         iSzXkUyiyN7fmqXU+S2xDVHsd/zoEDRJKe7fEDRuV77r0UiyAzFTx6R59lJsBC7OtVvm
         GjNOAh5cT96Aq+WVQZTZnw5kbBR/b46HgzEhqlXtSwCmvPQEyj0zAB5QEYWlsgEPDLmU
         own6EBmevIdiOKL/694TTaGwFS2BRYjWGtxUIq2HeAhU/z/aH9hqoqHV5eeIx6zH+rJm
         21Cw==
X-Gm-Message-State: AOAM530BmL2W8J/Ee/4Cf7MVayfN2QdJL+kty/EZgVMCa59hI2JurWqI
        3MwhlKSS2IMUufKEBcbJpjJAnANP+zlzM7hEgiw4wQ==
X-Google-Smtp-Source: ABdhPJxj7GpQ3PKbtuDhdeUp5vKfKSQlvikz2C0Pzs9lEsev7wE7CaimIDyJANObsB7KlCgeKZ18FjrvvmXStFE77O8=
X-Received: by 2002:a05:6102:3a70:: with SMTP id bf16mr18178025vsb.48.1624442160336;
 Wed, 23 Jun 2021 02:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210621201051.3211529-1-swboyd@chromium.org> <CAPDyKFr=sapFwgsDrZw5ZokcryGDpXDQTnv9kzAiijfuT6cw9g@mail.gmail.com>
 <CAE-0n53=AuYcBSTKkvDmNHpLMq7j4yTeMh5j80uN5dobqvC5ag@mail.gmail.com>
In-Reply-To: <CAE-0n53=AuYcBSTKkvDmNHpLMq7j4yTeMh5j80uN5dobqvC5ag@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Jun 2021 11:55:24 +0200
Message-ID: <CAPDyKFoxg0OhHUONm4dsOTyJperfM7bkkHpK0ikqP8u9mgi97w@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Shrink locking area of the gpd_list_lock
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 23 Jun 2021 at 10:31, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Ulf Hansson (2021-06-22 09:27:09)
> > On Mon, 21 Jun 2021 at 22:10, Stephen Boyd <swboyd@chromium.org> wrote:
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index b6a782c31613..18063046961c 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -1984,8 +1984,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> > >
> > >         mutex_lock(&gpd_list_lock);
> > >         list_add(&genpd->gpd_list_node, &gpd_list);
> > > -       genpd_debug_add(genpd);
> > >         mutex_unlock(&gpd_list_lock);
> > > +       genpd_debug_add(genpd);
> > >
> > >         return 0;
> > >  }
> > > @@ -2162,9 +2162,11 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
> > >         cp->xlate = xlate;
> > >         fwnode_dev_initialized(&np->fwnode, true);
> > >
> > > +       mutex_lock(&gpd_list_lock);
> >
> > By looking at the existing code, $subject patch makes the behavior
> > consistent and fixes the problem that the locks must always be
> > taken/released in the same order.
> >
> > However, as I have been looking at this before (but never got to the
> > point of sending a patch), I am actually thinking that it would be
> > better to decouple the two locks, instead of further combining them.
> >
> > In other words, we shouldn't lock/unlock the &gpd_list_lock here in
> > this function. Of course, that also means we need to fixup the code in
> > of_genpd_del_provider() accordingly.
>
> Yes I was wondering why this list lock was used here at all. It seems to
> be a substitute for calling genpd_lock()? I opted to just push the list

The genpd_lock should be used to protect some of the data in the genpd
struct. Like the genpd->provider and the genpd->has_provider, for
example.

Clearly, some of the data in the genpd struct are protected with
gpd_list_lock, which is suboptimal.

> lock as far down as possible to fix the problem, which is holding it
> over the calls into OPP.

Yes, we don't want that.

>
> If I've read the code correctly it serves no purpose to grab the
> gpd_list_lock here in genpd_add_provider() because we grab the
> of_genpd_mutex and that is protecting the of_genpd_providers list
> everywhere else. Is that right? Put another way, This hunk of the patch
> can be dropped and then your concern will be addressed and there isn't
> anything more to do.

It certainly can be dropped from the $subject patch, please re-spin to
update that.

However, there are additional changes that deserve to be done to
improve the behaviour around the locks. More precisely, the
&gpd_list_lock and the &of_genpd_mutex should be completely decoupled,
but there are some other related things as well.

Probably it's easier if I post a patch, on top of yours, to try to
further improve the behavior. I would appreciate it if you could help
with the test/review then.

>
> >
> >
> > >         mutex_lock(&of_genpd_mutex);
> > >         list_add(&cp->link, &of_genpd_providers);
> > >         mutex_unlock(&of_genpd_mutex);
> > > +       mutex_unlock(&gpd_list_lock);
> > >         pr_debug("Added domain provider from %pOF\n", np);
> > >
> > >         return 0;
> > > @@ -2314,8 +2314,6 @@ int of_genpd_add_provider_onecell(struct device_node *np,
> > >                 }
> > >         }
> > >
> > > -       mutex_unlock(&gpd_list_lock);
> > > -
> > >         return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
> >
> > I will continue to have a look at this and provide some more comments
> > asap, but overall the change is a step in the right direction.
> >
> > Possibly, we may even consider applying it as is and work on the
> > things I pointed out above, as improvements on top. Let's see, give me
> > a day or so.
> >
>
> Ok sure.

Kind regards
Uffe
