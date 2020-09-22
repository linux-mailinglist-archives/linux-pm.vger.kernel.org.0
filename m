Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B8A274690
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVQZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 12:25:42 -0400
Received: from foss.arm.com ([217.140.110.172]:46736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVQZm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Sep 2020 12:25:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2124E101E;
        Tue, 22 Sep 2020 09:25:42 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5BB43F718;
        Tue, 22 Sep 2020 09:25:41 -0700 (PDT)
Date:   Tue, 22 Sep 2020 17:25:40 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq,cppc: fix issue when hotplugging out policy->cpu
Message-ID: <20200922162540.GB796@arm.com>
References: <20200903111955.31029-1-ionela.voinescu@arm.com>
 <20200904050604.yoar2c6fofcikipp@vireshk-i7>
 <20200904094303.GA10031@arm.com>
 <20200907061154.iiyaq4m3vjtrlkp4@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907061154.iiyaq4m3vjtrlkp4@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Sorry for the delay, I just got back from holiday as well.

On Monday 07 Sep 2020 at 11:41:54 (+0530), Viresh Kumar wrote:
> On 04-09-20, 10:43, Ionela Voinescu wrote:
> > Do you know why it was designed this way in the first place?
> 
> No.
> 
> > I assumed it was designed like this (per-cpu cppc_cpudata structures) to
> > allow for the future addition of support for the HW_ALL CPPC coordination
> > type. In that case you can still have PSD (dependency) domains but the
> > desired performance controls would be per-cpu, with the coordination
> > done in hardware/firmware. So, in the HW_ALL case you'd end up having
> > different performance controls even for CPUs in the same policy.
> > Currently the CPPC driver only supports SW_ANY which is the traditional
> > cpufreq approach.
> 
> Then the person who would add that feature will take care of fixing the issues
> then. We should make sure we handle the current use-case optimally. And a
> per-cpu thing isn't working well for that.
> 

Okay, I'll follow your lead and remove the per-cpu structures.

Thanks,
Ionela.

> -- 
> viresh
