Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F6C9118
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 20:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfJBSsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 14:48:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44372 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSsS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 14:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f8mAyZhBV/yu9HtV7Xf/051+CCc7dJkpNzFzIX8htq0=; b=UMsvqJO9uRYsqbfk3scnuZD3f
        6aYbs+GulG0vslpSx2eoCS2n9qklVcj0LUnmhtMafPWe3nZImPC4QLd9PH6JIvoBYAReNnSEUt5rl
        JAsPreh89kbcGStbE0oECyhTlJq+54oNVfAL2p/G2Egf8qscyfCHEl/Ba0YmrcmP9ebojiLspln4k
        2M8z39oVFlOlydAKHitv1dyaI8Y0RAiRj0+ZB53+YzgnAAp+JgUxpaMLKyi4f8vj68+2PHi0LXW6H
        wK874Kj2PnEdwbshF/tXQngLvqbADN2aLgKt8XPSkI/PIbGgG4zb/0ScUaRrwkIMDb1mNirjU/1PB
        crIzRwz9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFjfL-0004b8-Qf; Wed, 02 Oct 2019 18:48:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2ABF9802BF; Wed,  2 Oct 2019 20:47:57 +0200 (CEST)
Date:   Wed, 2 Oct 2019 20:47:57 +0200
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
Message-ID: <20191002184757.GG4643@worktop.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
 <20190909024216.5942-2-ggherdovich@suse.cz>
 <20190924163053.GA4519@hirez.programming.kicks-ass.net>
 <1570019152.22393.0.camel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570019152.22393.0.camel@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 02:25:52PM +0200, Giovanni Gherdovich wrote:

> > What about KABYLAKE_X and ICELAKE_X ?
> 
> KABYLAKE_X: does it exist? I couldn't find it in
> arch/x86/include/asm/intel-family.h (the tip tree), I only see KABYLAKE_L and
> KABYLAKE.

My bad, I must've been staring cross-eyed at intel-family.h.

> If the SDM is outdated and ICELAKE_X is also in that category, then the
> turbostat source code is outdated too as it has this function to detect this
> feature:

I think you can trust the turbostat code.
