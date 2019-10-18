Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2EDBD72
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 08:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404409AbfJRGCz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 02:02:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39095 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404382AbfJRGCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 02:02:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so2742936pgn.6
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 23:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bmw3lymR1IHTx/P5Cu0tNE9XSCLAlsThpDTND3pb92U=;
        b=EBFzFczkf/fK1c16qdE7jwqUeNg+KP5qrx86Hlocq2IqypVy6/EylgxZGKfD5Tloyj
         2bwsrTu7SV4sX6UeOE3Am1UAAKeyb0NehH9og2NTU8d3uefzBIiQhuLd0UKHxWaCxI10
         TVoDYepkEFiMAGd6W9Dv0lNELJNK2XhMfHC4TRs3ENz6mSYTc+MPey2M0cTULFjw6oz3
         ixKsqYpYHtSg9xMnHwRSRG3y9FngDD6jfR0TSv1wQBWRm3CFv2wTQFae5STUQJ22orKd
         kaYTYKn+iua86WrhKpIGvf0UebmlBM0rJ344YUaHWODnOgMYQvtwN0O+w5hRAJj1B0VV
         QxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmw3lymR1IHTx/P5Cu0tNE9XSCLAlsThpDTND3pb92U=;
        b=Un8k3BgXby71johD1xDGxXvRbbxxKcOJ6AltisfOJQqI6GCneEq6i67vL5RY5t8hJ8
         XuozHKTuHvJvVmCRJcNuQ8cwJWpeYM1P3RW+LgeO/Oy8AX7HT/ArhPvsoeKt5IvsgZYw
         78qF6BlDsgqbRdB7G6W/S5LMDnNzUWr4gjwzX5aJGDl875uT2pA9H6JwNxKYcGCscRVA
         Arg3Y4kKWpOmZvk2C3g6xkvhMOFJb3PDV4FaK7Tt/tHtGXIbpnXjT1yHaWwlMczeGWyc
         wi0OyaT6wcT7V1rbKwyWZ0KSfoQXJtibYtBd+Bj0rthv+Si/QnCq2+DbOnCkOBuWdjDF
         KEtA==
X-Gm-Message-State: APjAAAUt3Y88senSA0ypcmNzUq19AiTF3FOpy2+wBVfN4LroR6g4r/Qz
        P2L6mZE+kBdJyHEh8P0A4/xaoA==
X-Google-Smtp-Source: APXvYqxEQrJKtTB4vW18ekNhvfpWhYSlWkRk5ozKUeaI3cyZau19ilGNO36Ebj7Ami4euCIJxsEEHQ==
X-Received: by 2002:a17:90a:fd8d:: with SMTP id cx13mr8895469pjb.66.1571378572105;
        Thu, 17 Oct 2019 23:02:52 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id h70sm4128731pgc.48.2019.10.17.23.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 23:02:50 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:32:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <CAJZ5v0gTpK0cJhsWGVvs-=Sbgcia0jz2j5QNYRL+1wOz=2xkJQ@mail.gmail.com>
 <CAJZ5v0h0ioEZqLuaW1jz_8jRuGYZLQS3fbpv9ctyV9ucXb1WiA@mail.gmail.com>
 <20191018055533.GC31836@e107533-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018055533.GC31836@e107533-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 06:55, Sudeep Holla wrote:
> On Thu, Oct 17, 2019 at 11:26:54PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Oct 17, 2019 at 9:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 6:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > dev_pm_qos_remove_request ends calling {max,min}_freq_req QoS notifiers
> > > > which schedule policy update work. It may end up racing with the freeing
> > > > the policy and unregistering the driver.
> > > >
> > > > One possible race is as below where the cpufreq_driver is unregistered
> > > > but the scheduled work gets executed at later stage when cpufreq_driver
> > > > is NULL(i.e. after freeing the policy and driver)
> > > >
> > > > Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> > > > pgd = (ptrval)
> > > > [0000001c] *pgd=80000080204003, *pmd=00000000
> > > > Internal error: Oops: 206 [#1] SMP THUMB2
> > > > Modules linked in:
> > > > CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc3-00006-g67f5a8081a4b #86
> > > > Hardware name: ARM-Versatile Express
> > > > Workqueue: events handle_update
> > > > PC is at cpufreq_set_policy+0x58/0x228
> > > > LR is at dev_pm_qos_read_value+0x77/0xac
> > > > Control: 70c5387d  Table: 80203000  DAC: fffffffd
> > > > Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
> > > >         (cpufreq_set_policy) from (refresh_frequency_limits.part.24+0x37/0x48)
> > > >         (refresh_frequency_limits.part.24) from (handle_update+0x2f/0x38)
> > > >         (handle_update) from (process_one_work+0x16d/0x3cc)
> > > >         (process_one_work) from (worker_thread+0xff/0x414)
> > > >         (worker_thread) from (kthread+0xff/0x100)
> > > >         (kthread) from (ret_from_fork+0x11/0x28)
> > > >
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > Hi Rafael, Viresh,
> > > >
> > > > This fixed the boot issue I reported[1] on TC2 with bL switcher enabled.
> > > > I have based this patch on -rc3 and not on top of your patches. This
> > > > only fixes the boot issue but I hit the other crashes while continuously
> > > > switching on and off the bL switcher that register/unregister the driver
> > > > Your patch series fixes them. I can based this on top of those if you
> > > > prefer.
> > > >
> > > > Regards,
> > > > Sudeep
> > > >
> > > > [1] https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index c52d6fa32aac..b703c29a84be 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -1278,6 +1278,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > > >         }
> > > >
> > > >         dev_pm_qos_remove_request(policy->min_freq_req);
> > > > +       /* flush the pending policy->update work before freeing the policy */
> > > > +       if (work_pending(&policy->update))
> > >
> > > Isn't this racy?
> > >
> > > It still may be running if the pending bit is clear and we still need
> > > to wait for it then, don't we?
> > >
> > > Why don't you do an unconditional flush_work() here?
> > 
> > You may as well do a cancel_work_sync() here, because whether or not
> > the last update of the policy happens before it goes away is a matter
> > of timing in any case
> 
> In fact that's the first thing I tried to fix the issue I was seeing.
> But I then thought it would be better to complete the update as the PM
> QoS were getting updated back to DEFAULT values for the device. Even
> this works.
> 
> What is your preference ? flush_work or cancel_work_sync ? I will
> update accordingly. I may need to do some more testing with
> cancel_work_sync as I just checked that quickly to confirm the race.

As I said in the other email, this work didn't come as a result of
removal of the qos request from cpufreq core and so must have come
from other thermal or similar events. In that case maybe doing
flush_work() is better before we remove the cpufreq driver. Though
Rafael's timing related comment makes sense as well, but now that we
have received the work before policy is removed, I will rather
complete the work and quit.

-- 
viresh
