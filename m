Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53799231AD6
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 10:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgG2IHe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 04:07:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgG2IHd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 04:07:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 383B631B;
        Wed, 29 Jul 2020 01:07:33 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BD393F71F;
        Wed, 29 Jul 2020 01:07:24 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] sched: Cleanup SCHED_THERMAL_PRESSURE kconfig
 entry
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20200712165917.9168-1-valentin.schneider@arm.com>
 <20200712165917.9168-3-valentin.schneider@arm.com>
 <20200727141825.GA4174@lca.pw> <16f8c1d4-778b-3ab8-f328-bae80f3973b4@arm.com>
 <jhjpn8fiphi.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a8f6ebb5-0a49-a806-be6d-8d68cb99b75f@arm.com>
Date:   Wed, 29 Jul 2020 10:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhjpn8fiphi.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/07/2020 18:16, Valentin Schneider wrote:
> 
> Hi,
> 
> On 27/07/20 18:45, Dietmar Eggemann wrote:
>> On 27/07/2020 16:18, Qian Cai wrote:
>>> On Sun, Jul 12, 2020 at 05:59:16PM +0100, Valentin Schneider wrote:

[...]

> I went for having SCHED_THERMAL_PRESSURE in arm64/Kconfig because of where
> the discussion went in the original thread ([1] in the changelog).
> 
> One point is that selecting this option requires having the right
> infrastructure in place (arch_{set, scale}_thermal_pressure() must be
> redefined by the architecture), which cannot be easily expressed in Kconfig
> terms. Russell's point was that this is difficult for a lambda user to make
> sense of, and Vincent argued that this option should simply be selected at
> architecture level, which, given the context, makes sense IMO.
> 
> We could change the arch Kconfig into
> 
>   select SCHED_THERMAL_PRESSURE if CPU_FREQ_THERMAL
> 
> but that seems redundant; this dependency is already expressed in
> SCHED_THERMAL_PRESSURE's definition. Is there a proper pattern to select
> some Kconfig option only if all of its dependencies are met?

The warning when disabling CPU_FREQ_THERMAL after make defconfig disappears, so
this should be OK.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 939c4d6bbc2e..a677e71b3d5f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -46,7 +46,7 @@ config ARM
        select EDAC_ATOMIC_SCRUB
        select GENERIC_ALLOCATOR
        select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
-       select SCHED_THERMAL_PRESSURE if ARM_CPU_TOPOLOGY
+       select SCHED_THERMAL_PRESSURE if ARM_CPU_TOPOLOGY && CPU_FREQ_THERMAL
        select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
        select GENERIC_CLOCKEVENTS_BROADCAST if SMP
        select GENERIC_CPU_AUTOPROBE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c403e6f5db86..59ae16f8b941 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,7 +192,7 @@ config ARM64
        select PCI_SYSCALL if PCI
        select POWER_RESET
        select POWER_SUPPLY
-       select SCHED_THERMAL_PRESSURE
+       select SCHED_THERMAL_PRESSURE if CPU_FREQ_THERMAL
        select SPARSE_IRQ
        select SWIOTLB
        select SYSCTL_EXCEPTION_TRAC
