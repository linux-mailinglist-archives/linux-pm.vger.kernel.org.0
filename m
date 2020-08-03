Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163D923A617
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHCM2D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 08:28:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgHCM2B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 08:28:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073CNL11161543;
        Mon, 3 Aug 2020 12:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=B1itshdRPMsvYkSMFi+9dsaVmWgxSwSwsexzd+1OWa0=;
 b=Agu/yBn1mScLE6VU8rbqgEZARhW00j2+B121QZnqzpk8a/cCy8rwmyPEHtgkeIYNFSZF
 6mmlb/iD0swTK+xd4JnPuhfWtCIr6o3NsPKvzqHGNVwhIedl/Q8yd5sVx1ysCEwMyxJz
 +PWKM9iZyXrWi4eHKuOGL7vc+13EwJCUosvlS1LDsjqzWtOo8F5rVM5TCQbJ+2y/yd5n
 0e9ZISR0nUuVjzkQCgJkPEYqrD6QiPi2veKoegulEWorrDFPRpW+tGyb0TPzWugW9fjO
 xUFMCSwHEGj+RPabYHbq0080CKYxs99JU3S6tIx2YdOjMFKr33Cw5waE/auRubwHAIoW Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32pdnq1e0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 12:27:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073CIrRu040442;
        Mon, 3 Aug 2020 12:25:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32pdhacudm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 12:24:59 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073COoJp004388;
        Mon, 3 Aug 2020 12:24:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 05:24:48 -0700
Date:   Mon, 3 Aug 2020 15:24:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, devel@driverdev.osuosl.org, gulinghua@xiaomi.com,
        tanggeliang@xiaomi.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangdongdong@xiaomi.com,
        duhui@xiaomi.com, zhangguoquan@xiaomi.com, fengwei@xiaomi.com,
        taojun@xiaomi.com, rocking@linux.alibaba.com, huangqiwu@xiaomi.com
Subject: Re: [PATCH] sched: Provide USF for the portable equipment.
Message-ID: <20200803122437.GC1793@kadam>
References: <cover.1596101307.git.yangdongdong@xiaomi.com>
 <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030093
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 09:35:43PM +0800, Dongdong Yang wrote:
> From: Dongdong Yang <yangdongdong@xiaomi.com>
> 
> The power consumption and UI response are more cared
> for by the portable equipment users. USF(User Sensitive
> Feedback factor) auxiliary cpufreq governor is
> providing more utils adjustment settings to a high
> level by scenario identification.
> 
> From the view of portable equipment, screen off status
> usually stands for no request from the user, however,
> the kernel is still expected to notify the user
> in time on modem, network or powerkey events occur.
> In some scenarios, such as listening to music,
> low power processors, such as DSP, take more actions
> and CPU load requirements cut down.  It would bring
> more power consumption benefit if high level have
> interfaces to adjust utils according to the current
> scenario and load.
> 
> In addition, the portable equipment user usually heavy
> interact with devices by touch, and other peripherals.
> The boost preemptive counts are marking the load
> requirement urgent, vice versa. If such feedback
> factor could be set to high level according to the
> scenario, it would contribute to the power consumption
> and UI response.
> 
> If no USF sysfs inode is set, and no screen on or
> off event, adjust_task_pred_demand shall not be invoked.
> Once sched_usf_up_l0_r/down_r/non_ux_r be set,
> adjust_task_pred_demand_impl shall be called back
> to update settings according to high level scenario
> identification.
> 
> We can get about 17% mean power consumption save
> at listening to music with speaker on "screen
> off" scenario, as below statistical data from 7766
> XiaoMi devices for two weeks with
> sched_usf_non_ux_r be set:
> 
>         day1         day2         day3         day4
> count   7766.000000  7766.000000  7766.000000  7766.000000
> mean    88.035525    85.500282    83.829305    86.054997
> std     111.049980   108.258834   107.562583   108.558240
> min     0.099000     0.037000     0.067000     0.045000
> 25%     34.765500    34.021750    34.101500    34.423000
> 50%     54.950000    55.286500    54.189500    54.248500
> 75%     95.954000    93.942000    91.738000    94.0592500
> 80%     114.675000   107.430000   106.378000   108.673000
> 85%     137.851000   129.511000   127.156500   131.750750
> 90%     179.669000   170.208500   164.027000   172.348000
> 95%     272.395000   257.845500   247.750500   263.275750
> 98%     399.034500   412.170400   391.484000   402.835600
> 
>         day5         day6        day7         day8
> count   7766.000000  7766.00000  7766.000000  7766.000000
> mean    82.532677    79.21923    77.611380    81.075081
> std     104.870079   101.34819   103.140037   97.506221
> min     0.051000     0.02900     0.007000     0.068000
> 25%     32.873000    33.44400    31.965500    33.863500
> 50%     52.180500    51.56550    50.806500    53.080000
> 75%     90.905750    86.82625    83.859250    89.973000
> 80%     105.455000   99.64700    97.271000    104.225000
> 85%     128.300000   118.47825   116.570250   126.648250
> 90%     166.647500   149.18000   150.649500   161.087000
> 95%     247.208500   224.36050   226.380000   245.291250
> 98%     393.002000   347.92060   369.791800   378.778600
> 
>         day9         day10        day11        day12
> count   7766.000000  7766.000000  7766.000000  7766.000000
> mean    79.989170    83.859417    78.032930    77.060542
> std     104.226122   108.893043   102.561715   99.844276
> min     0.118000     0.017000     0.028000     0.039000
> 25%     32.056250    33.454500    31.176250    30.897750
> 50%     51.506000    54.056000    48.969500    49.069000
> 75%     88.513500    92.953500    83.506750    84.096000
> 80%     102.876000   107.845000   97.717000    98.073000
> 85%     124.363000   128.288000   118.366500   116.869250
> 90%     160.557000   167.084000   154.342500   148.187500
> 95%     231.149000   242.925750   236.759000   228.131250
> 98%     367.206600   388.619100   385.269100   376.541600
> 
>         day13        day14
> count   7766.000000  7766.000000
> mean    75.528036    73.702878
> std     90.750594    86.796016
> min     0.066000     0.054000
> 25%     31.170500    31.608500
> 50%     48.758500    49.215000
> 75%     84.522750    83.053000
> 80%     97.879000    94.875000
> 85%     116.680250   113.573750
> 90%     149.083500   144.089500
> 95%     226.177750   211.488750
> 98%     347.011100   331.317100
> 
> Signed-off-by: Dongdong Yang <yangdongdong@xiaomi.com>
> Signed-off-by: Jun Tao <taojun@xiaomi.com>
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> Signed-off-by: Geliang Tang <tanggeliang@xiaomi.com>
> Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> ---
>  drivers/staging/Kconfig          |   2 +
>  drivers/staging/Makefile         |   1 +
>  drivers/staging/fbsched/Kconfig  |  10 ++
>  drivers/staging/fbsched/Makefile |   2 +
>  drivers/staging/fbsched/usf.c    | 351 +++++++++++++++++++++++++++++++++++++++
>  kernel/sched/cpufreq_schedutil.c |  11 +-
>  6 files changed, 376 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/staging/fbsched/Kconfig
>  create mode 100644 drivers/staging/fbsched/Makefile
>  create mode 100644 drivers/staging/fbsched/usf.c
> 
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 4ec5528..05b231e 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -120,4 +120,6 @@ source "drivers/staging/qlge/Kconfig"
>  
>  source "drivers/staging/wfx/Kconfig"
>  
> +source "drivers/staging/fbsched/Kconfig"
> +
>  endif # STAGING
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index 4d34198..e016ec6 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -50,3 +50,4 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
>  obj-$(CONFIG_KPC2000)		+= kpc2000/
>  obj-$(CONFIG_QLGE)		+= qlge/
>  obj-$(CONFIG_WFX)		+= wfx/
> +obj-$(CONFIG_SCHED_USF)		+= fbsched/
> diff --git a/drivers/staging/fbsched/Kconfig b/drivers/staging/fbsched/Kconfig
> new file mode 100644
> index 0000000..954b6af
> --- /dev/null
> +++ b/drivers/staging/fbsched/Kconfig
> @@ -0,0 +1,10 @@
> +config SCHED_USF
> +	bool "User Sensitive Factors for Scheduler"
> +	depends on CPU_FREQ_GOV_SCHEDUTIL && FB
> +	help
> +	  Select this option to enable the adjustment on the cpufreq with
> +	  the user sensitive factors on schedule. It is special for portable
> +	  equipment which more power care and quick response requirement on
> +	  screen on.
> +
> +	  If unsure, say N.
> diff --git a/drivers/staging/fbsched/Makefile b/drivers/staging/fbsched/Makefile
> new file mode 100644
> index 0000000..f56aa6c
> --- /dev/null
> +++ b/drivers/staging/fbsched/Makefile
> @@ -0,0 +1,2 @@
> +LINUXINCLUDE += -include $(srctree)/kernel/sched/sched.h
> +obj-$(CONFIG_SCHED_USF) += usf.o
> diff --git a/drivers/staging/fbsched/usf.c b/drivers/staging/fbsched/usf.c
> new file mode 100644
> index 0000000..8582992
> --- /dev/null
> +++ b/drivers/staging/fbsched/usf.c
> @@ -0,0 +1,351 @@
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
> +extern void (*adjust_task_pred_demand)(int cpuid,
> +				       unsigned long *util,
> +				       struct rq *rq);
> +DEFINE_PER_CPU(unsigned long[PID_MAX_LIMIT], task_hist_nivcsw);
> +
> +static struct {
> +	bool is_sched_usf_enabled;
> +	int enable_debug;

Make this a bool.  Use true false.

> +	int is_screen_on;

Bool

> +	struct kobject *kobj;
> +	struct dentry *debugfs_entry;
> +	int sysctl_sched_usf_up_l0;
> +	int sysctl_sched_usf_down;
> +	int sysctl_sched_usf_non_ux;
> +	int usf_up_l0;
> +	int usf_down;
> +	int usf_non_ux;
> +} usf_vdev;
> +
> +static void adjust_task_pred_demand_impl(int cpuid,
> +					 unsigned long *util,
> +					 struct rq *rq)
> +{
> +	/* sysctl_sched_latency/sysctl_sched_min_granularity */
> +	u32 bl_sw_num = 3;
> +
> +	if (!usf_vdev.is_sched_usf_enabled || !rq || !rq->curr)
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
> +	if (unlikely(usf_vdev.enable_debug))
> +		trace_printk
> +		    ("%s: cpu_id=%d non_ux=%d usf_up=%d usf_down=%d util=%lu\n",
> +		     USF_TAG, cpuid, usf_vdev.usf_non_ux,
> +		     usf_vdev.usf_up_l0, usf_vdev.usf_down, *util);
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
> +			usf_vdev.is_screen_on = 0;
> +			if (usf_vdev.sysctl_sched_usf_non_ux != 0)
> +				adjust_task_pred_demand =
> +				    &adjust_task_pred_demand_impl;
> +			else
> +				adjust_task_pred_demand = NULL;
> +
> +			break;
> +
> +		case FB_BLANK_UNBLANK:
> +			usf_vdev.is_screen_on = 1;
> +			if (usf_vdev.sysctl_sched_usf_up_l0 != 0 ||
> +			    usf_vdev.sysctl_sched_usf_down != 0)
> +				adjust_task_pred_demand =
> +				    &adjust_task_pred_demand_impl;
> +			else
> +				adjust_task_pred_demand = NULL;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		usf_vdev.is_sched_usf_enabled = 1;

s/1/true/

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
> +
> +static ssize_t store_sched_usf_up_l0_r(struct kobject *kobj,
> +				       struct kobj_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret) {
> +		pr_err(USF_TAG "set state fail ret=%d\n", ret);

Don't print an error.  Just return ret;

> +		return ret;
> +	}
> +
> +	if ((val >= 0) && (val <= BOOST_MAX_V)) {
> +		usf_vdev.sysctl_sched_usf_up_l0 = val;
> +		usf_vdev.usf_up_l0 = LEVEL_TOP -
> +				DIV_ROUND_UP(val, BOOST_MAX_V / 2);
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, 0, BOOST_MAX_V);

Flip this test around and return an error code on invalide input:

	if (val < 0 || val > BOOST_MAX_V)
		return -EINVAL;

Print an error here if you want.

> +	}
> +	if ((usf_vdev.sysctl_sched_usf_up_l0 == 0) &&
> +	    (usf_vdev.sysctl_sched_usf_down == 0))
> +		adjust_task_pred_demand = NULL;
> +	else
> +		adjust_task_pred_demand = &adjust_task_pred_demand_impl;

There needs to be some locking around adjust_task_pred_demand.

> +
> +	return count;
> +}
> +
> +static ssize_t store_sched_usf_down_r(struct kobject *kobj,
> +				      struct kobj_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret) {
> +		pr_err(USF_TAG "set state fail ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((val >= BOOST_MIN_V) && (val <= 0)) {
> +		usf_vdev.sysctl_sched_usf_down = val;
> +		usf_vdev.usf_down = DIV_ROUND_UP(-val, -BOOST_MIN_V / 2);
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, BOOST_MIN_V, 0);

All the same comments as above.

> +	}i
> +	if ((usf_vdev.sysctl_sched_usf_up_l0 == 0) &&
> +	    (usf_vdev.sysctl_sched_usf_down == 0))
> +		adjust_task_pred_demand = NULL;
> +	else
> +		adjust_task_pred_demand = &adjust_task_pred_demand_impl;
> +
> +	return count;
> +}
> +
> +static ssize_t store_sched_usf_non_ux_r(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret) {
> +		pr_err(USF_TAG "set state fail ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((val >= BOOST_MIN_V) && (val <= 0)) {
> +		usf_vdev.sysctl_sched_usf_non_ux = val;
> +		usf_vdev.usf_non_ux = DIV_ROUND_UP(-val, -BOOST_MIN_V / 2);
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, BOOST_MIN_V, 0);
> +	}
> +	if (usf_vdev.sysctl_sched_usf_non_ux == 0)
> +		adjust_task_pred_demand = NULL;
> +	else
> +		adjust_task_pred_demand = &adjust_task_pred_demand_impl;
> +
> +	return count;

Same.

> +}
> +
> +#define usf_attr_rw(_name)						\
> +static struct kobj_attribute _name =					\
> +__ATTR(_name, 0664, show_##_name, store_##_name)
> +
> +#define usf_show_node(_name, _value)					\
> +static ssize_t show_##_name						\
> +(struct kobject *kobj, struct kobj_attribute *attr,  char *buf)		\
> +{									\
> +	unsigned int len = 0;						\
> +	unsigned int max_len = 8;					\
> +	len +=								\
> +	    snprintf(buf + len, max_len - len, "%d",			\
> +		     usf_vdev.sysctl_##_value);				\
> +	return len;							\


Just do this:

	return sprintf(buf, "%d", usf_vdev.sysctl_##_value);

> +}
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
> +
> +static int usf_dbg_get(void *data, u64 *val)
> +{
> +	*val = (u64)usf_vdev.enable_debug;
> +
> +	return 0;
> +}
> +
> +static int usf_dbg_set(void *data, u64 val)
> +{
> +	usf_vdev.enable_debug = !!val;
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(usf_dbg_fops, usf_dbg_get,
> +			usf_dbg_set, "%llu\n");
> +
> +static int __init intera_monitor_init(void)
> +{
> +	int res = -1;

Don't initialize this.  It just silences uninitialized variable warnings
so it will lead to accidental bugs.

> +	struct attribute_group *attr_group;
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
> +	attr_group = &sched_attr_group;
> +	usf_vdev.kobj = kobject_create_and_add("sched_usf",
> +					       &cpu_subsys.dev_root->kobj);
> +
> +	if (!usf_vdev.kobj) {
> +		pr_err("Failed to create sched_usf!\n");
> +		res = -ENOMEM;
> +		goto out;
> +	} else {

Delete the else.  Pull the code in one indent level.

> +		res = sysfs_create_group(usf_vdev.kobj, attr_group);
> +		if (res) {
> +			kobject_put(usf_vdev.kobj);
> +			goto out;
> +		} else {

Delete this else statement.

> +			kobject_uevent(usf_vdev.kobj, KOBJ_ADD);
> +		}
> +	}
> +
> +	usf_vdev.enable_debug = 0;
> +	usf_vdev.debugfs_entry = debugfs_create_file("usf_dbg",
> +						     0660, NULL, NULL,
> +						     &usf_dbg_fops);
> +	if (!usf_vdev.debugfs_entry)
> +		pr_err("Failed to create usf_dbg!\n");

debugfs never returns NULL.  Generally debugfs_create_file() returns
are not supposed to be error checked.  Just delete the check.

> +
> +	usf_vdev.is_sched_usf_enabled = 0;
> +	usf_vdev.sysctl_sched_usf_up_l0 = 0;
> +	usf_vdev.sysctl_sched_usf_down = 0;
> +	usf_vdev.sysctl_sched_usf_non_ux = 0;
> +	adjust_task_pred_demand = NULL;


No need to set all these to zero/NULL.  It's already zero.

> +
> +	return 0;
> +out:
> +	fb_unregister_client(&usf_lcd_nb);
> +	return res;
> +}
> +
> +module_init(intera_monitor_init);
> +
> +static void __exit intera_monitor_exit(void)
> +{
> +	if (usf_vdev.kobj)

Delet this impossible condition.

> +		kobject_put(usf_vdev.kobj);
> +	if (usf_vdev.debugfs_entry)

Delete this unnecessary condition.

> +		debugfs_remove(usf_vdev.debugfs_entry);
> +	fb_unregister_client(&usf_lcd_nb);
> +	usf_vdev.is_sched_usf_enabled = 0;
> +	usf_vdev.sysctl_sched_usf_up_l0 = 0;
> +	usf_vdev.sysctl_sched_usf_down = 0;
> +	usf_vdev.sysctl_sched_usf_non_ux = 0;
> +	adjust_task_pred_demand = NULL;

No need to set all these to zero/NULL.

regards,
dan carpenter

