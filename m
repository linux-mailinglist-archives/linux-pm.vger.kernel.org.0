Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD1D2961A4
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901434AbgJVPZs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901438AbgJVPZm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 11:25:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34FCC0613CE;
        Thu, 22 Oct 2020 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uNiU3efnTwPeAKOY4UJUGM46GfdX/X2ngekQQHB4va8=; b=SR5PUoAVNy8wU0ea/eyb0/kUYU
        53hX/8NiDEWA0ZcRxmxtqRpgpbNnip2BBnOrXY8+9D7Q8oIpeDgt4npEjXf+5wVqGyqFySUkSERco
        6x7Vc5LmIzk5Us32wJWXaYLn+n7D79f9u5o/K9QPn0IB9dBAUNeawLiJoH7nCGoS7IYkCN46k3q5e
        Xf09A4bKmOQxGUw89OpsbvyTa1O3FSlcXxEvdaJZrek5lRBKG+ywveYoL6iQ3yu9uwjAEVRMzTk4c
        tSdHzC1BRqBjPk2hEZZAlbtX2TubM8HeFx7vhQR43uVLFRney+3dZXlI9m18+FQQNPxhiU1EHyJQi
        4YvhkQvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVcSq-0006or-2N; Thu, 22 Oct 2020 15:25:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86DE03010D2;
        Thu, 22 Oct 2020 17:25:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DA02203D0835; Thu, 22 Oct 2020 17:25:14 +0200 (CEST)
Date:   Thu, 22 Oct 2020 17:25:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
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
        Len Brown <len.brown@intel.com>
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
Message-ID: <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
 <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022145250.GK32041@suse.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 03:52:50PM +0100, Mel Gorman wrote:

> There are some questions
> currently on whether schedutil is good enough when HWP is not available.

Srinivas and Rafael will know better, but Intel does run a lot of tests
and IIRC it was found that schedutil was on-par for !HWP. That was the
basis for commit:

  33aa46f252c7 ("cpufreq: intel_pstate: Use passive mode by default without HWP")

But now it turns out that commit results in running intel_pstate-passive
on ondemand, which is quite horrible.

> There was some evidence (I don't have the data, Giovanni was looking into
> it) that HWP was a requirement to make schedutil work well.

That seems to be the question; Rafael just said the opposite.

> For distros, switching to schedutil by default would be nice because
> frequency selection state would follow the task instead of being per-cpu
> and we could stop worrying about different HWP implementations but it's

s/HWP/cpufreq-governors/ ? But yes.

> not at the point where the switch is advisable. I would expect hard data
> before switching the default and still would strongly advise having a
> period of time where we can fall back when someone inevitably finds a
> new corner case or exception.

Which is why I advocated to make it 'difficult' to use the old ones and
only later remove them.

> For reference, SLUB had the same problem for years. It was switched
> on by default in the kernel config but it was a long time before
> SLUB was generally equivalent to SLAB in terms of performance.

I remember :-)

