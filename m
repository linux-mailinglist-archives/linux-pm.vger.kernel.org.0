Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49BA3A6A5D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 17:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhFNPb6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 11:31:58 -0400
Received: from foss.arm.com ([217.140.110.172]:38876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233859AbhFNPb2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Jun 2021 11:31:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 655CB1FB;
        Mon, 14 Jun 2021 08:29:25 -0700 (PDT)
Received: from [10.57.5.127] (unknown [10.57.5.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA6043F70D;
        Mon, 14 Jun 2021 08:29:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] sched/fair: Take thermal pressure into account
 while estimating energy
To:     vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        qperret@google.com, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, Beata.Michalska@arm.com,
        mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        segall@google.com, mgorman@suse.de, bristot@redhat.com,
        thara.gopinath@linaro.org, amit.kachhap@gmail.com,
        amitk@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
References: <20210610150324.22919-1-lukasz.luba@arm.com>
 <20210610150324.22919-3-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <81d7bd73-a61a-5501-f8ec-77e195355013@arm.com>
Date:   Mon, 14 Jun 2021 16:29:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210610150324.22919-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vincent,

Gentle ping. Could you have a look at this implementation, please?


On 6/10/21 4:03 PM, Lukasz Luba wrote:

[snip]

> @@ -6527,8 +6527,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>   	struct cpumask *pd_mask = perf_domain_span(pd);
>   	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>   	unsigned long max_util = 0, sum_util = 0;
> +	unsigned long _cpu_cap, thermal_pressure;
>   	int cpu;
>   
> +	thermal_pressure = arch_scale_thermal_pressure(cpumask_first(pd_mask));
> +	_cpu_cap = cpu_cap - thermal_pressure;

I've done the implementation according to your suggestion. That should
provide the consistent usage.

Regards,
Lukasz
