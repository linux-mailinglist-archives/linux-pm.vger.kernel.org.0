Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B415A672
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBLKcy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:32:54 -0500
Received: from foss.arm.com ([217.140.110.172]:58812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgBLKcw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 05:32:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C589330E;
        Wed, 12 Feb 2020 02:32:51 -0800 (PST)
Received: from localhost (unknown [10.1.198.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A953F68F;
        Wed, 12 Feb 2020 02:32:51 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:32:49 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clocksource/drivers/arm_arch_timer: validate
 arch_timer_rate
Message-ID: <20200212103249.GA19041@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-8-ionela.voinescu@arm.com>
 <05e257b6-0a39-135d-8117-7883739538c3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e257b6-0a39-135d-8117-7883739538c3@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Valentin,

On Wednesday 12 Feb 2020 at 09:30:34 (+0000), Valentin Schneider wrote:
> On 11/02/2020 18:45, Ionela Voinescu wrote:
> > From: Valentin Schneider <valentin.schneider@arm.com>
> > 
> > Using an arch timer with a frequency of less than 1MHz can result in an
> > incorrect functionality of the system which assumes a reasonable rate.
> > 
> > One example is the use of activity monitors for frequency invariance
> > which uses the rate of the arch timer as the known rate of the constant
> > cycle counter in computing its ratio compared to the maximum frequency
> > of a CPU. For arch timer frequencies less than 1MHz this ratio could
> > end up being 0 which is an invalid value for its use.
> > 
> 
> I'm being pedantic here (as usual), but I'd contrast this a bit more. The
> activity monitor code checks by itself that the ratio doesn't end up being
> 0, which is why we don't slam the brakes if the arch timer freq is < 1MHz.
> 
> It's just a CNTFRQ sanity check that goes a bit beyond the 0 value check,
> IMO.
> 

I agree, but this part was just given as an example of functionality
that relies on a reasonable arch timer rate. The AMU code checks for the
ratio not to be 0 so it does not end up breaking frequency invariance.
But if the ratio does end up being 0 due to the value of arch_time_rate,
we bypass the use of activity monitors which I'd argue it's incorrect
functionality by disabling a potential better source of information for
frequency invariance.

But I can rewrite this part for more clarity.

> > Therefore, warn if the arch timer rate is below 1MHz which contravenes
> > the recommended architecture interval of 1 to 50MHz.
> > 
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> 
> ISTR something somewhere that says the first signoff should be that of the
> author of the patch, and seeing as I just provided an untested diff that
> ought to be you :)

Will do!

Thanks,
Ionela.
