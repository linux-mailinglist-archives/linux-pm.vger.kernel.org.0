Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE922FBBF5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 17:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbhASQHS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 11:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391385AbhASQD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 11:03:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A50DC061575;
        Tue, 19 Jan 2021 08:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EhVNN5w31+BoStuV5p83fjIjrTbho1tnvewJve+/h9Q=; b=UWCs2GbaEiVNzA19wKWlr9c/PQ
        UMAZuyoJbhGdlV8lgXLhfgFbaPPe7Lpsa68jxwobKbaLIK+P95bRELv5UA3iWDav8I5VDBfvkedFS
        L655rampQgJNMFtqTyNpv4zhDBCk/jYsuzhSepx26gdFHNwfX1Uc1s17Q8QY/zMfurFb/78c8Y0we
        MDdUdDeZ+qlSShuLda/IkktpDC0tDiIidFBkainB86N45fT63FFku/gyzrJFqNzf7dmi9FK1xiQOb
        CPyBMTYfs8OAwFR4XgeYhEW+k1h+t85peDC+ohOBO0BCTXoWjFUiCPrp3agxiORyWrL6fKJt+QkvY
        IKD6dfBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1tTE-0007Eu-LV; Tue, 19 Jan 2021 16:03:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 104D53059DD;
        Tue, 19 Jan 2021 17:03:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02B0A202638D9; Tue, 19 Jan 2021 17:03:02 +0100 (CET)
Date:   Tue, 19 Jan 2021 17:03:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH] x86: PM: Register syscore_ops for scale invariance
Message-ID: <YAcCtnYbhasv+ENi@hirez.programming.kicks-ass.net>
References: <1803209.Mvru99baaF@kreacher>
 <X/25ssA2scFSu+3/@hirez.programming.kicks-ass.net>
 <CAJZ5v0gHHPcBbL-EnCYJieMV-pRJWsjb5qC-iqHYznYjzrkitw@mail.gmail.com>
 <CAJZ5v0gY+WjB2q=wnRYxpwFmLzOcLMKewrCgKdpC0oNPFgoDww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gY+WjB2q=wnRYxpwFmLzOcLMKewrCgKdpC0oNPFgoDww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 19, 2021 at 04:12:20PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 12, 2021 at 4:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Jan 12, 2021 at 4:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Jan 08, 2021 at 07:05:59PM +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > On x86 scale invariace tends to be disabled during resume from
> > > > suspend-to-RAM, because the MPERF or APERF MSR values are not as
> > > > expected then due to updates taking place after the platform
> > > > firmware has been invoked to complete the suspend transition.
> > > >
> > > > That, of course, is not desirable, especially if the schedutil
> > > > scaling governor is in use, because the lack of scale invariance
> > > > causes it to be less reliable.
> > > >
> > > > To counter that effect, modify init_freq_invariance() to register
> > > > a syscore_ops object for scale invariance with the ->resume callback
> > > > pointing to init_counter_refs() which will run on the CPU starting
> > > > the resume transition (the other CPUs will be taken care of the
> > > > "online" operations taking place later).
> > > >
> > > > Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Thanks!, I'll take it through the sched/urgent tree?
> >
> > That works, thanks!
> 
> Any news on this front?  It's been a few days ...

My bad, it's been held up behind me trying to fix another sched
regression. Lemme push out just this one so it doesn't go walk-about.
