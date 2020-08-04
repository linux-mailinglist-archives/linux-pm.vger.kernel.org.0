Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E374523B5FD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 09:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHDHsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 03:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgHDHsC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 03:48:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB172086A;
        Tue,  4 Aug 2020 07:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596527281;
        bh=pS1WPK1i6yro2DLNjCjUZpZoNv0ByMmOkSSvxn+6F1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QR3Hg6B44CqSd0jBaGgC7l8EdzRxprSXs/tZkN+GLYXwGA0QXuHoiQay1oVd7+7iT
         Qgog646pCVwry06e6Eb2tN1DdP9YaEKOTWpKbMGJiWdIrXaTABImI5q4i9tSZK1hUj
         LGHwlw5aKnCqbsvuj9AeANPuw29rbzUcZwlOm7Rs=
Date:   Tue, 4 Aug 2020 09:47:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
Subject: Re: [PATCH v3] Provide USF for the portable equipment.
Message-ID: <20200804074741.GA1761483@kroah.com>
References: <cover.1596464894.git.yangdongdong@xiaomi.com>
 <20200804054728.ojudxu5fmd54lar5@vireshk-mac-ubuntu>
 <CADhdXfri8L6763ifBFMtP-cFSOuXO4isXhxZ4qF6M4vE=eeEjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADhdXfri8L6763ifBFMtP-cFSOuXO4isXhxZ4qF6M4vE=eeEjA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Aug 04, 2020 at 03:34:25PM +0800, Dongdong Yang wrote:
> Appreciate Viresh for your help. I thought Peter's NAK was only for the
> initial version. I am going to upload the verified version 4. Could you
> please kindly help to further review?
> 
> 1. Motivation
> =============
> 
> The power consumption and UI response are more cared for by the portable
> equipment users.

That's not true, everyone cares about this.

> USF(User Sensitive Feedback factor) auxiliary cpufreq
> governor
> is providing more utils adjustment settings to the high level by scenario
> identification.

Odd line-wrapping :(

And what do you mean by "more utils adjustment settings to the high
level by scenario identification"?  I can not parse that at all.

> 2. Introduction
> ===============
> 
> The USF auxiliary scheduling is based on FrameBuffer and schdeutil cpufreq
> governor to adjust utils by the identificated scenario from User Space.

What is "adjust utils"?

And why is "User Space" in caps?

> It is for portable equipment which "screen off" status stands for no request
> from the user, however, the kernel is still expected to notify the user for
> UI in
> time on modem, network or powerkey events occur. In order to save power, the
> sysfs inode nonux is provided to set the utils down level on userspace
> tasks.

Having custom sysfs apis is almost never a good idea.  Do other cpufreq
governers do this?

> In addition, the portable equipment users usually heavily interact with
> devices
> by touch, and other peripherals. On "screen on" status, The boost preemptive
> counts are marking the load requirement urgent, vice versa. USF provides up
> and
> down sysfs inodes to adjust utils according to such feedback factor and the
> level setting from the user space identified scenario.
> 
> adjust_task_pred_set is as the switch to enable or disable the adjustment.
> If no USF sysfs inodes is set and no screen on or off event be received,
> adjust_task_pred_demand shall not be executed.
> 
> 3. System wide settings
> =======================
> 
> sched_usf_non_ux_r:
>         The ratio of utils is cut down on screen off. The default value is
> 0,

The line-wrapping makes it almost impossible to read here, can you fix
that up?

>         which no util be adjusted on sugov calculating utils to select

"sugov"?

> cpufreq.
>         Its range is [-100 , 0]. If its value falls into [-50, 0), the half
> of
>         utils, which calculates cpufreq, shall be  cut down. If its value
> falls
>         into [-100, -50), only a quarter of utils be left to continue to
>         calculates cpufreq.
>         It is expected to be set [-100, 0) once enter into the identificated
>         scenario, such as listen to music on screen off, and recover to 0 on
>         out of the scenario, such as screen on.

sysfs files are "one value per file", please do not parse such complex
things in the kernel.

> 
> sched_usf_up_l0_r:
>         The ratio of utils is boosted up on screen on. The default value is
> 0,
>         which no util be adjusted on sugov calculates utils to select
> cpufreq.
>         Its range is [0 , 100]. If its value falls into (0, 50], a quarter
> of
>         extra utils, which calculates cpufreq, shall be added. If its value
>         falls into (50, 100], the half of extra utils be added to continue
> to
>         calculates cpufreq.
>         It is expected to be set (0, 100] once enter into the identificated
>         scenario, such as browsing videolet on screen on, and recover to 0
> on
>         out of the scenario, such as screen off or videolet into background.
> 
> sched_usf_down_r:
>         The ratio of utils is cut down on screen on. The default value is 0,
>         which no util be adjusted on sugov calculating utils to select
> cpufreq.
>         Its range is [-100 , 0]. If its value falls into [-50, 0), the half
> of
>         utils, which calculates cpufreq, shall be  cut down. If its value
> falls
>         into [-100, -50), only a quarter of utils be left to continue to
>         calculates cpufreq.
>         It is expected to be set [-100, 0) once enter into the identificated
>         scenario, such as browsing videolet on screen on, and recover to 0
> on
>         out of the scenario, such as screen off or vidolet into background.

Why can't all of these work automatically?  Why do you need userspace
interaction here?

thanks,

greg k-h
