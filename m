Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D943C231BC5
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 11:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgG2JDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 05:03:45 -0400
Received: from foss.arm.com ([217.140.110.172]:48182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgG2JDp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 05:03:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EFCB31B;
        Wed, 29 Jul 2020 02:03:45 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE463F718;
        Wed, 29 Jul 2020 02:03:44 -0700 (PDT)
Date:   Wed, 29 Jul 2020 10:03:43 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2 1/7] cpufreq: move invariance setter calls in cpufreq
 core
Message-ID: <20200729090343.GA12941@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-2-ionela.voinescu@arm.com>
 <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Monday 27 Jul 2020 at 15:48:39 (+0200), Rafael J. Wysocki wrote:
> On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
> <ionela.voinescu@arm.com> wrote:
[..]
> > target()
> > =======
> > This has been flagged as deprecated since:
> >
> >   commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> >
> > It also doesn't have that many users:
> >
> >   cpufreq-nforce2.c:371:2:      .target = nforce2_target,
> >   cppc_cpufreq.c:416:2:         .target = cppc_cpufreq_set_target,
> >   gx-suspmod.c:439:2:           .target = cpufreq_gx_target,
> >   pcc-cpufreq.c:573:2:          .target = pcc_cpufreq_target,
> 
> Also intel_pstate in the passive mode.
> 

Thanks! I'll update the list. Somehow I missed a few others:

$ grep -E -Hn -r '\.target\s*='

gx-suspmod.c:439:       .target         = cpufreq_gx_target,
s3c24xx-cpufreq.c:428:  .target         = s3c_cpufreq_target,
intel_pstate.c:2528:    .target         = intel_cpufreq_target,
cppc_cpufreq.c:401:     .target = cppc_cpufreq_set_target,
cpufreq-nforce2.c:371:  .target = nforce2_target,
sh-cpufreq.c:163:       .target         = sh_cpufreq_target,
pcc-cpufreq.c:573:      .target = pcc_cpufreq_target,

Sorry about that!

Many thanks for the review,
Ionela.
