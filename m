Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042B9253F99
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 09:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgH0HwA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 03:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgH0Hv7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 03:51:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B48C06121A
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 00:51:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nv17so2198279pjb.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nEgSkOnQVowlRg8aJq/sPnEcD4QVcMS1v4xhvA6PlCM=;
        b=EYirg6C7hRhga4JHwj7dQ51KEztrDfJFHCgYxpdruO6UOpC5PeDkQskBet3WbGLyL1
         jQbeWDPPVUwjTDwQkJwXtUYZf3408aPgEU9GOO3lindTYBTXieyB+/tMGTBsmZOAGn1I
         u7Ny9ZZmX+2IK+IA2zbdyf9z4R2gjWJRVQECbKNuboRa3dAiGQTOfVWGPpH6Pp2XAWO+
         EoomPbu+pH4oJLb9WN68j2HJMI5Ct0dbEowqFybc6EKLwGKxm3DyQHZDXBxqW+Q+nDVJ
         RzFVv1ervqCN2BheNq+FWB+3pSyNIr4soPTxNwWEA3jXBf6nx/I3M6R3b5v9hRnJJJbk
         zhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nEgSkOnQVowlRg8aJq/sPnEcD4QVcMS1v4xhvA6PlCM=;
        b=RwFJDLxiNWDfpn3VRCiM/JD7i8u/UmL68ukIq0RoeLmMNsLzckzhudO36PwLlkMQr9
         b8tDswnrY4VmjYR0gY7XUgO4kFqelfY/Vepk5IHDrJEkgZPzVj3S7R3z0Nxsa7/mnxaj
         B0nhOTSe2jV5oBkTTuY4Kb6VAEfcJd0nk2H1brfx1ensNbgWo8qDiKJMAzBaElXnR7OE
         3O6gXcAOoDdKomFVPSRcjVky5WllOZkLRt4Ca5x7v5NBM2Wj5acdDYe/ng9a6fGuRxR6
         9f1dX5I3UW7wfZHtD2zBFWnyllwI+up1MitZPHd19JrJGNs4O3NoK+3npdrdSsE3G+Sm
         9HKA==
X-Gm-Message-State: AOAM530ur0/S2n6bQ2e9qAqWRj9VNX+vSGrpzurIEvIReKPEBtew/xbB
        w7vswgxRaMZ7Z6oeEMcAWnez4w==
X-Google-Smtp-Source: ABdhPJzGR5h3rUT3IAa1vnEBkFFhvrwXi7Kf613HiN1Wso4tsYRDk4ieaA/Qni9CcfJ01/8k5MOPDQ==
X-Received: by 2002:a17:90a:68c7:: with SMTP id q7mr9995445pjj.211.1598514712523;
        Thu, 27 Aug 2020 00:51:52 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id u3sm1248463pjn.29.2020.08.27.00.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 00:51:51 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:21:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Message-ID: <20200827075149.ixunmyi3m6ygtehu@vireshk-i7>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
 <20200709124349.GA15342@arm.com>
 <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
 <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
 <20200825095629.GA15469@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825095629.GA15469@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-08-20, 10:56, Ionela Voinescu wrote:
> I've been putting some more thought/code into this one and I believe
> something as follows might look nicer as well as cover a few corner cases
> (ignore implementation details for now, they can be changed):

I saw the other patchset you sent where AMU can be used as the backend
for CPPC driver, which means that if AMU IP is present on the platform
it will be used by the CPPC to get the perf counts, right ?

> - Have a per cpu value that marks the use of either AMUs, CPPC, or
>   cpufreq for freq invariance (can be done with per-cpu variable or with
>   cpumasks)
> 
> - arch_topology.c: initialization code as follows:
> 
> 	for_each_present_cpu(cpu) {
> 		if (freq_inv_amus_valid(cpu) &&
> 		    !freq_inv_set_max_ratio(cpufreq_get_hw_max_freq(cpu) * 1000,
> 					    arch_timer_get_rate(), cpu)) {
> 			per_cpu(inv_source, cpu) = INV_AMU_COUNTERS;
> 			continue;
> 		}
> 		if (freq_inv_cppc_counters_valid(cpu) &&
> 		    !freq_inv_set_max_ratio(cppc_max_perf, cppc_ref_perf, cpu)) {
> 			per_cpu(inv_source, cpu) = INV_CPPC_COUNTERS;
> 			continue;
> 		}
> 		if (!cpufreq_supports_freq_invariance() ||
> 		    freq_inv_set_max_ratio(cpufreq_get_hw_max_freq(cpu),
> 					   1, cpu)) {
> 			pr_info("FIE disabled: no valid source for CPU%d.", cpu);
> 			return 0;
> 		}
> 	}

Based on that (your other patchset), I think this can get further
simplified to whomsoever can register first for freq invariance.

i.e. if CPPC registers for it first then there is no need to check
AMUs further (as CPPC will be using AMUs anyway), else we will
fallback to AMU, else cpufreq.

Is that understanding correct ?

-- 
viresh
