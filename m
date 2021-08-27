Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BF43F98F4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 14:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhH0MWB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 08:22:01 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33738 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhH0MWB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 08:22:01 -0400
Received: by mail-oi1-f174.google.com with SMTP id n27so9640236oij.0;
        Fri, 27 Aug 2021 05:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVmv4+HY+RT64ljpEZdINU3ktCc0DXVmgySFxtLtPPM=;
        b=rmghF+vFts+I6boLvWm0XOlvxPDYO66cy3xa+lwh3VfmE5dZ2ckTCGm1CyUQTRrkbL
         kv2JjYBPJixYhpO5aH6JYBZp0qZ0koKMFuLzrjQh8UeaWc8O8TnDIwW5f64FQpJMzR2F
         VISvEQtn39qb8jhal9iscQ5foiz7M+F4zqkf6px+mtggl2Z3/3zAHrIJ+KvIvavd+PcI
         l7VxjceLI6F9WiOqbhRC/1MobYZhHDiBlOAUMk/xIwCS5hw8wAXw8p/hjJOgO3lbgNYL
         7cTeLQ31SZlzY24wkVUDXWjNf1Tc3yllDC4PARa1WIAFdYlH/09/TBu6DtM6w2JjpuQ2
         fApA==
X-Gm-Message-State: AOAM531rF01PjwPrB54aBNbw4UVOWCcLRlQm3f2wX97imzXhnsIDdt9N
        JsCYb6TIDe91WZI3nyp0pJPqE5TWpPkWwNCr5D2ZwZNatKI1kg==
X-Google-Smtp-Source: ABdhPJxo2JgcZ50/2ipgTTyFWfhX7cGNfz7TG8Wmd1H046V3bSU3jXVqMK85blYQhGLUjU0OhynzrtA/Dht82GCFLkM=
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr15252176ois.157.1630066872134;
 Fri, 27 Aug 2021 05:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <1629732470-155444-1-git-send-email-psodagud@codeaurora.org> <YSipF4KG130rw9lc@kroah.com>
In-Reply-To: <YSipF4KG130rw9lc@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Aug 2021 14:21:00 +0200
Message-ID: <CAJZ5v0jBBx93WVz4DohwiBTEXhJtpA1=+_vyqE2=iBzm6MrbGw@mail.gmail.com>
Subject: Re: [PATCH v4] PM: sleep: core: Avoid setting power.must_resume to false
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 27, 2021 at 10:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 23, 2021 at 08:27:50AM -0700, Prasad Sodagudi wrote:
> > There are variables(power.may_skip_resume and dev->power.must_resume)
> > and DPM_FLAG_MAY_SKIP_RESUME flags to control the resume of devices after
> > a system wide suspend transition.
> >
> > Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver allows
> > its "noirq" and "early" resume callbacks to be skipped if the device
> > can be left in suspend after a system-wide transition into the working
> > state. PM core determines that the driver's "noirq" and "early" resume
> > callbacks should be skipped or not with dev_pm_skip_resume() function by
> > checking power.may_skip_resume variable.
> >
> > power.must_resume variable is getting set to false in __device_suspend()
> > function without checking device's DPM_FLAG_MAY_SKIP_RESUME settings.
> > In problematic scenario, where all the devices in the suspend_late
> > stage are successful and some device can fail to suspend in
> > suspend_noirq phase. So some devices successfully suspended in suspend_late
> > stage are not getting chance to execute __device_suspend_noirq()
> > to set dev->power.must_resume variable to true and not getting
> > resumed in early_resume phase.
> >
> > Add a check for device's DPM_FLAG_MAY_SKIP_RESUME flag before
> > setting power.must_resume variable in __device_suspend function.
> >
> > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
> > Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> > ---
> >  V3 -> V4: Remove dev->power.usage_count variable check
> >  V2 -> V3: Format issues patch posting
> >  V1 -> V2: Fixed indentation and commit text to include scenario
> >  drivers/base/power/main.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index d568772..50e8ea3 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1642,7 +1642,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
> >       }
> >
> >       dev->power.may_skip_resume = true;
> > -     dev->power.must_resume = false;
> > +     if (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME))
> > +             dev->power.must_resume = false;
> > +     else
> > +             dev->power.must_resume = true;
> >
> >       dpm_watchdog_set(&wd, dev);
> >       device_lock(dev);
>
> Seems sane, Rafael, any comments?

Yup, please see my response:
https://lore.kernel.org/linux-pm/CAJZ5v0hAuZmaB6j4qA7P43J4TshBrYa8UsX3KtH7hkxWZPU2wA@mail.gmail.com/T/#t

Cheers!
