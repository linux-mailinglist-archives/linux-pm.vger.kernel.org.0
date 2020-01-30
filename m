Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC114DA19
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 12:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgA3LrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 06:47:21 -0500
Received: from foss.arm.com ([217.140.110.172]:51500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgA3LrV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Jan 2020 06:47:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B77EB328;
        Thu, 30 Jan 2020 03:47:20 -0800 (PST)
Received: from [10.37.12.72] (unknown [10.37.12.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1978D3F68E;
        Thu, 30 Jan 2020 03:47:18 -0800 (PST)
Subject: Re: [PATCH 0/1] drivers: devfreq: use DELAYED_WORK in DEVFREQ
 monitoring subsystem
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com
References: <20200127151731.8640-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b4d1624f-4ca8-c985-ff42-f5f677c72fa9@arm.com>
Date:   Thu, 30 Jan 2020 11:47:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200127151731.8640-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo, MyungJoo,

Gentle ping. The issue is not only in the devfreq itself,
but also it affects thermal. The devfreq cooling rely on
busy_time and total_time updated by the devfreq monitoring
(in simple_ondemand).
Thermal uses DELAYED_WORK and is more reliable, but uses stale
data from devfreq_dev_stats. It is especially visible when
you have cgroup spanning one cluster. Android uses cgroups
heavily. You can make easily this setup using 'taskset',
run some benchmarks and observe 'devfreq_monitor' traces and
timestamps, i.e. for your exynos-bus.

The patch is really non-invasive and simple. It can be a good starting
point for testing and proposing other solutions.

Regards,
Lukasz

On 1/27/20 3:17 PM, lukasz.luba@arm.com wrote:
> From: Lukasz Luba <lukasz.luba@arm.com>
> 
> Hi all,
> 
> This patch is a continuation of my previous work for fixing DEVFREQ monitoring
> subsystem [1]. The issue is around DEFERRABLE_WORK, which uses TIMER_DEFERRABLE
> under the hood which will work normally when the system is busy, but will not
> cause a CPU to come out of idle and serve the DEVFREQ monitoring requests.
> 
> This is especially important in the SMP systems with many CPUs, when the load
> balance tries to keep some CPUs idle. The next service request could not be
> triggered when the CPU went idle in the meantime.
> 
> The DELAYED_WORK is going to be triggered even on an idle CPU. This will allow
> to call the DEVFREQ monitoring in reliable intervals. Some of the drivers might
> use internal counters to monitor their load, when the DEVFREQ work is not
> triggered in a predictable way, these counters might overflow leaving the
> device in undefined state.
> 
> To observe the difference, the trace output might be used, i.e.
> 
> echo 1 > /sys/kernel/debug/tracing/events/devfreq/enable
> #your test starts here, i.e. 'sleep 5' or 'dd ' or 'gfxbench'
> echo 0 > /sys/kernel/debug/tracing/events/devfreq/enable
> cat /sys/kernel/debug/tracing/trace
> 
> When there are some registered devfreq drivers, you should see the traces
> 'devfreq_moniotor' triggered in reliable intervals.
> 
> The patch set is based on Chanwoo's devfreq repository and branch
> 'devfreq-next' [2].
> 
> Regards,
> Lukasz Luba
> 
> [1] https://lkml.org/lkml/2019/2/12/1179
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-next
> 
> 
> Lukasz Luba (1):
>    drivers: devfreq: add DELAYED_WORK to monitoring subsystem
> 
>   drivers/devfreq/Kconfig   | 19 +++++++++++++++++++
>   drivers/devfreq/devfreq.c |  6 +++++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
