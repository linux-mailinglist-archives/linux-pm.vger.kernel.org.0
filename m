Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4DFDBF03
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 09:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390389AbfJRHxe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 03:53:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33988 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389483AbfJRHxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 03:53:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so4487826oii.1;
        Fri, 18 Oct 2019 00:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGwGKswYlm8qaeis0iFsbVhgq2LVEVHU2LaBuG3PciM=;
        b=JsZNJh6vTCjw3zMeEHoU+HmixoCOencWP1LRftDwpjltuTTfB2Cj/+B0Vte/WdnaYy
         V513eEm7+/QJX2DWGu0wK+Zzjxzwb5nJULtRc0LBtxN//Ve23u8wxqCsXLQaZXT/5SL6
         +jqyesZB7Ye8UjlACZbpcrJ48ax6aDAswlSCtaqzJP875MPvNbRH6CwdiJe8atc9QQLS
         SM1YPtZU/iSZANfUB7fDoFmXdv0uU2UIRjKzftfmVdPOJkCu31ER4Y+VxedjgpLsc8AR
         MDShdlURhupscRvastRrgBY7wRgilhMk7iXKwTGVQY19rHEUZL18TJ8Kck6lmZBn2hGp
         vkMg==
X-Gm-Message-State: APjAAAVsYzXUfIoeY2LxFBgPyg5gHNma6EI8NeAVceObAd2CAutuFGAH
        IyEuzGkTX0c0od21SUOMIvAkP9WiELnTK4eVpVQ=
X-Google-Smtp-Source: APXvYqxUo39R22IVM2V43Dq/N/66E03d1vqWWeDpxTi6q71S7C/QviIVZAi9rhlCbAdM1SF/aj03YJgVhwxln/mK+R8=
X-Received: by 2002:a05:6808:917:: with SMTP id w23mr6558466oih.68.1571385213609;
 Fri, 18 Oct 2019 00:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191017163503.30791-1-sudeep.holla@arm.com> <20191018053844.s2fbk2le6uz3chk6@vireshk-i7>
In-Reply-To: <20191018053844.s2fbk2le6uz3chk6@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Oct 2019 09:53:22 +0200
Message-ID: <CAJZ5v0hhFtKddeoSQwM6XGeeztgfcatG_cry5-bKEO=8EzGR1g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 7:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 17-10-19, 17:35, Sudeep Holla wrote:
> > dev_pm_qos_remove_request ends calling {max,min}_freq_req QoS notifiers
> > which schedule policy update work.
>
> I don't think that's correct. We remove the notifiers first and then
> only remove the requests. Though it is possible due to the other bug
> we are discussing where the notifier doesn't really get removed from
> the right CPU, but even that patch didn't fix your issue.

Right, that async update comes from somewhere else.

> Looks like we are still missing something ?
>
> > It may end up racing with the freeing
> > the policy and unregistering the driver.
> >
> > One possible race is as below where the cpufreq_driver is unregistered
> > but the scheduled work gets executed at later stage when cpufreq_driver
> > is NULL(i.e. after freeing the policy and driver)
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> > pgd = (ptrval)
> > [0000001c] *pgd=80000080204003, *pmd=00000000
> > Internal error: Oops: 206 [#1] SMP THUMB2
> > Modules linked in:
> > CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc3-00006-g67f5a8081a4b #86
> > Hardware name: ARM-Versatile Express
> > Workqueue: events handle_update
> > PC is at cpufreq_set_policy+0x58/0x228
> > LR is at dev_pm_qos_read_value+0x77/0xac
> > Control: 70c5387d  Table: 80203000  DAC: fffffffd
> > Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
> >       (cpufreq_set_policy) from (refresh_frequency_limits.part.24+0x37/0x48)
> >       (refresh_frequency_limits.part.24) from (handle_update+0x2f/0x38)
> >       (handle_update) from (process_one_work+0x16d/0x3cc)
> >       (process_one_work) from (worker_thread+0xff/0x414)
> >       (worker_thread) from (kthread+0xff/0x100)
> >       (kthread) from (ret_from_fork+0x11/0x28)
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > Hi Rafael, Viresh,
> >
> > This fixed the boot issue I reported[1] on TC2 with bL switcher enabled.
> > I have based this patch on -rc3 and not on top of your patches. This
> > only fixes the boot issue but I hit the other crashes while continuously
> > switching on and off the bL switcher that register/unregister the driver
> > Your patch series fixes them. I can based this on top of those if you
> > prefer.
> >
> > Regards,
> > Sudeep
> >
> > [1] https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index c52d6fa32aac..b703c29a84be 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1278,6 +1278,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >       }
> >
> >       dev_pm_qos_remove_request(policy->min_freq_req);
> > +     /* flush the pending policy->update work before freeing the policy */
> > +     if (work_pending(&policy->update))
> > +             flush_work(&policy->update);
>
> This diff surely makes sense even without the QoS stuff, this race can
> still happen, very unlikely though.
>
> And yes, you must use the other variant that Rafael suggested, we are
> already doing similar thing in a bunch of cpufreq governors :)
>
> And I will probably add this after calling
> dev_pm_qos_remove_notifier() for the MAX policy as this doesn't and
> shouldn't depend on removing the qos request.

Good point.

This is after taking the last CPU in the policy offline, so
policy->update cannot be scheduled from anywhere at this point.

> >       kfree(policy->min_freq_req);
> >
> >       cpufreq_policy_put_kobj(policy);
> > --
