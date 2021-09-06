Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9106B4017B6
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbhIFISr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 04:18:47 -0400
Received: from foss.arm.com ([217.140.110.172]:53380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239780AbhIFISq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Sep 2021 04:18:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09478D6E;
        Mon,  6 Sep 2021 01:17:42 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 917373F73D;
        Mon,  6 Sep 2021 01:17:40 -0700 (PDT)
Date:   Mon, 6 Sep 2021 09:17:34 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v6 6/7] cpufreq: Skip inefficient frequencies
Message-ID: <20210906081733.GA4151@e120877-lin.cambridge.arm.com>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
 <1630405453-275784-7-git-send-email-vincent.donnefort@arm.com>
 <CAJZ5v0i5KRkUKvqGbqoxhaNh626bmg3C2F-rZmcqaaqReQF7SQ@mail.gmail.com>
 <20210902105037.GA136543@e120877-lin.cambridge.arm.com>
 <CAJZ5v0iRJuyup2M16snP+BdJSKToSQ4QiFnrCoZn1j2KYhLEGA@mail.gmail.com>
 <20210902134927.GA147718@e120877-lin.cambridge.arm.com>
 <CAJZ5v0hi=YDiO79YWPDHcHEVypwv7++Qjmz7JAjOs9O6ooGy+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hi=YDiO79YWPDHcHEVypwv7++Qjmz7JAjOs9O6ooGy+g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

> > >
> > > Moreover, if only efficient frequencies are to be used, RELATION_L
> > > needs to return min(policy->max, the closest efficient frequency equal
> > > to or above the target).
> >
> > You mean, never returning an inefficient frequency, unless there are no
> > efficient ones in the range policy->min policy->max ?
> 
> No, that's not what I mean.
> 
> First note that the target here is clamped between the policy min and
> max.  Also bear in mind that each of them is a frequency from the
> table, either efficient or inefficient.
> 
> In the first step, search through the efficient frequencies only.
> That will return you something at or above the target.  If it is at
> the target, you're done.  If it is above the target, it may be either
> within or above the policy max.  If it is within the policy max,
> you're done.  If it is above the policy max, you need to search
> through the inefficient frequencies between the target and the policy
> max (and you know that there is at least one - the policy max itself).
> 
> So what I said previously wasn't particularly precise, sorry about that.

I might have missed something but it seems equivalent to what's currently done:

Find the appropriate frequency, if inefficient go to the efficient one, if
above policy->max return the original inefficient frequency.
