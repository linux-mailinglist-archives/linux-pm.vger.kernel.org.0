Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5722347B7
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgGaO0Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 10:26:25 -0400
Received: from foss.arm.com ([217.140.110.172]:60984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgGaO0Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 10:26:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B61BD31B;
        Fri, 31 Jul 2020 07:26:24 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9013F66E;
        Fri, 31 Jul 2020 07:26:05 -0700 (PDT)
Subject: Re: [PATCH v2] sched: Provide USF for the portable equipment.
To:     Dongdong Yang <contribute.kernel@gmail.com>,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
References: <cover.1596196060.git.yangdongdong@xiaomi.com>
 <e992fea6ad249694e615640862a28346936f8844.1596196062.git.yangdongdong@xiaomi.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <67e5566b-2ec5-0a1d-87e1-88e90a8fa715@arm.com>
Date:   Fri, 31 Jul 2020 16:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e992fea6ad249694e615640862a28346936f8844.1596196062.git.yangdongdong@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/07/2020 14:46, Dongdong Yang wrote:
> From: Dongdong Yang <yangdongdong@xiaomi.com>

[...]

> +	if (unlikely(usf_vdev.enable_debug))
> +		trace_printk
> +		    ("%s: cpu_id=%d non_ux=%d usf_up=%d usf_down=%d util=%lu\n",
> +		     USF_TAG, cpuid, usf_vdev.usf_non_ux,
> +		     usf_vdev.usf_up_l0, usf_vdev.usf_down, *util);

trace_printk in code ?

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
> +			usf_vdev.is_screen_on = 0;
> +			if (usf_vdev.sysctl_sched_usf_non_ux != 0)
> +				static_branch_enable(&adjust_task_pred_set);
> +			else
> +				static_branch_disable(&adjust_task_pred_set);
> +
> +			break;
> +
> +		case FB_BLANK_UNBLANK:
> +			usf_vdev.is_screen_on = 1;
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
> +		usf_vdev.is_sched_usf_enabled = 1;
> +		if (usf_vdev.enable_debug)
> +			trace_printk("%s : usf_vdev.is_screen_on:%d\n",
> +				     __func__, usf_vdev.is_screen_on);
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block usf_lcd_nb = {
> +	.notifier_call = usf_lcd_notifier,
> +	.priority = INT_MAX,
> +};

Looks like those notifications should enable/disable the schedutil
extension adjust_task_pred_demand(). Who's calling them?

The 3 sched_usf_FOO sys files somehow have an influence here too. How
should this work?

I see a fb_register_client() in intera_monitor_init further below.

[...]

> +usf_attr_rw(sched_usf_up_l0_r);
> +usf_attr_rw(sched_usf_down_r);
> +usf_attr_rw(sched_usf_non_ux_r);

What can I do with these three files? What do they stand for?

root@h620:/sys/devices/system/cpu/sched_usf# ls
sched_usf_down_r  sched_usf_non_ux_r  sched_usf_up_l0_r

[...]

> +static int __init intera_monitor_init(void)
> +{
> +	int res = -1;
> +	struct attribute_group *attr_group;
> +
> +	res = fb_register_client(&usf_lcd_nb);
> +	if (res < 0) {
> +		pr_err("Failed to register usf_lcd_nb!\n");
> +		return res;

[...]
