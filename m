Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B942BFDB91
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKOKlv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 05:41:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKOKlu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 05:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IAccDbabd4kdJ+HEadLyepvJYR0lE95gi46SLtYmJXY=; b=k4Yd09/FaWg5kduhn1xEgQ/0q
        klkhrzjZ9cxOzw9iMrEsmRV7xeFNEmkxOc9eSt2Av/UAyr4i0AB0Vbsxf6+4NrwSIuBWOWqCTRTGL
        9GyGzrqNe1/JF5AfEZC7FqYHA7YBVT+m4BC39418EDhtZgIOpBWZdW5h3nDyPJ9qxB3mrf3Lpz5Nb
        Z6bVQlzFpYhYbZrLDFElJzvAi5d3qe0phAHxlgcHB7UCEtaadO5zkudpdBUTQuvFZQoD8iEgL6eyP
        CDINFP1BzXLUvJ5IxMW33CP7XOASSFP/kEj7ixgryJoZexsyWdH4FxSKQPCD96jsokyQcHYBsl3mo
        t26ncrzBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVZ26-0001Se-3T; Fri, 15 Nov 2019 10:40:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24BD4303D9F;
        Fri, 15 Nov 2019 11:39:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 388892B0BC1FC; Fri, 15 Nov 2019 11:40:52 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:40:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115104052.GF4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net>
 <CAJZ5v0hjsWM=bRg4k2qNCfcqjQ08N+6kG=1vCXpjbi5qEx7utw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hjsWM=bRg4k2qNCfcqjQ08N+6kG=1vCXpjbi5qEx7utw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 11:03:20AM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 15, 2019 at 10:55 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > So why are we making the scheduler code more ugly instead of fixing that
> > driver?
> 
> I guess we could "fix" the driver by making it rate limit MSR writes
> only, but I'm not sure if that would help.

So it is not clear to me what exactly intel_pstate needs and why. Like I
wrote in my reply to Vincent just now, it can still store the last
value, even if it doesn't act on it right away.

And it can then act on that stored value at a later event, whatever is
appropriate.

I'm just saying that generating superfluous events is silly. But
possibly I read the patch wrong.
