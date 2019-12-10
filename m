Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D31181CF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 09:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfLJIMr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Dec 2019 03:12:47 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43803 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJIMr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 03:12:47 -0500
Received: by mail-oi1-f174.google.com with SMTP id x14so8974191oic.10
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2019 00:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2+fQz0JsHOsDH7WuR/rPcWqaDrkJVs6bnh0aUj0SRxs=;
        b=ZwlWBLd0C/hg/YR7eVuk5NJ8/Yl2yOdSp+8RPyiXcR9OYZTj/F71DE3W6qH8zS84+G
         l+q3UyGZ5zlOsYJAl3Vh/AzelMtwQt7cWMAzBNMEDsyD/7PnMtGiJoax8SEJVzU+I+fN
         6qp7dRCgRerbOJukYanAAQR7yyAr2HuV/zMAJyBul6w2fGScQSeJzGupmQmqIhGPmVzJ
         6GnRq6NeNyPfUYb07PWXIEegh72/1PZYJ3ZQ2VAvMvkCur/cj7EUbiBD/98Qwux/T3L2
         SEvc0fKrEZf21X4ytKND41VIohjc7OUMzTq3+vYv+IJxObXymkiGRFp0VecW2cKJ2Zvw
         Ud0A==
X-Gm-Message-State: APjAAAVGxv52E4NIb/LLozuxRq4r/tosiDeS4I/LF3F/5XJIsaVpQdLg
        rnvv0mPP+XzmdUFDQz+uItKI/9UScMDPu5E9QH30xw==
X-Google-Smtp-Source: APXvYqxBEPlYdpKrAVH0WDKQOhuAx3QmPEBlNadnOs/Edeb7mL9kqEumfRWvDKJYQF0Bv+7V1akW+1vmZAhxNLuIL/M=
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr3000626oij.110.1575965566084;
 Tue, 10 Dec 2019 00:12:46 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <4087016.QifdzW7851@kreacher> <DB3PR0402MB39163BEC18FF81B06D1093BBF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j_op4vELkEQzJEuXij71p8SGSFSbo0m813W5Gq1ZdYoQ@mail.gmail.com>
 <DB3PR0402MB3916D581AFCA8D05BBED3B68F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916EF749069E53CB1C03475F5580@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0j+L_w7G=Z4K5tuWEp11uk3ggS-1c8RqQ-Px6mk1V98Pw@mail.gmail.com>
 <0EF688DF-FD00-456C-8CE1-C4F825651275@nxp.com> <CAJZ5v0iKpJBs71EKL42nL4F0EFaxvbZziwUz73WS45uDYKEpdA@mail.gmail.com>
 <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481518A4F89540B3ABA56A1885B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Dec 2019 09:12:33 +0100
Message-ID: <CAJZ5v0h0934-VBODZZJ8gEG2byuhQ+bomoCuTmmQZOBtqu5bKQ@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 10, 2019 at 6:53 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
> >
> > On Mon, Dec 9, 2019 at 1:32 PM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > >
> > >
> > >
> > > From Anson's iPhone 6
> > >
> > >
> > > > 在 2019年12月9日，19:23，Rafael J. Wysocki <rafael@kernel.org> 写
> > 道：
> > > >
> > > >> On Mon, Dec 9, 2019 at 11:57 AM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > > >>
> > > >> Forgot to mentioned that below patch on v5.4 can easily reproduce the
> > panic() on our platforms which I think is unexpected, as the policy->cpus
> > already be updated after governor stop, but still try to have irq work queued
> > on it.
> > > >>
> > > >> static void dbs_update_util_handler(struct update_util_data *data,
> > > >> u64 time, unsigned int flags)
> > > >> +       if (!cpumask_test_cpu(smp_processor_id(),
> > policy_dbs->policy->cpus))
> > > >> +               panic("...irq work on offline cpu %d\n",
> > > >> + smp_processor_id());
> > > >>        irq_work_queue(&policy_dbs->irq_work);
> > > >
> > > > Yes, that is unexpected.
> > > >
> > > > In cpufreq_offline(), we have:
> > > >
> > > >    down_write(&policy->rwsem);
> > > >    if (has_target())
> > > >        cpufreq_stop_governor(policy);
> > > >
> > > >    cpumask_clear_cpu(cpu, policy->cpus);
> > > >
> > > > and cpufreq_stop_governor() calls policy->governor->stop(policy)
> > > > which is cpufreq_dbs_governor_stop().
> > > >
> > > > That calls gov_clear_update_util(policy_dbs->policy) first, which
> > > > invokes cpufreq_remove_update_util_hook() for each CPU in
> > > > policy->cpus and synchronizes RCU, so after that point none of the
> > > > policy->cpus is expected to run dbs_update_util_handler().
> > > >
> > > > policy->cpus is updated next and the governor is started again with
> > > > the new policy->cpus.  Because the offline CPU is not there, it is
> > > > not expected to run dbs_update_util_handler() again.
> > > >
> > > > Do you only get the original error when one of the CPUs goes back online?
> > >
> > > No, sometimes I also got this error during a CPU is being offline.
> > >
> > > But the point is NOT that dbs_update_util_handler() called during
> > > governor stop, it is that this function is running on a CPU which
> > > already finish the governor stop function,
> >
> > Yes, it is, and which should not be possible as per the above.
> >
> > The offline CPU is not there in prolicy->cpus when
> > cpufreq_dbs_governor_start() is called for the policy, so its
> > cpufreq_update_util_data pointer is not set (it is NULL at that time).
> > Therefore it is not expected to run dbs_update_util_handler() until it is turn
> > back online.
> >
> > > I thought the original expectation is that this function ONLY be executed on
> > the CPU which needs scaling frequency?
> > > Is this correct?
> >
> > Yes, it is.
> >
> > > v4.19 follows this expectation while v5.4 is NOT.
> >
> > As per the kernel code, they both do.
>
> But per https://elixir.bootlin.com/linux/v5.5-rc1/source/kernel/sched/sched.h#L2293
> cpu_of(rq) and smp_processor_id() is possible to not the same,
>
> When cpu_of(rq) is not equal to smp_processor_id(), dbs_update_util_handler
> will use irq_work_queue to smp_processor_id(), not cpu_of(rq). Is this
> expected?

Yes, it is, in general.
