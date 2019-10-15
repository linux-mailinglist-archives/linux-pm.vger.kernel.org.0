Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4CD82F4
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbfJOVuk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 17:50:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39445 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfJOVuk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 17:50:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so18223540oia.6;
        Tue, 15 Oct 2019 14:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Rbg3GlsCZMY2PYzwlKYN6U3Hys/GlUE/N1CGmM1+mk=;
        b=umRVsOqGggFxreCANJTaxO9NJm0LhK+1fTpp6xV7MRdjr9plnVt8m2pyzAVU2miLeM
         MsjOJ65fKkLLKXIKoC0KBVc0DpB7Zn5tbEKKY93I7xzxc2tweH41kohYFNCdQ0ONfwIk
         p+WQWkvgMyYbVXVl+5N/Jef9IyBirAdVKCNPW3tsM/sowMKu2aqM4aNQjZCG1gS2mTLG
         jGhrT31h94uqvb2VaDj/ldThsciGboA0H74tDhwG0Eb5XLV3Wxy+EbJfDu/GVSzE7RkZ
         vfWQd2b2/qogVQNPUILIjiQMs1GDCZjNnBFvZmwC21NDWQhFVoSlRMrEsrDzA1T0B6UJ
         Gm2w==
X-Gm-Message-State: APjAAAWoLUwkdIcu10lUGxX7nUitNshDCTawhOdiV2OdnafYEC8ko+qa
        JHHdHdiIF1g5raWRybQxZrQn2EbyBu8vvLae9fAggDcm
X-Google-Smtp-Source: APXvYqwSdEONq2xTT80HSQuU+UMOReflhaKoGASTVXaLwjVs7H5aEpsz5B6O64BQDIT2HvPpOWEtr8ZZKM6ngr86wl8=
X-Received: by 2002:aca:d405:: with SMTP id l5mr582341oig.115.1571176238841;
 Tue, 15 Oct 2019 14:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
 <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
 <a1c503a7-6136-a405-369c-596a680183f2@gmail.com> <20191015114637.pcdbs2ctxl4xoxdo@vireshk-i7>
 <CAJZ5v0g3kRfa2WXy=xz3Mj15Pwb5tm1xg=uPODoifnv70O1ORA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g3kRfa2WXy=xz3Mj15Pwb5tm1xg=uPODoifnv70O1ORA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Oct 2019 23:50:27 +0200
Message-ID: <CAJZ5v0hxsy3ZKFvtWULHAVog4=3rYQfd3-61A9dNaKeUbiDtrg@mail.gmail.com>
Subject: Re: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 15, 2019 at 5:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 15, 2019 at 1:46 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 22-09-19, 23:12, Dmitry Osipenko wrote:
> > > Hello Viresh,
> > >
> > > This patch causes use-after-free on a cpufreq driver module reload. Please take a look, thanks in advance.
> > >
> > >
> > > [   87.952369] ==================================================================
> > > [   87.953259] BUG: KASAN: use-after-free in notifier_chain_register+0x4f/0x9c
> > > [   87.954031] Read of size 4 at addr e6abbd0c by task modprobe/243
> > >
> > > [   87.954901] CPU: 1 PID: 243 Comm: modprobe Tainted: G        W
> > > 5.3.0-next-20190920-00185-gf61698eab956-dirty #2408
> > > [   87.956077] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> > > [   87.956807] [<c0110aad>] (unwind_backtrace) from [<c010bb71>] (show_stack+0x11/0x14)
> > > [   87.957709] [<c010bb71>] (show_stack) from [<c0d37b25>] (dump_stack+0x89/0x98)
> > > [   87.958616] [<c0d37b25>] (dump_stack) from [<c02937e1>]
> > > (print_address_description.constprop.0+0x3d/0x340)
> > > [   87.959785] [<c02937e1>] (print_address_description.constprop.0) from [<c0293c6b>]
> > > (__kasan_report+0xe3/0x12c)
> > > [   87.960907] [<c0293c6b>] (__kasan_report) from [<c014988f>] (notifier_chain_register+0x4f/0x9c)
> > > [   87.962001] [<c014988f>] (notifier_chain_register) from [<c01499b5>]
> > > (blocking_notifier_chain_register+0x29/0x3c)
> > > [   87.963180] [<c01499b5>] (blocking_notifier_chain_register) from [<c06f7ee9>]
> > > (dev_pm_qos_add_notifier+0x79/0xf8)
> > > [   87.964339] [<c06f7ee9>] (dev_pm_qos_add_notifier) from [<c092927d>] (cpufreq_online+0x5e1/0x8a4)
> > > [   87.965351] [<c092927d>] (cpufreq_online) from [<c09295c9>] (cpufreq_add_dev+0x79/0x80)
> > > [   87.966247] [<c09295c9>] (cpufreq_add_dev) from [<c06eb9d3>] (subsys_interface_register+0xc3/0x100)
> > > [   87.967297] [<c06eb9d3>] (subsys_interface_register) from [<c0926e53>]
> > > (cpufreq_register_driver+0x13b/0x1ec)
> > > [   87.968476] [<c0926e53>] (cpufreq_register_driver) from [<bf800435>]
> > > (tegra20_cpufreq_probe+0x165/0x1a8 [tegra20_cpufreq])
> >
> > Hi Dmitry,
> >
> > Thanks for the bug report and I was finally able to reproduce it at my end and
> > this was quite an interesting debugging exercise :)
> >
> > When a cpufreq driver gets registered, we register with the subsys interface and
> > it calls cpufreq_add_dev() for each CPU, starting from CPU0. And so the QoS
> > notifiers get added to the first CPU of the policy, i.e. CPU0 in common cases.
> >
> > When the cpufreq driver gets unregistered, we unregister with the subsys
> > interface and it calls cpufreq_remove_dev() for each CPU, starting from CPU0
> > (should have been in reverse order I feel). We remove the QoS notifier only when
> > cpufreq_remove_dev() gets called for the last CPU of the policy, lets call it
> > CPUx. Now this has a different notifier list as compared to CPU0.
>
> The same problem will appear if the original policy CPU goes offline, won't it?
>
> > In short, we are adding the cpufreq notifiers to CPU0 and removing them from
> > CPUx. When we try to add it again by inserting the module for second time, we
> > find a node in the notifier list which is already freed but still in the list as
> > we removed it from CPUx's list (which doesn't do anything as the node wasn't
> > there in the first place).
> >
> > @Rafael: How do you see we solve this problem ? Here are the options I could
> > think of:
> >
> > - Update subsys layer to reverse the order of devices while unregistering (this
> >   will fix the current problem, but we will still have corner cases hanging
> >   around, like if the CPU0 is hotplugged out, etc).
>
> This isn't sufficient for the offline case.
>
> > - Update QoS framework with the knowledge of related CPUs, this has been pending
> >   until now from my side. And this is the thing we really need to do. Eventually
> >   we shall have only a single notifier list for all CPUs of a policy, at least
> >   for MIN/MAX frequencies.
>
> - Move the PM QoS requests and notifiers to the new policy CPU on all
> changes of that.  That is, when cpufreq_offline() nominates the new
> "leader", all of the QoS stuff for the policy needs to go to this one.

Alas, that still will not work, because things like
acpi_processor_ppc_init() only work accidentally for one-CPU policies.
Generally, adding such a PM QoS request to a non-policy CPU simply has
no effect until it becomes a policy CPU which may be never.

It looks like using device PM QoS for cpufreq is a mistake in general
and what is needed is a struct pm_qos_constraints member in struct
cpufreq_policy and something like

struct freq_pm_qos_request {
        enum freq_pm_qos_req_type type; /* min or max */
        struct plist_node pnode;
        struct cpufreq_policy *policy;
};

Then, pm_qos_update_target() can be used for adding, updating and
removing requests.
