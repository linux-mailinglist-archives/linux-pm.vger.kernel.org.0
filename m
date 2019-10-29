Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D36E8BE2
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 16:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbfJ2Pgq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 11:36:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41504 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389836AbfJ2Pgp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 11:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W3q1hEPDjEq734wvyAniCbZ5fe1dDnGICoYFdUBg30Q=; b=AD67DtNX69rkr3VK72+eCTm/1
        VbJtW0ublnyfqj3j01o9ySArpHOfNbaqMN5/8yz1Yv0MBAP9nME2PN+Cf5+y6K6d27hGaC5KEyeoq
        eM1F4ljbsQNewvLAxPxAwWvgOZXwvR1wiKGB+kPb7PmEg4Je49PnPxdSObIP6wK8OG9zOG0PWhQkg
        9lpOhT/DrcRm6gijNLiIEggE8WUBPO7jS73/cf4BnLSkoHgU92Vz6DqFPVi1zfh+8hlSJtC8lazUN
        2LhBYOEZAwuLf7EO9Wu/kp+G9GkgmXcOBUQk8xjeH/grORd6jVzv/Vm1Jc08XCoh9TTCf4m4d8xZw
        cY/lm2AOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPTXf-0006Dy-Gr; Tue, 29 Oct 2019 15:36:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B271300E4D;
        Tue, 29 Oct 2019 16:35:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC61420D7FEFA; Tue, 29 Oct 2019 16:36:15 +0100 (CET)
Date:   Tue, 29 Oct 2019 16:36:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        'linux-kernel' <linux-kernel@vger.kernel.org>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        'Ingo Molnar' <mingo@kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Sargun Dhillon' <sargun@sargun.me>,
        'Tejun Heo' <tj@kernel.org>, 'Xie XiuQi' <xiexiuqi@huawei.com>,
        xiezhipeng1@huawei.com,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Rik van Riel' <riel@surriel.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
Message-ID: <20191029153615.GP4114@hirez.programming.kicks-ass.net>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net>
 <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201d58e68$eaa39630$bfeac290$@net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 07:55:26AM -0700, Doug Smythies wrote:

> I only know that the call to the intel_pstate driver doesn't
> happen, and that it is because cfs_rq_is_decayed returns TRUE.
> So, I am asserting that the request is not actually decayed, and
> should not have been deleted.

So what cfs_rq_is_decayed() does is allow a cgroup's cfs_rq to be
removed from the list.

Once it is removed, that cfs_rq will no longer be checked in the
update_blocked_averages() loop. Which means done has less chance of
getting false. Which in turn means that it's more likely
rq->has_blocked_load becomes 0.

Which all sounds good.

Can you please trace what keeps the CPU awake?

> Now, if we also look back at the comments for the original commit:
> 
> 	"In an edge case where temporary cgroups were leaking, this
> 	caused the kernel to consume good several tens of percents of
> 	CPU cycles running update_blocked_averages(), each run taking
> 	multiple millisecs."
> 
> To my way of thinking: Fix the leak, don't program around it; The
> commit breaks something else, so revert it.

The leak was fixed, but it still doesn't make sense to keep idle cgroups
on that list. Some people have a stupid amount of cgroups, most of which
are pointless and unused, so being able to remove them is good.

Which is why it got added back, once list management issues were sorted.
