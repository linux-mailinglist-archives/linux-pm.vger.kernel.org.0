Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC12215716
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 14:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgGFMO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 08:14:59 -0400
Received: from foss.arm.com ([217.140.110.172]:34636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgGFMO6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Jul 2020 08:14:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0EF1FB;
        Mon,  6 Jul 2020 05:14:57 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3E973F68F;
        Mon,  6 Jul 2020 05:14:48 -0700 (PDT)
Subject: Re: [PATCH 1/8] cpufreq: allow drivers to flag custom support for
 freq invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-2-ionela.voinescu@arm.com>
 <20200701094417.ffuvduz6pqknjcks@vireshk-i7> <20200701133330.GA32736@arm.com>
 <CAJZ5v0gT+xWwxcx3OZjXBnDLr9i4VOt2Vp3ScWBxbu+NiopkbA@mail.gmail.com>
 <20200702025818.s4oh7rzz3tr6zwqr@vireshk-i7> <20200702114425.GB28120@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <389dd87f-fed0-e4ea-81f3-5491fd2a54d1@arm.com>
Date:   Mon, 6 Jul 2020 14:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702114425.GB28120@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/07/2020 13:44, Ionela Voinescu wrote:
> Hi,
> 
> On Thursday 02 Jul 2020 at 08:28:18 (+0530), Viresh Kumar wrote:
>> On 01-07-20, 18:05, Rafael J. Wysocki wrote:
>>> On Wed, Jul 1, 2020 at 3:33 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>>>> On Wednesday 01 Jul 2020 at 16:16:17 (+0530), Viresh Kumar wrote:

[...]

>> There can be other reasons which we aren't able to imagine at this
>> point of time.
>>
> 
> But I understand both the points you and Rafael raised so it's obvious
> that a 'opt in' flag would be the better option.

Why can't we just move the arch_set_freq_scale() call from cpufreq
driver to cpufreq core w/o introducing a FIE related driver flag?

Current scenario for Frequency Invariance Engine (FIE) on arm/arm64.

+------------------------------+       +------------------------------+
|                              |       |                              |
| cpufreq core:                |       | arch: (arm, arm64)           |

|                              |       |                              |
| weak arch_set_freq_scale() {}|       |                              |
|                              |       |                              |
+------------------------------+       |                              |
                                       |                              |
+------------------------------+       |                              |
|                              |       |                              |
| cpufreq driver:              |       |                              |
|                            +-----------> arch_set_freq_scale()      |
|                              |       |   {                          |
+------------------------------+       |      if (use counters)       |
                                       |        return;               |
+------------------------------+       |      ...                     |
|                              |       |   }                          |
| task scheduler:              |       |                              |
|                            +-----------> arch_scale_freq_tick()*    |
|                              |       |   {                          |

|                              |       |      if (!use counters)      |
|                              |       |        return;               |
|                              |       |      ...                     |
|                              |       |   }                          |
+------------------------------+       +------------------------------+

* defined as topology_scale_freq_tick() in arm64

Only Arm/Arm64 defines arch_set_freq_scale() to get the 'legacy' CPUfreq
based FIE. This would still be the case when we move
arch_set_freq_scale() from individual cpufreq drivers to cpufreq core.

Arm64 is the only arch which has to runtime-choose between two different
FIEs. This is currently done by bailing out early in one of the FIE
functions based on 'use counters'.

X86 (and others) will continue to not define arch_set_freq_scale().

The issue with CONFIG_BL_SWITCHER (vexpress-spc-cpufreq.c) could be
solved arm/arm64 internally (arch_topology.c) by putting
arch_set_freq_scale() under a !CONFIG_BL_SWITCHER guard.
I doubt that there are any arm bL systems out there running it. At least
I'm not aware of any complaints due to missing FIE support in bl
switcher setups so far.
