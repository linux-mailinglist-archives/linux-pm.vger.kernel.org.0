Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91363231F5A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgG2N3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 09:29:46 -0400
Received: from foss.arm.com ([217.140.110.172]:51714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2N3q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 09:29:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A7A61FB;
        Wed, 29 Jul 2020 06:29:45 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C1903F66E;
        Wed, 29 Jul 2020 06:29:43 -0700 (PDT)
References: <20200712165917.9168-1-valentin.schneider@arm.com> <20200712165917.9168-3-valentin.schneider@arm.com> <20200727141825.GA4174@lca.pw> <16f8c1d4-778b-3ab8-f328-bae80f3973b4@arm.com> <jhjpn8fiphi.mognet@arm.com> <20200729130910.GA1075614@google.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 2/3] sched: Cleanup SCHED_THERMAL_PRESSURE kconfig entry
In-reply-to: <20200729130910.GA1075614@google.com>
Date:   Wed, 29 Jul 2020 14:29:37 +0100
Message-ID: <jhjo8nyih4u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 29/07/20 14:09, Quentin Perret wrote:
> On Tuesday 28 Jul 2020 at 17:16:57 (+0100), Valentin Schneider wrote:
>> We could change the arch Kconfig into
>>
>>   select SCHED_THERMAL_PRESSURE if CPU_FREQ_THERMAL
>>
>> but that seems redundant; this dependency is already expressed in
>> SCHED_THERMAL_PRESSURE's definition. Is there a proper pattern to select
>> some Kconfig option only if all of its dependencies are met?
>
> How about something like this (totally untested):
>
> ---8<---
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 939c4d6bbc2e..2ac74904a3ce 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -46,7 +46,6 @@ config ARM
>       select EDAC_ATOMIC_SCRUB
>       select GENERIC_ALLOCATOR
>       select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
> -	select SCHED_THERMAL_PRESSURE if ARM_CPU_TOPOLOGY
>       select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
>       select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>       select GENERIC_CPU_AUTOPROBE
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c403e6f5db86..66dc41fd49f2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -192,7 +192,6 @@ config ARM64
>       select PCI_SYSCALL if PCI
>       select POWER_RESET
>       select POWER_SUPPLY
> -	select SCHED_THERMAL_PRESSURE
>       select SPARSE_IRQ
>       select SWIOTLB
>       select SYSCTL_EXCEPTION_TRACE
> diff --git a/init/Kconfig b/init/Kconfig
> index 0a97d85568b2..c2e1f3ac527e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -493,6 +493,7 @@ config HAVE_SCHED_AVG_IRQ
>
>  config SCHED_THERMAL_PRESSURE
>       bool
> +	default y if ARM64 || ARM_CPU_TOPOLOGY
>       depends on SMP
>       depends on CPU_FREQ_THERMAL
>       help
> --->8---
>

That does seem to do just what I was looking for, thanks!

> Thanks,
> Quentin
