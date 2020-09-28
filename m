Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE127AD53
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 13:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI1Lzy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 07:55:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgI1Lzy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Sep 2020 07:55:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F71231B;
        Mon, 28 Sep 2020 04:55:53 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F3EE3F6CF;
        Mon, 28 Sep 2020 04:55:51 -0700 (PDT)
Subject: Re: [PATCH 3/3] arm64: rebuild sched domains on invariance status
 changes
To:     Quentin Perret <qperret@google.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
 <20200924123937.20938-4-ionela.voinescu@arm.com>
 <20200924133925.GC3920949@google.com> <20200924161002.GC17927@arm.com>
 <20200925135900.GA11648@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <626062da-1d0e-3095-dd6f-f909a60a7de3@arm.com>
Date:   Mon, 28 Sep 2020 13:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925135900.GA11648@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/09/2020 15:59, Quentin Perret wrote:
> Hey Ionela,
> 
> On Thursday 24 Sep 2020 at 17:10:02 (+0100), Ionela Voinescu wrote:
>> I'm not sure what is a good way of fixing this.. I could add more info
>> to the warning to suggest it might be temporary ("Disabling EAS:
>> frequency-invariant load tracking currently not supported"). For further
>> debugging there are the additional prints guarded by sched_debug().
>>
>> I'll look over the code some more to see if other ideas pop out. Any
>> suggestions are appreciated.
> 
> Right, I'm not seeing anything perfect here, but I think I'd be
> personally happy with this message being entirely guarded by
> sched_debug(), like we do for asym CPU capacities for instance.
> 
> It's not easy to see if EAS has started at all w/o sched debug anyway,
> so I expect folks who need it to enable the debug stuff during
> bring-up. With a descriptive enough warn message, that should be just
> fine. But that's my 2p, so I'm happy to hear if others disagree.

Are you discussing a scenario where the system doesn't have FI via
CPUfreq but only via AMU? And then we would get the pr_warn

 "rd %*pbl: Disabling EAS: frequency-invariant load tracking not
 supported"

in (1)-(3)?

(1) initial sd build
(2) update_topology_flags_workfn()
(3) rebuild_sched_domains_energy()
(4) init_amu_fie()

Today (e.g. on Juno( we start EAS within (1)

root@juno:~# dmesg | grep "build_perf_domains\|EAS"
[    3.491304] *** build_perf_domains: rd 0-5
[    3.574226] sched_energy_set: starting EAS <--- !!!
[    3.847584] *** build_perf_domains: rd 0-5
[    3.928227] *** build_perf_domains: rd 0-5

And on a future AMU FI only system it would look like:

 Disabling EAS: frequency-invariant load tracking not supported"
 Disabling EAS: frequency-invariant load tracking not supported"
 Disabling EAS: frequency-invariant load tracking not supported"
 sched_energy_set: starting EAS

I guess it's a good idea to put all those warnings which indicate why
EAS can't be started under sched_debug().

The warning "rd %*pbl: CPUs do not have asymmetric capacities" already
is. This one is actually very similar to the FI related one, since
'asymmetric capacities' could only exist starting with (2) (big.LITTLE
based entirely on CPUfreq diffs)
