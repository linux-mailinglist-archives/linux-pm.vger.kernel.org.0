Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6A14466A7
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhKEQGi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 12:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhKEQGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Nov 2021 12:06:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE911C061714
        for <linux-pm@vger.kernel.org>; Fri,  5 Nov 2021 09:03:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f3so19568546lfu.12
        for <linux-pm@vger.kernel.org>; Fri, 05 Nov 2021 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XzKFWhSS6DkqpWATzWV7MOvor0jL3FL4uP/IgR22cc=;
        b=JfiwnVvKh70PW3C7iFkKviSsV7G2+mL3uHOXYUtNqOOj+CpkSB9WOLKvw/EF2KIO0v
         a1a4iphmIi0ZvksC3lxZ9pHYYUu9vPp0iW189gGL2ox/yvKfKXNV4rzjmgDa1lFV/9P8
         6pi0bUEgnLCVxAS1UfUMMclATuOhrqJGuY1bl+l2ICJQYNJN8OcmPrqm07q8qrx3LCJ1
         IxSOLoriFP1cwAl++u+E79TeqiZUyb4zizqPWz445tZW49qR549mhH1AbniXgicgWo05
         eRadyvMaPTvU0ednrS8TgcXRtM7L6tutCIk3NrcwqLr/UXGOJRfmWdo9pvnXwpWyCE8n
         oMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XzKFWhSS6DkqpWATzWV7MOvor0jL3FL4uP/IgR22cc=;
        b=GVOQbpP9ARR/oZtcJHqYTmPXdJK7qBvOzraDjsRUjvUhaeuci0pQ0g09x5M8rphRDQ
         kZuRzrxbixu/S0umLV4TPMyCNpAJ2EbFRzdMnGzoIhdelS1WiGDXbdJnlpgT69655a4J
         jeGGGIPqWOpPgCCmRJ5514aBuylqsCx7vT04cjYgNziO8MqUTVmsXVzhM3/LbIiV2bUY
         VKaja9TA9a1dryje6yYKJ+xRpA/jnK198Slud9GwECGWAmNr6wWHj6ZpNiHVB4j2HOM4
         XeQKR3WCMtjY+hBNtrWeYJbyxd3AzSRSWdStgbd+FL8Q++Dnj+F0RagLvvQ6PAihclL8
         eO5Q==
X-Gm-Message-State: AOAM533uA+5cUMSORRlt6+rPUaBoZvLcD4Sm3AlOeHK6UvtPC9K0Lqj7
        XgYYUpwn8Yu7hXWc8VoaQu9kbnsujNo4sKdlqPNgTX7DC7eT1/Vm
X-Google-Smtp-Source: ABdhPJy42WiVAxGTVXogarPxToKhQOsUg3hiubg3VeRbS+XPuEJqHnE9NumXJ84EZ+dR/6LpiAmWNGBpANiveHFyzsw=
X-Received: by 2002:ac2:5a46:: with SMTP id r6mr9517811lfn.358.1636128235033;
 Fri, 05 Nov 2021 09:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <20211027020235.GA1306582@rowland.harvard.edu> <CAPDyKFpgHJA-duQSA2uqhccrDxFqWXO1R1DJxo=aOkT5FyX+Ag@mail.gmail.com>
 <20211027143343.GC1319606@rowland.harvard.edu> <CAPDyKFoMS-0WqNjtsrGy5-SV3RRbpgA3_HS5XDtNHH9wFgLhXg@mail.gmail.com>
 <CAJZ5v0iKMKhdxP9htt-fVm1RVBJnRO-pzJ9eySbBOSviSXCAdQ@mail.gmail.com>
 <CAPDyKFqR1S5Hw_RM90b44qETieW1f_59+k3KExdMXPpk_3Yygg@mail.gmail.com> <641a41bc-68ea-c0e9-9430-faf3803e12d5@ti.com>
In-Reply-To: <641a41bc-68ea-c0e9-9430-faf3803e12d5@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Nov 2021 17:03:18 +0100
Message-ID: <CAPDyKFo8h2udbmcm_wm2Ro1Ur6tcnrumXwCW+4o=-ecnnMkgXw@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 1 Nov 2021 at 15:41, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>
>
>
> On 01/11/2021 11:27, Ulf Hansson wrote:
> > On Fri, 29 Oct 2021 at 20:27, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Fri, Oct 29, 2021 at 12:20 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>
> >>> On Wed, 27 Oct 2021 at 16:33, Alan Stern <stern@rowland.harvard.edu> wrote:
> >>>>
> >>>> On Wed, Oct 27, 2021 at 12:55:43PM +0200, Ulf Hansson wrote:
> >>>>> On Wed, 27 Oct 2021 at 04:02, Alan Stern <stern@rowland.harvard.edu> wrote:
> >>>>>>
> >>>>>> On Wed, Oct 27, 2021 at 12:26:26AM +0200, Ulf Hansson wrote:
> >>>>>>> During system suspend, the PM core sets dev->power.is_suspended for the
> >>>>>>> device that is being suspended. This flag is also being used in
> >>>>>>> rpm_resume(), to allow it to succeed by returning 1, assuming that runtime
> >>>>>>> PM has been disabled and the runtime PM status is RPM_ACTIVE, for the
> >>>>>>> device.
> >>>>>>>
> >>>>>>> To make this behaviour a bit more useful, let's drop the check for the
> >>>>>>> dev->power.is_suspended flag in rpm_resume(), as it doesn't really need to
> >>>>>>> be limited to this anyway.
> >>>>>>>
> >>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>>>>> ---
> >>>>>>>   drivers/base/power/runtime.c | 4 ++--
> >>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> >>>>>>> index ec94049442b9..fadc278e3a66 100644
> >>>>>>> --- a/drivers/base/power/runtime.c
> >>>>>>> +++ b/drivers/base/power/runtime.c
> >>>>>>> @@ -742,8 +742,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
> >>>>>>>    repeat:
> >>>>>>>        if (dev->power.runtime_error)
> >>>>>>>                retval = -EINVAL;
> >>>>>>> -     else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> >>>>>>> -         && dev->power.runtime_status == RPM_ACTIVE)
> >>>>>>> +     else if (dev->power.disable_depth > 0 &&
> >>>>>>> +             dev->power.runtime_status == RPM_ACTIVE)
> >>>>>>
> >>>>>> IIRC there was a good reason why the original code checked for
> >>>>>> disable_depth == 1 rather than > 0.  But I don't remember exactly what
> >>>>>> the reason was.  Maybe it had something to do with the fact that during
> >>>>>> a system sleep __device_suspend_late calls __pm_runtime_disable, and the
> >>>>>> code was checking that there were no other disables in effect.
> >>>>>
> >>>>> The check was introduced in the below commit:
> >>>>>
> >>>>> Commit 6f3c77b040fc
> >>>>> Author: Kevin Hilman <khilman@ti.com>
> >>>>> Date:   Fri Sep 21 22:47:34 2012 +0000
> >>>>> PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE, even when disabled, v2
> >>>>>
> >>>>> By reading the commit message it's pretty clear to me that the check
> >>>>> was added to cover only one specific use case, during system suspend.
> >>>>>
> >>>>> That is, that a driver may want to call pm_runtime_get_sync() from a
> >>>>> late/noirq callback (when the PM core has disabled runtime PM), to
> >>>>> understand whether the device is still powered on and accessible.
> >>>>>
> >>>>>> This is
> >>>>>> related to the documented behavior of rpm_resume (it's supposed to fail
> >>>>>> with -EACCES if the device is disabled for runtime PM, no matter what
> >>>>>> power state the device is in).
> >>>>>>
> >>>>>> That probably is also the explanation for why dev->power.is_suspended
> >>>>>> gets checked: It's how the code tells whether a system sleep is in
> >>>>>> progress.
> >>>>>
> >>>>> Yes, you are certainly correct about the current behaviour. It's there
> >>>>> for a reason.
> >>>>>
> >>>>> On the other hand I would be greatly surprised if this change would
> >>>>> cause any issues. Of course, I can't make guarantees, but I am, of
> >>>>> course, willing to help to fix problems if those happen.
> >>>>>
> >>>>> As a matter of fact, I think the current behaviour looks quite
> >>>>> inconsistent, as it depends on whether the device is being system
> >>>>> suspended.
> >>>>>
> >>>>> Moreover, for syscore devices (dev->power.syscore is set for them),
> >>>>> the PM core doesn't set the "is_suspended" flag. Those can benefit
> >>>>> from a common behaviour.
> >>>>>
> >>>>> Finally, I think the "is_suspended" flag actually needs to be
> >>>>> protected by a lock when set by the PM core, as it's being used in two
> >>>>> separate execution paths. Although, rather than adding a lock for
> >>>>> protection, we can just rely on the "disable_depth" in rpm_resume().
> >>>>> It would be easier and makes the behaviour consistent too.
> >>>>
> >>>> As long as is_suspended isn't _written_ in two separate execution paths,
> >>>> we're probably okay without a lock -- provided the code doesn't mind
> >>>> getting an indefinite result when a read races with a write.
> >>>
> >>> Well, indefinite doesn't sound very good to me for these cases, even
> >>> if it most likely never will happen.
> >>>
> >>>>
> >>>>>> So overall, I suspect this change should not be made.  But some other
> >>>>>> improvement (like a nice comment) might be in order.
> >>>>>>
> >>>>>> Alan Stern
> >>>>>
> >>>>> Thanks for reviewing!
> >>>>
> >>>> You're welcome.  Whatever you eventually decide to do should be okay
> >>>> with me.  I just wanted to make sure that you understood the deeper
> >>>> issue here and had given it some thought.  For example, it may turn out
> >>>> that you can resolve matters simply by updating the documentation.
> >>>
> >>> I observed the issue on cpuidle-psci. The devices it operates upon are
> >>> assigned as syscore devices and these are hooked up to a genpd.
> >>>
> >>> A call to pm_runtime_get_sync() can happen even after the PM core has
> >>> disabled runtime PM in the "late" phase. So the error code is received
> >>> for these real use-cases.
> >>>
> >>> Now, as we currently don't check the return value of
> >>> pm_runtime_get_sync() in cpuidle-psci, it's not a big deal. But it
> >>> certainly seems worth fixing in my opinion.
> >>>
> >>> Let's see if Rafael has some thoughts around this.
> >>
> >> Am I thinking correctly that this is mostly about working around the
> >> limitations of pm_runtime_force_suspend()?
> >
> > No, this isn't related at all.
> >
> > The cpuidle-psci driver doesn't have PM callbacks, thus using
> > pm_runtime_force_suspend() would not work here.
> >
>
> i think reason for (dev->power.disable_depth == 1 && dev->power.is_suspended)
> can be found in [1], as other related comments:
>
> Rafael J. Wysocki:
> >>>
> I've discussed that with Kevin. The problem is that the runtime PM
> status may be changed at will when runtime PM is disabled by using
> __pm_runtime_set_status(), so the status generally cannod be trusted
> if power.disable_depth > 0.
>
> During system suspend, however, runtime PM is disabled by the core and
> if neither the driver nor the subsystem has disabled it in the meantime,
> the status should be actually valid.

I don't quite understand this comment from the past, but I guess it's
also kind of difficult without having the complete context.

In any case, if anyone updates the runtime PM status for a device
through __pm_runtime_set_status(), protection from concurrent accesses
is managed by using the spin lock (dev->power.lock).

> <<<
>
> Hence, this is about using PM runtime for CPU PM and, CPU PM is pretty specific case,
> wouldn't manual check for CPU PM status work for you, like !pm_runtime_status_suspended()?
>   (if i'm not mistaken - CPU PM done in atomic context).

No, that doesn't work. If I want to call pm_runtime_status_suspended()
to check the runtime PM status, I would first need to disable runtime
PM.

>
>
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1209.2/03256.html
>
> --
> Best regards,
> grygorii

Kind regards
Uffe
