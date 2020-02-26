Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF09816FBE9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgBZKWN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 05:22:13 -0500
Received: from foss.arm.com ([217.140.110.172]:33336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgBZKWN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Feb 2020 05:22:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891421FB;
        Wed, 26 Feb 2020 02:22:12 -0800 (PST)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A7F23F9E6;
        Wed, 26 Feb 2020 02:22:12 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:22:10 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/7] arm64: use activity monitors for frequency
 invariance
Message-ID: <20200226102210.GB19513@arm.com>
References: <20200224141142.25445-1-ionela.voinescu@arm.com>
 <20200224141142.25445-7-ionela.voinescu@arm.com>
 <20200226095134.GM28029@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226095134.GM28029@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pavan,

On Wednesday 26 Feb 2020 at 15:21:34 (+0530), Pavan Kondeti wrote:
> On Mon, Feb 24, 2020 at 02:11:41PM +0000, Ionela Voinescu wrote:
> 
> [...]
> 
> > +static int __init init_amu_fie(void)
> > +{
> > +	cpumask_var_t valid_cpus;
> > +	bool have_policy = false;
> > +	int cpu;
> > +
> > +	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL) ||
> > +	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
> > +		return -ENOMEM;
> 
> The patch looks good to me. one minor comment here. In an unlikely
> scenario, valid_cpus which is a temporary mask can get allocated
> but amu_fie_cpus may not. In that case, we have to free valid_cpus
> here. I have seen some static code inspection tools catching these
> type of errors. If you happen to rebase this series, fix this.
> 

Thank you for the review!

I am just about to push v5 and I'll add this fix as well.

Thank you,
Ionela.

> Thanks,
> Pavan
> 
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
