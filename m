Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726791FA04A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 21:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFOTcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 15:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgFOTcR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 15:32:17 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F89C061A0E;
        Mon, 15 Jun 2020 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hcm83hMigudu0Xpe7RxqUCEEp9+mEn66rOJQWXNEKic=; b=fBAylcZRdHf57eCzHMqC5aW0w2
        UysR/1TxV8XpySMkXBbK/OBgZL3LD2gtDSkVymWzANOjFpMwt4g9XDuV7Bpq+rz/hzJRn/YSZJwM/
        85HUS5J1S1usG6Lar/Lam5CsZblON76imIj/nmrdOMwoQcmnX+n/Uv8RING7Q5H0bCh75Q8kRbtOt
        ZwlmIoTcuNwWlvJpasO8NW66XI6NJcMz8ezWLbwCs3RlJ80Qu+HX8KVTdGNkHFAjhH8rWP80YgQXU
        RD/W1Y7Av6pHJMFkJeuZoG5/HzctCXHqnRe5e9jTxHlwcvAtevkDTuRa6MD9jLi53QA6YgNGE8qjz
        KfKzbRQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkupo-0005CN-Tf; Mon, 15 Jun 2020 19:31:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9AB74301A32;
        Mon, 15 Jun 2020 21:31:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E857201CB859; Mon, 15 Jun 2020 21:31:54 +0200 (CEST)
Date:   Mon, 15 Jun 2020 21:31:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] PM / s2idle: Clear _TIF_POLLING_NRFLAG before
 suspend to idle
Message-ID: <20200615193154.GJ2554@hirez.programming.kicks-ass.net>
References: <20200615173611.15349-1-yu.c.chen@intel.com>
 <20200615184041.GG2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615184041.GG2531@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15, 2020 at 08:40:41PM +0200, Peter Zijlstra wrote:

> > @@ -186,8 +187,10 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> >  	 * be frozen safely.
> >  	 */
> >  	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
> > -	if (index > 0)
> > +	if (index > 0) {
> > +		__current_clr_polling();
> >  		enter_s2idle_proper(drv, dev, index);
> > +	}
> >  
> >  	return index;
> >  }
> 
> So how is that commit 08e237fa56a1 not suffient? That makes
> mwait_idle_with_hints() DTRT for this 'functionally challenged' piece of
> hardware.
> 
> AFAICT intel_enter_s2idle() uses mwait_idle_with_hints().
> 
> What am I missing?

What's missing is that cpuidle_enter_s2idle() doesn't properly match
call_cpuidle().

Something like so then. Your version is racy, if someone already set
TIF_NEED_RESCHED you just clear POLLING and go to sleep.

---

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c149d9e20dfd..81bee8d03c6d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -133,8 +133,8 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 }
 
 #ifdef CONFIG_SUSPEND
-static void enter_s2idle_proper(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev, int index)
+static void s2idle_enter(struct cpuidle_driver *drv,
+			 struct cpuidle_device *dev, int index)
 {
 	ktime_t time_start, time_end;
 
@@ -168,6 +168,15 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	dev->states_usage[index].s2idle_usage++;
 }
 
+static int call_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		       int index)
+{
+	if (!current_clr_polling_and_test())
+		s2idle_enter(drv, dev, index);
+
+	return index;
+}
+
 /**
  * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
  * @drv: cpuidle driver for the given CPU.
@@ -187,7 +196,7 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 */
 	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
 	if (index > 0)
-		enter_s2idle_proper(drv, dev, index);
+		call_s2idle(drv, dev, index);
 
 	return index;
 }
