Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168AD357F4B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 11:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhDHJff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 05:35:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35107 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229640AbhDHJfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 05:35:34 -0400
X-UUID: 0383ff6ce9bf4bad9b1b029f77ae1c80-20210408
X-UUID: 0383ff6ce9bf4bad9b1b029f77ae1c80-20210408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 360498388; Thu, 08 Apr 2021 17:35:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Apr 2021 17:35:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 17:35:17 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 1/6] PM: runtime: enable wake irq after runtime_suspend hook called
Date:   Thu, 8 Apr 2021 17:35:09 +0800
Message-ID: <1617874514-12282-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E5C6DB1EBBB6601790860FBE2A607D826DC4ADE8017410E55972F9D1B0FDA48D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the dedicated wake irq is level trigger, enable it before
calling runtime_suspend, will trigger an interrupt.

e.g.
for a low level trigger type, it's low level at running time (0),
and becomes high level when enters suspend (runtime_suspend (1) is
called), a wakeup signal at (2) make it become low level, wake irq
will be triggered.

                ------------------
               |           ^     ^|
----------------           |     | --------------
 |<---(0)--->|<--(1)--|   (3)   (2)    (4)

if we enable the wake irq before calling runtime_suspend during (0),
an interrupt will arise, it causes resume immediately;
enable wake irq after calling runtime_suspend, e.g. at (3) or (4),
will works.

This patch seems no side effect on edge trigger wake irq.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/base/power/runtime.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index a46a7e30881b..796739a015a5 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -619,12 +619,12 @@ static int rpm_suspend(struct device *dev, int rpmflags)
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
@@ -659,7 +659,6 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	return retval;
 
  fail:
-	dev_pm_disable_wake_irq_check(dev);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
-- 
2.18.0

