Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9568259207
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIAPBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgIAPBK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 11:01:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360DC061244;
        Tue,  1 Sep 2020 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c4Ee9icQII2DGAoMrIbwKT8Ude3XzoISGtg+XB13lKQ=; b=afn94a0rd08dIeIK+nPtOLy9ZF
        2kHzRnga5rpNnJdpfqAdEkDoDXnbQLFe53sru0CkEghz/uu1jDS/OLaSJ+nTqEjhT34UhvcmEEJIY
        MqjQVEuWOQeiiEIl9BzC7QTXM3oeEPCjpJZW0uTROZyy/No0zCe/etHYanQR7sMptJckLhBj1ciT8
        pB3s3YkIryDdSN+nEtCUxp7av0xGykhSncbcxwlkFtcNGZVMyZ4FT31TI2XkJIpM72reeWASyq8Lo
        1Es0Ru63eoYj9KldC//FQZ4EIGB9kRInPDRT/Y1JbvmfYRhsX3+W+/83DND1k4IpIOTaeVkdknDH/
        mlMV2o1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD7mL-0004dC-KN; Tue, 01 Sep 2020 15:00:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 770E6300F7A;
        Tue,  1 Sep 2020 17:00:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6633520BEB41B; Tue,  1 Sep 2020 17:00:55 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:00:55 +0200
From:   peterz@infradead.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, paulmck@kernel.org,
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
        Lina Iyer <ilina@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
Message-ID: <20200901150055.GD2674@hirez.programming.kicks-ass.net>
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72>
 <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com>
 <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 02:35:52PM +0200, Ulf Hansson wrote:
> On Tue, 1 Sep 2020 at 12:42, <peterz@infradead.org> wrote:

> > That said; I pushed the rcu_idle_enter() about as deep as it goes into
> > generic code in commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle
> > deeper into the idle path")
> 
> Aha, that commit should fix this problem, I think. Looks like that
> commit was sent as a fix and included in the recent v5.9-rc3.

AFAICT psci_enter_domain_idle_state() is still buggered. All that
pm_runtime_*() stuff is using locks.

Look at this:

  psci_enter_domain_idle_state()
    pm_runtime_put_sync_suspend()
      __pm_runtime_suspend()
        spin_lock_irqsave(&dev->power.lock, flags);

That's a definite fail after we've done rcu_idle_enter().

> > I suppose the next step is pushing it into individual driver when
> > needed, something like the below perhaps. I realize the coupled idle
> > state stuff is more complicated that most, but it's also not an area
> > I've looked at in detail, so perhaps I've just made a bigger mess, but
> > it ought to give you enough to get going I think.
> 
> These aren't coupled states. Instead, in cpuidle-psci, we are using PM
> domains through genpd and runtime PM to manage "shared idle states"
> between CPUs.

Similar problem I'm thinking, 'complicated' stuff.
