Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F599FDE84
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 14:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfKONCY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 08:02:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKONCX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 08:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KoLdEclcoHvvYVt7J9ZCX8ttqkOU2glCR7dqzQXBQMU=; b=QDM5+LEzEyrONS/b0QlQdc4Wj
        qV3yHi4kQcG48HIUUPcHLSFEtpCXcEqTGR38s6AuW70VY4uQYdBsRP1CGYCWsxS8X8jC4xe0tt84F
        TIkUumXToJooURP0sBtSY69t6xta7VRGaQZQBBqZWHq1EQ4vTIcJ0ElMAFRrTTqh92cgyhjJA3K5V
        lEOL06wbXOso5O5omYPNuzSpUKhAWkYl5D/bK46OA9OjAGPs9dskVmUD6+O2pGNwZ7VqAFtDhEIMx
        hEL2yAr1IDnWozFjemszTohqqSMmuyumNmuXkjYlVncvlE5/M/9h/MAGhAgjt5bsQd1EB3GSeh6J1
        DIx9+qEWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVbES-0007vI-Pw; Fri, 15 Nov 2019 13:01:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C6A530018B;
        Fri, 15 Nov 2019 14:00:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 363132B12DAC0; Fri, 15 Nov 2019 14:01:44 +0100 (CET)
Date:   Fri, 15 Nov 2019 14:01:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115130144.GA4097@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net>
 <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net>
 <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
 <20191115105110.GG4131@hirez.programming.kicks-ass.net>
 <CAKfTPtC3g4iCxvAJo9Km9fZ0fPSw5Jt9TY2+xF7kxGmOZ66gxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC3g4iCxvAJo9Km9fZ0fPSw5Jt9TY2+xF7kxGmOZ66gxw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 12:03:31PM +0100, Vincent Guittot wrote:

> This patch does 2 things:
> - fix the spurious call to cpufreq just before attaching a task

Right, so that one doesn't concern me too much.

> - make sure cpufreq is still called when cfs is 0 but not irq/rt or dl

But per the rq->has_blocked_load logic we would mostly stop sending
events once we reach all 0s.

Now, most of those updates will be through _nohz_idle_balance() ->
update_nohz_stats(), which are remote, which means intel_pstate is
ignoring them anyway.

Now the _nohz_idle_balance() -> update_blocked_averages() thing runs
local, and that will update the one random idle CPU we picked to run
nohz balance, but all others will be left where they were.

So why does intel_pstate care... Esp. on SKL+ with per-core P state this
is of dubious value.

Also, and maybe I should go read back, why do we care what the P state
is when we're mostly in C states anyway? These are all idle CPUs,
otherwise we wouldkn't be running update_blocked_averages() on them
anyway.


Much confusion..
