Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651C4278295
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 10:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgIYIVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 04:21:18 -0400
Received: from foss.arm.com ([217.140.110.172]:38510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgIYIVR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 04:21:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 794371045;
        Fri, 25 Sep 2020 01:21:16 -0700 (PDT)
Received: from [10.57.53.72] (unknown [10.57.53.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3FED3F718;
        Fri, 25 Sep 2020 01:21:14 -0700 (PDT)
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
References: <cover.1600238586.git.viresh.kumar@linaro.org>
 <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6f794935-a5d2-0f4d-70d7-de4705ba9511@arm.com>
Date:   Fri, 25 Sep 2020 09:21:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/16/20 7:45 AM, Viresh Kumar wrote:
> In order to prepare for lock-less stats update, add support to defer any
> updates to it until cpufreq_stats_record_transition() is called.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
>   1 file changed, 56 insertions(+), 19 deletions(-)
> 

[snip]

> @@ -228,10 +264,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
>   	struct cpufreq_stats *stats = policy->stats;
>   	int old_index, new_index;
>   
> -	if (!stats) {
> -		pr_debug("%s: No stats found\n", __func__);
> +	if (!stats)
>   		return;
> -	}
> +
> +	if (READ_ONCE(stats->reset_pending))
> +		cpufreq_stats_reset_table(stats);
>   

This is in the hot path code, called from the scheduler. I wonder if we
avoid it or make that branch 'unlikely'?

if (unlikely(READ_ONCE(stats->reset_pending)))

Probably the CPU (when it has good prefetcher) would realize about it,
but maybe we can help a bit here.

