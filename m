Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED525D556
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 11:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgIDJnG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 05:43:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbgIDJnF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Sep 2020 05:43:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CC09101E;
        Fri,  4 Sep 2020 02:43:05 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D07703F66F;
        Fri,  4 Sep 2020 02:43:04 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:43:03 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq,cppc: fix issue when hotplugging out policy->cpu
Message-ID: <20200904094303.GA10031@arm.com>
References: <20200903111955.31029-1-ionela.voinescu@arm.com>
 <20200904050604.yoar2c6fofcikipp@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904050604.yoar2c6fofcikipp@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Friday 04 Sep 2020 at 10:36:04 (+0530), Viresh Kumar wrote:
[..]
> >  /* Per CPU container for runtime CPPC management. */
> >  struct cppc_cpudata {
> > -	int cpu;
> >  	struct cppc_perf_caps perf_caps;
> >  	struct cppc_perf_ctrls perf_ctrls;
> >  	struct cppc_perf_fb_ctrs perf_fb_ctrs;
> 
> With the way things are designed, I believe this is one of the bugs
> out of many.
> 
> The structure cppc_cpudata must be shared across all CPUs of the same
> policy, so they all end up using the same set of values for different
> variables. i.e. it shouldn't be a per-cpu thing at all. Just allocate
> it from cpufreq_driver->init and store in policy->driver_data for use
> elsewhere.
> 
> That would be a proper fix IMO, we just avoided one of the bugs here
> otherwise.
> 

Do you know why it was designed this way in the first place?

I assumed it was designed like this (per-cpu cppc_cpudata structures) to
allow for the future addition of support for the HW_ALL CPPC coordination
type. In that case you can still have PSD (dependency) domains but the
desired performance controls would be per-cpu, with the coordination
done in hardware/firmware. So, in the HW_ALL case you'd end up having
different performance controls even for CPUs in the same policy.
Currently the CPPC driver only supports SW_ANY which is the traditional
cpufreq approach.

Thanks,
Ionela.


> -- 
> viresh
