Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2A2077F
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfEPNCF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 09:02:05 -0400
Received: from foss.arm.com ([217.140.101.70]:45000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfEPNCE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 May 2019 09:02:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72BB51715;
        Thu, 16 May 2019 06:02:04 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BD1B3F703;
        Thu, 16 May 2019 06:02:02 -0700 (PDT)
Date:   Thu, 16 May 2019 14:01:50 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     douglas.raillard@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 1/7] PM: Introduce em_pd_get_higher_freq()
Message-ID: <20190516130148.uhq55ptut47usnae@queper01-lin>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-2-douglas.raillard@arm.com>
 <20190516124200.opxczohjelhvrzmo@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516124200.opxczohjelhvrzmo@e110439-lin>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 16 May 2019 at 13:42:00 (+0100), Patrick Bellasi wrote:
> > +static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
> > +	unsigned long min_freq, unsigned long cost_margin)
> > +{
> > +	unsigned long max_cost = 0;
> > +	struct em_cap_state *cs;
> > +	int i;
> > +
> > +	if (!pd)
> > +		return min_freq;
> > +
> > +	/* Compute the maximum allowed cost */
> > +	for (i = 0; i < pd->nr_cap_states; i++) {
> > +		cs = &pd->table[i];
> > +		if (cs->frequency >= min_freq) {
> > +			max_cost = cs->cost + (cs->cost * cost_margin) / 1024;
>                                                                          ^^^^
> ... end here we should probably better use SCHED_CAPACITY_SCALE
> instead of hard-coding in values, isn't it?

I'm not sure to agree. This isn't part of the scheduler per se, and the
cost thing isn't in units of capacity, but in units of power, so I don't
think SCHED_CAPACITY_SCALE is correct here.

But I agree these hard coded values (that one, and the 512 in one of the
following patches) could use some motivation :-)

Thanks,
Quentin
