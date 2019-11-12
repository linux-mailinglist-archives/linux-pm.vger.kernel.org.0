Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFCF87B6
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 06:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbfKLFK5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 00:10:57 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39486 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfKLFK4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 00:10:56 -0500
Received: by mail-vk1-f193.google.com with SMTP id j84so4153024vkj.6
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 21:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FUHFgvZSEngITMCI9orpsm1HceXAwenmOd8JoVpvmWw=;
        b=d2ab6AsY4RXH/1xsCbQSM3gYDzCo5eCXJuhWwuja/Znnu83rg5+C0TKIn3d9dVUUQt
         gBWC4SiiICPXcMI/n3SDSVCiE8AnM5TL4AOhMIAkWfLWKtW7uTKOuLnM/7x8EwpScm/N
         tAxAS0Iv1EuLEdnzWyFMP/yqjO1jmqZ/Nj4nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUHFgvZSEngITMCI9orpsm1HceXAwenmOd8JoVpvmWw=;
        b=knnHrW0R5MNeVGMf9/ls0PrkxasfGiMRQxsIxl5lZ295D10Pvy4YsG0NbUZ1dkZvzz
         0uBp/q7OOH6Poc+nQ9iRABdpRwnBqwdUXwQA8lwGl+vxZQothGTxlI/gHl5nST52Gex4
         QNVIZc9vO/75E3ibETF5+pMFrcv+Gghvs4AaIj9rZlTGoDJ8gAfku9Kpz24LlhtR7NWg
         FPtpETeESTUldRfacb2sY5EdexkxF4RbxEvjnBNcBiLP5rX+XQaoAd3PyzGesHRk/8+X
         q0sWrPRHJI8PWxJSscRqh1yFrWoPTgEgx0I2ILBCE4WDd7xPBihVFBOc/RRugNWyJeD7
         LVPg==
X-Gm-Message-State: APjAAAXVPDMnku4Rc/gVrqHOihjOoyeNy8ec/NqT1RerNJxOBWQKzq+7
        GMWOoYPhun9tyF7JKLG5lGSunG/e0v2HKFzLQ0E43w==
X-Google-Smtp-Source: APXvYqx6z8n8fAehowy7Z+42B3Oc/SI8Gr6VaJr/DSFNmYRy3Q5B44uXmM1iv6GuGiDGQCa9BTDsXZ9YAPYznmwHNxw=
X-Received: by 2002:a1f:3f56:: with SMTP id m83mr20412444vka.51.1573535455757;
 Mon, 11 Nov 2019 21:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20191030022105.223213-1-ikjn@chromium.org> <2576101.gjqMWB6DaV@kreacher>
In-Reply-To: <2576101.gjqMWB6DaV@kreacher>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 12 Nov 2019 13:10:44 +0800
Message-ID: <CAATdQgCH+WBU-caZ-kUFZxsYAQqMXNgCOtTosK5H70KodzkTaw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] cpuidle: undelaying cpuidle in dpm_{suspend|resume}()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, "Pavel Machek )" <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 8, 2019 at 7:22 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, October 30, 2019 3:21:05 AM CET Ikjoon Jang wrote:
> > cpuidle is paused only during dpm_suspend_noirq() ~ dpm_resume_noirq().
> > But some device drivers need random sized IOs in dpm_{suspend|resume}()
> > stage (e.g. re-downloading firmware in resume).
> > And with such a device, cpuidle's latencies could be critical to
> > response time of system suspend/resume.
> >
> > To minimize those latencies, we could apply pm_qos to such device drivers,
> > but simply undelaying cpuidle from dpm_suspend_noirq() to dpm suspend()
> > seems no harm.
>
> While the patch is generally acceptable, the changelog is not.
>
> First, what does "undelying" mean?

You're right, that should be fixed,
actually I used 'undelaying' from commit: 8651f97bd951d
(PM / cpuidle: System resume hang fix with cpuidle),
when the first time cpuidle_{pause|resume} is introduced:

"Since we are dealing with drivers it seems best to call this function
during dpm_suspend(). Delaying the call till dpm_suspend_noirq() does
no harm, as long as it is before cpu_hotplug_begin() to avoid race
conditions with cpu hotpulg operations."

Delaying does no harm, but I think that there had been no specific
reason of this
delay from the beginning. Undelaying does no harm too.

>
> Second, you seem to be talking about the cases in which exit latencies of
> idle states are not small relative to the system suspend/resume time, so
> without any specific examples this is not really convincing.
>
> Also, potentially, there is another reason to make this change, which is
> that on some systems i2c (or similar) controllers may be requisite for
> idle state entry and exit, so it may make sense in general to prevent
> cpuidle from being used over the entire suspend and resume of the
> system.  However, without any example of a system in which that matters
> it still is not convincing enough IMO.
>

Currently I've got only one specific device for examples.
Maybe this patch needs more generalized examples for applying to all
other machines.

Thanks!

> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > ---
> >  drivers/base/power/main.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 134a8af51511..5928dd2139e8 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -773,8 +773,6 @@ void dpm_resume_noirq(pm_message_t state)
> >
> >       resume_device_irqs();
> >       device_wakeup_disarm_wake_irqs();
> > -
> > -     cpuidle_resume();
> >  }
> >
> >  static pm_callback_t dpm_subsys_resume_early_cb(struct device *dev,
> > @@ -1069,6 +1067,7 @@ void dpm_resume(pm_message_t state)
> >
> >       cpufreq_resume();
> >       devfreq_resume();
> > +     cpuidle_resume();
> >       trace_suspend_resume(TPS("dpm_resume"), state.event, false);
> >  }
> >
> > @@ -1411,8 +1410,6 @@ int dpm_suspend_noirq(pm_message_t state)
> >  {
> >       int ret;
> >
> > -     cpuidle_pause();
> > -
> >       device_wakeup_arm_wake_irqs();
> >       suspend_device_irqs();
> >
> > @@ -1830,6 +1827,7 @@ int dpm_suspend(pm_message_t state)
> >       trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
> >       might_sleep();
> >
> > +     cpuidle_pause();
> >       devfreq_suspend();
> >       cpufreq_suspend();
> >
> >
>
>
>
>
