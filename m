Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91FFDD3B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 13:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfKOMRv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 07:17:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfKOMRv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 07:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qC9e/jFTs3ufey3dx1Bty3A4kgjYIAA6Ny/ShN4ed/8=; b=CpcoSzGCGDPB3GbYTEh6UU97c
        V7w3+PV3+ceDma25/jw1+VHnpfkq1sDj48oGfPYLcEBQ8WjPGUODe4yLxgHwFpM3L/yDG9R7dhKam
        UDnaxz6KUhU32T/ogM7YdbfSvknuR2o5P8RBKAorY+GnlWHcCvSSLEo8GZ/Rj+zgQ9xxGfbvfKBl3
        hjgY9XemUkjcmRDUXqrtVZ55GWTBYDTcQvkHFvIsHutZlWC+ZibkPX5b5+Ka/aK8ru2cDs6KdPWWI
        snPR0bff3fhAomXkloIQfih1b5SjCa1ANFQffwIs14wJAccn5DY3bRCH/y30aH9IJzTp3DTLD/I3b
        HWHv8BZVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVaXN-0007Sq-7h; Fri, 15 Nov 2019 12:17:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D69F13006FB;
        Fri, 15 Nov 2019 13:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9AD52B12BF1D; Fri, 15 Nov 2019 13:17:14 +0100 (CET)
Date:   Fri, 15 Nov 2019 13:17:14 +0100
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
Message-ID: <20191115121714.GI4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net>
 <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net>
 <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 11:46:01AM +0100, Vincent Guittot wrote:
> On Fri, 15 Nov 2019 at 11:37, Peter Zijlstra <peterz@infradead.org> wrote:

> > Sure, but then it can still remember the value passed in last and use
> > that state later.
> >
> > It doesn't _have_ to completely discard values.
> 
> yes but it means that we run at the "wrong" frequency during this
> period and also that the cpufreq must in this case set a kind of timer
> to resubmit a new frequency change out of scheduler event

It always runs at the wrong frequency. Almost per definition. We're
doing near future predictions based on recent past, and if we can only
set the hardware once every N [ms] then there's really nothing better we
can do. We'll _have_ to live with the value we 'randomly' pick at the
start of those N [ms] for the whole period.

And I'm not sure it needs to set a timer, it can simply probe the value
when we go idle, if this is the kind of system that cares about OPP on
idle.
