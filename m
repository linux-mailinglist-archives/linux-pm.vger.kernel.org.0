Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2536B13A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfGPVk2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 17:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbfGPVk2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 17:40:28 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17637206C2;
        Tue, 16 Jul 2019 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563313227;
        bh=DsJllMIph7rrpdefmAd2AzgdJy2cvJ1qoXgL7T7usRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gT69QE+d5wzTTSXhV5hoXTFHOiN0EX47IbcE2DOtxiYNQReYbvTY8CGgt6YS2Vyq6
         ugXB91GW9ykT//bPrcIOC4Q1Fg6oRQPe9cc2ML0j83sGuS/5J6mgbtHUj764WNdyXN
         r36J7y+AZ0/tB0Q7l8Fmf7XENBtk0t6WMHFTbnK0=
Date:   Tue, 16 Jul 2019 23:40:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuidle: Always stop scheduler tick on adaptive-tick CPUs
Message-ID: <20190716214024.GA8345@lenoir>
References: <6254683.2O5gIZElE2@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6254683.2O5gIZElE2@kreacher>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 05:25:10PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Running the scheduler tick on idle adaptive-tick CPUs is not useful

Judging by the below change, you mean full dynticks, right?

> and it may also be not expected by users (as reported by Thomas), so
> add a check to cpuidle_idle_call() to always stop the tick on them
> regardless of the idle duration predicted by the governor.
> 
> Fixes: 554c8aa8ecad ("sched: idle: Select idle state before stopping the tick")
> Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> Tested-by: Thomas Lindroth <thomas.lindroth@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/idle.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -191,7 +191,8 @@ static void cpuidle_idle_call(void)
>  		 */
>  		next_state = cpuidle_select(drv, dev, &stop_tick);
>  
> -		if (stop_tick || tick_nohz_tick_stopped())
> +		if (stop_tick || tick_nohz_tick_stopped() ||
> +		    !housekeeping_cpu(dev->cpu, HK_FLAG_TICK))

But tick_nohz_tick_stopped() also works on full dynticks CPUs. If the
tick isn't stopped on a full dynticks CPU by the time we reach this path,
it means that the conditions for the tick to be stopped are not met anyway
(eg: more than one task and sched tick is needed, perf event requires the tick,
posix CPU timer, etc...)

Or am I missing something else?

Thanks.

>  			tick_nohz_idle_stop_tick();
>  		else
>  			tick_nohz_idle_retain_tick();
> 
> 
> 
