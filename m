Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F048F118224
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLJIW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 03:22:26 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34427 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfLJIWZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 03:22:25 -0500
Received: by mail-oi1-f181.google.com with SMTP id l136so9054350oig.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 00:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hzDkH/QKGYlQKbNC1C+7eRD4+NGjLxYhLRfdNHT6Vk=;
        b=SyvKufX6brb+XqvO6mvlnv2Xw83VAOICcJckGGtq4gL32u17dVuaZFURLDQiQyDbjp
         AnON9fTIUZVhSVIRM52OnbCTqyGcoBMlinTgyhK020brz9Sqtl7APwjLshRpBhk8kPhx
         q1nCKAMJt5cGTtGQ0wDz0joUinQ8ZavXD7ztghPMGuCzdKx5SMRudbttYNfY7o5z/lM8
         1warclh9KykPiDY3FIx1J3v0eS+jWAIUVltimUDF6HBZNezu2LFE+7nUrvGQRkAmXwSK
         /nKHk+hMvWH60khUWiLvibkP6+sw4BNrZqKVXgCjbJOOcGI8EhrwxcOGC2B2Q2Z4SxAd
         slcg==
X-Gm-Message-State: APjAAAUuahriRX80A6GJZBSGRk1osbnMLXsTsjbK9xGjQ8edXIrMXKko
        WocVefraOTZ+PsXbdMoypV/DFnk/sLWUD8oCEuM=
X-Google-Smtp-Source: APXvYqx7J0NosgVhtBkNVEfCd5vUETGfk999oT48qlVrpqNh74wr4WsJrA5/BbRaiQEYzy3Oz4QtyL1VdMHPuuanY9g=
X-Received: by 2002:aca:4f48:: with SMTP id d69mr3046521oib.103.1575966144770;
 Tue, 10 Dec 2019 00:22:24 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher> <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com> <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
 <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20191210070535.bvfzigolydhyz2ix@vireshk-i7>
In-Reply-To: <20191210070535.bvfzigolydhyz2ix@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Dec 2019 09:22:12 +0100
Message-ID: <CAJZ5v0hQeZDOiQC=UT+nEOc27E7Rn0O_7tLbeO1YMinCntDFCQ@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 8:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +few more guys
>
> On 10-12-19, 05:53, Peng Fan wrote:
> > But per https://elixir.bootlin.com/linux/v5.5-rc1/source/kernel/sched/sched.h#L2293
> > cpu_of(rq) and smp_processor_id() is possible to not the same,
> >
> > When cpu_of(rq) is not equal to smp_processor_id(), dbs_update_util_handler
> > will use irq_work_queue to smp_processor_id(), not cpu_of(rq). Is this
> > expected?
> > Or should the irq_work be queued to cpu_of(rq)?
>
> Okay, sorry for the long weekend where I couldn't get time to reply at all.

No worries. :-)

> First of all, lets try to understand dvfs_possible_from_any_cpu.
>
> Who can update the frequency of a CPU ? For many architectures/platforms the
> eventual code that writes to some register to change the frequency should only
> run on the local CPU, as these registers are per-cpu registers and not something
> shared between CPUs.
>
> But for the ARM architecture, we have a PLL and then some more registers to play
> with the clk provided to the CPU blocks and these registers (which are updated
> as a result of clk_set_rate()) are part of a block outside of the CPU blocks.
> And so any CPU (even if it is not part of the same cpufreq policy) can update
> it. Setting this flag allows that and eventually we may end up updating the
> frequency sooner, instead of later (which may be less effective). That was the
> idea of the remote-wakeup series. This stuff is absolutely correct and so
> cpufreq-dt does it for everyone.
>
> This also means that the normal work and irq-work both can run on any CPU for
> your platform and it should be okay to do that.

And it the failing case all of the CPUs in the system are in the same
policy anyway, so dvfs_possible_from_any_cpu is a red herring.

> Now, we have necessary measures in place to make sure that after stopping and
> before starting a governor, the scheduler hooks to save the cpufreq governor
> pointer and updates to policy->cpus are made properly, to make sure that we
> never ever schedule a work or irq-work on a CPU which is offline. Now it looks
> like this isn't working as expected and we need to find what exactly is broken
> here.
>
> And yes, I did the testing on Hikey 620, an octa-core ARM platform which has a
> single cpufreq policy which has all the 8 CPUs. And yes, I am using cpufreq-dt
> only and I wasn't able to reproduce the problem with mainline kernel as I
> explained earlier.
>
> The problem is somewhere between the scheduler's governor hook running or
> queuing work on a CPU which is in the middle of getting offline/online and there
> is some race around that. The problem hence may not be related to just cpufreq,
> but a wider variety of clients.

The problem is that a CPU is running a governor hook which it
shouldn't be running at all.

The observation that dvfs_possible_from_any_cpu makes a difference
only means that the governor hook is running on a CPU that is not
present in the policy->cpus mask.  On the platform(s) in question this
cannot happen as long as RCU works as expected.
