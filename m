Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D66E43F29E
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 00:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhJ1WXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 18:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhJ1WXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 18:23:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612AAC061570
        for <linux-pm@vger.kernel.org>; Thu, 28 Oct 2021 15:20:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c28so16574805lfv.13
        for <linux-pm@vger.kernel.org>; Thu, 28 Oct 2021 15:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrMC6ps/Yy4KdTFANWsKX5xwpfm3xnZdTscIy4NxrwM=;
        b=r2rp15DmSFiQXaIqZojTMocwCNzQ7uibqUeLpOwuyknyyyrgRxBJtMfLSH7g8MnhGm
         AUE6u79hOGrrdXe9CoeYTZzrR2saPFLsgFWmkghX1eiKYEqd1ur4QtLJMKTxMYu4Ci+U
         pWPLRVN+3eyeIO2LIPyvN7lV7t4/xBLcXS3smaIqPoOwzs1EZN/iYzfgboGHJTGRFMOh
         GEe6Bo4h8XbGA9/tNdxZKWSWdoxjdgDZYJ/zmgvJT4+g7XZMn17KjL3q8Gy2lD8dQL9H
         iw736xfnE8WL++eYNmJqXwPgsFfrtoUVkEdMuCHJOVaD/pos+Q5M5P9FxP9PMHw8hUB5
         13zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrMC6ps/Yy4KdTFANWsKX5xwpfm3xnZdTscIy4NxrwM=;
        b=PRsGagFJ62MXDzOlDbUotzTf2N7gflhC43MIqJ5Ixkv8Kday6UJ32bKAi+oaxwmNO1
         y7KxMC+d6fSJw684IdkVSNvdJA48afWq0XwKjyzoUYWqmasMGDlUwH/A/ipnaBuaBi0t
         wmPS8ppBKf+MCl2Cnb8pMl9sI48k+xwzlzmDY8o6N1aI7LPXR/9rVQFiOAkue01CAhkg
         4++EWMRcrKrbH87H0Kym2Z1mwSytYhPCF7R0kboaU0kkqsNn/8/g+MxURf+P6ekT/nH5
         T2FS8+RIgoQC2RZ8mxlnrDFZnUtlY7VU37UeLcMOkRC7a8eePaBvRX+wu4Nk7PLnZvke
         kcqQ==
X-Gm-Message-State: AOAM530sJVYIJEMxpNzzROGKkN+pkD2vwa2pYJbVCwS8UO0iiAoXtBsP
        shVO6wIdK6SndX8KipZqXYkDe6gzRh0Qs3pFWaBTYQ==
X-Google-Smtp-Source: ABdhPJzVc+Tap1Ahd0sAw7lz95FWy8WEWdvKB4gdDXVSzeAd3fJljMWKzF7poGRnHwuGBovGkiFkH+H4vTavZjuMAr8=
X-Received: by 2002:a19:ad4d:: with SMTP id s13mr6988529lfd.373.1635459638664;
 Thu, 28 Oct 2021 15:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <20211027020235.GA1306582@rowland.harvard.edu> <CAPDyKFpgHJA-duQSA2uqhccrDxFqWXO1R1DJxo=aOkT5FyX+Ag@mail.gmail.com>
 <20211027143343.GC1319606@rowland.harvard.edu>
In-Reply-To: <20211027143343.GC1319606@rowland.harvard.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 29 Oct 2021 00:20:02 +0200
Message-ID: <CAPDyKFoMS-0WqNjtsrGy5-SV3RRbpgA3_HS5XDtNHH9wFgLhXg@mail.gmail.com>
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

On Wed, 27 Oct 2021 at 16:33, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Oct 27, 2021 at 12:55:43PM +0200, Ulf Hansson wrote:
> > On Wed, 27 Oct 2021 at 04:02, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Wed, Oct 27, 2021 at 12:26:26AM +0200, Ulf Hansson wrote:
> > > > During system suspend, the PM core sets dev->power.is_suspended for the
> > > > device that is being suspended. This flag is also being used in
> > > > rpm_resume(), to allow it to succeed by returning 1, assuming that runtime
> > > > PM has been disabled and the runtime PM status is RPM_ACTIVE, for the
> > > > device.
> > > >
> > > > To make this behaviour a bit more useful, let's drop the check for the
> > > > dev->power.is_suspended flag in rpm_resume(), as it doesn't really need to
> > > > be limited to this anyway.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/base/power/runtime.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > index ec94049442b9..fadc278e3a66 100644
> > > > --- a/drivers/base/power/runtime.c
> > > > +++ b/drivers/base/power/runtime.c
> > > > @@ -742,8 +742,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > > >   repeat:
> > > >       if (dev->power.runtime_error)
> > > >               retval = -EINVAL;
> > > > -     else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > > > -         && dev->power.runtime_status == RPM_ACTIVE)
> > > > +     else if (dev->power.disable_depth > 0 &&
> > > > +             dev->power.runtime_status == RPM_ACTIVE)
> > >
> > > IIRC there was a good reason why the original code checked for
> > > disable_depth == 1 rather than > 0.  But I don't remember exactly what
> > > the reason was.  Maybe it had something to do with the fact that during
> > > a system sleep __device_suspend_late calls __pm_runtime_disable, and the
> > > code was checking that there were no other disables in effect.
> >
> > The check was introduced in the below commit:
> >
> > Commit 6f3c77b040fc
> > Author: Kevin Hilman <khilman@ti.com>
> > Date:   Fri Sep 21 22:47:34 2012 +0000
> > PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE, even when disabled, v2
> >
> > By reading the commit message it's pretty clear to me that the check
> > was added to cover only one specific use case, during system suspend.
> >
> > That is, that a driver may want to call pm_runtime_get_sync() from a
> > late/noirq callback (when the PM core has disabled runtime PM), to
> > understand whether the device is still powered on and accessible.
> >
> > > This is
> > > related to the documented behavior of rpm_resume (it's supposed to fail
> > > with -EACCES if the device is disabled for runtime PM, no matter what
> > > power state the device is in).
> > >
> > > That probably is also the explanation for why dev->power.is_suspended
> > > gets checked: It's how the code tells whether a system sleep is in
> > > progress.
> >
> > Yes, you are certainly correct about the current behaviour. It's there
> > for a reason.
> >
> > On the other hand I would be greatly surprised if this change would
> > cause any issues. Of course, I can't make guarantees, but I am, of
> > course, willing to help to fix problems if those happen.
> >
> > As a matter of fact, I think the current behaviour looks quite
> > inconsistent, as it depends on whether the device is being system
> > suspended.
> >
> > Moreover, for syscore devices (dev->power.syscore is set for them),
> > the PM core doesn't set the "is_suspended" flag. Those can benefit
> > from a common behaviour.
> >
> > Finally, I think the "is_suspended" flag actually needs to be
> > protected by a lock when set by the PM core, as it's being used in two
> > separate execution paths. Although, rather than adding a lock for
> > protection, we can just rely on the "disable_depth" in rpm_resume().
> > It would be easier and makes the behaviour consistent too.
>
> As long as is_suspended isn't _written_ in two separate execution paths,
> we're probably okay without a lock -- provided the code doesn't mind
> getting an indefinite result when a read races with a write.

Well, indefinite doesn't sound very good to me for these cases, even
if it most likely never will happen.

>
> > > So overall, I suspect this change should not be made.  But some other
> > > improvement (like a nice comment) might be in order.
> > >
> > > Alan Stern
> >
> > Thanks for reviewing!
>
> You're welcome.  Whatever you eventually decide to do should be okay
> with me.  I just wanted to make sure that you understood the deeper
> issue here and had given it some thought.  For example, it may turn out
> that you can resolve matters simply by updating the documentation.

I observed the issue on cpuidle-psci. The devices it operates upon are
assigned as syscore devices and these are hooked up to a genpd.

A call to pm_runtime_get_sync() can happen even after the PM core has
disabled runtime PM in the "late" phase. So the error code is received
for these real use-cases.

Now, as we currently don't check the return value of
pm_runtime_get_sync() in cpuidle-psci, it's not a big deal. But it
certainly seems worth fixing in my opinion.

Let's see if Rafael has some thoughts around this.

Again, thanks for your input!

Kind regards
Uffe
