Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B2F1AB9B4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 09:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438708AbgDPHVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 03:21:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38420 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438994AbgDPHVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 03:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jQJpyv9mWOGvWWLLrQIG1lSOaT4yQcrtTLgVAFWtcqo=; b=K/+1a/v9SCQ2y8fy5FWyuyEPVX
        4zhtejMmGej+qnrrNoHsMs6hBRkLRNsx+4pqhz9ZmST/bJZhlDO0gzbeY8RqQZHlCijOdk8Ml83Ar
        2zpPzLRgLkd9d/BoRctfN3whBLULQV8i3d1Ww4S3KuAhayVlPDcQVzJI1dAJRZ5+pvWk0gS1iFCpE
        T6sGLeKvWhuW+evqLWUJaU6orM+KKlrarvLQ2BSoDvDXmXvUgL53cQHwNTf473zDA+/KaI4BDcCjx
        xm4vEGACkbV3g7BMwN2OyEUp2FXWg6numvtEcYVPdkZVd3cbKH0dX570XcROdwPVo72+WeX51TMn+
        8nDmAw8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOyow-0006TI-TH; Thu, 16 Apr 2020 07:20:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26D7630477A;
        Thu, 16 Apr 2020 09:20:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 741A62B0DB54A; Thu, 16 Apr 2020 09:20:17 +0200 (CEST)
Date:   Thu, 16 Apr 2020 09:20:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 0/4] Frequency invariance fixes for x86
Message-ID: <20200416072017.GJ20730@hirez.programming.kicks-ass.net>
References: <20200416054745.740-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416054745.740-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 16, 2020 at 07:47:41AM +0200, Giovanni Gherdovich wrote:
> Patches 1-3 address bugs in the current frequency invariance support for x86,
> including the incompatibility with cpu0 hotplug reported by Chris Wilson at
> https://lore.kernel.org/lkml/158556634294.3228.4889951961483021094@build.alporthouse.com/
> and the issue with CPUs that have less than 4 cores pointed out earlier
> today by Like Xu at
> https://lore.kernel.org/lkml/20200416021210.170736-1-like.xu@linux.intel.com/ 
> 
> Patch 4 is a minor code reorganization.
> 
> Giovanni Gherdovich (3):
>   x86, sched: Bail out of frequency invariance if base frequency is
>     unknown
>   x86, sched: Account for CPUs with less than 4 cores in freq.
>     invariance
>   x86, sched: Move check for CPU type to caller function
> 
> Peter Zijlstra (Intel) (1):
>   x86, sched: Don't enable static key when starting secondary CPUs
> 
>  arch/x86/kernel/smpboot.c | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)

Thanks!
