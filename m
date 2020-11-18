Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849C32B7EF4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgKROB6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 09:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgKROB6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 09:01:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE139C0613D4;
        Wed, 18 Nov 2020 06:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hf+WmZw0/QtzjHu8PMxC8I8eLlzP2pZgCrBHY8NMmfc=; b=K8vI3PlW1f6TCL/Je5bIPCLDeA
        cEKHmqqYa7LLEw1fN4xyIw9AuPUR9cz8Y8DLYrsT4l1DE6nW/g9j/bF9PRf5yEBOoeVc0aTVJNQod
        ITsBKbO3DKmue3+EIYv+vHUHUJHe8iGWjiYfmZ60uyZrI8RHfS6iOK3gP2/jxpF6IkkwlMVDx1HnJ
        rsQBAwx9YnNuh5Z5xP7ngVCl0CZuYwYknGyUvH3y+wUBwJ497JFQxPMxxQk+xgGx62tJx55j8KIUb
        VVGnKuz9p/sjmQfBUSfPwLS5w7S+IppxyYHrNFhCWPrxPxZpZ/UEaYkGml9skPendDL4Z35iLrvo4
        d5EzHGOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfO1o-0002uK-B3; Wed, 18 Nov 2020 14:01:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB3273012C3;
        Wed, 18 Nov 2020 15:01:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0F442BC733C0; Wed, 18 Nov 2020 15:01:41 +0100 (CET)
Date:   Wed, 18 Nov 2020 15:01:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        qperret@google.com, valentin.schneider@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 0/3] condition EAS enablement on FI support
Message-ID: <20201118140141.GT3121392@hirez.programming.kicks-ass.net>
References: <20201027180713.7642-1-ionela.voinescu@arm.com>
 <20201118114233.GB9782@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118114233.GB9782@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 18, 2020 at 11:42:34AM +0000, Ionela Voinescu wrote:
> Hi guys,
> 
> On Tuesday 27 Oct 2020 at 18:07:10 (+0000), Ionela Voinescu wrote:
> > Given the maturity gained by cpufreq-based Frequency Invariance (FI)
> > support following the patches at [1], this series conditions Energy
> > Aware Scheduling (EAS) enablement on a frequency invariant system.
> > 
> > Currently, EAS can be enabled on a system without FI support, leading
> > to incorrect (energy-wise) task placements. As no warning is emitted,
> > it could take some debugging effort to track the behavior back to the
> > lack of FI support; this series changes that by disabling EAS
> > (and advertising it) when FI support is missing.
> > 
> > The series is structured as follows:
> >  - 1/3 - create function that can rebuild the scheduling and EAS'
> >    performance domains if EAS' initial conditions change
> >  - 2/3 - arm64: rebuild scheduling and performance domains in the
> >          case of late, counter-driven FI initialisation.
> >  - 3/3 - condition EAS enablement on FI support
> > 
> > RESEND v2: rebase and retest on v5.10-rc1
> > 
> 
> This still applies nicely on v5.10-rc4.
> 
> Peter, given that 1/3 and 2/3 are acked, do you think there's anything
> else that needs to be done for this?

I'll take it, thanks!
