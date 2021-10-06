Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DCE42397B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbhJFIOc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 04:14:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34798 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhJFIO3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 04:14:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 149F02032D;
        Wed,  6 Oct 2021 08:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633507957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cuANoZC0eqWWyXV1GnZy30IOwWR5zjD4YHS7ED13eOE=;
        b=fbkrXjHS3lyiYaHLQ95vnpPoKK88wfegZJLo3O61T7CLJySgm74cw7Ujy2WH+cylpUqlhL
        1JYwYXkixmgcxce1DlGcG1dvzuZ/xnWoKv/4EDoTl2tiZY7uIszPlRKCcekwGYtRMhNFmW
        pQ3uC2Gh2r7FaZc1VhtcE7s/zOMVMZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633507957;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cuANoZC0eqWWyXV1GnZy30IOwWR5zjD4YHS7ED13eOE=;
        b=0jQNEYKHjYB7LjbeAJpWAXSte1FsLyHSj+dJJYI+WnLUZssT8zaIt+M9gJVB48AKShaTAf
        EUsAmX4x+sWjpcDg==
Received: from ggherdovich.udp.ovpn2.nue.suse.de (ggherdovich.udp.ovpn2.nue.suse.de [10.163.44.102])
        by relay2.suse.de (Postfix) with ESMTP id 5CE22A3B8F;
        Wed,  6 Oct 2021 08:12:36 +0000 (UTC)
Message-ID: <3ec0387f2ecf0121eb59c054e2633afa2503ef6b.camel@suse.cz>
Subject: Re: [PATCH v2 08/21] cpufreq: amd: add trace for amd-pstate module
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Wed, 06 Oct 2021 10:12:33 +0200
In-Reply-To: <20210926090605.3556134-9-ray.huang@amd.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
         <20210926090605.3556134-9-ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2021-09-26 at 17:05 +0800, Huang Rui wrote:
> Add trace event to monitor the performance value changes which is
> controlled by cpu governors.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/Makefile           |  6 +-
>  drivers/cpufreq/amd-pstate-trace.c |  2 +
>  drivers/cpufreq/amd-pstate-trace.h | 96 ++++++++++++++++++++++++++++++
>  drivers/cpufreq/amd-pstate.c       | 11 ++++
>  4 files changed, 114 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpufreq/amd-pstate-trace.c
>  create mode 100644 drivers/cpufreq/amd-pstate-trace.h
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 5c9a2a1ee8dc..04882bc4b145 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -17,6 +17,10 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
>  obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
>  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
>  
> +# Traces
> +CFLAGS_amd-pstate-trace.o               := -I$(src)
> +amd_pstate-y				:= amd-pstate.o amd-pstate-trace.o
> +
>  ##################################################################################
>  # x86 drivers.
>  # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
> @@ -25,7 +29,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
>  # speedstep-* is preferred over p4-clockmod.
>  
>  obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
> -obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
> +obj-$(CONFIG_X86_AMD_PSTATE)		+= amd_pstate.o
>  obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
>  obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
>  obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
> diff --git a/drivers/cpufreq/amd-pstate-trace.c b/drivers/cpufreq/amd-pstate-trace.c
> new file mode 100644
> index 000000000000..891b696dcd69
> --- /dev/null
> +++ b/drivers/cpufreq/amd-pstate-trace.c
> @@ -0,0 +1,2 @@
> +#define CREATE_TRACE_POINTS
> +#include "amd-pstate-trace.h"
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> new file mode 100644
> index 000000000000..50c85e150f30
> --- /dev/null
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * amd-pstate-trace.h - AMD Processor P-state Frequency Driver Tracer
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
> + *
> + * Author: Huang Rui <ray.huang@amd.com>
> + */
> +
> +#if !defined(_AMD_PSTATE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _AMD_PSTATE_TRACE_H
> +
> +#include <linux/cpufreq.h>
> +#include <linux/tracepoint.h>
> +#include <linux/trace_events.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM amd_cpu

Hello Ray,

I'd prefer if TRACE_SYSTEM was set to "power". In that way the tracepoint is easier
to find, since it'd be together with other power-related tracepoints. I often do

    perf list | grep "power:"

to find all that's available, or equivalently

    ls $TRACEFS/events/power/

and if your tracepoint is somewhere else, I wouldn't find it.

> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE amd-pstate-trace
> +
> +#define TPS(x)  tracepoint_string(x)
> +
> +TRACE_EVENT(amd_pstate_perf,
> +
> +	TP_PROTO(unsigned long min_perf,
> +		 unsigned long target_perf,
> +		 unsigned long capacity,
> +		 unsigned int cpu_id,
> +		 u64 prev,
> +		 u64 value,
> +		 int type
> +		 ),
> +
> +	TP_ARGS(min_perf,
> +		target_perf,
> +		capacity,
> +		cpu_id,
> +		prev,
> +		value,
> +		type
> +		),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, min_perf)
> +		__field(unsigned long, target_perf)
> +		__field(unsigned long, capacity)
> +		__field(unsigned int, cpu_id)
> +		__field(u64, prev)
> +		__field(u64, value)
> +		__field(int, type)
> +		),
> +
> +	TP_fast_assign(
> +		__entry->min_perf = min_perf;
> +		__entry->target_perf = target_perf;
> +		__entry->capacity = capacity;
> +		__entry->cpu_id = cpu_id;
> +		__entry->prev = prev;
> +		__entry->value = value;
> +		__entry->type = type;
> +		),
> +
> +	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u prev=0x%llx value=0x%llx type=0x%d",
> +		  (unsigned long)__entry->min_perf,
> +		  (unsigned long)__entry->target_perf,
> +		  (unsigned long)__entry->capacity,
> +		  (unsigned int)__entry->cpu_id,
> +		  (u64)__entry->prev,
> +		  (u64)__entry->value,
> +		  (int)__entry->type
> +		 )
> +);
> +
> +#endif /* _AMD_PSTATE_TRACE_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#include <trace/define_trace.h>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c9bee7b1698a..0c9f9c0c8928 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -45,10 +45,17 @@
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
>  #include <asm/cpu_device_id.h>
> +#include "amd-pstate-trace.h"
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
>  #define AMD_PSTATE_TRANSITION_DELAY	500
>  
> +enum switch_type
> +{
> +	AMD_TARGET = 0,
> +	AMD_ADJUST_PERF
> +};
> +
>  static struct cpufreq_driver amd_pstate_driver;
>  
>  struct amd_cpudata {
> @@ -183,6 +190,7 @@ amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  {
>  	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>  	u64 value = prev;
> +	enum switch_type type = fast_switch ? AMD_ADJUST_PERF : AMD_TARGET;
>  
>  	value &= ~REQ_MIN_PERF(~0L);
>  	value |= REQ_MIN_PERF(min_perf);
> @@ -193,6 +201,9 @@ amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	value &= ~REQ_MAX_PERF(~0L);
>  	value |= REQ_MAX_PERF(max_perf);
>  
> +	trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> +			      cpudata->cpu, prev, value, type);

Two things here:

1. the field "value" seems redundant, as you're already showing me {min,des,max}_perf.
   Maybe you can remove "value" from the output of the trace?
   One reason I can think why you're showing me "value", is to let me see if it's the
   same as "prev", in which case I'd know the request isn't passed to the hardware.
   Is that so? If that's the reason, maybe it would be clear to remove "value", "prev"
   and just show a field like "changed={true,false}".

2. the field "type" is a little obscure for someone reading the trace. It can be
   0 or 1, and to know what that means one has to read the code. I would suggest
   replacing it with a field "fast_switch={true,false}", which is more telling.
   What do you think?


Giovanni

