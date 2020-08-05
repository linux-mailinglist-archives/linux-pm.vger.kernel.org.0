Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD6123C9FE
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgHEKrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 06:47:55 -0400
Received: from foss.arm.com ([217.140.110.172]:57454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgHEKrv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 06:47:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01926D6E;
        Wed,  5 Aug 2020 03:35:33 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97E053FA32;
        Wed,  5 Aug 2020 03:35:32 -0700 (PDT)
Date:   Wed, 5 Aug 2020 11:35:31 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200805103531.GB4817@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-5-ionela.voinescu@arm.com>
 <20200730044346.rgtaikotkgwdpc3m@vireshk-mac-ubuntu>
 <20200803152400.GB20312@arm.com>
 <20200804064656.h25yapthuumdxjw7@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804064656.h25yapthuumdxjw7@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 04 Aug 2020 at 12:16:56 (+0530), Viresh Kumar wrote:
> On 03-08-20, 16:24, Ionela Voinescu wrote:
> > Right, cpufreq_register_driver() should check that at least one of them
> > is present
> 
> > (although currently cpufreq_register_driver() will return
> > -EINVAL if .fast_switch() alone is present - something to be fixed).
> 
> I think it is fine as there is no guarantee from cpufreq core if
> .fast_switch() will get called and so target/target_index must be
> present. We can't do fast-switch today without schedutil (as only that
> enables it) and if a notifier gets registered before the driver, then
> we are gone again.
> 
> > Will do, on both accounts.
> > 
> > 
> > > > +		static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
> > > > +		pr_debug("%s: Driver %s can provide frequency invariance.",
> > > > +			 __func__, driver->name);
> > > 
> > > I think a simpler print will work well too.
> > > 
> > >                 pr_debug("Freq invariance enabled");
> > > 
> > 
> > I think the right way of reporting this support is important here.
> 
> Yeah, we can't say it is enabled as you explained, though I meant
> something else here then, i.e. getting rid of driver name and
> unimportant stuff. What about this now:
> 
> pr_debug("supports frequency invariance");
> 
> This shall get printed as this finally:
> 
> cpufreq: supports frequency invariance
> 

Will do!

Thanks,
Ionela.

> -- 
> viresh
