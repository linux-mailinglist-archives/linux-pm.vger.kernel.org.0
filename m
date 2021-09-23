Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5E4162A9
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbhIWQGE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242405AbhIWQGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 12:06:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2CAC061756;
        Thu, 23 Sep 2021 09:04:30 -0700 (PDT)
Message-ID: <20210923153339.746654947@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632413069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w42oYem1Txk9Mic7XpqKf9n3jDnZdt7JZmS9PQDeSVk=;
        b=4bMSztB2DO8neREKH2XROIJCXPLT3gNNotwW5JUopESKMgDTLJp6iC3+VSCT3bMcpIsriy
        5X7J24TqPxszoYHnMDaZwyJ2Sa3Ztt++9Yh9JDDfJ7OGPNR73/rgpjbzouWXrBcjLK1mzY
        Gzc37sJvv0AHfQLYfVzlOtRhucl1oraGcjsqx3cDXWNoKhf5f1Q+4FS3RuSA0+KEAuuIG+
        L5Z8PnvM1gcZwvO7tdXWPemn7DOF/vbYP9Ejjj0obrbKP5+b/cg434GZAyncbs1IjiU/Xp
        iVqnAJ85XRlhUi92jhaZaI+oqKvVyJ+A+WHiHZnnO1c+MWYNysskjPWDepCclA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632413069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w42oYem1Txk9Mic7XpqKf9n3jDnZdt7JZmS9PQDeSVk=;
        b=JurGoxIoInhfo7TQbGr1HNz0kXIjNRHncDkjkf7upb5tfyYutS2D3UjSZAj+mJMVloNdi9
        MSJaohWnsFsky1Aw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [patch 06/11] power: reset: ltc2952: Use hrtimer_forward_now()
References: <20210923153311.225307347@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:04:28 +0200 (CEST)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hrtimer_forward_now() provides the same functionality as the open coded
hrtimer_forward() invocation. Prepares for removal of hrtimer_forward()
from the public interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/reset/ltc2952-poweroff.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -94,7 +94,6 @@ static struct ltc2952_poweroff *ltc2952_
  */
 static enum hrtimer_restart ltc2952_poweroff_timer_wde(struct hrtimer *timer)
 {
-	ktime_t now;
 	int state;
 	struct ltc2952_poweroff *data = to_ltc2952(timer, timer_wde);
 
@@ -104,8 +103,7 @@ static enum hrtimer_restart ltc2952_powe
 	state = gpiod_get_value(data->gpio_watchdog);
 	gpiod_set_value(data->gpio_watchdog, !state);
 
-	now = hrtimer_cb_get_time(timer);
-	hrtimer_forward(timer, now, data->wde_interval);
+	hrtimer_forward_now(timer, data->wde_interval);
 
 	return HRTIMER_RESTART;
 }

