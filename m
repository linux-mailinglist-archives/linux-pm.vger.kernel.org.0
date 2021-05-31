Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF93955C1
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 09:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhEaHK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 03:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhEaHK0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 03:10:26 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FA0C061574
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 00:08:45 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id q10so5223015uam.3
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vUcOLOLJFvqTx0Q1+alN5ka8ZC+o11y2paCA+C3hD8=;
        b=S2UNFqxEhgyn5voEcAQ5yYLEXfKVM2XwBNQgOUuhiwcTjPFzIfdtCZ4Yvj7mDRJSeG
         GDGUB0fLTUyYVPw25QdBjMlLftuN8zV0eLOH+bRziHVmayRjeAwUy9YTYl+QBGJ0taUg
         VMerwRBPrcWxjU2kKN2y2litigUU+LidXGKJfcGdTHpU7bal0AR64t8iq17b8g1KHJkE
         GAMQU1+BnASUYJbx317ew5z8+0Hd/DU2+g+0UczzK4+AssS9z1mOzBw0zwT0ADvKazdg
         W6uFCvdLj5ZywyQ+nPT2cDTjKM7XLcZjF2B0uDxzeNQHqbT3KGFoCJcCT1d9IfyUZQrR
         y5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vUcOLOLJFvqTx0Q1+alN5ka8ZC+o11y2paCA+C3hD8=;
        b=QHkTOMQ8/bb6QWqTFKnrbAqhRESYBA/h5b3oSw5P77JubVxVEiBL6AqddY5DyrRm/7
         0KkwhT6LZa7xP1z1UVOz8JMgqBUxZ/WbXvMnAkZJ31cltC0NK9gGj6a0LmoZ7vy83DsF
         wjGm1/Wrzhwaj+oItp7zJDrQaVHcjE6GBZw0NWkHecAPnjsyysQCZs2SOUjkxWU0Jc1Q
         CsxejVGURyHjYZxm24ywEf22JTGBTlAOwx4JeeCnf0ET1/CNNn+Fk30CRhFkUu5yf4/S
         cC31SSo1P0aveMSpx7rbcFcGi56Uss6DwRp4kXC3yBkCKU5zW5tJmzjj5yFvrhDrUP5i
         fqRw==
X-Gm-Message-State: AOAM532OdtditTtrtfhxJhruCMMKJIySsDU6A5x51HC19j3VVhZWe/3H
        qdv03lneHyPjY39mKQ5vEpvT+idMo0xPf1+0E8BkbA==
X-Google-Smtp-Source: ABdhPJzdcPknYIKY/HoFuBEvjeUrSBKGHjI3+ZdgXz4b7AY9qOCV+Wcz1GkCQofBeEC/XrGOEZA5hdhnC18QdgQMdNw=
X-Received: by 2002:ab0:100f:: with SMTP id f15mr9827076uab.100.1622444924930;
 Mon, 31 May 2021 00:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210528091202.11603-1-ulf.hansson@linaro.org> <20210528152719.GA1473569@rowland.harvard.edu>
In-Reply-To: <20210528152719.GA1473569@rowland.harvard.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 May 2021 09:08:08 +0200
Message-ID: <CAPDyKFp14pnSsaV3bnbW2FVTbtqTb5z39nZ0+NQM0YRv00W4JQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: runtime: Allow unassigned ->runtime_suspend|resume
 callbacks
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 28 May 2021 at 17:27, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, May 28, 2021 at 11:12:02AM +0200, Ulf Hansson wrote:
> > We are currently allowing ->rpm_idle() callbacks to be unassigned without
> > returning an error code from rpm_idle(). This has been useful to avoid
> > boilerplate code in drivers. Let's take this approach a step further, by
> > allowing unassigned ->runtime_suspend|resume() callbacks as well.
> >
> > In this way, a consumer/supplier device link can be used to let a consumer
> > device be power managed through its supplier device, without requiring
> > assigned ->runtime_suspend|resume() callbacks for the consumer device, for
> > example.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 68bebbf81347..8a66eaf731e4 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -345,7 +345,7 @@ static void rpm_suspend_suppliers(struct device *dev)
> >  static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> >       __releases(&dev->power.lock) __acquires(&dev->power.lock)
> >  {
> > -     int retval, idx;
> > +     int retval = 0, idx;
> >       bool use_links = dev->power.links_count > 0;
> >
> >       if (dev->power.irq_safe) {
> > @@ -373,7 +373,8 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> >               }
> >       }
> >
> > -     retval = cb(dev);
> > +     if (cb)
> > +             retval = cb(dev);
> >
> >       if (dev->power.irq_safe) {
> >               spin_lock(&dev->power.lock);
> > @@ -484,9 +485,6 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
> >  {
> >       int retval;
> >
> > -     if (!cb)
> > -             return -ENOSYS;
>
> This is a change in behavior, right?  What about drivers or subsystems
> that don't support runtime PM and consequently don't have any RPM
> callbacks assigned?

Yes, you are right.

However, drivers/subsystems that support runtime PM should also call
pm_runtime_enable() and if they don't, the rpm_callback() should not
get called for them.

Then, at least to me, I think it would be quite odd that a
subsystem/driver that calls pm_runtime_enable(), would be checking
return values from pm_runtime_get|put_*() for -ENOSYS? I mean, why
bother calling pm_runtime_enable() in the first place?

>
> Also, assuming Rafael accepts this change, don't you also need to update
> the runtime-PM documentation?

Good point, thanks! Let me add a patch updating the docs.

>
> Alan Stern
>

Kind regards
Uffe
