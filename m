Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D77C910C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfJBSpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 14:45:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfJBSpQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 14:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5+G2tHFgFoiZj/Z+Rg08oIFehuXIST+miBzS2rXIaJs=; b=a3HEDIFJaMWYyFaI2rSAB3WF2
        2vwfgQamUoLTbyC9bY81Bv/L4/QQVTqQDEU5vhqAC+zWJC1LF4qB6KycP5CULppF+SX5w5kbh5cRU
        R3fJ2KU1QwaCpqTEgcKdizEbN+fMKHYj9qdrvPxE7uD9k2t7XYpX7x/6HqVWNWfjNgQ6e7owr00VL
        N2Sh53ZySmhxBroVSescCXjMPjPAmoXgnDEjBbTTxw30PoybKtynzABKoA5b2aXkrDxec35Zt1Dsa
        3b4QOKY0vpoefvc80/iRJ4qvv4XM+r64Gr0vmJPW4FFURucUPk19iIbF07cSenzkvfA6vjNFzw3ow
        YOfuxJkeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFjcU-00015N-Ml; Wed, 02 Oct 2019 18:45:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE50D9802BF; Wed,  2 Oct 2019 20:45:00 +0200 (CEST)
Date:   Wed, 2 Oct 2019 20:45:00 +0200
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
Message-ID: <20191002184500.GF4643@worktop.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
 <20190914105708.GA12877@qperret.net>
 <1568730466.3329.4.camel@suse.cz>
 <20190924140332.GL2369@hirez.programming.kicks-ass.net>
 <20190924160022.GB2386@hirez.programming.kicks-ass.net>
 <1570019274.22393.2.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570019274.22393.2.camel@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 02:27:54PM +0200, Giovanni Gherdovich wrote:
> On Tue, 2019-09-24 at 18:00 +0200, Peter Zijlstra wrote:
> > On Tue, Sep 24, 2019 at 04:03:32PM +0200, Peter Zijlstra wrote:
> > 
> > > > I'll check what's the cost of static_cpu_has() and if it's non-negligible I'll
> > > > do what you suggest (x86-specific version of arch_scale_freq_invariant().
> > > 
> > > static_cpu_has() is an alternative and ends up being a static branch
> > > (similar to static_key) once the alternative patching runs.
> > 
> > That said; I think you want a static key anyway, because if we can't
> > tell the max_freq we don't want to use the invariant stuff.
> > 
> > Something a little like so on top perhaps.
> > 
> > Also, the below fixes that silly tick_disable stuff.
> 
> Thanks for this patch, I'll add this change in v2.
> 
> Can you elaborate on what you don't like in the tick_disable mechanism?

Mostly because I dislike intel_pstate active mode a lot, but also
because it makes PELT behave differently between pstate and !pstate.

> > +static void init_scale_freq(void *arg)
> >  {
> >  	u64 aperf, mperf;
> >  
> > +	rdmsrl(MSR_IA32_APERF, aperf);
> > +	rdmsrl(MSR_IA32_MPERF, mperf);
> > +
> > +	this_cpu_write(arch_prev_aperf, aperf);
> > +	this_cpu_write(arch_prev_mperf, mperf);
> > +}
> > +

> > @@ -1940,5 +1949,6 @@ void x86_arch_scale_freq_tick_enable(voi
> >  
> >  void x86_arch_scale_freq_tick_disable(void)
> >  {
> > +	on_each_cpu(init_scale_freq, NULL, 1);
> >  	tick_disable = true;
> 
> I don't see why the call init_scale_freq() here is needed; why would I care of
> what's in arch_prev_[am]perf at this point. arch_scale_freq_tick() will see
> that tick_disable == true and exit early before reading arch_prev_[am]perf.

You're right, we should reset the prev values on enable. Otherwise the
first tick after enable will see 'weird' values.
