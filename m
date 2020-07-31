Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5459233F00
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgGaGTg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 02:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731359AbgGaGTg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 02:19:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92B52083B;
        Fri, 31 Jul 2020 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596176375;
        bh=b1t9HytUhUU2EjOGArGZ1wc7s+rwEM++yuu4FJ5CmMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w2PSvMy7G78srHkxam5ApiTQn83UAkyDjL9kZKmP1Vuy+P77dNewqL6rT1znwAJ1C
         xZnbsNS9xRGVcOSwQzqHA5DWiMY21d6huPQTx4w1OVEt9vTJCc4CrqvNhzDp2Wi5ZS
         h3rd85P9DViGe/dy4SHEl/gQfPnPSqqL6XWiPdsM=
Date:   Fri, 31 Jul 2020 08:19:22 +0200
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
Subject: Re: [PATCH] sched: Provide USF for the portable equipment.
Message-ID: <20200731061922.GB1508201@kroah.com>
References: <cover.1596101307.git.yangdongdong@xiaomi.com>
 <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
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
> >From the view of portable equipment, screen off status
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


Nit, you can wrap your changelog text at 72 columns to make it easier to
read.

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

Why the different names, "fbsched" and "usf"?  what does "fbsched" mean?

>  kernel/sched/cpufreq_schedutil.c |  11 +-

Why are you touching code outside of drivers/staging/ at all?  That's
usually a good sign that this should not be a staging driver as they
should all be self-contained so nothing else in the kernel is messed
with.

> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -289,12 +289,21 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
>  	return min(max, util);
>  }
>  
> +#ifdef CONFIG_SCHED_USF
> +void (*adjust_task_pred_demand)(int cpuid, unsigned long *util,
> +	struct rq *rq) = NULL;
> +EXPORT_SYMBOL(adjust_task_pred_demand);
> +#endif

No #ifdef in .c code.  And why not EXPORT_SYMBOL_GPL?


> +
>  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
>  	unsigned long util = cpu_util_cfs(rq);
>  	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> -
> +#ifdef CONFIG_SCHED_USF
> +	if (adjust_task_pred_demand)
> +		adjust_task_pred_demand(sg_cpu->cpu, &util, rq);
> +#endif

Again, no #ifdef in .c code should be ever done, especially for
something as simple as this.  Otherwise the code is totally
unmaintainable over time.

thanks,

greg k-h
