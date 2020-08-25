Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3342517A3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgHYLbi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 07:31:38 -0400
Received: from foss.arm.com ([217.140.110.172]:56696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730037AbgHYLbe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 07:31:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BE1830E;
        Tue, 25 Aug 2020 04:31:33 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CF913F66B;
        Tue, 25 Aug 2020 04:31:33 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:31:31 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] arch_topology: validate input frequencies to
 arch_set_freq_scale()
Message-ID: <20200825113131.GB12506@arm.com>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
 <20200824210252.27486-2-ionela.voinescu@arm.com>
 <20200825055618.ybght3enlpuwo3va@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825055618.ybght3enlpuwo3va@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 25 Aug 2020 at 11:26:18 (+0530), Viresh Kumar wrote:
> On 24-08-20, 22:02, Ionela Voinescu wrote:
> > The current frequency passed to arch_set_freq_scale() could end up
> > being 0, signaling an error in setting a new frequency. Also, if the
> > maximum frequency in 0, this will result in a division by 0 error.
> > 
> > Therefore, validate these input values before using them for the
> > setting of the frequency scale factor.
> > 
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > ---
> >  drivers/base/arch_topology.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 75f72d684294..1aca82fcceb8 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -33,6 +33,9 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> >  	unsigned long scale;
> >  	int i;
> >  
> > +	if (!cur_freq || !max_freq)
> 
> We should probably use unlikely() here.
> 
> Rafael: Shouldn't this have a WARN_ON_ONCE() as well ?
> 

I'll add the unlikely() as it's definitely useful.

I'm somewhat on the fence about WARN_ON_ONCE() here. Wouldn't it work
better in cpufreq_driver_fast_switch()? It would cover scenarios where
the default arch_set_freq_scale() is used and flag potential hardware
issues with setting frequency that are currently just ignored both here
and in sugov_fast_switch().

Thanks,
Ionela.
