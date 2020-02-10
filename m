Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F76157A4D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 14:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgBJNVr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 08:21:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48602 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbgBJNVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 08:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xtst/Oq1oI0Mc3uxXACsXifgp1sZOBCOF/8SXmhWFbU=; b=OWUhVqzOzsNBs/VxwAiUkYkisS
        ANl9xWDktCLfJWIUnrLzpc5Nc6BIWG+NnTcfdsDfnSyEwN0ZyFB6rUsIYqwr6fpSTPM8kyOcPNFCw
        gu1aG3yEm539cIEqBjg3YShylkM1uWuTytDsW+rCr8oIyWm+74ol0XLfgcr41K590o52DDMCZxer6
        3p6lvXKKZioY8CuLEv5puOfPiXdHLp0LJNEvQzTSufezgllwRJS+FofnS50UNcYUSq8aUl44LH+5a
        RSDFDW/5DT4drTia+IN00hGkYjK1F0Re40QzQlRBQfhhkqORw4+fdSImqUq/L/GHHHGxuXnmc2eTC
        CMpG5XXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j190J-0006Rp-AN; Mon, 10 Feb 2020 13:21:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 194E030066E;
        Mon, 10 Feb 2020 14:19:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5661420148931; Mon, 10 Feb 2020 14:21:33 +0100 (CET)
Date:   Mon, 10 Feb 2020 14:21:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20200210132133.GH14897@hirez.programming.kicks-ass.net>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <c49ca012-bb3e-580d-9b45-359caa67d7c1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49ca012-bb3e-580d-9b45-359caa67d7c1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 22, 2020 at 06:14:24PM +0000, Douglas Raillard wrote:
> Hi Peter,
> 
> Since the v3 was posted a while ago, here is a short recap of the hanging
> comments:
> 
> * The boost margin was relative, but we came to the conclusion it would make
>   more sense to make it absolute (done in that v4).

As per (patch #1):

+       max_cost = pd->table[pd->nr_cap_states - 1].cost;
+       cost_margin = (cost_margin * max_cost) / EM_COST_MARGIN_SCALE;

So we'll allow the boost to double energy consumption (or rather, since
you cannot go above the max OPP, we're allowed that).

> * The main remaining blur point was why defining boost=(util - util_est) makes
>   sense. The justification for that is that we use PELT-shaped signal to drive
>   the frequency, so using a PELT-shaped signal for the boost makes sense for the
>   same reasons.

As per (patch #4):

+       unsigned long boost = 0;

+       if (util_est_enqueued == sg_cpu->util_est_enqueued &&
+           util_avg >= sg_cpu->util_avg &&
+           util_avg > util_est_enqueued)
+               boost = util_avg - util_est_enqueued;

The result of that is not, strictly speaking, a PELT shaped signal.
Although when it is !0 the curves are similar, albeit offset.

> AFAIK there is no specific criteria to meet for frequency selection signal shape
> for anything else than periodic tasks (if we don't add other constraints on
> top), so (util - util_est)=(util - constant) seems as good as anything else.
> Especially since util is deemed to be a good fit in practice for frequency
> selection. Let me know if I missed anything on that front.


Given:

  sugov_get_util() <- cpu_util_cfs() <- UTIL_EST ? util_est.enqueued : util_avg.

our next_f becomes:

  next_f = 1.25 * util_est * max_freq / max;

so our min_freq in em_pd_get_higher_freq() will already be compensated
for the offset.

So even when:

  boost = util_avg - util_est

is small, despite util_avg being huge (~1024), due to large util_est,
we'll still get an effective boost to max_cost ASSUMING cs[].cost and
cost_margin have the same curve.

They have not.

assuming cs[].cost ~ f^3, and given our cost_margin ~ f, that leaves a
factor f^2 on the table.

So the higher the min_freq, the less effective the boost.

Maybe it all works out in practise, but I'm missing a big picture
description of it all somewhere.

