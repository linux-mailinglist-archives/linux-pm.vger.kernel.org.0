Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B39DBF90
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfJRIME (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 04:12:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfJRIME (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 04:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tA/jFxjvIHq0tQ9bAEhe6lZyldnVuvn0ypIwLrAbRC8=; b=X4HC/htEf84+RawY1Xmok8qZZ
        nfVykWThT6oMbX6rJ8l2fPLcdqiZz4H2ZFz5IaEHEPBZSFq1P6vOUyMi+8II/FXRzscg4tVV5PSfK
        QmkF7NRenb8zMCgnJAWWdyH53N7T7lXnyQ7Jr2JDim2G9FsS0EvtTIKSt66v5LSThomRjm0DCACcC
        atVs2UPy2xqCs+jUEGsHepUH8kz+iCrb2e5dNXNwV3tIgKGPQ0VnQ0LD0K9hoPnPlMyZBOrZvryV4
        WuNIA0usVXeywej/s7pTKU2QM1tt7BqTD/NXyww5x5nIraTE2nkj98LzZy2QFnE9K0Z1HR7wQXQoY
        nclXpC0JA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLNMZ-0001bB-Lx; Fri, 18 Oct 2019 08:11:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 000E630018A;
        Fri, 18 Oct 2019 10:10:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2F99200DE9FA; Fri, 18 Oct 2019 10:11:53 +0200 (CEST)
Date:   Fri, 18 Oct 2019 10:11:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Douglas Raillard <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        qperret@qperret.net, patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: Re: [RFC PATCH v3 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20191018081153.GE2328@hirez.programming.kicks-ass.net>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191014145315.GZ2311@hirez.programming.kicks-ass.net>
 <a1ce67d7-62c3-b78b-1d87-23ef4dbc2274@arm.com>
 <20191017095015.GI2311@hirez.programming.kicks-ass.net>
 <20191017111116.GA27006@google.com>
 <20191017141107.GJ2311@hirez.programming.kicks-ass.net>
 <2cbde0fe-c10c-0ebb-32ef-2d522986bc89@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbde0fe-c10c-0ebb-32ef-2d522986bc89@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 09:44:44AM +0200, Dietmar Eggemann wrote:
> On 17/10/2019 16:11, Peter Zijlstra wrote:
> > On Thu, Oct 17, 2019 at 12:11:16PM +0100, Quentin Perret wrote:
> 
> [...]
> 
> > It only boosts when 'rq->cfs.avg.util' increases while
> > 'rq->cfs.avg.util_est.enqueued' remains unchanged (and util > util_est
> > obv).
> > 
> > This condition can be true for select_task_rq_fair(), because that is
> > ran before we do enqueue_task_fair() (for obvious raisins).
> > 
> >>> I'm still thinking about the exact means you're using to raise C; that
> >>> is, the 'util - util_est' as cost_margin. It hurts my brain still.
> >>
> >> +1 ...
> > 
> > cost_i = capacity_i / power_i ; for the i-th OPP
> 
> I get confused by this definition. efficiency=capacity/power but the
> cs->cost value used in em_pd_get_higher_freq() is defined as
> 
> cs_cost = cs->power * cpu_max_freq / cs->freq [energy_model.h]

	cost_i = power_i * f_max / f_i

	cost(x) = cost_j * (1 + x) ; f_j >= min_freq

	cost_k <= cost(x)

	P = C*V^2*f, V ~ f -> P ~ f^3

	cost_i ~ f_i^3 * f_max / f_i
	       = f_i^2 * f_max

	cost(x) = (1 + x) * f_j^2 * f_max

	cost_k = cost(x)

	f_k^2 * f_max = (1 + x) * f_j^2 * f_max

	f_k = sqrt(1 + x) * f_j

Which does indeed make more sense... However, I still struggle with
using our 'x = util - util_est' as input for an OPP specific increase.

