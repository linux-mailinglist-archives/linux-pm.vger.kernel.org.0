Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36C296CED
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460804AbgJWKeV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460789AbgJWKeV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:34:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C665EC0613CE;
        Fri, 23 Oct 2020 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FY9N/5KVWtyIU3Yg2KPO7b4LfRF9k+nDHXcTOcUUP2Y=; b=BU6hoREwvlyQ3AmxUvWQf6Z9nC
        Ieg9plN7gFSe15QQq/YIbhSoz75Dx+vaqcv4x9b4ByzSa+KRljGcp9J8V5Kp5L/pnb+ePEhCeiUiw
        Wbj+WdKPnKHdqOuitUZnZwQQoJ2b84YHafcf7EcL0zUo2ZEtVX5XqAe3qQbX8kvXyOfhyUZZ6qzD+
        21eCVoaojPT4HjLsDI3G+cw09UVvc4CbWsQimDzby7tLDzoU04+yJYh19zZu4hBcko2ZNN+wfPC+c
        sF4LKaUmadg88zFeF/YDgSyumP5+sU0MymQb6CvxzKn8Oi7Z0EJh3v7R2hmQIBDym9Zo9eSlsbCIk
        CYAH+36A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuOd-0003Te-Mz; Fri, 23 Oct 2020 10:34:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4338E300B22;
        Fri, 23 Oct 2020 12:34:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 247D82BB5A39A; Fri, 23 Oct 2020 12:34:07 +0200 (CEST)
Date:   Fri, 23 Oct 2020 12:34:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
Message-ID: <20201023103407.GK2594@hirez.programming.kicks-ass.net>
References: <cover.1603448113.git.viresh.kumar@linaro.org>
 <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 23, 2020 at 03:50:20PM +0530, Viresh Kumar wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2003a7d5ab5..369ff54d11d4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5117,6 +5117,119 @@ struct task_struct *idle_task(int cpu)
>  	return cpu_rq(cpu)->idle;
>  }
>  
> +/*
> + * This function computes an effective utilization for the given CPU, to be
> + * used for frequency selection given the linear relation: f = u * f_max.
> + *
> + * The scheduler tracks the following metrics:
> + *
> + *   cpu_util_{cfs,rt,dl,irq}()
> + *   cpu_bw_dl()
> + *
> + * Where the cfs,rt and dl util numbers are tracked with the same metric and
> + * synchronized windows and are thus directly comparable.
> + *
> + * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> + * which excludes things like IRQ and steal-time. These latter are then accrued
> + * in the irq utilization.
> + *
> + * The DL bandwidth number otoh is not a measured metric but a value computed
> + * based on the task model parameters and gives the minimal utilization
> + * required to meet deadlines.
> + */
> +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> +				 unsigned long max, enum cpu_util_type type,
> +				 struct task_struct *p)
> +{
	...
> +}
> +
> +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
> +			     unsigned long max)
> +{
> +	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
> +				  NULL);
> +}

Shouldn't all that be: #ifdef CONFIG_SMP ?
