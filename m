Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F282C20EA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgKXJK0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgKXJKY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:10:24 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD74C0613D6
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 01:10:24 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so2067970wmb.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 01:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Mqfhh5sobw5RQvqH90O9IkiiSzC2XEiEberF8qfFS0=;
        b=jGon3Gf+LiqEqK0gLdBoozR136wGzvXGvJ1ij5lupny+np0OE0HyWJBTWy87/gD5K1
         gZLV7O2sXLiOlm31O//WAmiAFeJ7OkGsr4vhsQjFS6Tj9iImbtb6LOeXO9nKuZlvuHyc
         Un0nf2CKg/nQnFtfP0XQgVisyCuBm4v1hT3LOAYM8jlITep7MkBNCJQVomyx4bF28IxB
         kyCxRyRxfSRer5469CV96JS5f++Ro3ARnSifnf7Qmmh+u2athG7nm4zhH/pZ+W+XlQyl
         ZTP855Lpe6gAo5Z6e3QPoVi4XYSL1gUT9X2HzaWH5IUZpZgXUtpPy0uOhFGsafET+3Ge
         +liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Mqfhh5sobw5RQvqH90O9IkiiSzC2XEiEberF8qfFS0=;
        b=sauHtnkFkVio/MvIaITl1NpwBvDpGaXtPvWhiUcLYYoRHPzHw0qPsgSZQk31eCFH6c
         M67VQKIV1r1ELCo2m2QxLhs4KYSswKrGRB1fhYzr61n75FgxIDknzcXa41kczhqiexjc
         onzLHVart5IzsDarMUkG1ac7iZN/Maed7N5nMFTuRBuvYXxh2vR0RgCqg1gyZ79HxLEH
         E8Saa/AnMbuqsaFIy15JVTNn8h+Gr93e1NATEhpg+Fwt5bwpRF39/+LpvJpqxkROZ8qH
         hQzCJQaY9wgXlXLcYFlS0y1nNa5g+OgPIutHWrAp6M42RaaDMvWYC6yPhWqje8fCKetz
         IpiA==
X-Gm-Message-State: AOAM530iHb3BrzdoTQQQR+/4S8umBQVCNHsyzCB4q8FpDx8oHSo6Fizs
        Be5OLHKzdsbqEn8KxRDrP+DsfA==
X-Google-Smtp-Source: ABdhPJzk8iYOXz1ncUa8TnoRC9Y7B1bESlx4UUXMqhszK61k1YtxO6os9+qMBFWYMWQuvTwfiJjASA==
X-Received: by 2002:a1c:e455:: with SMTP id b82mr3221302wmh.117.1606209023093;
        Tue, 24 Nov 2020 01:10:23 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id j4sm23646396wrn.83.2020.11.24.01.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 01:10:22 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:10:19 +0000
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 2/3] sched/core: Rename schedutil_cpu_util() and allow
 rest of the kernel to use it
Message-ID: <20201124091019.GA1023091@google.com>
References: <cover.1606198885.git.viresh.kumar@linaro.org>
 <9a5442b916f9667e714dd84fe4e3fc26f8bcc887.1606198885.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a5442b916f9667e714dd84fe4e3fc26f8bcc887.1606198885.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Viresh,

On Tuesday 24 Nov 2020 at 11:56:15 (+0530), Viresh Kumar wrote:
> There is nothing schedutil specific in schedutil_cpu_util(), rename it
> to effective_cpu_util(). Also create and expose another wrapper
> sched_cpu_util() which can be used by other parts of the kernel, like
> thermal core (that will be done in a later commit).
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/sched.h            | 21 +++++++++++++++++++++
>  kernel/sched/core.c              | 11 +++++++++--
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/fair.c              |  6 +++---
>  kernel/sched/sched.h             | 19 ++-----------------
>  5 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 063cd120b459..926b944dae5e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1926,6 +1926,27 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
>  #define TASK_SIZE_OF(tsk)	TASK_SIZE
>  #endif
>  
> +#ifdef CONFIG_SMP
> +/**
> + * enum cpu_util_type - CPU utilization type
> + * @FREQUENCY_UTIL:	Utilization used to select frequency
> + * @ENERGY_UTIL:	Utilization used during energy calculation
> + *
> + * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> + * need to be aggregated differently depending on the usage made of them. This
> + * enum is used within sched_cpu_util() to differentiate the types of
> + * utilization expected by the callers, and adjust the aggregation accordingly.
> + */
> +enum cpu_util_type {
> +	FREQUENCY_UTIL,
> +	ENERGY_UTIL,
> +};
> +
> +/* Returns effective CPU utilization, as seen by the scheduler */
> +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
> +			     unsigned long max);

Are 'type' and 'max' useful to anybody outside of kernel/sched ?
If not then how about we hide them, keep the cpu_util_type enum in
kernel/sched/sched.h and evaluate arch_scale_cpu_capacity() in
sched_cpu_util() directly?

Thanks,
Quentin
