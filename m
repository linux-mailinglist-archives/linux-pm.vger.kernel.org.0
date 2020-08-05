Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8D323CD20
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgHERUt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 13:20:49 -0400
Received: from foss.arm.com ([217.140.110.172]:33666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbgHERSG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 13:18:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4401FB;
        Wed,  5 Aug 2020 03:35:07 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B26013FA32;
        Wed,  5 Aug 2020 03:35:06 -0700 (PDT)
Date:   Wed, 5 Aug 2020 11:35:05 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] cpufreq: set invariance scale factor on
 transition end
Message-ID: <20200805103452.GA4817@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-3-ionela.voinescu@arm.com>
 <20200730041334.cjg5mc5xpopd2lst@vireshk-mac-ubuntu>
 <20200803135838.GB9512@arm.com>
 <20200804062611.6jpra73hmhybdw3i@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804062611.6jpra73hmhybdw3i@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 04 Aug 2020 at 11:56:11 (+0530), Viresh Kumar wrote:
[..]
> > > >  - In __target_index(), cpufreq_freq_transition_end() is called only for
> > > >    drivers that have synchronous notifications enabled. There is only one
> > > >    driver that disables them,
> > > > 
> > > >    drivers/cpufreq/powernow-k8.c:1142: .flags = CPUFREQ_ASYNC_NOTIFICATION,
> > > > 
> > > >    which is deprecated.
> > > 
> > > I don't think this is deprecated.
> 
> Heh, maybe I misunderstood. I thought you are talking about the flag,
> while you were talking about the driver.
> 
> > Sorry, possibly 'deprecated' is a strong word.
> > 
> > As far as I knew acpi_cpufreq was recommended more recently for K8/K10
> > CPUs so that's why I decided not to create a special case for it, also
> > considering that it was not supporting cpufreq-based frequency
> > invariance to begin with.
> > 
> > We could support this as well by having a call to arch_set_freq_scale()
> > on the else path in __target_index(). But given that there was only this
> > one user of CPUFREQ_ASYNC_NOTIFICATION, I thought I'd propose this simpler
> > version first.
> > 
> > Let me know if my reasoning is wrong.
> 
> Nevertheless, I don't think you need to mention this detail in
> changelog for powernow-k8 as cpufreq_freq_transition_end() does get
> called for it as well, by the driver instead of the core.
> 

Agreed!

Many thanks,
Ionela.

> -- 
> viresh
