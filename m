Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE7C90EF
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfJBSfu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 14:35:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44262 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 14:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kff8NFhNWSYdZTeTx86ANdXzbIxamMv6vlbE+DKs0WU=; b=UsUe2khu1wXY5oN8m9YPh4uLm
        OexM0Ep2yCh1BkyfLeFIH++DBV0GTdS4urxCmLu6bXtDgIZ7tSGB+aqHx9hqQElgMx7HY4i7F/aqY
        EB19mcnPS+8vP4Y0oJ2fXVr7XYzIVrzNfm5t7gI5U3UZpWt6bdKSVTAiWBfHCuWF8m3pNEQVzuJib
        SB35uqbp5zp8MZr/M2q2uqR40wA1yOZ8SUaZ8f2ax+K25EQXv5+7XNl6uC1NuWlaG+iQe6kIwrMu4
        cSzEK7ocSLkaq7X6DednAdP+vI21C8uRnjZeftz2a4HhRSs3ONoubRPNh2T9ge6G+nhmWCVJptW1A
        j0+nc6M9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFjSx-0004UT-6b; Wed, 02 Oct 2019 18:35:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17B399802BF; Wed,  2 Oct 2019 20:35:07 +0200 (CEST)
Date:   Wed, 2 Oct 2019 20:35:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20191002183507.GE4643@worktop.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
 <20190924160423.GN2369@hirez.programming.kicks-ass.net>
 <1570019204.22393.1.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570019204.22393.1.camel@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 02:26:44PM +0200, Giovanni Gherdovich wrote:
> On Tue, 2019-09-24 at 18:04 +0200, Peter Zijlstra wrote:
> > On Mon, Sep 09, 2019 at 04:42:15AM +0200, Giovanni Gherdovich wrote:
> > 
> > > +static void intel_set_cpu_max_freq(void)
> > > +{
> > > +	/*
> > > +	 * TODO: add support for:
> > > +	 *
> > > +	 * - Xeon Phi (KNM, KNL)
> > > +	 * - Xeon Gold/Platinum, Atom Goldmont/Goldmont Plus
> > > +	 * - Atom Silvermont
> > 
> > ISTR I had code for Atom.. what happened with that?
> 
> I'm being overly zealous and I wanted to get a Silvermont machine to test that
> code before sending.
> 
> The reason is that your code uses MSR_ATOM_CORE_RATIOS and
> MSR_ATOM_CORE_TURBO_RATIOS which are not documented in the SDM. I wanted to
> make sure those have the expected content on at least one machine before using
> them in my code. I have no doubt you, Srinivas and Len (who uses them in
> turbostat) have already checked but you know, more eyeballs.
> 
> I've talked to Len and Srinivas at LPC, they agreed that those two MSR may not
> have made it to the SDM but said the turbostat source code is the reference in
> this case.

Can you at least include the patch as RFC then? Perhaps other people,
who have hardware at hand, can then help test it.
