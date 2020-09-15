Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6956526A2AB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOKEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 06:04:30 -0400
Received: from foss.arm.com ([217.140.110.172]:59676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIOKE3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Sep 2020 06:04:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA3D1396;
        Tue, 15 Sep 2020 03:04:29 -0700 (PDT)
Received: from [10.37.12.52] (unknown [10.37.12.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D2DB3F68F;
        Tue, 15 Sep 2020 03:04:27 -0700 (PDT)
Subject: Re: [PATCH 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
References: <cover.1599031227.git.viresh.kumar@linaro.org>
 <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <bd6e6d93-7491-0971-3bed-27d1885c38cd@arm.com>
Date:   Tue, 15 Sep 2020 11:04:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 9/2/20 8:24 AM, Viresh Kumar wrote:
> In order to prepare for lock-less stats update, add support to defer any
> updates to it until cpufreq_stats_record_transition() is called.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
>   1 file changed, 56 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 94d959a8e954..fdf9e8556a49 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -22,17 +22,22 @@ struct cpufreq_stats {

Would it be possible to move this structure in the
linux/cpufreq.h header? Any subsystem could have access to it,
like to the cpuidle stats.

Apart from that (and the comment regarding the 'atomic_t' field)
I don't see any issues.

Regards,
Lukasz
