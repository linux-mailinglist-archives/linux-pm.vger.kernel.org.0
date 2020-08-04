Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5323BD5B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHDPlx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHDPlq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 11:41:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BF8C06174A;
        Tue,  4 Aug 2020 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=4HYOsiWuipXA9W4Av6msL0bg5EM4ZU//zWeqQbSSb4Y=; b=AjZY9OLE4ER6XFJ2LVIu7XnO8R
        x/MYxLmAhfurUe1u0rvS4b04CnTUXL/Bo8iCnghvFmgeg1saQ3q1aOKmqfzE3/qgJnVV3Y5avqAod
        lCNKowcjrhCg//YQvJxo/84zGJdiuF6goSnR2lqUDLlgi4unVpeeHwE8bwvZLTdHzYTHVIRradfmz
        WVr7MZ+gpANvhDltZd8un/D1I0DeqhsXNaUk6mG0xRFjx4LEuVp3rzSzvkBVidFuxxbwlZ8uftgG8
        r1CaBHAgqUttriiMtjiV2LomrsJ3kV8NtaJJwV1S8TLpAtlo6HcAA7/LWp8df3gTMVMWRkSE1kPOS
        1W2jPmGw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2z4H-0000fW-5v; Tue, 04 Aug 2020 15:41:34 +0000
Subject: Re: [PATCH v4] sched: Provide USF for the portable equipment.
To:     Dongdong Yang <contribute.kernel@gmail.com>,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
References: <cover.1596526941.git.yangdongdong@xiaomi.com>
 <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2a35c303-6c28-cc16-3f12-3d7b25ff4dfc@infradead.org>
Date:   Tue, 4 Aug 2020 08:41:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/4/20 12:50 AM, Dongdong Yang wrote:
> From: Dongdong Yang <yangdongdong@xiaomi.com>
> 
> ---
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index b555df8..e299418 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -614,3 +614,51 @@ Description:	SPURR ticks for cpuX when it was idle.
>  
>  		This sysfs interface exposes the number of SPURR ticks
>  		for cpuX when it was idle.
> +
> +What:		/sys/devices/system/cpu/sched_usf
> +		/sys/devices/system/cpu/sched_usf/sched_usf_non_ux_r
> +		/sys/devices/system/cpu/sched_usf/sched_usf_up_l0_r
> +		/sys/devices/system/cpu/sched_usf/sched_usf_down_r
> +Date:		Aug 2020
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	User Sensitive Feedback factor auxiliary scheduling which
> +		is providing more utils adjustment settings to the high level
> +		by scenario identification.

what is "utils"?

> +		sched_usf_non_ux_r:
> +			The ratio of utils is cut down on screen off. The

same question.

> +			default value is 0, which no util is adjusted on sugov

what is "sugov"?

> +			calculating utils to select cpufreq. Its range is
> +			[-100 , 0]. If its value falls into [-50, 0), the half
> +			of utils, which	calculates cpufreq, shall be  cut down.
> +			If its value falls into [-100, -50), only a quarter of
> +			utils are left to continue to calculate cpufreq.
> +			It is expected to be set [-100, 0) once enter into the
> +			identificated scenario, such as listen to music on

			^^^^^^^^^^^^^ not a word.


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

what is "videolet"?

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


-- 
~Randy

