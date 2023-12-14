Return-Path: <linux-pm+bounces-1138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD8E812B83
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 10:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F058D28270B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB52E3EC;
	Thu, 14 Dec 2023 09:20:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B373EA6;
	Thu, 14 Dec 2023 01:20:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEA7DC15;
	Thu, 14 Dec 2023 01:20:58 -0800 (PST)
Received: from [10.57.85.242] (unknown [10.57.85.242])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14D53F762;
	Thu, 14 Dec 2023 01:20:08 -0800 (PST)
Message-ID: <af7b67d1-c4a3-44e3-a632-5f0a4ea6eb25@arm.com>
Date: Thu, 14 Dec 2023 09:21:11 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org,
 mhiramat@kernel.org, rui.zhang@intel.com, vschneid@redhat.com,
 bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
 juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, agross@kernel.org,
 konrad.dybcio@linaro.org, andersson@kernel.org, viresh.kumar@linaro.org,
 sudeep.holla@arm.com, rafael@kernel.org, rostedt@goodmis.org,
 mgorman@suse.de, amit.kachhap@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231212142730.998913-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 14:27, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 48 +++++++++++++++++++++++++++++++++++++++
>   include/linux/cpufreq.h   | 10 ++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..7d5f71be8d29 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2563,6 +2563,50 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
>   }
>   EXPORT_SYMBOL(cpufreq_get_policy);
>   
> +DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
> +EXPORT_PER_CPU_SYMBOL_GPL(cpufreq_pressure);

Why do we export this variable when we have get/update functions?
Do we expect modules would manipulate those per-cpu variables
independently and not like we do per-cpumask in the update func.?

