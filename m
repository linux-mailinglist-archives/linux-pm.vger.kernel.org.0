Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511B425AAF0
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 14:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBMOR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIBMOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 08:14:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C9C061244;
        Wed,  2 Sep 2020 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NadokaudFgFu9nMqgW3AlEN/gjoKd9NcBHIQBLterQc=; b=cNHyhKqUc+bx3k9nQ7UUWDCZaU
        S3o+RQdCG0YXb+ogIN83rwNSwWanJEnCLsxrjV8MtSAGJG1RjGRPQ3GcUaecix2yWLKI0q9Hgiyt/
        JtAfRFzWy8t15wcwatM8mJr/KXTngtKdH3XlLhkh5dyNPVsWgCRIe7QkCo0YKXjp/bvq1Rr/gsCHP
        hXlbG7hbnps9N+UP/GAgKgl0JeD57Zbx0oZiLqNsqnVx9Pyrcz3PEGfXn9yp7vUPHG4plQsq5/CSD
        NK06IP8lJJjJ9NGZ4Il1Wt3x2S1pjySa6oKFp3C7y7qs/ct4VF2zYuTL55+GR8C1qENhjWzsfAndD
        0NlgetLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDReH-0007On-AX; Wed, 02 Sep 2020 12:13:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB1E93003E5;
        Wed,  2 Sep 2020 14:13:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A43C123D3D72C; Wed,  2 Sep 2020 14:13:55 +0200 (CEST)
Date:   Wed, 2 Sep 2020 14:13:55 +0200
From:   peterz@infradead.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
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
Message-ID: <20200902121355.GE1362448@hirez.programming.kicks-ass.net>
References: <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com>
 <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
 <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org>
 <20200901155014.GF2674@hirez.programming.kicks-ass.net>
 <20200901161340.GC29330@paulmck-ThinkPad-P72>
 <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
 <CAPDyKFqPh7bg16AsitGv2QQHgwOPnWx9DiPPCMuD1EGA5TFFdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqPh7bg16AsitGv2QQHgwOPnWx9DiPPCMuD1EGA5TFFdg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 02, 2020 at 09:03:37AM +0200, Ulf Hansson wrote:
> Lots of cpuidle drivers are using CPU_PM notifiers (grep for
> cpu_pm_enter and you will see) from their idlestates ->enter()
> callbacks. And for those we are already calling
> rcu_irq_enter_irqson|off() in cpu_pm_notify() when firing them.

Yeah, that particular trainwreck is on my todo list already ... then
again, that list is forever overflowing.

I'm thinking cpu_pm_unregister_notifier() is not a common thing? The few
I looked at seem to suggest 'never' is a good approximation.

It would be fairly trivial to replace the atomic_notifier usage with a
raw_notifier a lock and either stop-machine or IPIs. Better still would
be if we can get rid of it entirely, but I can't tell in a hurry if that
is possible.
