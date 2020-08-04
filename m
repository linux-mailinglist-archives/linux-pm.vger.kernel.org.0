Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3023B8FC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgHDKni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 06:43:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbgHDKni (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 06:43:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0389E1FB;
        Tue,  4 Aug 2020 03:43:37 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6B7B3F718;
        Tue,  4 Aug 2020 03:43:34 -0700 (PDT)
Date:   Tue, 4 Aug 2020 11:43:32 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-pm@vger.kernel.org,
        yangdongdong@xiaomi.com, yanziily@xiaomi.com,
        rocking@linux.alibaba.com
Subject: Re: [PATCH v4] sched: Provide USF for the portable equipment.
Message-ID: <20200804104331.6vphb2iclwz3buig@e107158-lin.cambridge.arm.com>
References: <cover.1596526941.git.yangdongdong@xiaomi.com>
 <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dongdong

On 08/04/20 15:50, Dongdong Yang wrote:
> +What:		/sys/devices/system/cpu/sched_usf
> +		/sys/devices/system/cpu/sched_usf/sched_usf_non_ux_r
> +		/sys/devices/system/cpu/sched_usf/sched_usf_up_l0_r
> +		/sys/devices/system/cpu/sched_usf/sched_usf_down_r
> +Date:		Aug 2020
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	User Sensitive Feedback factor auxiliary scheduling which
> +		is providing more utils adjustment settings to the high level
> +		by scenario identification.
> +		sched_usf_non_ux_r:
> +			The ratio of utils is cut down on screen off. The
> +			default value is 0, which no util is adjusted on sugov
> +			calculating utils to select cpufreq. Its range is
> +			[-100 , 0]. If its value falls into [-50, 0), the half
> +			of utils, which	calculates cpufreq, shall be  cut down.
> +			If its value falls into [-100, -50), only a quarter of
> +			utils are left to continue to calculate cpufreq.
> +			It is expected to be set [-100, 0) once enter into the
> +			identificated scenario, such as listen to music on
> +			screen off, and recover to 0 on out of the scenario,
> +			such as	screen on.
> +
> +		sched_usf_up_l0_r:
> +			The ratio of utils is boost up on screen on. The
> +			default value is 0, which no util is adjusted on sugov
> +			calculates utils to select cpufreq. Its range is [0 , 100].
> +			If its value falls into (0, 50], a quarter of extra utils,
> +			which calculate cpufreq, shall be added. If its value
> +			falls into (50, 100], the half of extra utils are added
> +			to continue to	calculate cpufreq.
> +			It is expected to be set (0, 100] once enter into the
> +			identificated scenario, such as browsing videolet on
> +			screen on, and recover to 0 on out of the scenario,
> +			such as screen off or videolet into background.
> +
> +		sched_usf_down_r:
> +			The ratio of utils is cut down on screen on. The
> +			default	value is 0, which no util is adjusted on sugov
> +			calculating utils to select cpufreq. Its range is
> +			[-100 , 0]. If its value falls into [-50, 0), the half
> +			of utils, which	calculate cpufreq, shall be  cut down.
> +			If its value falls into [-100, -50), only a quarter of
> +			utils are left to continue to calculate cpufreq.
> +			It is expected to be set [-100, 0) once enter into the
> +			identificated scenario, such as browsing videolet on
> +			screen on, and recover to 0 on	out of the scenario,
> +			such as screen off or vidolet into background.

AFACS you're duplicating util clamp functionality here. You can already use
util clamp to boost tasks on screen on, and cap them on screen off. And extra
brownie points; you can already use that on android 4.19 and 5.4 kernels (I'm
assuming the battery device is android based, sorry).

Any reason why util clamp isn't giving you what you want?

To cap the system on screen off you need to

	# Don't allow the util to go above 512
	echo  512 > /proc/sys/kernel/sched_util_clamp_min
	echo  512 > /proc/sys/kernel/sched_util_clamp_max

To boost the system on screen on, you need first to lift the capping done above


	# Allow util to use the full range again
	echo  1024 > /proc/sys/kernel/sched_util_clamp_min
	echo  1024 > /proc/sys/kernel/sched_util_clamp_max

	# This is pseudo C code
	for_each_important_task(p) {

		/*
		 * boost the task utilization to start from 512.
		 */
		sched_attr attr = {
			.util_min = 512,
			.util_max = 1024
		};
		sched_setattr(p, attr);
	}

	/* undo boosting once system has settled down */
	for_each_important_task(p) {

		/*
		 * reset util_min back to 0, or whatever value you want.
		 */
		sched_attr attr = {
			.util_min = 0,
			.util_max = 1024
		};
		sched_setattr(p, attr);
	}

There's a cgroup API for util clamp too.

Thanks

--
Qais Yousef
