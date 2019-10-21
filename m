Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14CDE16B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 02:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfJUAPF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 20:15:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41663 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfJUAPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 20:15:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id g13so9487620otp.8;
        Sun, 20 Oct 2019 17:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fq+vYEfQuv8rpJrOTJ9oLC4H1EvdrOj9GHc0KwJV19w=;
        b=lJmI0QBhhqAIpBOLFfYR+Tm7MhZs1tvTp8ipfadWgUyCTLEi/V/hY8BrIc+42s8Nzn
         3xb/4Izj83oo6wPq1AU9utt+ghVkeRagYyXcpvD59jao8Noh+u1WTXHVLVtjrQd4bUDp
         PuTUl6hKLU2NNKCsEd0//pTw/nUGWFypSb5lfzyC3aj6Qps54A7fTeWUmemIE7ZR0lhS
         6CRK68/xOkGzxvvaFpuyCSf5AInhtBfNNJzrQYA9H7v10VPTCta1rr1qev2To+zug3Iw
         7kvs8uS3tKUixQZiyMQKXU4+atjMyiO8YegFZc1y8xZDRq0f95lWEeRjVJzDZtgW1270
         kj4w==
X-Gm-Message-State: APjAAAXeR4UFtjhe/Fd3dh59qJQqhMEdGnobGAUWH2NQbKtqkS09151S
        HTRK/Gilw6r2J3t/xrsOdyEk5glv5T6EhsdERnY=
X-Google-Smtp-Source: APXvYqx/9Ny5dMXopObXoVn5Fx157H12CJIPbT82pFBL84O2+vxj9f5PxQ2rhV4EeXEM1v8hcF/AieUs8iMckw+9RiQ=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr16863262oth.266.1571616903535;
 Sun, 20 Oct 2019 17:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191017163503.30791-1-sudeep.holla@arm.com> <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <20191018101924.GA25540@bogus> <4881906.zjS51fuFuv@kreacher> <20191018110632.GB25540@bogus>
In-Reply-To: <20191018110632.GB25540@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Oct 2019 02:14:51 +0200
Message-ID: <CAJZ5v0hnvahJ6bu6SEVvavb1kRe=X0wP_JUS26h_d019u5z7PA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 1:06 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 18, 2019 at 12:37:51PM +0200, Rafael J. Wysocki wrote:
> > On Friday, October 18, 2019 12:19:24 PM CEST Sudeep Holla wrote:
> > > On Fri, Oct 18, 2019 at 11:32:47AM +0530, Viresh Kumar wrote:
> > > > On 18-10-19, 06:55, Sudeep Holla wrote:
> > > > > On Thu, Oct 17, 2019 at 11:26:54PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Thu, Oct 17, 2019 at 9:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 17, 2019 at 6:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > > > > >
> > > > > > > > dev_pm_qos_remove_request ends calling {max,min}_freq_req QoS notifiers
> > > > > > > > which schedule policy update work. It may end up racing with the freeing
> > > > > > > > the policy and unregistering the driver.
> > > > > > > >
> > > > > > > > One possible race is as below where the cpufreq_driver is unregistered
> > > > > > > > but the scheduled work gets executed at later stage when cpufreq_driver
> > > > > > > > is NULL(i.e. after freeing the policy and driver)
> > > > > > > >
> > > > > > > > Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> > > > > > > > pgd = (ptrval)
> > > > > > > > [0000001c] *pgd=80000080204003, *pmd=00000000
> > > > > > > > Internal error: Oops: 206 [#1] SMP THUMB2
> > > > > > > > Modules linked in:
> > > > > > > > CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc3-00006-g67f5a8081a4b #86
> > > > > > > > Hardware name: ARM-Versatile Express
> > > > > > > > Workqueue: events handle_update
> > > > > > > > PC is at cpufreq_set_policy+0x58/0x228
> > > > > > > > LR is at dev_pm_qos_read_value+0x77/0xac
> > > > > > > > Control: 70c5387d  Table: 80203000  DAC: fffffffd
> > > > > > > > Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
> > > > > > > >         (cpufreq_set_policy) from (refresh_frequency_limits.part.24+0x37/0x48)
> > > > > > > >         (refresh_frequency_limits.part.24) from (handle_update+0x2f/0x38)
> > > > > > > >         (handle_update) from (process_one_work+0x16d/0x3cc)
> > > > > > > >         (process_one_work) from (worker_thread+0xff/0x414)
> > > > > > > >         (worker_thread) from (kthread+0xff/0x100)
> > > > > > > >         (kthread) from (ret_from_fork+0x11/0x28)
> > > > > > > >
> > > > > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > > > > > ---
> > > > > > > >  drivers/cpufreq/cpufreq.c | 3 +++
> > > > > > > >  1 file changed, 3 insertions(+)
> > > > > > > >
> > > > > > > > Hi Rafael, Viresh,
> > > > > > > >
> > > > > > > > This fixed the boot issue I reported[1] on TC2 with bL switcher enabled.
> > > > > > > > I have based this patch on -rc3 and not on top of your patches. This
> > > > > > > > only fixes the boot issue but I hit the other crashes while continuously
> > > > > > > > switching on and off the bL switcher that register/unregister the driver
> > > > > > > > Your patch series fixes them. I can based this on top of those if you
> > > > > > > > prefer.
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Sudeep
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
> > > > > > > >
> > > > > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > > > > index c52d6fa32aac..b703c29a84be 100644
> > > > > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > > > > @@ -1278,6 +1278,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         dev_pm_qos_remove_request(policy->min_freq_req);
> > > > > > > > +       /* flush the pending policy->update work before freeing the policy */
> > > > > > > > +       if (work_pending(&policy->update))
> > > > > > >
> > > > > > > Isn't this racy?
> > > > > > >
> > > > > > > It still may be running if the pending bit is clear and we still need
> > > > > > > to wait for it then, don't we?
> > > > > > >
> > > > > > > Why don't you do an unconditional flush_work() here?
> > > > > >
> > > > > > You may as well do a cancel_work_sync() here, because whether or not
> > > > > > the last update of the policy happens before it goes away is a matter
> > > > > > of timing in any case
> > > > >
> > > > > In fact that's the first thing I tried to fix the issue I was seeing.
> > > > > But I then thought it would be better to complete the update as the PM
> > > > > QoS were getting updated back to DEFAULT values for the device. Even
> > > > > this works.
> > > > >
> > > > > What is your preference ? flush_work or cancel_work_sync ? I will
> > > > > update accordingly. I may need to do some more testing with
> > > > > cancel_work_sync as I just checked that quickly to confirm the race.
> > > >
> > > > As I said in the other email, this work didn't come as a result of
> > > > removal of the qos request from cpufreq core and so must have come
> > > > from other thermal or similar events.
> > >
> > > I don't think so. For sure not because of any thermal events. I didn't
> > > have log handy and hence had to wait till I was next to hardware.
> > >
> > > This is log:
> > >  cpufreq: cpufreq_policy_free: dev_pm_qos_remove_request max before
> > >  cpufreq: cpufreq_notifier_max: schedule_work(&policy->update)
> > >  cpufreq: cpufreq_policy_free: dev_pm_qos_remove_request max after
> > >  cpufreq: cpufreq_policy_free: dev_pm_qos_remove_request min before
> > >  cpufreq: cpufreq_notifier_min: schedule_work(&policy->update)
> > >  cpufreq: cpufreq_policy_free: dev_pm_qos_remove_request min after
> > >  cpufreq: cpufreq_policy_free: dev_pm_qos_remove_request max before
> > >  cpufreq: cpufreq_notifier_max: schedule_work(&policy->update)
> > >  cpufreq: cpufreq_policy_free: dev_pm_qos_remove_request max after
> > >  cpufreq: cpufreq_policy_free: dev_pm_qos_remove_request min before
> > >  cpufreq: cpufreq_notifier_min: schedule_work(&policy->update)
> > >  cpufreq: cpufreq_policy_free: dev_pm_qos_remove_request min after
> > >
> > > So if I move the call above, it still crashes as the work is getting
> > > scheduled later.
> >
> > OK, please cancel the work after dropping the last request.
> >
> > We still need to understand what is going on here, but the crash needs to be
> > prevented from occurring in the first place IMO.
> >
> Callstack is:
>
> (cpufreq_notifier_max)
> (notifier_call_chain)
> (blocking_notifier_call_chain)
> (pm_qos_update_target)
> (freq_qos_apply)
> (freq_qos_remove_request)
> (cpufreq_policy_free)
> (subsys_interface_unregister)
> (cpufreq_unregister_driver)

That may be due to a bug in one of my patches (it's adding one of the
notifiers to a wrong list).

Please re-test with the current linux-next branch that I've just pushed.
