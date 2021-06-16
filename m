Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6D3A94D8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFPIVI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhFPIVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 04:21:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1CDC06175F
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 01:19:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so1315202pjn.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+AzUjtrJOh8ZWRh784rmLMzJQd1pE1/adqWdw+99bT4=;
        b=nqcq9amYZYQtquTdDm40QUnU2urna5vkIVt25YGHbWE1PJv/OtejXkSFqDAl+BAKrN
         Bw79ZuawEIYG3SrfHHvNmR+gaTQJ8GOc65mIUwgifXEsXIuK/+YMGmb3x2uhLAI0CTcZ
         AizQez9fbr2QjQdNwy27mcKhYTNmSz0uzED29jpObh6SnHIJ2t/Q63zBJwvB8IBqOb1r
         Ye6o1cwDZkdPYhz25Nu6j0+8WP67wAklr+Ort09x8Lu9lpI4q+ck8SkCzAWU10MjJGQj
         1wKW3EaxVWS7QUtLG9B+jAdJMJTtwNb4dFn7JOJBDIJF+1qTy+8UYANfmM0hphkpLygx
         LoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+AzUjtrJOh8ZWRh784rmLMzJQd1pE1/adqWdw+99bT4=;
        b=NVcTLs0PeZOQUFLkhgGMmn8hcLv7k774jfBF8zgk47BcwIUz/k+rhprxWaNMIMZWH3
         Dvdb+skjpykOVixyjGg++ZeIvEP16usVdASt2EOfilfUTnQ7YF15mypceCe/KD28Efmi
         W6C+XrLEK4pETMeNOoWyhW2IJvCVTh0VdrvG0amotGpnhgpbaShRCbZ/SsxIH5yiufux
         wLlLbAbIKZPLCltnBWokZp0bX74IpIK4kgKGHWql34wUnPAk2FclRn+IfHwgFtU+sGMi
         7X2nYz9A1D4zJPl5d3/ss42P40PoQ10ywldGle2xA2Un9sdzFTbeZ54W/4+uyf1VRZIi
         vDgQ==
X-Gm-Message-State: AOAM533TVrPcqxGeBR4fNj4QxiXEM0juLv6BMjSQOB+iNvpZGtrx/kGg
        dIHiRy1G6xiellYubwrL4UBFkMTlnrvDQw==
X-Google-Smtp-Source: ABdhPJypIF7kXx23yj+Dg80lYHYrg2s+N9oFEbv4GhxfmY6e8X3IPwp4XbpJU3xleGLEESYRmb6ttA==
X-Received: by 2002:a17:902:7244:b029:f5:2ffd:37f9 with SMTP id c4-20020a1709027244b02900f52ffd37f9mr8146848pll.26.1623831542179;
        Wed, 16 Jun 2021 01:19:02 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id f18sm4647252pjq.48.2021.06.16.01.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 01:19:01 -0700 (PDT)
Date:   Wed, 16 Jun 2021 13:48:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] arch_topology: Avoid use-after-free for
 scale_freq_data
Message-ID: <20210616081859.idzpwzdyeu666xpz@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
 <YMmu3bS3Q6avUfEW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMmu3bS3Q6avUfEW@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-21, 09:57, Greg Kroah-Hartman wrote:
> On Wed, Jun 16, 2021 at 12:18:08PM +0530, Viresh Kumar wrote:
> > Currently topology_scale_freq_tick() may end up using a pointer to
> > struct scale_freq_data, which was previously cleared by
> > topology_clear_scale_freq_source(), as there is no protection in place
> > here. The users of topology_clear_scale_freq_source() though needs a
> > guarantee that the previous scale_freq_data isn't used anymore.
> > 
> > Since topology_scale_freq_tick() is called from scheduler tick, we don't
> > want to add locking in there. Use the RCU update mechanism instead
> > (which is already used by the scheduler's utilization update path) to
> > guarantee race free updates here.
> > 
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> So this is a bugfix for problems in the current codebase?  What commit
> does this fix?  Should it go to the stable kernels?

There is only one user of topology_clear_scale_freq_source()
(cppc-cpufreq driver, which is already reverted in pm/linux-next). So
in the upcoming 5.13 kernel release, there will be no one using this
API and so no one will break.

And so I skipped the fixes tag, I can add it though.

> > ---
> >  drivers/base/arch_topology.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index c1179edc0f3b..921312a8d957 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -18,10 +18,11 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/init.h>
> >  #include <linux/percpu.h>
> > +#include <linux/rcupdate.h>
> >  #include <linux/sched.h>
> >  #include <linux/smp.h>
> >  
> > -static DEFINE_PER_CPU(struct scale_freq_data *, sft_data);
> > +static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
> >  static struct cpumask scale_freq_counters_mask;
> >  static bool scale_freq_invariant;
> >  
> > @@ -66,16 +67,20 @@ void topology_set_scale_freq_source(struct scale_freq_data *data,
> >  	if (cpumask_empty(&scale_freq_counters_mask))
> >  		scale_freq_invariant = topology_scale_freq_invariant();
> >  
> > +	rcu_read_lock();
> > +
> >  	for_each_cpu(cpu, cpus) {
> > -		sfd = per_cpu(sft_data, cpu);
> > +		sfd = rcu_dereference(*per_cpu_ptr(&sft_data, cpu));
> >  
> >  		/* Use ARCH provided counters whenever possible */
> >  		if (!sfd || sfd->source != SCALE_FREQ_SOURCE_ARCH) {
> > -			per_cpu(sft_data, cpu) = data;
> > +			rcu_assign_pointer(per_cpu(sft_data, cpu), data);
> >  			cpumask_set_cpu(cpu, &scale_freq_counters_mask);
> >  		}
> >  	}
> >  
> > +	rcu_read_unlock();
> > +
> >  	update_scale_freq_invariant(true);
> >  }
> >  EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
> > @@ -86,22 +91,32 @@ void topology_clear_scale_freq_source(enum scale_freq_source source,
> >  	struct scale_freq_data *sfd;
> >  	int cpu;
> >  
> > +	rcu_read_lock();
> > +
> >  	for_each_cpu(cpu, cpus) {
> > -		sfd = per_cpu(sft_data, cpu);
> > +		sfd = rcu_dereference(*per_cpu_ptr(&sft_data, cpu));
> >  
> >  		if (sfd && sfd->source == source) {
> > -			per_cpu(sft_data, cpu) = NULL;
> > +			rcu_assign_pointer(per_cpu(sft_data, cpu), NULL);
> >  			cpumask_clear_cpu(cpu, &scale_freq_counters_mask);
> >  		}
> >  	}
> >  
> > +	rcu_read_unlock();
> > +
> > +	/*
> > +	 * Make sure all references to previous sft_data are dropped to avoid
> > +	 * use-after-free races.
> > +	 */
> > +	synchronize_rcu();
> 
> What race is happening?  How could the current code race?  Only when a
> cpu is removed?

topology_scale_freq_tick() is called by the scheduler for each CPU
from scheduler_tick().

It is possible that topology_scale_freq_tick() ends up using an older
copy of sft_data pointer, while it is being removed by
topology_clear_scale_freq_source() because a CPU went away or a
cpufreq driver went away, or during normal suspend/resume (where CPUs
are hot-unplugged).

synchronize_rcu() makes sure that all RCU critical sections that
started before it is called, will finish before it returns. And so the
callers of topology_clear_scale_freq_source() don't need to worry
about their callback getting called anymore.

-- 
viresh
