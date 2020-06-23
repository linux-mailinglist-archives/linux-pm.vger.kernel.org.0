Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D5205A05
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFWR6C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 13:58:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46216 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWR6C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 13:58:02 -0400
Received: from 89-64-86-94.dynamic.chello.pl (89.64.86.94) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 8d4284b4e984008f; Tue, 23 Jun 2020 19:58:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2][v3] PM / s2idle: Code cleanup to make s2idle consistent with normal idle path
Date:   Tue, 23 Jun 2020 19:57:59 +0200
Message-ID: <15473183.xuek0xzqYe@kreacher>
In-Reply-To: <a00278cc5db9f4845006cff130fd91a58c0d92d1.1592892767.git.yu.c.chen@intel.com>
References: <cover.1592892767.git.yu.c.chen@intel.com> <a00278cc5db9f4845006cff130fd91a58c0d92d1.1592892767.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, June 23, 2020 8:31:52 AM CEST Chen Yu wrote:
> Currently s2idle is a little different from the normal idle path. This
> patch makes call_s2idle() consistent with call_cpuidle(), and also
> s2idle_enter() is analogous to cpuidle_enter().
> 
> No functional change.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/cpuidle/cpuidle.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index e092789187c6..b2e764d1ac99 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -134,8 +134,8 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
>  }
>  
>  #ifdef CONFIG_SUSPEND
> -static void enter_s2idle_proper(struct cpuidle_driver *drv,
> -				struct cpuidle_device *dev, int index)
> +static void s2idle_enter(struct cpuidle_driver *drv,
> +			 struct cpuidle_device *dev, int index)
>  {
>  	ktime_t time_start, time_end;
>  
> @@ -169,6 +169,15 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
>  	dev->states_usage[index].s2idle_usage++;
>  }
>  
> +static int call_s2idle(struct cpuidle_driver *drv,
> +		       struct cpuidle_device *dev, int index)
> +{
> +	if (!current_clr_polling_and_test())
> +		s2idle_enter(drv, dev, index);
> +

Well, I'd rather move the definition of this function to idle.c, because it is
better to call current_clr_polling_and_test() from there.

> +	return index;
> +}
> +
>  /**
>   * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
>   * @drv: cpuidle driver for the given CPU.
> @@ -187,8 +196,8 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	 * be frozen safely.
>  	 */
>  	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> -	if (index > 0 && !current_clr_polling_and_test())
> -		enter_s2idle_proper(drv, dev, index);
> +	if (index > 0)
> +		call_s2idle(drv, dev, index);

This can be made look more like cpuidle_enter() too.

>  
>  	return index;
>  }
> 

So overall I'd prefer to apply something like this (on top of the [1/2]):

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpuidle: Rearrange s2idle-specific idle state entry code

Implement call_cpuidle_s2idle() in analogy with call_cpuidle()
for the s2idle-specific idle state entry and invoke it from
cpuidle_idle_call() to make the s2idle-specific idle entry code
path look more similar to the "regular" idle entry one.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |    6 +++---
 kernel/sched/idle.c       |   15 +++++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -96,6 +96,15 @@ void __cpuidle default_idle_call(void)
 	}
 }
 
+static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
+			       struct cpuidle_device *dev)
+{
+	if (current_clr_polling_and_test())
+		return -EBUSY;
+
+	return cpuidle_enter_s2idle(drv, dev);
+}
+
 static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		      int next_state)
 {
@@ -171,11 +180,9 @@ static void cpuidle_idle_call(void)
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
-			entered_state = cpuidle_enter_s2idle(drv, dev);
-			if (entered_state > 0) {
-				local_irq_enable();
+			entered_state = call_cpuidle_s2idle(drv, dev);
+			if (entered_state > 0)
 				goto exit_idle;
-			}
 
 			rcu_idle_exit();
 
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
-#include <linux/sched/idle.h>
 #include <linux/notifier.h>
 #include <linux/pm_qos.h>
 #include <linux/cpu.h>
@@ -187,9 +186,10 @@ int cpuidle_enter_s2idle(struct cpuidle_
 	 * be frozen safely.
 	 */
 	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
-	if (index > 0 && !current_clr_polling_and_test())
+	if (index > 0) {
 		enter_s2idle_proper(drv, dev, index);
-
+		local_irq_enable();
+	}
 	return index;
 }
 #endif /* CONFIG_SUSPEND */



