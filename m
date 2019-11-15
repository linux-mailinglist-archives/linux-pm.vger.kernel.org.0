Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD2CFE63E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 21:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKOUNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 15:13:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfKOUNk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 15:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U04AK+OppLVeV3O4pLzN/YFK2FxmH5fvNNCh3MF92IY=; b=KLlt0GWj6whouRd+kp6oFHl+D
        Ej7uCVDEWwpmYgi1CuUy5ZPt4CSESoygcANnBUp+FylIfcx8PPNchrIElja8DG5PgRxvTVxbva91r
        eXKYgGugBmZsrVp6eYvXJVghy/Al6Zlc+5vATGmz4ksfuLstcAJUN4KPT7X6gKQX3XM7OumtCivB9
        jjTOxs1YffJtEKFKN3WoQTSR3DgCKKD1PMXpnOuoivG3gFMtKoZ+bOz0n04eMOKAERlQglZB6/UBZ
        F5vqDh1JcH1j8bmCDBNyEI+n9Xyv0bz0OA+0bZWU07VL5bkLBDDR3bBrFZUmR5/l7AdkRgBQdqvFE
        ryAGRW+eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVhxm-00048n-Ot; Fri, 15 Nov 2019 20:13:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0A3C3056C8;
        Fri, 15 Nov 2019 21:11:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECE222B12EE0A; Fri, 15 Nov 2019 21:12:56 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:12:56 +0100
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
Message-ID: <20191115201256.GQ4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115132520.GJ4131@hirez.programming.kicks-ass.net>
 <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
 <20191115151220.GO4131@hirez.programming.kicks-ass.net>
 <CAKfTPtCg-zEysYmGSFTa4bjh0D=sf1UsT0WpeWcVrb9SLt+VZw@mail.gmail.com>
 <20191115174355.GP4131@hirez.programming.kicks-ass.net>
 <CAKfTPtAKz5zGwyNUtEeM+2JJNBNVnoKmFkXdFu1hjWD52_BwFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAKz5zGwyNUtEeM+2JJNBNVnoKmFkXdFu1hjWD52_BwFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 07:00:45PM +0100, Vincent Guittot wrote:
> On Fri, 15 Nov 2019 at 18:44, Peter Zijlstra <peterz@infradead.org> wrote:

> > Because we don't care about the rt,dl,irq decay anywhere else either. We
> > only call cpufreq_update_util() for rq->cfs changes.
> 
> cpufreq_update_util is called for each enqueue/dequeue of rt/dl tasks

Oh indeed.. OK, so then I suppose rt,dl,cfs makes some sense.

Let me sleep on it.
