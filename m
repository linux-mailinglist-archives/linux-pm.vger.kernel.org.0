Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F13A6836
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhFNNmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 09:42:20 -0400
Received: from foss.arm.com ([217.140.110.172]:36406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234090AbhFNNmS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Jun 2021 09:42:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE3F6D;
        Mon, 14 Jun 2021 06:40:16 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07D43F719;
        Mon, 14 Jun 2021 06:40:14 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:40:12 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210614134012.GB34061@e120877-lin.cambridge.arm.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <YLput6k5NIJKsy6v@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLput6k5NIJKsy6v@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > +	for (;;) {
> > +		pos = &table[idx];
> > +
> > +		if (pos->frequency == CPUFREQ_ENTRY_INVALID)
> > +			continue;
> 
> That would result in an infinite loop, you still want to execute the code
> at the bottom of the loop which increments/decrements 'idx' and exits the
> loop when the end of the table is reached.

Arg, indeed, sorry for that ugly thing.

I'll wait for more input from Viresh before submitting a fixed version.

> 
> > +
> > +		if (pos->flags & CPUFREQ_INEFFICIENT_FREQ) {
> > +			pos->efficient = efficient;
> > +		} else {
> > +			pos->efficient = idx;
> > +			efficient = idx;
> > +		}
> > +
> > +		if (sort == CPUFREQ_TABLE_SORTED_ASCENDING) {
> > +			if (--idx < 0)
> > +				break;
> > +		} else {
> > +			if (table[++idx].frequency == CPUFREQ_TABLE_END)
> > +				break;
> > +		}
> > +	}
> > +}
> > +
