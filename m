Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF81A75CE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436572AbgDNIWX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 04:22:23 -0400
Received: from foss.arm.com ([217.140.110.172]:50778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436548AbgDNIWB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Apr 2020 04:22:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82AE91FB;
        Tue, 14 Apr 2020 01:21:57 -0700 (PDT)
Received: from bogus (unknown [10.37.12.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 539AC3F73D;
        Tue, 14 Apr 2020 01:21:48 -0700 (PDT)
Date:   Tue, 14 Apr 2020 09:21:36 +0100
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
        Mike Rapoport <rppt@linux.ibm.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, oprofile-list@lists.sf.net,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/11] MIPS: setup: Drop prefill_possible_map
Message-ID: <20200414082123.GA6459@bogus>
References: <20200412032123.3896114-1-jiaxun.yang@flygoat.com>
 <20200412032123.3896114-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412032123.3896114-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 12, 2020 at 11:20:31AM +0800, Jiaxun Yang wrote:
> All the plat_smp_setup are setting up possible cpus in their
> platform code. So prefill_possible_map is actually overwriting
> platform's setup, which seems unreasonable.
> 

Why don't you rearrange the code so that this still remains as is and
the platforms can override if they need. If you do so, you don't need
the change in 04/11 as I suggested previously.

-- 
Regards,
Sudeep
