Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8523B15E1
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhFWIdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhFWIdc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 04:33:32 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E20C061756
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 01:31:14 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso1161523otp.8
        for <linux-pm@vger.kernel.org>; Wed, 23 Jun 2021 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=pg6na3Sjfw7d1bgiBOhhyTulJ9ibeai4DyNwYAHS3qM=;
        b=axye4QEYJzMnPApVFh9BPUVTSlxZlQnMNxu/dG8yBvQE/3I9me2bLpmM3V+H6YXIwO
         hBfQ0CLeEX18/T6CRmCW38r49ZMpwy2ksNmYEki9QTC2N2UdlJQnUjBQbqaEpVNwcj6o
         eMqJMBdd8YKAwafCXvYrXfOvI5WDN2k3c+7zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=pg6na3Sjfw7d1bgiBOhhyTulJ9ibeai4DyNwYAHS3qM=;
        b=Wcv+6O2uDM31PwD776VynxiREw58KFRTE1RiP6gQFG55E2d3eWE7H3zVHC7GzfHUAv
         Ir6DAnacn10PRa2KOV/gFNLZVhWM8fBseE6+K+MFpIZa2ZXytZexlwLXDZZ7dWnCUqji
         HmU9zOfBWW8q0TIcZtSUueWvdCtl0wIze10elMvLxkFtEIgRGaafCI6OUDLPERyl62NH
         5fSl8fhzCtF0zmTMQLz6C38A1awC7hT1jhrxMmbgeqTXzT7cQovwiRHigk1Gc5twVxKy
         dyjgAf0LC6T6z6pE09O5Yr9uFJo1UNVhMcycwAn6kMwSqRhVlqG2uUDZeiiTLDHPyri7
         AlSw==
X-Gm-Message-State: AOAM532v4if30xq0qpXxkewlJrdiSytAuLhpf2Rzb+pG3JP/uh9EgdgF
        pQ9ZZ+5dJh6eNh7GE8rFIvC9dMdLpJh1z/4X6heF2Q==
X-Google-Smtp-Source: ABdhPJzoGyDigu72GEPhJsoELV95Ud6ooDVlV36ZQsM9jCJdfMYNuMxkFC+TKemTku7qLUHoo4YIqinnU6CaVzFLyRQ=
X-Received: by 2002:a9d:600b:: with SMTP id h11mr6953712otj.233.1624437073975;
 Wed, 23 Jun 2021 01:31:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Jun 2021 01:31:13 -0700
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr=sapFwgsDrZw5ZokcryGDpXDQTnv9kzAiijfuT6cw9g@mail.gmail.com>
References: <20210621201051.3211529-1-swboyd@chromium.org> <CAPDyKFr=sapFwgsDrZw5ZokcryGDpXDQTnv9kzAiijfuT6cw9g@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 23 Jun 2021 01:31:13 -0700
Message-ID: <CAE-0n53=AuYcBSTKkvDmNHpLMq7j4yTeMh5j80uN5dobqvC5ag@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Shrink locking area of the gpd_list_lock
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Quoting Ulf Hansson (2021-06-22 09:27:09)
> On Mon, 21 Jun 2021 at 22:10, Stephen Boyd <swboyd@chromium.org> wrote:
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index b6a782c31613..18063046961c 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1984,8 +1984,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> >
> >         mutex_lock(&gpd_list_lock);
> >         list_add(&genpd->gpd_list_node, &gpd_list);
> > -       genpd_debug_add(genpd);
> >         mutex_unlock(&gpd_list_lock);
> > +       genpd_debug_add(genpd);
> >
> >         return 0;
> >  }
> > @@ -2162,9 +2162,11 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
> >         cp->xlate = xlate;
> >         fwnode_dev_initialized(&np->fwnode, true);
> >
> > +       mutex_lock(&gpd_list_lock);
>
> By looking at the existing code, $subject patch makes the behavior
> consistent and fixes the problem that the locks must always be
> taken/released in the same order.
>
> However, as I have been looking at this before (but never got to the
> point of sending a patch), I am actually thinking that it would be
> better to decouple the two locks, instead of further combining them.
>
> In other words, we shouldn't lock/unlock the &gpd_list_lock here in
> this function. Of course, that also means we need to fixup the code in
> of_genpd_del_provider() accordingly.

Yes I was wondering why this list lock was used here at all. It seems to
be a substitute for calling genpd_lock()? I opted to just push the list
lock as far down as possible to fix the problem, which is holding it
over the calls into OPP.

If I've read the code correctly it serves no purpose to grab the
gpd_list_lock here in genpd_add_provider() because we grab the
of_genpd_mutex and that is protecting the of_genpd_providers list
everywhere else. Is that right? Put another way, This hunk of the patch
can be dropped and then your concern will be addressed and there isn't
anything more to do.

>
>
> >         mutex_lock(&of_genpd_mutex);
> >         list_add(&cp->link, &of_genpd_providers);
> >         mutex_unlock(&of_genpd_mutex);
> > +       mutex_unlock(&gpd_list_lock);
> >         pr_debug("Added domain provider from %pOF\n", np);
> >
> >         return 0;
> > @@ -2314,8 +2314,6 @@ int of_genpd_add_provider_onecell(struct device_node *np,
> >                 }
> >         }
> >
> > -       mutex_unlock(&gpd_list_lock);
> > -
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
>
> I will continue to have a look at this and provide some more comments
> asap, but overall the change is a step in the right direction.
>
> Possibly, we may even consider applying it as is and work on the
> things I pointed out above, as improvements on top. Let's see, give me
> a day or so.
>

Ok sure.
