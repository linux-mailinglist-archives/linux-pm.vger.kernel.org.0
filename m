Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFE116D46
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 13:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLIMoy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 9 Dec 2019 07:44:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37336 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfLIMox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 07:44:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so12046893otn.4
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 04:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c+ELEXRFNNVXPowvEvklMHcDzPFbpmODjwtDaavTNMM=;
        b=W4vZacCGH32Zs2isc9a2P4SsheJuqIGY13Ny/07YgQ20wa6Bf1C59PSlz1ohEIU68+
         R3hhMMqUXQZ4RDXa/YrrTFooObHL2a9fLH3gsiA7qnM/e8EQZ9fxFL/4/bKqEZ/eb3hr
         38Jh4uzLyZgdvCP2pkkAu3Sg5DPeUrReaW/w9RgagDX91zdPJvtA5M4ENjam5MGC+3Ix
         NAmH0/3ZHrTuDKq+X+M+U/cdI2Z00TV+4lupLRO62jUVfWLC6EnV2brmGcmnHKLIxnUz
         aCvtcWlWgkT0aUahm1EVv0ZBWjoX5rKLVlTh7hlegtVswkHWZVHc30GVjCkRDFoXnxRO
         RCtw==
X-Gm-Message-State: APjAAAWzjVnc1cvZsRDj15Qte/Po5g2GNPp55EbJZdCfQ+60pXhdos9Y
        D1CjwqpcIXVyHCykGodYh1keaZi5jmoi9cBj5BI=
X-Google-Smtp-Source: APXvYqzlLQ/v/MzDNxzf8/iEOQAAOuDCLOxgBwFclffR3llUkvkgte6Xn/tURU1N9HUFsQHnvtolqN6QGJKasuRIPfs=
X-Received: by 2002:a9d:7447:: with SMTP id p7mr20299188otk.189.1575895492787;
 Mon, 09 Dec 2019 04:44:52 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher> <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com> <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
In-Reply-To: <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 13:44:41 +0100
Message-ID: <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peng Fan <peng.fan@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 9, 2019 at 1:32 PM Anson Huang <anson.huang@nxp.com> wrote:
>
>
>
> From Anson's iPhone 6
>
>
> > 在 2019年12月9日，19:23，Rafael J. Wysocki <rafael@kernel.org> 写道：
> >
> >> On Mon, Dec 9, 2019 at 11:57 AM Anson Huang <anson.huang@nxp.com> wrote:
> >>
> >> Forgot to mentioned that below patch on v5.4 can easily reproduce the panic() on our platforms which I think is unexpected, as the policy->cpus already be updated after governor stop, but still try to have irq work queued on it.
> >>
> >> static void dbs_update_util_handler(struct update_util_data *data, u64 time, unsigned int flags)
> >> +       if (!cpumask_test_cpu(smp_processor_id(), policy_dbs->policy->cpus))
> >> +               panic("...irq work on offline cpu %d\n", smp_processor_id());
> >>        irq_work_queue(&policy_dbs->irq_work);
> >
> > Yes, that is unexpected.
> >
> > In cpufreq_offline(), we have:
> >
> >    down_write(&policy->rwsem);
> >    if (has_target())
> >        cpufreq_stop_governor(policy);
> >
> >    cpumask_clear_cpu(cpu, policy->cpus);
> >
> > and cpufreq_stop_governor() calls policy->governor->stop(policy) which
> > is cpufreq_dbs_governor_stop().
> >
> > That calls gov_clear_update_util(policy_dbs->policy) first, which
> > invokes cpufreq_remove_update_util_hook() for each CPU in policy->cpus
> > and synchronizes RCU, so after that point none of the policy->cpus is
> > expected to run dbs_update_util_handler().
> >
> > policy->cpus is updated next and the governor is started again with
> > the new policy->cpus.  Because the offline CPU is not there, it is not
> > expected to run dbs_update_util_handler() again.
> >
> > Do you only get the original error when one of the CPUs goes back online?
>
> No, sometimes I also got this error during a CPU is being offline.
>
> But the point is NOT that dbs_update_util_handler() called during governor stop,
> it is that this function is running on a CPU which already finish the governor stop
> function,

Yes, it is, and which should not be possible as per the above.

The offline CPU is not there in prolicy->cpus when
cpufreq_dbs_governor_start() is called for the policy, so its
cpufreq_update_util_data pointer is not set (it is NULL at that time).
Therefore it is not expected to run dbs_update_util_handler() until it
is turn back online.

> I thought the original expectation is that this function ONLY be executed on the CPU which needs scaling frequency?
> Is this correct?

Yes, it is.

> v4.19 follows this expectation while v5.4 is NOT.

As per the kernel code, they both do.

> The only thing I can image is the changes in kernel/sched/ folder cause this difference, but I still need more time to figure out what changes cause it, if you have any suggestion, please advise, thanks!

The CPU offline/online (hotplug) rework was done after 4.19 IIRC and
that changed the way online works.  Now, it runs on the CPU going
online and previously it ran on the CPU "asking" the other one to go
online.  That may be what makes the difference (if my recollection of
the time frame is correct).
