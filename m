Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8495BC9B0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392025AbfIXOEI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 10:04:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49144 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfIXOEI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 10:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OCd9Fr0CJ9gkQjtYi+RvQr2AUrWhMG1/VlZsM2oF7Yc=; b=cu5yI+WuhPe37UB2o0iJ7Qx5Q
        5odWybKsCWzA9tcyVGj3aBSDl69PhcCVf25E9LobhN3SkxSMbEyEIZrPoy3j/F/Sf5G1DdQIXUVnA
        +G2dS+VpOCXkuT9vjYjPH2f6653yBReJGhANNnaO782eRAJSF6A5zBSfzdJmM6p9hTy+ycraszids
        M/614TxQzRc8ILxTr59o29o/O5HQAIVao5jwyE/mwNKSxgMbAKv+4+nxUsw+SgCN2ML9FjCz8bh90
        EjlfLHPW/eg4iOibq3MPQrEpDHXcoaQEUiorXfaB8LkOFmTxG6FHFsGwjzAUzLlbevs89HQzV/qQW
        bFTvVXZgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iClPj-0001cm-LP; Tue, 24 Sep 2019 14:03:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCF4A305E35;
        Tue, 24 Sep 2019 16:02:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6803620D83757; Tue, 24 Sep 2019 16:03:32 +0200 (CEST)
Date:   Tue, 24 Sep 2019 16:03:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Quentin Perret <qperret@qperret.net>,
        srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
Message-ID: <20190924140332.GL2369@hirez.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
 <20190914105708.GA12877@qperret.net>
 <1568730466.3329.4.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568730466.3329.4.camel@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 17, 2019 at 04:27:46PM +0200, Giovanni Gherdovich wrote:
> Hello Quentin,
> 
> On Sat, 2019-09-14 at 12:57 +0200, Quentin Perret wrote:
> > Hi Giovanni
> > 
> > On Monday 09 Sep 2019 at 04:42:15 (+0200), Giovanni Gherdovich wrote:
> > > +static inline long arch_scale_freq_capacity(int cpu)
> > > +{
> > > +	if (static_cpu_has(X86_FEATURE_APERFMPERF))
> > > +		return per_cpu(arch_cpu_freq, cpu);
> > 
> > So, if this is conditional, perhaps you could also add this check in an
> > x86-specific implementation of arch_scale_freq_invariant() ? That would
> > guide sugov in the right path (see get_next_freq()) if APERF/MPERF are
> > unavailable.
> > 
> > > +	return 1024 /* SCHED_CAPACITY_SCALE */;
> > > +}
> >
> 
> Good remark. If the cpu doesn't have APERF/MPERF, the choice here is that
> freq_curr is constantly equal to freq_max, and the scaling factor is 1 all the
> time.
> 
> But I'm checking this static_cpu_has() every time I do a frequency update;
> arguably schedutil should be smarter and settle such a case once and for all
> at boot time.
> 
> I'll check what's the cost of static_cpu_has() and if it's non-negligible I'll
> do what you suggest (x86-specific version of arch_scale_freq_invariant().

static_cpu_has() is an alternative and ends up being a static branch
(similar to static_key) once the alternative patching runs.
