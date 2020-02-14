Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C345815D748
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgBNMVe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 07:21:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgBNMVe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 07:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q/Mx/kZS/5BXh5u8pbLrsFR1GPA1vP9LOyYFjWibc6E=; b=HtlEeUgwqsb/n49MjQL2vF0eFo
        ps0bfM5FkwtI+QymKik7diKuJembZxKn2vBmiPY7bmeNpTqx5YX1Nrbz+xJ4XdZ5UGhY8JN+efdfC
        RPidqxgAi/Sv5TKel673fEMOfa4QxYFvDWwJhJb8YBRPrUS67fzRCBfi0yJq/Lx9utSn3agfVu2f6
        0Dqj/DcMGE4uv7PKdoubwA/wZygzuNP+72VpZa5tJ5Pymw7a68IgdFm1y7q0g1u2iy7n2stWeybMo
        D9y2zlOfi346S7i0UQWRlb1sESN4Ux7pNucw8Xf0/Hg8085XOKB+Fm7gBDTknOIahi9M0YxAteqkM
        ACZcAzAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2ZyE-00028o-Eh; Fri, 14 Feb 2020 12:21:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D05F430257C;
        Fri, 14 Feb 2020 13:19:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA08D20206D87; Fri, 14 Feb 2020 13:21:19 +0100 (CET)
Date:   Fri, 14 Feb 2020 13:21:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/6] sched/cpufreq: Make schedutil energy aware
Message-ID: <20200214122119.GK14879@hirez.programming.kicks-ass.net>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <c49ca012-bb3e-580d-9b45-359caa67d7c1@arm.com>
 <20200210132133.GH14897@hirez.programming.kicks-ass.net>
 <4a664419-f5a6-882f-83ee-5bbf20ff33d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a664419-f5a6-882f-83ee-5bbf20ff33d3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 05:49:48PM +0000, Douglas Raillard wrote:

> > So even when:
> > 
> >   boost = util_avg - util_est
> > 
> > is small, despite util_avg being huge (~1024), due to large util_est,
> > we'll still get an effective boost to max_cost ASSUMING cs[].cost and
> > cost_margin have the same curve.
> 
> I'm not sure to follow, cs[].cost can be plotted against cs[].freq, but
> cost_margin is a time-based signal (the boost value), so it would be
> plotted against time.

Suppose we have the normalized energy vs frequency curve: x^3

( P ~ V^2 * f, due to lack of better: V ~ f -> P ~ f^3 )

  1 +--------------------------------------------------------------------+
    |             +             +            +             +            *|
    |                                                       x**3 ******* |
    |                                                                **  |
0.8 |-+                                                            **  +-|
    |                                                             **     |
    |                                                            *       |
    |                                                          **        |
0.6 |-+                                                       **       +-|
    |                                                       **           |
    |                                                     **             |
    |                                                   ***              |
0.4 |-+                                               ***              +-|
    |                                               **                   |
    |                                            ***                     |
    |                                          ***                       |
0.2 |-+                                    ****                        +-|
    |                                  ****                              |
    |                            ******                                  |
    |             +     **********           +             +             |
  0 +--------------------------------------------------------------------+
    0            0.2           0.4          0.6           0.8            1


where x is our normalized frequency and y is the normalized energy.

Further, remember that schedutil does (per construction; for lack of
better):

  f ~ u

So at u=0.6, we're at f=0.6 and P=0.2

+               boost = util_avg - util_est_enqueued;

So for util_est = 0.6, we're limited to: boost = 0.4.

+       max_cost = pd->table[pd->nr_cap_states - 1].cost;
+       cost_margin = (cost_margin * max_cost) / EM_COST_MARGIN_SCALE;

Which then gives:

  cost_margin = boost = 0.4

And we find that:

  P' = P + cost_margin = 0.2 + 0.4 = 0.6 < 1

So even though set out to allow a 100% boost in energy usage, we were in
fact incapable of achieving this, because our cost_margin is linear in u
while the energy (or cost) curve is cubic in u.

That was my argument; but I think that now that I've expanded on it, I
see a flaw, because when we do have boost = 0.4, this means util_avg =
1, and we would've selected f = 1, and boosting would've been pointless.

So let me try again:

  f = util_avg, P = f^3, boost = util_avg - util_est

  P' = util_avg ^ 3 + util_avg - util_est

And I'm then failing to make further sense of that; it of course means
that P'(u) is larger than P(2u) for some u, but I don't think we set
that as a goal either.

Let me ponder this a little more while I go read the rest of your email.
