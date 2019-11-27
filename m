Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2110AF48
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 13:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfK0MIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 07:08:21 -0500
Received: from foss.arm.com ([217.140.110.172]:46892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfK0MIV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 07:08:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2325530E;
        Wed, 27 Nov 2019 04:08:20 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A73C73F6C4;
        Wed, 27 Nov 2019 04:08:18 -0800 (PST)
Date:   Wed, 27 Nov 2019 12:08:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191127120816.GC29301@bogus>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127114801.23837-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 12:48:01PM +0100, Dietmar Eggemann wrote:
> Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> functions.") the core cpumask has to be modified during cpu hotplug
> operations.
>
> ("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
> [1] fixed that but revealed another issue on TC2, i.e in its cpufreq
> driver.
>
> During CPU hp stress operations on multiple CPUs, policy->related_cpus
> can be altered. This is wrong since this cpumask should contain the
> online and offline CPUs.
>
> The WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus)) in
> cpufreq_online() triggers in this case.
>
> The core cpumask can't be used to set the policy->cpus in
> ve_spc_cpufreq_init() anymore in case it is called via
> cpuhp_cpufreq_online()->cpufreq_online()->cpufreq_driver->init().
>
> An empty online() callback can be used to avoid that the init()
> driver function is called during CPU hotplug in so that
> policy->related_cpus will not be changed.
>

Unlike DT based drivers, it not easy to get the fixed cpumask unless we
add some mechanism to extract it based on clks/OPP added. I prefer
this simple solution instead.

> Implementing an online() also requires an offline() callback.
>
> Tested on TC2 with CPU hp stress test (CPU hp from multiple CPUs at
> the same time).
>
> [1]
> https://lore.kernel.org/r/20191127103353.12417-1-dietmar.eggemann@arm.com
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
