Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CB32DC762
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 20:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgLPTuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 14:50:51 -0500
Received: from foss.arm.com ([217.140.110.172]:43854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbgLPTuv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Dec 2020 14:50:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05EEB31B;
        Wed, 16 Dec 2020 11:50:05 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921BB3F66E;
        Wed, 16 Dec 2020 11:50:04 -0800 (PST)
Date:   Wed, 16 Dec 2020 19:50:03 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 0/2] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20201216195003.GA21585@arm.com>
References: <cover.1608030508.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608030508.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tuesday 15 Dec 2020 at 16:46:34 (+0530), Viresh Kumar wrote:
> Hello,
> 
> CPPC cpufreq driver is used for ARM servers and this patch series tries
> to provide frequency invariance support for them.
> 

Nitpick: cppc_cpufreq already supports cpufreq-based frequency
invariance, but not counter-based frequency invariance, when lacking
AMUs :).

> This is tested with some hacks, as I didn't have access to the right
> hardware, on the ARM64 hikey board to check the overall functionality
> and that works fine.
> 
> Ionela/Peter Puhov, it would be nice if you guys can give this a shot.
> 

I'll be on holiday starting tomorrow until January. I fully intend to
review and test this but I'll have to set myself a deadline for January
to do it.

Sorry for the delay,
Ionela.

> This is based of pm/linux-next and patches [1] and [2] which I sent
> recently to cleanup arm64 topology stuff.
> 
> Changes since V1:
> - The interface for setting the callbacks is improved, so different
>   parts looking to provide their callbacks don't need to think about
>   each other.
> 
> - Moved to per-cpu storage for storing the callback related data, AMU
>   counters have higher priority with this.
> 
> --
> viresh
> 
> [1] https://lore.kernel.org/lkml/7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org/
> [2] https://lore.kernel.org/lkml/5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org/
> 
> Viresh Kumar (2):
>   topology: Allow multiple entities to provide sched_freq_tick()
>     callback
>   cpufreq: cppc: Add support for frequency invariance
> 
>  arch/arm64/include/asm/topology.h |   8 +-
>  arch/arm64/kernel/topology.c      |  89 +++++++++----------
>  drivers/base/arch_topology.c      |  56 +++++++++++-
>  drivers/cpufreq/cppc_cpufreq.c    | 140 +++++++++++++++++++++++++++++-
>  include/linux/arch_topology.h     |  14 ++-
>  kernel/sched/core.c               |   1 +
>  6 files changed, 244 insertions(+), 64 deletions(-)
> 
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
