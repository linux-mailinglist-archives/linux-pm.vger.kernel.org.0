Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3695123B63B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 10:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgHDIDb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 04:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgHDIDa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 04:03:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1ED2086A;
        Tue,  4 Aug 2020 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596528208;
        bh=8ACzz0hFyrdliBwP3ZGGsA+CzNGBjmyGPttNftbCTF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XW93tlrDHQkukpqQqtosd3vY9T/vR11YrsjrEnab6W9UAf2Wii3KNygsuK3eZAOil
         8MkSrShsDsKKYnWoi+51XYip64xk0dh6zGoHQq3hbP1SJEz6y3IiVdEyKVnZI6JXdw
         i2XEKZr1MWiGDlPegm52HTs5DWqiq9se78qWxljQ=
Date:   Tue, 4 Aug 2020 10:03:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        devel@driverdev.osuosl.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangdongdong@xiaomi.com,
        yanziily@xiaomi.com, rocking@linux.alibaba.com
Subject: Re: [PATCH v4] sched: Provide USF for the portable equipment.
Message-ID: <20200804080309.GA1764192@kroah.com>
References: <cover.1596526941.git.yangdongdong@xiaomi.com>
 <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820a185b6765d6246ac34f612faedeb35189487c.1596526941.git.yangdongdong@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 03:50:35PM +0800, Dongdong Yang wrote:

Comments on code stuff only, not if this is actually a valid thing to be
doing at all:

> --- /dev/null
> +++ b/kernel/sched/usf.c
> @@ -0,0 +1,294 @@
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

No need for the two paragraph "boiler plate" license text now that you
have a SPDX line, please remove them.

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
> +#include <linux/fb.h>
> +#include <linux/notifier.h>
> +#include <trace/events/sched.h>
> +#include "sched.h"
> +
> +#define BOOST_MIN_V -100
> +#define BOOST_MAX_V 100
> +#define LEVEL_TOP 3
> +
> +#define USF_TAG	"[usf_sched]"

Please pr_fmt instead.

> +
> +DEFINE_PER_CPU(unsigned long[PID_MAX_DEFAULT], task_hist_nivcsw);
> +
> +static struct {
> +	bool is_sched_usf_enabled;
> +	bool is_screen_on;
> +	int sysctl_sched_usf_up_l0;
> +	int sysctl_sched_usf_down;
> +	int sysctl_sched_usf_non_ux;
> +	int usf_up_l0;
> +	int usf_down;
> +	int usf_non_ux;
> +} usf_vdev;
> +
> +void adjust_task_pred_demand(int cpuid,
> +			     unsigned long *util,
> +			     struct rq *rq)
> +{
> +	/* sysctl_sched_latency/sysctl_sched_min_granularity */
> +	u32 bl_sw_num = 3;
> +
> +	if (!usf_vdev.is_sched_usf_enabled || !rq || !rq->curr ||
> +		(rq->curr->pid >= PID_MAX_DEFAULT))
> +		return;
> +
> +	if (usf_vdev.is_screen_on) {
> +		if (rq->curr->nivcsw >
> +		    (per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid]
> +		     + bl_sw_num + 1)) {
> +			(*util) += (*util) >> usf_vdev.usf_up_l0;
> +		} else if (rq->curr->nivcsw <
> +			   (per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid]
> +			    + bl_sw_num - 1) && (rq->nr_running < bl_sw_num)) {
> +			(*util) >>= usf_vdev.usf_down;
> +		}
> +		per_cpu(task_hist_nivcsw, cpuid)[rq->curr->pid] =
> +		    rq->curr->nivcsw;
> +	} else if (rq->curr->mm) {
> +		(*util) >>= usf_vdev.usf_non_ux;
> +	}
> +
> +	trace_sched_usf_adjust_utils(cpuid, usf_vdev.usf_up_l0,
> +				     usf_vdev.usf_down,
> +				     usf_vdev.usf_non_ux, *util);
> +}
> +
> +static int usf_lcd_notifier(struct notifier_block *nb,
> +			    unsigned long val, void *data)
> +{
> +	struct fb_event *evdata = data;
> +	unsigned int blank;
> +
> +	if (!evdata)
> +		return 0;
> +
> +	if (val != FB_EVENT_BLANK)
> +		return 0;
> +
> +	if (evdata->data && val == FB_EVENT_BLANK) {
> +		blank = *(int *)(evdata->data);
> +
> +		switch (blank) {
> +		case FB_BLANK_POWERDOWN:
> +			usf_vdev.is_screen_on = false;
> +			if (usf_vdev.sysctl_sched_usf_non_ux != 0)
> +				static_branch_enable(&adjust_task_pred_set);
> +			else
> +				static_branch_disable(&adjust_task_pred_set);
> +
> +			break;
> +
> +		case FB_BLANK_UNBLANK:
> +			usf_vdev.is_screen_on = true;
> +			if (usf_vdev.sysctl_sched_usf_up_l0 != 0 ||
> +			    usf_vdev.sysctl_sched_usf_down != 0)
> +				static_branch_enable(&adjust_task_pred_set);
> +			else
> +				static_branch_disable(&adjust_task_pred_set);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		usf_vdev.is_sched_usf_enabled = true;
> +		pr_info("%s : usf_vdev.is_screen_on:%b\n",
> +				     __func__, usf_vdev.is_screen_on);
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block usf_lcd_nb = {
> +	.notifier_call = usf_lcd_notifier,
> +	.priority = INT_MAX,
> +};
> +
> +static ssize_t store_sched_usf_up_l0_r(struct kobject *kobj,
> +				       struct kobj_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret = 0;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val == 0) {
> +		usf_vdev.sysctl_sched_usf_up_l0 = val;
> +		usf_vdev.usf_up_l0 = 0;
> +	} else if ((val > 0) && (val <= BOOST_MAX_V)) {
> +		usf_vdev.sysctl_sched_usf_up_l0 = val;
> +		usf_vdev.usf_up_l0 = LEVEL_TOP -
> +				DIV_ROUND_UP(val, BOOST_MAX_V / 2);
> +		ret = count;
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, 0, BOOST_MAX_V);
> +		ret = -EINVAL;
> +	}
> +	if ((usf_vdev.sysctl_sched_usf_up_l0 == 0) &&
> +	    (usf_vdev.sysctl_sched_usf_down == 0))
> +		static_branch_disable(&adjust_task_pred_set);
> +	else
> +		static_branch_enable(&adjust_task_pred_set);
> +
> +	return ret;
> +}
> +
> +static ssize_t store_sched_usf_down_r(struct kobject *kobj,
> +				      struct kobj_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret = 0;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if ((val >= BOOST_MIN_V) && (val <= 0)) {
> +		usf_vdev.sysctl_sched_usf_down = val;
> +		usf_vdev.usf_down = DIV_ROUND_UP(-val, -BOOST_MIN_V / 2);
> +		ret = count;
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, BOOST_MIN_V, 0);
> +		ret = -EINVAL;
> +	}
> +	if ((usf_vdev.sysctl_sched_usf_up_l0 == 0) &&
> +	    (usf_vdev.sysctl_sched_usf_down == 0))
> +		static_branch_disable(&adjust_task_pred_set);
> +	else
> +		static_branch_enable(&adjust_task_pred_set);
> +
> +	return ret;
> +}
> +
> +static ssize_t store_sched_usf_non_ux_r(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret = 0;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if ((val >= BOOST_MIN_V) && (val <= 0)) {
> +		usf_vdev.sysctl_sched_usf_non_ux = val;
> +		usf_vdev.usf_non_ux = DIV_ROUND_UP(-val, -BOOST_MIN_V / 2);
> +		ret = count;
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, BOOST_MIN_V, 0);
> +		ret = -EINVAL;
> +	}
> +	if (usf_vdev.sysctl_sched_usf_non_ux == 0)
> +		static_branch_disable(&adjust_task_pred_set);
> +	else
> +		static_branch_enable(&adjust_task_pred_set);
> +
> +	return ret;
> +}
> +
> +#define usf_attr_rw(_name)						\
> +static struct kobj_attribute _name =					\
> +__ATTR(_name, 0664, show_##_name, store_##_name)

__ATTR_RW()?

> +
> +#define usf_show_node(_name, _value)					\
> +static ssize_t show_##_name						\
> +(struct kobject *kobj, struct kobj_attribute *attr,  char *buf)		\
> +{									\
> +	return sprintf(buf, "%d", usf_vdev.sysctl_##_value);		\
> +}

Again do NOT use raw kobjects.

> +
> +usf_show_node(sched_usf_up_l0_r, sched_usf_up_l0);
> +usf_show_node(sched_usf_down_r, sched_usf_down);
> +usf_show_node(sched_usf_non_ux_r, sched_usf_non_ux);
> +
> +usf_attr_rw(sched_usf_up_l0_r);
> +usf_attr_rw(sched_usf_down_r);
> +usf_attr_rw(sched_usf_non_ux_r);
> +
> +static struct attribute *sched_attrs[] = {
> +	&sched_usf_up_l0_r.attr,
> +	&sched_usf_down_r.attr,
> +	&sched_usf_non_ux_r.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sched_attr_group = {
> +	.attrs = sched_attrs,
> +};

ATTRIBUTE_GROUPS()?

> +
> +static int __init intera_monitor_init(void)
> +{
> +	int res = -1;
> +	struct device *dev;
> +
> +	res = fb_register_client(&usf_lcd_nb);
> +	if (res < 0) {
> +		pr_err("Failed to register usf_lcd_nb!\n");
> +		return res;
> +	}
> +
> +	/*
> +	 * create a sched_usf in cpu_subsys:
> +	 * /sys/devices/system/cpu/sched_usf/...
> +	 */
> +	dev = cpu_subsys.dev_root;
> +	res = sysfs_create_group(&dev->kobj, &sched_attr_group);

Do not just tack on random sysfs files to a random struct device that
you do not own.  That's ripe for big problems.

Ugh, that seems to be how others do it too, not nice.

Ok, but at the very least, use DEVICE_ATTR_RW() and do not use kobjects,
as you will get into problems there.

How does userspace know that these new sysfs files have shown up?  You
never told it about them, so does it just "guess"?

thanks,

greg k-h
