Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804823FCB57
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbhHaQSx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 12:18:53 -0400
Received: from foss.arm.com ([217.140.110.172]:56302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239733AbhHaQSw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 12:18:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E7C16D;
        Tue, 31 Aug 2021 09:17:57 -0700 (PDT)
Received: from [10.57.20.161] (unknown [10.57.20.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01583F766;
        Tue, 31 Aug 2021 09:17:54 -0700 (PDT)
Subject: Re: [PATCH V3 9/9] cpufreq: scmi: Use .register_em() to register with
 energy model
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Quentin Perret <qperret@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1628742634.git.viresh.kumar@linaro.org>
 <8158488baa1ea1aebd09c8d256db7420051d05ac.1628742634.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d454df8e-9adb-ea97-727e-f182e95707ef@arm.com>
Date:   Tue, 31 Aug 2021 17:17:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8158488baa1ea1aebd09c8d256db7420051d05ac.1628742634.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

My apologies for delay I was on holidays. I've seen the pull requests,
so it's too late, but just for history...

I have tested this new callback with hacked juno FW which works in
the per-cpu perf requests. There are no issues.

Some debug prints:

[    3.110072] cpu cpu0: cpumask weight(opp_shared_cpus)=4 weight 
policy->cpus=1
[    3.117666] cpu cpu0: Empty OPP table
[    3.121418] cpu cpu0: OPP table empty
[    3.131367] cpu cpu0: EM: created perf domain
[    3.137848] cpu cpu1: cpumask weight(opp_shared_cpus)=2 weight 
policy->cpus=1
[    3.145220] cpu cpu1: Empty OPP table
[    3.148961] cpu cpu1: OPP table empty
[    3.158193] cpu cpu1: EM: created perf domain
[    3.164325] cpu cpu2: cpumask weight(opp_shared_cpus)=2 weight 
policy->cpus=1
[    3.173430] cpu cpu3: cpumask weight(opp_shared_cpus)=4 weight 
policy->cpus=1
[    3.181947] cpu cpu4: cpumask weight(opp_shared_cpus)=4 weight 
policy->cpus=1
[    3.190620] cpu cpu5: cpumask weight(opp_shared_cpus)=4 weight 
policy->cpus=1

root@sqwt-ubuntu:~# grep . /sys/kernel/debug/energy_model/cpu0/ps\:*/*
/sys/kernel/debug/energy_model/cpu0/ps:450000/cost:79
/sys/kernel/debug/energy_model/cpu0/ps:450000/frequency:450000
/sys/kernel/debug/energy_model/cpu0/ps:450000/power:42
/sys/kernel/debug/energy_model/cpu0/ps:575000/cost:85
/sys/kernel/debug/energy_model/cpu0/ps:575000/frequency:575000
/sys/kernel/debug/energy_model/cpu0/ps:575000/power:58
/sys/kernel/debug/energy_model/cpu0/ps:700000/cost:95
/sys/kernel/debug/energy_model/cpu0/ps:700000/frequency:700000
/sys/kernel/debug/energy_model/cpu0/ps:700000/power:79
/sys/kernel/debug/energy_model/cpu0/ps:775000/cost:106
/sys/kernel/debug/energy_model/cpu0/ps:775000/frequency:775000
/sys/kernel/debug/energy_model/cpu0/ps:775000/power:97
/sys/kernel/debug/energy_model/cpu0/ps:850000/cost:119
/sys/kernel/debug/energy_model/cpu0/ps:850000/frequency:850000
/sys/kernel/debug/energy_model/cpu0/ps:850000/power:119
root@sqwt-ubuntu:~# cat /sys/kernel/debug/energy_model/cpu0/cpus
0,3-5
root@sqwt-ubuntu:~# cat /sys/kernel/debug/energy_model/cpu1/cpus
1-2
root@sqwt-ubuntu:~# grep . /sys/kernel/debug/energy_model/cpu1/ps\:*/*
/sys/kernel/debug/energy_model/cpu1/ps:1100000/cost:583
/sys/kernel/debug/energy_model/cpu1/ps:1100000/frequency:1100000
/sys/kernel/debug/energy_model/cpu1/ps:1100000/power:583
/sys/kernel/debug/energy_model/cpu1/ps:450000/cost:391
/sys/kernel/debug/energy_model/cpu1/ps:450000/frequency:450000
/sys/kernel/debug/energy_model/cpu1/ps:450000/power:160
/sys/kernel/debug/energy_model/cpu1/ps:625000/cost:420
/sys/kernel/debug/energy_model/cpu1/ps:625000/frequency:625000
/sys/kernel/debug/energy_model/cpu1/ps:625000/power:239
/sys/kernel/debug/energy_model/cpu1/ps:800000/cost:471
/sys/kernel/debug/energy_model/cpu1/ps:800000/frequency:800000
/sys/kernel/debug/energy_model/cpu1/ps:800000/power:343
/sys/kernel/debug/energy_model/cpu1/ps:950000/cost:525
/sys/kernel/debug/energy_model/cpu1/ps:950000/frequency:950000
/sys/kernel/debug/energy_model/cpu1/ps:950000/power:454
root@sqwt-ubuntu:~#

Regards,
Lukasz
