Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E7221D3C4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 12:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgGMK3u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 06:29:50 -0400
Received: from foss.arm.com ([217.140.110.172]:53228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbgGMK3t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jul 2020 06:29:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 503A131B;
        Mon, 13 Jul 2020 03:29:49 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DD313F7D8;
        Mon, 13 Jul 2020 03:29:47 -0700 (PDT)
References: <20200712165917.9168-1-valentin.schneider@arm.com> <20200712165917.9168-4-valentin.schneider@arm.com> <20200713100310.GA15829@gaia>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 3/3] arm, arm64: Select CONFIG_SCHED_THERMAL_PRESSURE
In-reply-to: <20200713100310.GA15829@gaia>
Date:   Mon, 13 Jul 2020 11:29:31 +0100
Message-ID: <jhjlfjnlnck.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 13/07/20 11:03, Catalin Marinas wrote:
> On Sun, Jul 12, 2020 at 05:59:17PM +0100, Valentin Schneider wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 66dc41fd49f2..96d478fb7a2e 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -100,6 +100,7 @@ config ARM64
>>      select FRAME_POINTER
>>      select GENERIC_ALLOCATOR
>>      select GENERIC_ARCH_TOPOLOGY
>> +	select SCHED_THERMAL_PRESSURE
>>      select GENERIC_CLOCKEVENTS
>>      select GENERIC_CLOCKEVENTS_BROADCAST
>>      select GENERIC_CPU_AUTOPROBE
>
> We tend to keep these in alphabetical order. Otherwise,
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks! Will reorder that in v3.
