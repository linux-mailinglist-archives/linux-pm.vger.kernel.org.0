Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F54296A0C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 09:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375545AbgJWHEQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375543AbgJWHEQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 03:04:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24EAC0613CE;
        Fri, 23 Oct 2020 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kHLq63/v8RTZ3ythdp0rVyTOykDNXkcng3smpcAygcQ=; b=HsM/DV+CQDLD6twAWvr892BZKS
        WHNP8Zr9MOR0pKFrlOLp03+oKGku0Q5RRVSzCv13HEd6wWR/TogP6/kEaAdle+d0qg98SVMv8lXyz
        L9IF4j3SotzEOJjTQI5723pBaTlGI93wuNktj8swl9eE6ALFaOyeYayhjFEYN1mzpV6RGN6fDFT1D
        +/XubHt1bx0pPG5oTYVAWYm+TFD9lEjLVtyuwIpZ6DFveq1cEKD3SHD3mjBlo3hQ9NSrT8nQ1dgTn
        PcO5YCzKAq5qYnv7G2ZEiVc3NNaQ18UsQVyq0nVMsVwUhiYVt/lMBgSs/WX+E9cKE+UnWaaS+1gOd
        yulitPOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVr6Z-0007DE-8C; Fri, 23 Oct 2020 07:03:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B65FF304D28;
        Fri, 23 Oct 2020 09:03:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A49702B7729AE; Fri, 23 Oct 2020 09:03:10 +0200 (CEST)
Date:   Fri, 23 Oct 2020 09:03:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, thomas.lendacky@amd.com,
        puwen@hygon.cn, yazen.ghannam@amd.com, kim.phillips@amd.com,
        suravee.suthikulpanit@amd.com
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
Message-ID: <20201023070310.GK2611@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
 <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de>
 <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
 <1603397435.16275.45.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603397435.16275.45.camel@suse.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 10:10:35PM +0200, Giovanni Gherdovich wrote:
> * for the AMD EPYC machines we haven't yet implemented frequency invariant
>   accounting, which might explain why schedutil looses to ondemand on all
>   the benchmarks.

Right, I poked the AMD people on that a few times, but nothing seems to
be forthcoming :/ Tom, any way you could perhaps expedite the matter?

In particular we're looking for some X86_VENDOR_AMD/HYGON code to run in

  arch/x86/kernel/smpboot.c:init_freq_invariance()

The main issue is finding a 'max' frequency that is not the absolute max
turbo boost (this could result in not reaching it very often) but also
not too low such that we're always clipping.

And while we're here, IIUC AMD is still using acpi_cpufreq, but AFAIK
the chips have a CPPC interface which could be used instead. Is there
any progress on that?
