Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546865D381
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 17:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfGBPvW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 11:51:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBPvV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 11:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KLwUF+icpY+NvjPg4hCU2tdrBb0AljHtBhiYk13AZqw=; b=CUJnZ9HI9SeWFonIC7HtQq1TH
        r/+EJ0czLxUhbo1zSc6SyubnA2lnVcxBrH/Na7K8zabPBwzM7MLvqT5xmIolyX5Xhjem7C5no90Ze
        mEu+eBvH/JxsV4E6nhzO/ZunGmGY6gx0ybQOZjL+Rney6LOhL5j3zu7Ce5c7JbGneVozT0kNJ1Agk
        sr5MqZEEpgJ7gy54PvuRHzdIdQBP+a02Itwda7W1+ZPtIe3JZ8AXY9YGDANy6SRVetoOhLwulyQiw
        uoBYP6L54Igt22rOLYPvUgOaaX62fT1gHZVlu6mlcUjTPBpzNz7PGMjX32dWuhsso1Z/sU7t4u96F
        lRhPQ6cDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiL3t-0003Zu-Dg; Tue, 02 Jul 2019 15:51:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1199203C694A; Tue,  2 Jul 2019 17:51:15 +0200 (CEST)
Date:   Tue, 2 Jul 2019 17:51:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, patrick.bellasi@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH v2 0/5] sched/cpufreq: Make schedutil energy aware
Message-ID: <20190702155115.GW3436@hirez.programming.kicks-ass.net>
References: <20190627171603.14767-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627171603.14767-1-douglas.raillard@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 27, 2019 at 06:15:58PM +0100, Douglas RAILLARD wrote:
> Make schedutil cpufreq governor energy-aware.
> 
> - patch 4 adds sugov_cpu_ramp_boost() function.
> - patch 5 updates sugov_update_(single|shared)() to make use of
>   sugov_cpu_ramp_boost().
> 
> The benefits of using the EM in schedutil are twofold:

> 2) Driving the frequency selection with power in mind, in addition to
>    maximizing the utilization of the non-idle CPUs in the system.

> Point 2) is enabled in
> "sched/cpufreq: Boost schedutil frequency ramp up". It allows using
> higher frequencies when it is known that the true utilization of
> currently running tasks is exceeding their previous stable point.
> The benefits are:
> 
> * Boosting the frequency when the behavior of a runnable task changes,
>   leading to an increase in utilization. That shortens the frequency
>   ramp up duration, which in turns allows the utilization signal to
>   reach stable values quicker.  Since the allowed frequency boost is
>   bounded in energy, it will behave consistently across platforms,
>   regardless of the OPP cost range.
> 
> * The boost is only transient, and should not impact a lot the energy
>   consumed of workloads with very stable utilization signals.

So you're allowing a higher pick when the EWMA exceeds the enqueue
thing.

This then obviously has relation to Patrick's patch that makes the EWMA
asymmetric, but I'm thinking that the interaction is mostly favourable?

I'm not immediately seeing how it is transient; that is, PELT has a
wobble in it's steady state, is that accounted for?
