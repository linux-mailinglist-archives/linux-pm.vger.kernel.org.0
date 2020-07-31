Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154062346BD
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgGaNUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 09:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgGaNUX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 09:20:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B268121744;
        Fri, 31 Jul 2020 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596201623;
        bh=uoVX3bcmvsWft+k3e/OzNfmAD+L1d0+lh517DnQsT3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQybmUSH4o4yjsQH3hjYptrtzYyNBgJYZX1jxcs1DCJFYTIDjSqmDX8w0ruluIazZ
         fn3x8S8I1DnNzoLKeueMDgbXg/TnEcLc/cjvj0fvHDAxixj7CJUkSs6yJ/CKkoTvT8
         Ql+71fA47Mq1Qjz4xBg7rQPn9aT9Sbt7yry84GNU=
Date:   Fri, 31 Jul 2020 15:20:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
Subject: Re: [PATCH v2] sched: Provide USF for the portable equipment.
Message-ID: <20200731132009.GA1712190@kroah.com>
References: <cover.1596196060.git.yangdongdong@xiaomi.com>
 <e992fea6ad249694e615640862a28346936f8844.1596196062.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e992fea6ad249694e615640862a28346936f8844.1596196062.git.yangdongdong@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 31, 2020 at 08:46:30PM +0800, Dongdong Yang wrote:
>  drivers/staging/Kconfig          |   2 +
>  drivers/staging/Makefile         |   1 +
>  drivers/staging/fbsched/Kconfig  |  10 ++
>  drivers/staging/fbsched/Makefile |   2 +
>  drivers/staging/fbsched/usf.c    | 346 +++++++++++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c |   3 +
>  kernel/sched/sched.h             |  10 ++
>  7 files changed, 374 insertions(+)
>  create mode 100644 drivers/staging/fbsched/Kconfig
>  create mode 100644 drivers/staging/fbsched/Makefile
>  create mode 100644 drivers/staging/fbsched/usf.c

I asked for a TODO file, like all other staging drivers have, why did
you not include one here?

