Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD82F3388
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 16:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbhALPC0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbhALPC0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 10:02:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED33C061575;
        Tue, 12 Jan 2021 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0sGgaWxUWbmYiELyfxS8f48aZu+eQped+nqanx8s+sw=; b=ABUwrMYAkyESdjSWcSwybKocQa
        7Jj9wYYXjerOEETCCXJZxxcA5FN/6ByXmf9Zr3xOKZlqoNPmwMGm+1+dNXxpL7bBrwZl86FbiUDku
        Em3Ts8uY6lPcEW5GUlGQOViiYmO4WPlS6MnLSU4SleZW/NEs6tHgHljKafTwiRA5g/RZHQmzSJOc9
        D7paS6Gm5WbiDG2L/pifQ6JAVQNRNIESVpmt1KTh//QBCqCzqjZbWX4JuqCitujoG8e9zh4MmV0ls
        zQiqoQQise/bRDHPUQWDwPbgS+FQqGS21ehKDOTCkObRrkXa0DTCrec4gCFwn1lHwqQhMyQjoEhAS
        IGnpYlBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzLAR-004vhr-U3; Tue, 12 Jan 2021 15:01:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19F70301A32;
        Tue, 12 Jan 2021 16:01:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0647E20C228EB; Tue, 12 Jan 2021 16:01:07 +0100 (CET)
Date:   Tue, 12 Jan 2021 16:01:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH] x86: PM: Register syscore_ops for scale invariance
Message-ID: <X/25ssA2scFSu+3/@hirez.programming.kicks-ass.net>
References: <1803209.Mvru99baaF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1803209.Mvru99baaF@kreacher>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 08, 2021 at 07:05:59PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On x86 scale invariace tends to be disabled during resume from
> suspend-to-RAM, because the MPERF or APERF MSR values are not as
> expected then due to updates taking place after the platform
> firmware has been invoked to complete the suspend transition.
> 
> That, of course, is not desirable, especially if the schedutil
> scaling governor is in use, because the lack of scale invariance
> causes it to be less reliable.
> 
> To counter that effect, modify init_freq_invariance() to register
> a syscore_ops object for scale invariance with the ->resume callback
> pointing to init_counter_refs() which will run on the CPU starting
> the resume transition (the other CPUs will be taken care of the
> "online" operations taking place later).
> 
> Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!, I'll take it through the sched/urgent tree?
