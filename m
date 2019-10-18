Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B12DBD51
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 07:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392030AbfJRF4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 01:56:11 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55370 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1733227AbfJRF4L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 01:56:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D34B329;
        Thu, 17 Oct 2019 22:55:46 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCD643F68E;
        Thu, 17 Oct 2019 22:58:30 -0700 (PDT)
Date:   Fri, 18 Oct 2019 06:55:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191018055533.GC31836@e107533-lin.cambridge.arm.com>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <CAJZ5v0gTpK0cJhsWGVvs-=Sbgcia0jz2j5QNYRL+1wOz=2xkJQ@mail.gmail.com>
 <CAJZ5v0h0ioEZqLuaW1jz_8jRuGYZLQS3fbpv9ctyV9ucXb1WiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h0ioEZqLuaW1jz_8jRuGYZLQS3fbpv9ctyV9ucXb1WiA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 11:26:54PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 17, 2019 at 9:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Oct 17, 2019 at 6:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > dev_pm_qos_remove_request ends calling {max,min}_freq_req QoS notifiers
> > > which schedule policy update work. It may end up racing with the freeing
> > > the policy and unregistering the driver.
> > >
> > > One possible race is as below where the cpufreq_driver is unregistered
> > > but the scheduled work gets executed at later stage when cpufreq_driver
> > > is NULL(i.e. after freeing the policy and driver)
> > >
> > > Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> > > pgd = (ptrval)
> > > [0000001c] *pgd=80000080204003, *pmd=00000000
> > > Internal error: Oops: 206 [#1] SMP THUMB2
> > > Modules linked in:
> > > CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc3-00006-g67f5a8081a4b #86
> > > Hardware name: ARM-Versatile Express
> > > Workqueue: events handle_update
> > > PC is at cpufreq_set_policy+0x58/0x228
> > > LR is at dev_pm_qos_read_value+0x77/0xac
> > > Control: 70c5387d  Table: 80203000  DAC: fffffffd
> > > Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
> > >         (cpufreq_set_policy) from (refresh_frequency_limits.part.24+0x37/0x48)
> > >         (refresh_frequency_limits.part.24) from (handle_update+0x2f/0x38)
> > >         (handle_update) from (process_one_work+0x16d/0x3cc)
> > >         (process_one_work) from (worker_thread+0xff/0x414)
> > >         (worker_thread) from (kthread+0xff/0x100)
> > >         (kthread) from (ret_from_fork+0x11/0x28)
> > >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > Hi Rafael, Viresh,
> > >
> > > This fixed the boot issue I reported[1] on TC2 with bL switcher enabled.
> > > I have based this patch on -rc3 and not on top of your patches. This
> > > only fixes the boot issue but I hit the other crashes while continuously
> > > switching on and off the bL switcher that register/unregister the driver
> > > Your patch series fixes them. I can based this on top of those if you
> > > prefer.
> > >
> > > Regards,
> > > Sudeep
> > >
> > > [1] https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index c52d6fa32aac..b703c29a84be 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -1278,6 +1278,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > >         }
> > >
> > >         dev_pm_qos_remove_request(policy->min_freq_req);
> > > +       /* flush the pending policy->update work before freeing the policy */
> > > +       if (work_pending(&policy->update))
> >
> > Isn't this racy?
> >
> > It still may be running if the pending bit is clear and we still need
> > to wait for it then, don't we?
> >
> > Why don't you do an unconditional flush_work() here?
> 
> You may as well do a cancel_work_sync() here, because whether or not
> the last update of the policy happens before it goes away is a matter
> of timing in any case

In fact that's the first thing I tried to fix the issue I was seeing.
But I then thought it would be better to complete the update as the PM
QoS were getting updated back to DEFAULT values for the device. Even
this works.

What is your preference ? flush_work or cancel_work_sync ? I will
update accordingly. I may need to do some more testing with
cancel_work_sync as I just checked that quickly to confirm the race.

--
Regards,
Sudeep
