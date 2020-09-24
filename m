Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60527763A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgIXQHv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 12:07:51 -0400
Received: from foss.arm.com ([217.140.110.172]:49954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgIXQHv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 12:07:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E0B71396;
        Thu, 24 Sep 2020 09:07:50 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3964A3F718;
        Thu, 24 Sep 2020 09:07:50 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:07:48 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/topology,schedutil: wrap sched domains rebuild
Message-ID: <20200924160748.GA17927@arm.com>
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
 <20200924123937.20938-2-ionela.voinescu@arm.com>
 <20200924133446.GA3920949@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924133446.GA3920949@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey,

On Thursday 24 Sep 2020 at 14:34:46 (+0100), Quentin Perret wrote:
> On Thursday 24 Sep 2020 at 13:39:35 (+0100), Ionela Voinescu wrote:
> > @@ -433,6 +437,7 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
> >  }
> >  #else
> >  static void free_pd(struct perf_domain *pd) { }
> > +void rebuild_sched_domains_energy(void) { }
> 
> Nit: maybe make that stub static inline in a header instead? I guess LTO
> and friends ought to clean that up for you, but it shouldn't hurt to give
> the compiler a little bit of help here.
> 

Makes sense and will do!

Thank you,
Ionela.

> Otherwise, LGTM:
> 
> Acked-by: Quentin Perret <qperret@google.com>
> 
> >  #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL*/
> >  
> >  static void free_rootdomain(struct rcu_head *rcu)
> > -- 
> > 2.17.1
> > 
