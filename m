Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2201B47B6
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgDVOyE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 10:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDVOyE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 10:54:04 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB5C03C1A9;
        Wed, 22 Apr 2020 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C/y0MT4RUP0Ak6RuYzOz+uq54Hlm5rIbVfYvdumz+DM=; b=UUrQV2YDRusF3q4mtsyE/OglW+
        U6JQFBF+3KcYfY7tjK+1QSbpmnSpKbp0FQEukWKyUX5k1kTTlBNKnSHilBSlB3pqEDAVNJZ/pHo4a
        zYgNUSBw8W/iY24GB0zmPhRnlYzY+nDJE/wb167ntBElVK2e5ENkXqzpxo6dWG6pnauv1YaZFu48A
        kzkSovg89bUxZz5vghqkSykuvsyd2vKZjRiE4udPWELuOoPACF7LwCTxdaVgiMZAZPW0sv2RHGs/s
        qNhCOEWrh95kiNuxy8LDPyIhj1cL/HyP6dkVzmx82qtF5inj36eqJfFWCCsKHhaKI+YjcVHe6A1fh
        kv0SMH1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRGkr-0002YT-JX; Wed, 22 Apr 2020 14:53:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E49C3010C4;
        Wed, 22 Apr 2020 16:53:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30D18203AA838; Wed, 22 Apr 2020 16:53:34 +0200 (CEST)
Date:   Wed, 22 Apr 2020 16:53:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86, sched: Prevent divisions by zero in frequency
 invariant accounting
Message-ID: <20200422145334.GM20730@hirez.programming.kicks-ass.net>
References: <20200422144055.18171-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422144055.18171-1-ggherdovich@suse.cz>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 22, 2020 at 04:40:55PM +0200, Giovanni Gherdovich wrote:
> The product mcnt * arch_max_freq_ratio could be zero if it overflows u64.
> 
> For context, a large value for arch_max_freq_ratio would be 5000,
> corresponding to a turbo_freq/base_freq ratio of 5 (normally it's more like
> 1500-2000). A large increment frequency for the MPERF counter would be 5GHz
> (the base clock of all CPUs on the market today is less than that). With
> these figures, a CPU would need to go without a scheduler tick for around 8
> days for the u64 overflow to happen. It is unlikely, but the check is
> warranted.
> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
> ---
>  arch/x86/kernel/smpboot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 8c89e4d9ad28..fb71395cbcad 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -2055,14 +2055,14 @@ void arch_scale_freq_tick(void)
>  
>  	acnt = aperf - this_cpu_read(arch_prev_aperf);
>  	mcnt = mperf - this_cpu_read(arch_prev_mperf);
> -	if (!mcnt)
> -		return;
>  
>  	this_cpu_write(arch_prev_aperf, aperf);
>  	this_cpu_write(arch_prev_mperf, mperf);
>  
>  	acnt <<= 2*SCHED_CAPACITY_SHIFT;
>  	mcnt *= arch_max_freq_ratio;
> +	if (!mcnt)
> +		return;

Should we not pr_warn() and disable the whole thing when this happens?
