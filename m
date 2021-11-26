Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02E445F4AA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 19:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbhKZSez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 13:34:55 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:40797 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbhKZScz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 13:32:55 -0500
Received: by mail-oi1-f170.google.com with SMTP id bk14so20348682oib.7;
        Fri, 26 Nov 2021 10:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU+F1ILhecfjPMi/oGN+9wdc0EneIk+uN4uyDUprisQ=;
        b=EqNAK+ooI3UVpyjHCjBMbVtbSkOdVVEyjIqN+y78fKZ4cua6cfJJbV2NBNWBIoV0CY
         ks/pOqVej8OSmUUdOimu6r/J/qjMk+YMClRTGOrnwVhNLcFqHJBozgwQRVTSjZC2dIUh
         cE2aDke30C4Uh3KD1XqZiMUftPI4p6eSrEqTQH5WCie+JaET2IUI20fRLTWu+czwNZAY
         6RWQBW2CnNrhlOOnC7jLJOfN1xlNVSH7LeAkoOHLj65UcxLZqyNmw9++4SrjGXuxURpT
         TXXoJ6zUIzrJzj9vSbyT/bS/nS1evS2PaDbRM1hSls27/vlZbgM1M0x5hiw92shtYDNH
         sU7g==
X-Gm-Message-State: AOAM533H7sWCF2NsYEQayPYPonzVymdcx0HJb4ZZ/PipIslfLJRRXp9b
        7DLoSOgYygx6Kfo+m13r7kgrAueIVUWEsluXX2M=
X-Google-Smtp-Source: ABdhPJxDB9trOvwGUqBibNIYUwvXDU30VtWd9Y6Y/BzmyEyMPyha+h+4xXw+5YyTaB9Giub1suJdasYz02RqL0vY8mE=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr24563889oiw.154.1637951381645;
 Fri, 26 Nov 2021 10:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <CAJZ5v0hrTDsCUn4vgmFrTTgd6H=orh-Kb5b3+_H9St4n8fTxBw@mail.gmail.com>
 <CAPDyKFre=tp4919FLoeU-wjLDJ02zmHaXY4wgTUmfmFbeaCadQ@mail.gmail.com> <4380690.LvFx2qVVIh@kreacher>
In-Reply-To: <4380690.LvFx2qVVIh@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Nov 2021 19:29:30 +0100
Message-ID: <CAJZ5v0gtqYRhQivLW1H243rGDWRKZPzbo-xEHvDz8jgQsChN6Q@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 26, 2021 at 7:00 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, November 26, 2021 2:46:02 PM CET Ulf Hansson wrote:
> > On Fri, 26 Nov 2021 at 14:30, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Nov 26, 2021 at 1:20 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Mon, 1 Nov 2021 at 10:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > On Fri, 29 Oct 2021 at 20:27, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Oct 29, 2021 at 12:20 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > >
> > > > > > > On Wed, 27 Oct 2021 at 16:33, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 27, 2021 at 12:55:43PM +0200, Ulf Hansson wrote:
> > > > > > > > > On Wed, 27 Oct 2021 at 04:02, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Oct 27, 2021 at 12:26:26AM +0200, Ulf Hansson wrote:
> > > > > > > > > > > During system suspend, the PM core sets dev->power.is_suspended for the
> > > > > > > > > > > device that is being suspended. This flag is also being used in
> > > > > > > > > > > rpm_resume(), to allow it to succeed by returning 1, assuming that runtime
> > > > > > > > > > > PM has been disabled and the runtime PM status is RPM_ACTIVE, for the
> > > > > > > > > > > device.
> > > > > > > > > > >
> > > > > > > > > > > To make this behaviour a bit more useful, let's drop the check for the
> > > > > > > > > > > dev->power.is_suspended flag in rpm_resume(), as it doesn't really need to
> > > > > > > > > > > be limited to this anyway.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/base/power/runtime.c | 4 ++--
> > > > > > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > > > > > > index ec94049442b9..fadc278e3a66 100644
> > > > > > > > > > > --- a/drivers/base/power/runtime.c
> > > > > > > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > > > > > > @@ -742,8 +742,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > > > > > > > > > >   repeat:
> > > > > > > > > > >       if (dev->power.runtime_error)
> > > > > > > > > > >               retval = -EINVAL;
> > > > > > > > > > > -     else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > > > > > > > > > > -         && dev->power.runtime_status == RPM_ACTIVE)
> > > > > > > > > > > +     else if (dev->power.disable_depth > 0 &&
> > > > > > > > > > > +             dev->power.runtime_status == RPM_ACTIVE)
> > > > > > > > > >
> > > > > > > > > > IIRC there was a good reason why the original code checked for
> > > > > > > > > > disable_depth == 1 rather than > 0.  But I don't remember exactly what
> > > > > > > > > > the reason was.  Maybe it had something to do with the fact that during
> > > > > > > > > > a system sleep __device_suspend_late calls __pm_runtime_disable, and the
> > > > > > > > > > code was checking that there were no other disables in effect.
> > > > > > > > >
> > > > > > > > > The check was introduced in the below commit:
> > > > > > > > >
> > > > > > > > > Commit 6f3c77b040fc
> > > > > > > > > Author: Kevin Hilman <khilman@ti.com>
> > > > > > > > > Date:   Fri Sep 21 22:47:34 2012 +0000
> > > > > > > > > PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE, even when disabled, v2
> > > > > > > > >
> > > > > > > > > By reading the commit message it's pretty clear to me that the check
> > > > > > > > > was added to cover only one specific use case, during system suspend.
> > > > > > > > >
> > > > > > > > > That is, that a driver may want to call pm_runtime_get_sync() from a
> > > > > > > > > late/noirq callback (when the PM core has disabled runtime PM), to
> > > > > > > > > understand whether the device is still powered on and accessible.
> > > > > > > > >
> > > > > > > > > > This is
> > > > > > > > > > related to the documented behavior of rpm_resume (it's supposed to fail
> > > > > > > > > > with -EACCES if the device is disabled for runtime PM, no matter what
> > > > > > > > > > power state the device is in).
> > > > > > > > > >
> > > > > > > > > > That probably is also the explanation for why dev->power.is_suspended
> > > > > > > > > > gets checked: It's how the code tells whether a system sleep is in
> > > > > > > > > > progress.
> > > > > > > > >
> > > > > > > > > Yes, you are certainly correct about the current behaviour. It's there
> > > > > > > > > for a reason.
> > > > > > > > >
> > > > > > > > > On the other hand I would be greatly surprised if this change would
> > > > > > > > > cause any issues. Of course, I can't make guarantees, but I am, of
> > > > > > > > > course, willing to help to fix problems if those happen.
> > > > > > > > >
> > > > > > > > > As a matter of fact, I think the current behaviour looks quite
> > > > > > > > > inconsistent, as it depends on whether the device is being system
> > > > > > > > > suspended.
> > > > > > > > >
> > > > > > > > > Moreover, for syscore devices (dev->power.syscore is set for them),
> > > > > > > > > the PM core doesn't set the "is_suspended" flag. Those can benefit
> > > > > > > > > from a common behaviour.
> > > > > > > > >
> > > > > > > > > Finally, I think the "is_suspended" flag actually needs to be
> > > > > > > > > protected by a lock when set by the PM core, as it's being used in two
> > > > > > > > > separate execution paths. Although, rather than adding a lock for
> > > > > > > > > protection, we can just rely on the "disable_depth" in rpm_resume().
> > > > > > > > > It would be easier and makes the behaviour consistent too.
> > > > > > > >
> > > > > > > > As long as is_suspended isn't _written_ in two separate execution paths,
> > > > > > > > we're probably okay without a lock -- provided the code doesn't mind
> > > > > > > > getting an indefinite result when a read races with a write.
> > > > > > >
> > > > > > > Well, indefinite doesn't sound very good to me for these cases, even
> > > > > > > if it most likely never will happen.
> > > > > > >
> > > > > > > >
> > > > > > > > > > So overall, I suspect this change should not be made.  But some other
> > > > > > > > > > improvement (like a nice comment) might be in order.
> > > > > > > > > >
> > > > > > > > > > Alan Stern
> > > > > > > > >
> > > > > > > > > Thanks for reviewing!
> > > > > > > >
> > > > > > > > You're welcome.  Whatever you eventually decide to do should be okay
> > > > > > > > with me.  I just wanted to make sure that you understood the deeper
> > > > > > > > issue here and had given it some thought.  For example, it may turn out
> > > > > > > > that you can resolve matters simply by updating the documentation.
> > > > > > >
> > > > > > > I observed the issue on cpuidle-psci. The devices it operates upon are
> > > > > > > assigned as syscore devices and these are hooked up to a genpd.
> > > > > > >
> > > > > > > A call to pm_runtime_get_sync() can happen even after the PM core has
> > > > > > > disabled runtime PM in the "late" phase. So the error code is received
> > > > > > > for these real use-cases.
> > > > > > >
> > > > > > > Now, as we currently don't check the return value of
> > > > > > > pm_runtime_get_sync() in cpuidle-psci, it's not a big deal. But it
> > > > > > > certainly seems worth fixing in my opinion.
> > > > > > >
> > > > > > > Let's see if Rafael has some thoughts around this.
> > > > > >
> > > > > > Am I thinking correctly that this is mostly about working around the
> > > > > > limitations of pm_runtime_force_suspend()?
> > > > >
> > > > > No, this isn't related at all.
> > > > >
> > > > > The cpuidle-psci driver doesn't have PM callbacks, thus using
> > > > > pm_runtime_force_suspend() would not work here.
> > > >
> > > > Just wanted to send a ping on this to see if we can come to a
> > > > conclusion. Or maybe we did? :-)
> > > >
> > > > I think in the end, what slightly bothers me, is that the behavior is
> > > > a bit inconsistent. Although, maybe it's the best we can do.
> > >
> > > I've been thinking about this and it looks like we can do better, but
> > > instead of talking about this I'd rather send a patch.
> >
> > Alright.
> >
> > I was thinking along the lines of make similar changes for
> > rpm_idle|suspend(). That would make the behaviour even more
> > consistent, I think.
> >
> > Perhaps that's what you have in mind? :-)
>
> Well, not exactly.
>
> The idea is to add another counter (called restrain_depth in the patch)
> to prevent rpm_resume() from running the callback when that is potentially
> problematic.  With that, it is possible to actually distinguish devices
> with PM-runtime enabled and it allows the PM-runtime status to be checked
> when it is still known to be meaningful.
>
> It requires quite a few changes, but is rather straightforward, unless I'm
> missing something.
>
> Please see the patch below.  I've only checked that it builds on x86-64.
>
> ---
>  drivers/base/power/main.c    |   18 +++----
>  drivers/base/power/runtime.c |  105 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/pm.h           |    2
>  include/linux/pm_runtime.h   |    2
>  4 files changed, 101 insertions(+), 26 deletions(-)
>
> Index: linux-pm/include/linux/pm.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm.h
> +++ linux-pm/include/linux/pm.h
> @@ -598,6 +598,7 @@ struct dev_pm_info {
>         atomic_t                usage_count;
>         atomic_t                child_count;
>         unsigned int            disable_depth:3;
> +       unsigned int            restrain_depth:3;       /* PM core private */
>         unsigned int            idle_notification:1;
>         unsigned int            request_pending:1;
>         unsigned int            deferred_resume:1;
> @@ -609,6 +610,7 @@ struct dev_pm_info {
>         unsigned int            use_autosuspend:1;
>         unsigned int            timer_autosuspends:1;
>         unsigned int            memalloc_noio:1;
> +       unsigned int            already_suspended:1;    /* PM core private */
>         unsigned int            links_count;
>         enum rpm_request        request;
>         enum rpm_status         runtime_status;
> Index: linux-pm/include/linux/pm_runtime.h
> ===================================================================
> --- linux-pm.orig/include/linux/pm_runtime.h
> +++ linux-pm/include/linux/pm_runtime.h
> @@ -46,6 +46,8 @@ extern void pm_runtime_enable(struct dev
>  extern void __pm_runtime_disable(struct device *dev, bool check_resume);
>  extern void pm_runtime_allow(struct device *dev);
>  extern void pm_runtime_forbid(struct device *dev);
> +extern void pm_runtime_restrain(struct device *dev);
> +extern void pm_runtime_relinquish(struct device *dev);
>  extern void pm_runtime_no_callbacks(struct device *dev);
>  extern void pm_runtime_irq_safe(struct device *dev);
>  extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -744,11 +744,11 @@ static int rpm_resume(struct device *dev
>   repeat:
>         if (dev->power.runtime_error)
>                 retval = -EINVAL;
> -       else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> -           && dev->power.runtime_status == RPM_ACTIVE)
> -               retval = 1;
>         else if (dev->power.disable_depth > 0)
>                 retval = -EACCES;
> +       else if (dev->power.restrain_depth > 0)
> +               retval = dev->power.runtime_status == RPM_ACTIVE ? 1 : -EAGAIN;
> +
>         if (retval)
>                 goto out;
>
> @@ -1164,9 +1164,9 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_acti
>   * @dev: Device to handle.
>   * @status: New runtime PM status of the device.
>   *
> - * If runtime PM of the device is disabled or its power.runtime_error field is
> - * different from zero, the status may be changed either to RPM_ACTIVE, or to
> - * RPM_SUSPENDED, as long as that reflects the actual state of the device.
> + * If runtime PM of the device is disabled or restrained, or its
> + * power.runtime_error field is nonzero, the status may be changed either to
> + * RPM_ACTIVE, or to RPM_SUSPENDED, as long as that reflects its actual state.
>   * However, if the device has a parent and the parent is not active, and the
>   * parent's power.ignore_children flag is unset, the device's status cannot be
>   * set to RPM_ACTIVE, so -EBUSY is returned in that case.
> @@ -1195,13 +1195,16 @@ int __pm_runtime_set_status(struct devic
>         spin_lock_irq(&dev->power.lock);
>
>         /*
> -        * Prevent PM-runtime from being enabled for the device or return an
> -        * error if it is enabled already and working.
> +        * Prevent PM-runtime from being used for the device or return an
> +        * error if it is in use already.
>          */
> -       if (dev->power.runtime_error || dev->power.disable_depth)
> -               dev->power.disable_depth++;
> -       else
> +       if (dev->power.runtime_error || dev->power.disable_depth ||
> +           dev->power.restrain_depth) {
> +               pm_runtime_get_noresume(dev);
> +               dev->power.restrain_depth++;
> +       } else {
>                 error = -EAGAIN;
> +       }
>
>         spin_unlock_irq(&dev->power.lock);
>
> @@ -1278,7 +1281,7 @@ int __pm_runtime_set_status(struct devic
>                 device_links_read_unlock(idx);
>         }
>
> -       pm_runtime_enable(dev);
> +       pm_runtime_relinquish(dev);
>
>         return error;
>  }
> @@ -1513,6 +1516,72 @@ void pm_runtime_allow(struct device *dev
>  EXPORT_SYMBOL_GPL(pm_runtime_allow);
>
>  /**
> + * pm_runtime_restrain - Temporarily block runtime PM of a device.
> + * @dev: Device to handle.
> + *
> + * Increase the device's usage count and its restrain_dpeth count.  If the
> + * latter was 0 initially, cancel the runtime PM work for @dev if pending and
> + * wait for all of the runtime PM operations on it in progress to complete.
> + *
> + * After this function has been called, attempts to runtime-suspend @dev will
> + * fail with -EAGAIN and attempts to runtime-resume it will succeed if its
> + * runtime PM status is RPM_ACTIVE and will fail with -EAGAIN otherwise.
> + *
> + * This function can only be called by the PM core.
> + */
> +void pm_runtime_restrain(struct device *dev)
> +{
> +       pm_runtime_get_noresume(dev);
> +
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.restrain_depth++ > 0)
> +               goto out;
> +
> +       if (dev->power.disable_depth > 0) {
> +               dev->power.already_suspended = false;
> +               goto out;
> +       }
> +
> +       /* Update time accounting before blocking PM-runtime. */
> +       update_pm_runtime_accounting(dev);
> +
> +       __pm_runtime_barrier(dev);
> +
> +       dev->power.already_suspended = pm_runtime_status_suspended(dev);
> +
> +out:
> +       spin_unlock_irq(&dev->power.lock);
> +}
> +
> +/**
> + * pm_runtime_relinquish - Unblock runtime PM of a device.
> + * @dev: Device to handle.
> + *
> + * Decrease the device's usage count and its restrain_dpeth count.
> + *
> + * This function can only be called by the PM core.
> + */
> +void pm_runtime_relinquish(struct device *dev)
> +{
> +       spin_lock_irq(&dev->power.lock);
> +
> +       if (dev->power.restrain_depth > 0) {
> +               dev->power.restrain_depth--;
> +
> +               /* About to unbolck runtime PM, set accounting_timestamp to now */
> +               if (!dev->power.restrain_depth && !dev->power.disable_depth)
> +                       dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
> +       } else {
> +               dev_warn(dev, "Unbalanced %s!\n", __func__);
> +       }
> +
> +       spin_unlock_irq(&dev->power.lock);
> +
> +       pm_runtime_put_noidle(dev);
> +}
> +
> +/**
>   * pm_runtime_no_callbacks - Ignore runtime PM callbacks for a device.
>   * @dev: Device to handle.
>   *
> @@ -1806,8 +1875,10 @@ int pm_runtime_force_suspend(struct devi
>         int (*callback)(struct device *);
>         int ret;
>
> -       pm_runtime_disable(dev);
> -       if (pm_runtime_status_suspended(dev))
> +       pm_runtime_restrain(dev);
> +
> +       /* No suspend if the device has already been suspended by PM-runtime. */
> +       if (!dev->power.already_suspended)

I got the check here the other way around, sorry.

>                 return 0;
>
>         callback = RPM_GET_CALLBACK(dev, runtime_suspend);
> @@ -1832,7 +1903,7 @@ int pm_runtime_force_suspend(struct devi
>         return 0;
>
>  err:
> -       pm_runtime_enable(dev);
> +       pm_runtime_relinquish(dev);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
> @@ -1854,7 +1925,7 @@ int pm_runtime_force_resume(struct devic
>         int (*callback)(struct device *);
>         int ret = 0;
>
> -       if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
> +       if (!dev->power.already_suspended || !dev->power.needs_force_resume)

And here I probably should leave the original check the way it is.

>                 goto out;
>
>         /*
> @@ -1874,7 +1945,7 @@ int pm_runtime_force_resume(struct devic
>         pm_runtime_mark_last_busy(dev);
>  out:
>         dev->power.needs_force_resume = 0;
> -       pm_runtime_enable(dev);
> +       pm_runtime_relinquish(dev);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_force_resume);
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -809,7 +809,7 @@ Skip:
>  Out:
>         TRACE_RESUME(error);
>
> -       pm_runtime_enable(dev);
> +       pm_runtime_relinquish(dev);
>         complete_all(&dev->power.completion);
>         return error;
>  }
> @@ -907,8 +907,8 @@ static int device_resume(struct device *
>                 goto Complete;
>
>         if (dev->power.direct_complete) {
> -               /* Match the pm_runtime_disable() in __device_suspend(). */
> -               pm_runtime_enable(dev);
> +               /* Match the pm_runtime_restrict() in __device_suspend(). */
> +               pm_runtime_relinquish(dev);
>                 goto Complete;
>         }
>
> @@ -1392,7 +1392,7 @@ static int __device_suspend_late(struct
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> -       __pm_runtime_disable(dev, false);
> +       pm_runtime_restrain(dev);
>
>         dpm_wait_for_subordinate(dev, async);
>
> @@ -1627,9 +1627,9 @@ static int __device_suspend(struct devic
>          * callbacks for it.
>          *
>          * If the system-wide suspend callbacks below change the configuration
> -        * of the device, they must disable runtime PM for it or otherwise
> -        * ensure that its runtime-resume callbacks will not be confused by that
> -        * change in case they are invoked going forward.
> +        * of the device, they must ensure that its runtime-resume callbacks
> +        * will not be confused by that change in case they are invoked going
> +        * forward.
>          */
>         pm_runtime_barrier(dev);
>
> @@ -1648,13 +1648,13 @@ static int __device_suspend(struct devic
>
>         if (dev->power.direct_complete) {
>                 if (pm_runtime_status_suspended(dev)) {
> -                       pm_runtime_disable(dev);
> +                       pm_runtime_restrain(dev);
>                         if (pm_runtime_status_suspended(dev)) {
>                                 pm_dev_dbg(dev, state, "direct-complete ");
>                                 goto Complete;
>                         }
>
> -                       pm_runtime_enable(dev);
> +                       pm_runtime_relinquish(dev);
>                 }
>                 dev->power.direct_complete = false;
>         }
>
>
>
