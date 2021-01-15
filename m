Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8081E2F7B4C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbhAONAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 08:00:12 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33651 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbhAONAM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 08:00:12 -0500
Received: by mail-oi1-f173.google.com with SMTP id d203so9452040oia.0;
        Fri, 15 Jan 2021 04:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvhCbOA5k3IxeAVfkiAa0smIV4HU4p/9zKuQCQSUGuA=;
        b=d3Df1OQWM7JhlLwuGGl4ks/DRfFzKHSVJJxCveRIpooutIpsA1RF3O1SJ+X+/IFt6Q
         5UJpEkk3CWMKSWCEm1mIIPzY+A0THjxf5sY+o6h4HV6N0NVwzReGK+ff7ALudNx4A1zZ
         OR+p2hporsTzuB1nj8UvqsYVSQT+P40CQz+xxtbNj65Posy9vId+WhKOS9tqpGSZR2lY
         ZQ4QMo3lqGoV0ONkK376cKLXslw5FwPJuLHxn10R9r4P0pp6XI8As7MEhR2CKW6Fzq6B
         iqxeBDmMVzLR8MhrN/QZYgOvSoAF61kyibqMykVQF1kfyq0zimwQqZeDUBjpGwUUYOIB
         YVGA==
X-Gm-Message-State: AOAM5328V4x0ShoFPzCKxtMhNmLvodJUq9C+qD4j6qjp9mYFExXQrKp0
        FRydQqFk2m3hiJMtcvKGYcLIhOC1zeLm5B/xhsY=
X-Google-Smtp-Source: ABdhPJzfeNsLfCbNEnl1Wxpov3PlygdxuZSAjP6IZbsk08NqecL/DEtG1ZxX7kxEXIO9udsCfLeE5f1LcHmC25DWG+k=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr5229964oig.69.1610715570885;
 Fri, 15 Jan 2021 04:59:30 -0800 (PST)
MIME-Version: 1.0
References: <2073294.4OfjquceTg@kreacher> <CAGETcx980TXe_Jur3LqpWoMwt0wG9BBvVdXfhAo3jU8-tgv=kw@mail.gmail.com>
 <CAJZ5v0jREeXtYa8LAiLoRBG1ok66BR86MCQxrQ1WPR5qbhTKbw@mail.gmail.com> <CAGETcx-G4YQ2Og0CrpVXK3n9Re=VNQbdSt=d7MA7gzRf8D5SxA@mail.gmail.com>
In-Reply-To: <CAGETcx-G4YQ2Og0CrpVXK3n9Re=VNQbdSt=d7MA7gzRf8D5SxA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jan 2021 13:59:19 +0100
Message-ID: <CAJZ5v0ganM6exWL62Pua4ETY_RNieW0JHixQZAx3ebiya94qNQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Extend device_is_dependent()
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 14, 2021 at 8:59 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jan 14, 2021 at 8:32 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
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
> > > The code works, but it's not at all obvious what it's doing. Because,
> > > at first glance, it's easy to mistakenly think that it's trying to
> > > catch this case:
> > > dev <- child1 <- child2 <- target
> > >
> > > Maybe it's clearer if we do this check inside the loop?
> >
> > Which of the loops do you mean?
>
> Sorry, the list of consumers loop.
>
> > There are two of them and both need
> > to do the check in each step AFAICS.
>
> I don't think we need it in the "loop through children" one. Here's why.
>
> We already make sure:
> 1. The prospective supplier (target) is not a child of the prospective
> consumer (dev).
> 2. The prospective supplier (target) is not a consumer of the
> prospective consumer (dev) or any of its children.
>
> To address the problem in the commit, we need to make changes to make sure:
> 3. The ancestor of prospective supplier (ancestor of target) is not a
> child of prospective consumer (dev)
> 4. The ancestor of prospective supplier (ancestor of target) is not a
> consumer of the prospective consumer (dev) or any of its children.

This should be taken care of by the recursive device_is_depedent()
invocation in the loop over consumers, but only if (and that's what's
really missing) the supplier has been fully registered.

If the supplier has been initialized, which is specifically checked by
device_link_add(), but not added, it may be missing from its parent's
list of children, but device_is_depedent() only checks those lists.

> But (3) would be caught automatically when we do (1). Because if (3)
> is true, (1) would also be true.
> So, what's left is (4), for which my suggestion should be sufficient?
>
> Does it make sense? Or am I missing anything else that needs to be checked?

AFAICS, the failing case is when the suppliers has been initialized
already, but not fully registered yet, because in that case it is not
sufficient to walk the list of children, it is also necessary to look
at the supplier's parent pointer (and the whole chain of direct
ancestors associated with it).

So the code change in the patch is correct, but the description of it isn't.

Let me respin.
