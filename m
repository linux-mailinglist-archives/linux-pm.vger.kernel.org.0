Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11AF2A8053
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 15:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgKEODh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 09:03:37 -0500
Received: from foss.arm.com ([217.140.110.172]:33408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgKEODh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 09:03:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07E511509;
        Thu,  5 Nov 2020 06:03:37 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D5763F719;
        Thu,  5 Nov 2020 06:03:36 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:03:35 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 1/3] sched/topology,schedutil: wrap sched
 domains rebuild
Message-ID: <20201105140335.GA22244@arm.com>
References: <20201027180713.7642-1-ionela.voinescu@arm.com>
 <20201027180713.7642-2-ionela.voinescu@arm.com>
 <CAJZ5v0gg7dz44s_fjtJKm8Sv87RZypxYe3EwXX74oAuk31GW1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gg7dz44s_fjtJKm8Sv87RZypxYe3EwXX74oAuk31GW1Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Friday 30 Oct 2020 at 16:26:32 (+0100), Rafael J. Wysocki wrote:
> On Tue, Oct 27, 2020 at 7:08 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >
> > Add the rebuild_sched_domains_energy() function to wrap the functionality
> > that rebuilds the scheduling domains if any of the Energy Aware Scheduling
> > (EAS) initialisation conditions change. This functionality is used when
> > schedutil is added or removed or when EAS is enabled or disabled
> > through the sched_energy_aware sysctl.
> >
> > Therefore, create a single function that is used in both these cases and
> > that can be later reused.
> >
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Acked-by: Quentin Perret <qperret@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> 
> For the schedutil part:
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

Thank you for taking a look!

> and I'm assuming the patch to be taken care of by Peter.

I'm hoping that as well. I'll ask some of the arm64 folk to take another
look over 2/3 to make sure that's covered.

Many thanks,
Ionela.
