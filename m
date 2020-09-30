Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33BA27E7B2
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 13:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgI3Ldf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 07:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3Lde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 07:33:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ABDC061755
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mGXif5c1D0bP4N9KNJlE5DzIZgbdve743XcY4Tk32Oc=; b=rQ59hkASANGuZsk3OexuzhblSz
        9OMAz1xQFLj4Vm0ZK9r9hLMYNqSoN9CkTKzDnRklzd9JLb7cMryLPObBjMShtNhd3C0FbjsR/4tf3
        maQcCS+W7De/vahGaso1Tr/3F8DjJkFAa4KBt96Xfz7u/4g33CJ8uCrXyP9VrGO6MIsiSo7YY90BK
        4aKF/cxIAB7F8Ll5svEG7xDwQHTzkizSOuK4WjGDYiQYEmZJGs+aqnyZ8Sd043vaiiy2gO6Xw/2ZA
        MxCFU1V2xKMf2ldbmnkiYWXUoiK8e4xKZBPraldL8zKfpPlItW3pmYpilntuIW0F5id4MldKW6Lfw
        zaOSxBzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNaMQ-0006s1-BE; Wed, 30 Sep 2020 11:33:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A01A23003D8;
        Wed, 30 Sep 2020 13:33:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 819E2202A40A0; Wed, 30 Sep 2020 13:33:25 +0200 (CEST)
Date:   Wed, 30 Sep 2020 13:33:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anson Huang <anson.huang@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx6q: Fixup RCU usage for cpuidle
Message-ID: <20200930113325.GA2628@hirez.programming.kicks-ass.net>
References: <20200930112023.121821-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930112023.121821-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 30, 2020 at 01:20:23PM +0200, Ulf Hansson wrote:
> The commit eb1f00237aca ("lockdep,trace: Expose tracepoints"), started to
> expose us for tracepoints. For imx6q cpuidle, this leads to an RCU splat
> according to below.
> 
> [6.870684] [<c0db7690>] (_raw_spin_lock) from [<c011f6a4>] (imx6q_enter_wait+0x18/0x9c)
> [6.878846] [<c011f6a4>] (imx6q_enter_wait) from [<c09abfb0>] (cpuidle_enter_state+0x168/0x5e4)
> 
> To fix the problem, let's assign the corresponding idlestate->flags the
> CPUIDLE_FLAG_RCU_IDLE bit, which enables us to call rcu_idle_enter|exit()
> at the proper point.
> 
> Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Yep, that looks about right.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/arm/mach-imx/cpuidle-imx6q.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> index 24dd5bbe60e4..094337dc1bc7 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -24,7 +24,9 @@ static int imx6q_enter_wait(struct cpuidle_device *dev,
>  		imx6_set_lpm(WAIT_UNCLOCKED);
>  	raw_spin_unlock(&cpuidle_lock);
>  
> +	rcu_idle_enter();
>  	cpu_do_idle();
> +	rcu_idle_exit();
>  
>  	raw_spin_lock(&cpuidle_lock);
>  	if (num_idle_cpus-- == num_online_cpus())
> @@ -44,7 +46,7 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
>  		{
>  			.exit_latency = 50,
>  			.target_residency = 75,
> -			.flags = CPUIDLE_FLAG_TIMER_STOP,
> +			.flags = CPUIDLE_FLAG_TIMER_STOP | CPUIDLE_FLAG_RCU_IDLE,
>  			.enter = imx6q_enter_wait,
>  			.name = "WAIT",
>  			.desc = "Clock off",
> -- 
> 2.25.1
> 
