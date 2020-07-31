Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEF12346C7
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgGaNWW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 09:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387419AbgGaNWU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 09:22:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A496E21744;
        Fri, 31 Jul 2020 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596201740;
        bh=fSZT8j8Q56S+X8wVCP0FfOqs/yNJDKaYWLtqjNf+5kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Le2hBFz8FZfk929djZVF90YdpLUaDO2LYKHKDoNNYI38z2Isfu3EXpllQ9gDpAEef
         LmIBmoHq9LxlDex2+0hsMssnIUcexmDjeTutM+V+DsxCQCdgLpAPRwosPHcj9jJPDz
         GtBwC47XzO6fXUT9A1v0EoltNY0QdDPWZpRLwkck=
Date:   Fri, 31 Jul 2020 15:22:07 +0200
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
Message-ID: <20200731132207.GB1712190@kroah.com>
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
> --- /dev/null
> +++ b/drivers/staging/fbsched/usf.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 XiaoMi Inc.
> + * Author: Yang Dongdong <yangdongdong@xiaomi.com>
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * See http://www.gnu.org/licenses/gpl-2.0.html for more details.

Please remove the license "boilerplate" text as you have the SPDX line
on top.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/kthread.h>
> +#include <linux/cpu.h>
> +#include <linux/sysfs.h>
> +#include <linux/kthread.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/kallsyms.h>
> +#include <linux/debugfs.h>
> +#include <linux/fb.h>
> +#include <linux/notifier.h>
> +
> +#define BOOST_MIN_V -100
> +#define BOOST_MAX_V 100
> +#define LEVEL_TOP 3
> +
> +#define USF_TAG	"[usf_sched]"
> +
> +DEFINE_PER_CPU(unsigned long[PID_MAX_LIMIT], task_hist_nivcsw);
> +
> +static struct {
> +	bool is_sched_usf_enabled;
> +	int enable_debug;
> +	int is_screen_on;
> +	struct kobject *kobj;

A raw kobject?  For a driver?  are you _SURE_???

> +	struct dentry *debugfs_entry;

Why do you need this?

> +	usf_vdev.enable_debug = 0;
> +	usf_vdev.debugfs_entry = debugfs_create_file("usf_dbg",
> +						     0660, NULL, NULL,
> +						     &usf_dbg_fops);
> +	if (!usf_vdev.debugfs_entry)
> +		pr_err("Failed to create usf_dbg!\n");

How can that value be NULL?

There is no need to check debugfs functions for error values.

But in this case, why are you writing a single file to the root of
debugfs?  Why not put it in a directory instead?  That would be much
nicer, don't you think?

thanks,

greg k-h
