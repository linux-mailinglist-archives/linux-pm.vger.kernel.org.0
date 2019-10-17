Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D04DB082
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406259AbfJQOxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 10:53:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfJQOxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 10:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7F6OpUKlT4qeQmBMlD88GzzQdfEEND1LjxCnJ2E6AiE=; b=FDCRFT/JUi2E5d+W+sSV/sHxa
        Krw4npq0tKpYLGgHh+1EnFo9j3vTkJA9gotYSGMKvzIffDjHnFG0DuHYdO0IUQYVuXHTZdcOz7TiP
        CvKWtpnds5nAeIc/V7U51V989ngI5hze90BsE/6iBJfekmJin81f0p8Vb5Th4M4GvLkVqtlainVQT
        k0kQz+xFC14XvzXmbUV0pSuHqjz1K+M+ApB6BtzoB1MzF19F1cltTI3EGnc2XVhLE1s5PF1dMDwrd
        R8HIC/Mn5hps/tOAUOrjmXpTQNVml0C8eDWDG5F2Ad8vRamOzTrnLoPv78+gxVDVjTK0qZ4iv+qDN
        QCYlJB7kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL79Z-0002bq-C0; Thu, 17 Oct 2019 14:53:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A44F3032F8;
        Thu, 17 Oct 2019 16:52:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63B2229A4A2C2; Thu, 17 Oct 2019 16:53:22 +0200 (CEST)
Date:   Thu, 17 Oct 2019 16:53:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20191017145322.GK2311@hirez.programming.kicks-ass.net>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
 <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7edb1b73-54e7-5729-db5d-6b3b1b616064@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 03:23:04PM +0100, Douglas Raillard wrote:
> On 10/17/19 10:50 AM, Peter Zijlstra wrote:
> > Now, the thing is, we use map_util_freq() in more places, and should we
> > not reflect this increase in C for all of them? That is, why is this
> > patch changing get_next_freq() and not map_util_freq().
> > 
> > I don't think that question is answered in the Changelogs.
> > 
> > Exactly because it does change the energy consumption (it must) should
> > that not also be reflected in the EAS logic?
> 
> map_util_freq() is only used in schedutil and in EAS by compute_energy(), so
> I retarget the question at compute_energy(). It is supposed to compute
> the energy consumed by a given CPU if a given task was migrated on it.
> This implies some assumptions on util signals:
> 1) util(_est.enqueued) of the task is representative of the task's
>    duty cycle (the semantic of util is somehow blurry for aperiodic tasks
>    AFAIK).
> 2) util of the task is CPU-invariant

( we know this to be false, but do indeed make this assumption because
simplicity, taking IPC differences into account would just complicate
things more )

> 3) task util + target CPU util = new target CPU util for the
>    foreseeable future, i.e. the amount of future we can predict with
>    reasonable accuracy. Otherwise we would end up moving things around
>    all the time.
> 
> Since ramp boost is designed to be transient, integrating it
> (indirectly) in "target CPU util" will add some noise to the placement
> decision, potentially rendering it obsolete as soon as the boosting
> stops. Basing a costly decision on that does not sound like a good
> idea IMHO.

Well, we _hope_ recent past is a reasonable predictor for the near
future. We of course know it'll be complete crap every so often, but
hope that on average it is true more than false :-)

Anyway, the above seems like a sensible enough argument, and seems
worthy of being part of the Changelog. Also maybe a comment in schedutil
as to why there is a map_util_freq() modifier there.
