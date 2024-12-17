Return-Path: <linux-pm+bounces-19365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976779F47B6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6026F163F62
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260FC1DE8B0;
	Tue, 17 Dec 2024 09:38:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8FF1D5AA5;
	Tue, 17 Dec 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428315; cv=none; b=IZAczVf55TsPJvnQTKqnAmvccwknoad8YbtbR881bK/1cdAne3VwN8cRhEKydK+qi8QkyhnKhbUP+qvUUeEn8+EoodH7INo4+ZL7E1gwjkbbgRmJLhMJBKlf84tZYJckqvANGoqWQhBTKA/0N+CWfibRm3lN10Zx5klHiVS2VCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428315; c=relaxed/simple;
	bh=bdqTMj31J0d19foueIwWZpipzFk7mkkYFLZuSeLOUHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fajt7T76uxckFZ9GhrLZrMy0vMze+0Kl4Um5Yue48MoPIE/pX10wSI79ZTjifJ3GjcIZQrGR8wVgVnpOqtlYrR9RtSv1Jfyzn6UZQ28Q9Bkm/5Zj6r0taaLigZFqDRqTR5OxWHgG6sG+PUtFxs3oZp0v/X9pDm6Xgk/eZZu3jZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C37B1007;
	Tue, 17 Dec 2024 01:38:59 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BCCA3F720;
	Tue, 17 Dec 2024 01:38:29 -0800 (PST)
Message-ID: <31c86834-273b-458f-9914-eff76c283cfb@arm.com>
Date: Tue, 17 Dec 2024 10:38:28 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v021 5/9] PM: EM: Introduce
 em_dev_expand_perf_domain()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>
References: <5861970.DvuYhMxLoT@rjwysocki.net>
 <3353401.44csPzL39Z@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <3353401.44csPzL39Z@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2024 17:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a helper function for adding a CPU to an existing EM perf
> domain.
> 
> Subsequently, this will be used by the intel_pstate driver to add new
> CPUs to existing perf domains when those CPUs go online for the first
> time after the initialization of the driver.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v0.1 -> v0.2: No changes

Could you add information why this new EM interface is needed?

IIRC, you can't use the existing way (cpufreq_driver::register_em) since
it gets called to early (3) for the PD cpumasks to be ready. This issue
will be there for any system in which uarch domains are not congruent
with clock domains which we hadn't have to deal with Arm's heterogeneous
CPUs so far.

__init intel_pstate_init()

  intel_pstate_register_driver()

    cpufreq_register_driver()

      subsys_interface_register()

        sif->add_dev() -> cpufreq_add_dev()

          cpufreq_online()

            if (!new_policy && cpufreq_driver->online)

            else

              cpufreq_driver->init() -> intel_pstate_cpu_init()

                __intel_pstate_cpu_init()

                  intel_pstate_init_cpu()

                    intel_pstate_get_cpu_pstates()

                      hybrid_add_to_domain()

                        em_dev_expand_perf_domain()              <-- (1)

                  intel_pstate_init_acpi_perf_limits()

                    intel_pstate_set_itmt_prio()                 <-- (2)

            if (new_policy)

              cpufreq_driver->register_em()                      <-- (3)

    hybrid_init_cpu_capacity_scaling()

      hybrid_refresh_cpu_capacity_scaling()

        __hybrid_refresh_cpu_capacity_scaling()                  <-- (4)

        hybrid_register_all_perf_domains()

          hybrid_register_perf_domain()	

            em_dev_register_perf_domain()                        <-- (5)

      /* Enable EAS */
      sched_clear_itmt_support()                                 <-- (6)

Debugging this on a 'nosmt' i7-13700K (online mask =
[0,2,4,6,8,10,12,14,16-23]

(1) Add CPU to existing hybrid PD or create new hybrid PD.
(2) Triggers sched domain rebuild (+ enabling EAS) already here during
    startup ?
    IMHO, reason is that max_highest_perf > min_highest_perf because of
    different itmt prio
    Happens for CPU8 on my machine (after CPU8 is added to hybrid PD
    0,2,4,6,8) (itmt prio for CPU8=69 (1024) instead of 68 (1009)).
    So it looks like EAS is enabled before (6) ?	
(3) ARM's way to do (5)
(4) Setting hybrid_max_perf_cpu
(5) Register EM here
(6) Actual call to initially triggers sched domain rebuild (+ enable
    EAS) (done already in (2) on my machine)

So (3) is not possible for Intel hybrid since the policy's cpumask(s)
contain only one CPUs, i.e. CPUs are not sharing clock.
And those cpumasks have to be build under (1) to be used in (5)?

[...]

