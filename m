Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1943C823
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 12:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbhJ0K6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbhJ0K6r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 06:58:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584BC061745
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 03:56:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e2so3917530ljg.13
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VcwIbDXyqxOVXmwhFTh3M4U8pwTWBcfpjA1gKThuQwM=;
        b=DOleeR66hVCWRUSE1vVRgpe8SJwg3hXoPhnYGSWr2h/1QsY59933hT503CxAL7bTNk
         iAmCUx0TWh3pVoqWNx9NfD3cn8DWC6uQYvCRUH8Mze9MIUaGAlJOWh9Rs6Jb+LYtgoST
         cjvI7vr2NNcKcaTXT3/tV9MElrGguJ5w9z+JbcXFX/2ofZN8/UsF+gKVIIl+ByuNaQ8Y
         yPsk8wPrbdfXVROwTXzZuSRkjgb9arBztxSpf3SmGhRUuRLcpdrnjYCpgT+j4EHzVgHA
         DYQvE5KXJ/1CnQ6ufOLPUW7E3xStkYgXY4qDSJNfLOpWZV1eVezITj1sM6bh3c8kXPLb
         DFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcwIbDXyqxOVXmwhFTh3M4U8pwTWBcfpjA1gKThuQwM=;
        b=BIzdmUnlslxJbEwWScJ2pIts8WPGnak2SlYtRjAi0+7d36Z+2hU7wnTo9Fojn0jnL4
         pFWhtW5hmk6g75Atho8Dqa1sZFmk+kEawYAfGsVECT5QAMv/nwBF69JIleaQmz5ZZV6F
         E55U5atZoCRJziBJ1scxI2cH3tccg8gSG6h+3MjLZ1NmpxhrUEzeN184ZpcuN+yWN+Ij
         kiH0o+w4lMztQmBBU10JxzCPcF6aMh8jmCDa2Hj/rdZOxPdwhoSOEsBpp9cAqySlf2Ff
         FxkuRYm+rfFeAn0Mh3iJCBJbchxht9FMMSUJlo1cfE2AvX6rWYA0A8v/MCVnp/zZHfJc
         7XaA==
X-Gm-Message-State: AOAM530kI/Ytkx2y5U39vLH+n1usu1MGw+Ozodzl6865HvQeZ6OveuRa
        5hV5mQN3kAah7z6l3RAGnTEyuAoCTqm11dqkBImEMg==
X-Google-Smtp-Source: ABdhPJy1h3NelpYd9TSvKaUHWrMYA+ZVL3fwLTcVJEPZpatCHhPdaElqmnb17Fr40bMDmvrRBl+JpTVBgGxcDMAKBTQ=
X-Received: by 2002:a2e:b550:: with SMTP id a16mr32975194ljn.229.1635332180469;
 Wed, 27 Oct 2021 03:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org> <20211027020235.GA1306582@rowland.harvard.edu>
In-Reply-To: <20211027020235.GA1306582@rowland.harvard.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Oct 2021 12:55:43 +0200
Message-ID: <CAPDyKFpgHJA-duQSA2uqhccrDxFqWXO1R1DJxo=aOkT5FyX+Ag@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Oct 2021 at 04:02, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Oct 27, 2021 at 12:26:26AM +0200, Ulf Hansson wrote:
> > During system suspend, the PM core sets dev->power.is_suspended for the
> > device that is being suspended. This flag is also being used in
> > rpm_resume(), to allow it to succeed by returning 1, assuming that runtime
> > PM has been disabled and the runtime PM status is RPM_ACTIVE, for the
> > device.
> >
> > To make this behaviour a bit more useful, let's drop the check for the
> > dev->power.is_suspended flag in rpm_resume(), as it doesn't really need to
> > be limited to this anyway.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index ec94049442b9..fadc278e3a66 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -742,8 +742,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
> >   repeat:
> >       if (dev->power.runtime_error)
> >               retval = -EINVAL;
> > -     else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > -         && dev->power.runtime_status == RPM_ACTIVE)
> > +     else if (dev->power.disable_depth > 0 &&
> > +             dev->power.runtime_status == RPM_ACTIVE)
>
> IIRC there was a good reason why the original code checked for
> disable_depth == 1 rather than > 0.  But I don't remember exactly what
> the reason was.  Maybe it had something to do with the fact that during
> a system sleep __device_suspend_late calls __pm_runtime_disable, and the
> code was checking that there were no other disables in effect.

The check was introduced in the below commit:

Commit 6f3c77b040fc
Author: Kevin Hilman <khilman@ti.com>
Date:   Fri Sep 21 22:47:34 2012 +0000
PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE, even when disabled, v2

By reading the commit message it's pretty clear to me that the check
was added to cover only one specific use case, during system suspend.

That is, that a driver may want to call pm_runtime_get_sync() from a
late/noirq callback (when the PM core has disabled runtime PM), to
understand whether the device is still powered on and accessible.

> This is
> related to the documented behavior of rpm_resume (it's supposed to fail
> with -EACCES if the device is disabled for runtime PM, no matter what
> power state the device is in).
>
> That probably is also the explanation for why dev->power.is_suspended
> gets checked: It's how the code tells whether a system sleep is in
> progress.

Yes, you are certainly correct about the current behaviour. It's there
for a reason.

On the other hand I would be greatly surprised if this change would
cause any issues. Of course, I can't make guarantees, but I am, of
course, willing to help to fix problems if those happen.

As a matter of fact, I think the current behaviour looks quite
inconsistent, as it depends on whether the device is being system
suspended.

Moreover, for syscore devices (dev->power.syscore is set for them),
the PM core doesn't set the "is_suspended" flag. Those can benefit
from a common behaviour.

Finally, I think the "is_suspended" flag actually needs to be
protected by a lock when set by the PM core, as it's being used in two
separate execution paths. Although, rather than adding a lock for
protection, we can just rely on the "disable_depth" in rpm_resume().
It would be easier and makes the behaviour consistent too.

>
> So overall, I suspect this change should not be made.  But some other
> improvement (like a nice comment) might be in order.
>
> Alan Stern

Thanks for reviewing!

Kind regards
Uffe
