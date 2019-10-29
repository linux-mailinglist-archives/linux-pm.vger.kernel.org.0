Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3EE8D44
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfJ2QuU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:50:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfJ2QuT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fIL1Adi28JKakaN1g7A5cYvjz9S3B/LlVrClKBzVNUg=; b=iR7KWdeGJ6IKWizwsGIN/qDyH
        Iq2kpS0o/8rrl2nt3rTN/6xKl4OxrDkSkRONXz7hN0Q5XuRL7bPWhk5Ec3m6vtBjK2MyUctCR7aC8
        fy7uhV1Xb+TmfITt4SsPvh3020vahab8yY7Rb4d1Lx2PfPctOLd5ZftqcN5zNXu7dPhh7/ZoYtPvq
        x4pSxhTwC5zi7fDBsH3xpiFm04YIcmY4Si8+N/dAR7yYCqDlXmWwobDpJLNyi6DrmYejBpHNXBSh6
        ufrdVRopDyOJ+gaFv2PbzLBCi2zcR3C6V85u0ZdcEUKweJVel8uQjHFgujopMFFw5ctVRdwoPfwBK
        b2Vht7r6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPUgx-0008Vu-Dk; Tue, 29 Oct 2019 16:49:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BA86300E4D;
        Tue, 29 Oct 2019 17:48:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C957C20D7FEFA; Tue, 29 Oct 2019 17:49:55 +0100 (CET)
Date:   Tue, 29 Oct 2019 17:49:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
Message-ID: <20191029164955.GO4131@hirez.programming.kicks-ass.net>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net>
 <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net>
 <20191029153615.GP4114@hirez.programming.kicks-ass.net>
 <CAKfTPtD79VE+gqffpBAGd39bJKe7ao+jbmVSQ7PtS=dky0Wx6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD79VE+gqffpBAGd39bJKe7ao+jbmVSQ7PtS=dky0Wx6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 05:20:56PM +0100, Vincent Guittot wrote:
> On Tue, 29 Oct 2019 at 16:36, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 29, 2019 at 07:55:26AM -0700, Doug Smythies wrote:
> >
> > > I only know that the call to the intel_pstate driver doesn't
> > > happen, and that it is because cfs_rq_is_decayed returns TRUE.
> > > So, I am asserting that the request is not actually decayed, and
> > > should not have been deleted.
> >
> > So what cfs_rq_is_decayed() does is allow a cgroup's cfs_rq to be
> > removed from the list.
> >
> > Once it is removed, that cfs_rq will no longer be checked in the
> > update_blocked_averages() loop. Which means done has less chance of
> > getting false. Which in turn means that it's more likely
> > rq->has_blocked_load becomes 0.
> >
> > Which all sounds good.
> >
> > Can you please trace what keeps the CPU awake?
> 
> I think that the sequence below is what intel pstate driver was using
> 
> rt/dl task wakes up and run for some times
> rt/dl pelt signal is no more null so periodic decay happens.
> 
> before optimization update_cfs_rq_load_avg() for root cfs_rq was
> called even if pelt was null,
> which calls cfs_rq_util_change,  which calls intel pstate
> 
> after optimization its no more called.

Not calling cfs_rq_util_change() when it doesn't change, seems like the
right thing. Why would intel_pstate want it called when it doesn't
change?
