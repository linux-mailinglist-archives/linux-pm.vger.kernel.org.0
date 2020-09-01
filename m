Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0395D259766
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgIAQNq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 12:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbgIAQNo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 12:13:44 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C99204EC;
        Tue,  1 Sep 2020 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598976820;
        bh=wSYh3X+qxwyoZekqoM20nCWZcWw1dfhsCUJVuXIEPaE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WKc3b7+l3qEJxpTCJykOhIL5mC4+Tc+4xUuoNh86NmlHnYI62zNec4SSfKIrB0rAl
         ejM533Ibu1SyDPQ5Dx6TmnAip7Lh6b8EbpmM29rchZrIEuzNWLMiSMXe5Dank5qQjr
         uH/ubRDB/JaW46oPe7Zn39dD8nr2lIcTL1jF36E8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1FB1F35226A5; Tue,  1 Sep 2020 09:13:40 -0700 (PDT)
Date:   Tue, 1 Sep 2020 09:13:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
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
Message-ID: <20200901161340.GC29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72>
 <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com>
 <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
 <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org>
 <20200901155014.GF2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901155014.GF2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 05:50:14PM +0200, peterz@infradead.org wrote:
> On Tue, Sep 01, 2020 at 09:44:17AM -0600, Lina Iyer wrote:
> > > > > > > I could add RCU_NONIDLE for the calls to pm_runtime_put_sync_suspend()
> > > > > > > and pm_runtime_get_sync() in psci_enter_domain_idle_state(). Perhaps
> > > > > > > that's the easiest approach, at least to start with.
> 
> > I think this would be nice. This should also cover the case, where PM domain
> > power off notification callbacks call trace function internally. Right?
> 
> That's just more crap for me to clean up later :-(
> 
> trace_*_rcuidle() and RCU_NONIDLE() need to die, not proliferate.

Moving the idle-entry boundary further in is good in any number of ways.
But experience indicates that no matter how far you move it, there will
be something complex further in.  Unless you are pushing it all the way
into all the arch-specific code down as far as it can possibly go?

							Thanx, Paul
