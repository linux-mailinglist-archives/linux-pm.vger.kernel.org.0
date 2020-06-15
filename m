Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37CD1F9F91
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 20:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgFOSkq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731279AbgFOSkp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 14:40:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81E9C061A0E;
        Mon, 15 Jun 2020 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zN/Nv/pr9vVaSfZ2zDdo/huhxeODkyXQIX0vAvnL4ec=; b=IDDUm1JDiDC43AnkAetdgjEzKd
        Ayvpow2HB0p5VOLLx1Kv1Yc4iHD+J8HRUFy3d+wL13OMzmdTa+bkkdU+pWwM7PwB39hZuuY8qJCdE
        xh4jT4KFsNmlGK3RPC6E1rasSWhSn3Oy5A0B9AkkmUe5Nlq+FBk5gQrVhbDKsc1Nu2GC8lV2ErIiO
        FKrKjtSHfOn0oywBlXdtMO5hr1q4SeA4GWxy2s3X1zNIv3fv53gZ3Hu9Pgfapcr9N1j5kd9du+T7a
        o5XWdld6a0L5Q4KB+l/jybedI35DwVe/k3yxr+zoXbamDjmcOgM3CmPoiOZfbPcV4KT8XtX63AqFh
        0StLd1ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jku2F-0002py-HS; Mon, 15 Jun 2020 18:40:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1654306089;
        Mon, 15 Jun 2020 20:40:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC6F4201CB85A; Mon, 15 Jun 2020 20:40:41 +0200 (CEST)
Date:   Mon, 15 Jun 2020 20:40:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PM / s2idle: Clear _TIF_POLLING_NRFLAG before
 suspend to idle
Message-ID: <20200615184041.GG2531@hirez.programming.kicks-ass.net>
References: <20200615173611.15349-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615173611.15349-1-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 16, 2020 at 01:36:11AM +0800, Chen Yu wrote:
> Suspend to idle was found to not work on Goldmont CPU recently.
> And the issue was triggered due to:
> 
> 1. On Goldmont the CPU in idle can only be woken up via IPIs,
>    not POLL mode:
>    Commit 08e237fa56a1 ("x86/cpu: Add workaround for MONITOR
>    instruction erratum on Goldmont based CPUs")
> 2. When the CPU is entering suspend to idle process, the
>   _TIF_POLLING_NRFLAG is kept on.
> 3. Commit b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
>    makes use of _TIF_POLLING_NRFLAG to avoid sending IPIs to
>    idle CPUs.
> 4. As a result, some IPIs related functions might not work
>    well during suspend to idle on Goldmont. For example, one
>    suspected victim:
>    tick_unfreeze() -> timekeeping_resume() -> hrtimers_resume()
>    -> clock_was_set() -> on_each_cpu() might wait forever,
>    because the IPIs will not be sent to the CPUs which are
>    sleeping with _TIF_POLLING_NRFLAG set, and Goldmont CPU
>    could not be woken up by only setting _TIF_NEED_RESCHED
>    on the monitor address.

*sigh*... just what we need.


> @@ -186,8 +187,10 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	 * be frozen safely.
>  	 */
>  	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> -	if (index > 0)
> +	if (index > 0) {
> +		__current_clr_polling();
>  		enter_s2idle_proper(drv, dev, index);
> +	}
>  
>  	return index;
>  }

So how is that commit 08e237fa56a1 not suffient? That makes
mwait_idle_with_hints() DTRT for this 'functionally challenged' piece of
hardware.

AFAICT intel_enter_s2idle() uses mwait_idle_with_hints().

What am I missing?
