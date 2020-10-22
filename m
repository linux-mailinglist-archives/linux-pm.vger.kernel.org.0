Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107E9295D81
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502961AbgJVLjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 07:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438250AbgJVLjY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 07:39:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BF5C0613CE;
        Thu, 22 Oct 2020 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2E3kMNYpFQGPJuJs5up4gmdkpzSi7nO8NUmiDPeWiQQ=; b=CW73PwlR38lmWk+q+2+HFhgQuz
        +yjEknYiNUpUp3NUKo0e64Urvvc2QZgBrozVyCHtXYFuJzT4hVRy5iJ0OFpwM7/03CP1JSH3/3iYP
        wRGy00lrmbp8eG6Mw1e66eJxxR6ghHhHCOzksHvRMXiRf2LxS9wmLx/P+eOvQW/AyMmDQjQa+R+tW
        LVpurff96NnOsac7Wi/ijogF4zymdv9CeU0d1ATNDA4CeB4j1C4QV1DJ8I9W1sjFxcGFQBrYkgBEQ
        82W6koSkl6OZFyMSdxkjzHjcBMBIT/RMv5fXEcP29Dw1LW8u3j+Modv+PO1cls1vGR3BF+vE/vyAX
        MMbEjYiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVYw3-0006KQ-UF; Thu, 22 Oct 2020 11:39:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 404F730377D;
        Thu, 22 Oct 2020 13:39:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28F02203CC4B2; Thu, 22 Oct 2020 13:39:09 +0200 (CEST)
Date:   Thu, 22 Oct 2020 13:39:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20201022113909.GE2611@hirez.programming.kicks-ass.net>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net>
 <20201022083255.37xl3lffwk5qo6uk@vireshk-i7>
 <20201022090523.GV2628@hirez.programming.kicks-ass.net>
 <20201022110656.gaphjv2tzhj4f5y6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022110656.gaphjv2tzhj4f5y6@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 04:36:56PM +0530, Viresh Kumar wrote:
> On 22-10-20, 11:05, Peter Zijlstra wrote:
> > On Thu, Oct 22, 2020 at 02:02:55PM +0530, Viresh Kumar wrote:
> > > One of the issues I see with this is that schedutil may not be
> > > available in all configurations and it is still absolutely fine to
> > > using the suggested helper to get the energy numbers in such cases, so
> > > we shouldn't really make it scheutil dependent.
> > 
> > The only constraint on schedutil is SMP I think; aside from that it
> > should/could always be available.
> > 
> > Given the trainwreck here:
> > 
> >   20201022071145.GM2628@hirez.programming.kicks-ass.net
> > 
> > (you're on Cc), I'm starting to lean more and more towards making it
> > unconditionally available (when SMP).
> > 
> > Anybody forcing it off either sets performance (in which case we don't
> > care about energy usage anyway)
> 
> I agree.
> 
> > or they select one of the old (broken)
> > ondemand/conservative things and I don't give a crap.
> 
> The other kernel layers, for example cpufreq-cooling in question here,
> don't really need to bother with the governor in use and should be
> able to get the energy numbers anyway. So for me, the energy number
> that the cpufreq-cooling stuff gets should be same irrespective of the
> governor in use, schedutil or ondemand.
> 
> Having said that, schedutil really doesn't need to install the
> fallback (which you suggested earlier), rather the scheduler core can
> do that directly with cpufreq core and schedutil can also use the same
> fallback mechanism maybe ? And so we can avoid the exporting of stuff
> that way.

I suppose that could work, yes. It's a bit weird to have two
interactions with cpufreq, once through a governor and once outside it,
but I suppose I can live with that.
