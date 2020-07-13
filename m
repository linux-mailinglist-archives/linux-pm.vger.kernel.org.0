Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740B121D359
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 12:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgGMKDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 06:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGMKDQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jul 2020 06:03:16 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0D020773;
        Mon, 13 Jul 2020 10:03:13 +0000 (UTC)
Date:   Mon, 13 Jul 2020 11:03:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
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
Message-ID: <20200713100310.GA15829@gaia>
References: <20200712165917.9168-1-valentin.schneider@arm.com>
 <20200712165917.9168-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712165917.9168-4-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jul 12, 2020 at 05:59:17PM +0100, Valentin Schneider wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 66dc41fd49f2..96d478fb7a2e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -100,6 +100,7 @@ config ARM64
>  	select FRAME_POINTER
>  	select GENERIC_ALLOCATOR
>  	select GENERIC_ARCH_TOPOLOGY
> +	select SCHED_THERMAL_PRESSURE
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_CLOCKEVENTS_BROADCAST
>  	select GENERIC_CPU_AUTOPROBE

We tend to keep these in alphabetical order. Otherwise,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
