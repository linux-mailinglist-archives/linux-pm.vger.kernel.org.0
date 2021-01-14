Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB52A2F6B3A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 20:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbhANTj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 14:39:29 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45048 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbhANTj3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 14:39:29 -0500
Received: by mail-ot1-f52.google.com with SMTP id r9so6266742otk.11;
        Thu, 14 Jan 2021 11:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjAqxhBQ9KVJPQ7Xln3UosRFIz/jPg+p3aP0w5NuCFo=;
        b=QESmLSD4Bl8l4488Xq7QtSflwNp3n6+vpoe1MaxdGJJg7iJbHXhNXDWtXqrp1juOeO
         kB6jrCihdOAI5lkVCt4tEiElsvjTnX2PR5Ns93Vg2uN7FpIas5Hz/KXnLiLajcoxuGEF
         2lDn5OJJIm18Z5sT837BB8kzN3z07/bBviiqL3t3y0mPQ+t1M9fxYSmmBMXZ0uqD3Fh7
         EjxGbjnyuK2QoRHCetatatTFkbV6Gizq+JjuKHhRbfBaMBcnzDl/njo07s8YMSDhHdHq
         iimuOEnKY9pLIBQxSkMeiZWskGgv0ZdPRtSBSeJOmvwxWmFZuMHJK5Y/QW2ZSI7r8K8P
         DoGQ==
X-Gm-Message-State: AOAM532HQy8x4+2TSd33YPebptc+KcFVgWkBlppOM2Uz7YlGw7HGeByO
        iTt3iXuU1rasR0zN9lUB0TarM2ukUmmZkwswApSMzAay
X-Google-Smtp-Source: ABdhPJyWF+y3MoeHHSQg5WKaihfkQNskryp/9p6FwVe/9MYcgH8jA8FfspmJ79BqC858dptaM8zFYaOvZF8GTZqgMkA=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr5817920otk.206.1610653128501;
 Thu, 14 Jan 2021 11:38:48 -0800 (PST)
MIME-Version: 1.0
References: <2073294.4OfjquceTg@kreacher> <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
In-Reply-To: <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jan 2021 20:38:37 +0100
Message-ID: <CAJZ5v0jREeXtYa8LAiLoRBG1ok66BR86MCQxrQ1WPR5qbhTKbw@mail.gmail.com>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
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

On Thu, Jan 14, 2021 at 8:32 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 10:41 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When adding a new device link, device_is_dependent() is used to
> > check whether or not the prospective supplier device does not
> > depend on the prospective consumer one to avoid adding loops
> > to the graph of device dependencies.
> >
> > However, device_is_dependent() does not take the ancestors of
> > the target device into account, so it may not detect an existing
> > reverse dependency if, for example, the parent of the target
> > device depends on the device passed as its first argument.
> >
> > For this reason, extend device_is_dependent() to also check if
> > the device passed as its first argument is an ancestor of the
> > target one and return 1 if that is the case.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  drivers/base/core.c |   12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
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
> > @@ -221,7 +231,7 @@ int device_is_dependent(struct device *d
> >         struct device_link *link;
> >         int ret;
> >
> > -       if (dev == target)
> > +       if (dev == target || device_is_ancestor(dev, target))
> >                 return 1;
> >
> >         ret = device_for_each_child(dev, target, device_is_dependent);
> >
>
> The code works, but it's not at all obvious what it's doing. Because,
> at first glance, it's easy to mistakenly think that it's trying to
> catch this case:
> dev <- child1 <- child2 <- target
>
> Maybe it's clearer if we do this check inside the loop?

Which of the loops do you mean?  There are two of them and both need
to do the check in each step AFAICS.

> Something like:
>
>                 if (link->consumer == target ||
> device_is_ancestor(link->consumer, target))
>                         return 1;

So would this be sufficient?
