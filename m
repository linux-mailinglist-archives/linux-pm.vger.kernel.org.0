Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8393B3A9C0A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 15:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhFPNfS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 09:35:18 -0400
Received: from foss.arm.com ([217.140.110.172]:37476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFPNfS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 09:35:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F400F31B;
        Wed, 16 Jun 2021 06:33:11 -0700 (PDT)
Received: from [10.57.9.31] (unknown [10.57.9.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 790243F719;
        Wed, 16 Jun 2021 06:33:08 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Add allowed CPU capacity knowledge to EAS
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        dietmar.eggemann@arm.com, vincent.donnefort@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com, thara.gopinath@linaro.org,
        amit.kachhap@gmail.com, amitk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org
References: <20210614185815.15136-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9e8a2c92-161d-e1f3-efd9-ac0fa4d62fd5@arm.com>
Date:   Wed, 16 Jun 2021 14:33:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210614185815.15136-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,


On 6/14/21 7:58 PM, Lukasz Luba wrote:
> Hi all,
> 
> The patch set v4 aims to add knowledge about reduced CPU capacity
> into the Energy Model (EM) and Energy Aware Scheduler (EAS). Currently the
> issue is that SchedUtil CPU frequency and EM frequency are not aligned,
> when there is a CPU thermal capping. This causes an estimation error.
> This patch set provides the information about allowed CPU capacity
> into the EM (thanks to thermal pressure information). This improves the
> energy estimation. More info about this mechanism can be found in the
> patches description.
> 
> Changelog:
> v4:
> - removed local variable and improved description in patch 2/3
> - added Reviewed-by from Vincent for patch 2/3
> - added Acked-by from Viresh for patch 1/3
> v3 [3]:
> - switched to 'raw' per-cpu thermal pressure instead of thermal pressure
>    geometric series signal, since it more suited for purpose of
>    this use case: predicting SchedUtil frequency (Vincent, Dietmar)
> - added more comment in the patch 2/3 header for use case when thermal
>    capping might be applied even the CPUs are not over-utilized
>    (Dietmar)
> - added ACK tag from Rafael for SchedUtil part
> - added a fix patch for offline CPUs in cpufreq_cooling and per-cpu
>    thermal_pressure missing update
> v2 [2]:
> - clamp the returned value from effective_cpu_util() and avoid irq
>    util scaling issues (Quentin)
> v1 is available at [1]
> 
> Regards,
> Lukasz
> 
> [1] https://lore.kernel.org/linux-pm/20210602135609.10867-1-lukasz.luba@arm.com/
> [2] https://lore.kernel.org/lkml/20210604080954.13915-1-lukasz.luba@arm.com/
> [3] https://lore.kernel.org/lkml/20210610150324.22919-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (3):
>    thermal: cpufreq_cooling: Update also offline CPUs per-cpu
>      thermal_pressure
>    sched/fair: Take thermal pressure into account while estimating energy
>    sched/cpufreq: Consider reduced CPU capacity in energy calculation
> 
>   drivers/thermal/cpufreq_cooling.c |  2 +-
>   include/linux/energy_model.h      | 16 +++++++++++++---
>   include/linux/sched/cpufreq.h     |  2 +-
>   kernel/sched/cpufreq_schedutil.c  |  1 +
>   kernel/sched/fair.c               | 13 +++++++++----
>   5 files changed, 25 insertions(+), 9 deletions(-)
> 

Could you take these 3 patches via your tree, please?
I'm asking you because the fair.c has most changes
(apart from energy_model.h) and the patches got
ACKs from Rafael and Viresh. The patch which touches
fair.c got Reviewed-by Vincent Guittot. I have address
all the comment, thus, IMHO it could fly now.

Please let me know if you like me to re-base on top
of some of your branches.

Regards,
Lukasz
