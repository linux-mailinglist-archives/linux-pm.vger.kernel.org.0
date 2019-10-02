Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1772C883C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 14:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfJBMVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 08:21:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfJBMVP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 08:21:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CEC4ACC3;
        Wed,  2 Oct 2019 12:21:13 +0000 (UTC)
Message-ID: <1570019204.22393.1.camel@suse.cz>
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com
Date:   Wed, 02 Oct 2019 14:26:44 +0200
In-Reply-To: <20190924160423.GN2369@hirez.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
         <20190909024216.5942-2-ggherdovich@suse.cz>
         <20190924160423.GN2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2019-09-24 at 18:04 +0200, Peter Zijlstra wrote:
> On Mon, Sep 09, 2019 at 04:42:15AM +0200, Giovanni Gherdovich wrote:
> 
> > +static void intel_set_cpu_max_freq(void)
> > +{
> > +	/*
> > +	 * TODO: add support for:
> > +	 *
> > +	 * - Xeon Phi (KNM, KNL)
> > +	 * - Xeon Gold/Platinum, Atom Goldmont/Goldmont Plus
> > +	 * - Atom Silvermont
> 
> ISTR I had code for Atom.. what happened with that?

I'm being overly zealous and I wanted to get a Silvermont machine to test that
code before sending.

The reason is that your code uses MSR_ATOM_CORE_RATIOS and
MSR_ATOM_CORE_TURBO_RATIOS which are not documented in the SDM. I wanted to
make sure those have the expected content on at least one machine before using
them in my code. I have no doubt you, Srinivas and Len (who uses them in
turbostat) have already checked but you know, more eyeballs.

I've talked to Len and Srinivas at LPC, they agreed that those two MSR may not
have made it to the SDM but said the turbostat source code is the reference in
this case.


Giovanni
