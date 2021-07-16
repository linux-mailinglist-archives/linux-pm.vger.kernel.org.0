Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29453CB53A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhGPJ0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 05:26:32 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24881 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232644AbhGPJ0c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 05:26:32 -0400
X-UUID: 37a12d0bd6a1455f933c25f7df2eea8e-20210716
X-UUID: 37a12d0bd6a1455f933c25f7df2eea8e-20210716
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1538404821; Fri, 16 Jul 2021 17:23:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 17:23:26 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Jul 2021 17:23:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ikjoon Jang <ikjn@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH v2] PM: runtime: enable wake irq after runtime_suspend hook called
Date:   Fri, 16 Jul 2021 17:23:01 +0800
Message-ID: <1626427381-30131-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 98801C3A6DA5502926890C972FFD7F58BDD0757917DD0C1D5AE2E3442D4A068A2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the dedicated wake-irq is level trigger, and it uses the
consumer's sleep status as the wakeup source, that means if the
consumer is not in sleep state, the wake-irq will be triggered
when enable it; For this case, need enable the wake-irq after
invoking the consumer's runtime_suspend() which make the consumer
enter sleep state.

e.g.
Assume the wake-irq is a low level trigger type, and the wakeup
signal comes from the sleep status of consumer.
The wakeup signal is low level at running time (0), and becomes
high level when the consumer enters sleep state (runtime_suspend
(1) is called), a wakeup event at (2) make the consumer exit sleep
state, then the wakeup signal also becomes low level.

                ------------------
               |           ^     ^|
----------------           |     | --------------
 |<---(0)--->|<--(1)--|   (3)   (2)    (4)

if enable the wake-irq before calling runtime_suspend during (0),
an interrupt will arise, it causes resume immediately;
it works if enable wake-irq ( e.g. at (3) or (4)) after calling
runtime_suspend.

In this example, can't fix it by using falling edge trigger without
this patch, the issue will happen as below steps:
1. use another wakeup source to wake up the suspended system;
2. the consumer's resume() will be called, and exits sleep state;
3. the consumer's wakeup signal will fall into low level, due to
   currently the wakeup irq is disabled, the wake-irq is pending;
4. the consumer tries to enter runtime suspend, but there is a
   pending wakeup irq, so will resume again, this will repeat
   endlessly.

This patch seems no side effect on edge trigger wake-irq that works
before.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add more commit message

  I use the falling edge trigger interrupt suggested by Ikjoon [1], it
works well at firstly when only use this related wakeup source, but
encounter issues if use other wakeup sources to wakeup platform as
described in commit message.
  Send out the patch again for further discussion.

[1]: https://patchwork.kernel.org/patch/12190407

---
 drivers/base/power/runtime.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8a66eaf731e4..90a91b2b1364 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -639,12 +639,12 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	__update_runtime_status(dev, RPM_SUSPENDING);
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
-
-	dev_pm_enable_wake_irq_check(dev, true);
 	retval = rpm_callback(callback, dev);
 	if (retval)
 		goto fail;
 
+	dev_pm_enable_wake_irq_check(dev, true);
+
  no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
@@ -690,7 +690,6 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	return retval;
 
  fail:
-	dev_pm_disable_wake_irq_check(dev);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
-- 
2.18.0

