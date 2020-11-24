Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2CC2C2700
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 14:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbgKXNWo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 08:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbgKXNWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 08:22:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAF5C0617A6
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 05:22:43 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 5so10681937plj.8
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2020 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e7vSOMbj0zPx6JF2lHClWTW/C5ALeNJny1X9ptSKIck=;
        b=iDKRgxDeFw+OR0/wRVWW6JX6GHlwYO3QyaedJXmODg7EpiW4f0/pSaFqbDv2k0nQNI
         4xhgxoYTsxgJw4TEz6+3bNP5Utc0JB3vxIPt7D6c/BiAvDPctIF7VD/LcCIHlqk/kLIY
         U57flrzq1ayvFEmhKhpT33DUKzYt8ysf0dEEMXVMLOqsH2nfYmOzmFN+lPHJK1wZc+6X
         muLL+AXT2mp2poh1c1o6g4nfRrkMcDNkP8mlwtszXnKnlhwc6UOyrRX/4Tym8LbPL0dA
         B3MxB3SX4WKaC90WqD1U8/UwEjE4F9JHrJyufZavqQhE2u/o9LKFuVjmsXUHMchCjuM2
         +mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e7vSOMbj0zPx6JF2lHClWTW/C5ALeNJny1X9ptSKIck=;
        b=abKhtyM53lXlU7cGoHJfpLQCsmSKHDj+qWdDxw8lW7y63zVM674xjkmx2lrwwnuxAa
         82QKaBCiTYg8WlGgZZi/gV0gC+rQF1Bu/7ilQKRTFRFF50HoH1FGeV6GByYCdgDbE/41
         GJ43CeyUJkVvx6PNq/SWP3PkP/N7JJG7IsnYR1G5PVrUcPJ4+igG9d8jvKlYT/S7pGtA
         iGia2AB2IcRH4ywUjOntQ7QmuzJwOEsZVvTuN2keEtDTo06n8vP9/qordH0SOgL5SLzN
         0jOIeIwghzXN1G3spVtTPV5g76P6kXbpQahWYfKIlPJ3184mnU0foywkDKkbjunSHpHS
         Fo7g==
X-Gm-Message-State: AOAM533UPdE0yw6S7GcMwmRAe1xGp0nP2Ue1KYhZPg1fMvi4IIs1QQVC
        HryWSjbkSUrhk/g196TsgJI2vA==
X-Google-Smtp-Source: ABdhPJyHA0Wg0ZpjEQ3r6SZZg8L+iPOxXjnLT5KWlS1QtcWXEFFKQWgFHRUKaqT+De86wD2fkDrLLg==
X-Received: by 2002:a17:902:ff0e:b029:d6:820d:cb81 with SMTP id f14-20020a170902ff0eb02900d6820dcb81mr3970370plj.47.1606224162802;
        Tue, 24 Nov 2020 05:22:42 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 145sm13546299pga.11.2020.11.24.05.22.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Nov 2020 05:22:41 -0800 (PST)
Date:   Tue, 24 Nov 2020 18:52:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
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
Message-ID: <20201124132239.h3kjk6pdwqeoitvb@vireshk-mac-ubuntu>
References: <cover.1606198885.git.viresh.kumar@linaro.org>
 <9a5442b916f9667e714dd84fe4e3fc26f8bcc887.1606198885.git.viresh.kumar@linaro.org>
 <20201124091019.GA1023091@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124091019.GA1023091@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-11-20, 09:10, Quentin Perret wrote:
> Hey Viresh,
> 
> On Tuesday 24 Nov 2020 at 11:56:15 (+0530), Viresh Kumar wrote:
> > There is nothing schedutil specific in schedutil_cpu_util(), rename it
> > to effective_cpu_util(). Also create and expose another wrapper
> > sched_cpu_util() which can be used by other parts of the kernel, like
> > thermal core (that will be done in a later commit).
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  include/linux/sched.h            | 21 +++++++++++++++++++++
> >  kernel/sched/core.c              | 11 +++++++++--
> >  kernel/sched/cpufreq_schedutil.c |  2 +-
> >  kernel/sched/fair.c              |  6 +++---
> >  kernel/sched/sched.h             | 19 ++-----------------
> >  5 files changed, 36 insertions(+), 23 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 063cd120b459..926b944dae5e 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1926,6 +1926,27 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
> >  #define TASK_SIZE_OF(tsk)	TASK_SIZE
> >  #endif
> >  
> > +#ifdef CONFIG_SMP
> > +/**
> > + * enum cpu_util_type - CPU utilization type
> > + * @FREQUENCY_UTIL:	Utilization used to select frequency
> > + * @ENERGY_UTIL:	Utilization used during energy calculation
> > + *
> > + * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> > + * need to be aggregated differently depending on the usage made of them. This
> > + * enum is used within sched_cpu_util() to differentiate the types of
> > + * utilization expected by the callers, and adjust the aggregation accordingly.
> > + */
> > +enum cpu_util_type {
> > +	FREQUENCY_UTIL,
> > +	ENERGY_UTIL,
> > +};
> > +
> > +/* Returns effective CPU utilization, as seen by the scheduler */
> > +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
> > +			     unsigned long max);
> 
> Are 'type' and 'max' useful to anybody outside of kernel/sched ?
> If not then how about we hide them, keep the cpu_util_type enum in
> kernel/sched/sched.h and evaluate arch_scale_cpu_capacity() in
> sched_cpu_util() directly?

cpufreq_cooling uses 'max' (as can be seen in the next patch).

-- 
viresh
