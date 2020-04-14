Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1651A7806
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438099AbgDNKDm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 06:03:42 -0400
Received: from foss.arm.com ([217.140.110.172]:52300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438097AbgDNKDl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 06:03:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ED3031B;
        Tue, 14 Apr 2020 03:03:40 -0700 (PDT)
Received: from bogus (unknown [10.37.12.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 896E43F6C4;
        Tue, 14 Apr 2020 03:03:31 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:03:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, dietmar.eggemann@arm.com,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zhou Yanjie <zhouyanjie@zoho.com>,
        =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, YunQiang Su <syq@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steve Winslow <swinslow@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Xu <peterx@redhat.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] arch_topology: Reset all cpus in
 reset_cpu_topology
Message-ID: <20200414100324.GA17835@bogus>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
 <20200412032123.3896114-5-jiaxun.yang@flygoat.com>
 <20200414082734.GC6459@bogus>
 <20200414163514.00000100@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414163514.00000100@flygoat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 14, 2020 at 04:35:14PM +0800, Jiaxun Yang wrote:
> On Tue, 14 Apr 2020 09:27:34 +0100
> Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> > On Sun, Apr 12, 2020 at 11:20:34AM +0800, Jiaxun Yang wrote:
> > > For MIPS platform, when topology isn't probed by DeviceTree,
> > > possible_cpu might be empty when calling init_cpu_topology,
> > > that may result cpu_topology not fully reseted for all CPUs.
> > > So here we can reset all cpus instead of possible cpus.
> > >
> >
> > As I have told before adjust and make it default before this function
> > gets called.
>
> Hi,
>
> That's really impossible under current MIPS code structure.
>

I really doubt that, but I have no knowledge on MIPS port, so I would
let maintainers take that call.

> Another option would be prefill possible_cpu with all_cpu_mask before
> calling topology_init, but that would make the code unnecessarily
> complex.
>

I still prefer that. By the time we call this function on a config
with say NR_CPUS=1024, we would have parsed DT and set nr_cpus to say 8
or 16 just for sake of example, so if platforms can't figure the
possible CPUs, let them set it to NR_CPUs so that not all platforms
have to run through that loop.

> Here simply reset the whole array won't cause any regression.
>

Not necessary, please discuss and check if some simplification to MIPS
can be done rather than patching here and there to make it work.

--
Regards,
Sudeep
