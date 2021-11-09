Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0094A44ADAB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 13:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhKIMmc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 07:42:32 -0500
Received: from foss.arm.com ([217.140.110.172]:33256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243023AbhKIMmc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 07:42:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 048BAED1;
        Tue,  9 Nov 2021 04:39:46 -0800 (PST)
Received: from [10.57.26.224] (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A95CE3F7F5;
        Tue,  9 Nov 2021 04:39:42 -0800 (PST)
Subject: Re: [PATCH 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2160a0b8-59ec-03a1-1fd5-a3f98085be07@arm.com>
Date:   Tue, 9 Nov 2021 12:39:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ricardo,


On 11/6/21 1:33 AM, Ricardo Neri wrote:
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Add a new netlink event to notify change in CPU capabilities in terms of
> performance and efficiency.

Is this going to be handled by some 'generic' tools? If yes, maybe
the values for 'performance' might be aligned with capacity
[0,1024] ? Or are they completely not related so the mapping is
simply impossible?

> 
> Firmware may change CPU capabilities as a result of thermal events in the
> system or to account for changes in the TDP (thermal design power) level.
> 
> This notification type will allow user space to avoid running workloads
> on certain CPUs or proactively adjust power limits to avoid future events.
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/thermal/thermal_netlink.c | 52 +++++++++++++++++++++++++++++++
>   drivers/thermal/thermal_netlink.h | 13 ++++++++
>   include/uapi/linux/thermal.h      |  6 +++-
>   3 files changed, 70 insertions(+), 1 deletion(-)

[snip]

>   
> +struct cpu_capability {
> +	int cpu;
> +	int perf;
> +	int eff;

Why not use the full names, instead of thse shortcuts? We use full
naming e.g. in cpufreq framework such as 'frequency' not 'freq'.
The 'eff' is really not meaningful ('perf' a bit less but it has
to meanings in kernel).

Regards,
Lukasz
