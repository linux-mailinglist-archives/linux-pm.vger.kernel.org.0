Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA110234AB6
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgGaSQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 14:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730040AbgGaSQF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 14:16:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F8DC061574;
        Fri, 31 Jul 2020 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WbtzOVCRlAfFjJFM2IifB/d+SPx9ULrVUgo17CsAxIk=; b=c1nSfus8ldaPmfvbONTg9B72M/
        5obEFm0AxYVrEpBqZ5YyQc/gp8+2RT+5eVMnSoVxp0MQTMjSO98HJhIeqUK/LHi3jbky8gJduRFIu
        Kpx5puS0FwnHYqgn08qUQfdNsMCeXO6RZ2ZiXBv4dXUqNMREKU9WxcrVSwXoN/nLj78AgDzZKD5Fv
        mtr2930HRl9Eh3I9iKbhI4YXdPXQFRco8nVzv1sfneISnZTbvKUkIhUDyv81w9k3qEfJWDu5RLIIy
        JY01QCELVFs5/SmjWnhqcLoWVPpixhQa5UcMNsC1SdIlR7SQuNOX4hab60WmSyY1THl0b2mMz0x59
        e7BWzo6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1ZZG-0002Ky-Id; Fri, 31 Jul 2020 18:15:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B552330066E;
        Fri, 31 Jul 2020 20:15:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9865E203C0A1B; Fri, 31 Jul 2020 20:15:38 +0200 (CEST)
Date:   Fri, 31 Jul 2020 20:15:38 +0200
From:   peterz@infradead.org
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
Subject: Re: [PATCH] sched: Provide USF for the portable equipment.
Message-ID: <20200731181538.GB2674@hirez.programming.kicks-ass.net>
References: <cover.1596101307.git.yangdongdong@xiaomi.com>
 <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596116273-2290-1-git-send-email-contribute.kernel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 30, 2020 at 09:35:43PM +0800, Dongdong Yang wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7fbaee2..7bc3429 100644
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
>  	sg_cpu->max = max;
>  	sg_cpu->bw_dl = cpu_bw_dl(rq);

NAK
