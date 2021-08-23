Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8693F4EFB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhHWRHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 13:07:14 -0400
Received: from foss.arm.com ([217.140.110.172]:55406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhHWRHN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Aug 2021 13:07:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B3A111D4;
        Mon, 23 Aug 2021 10:06:30 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6CDA3F5A1;
        Mon, 23 Aug 2021 10:06:28 -0700 (PDT)
Date:   Mon, 23 Aug 2021 18:06:23 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 0/9] Inefficient OPPs
Message-ID: <20210823170623.GA238231@e120877-lin.cambridge.arm.com>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0jLzj48-Bu1-i4=r3aratJwRzVYuaPvycUb--4jKSRkHw@mail.gmail.com>
 <20210810061323.kc5kvy6m6566z3gz@vireshk-i7>
 <CAJZ5v0hta1mEVatT=6ZMLhZCs3btcSbTT10YEihfdvB-WxDuzQ@mail.gmail.com>
 <20210817070619.g6ootmga3nyxm7tz@vireshk-i7>
 <43cd2dfc-a9bf-ccaa-292c-a36124d57025@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43cd2dfc-a9bf-ccaa-292c-a36124d57025@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 17, 2021 at 10:03:53AM +0100, Lukasz Luba wrote:
> 
> 
> On 8/17/21 8:06 AM, Viresh Kumar wrote:
> >On 16-08-21, 16:19, Rafael J. Wysocki wrote:
> >>On Tue, Aug 10, 2021 at 8:13 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>>  I understand  that this was done to not do the efficient stuff in case of
> >>>   userspace/powersave/performance governors.
> >>>
> >>>   What about reusing following for finding all such cases ?
> >>>
> >>>         policy->governor->flags & CPUFREQ_GOV_DYNAMIC_SWITCHING
> >>>
> >>>   The driver can set a flag to tell if it wants efficient frequencies
> >>>   or not, and at runtime we apply efficient algorithm only if the
> >>>   current governor does DVFS, which will leave out
> >>>   userspace/performance/powersave.
> >>
> >>As long as this can be done without actually accessing
> >>policy->governor->flags on every transition, it sounds like a good
> >>idea.
> >
> >Great.
> >
> >Vincent, I hope you will be taking this forward then ?
> >
> 
> Vincent has been on vacations for quite a while, but he will be back
> next week.
> 
> Thank you guys for the comments.

Sorry, I was indeed off for few weeks, that's why I was silent until now.
Looks like I missed the party here. But if I sum-up what you discussed in
the thread:

  * With a newly introduced callback .register_em(), we could use the EM
    table to mark inefficiencies into the CPUFreq table from the CPUFreq
    driver.

  * Instead of having a RELATION_E, resolving inefficiencies to efficient
    frequencies whenever the driver supports it and the governor declares
    CPUFREQ_GOV_DYNAMIC_SWITCHING.

I'll have a look and I'll prepare a new version, based on:

  [PATCH V3 0/9] Add callback to register with energy model 

-- 
Vincent
