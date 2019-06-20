Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5695C4CE26
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 15:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfFTNEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 09:04:45 -0400
Received: from foss.arm.com ([217.140.110.172]:36626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfFTNEp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Jun 2019 09:04:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E87A360;
        Thu, 20 Jun 2019 06:04:42 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 690673F718;
        Thu, 20 Jun 2019 06:04:41 -0700 (PDT)
Date:   Thu, 20 Jun 2019 14:04:39 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 1/7] PM: Introduce em_pd_get_higher_freq()
Message-ID: <20190620130439.c3tk7osezd37pfmj@e110439-lin>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-2-douglas.raillard@arm.com>
 <20190516124200.opxczohjelhvrzmo@e110439-lin>
 <20190516130148.uhq55ptut47usnae@queper01-lin>
 <20190516132250.hedtianse7rnk3wq@e110439-lin>
 <11976c37-65d3-e0c6-034d-cfec9ebb5b49@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11976c37-65d3-e0c6-034d-cfec9ebb5b49@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-Jun 17:08, Douglas Raillard wrote:
> Hi Patrick,
> 
> On 5/16/19 2:22 PM, Patrick Bellasi wrote:
> > On 16-May 14:01, Quentin Perret wrote:
> > > On Thursday 16 May 2019 at 13:42:00 (+0100), Patrick Bellasi wrote:
> > > > > +static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
> > > > > +	unsigned long min_freq, unsigned long cost_margin)
> > > > > +{
> > > > > +	unsigned long max_cost = 0;
> > > > > +	struct em_cap_state *cs;
> > > > > +	int i;
> > > > > +
> > > > > +	if (!pd)
> > > > > +		return min_freq;
> > > > > +
> > > > > +	/* Compute the maximum allowed cost */
> > > > > +	for (i = 0; i < pd->nr_cap_states; i++) {
> > > > > +		cs = &pd->table[i];
> > > > > +		if (cs->frequency >= min_freq) {
> > > > > +			max_cost = cs->cost + (cs->cost * cost_margin) / 1024;
> > > >                                                                           ^^^^
> > > > ... end here we should probably better use SCHED_CAPACITY_SCALE
> > > > instead of hard-coding in values, isn't it?
> > > 
> > > I'm not sure to agree. This isn't part of the scheduler per se, and the
> > > cost thing isn't in units of capacity, but in units of power, so I don't
> > > think SCHED_CAPACITY_SCALE is correct here.
> > 
> > Right, I get the units do not match and it would not be elegant to use
> > it here...
> > 
> > > But I agree these hard coded values (that one, and the 512 in one of the
> > > following patches) could use some motivation :-)
> > 
> > ... ultimately SCHED_CAPACITY_SCALE is just SCHED_FIXEDPOINT_SCALE,
> > which is adimensional. Perhaps we should use that or yet another alias
> > for the same.
> 
> Would it be a good idea to use SCHED_FIXEDPOINT_SCALE in energy.c ?
> Since it's not part of the scheduler, maybe there is a scale covering a wider scope,
> or we can introduce a similar ENERGY_FIXEDPOINT_SCALE in energy_model.h.

Well, in energy_model.c we have references to "capacity" and
"utilization" which are all SCHED_FIXEDPOINT_SCALE range values.
That symbol is defined in <linux/sched.h> and we already pull
in other <linux/sched/*> headers.

So, to me it seems it's not unreasonable to say that we use scheduler
related concepts and it makes more sense than introducing yet another
scaling factor.

But that's just my two cents ;)

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
