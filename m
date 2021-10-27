Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFA743CC4B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhJ0OgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 10:36:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38441 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235365AbhJ0OgK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 10:36:10 -0400
Received: (qmail 1321012 invoked by uid 1000); 27 Oct 2021 10:33:43 -0400
Date:   Wed, 27 Oct 2021 10:33:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
Message-ID: <20211027143343.GC1319606@rowland.harvard.edu>
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <20211027020235.GA1306582@rowland.harvard.edu>
 <CAPDyKFpgHJA-duQSA2uqhccrDxFqWXO1R1DJxo=aOkT5FyX+Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpgHJA-duQSA2uqhccrDxFqWXO1R1DJxo=aOkT5FyX+Ag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 27, 2021 at 12:55:43PM +0200, Ulf Hansson wrote:
> On Wed, 27 Oct 2021 at 04:02, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Oct 27, 2021 at 12:26:26AM +0200, Ulf Hansson wrote:
> > > During system suspend, the PM core sets dev->power.is_suspended for the
> > > device that is being suspended. This flag is also being used in
> > > rpm_resume(), to allow it to succeed by returning 1, assuming that runtime
> > > PM has been disabled and the runtime PM status is RPM_ACTIVE, for the
> > > device.
> > >
> > > To make this behaviour a bit more useful, let's drop the check for the
> > > dev->power.is_suspended flag in rpm_resume(), as it doesn't really need to
> > > be limited to this anyway.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/base/power/runtime.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index ec94049442b9..fadc278e3a66 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -742,8 +742,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > >   repeat:
> > >       if (dev->power.runtime_error)
> > >               retval = -EINVAL;
> > > -     else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > > -         && dev->power.runtime_status == RPM_ACTIVE)
> > > +     else if (dev->power.disable_depth > 0 &&
> > > +             dev->power.runtime_status == RPM_ACTIVE)
> >
> > IIRC there was a good reason why the original code checked for
> > disable_depth == 1 rather than > 0.  But I don't remember exactly what
> > the reason was.  Maybe it had something to do with the fact that during
> > a system sleep __device_suspend_late calls __pm_runtime_disable, and the
> > code was checking that there were no other disables in effect.
> 
> The check was introduced in the below commit:
> 
> Commit 6f3c77b040fc
> Author: Kevin Hilman <khilman@ti.com>
> Date:   Fri Sep 21 22:47:34 2012 +0000
> PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE, even when disabled, v2
> 
> By reading the commit message it's pretty clear to me that the check
> was added to cover only one specific use case, during system suspend.
> 
> That is, that a driver may want to call pm_runtime_get_sync() from a
> late/noirq callback (when the PM core has disabled runtime PM), to
> understand whether the device is still powered on and accessible.
> 
> > This is
> > related to the documented behavior of rpm_resume (it's supposed to fail
> > with -EACCES if the device is disabled for runtime PM, no matter what
> > power state the device is in).
> >
> > That probably is also the explanation for why dev->power.is_suspended
> > gets checked: It's how the code tells whether a system sleep is in
> > progress.
> 
> Yes, you are certainly correct about the current behaviour. It's there
> for a reason.
> 
> On the other hand I would be greatly surprised if this change would
> cause any issues. Of course, I can't make guarantees, but I am, of
> course, willing to help to fix problems if those happen.
> 
> As a matter of fact, I think the current behaviour looks quite
> inconsistent, as it depends on whether the device is being system
> suspended.
> 
> Moreover, for syscore devices (dev->power.syscore is set for them),
> the PM core doesn't set the "is_suspended" flag. Those can benefit
> from a common behaviour.
> 
> Finally, I think the "is_suspended" flag actually needs to be
> protected by a lock when set by the PM core, as it's being used in two
> separate execution paths. Although, rather than adding a lock for
> protection, we can just rely on the "disable_depth" in rpm_resume().
> It would be easier and makes the behaviour consistent too.

As long as is_suspended isn't _written_ in two separate execution paths, 
we're probably okay without a lock -- provided the code doesn't mind 
getting an indefinite result when a read races with a write.

> > So overall, I suspect this change should not be made.  But some other
> > improvement (like a nice comment) might be in order.
> >
> > Alan Stern
> 
> Thanks for reviewing!

You're welcome.  Whatever you eventually decide to do should be okay 
with me.  I just wanted to make sure that you understood the deeper 
issue here and had given it some thought.  For example, it may turn out 
that you can resolve matters simply by updating the documentation.

Alan Stern
