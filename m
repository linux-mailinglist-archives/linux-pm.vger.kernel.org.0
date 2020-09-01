Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABE5259D73
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 19:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgIARma (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgIARm3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 13:42:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5E8C061244;
        Tue,  1 Sep 2020 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L5+iKG5i9fFPHpLQKtEzdQO5HXzkEnTIXwpxe3If020=; b=stdjs9CM1DFY4aiDaHudhWDJKU
        s6Hpvn/DWs26Mh7Z8oSw5OtKqQbVdj5SUUKsJ1RzZsqkZ39iCtnmLzLab8+w9xopeoSAKgcoJn6jZ
        ZUdshd6E0AdA9iKpriv90RAayQNk0C70iq733aVy7W2zU/HsFVzkiBnQAP3pbXRftxhNJfEHVTJ9u
        UmFULOER0xmaxEZN3kArygBpf/4g90Zo7eLjoRZkwxRpRaG5MPMPil2KZzQTNGZvVKsOilhf4aK+b
        pMi98ShaxU07nrCWfxpRZlQ+p1FZxTk+EQKLdULpiD/p+qzQGDZ3px05LdXW42p9dOheyfnLt3CAr
        aL9eBGIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDAIU-0000zX-AR; Tue, 01 Sep 2020 17:42:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26867980D85; Tue,  1 Sep 2020 19:42:16 +0200 (CEST)
Date:   Tue, 1 Sep 2020 19:42:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
Message-ID: <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72>
 <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com>
 <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
 <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org>
 <20200901155014.GF2674@hirez.programming.kicks-ass.net>
 <20200901161340.GC29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901161340.GC29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 09:13:40AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 01, 2020 at 05:50:14PM +0200, peterz@infradead.org wrote:
> > On Tue, Sep 01, 2020 at 09:44:17AM -0600, Lina Iyer wrote:
> > > > > > > > I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
> > > > > > > > and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
> > > > > > > > that's the easiest approach, at least to start with.
> > 
> > > I think this would be nice. This should also cover the case, where PM domain
> > > power off notification callbacks call trace function internally. Right?
> > 
> > That's just more crap for me to clean up later :-(
> > 
> > trace_*_rcuidle() and RCU_NONIDLE() need to die, not proliferate.
> 
> Moving the idle-entry boundary further in is good in any number of ways.
> But experience indicates that no matter how far you move it, there will
> be something complex further in.  Unless you are pushing it all the way
> into all the arch-specific code down as far as it can possibly go?

Not all; the simple cpuidle drivers should be good already. The more
complicated ones need some help.

The patch provided earlier:

  https://lkml.kernel.org/r/20200901104206.GU1362448@hirez.programming.kicks-ass.net

should allow the complicated drivers to take over and DTRT.
