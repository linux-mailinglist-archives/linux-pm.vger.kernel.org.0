Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECFADAF44
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394721AbfJQOLf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 10:11:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53812 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfJQOLf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 10:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Th37Qhz4w+8rDn8hj1nGSF7iCLduKVxIPDbgodx/X/4=; b=wHx9JLYh7xxzrCE7aqoGH3Fua
        QJwrcFlGlCUohbrngB+NjEyamPTc7mGtxcwvweVcZtx/XIKutLSD2ogm5yfjvxwOlExfn1Jw57DVr
        BS0TKGjt2rZ5Rgyas5jzkO/yfFW5tINKeBYMjxXRkVzaw6P8983Uzaxf3YDokJ6nowjkD7N6Xhpgh
        pfHLicvC/usacRbdA5TZ0xLZmgSTWep4okwXXMs3ltxeu4QKVaH0H83SAR/RIzeQhQnO/kJbKFkmj
        56DsB87diY/jsLgpZ2wu2DAM5jknuVIeO2NHFsgBo+OtModaz001PH25OyaDS0p5l4YImq0V4KSST
        YHSUK7p+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL6Ug-0000JA-Qc; Thu, 17 Oct 2019 14:11:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 295513032F8;
        Thu, 17 Oct 2019 16:10:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FF8D203BFA9E; Thu, 17 Oct 2019 16:11:07 +0200 (CEST)
Date:   Thu, 17 Oct 2019 16:11:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Douglas Raillard <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20191017141107.GJ2311@hirez.programming.kicks-ass.net>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
 <20191017111116.GA27006@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017111116.GA27006@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 12:11:16PM +0100, Quentin Perret wrote:
> On Thursday 17 Oct 2019 at 11:50:15 (+0200), Peter Zijlstra wrote:
> > Now, the thing is, we use map_util_freq() in more places, and should we
> > not reflect this increase in C for all of them? That is, why is this
> > patch changing get_next_freq() and not map_util_freq().
> > 
> > I don't think that question is answered in the Changelogs.
> > 
> > Exactly because it does change the energy consumption (it must) should
> > that not also be reflected in the EAS logic?
> 
> Right that shouldn't hurt and keep things consistent. That probably
> won't have a huge impact in practice (the boost should be != 0 only when
> the util signals haven't converged IIUC, which is a case where the EAS
> calculation is already 'wrong' anyway), but that still feels like the
> right thing to do.

It only boosts when 'rq->cfs.avg.util' increases while
'rq->cfs.avg.util_est.enqueued' remains unchanged (and util > util_est
obv).

This condition can be true for select_task_rq_fair(), because that is
ran before we do enqueue_task_fair() (for obvious raisins).

> > I'm still thinking about the exact means you're using to raise C; that
> > is, the 'util - util_est' as cost_margin. It hurts my brain still.
> 
> +1 ...

cost_i = capacity_i / power_i ; for the i-th OPP

We then do: 'x = util - util_avg' and use that on the first
OPP >= min_freq:

	cost(x) = cost_j + cost_j * x ; freq_j >= min_freq
	        = cost_j * (1 + x)

And then we find the highest OPP that has:

	cost_k <= cost(x)

Now, 'P = C*V^2*f', which under 'V ~ f' turns into 'P ~ f^3'.

(this assumption is important because we don't have V_i, but know that
when f increases, V also increases and the linear relation is the
simplest)

This then gives us:

	capacity_i = f_i / f_max
	power_i ~ f_i ^ 3
	cost_i = capacity_i / power_i
	       ~ (f_i / f_max) / f_i^3
	       ~ 1 / (f_max * f_i^2)

(your changelog already called if efficiency, but then went on calling
it cost; as per the above, you see that higher frequencies have lower
efficiency, as expected)

cost(x) then turns into something like:

	cost(x) = cost_j * (1 + x)
	        ~ (1 + x) / (f_max * f_j^2)

We then get the following equation (assuming inf. OPPs):

	cost_k = cost(x)

	1 / (f_max * f_k^2) = (1 + x) / (f_max * f_j^2)

From which we can solve f_k:

	f_k = f_j / sqrt(1 + x) ; x = util - util_est

Which, given positive 'x' results in f_k < f_j, IOW. we're selecting a
lower frequency.

Given that 'cost' really is efficiency, and we've made the equations
about selecting a higher efficiency, that makes sense in so far that it
would always end up at the knee in the graph (our most efficient OPP).

Is this really what we're wanting to do?
