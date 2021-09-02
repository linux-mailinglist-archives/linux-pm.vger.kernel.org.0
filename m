Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE03FF552
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 23:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbhIBVHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 17:07:44 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:49678 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344283AbhIBVHo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 17:07:44 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 17:07:43 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 407352032404
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-pm@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH power core: wakeirq: kill useless parameter in
 dev_pm_attach_wake_irq()
Organization: Open Mobile Platform
Message-ID: <c670e963-0059-0da8-0273-ef0170fb769d@omp.ru>
Date:   Thu, 2 Sep 2021 23:57:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This function has the 'irq' parameter which isn't ever used, so let's kill it. 

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
The patch is against the 'linux-next' branch of the Rafael J. Wysocki's
'linux-=pm.git' repo.

 drivers/base/power/wakeirq.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/base/power/wakeirq.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeirq.c
+++ linux-pm/drivers/base/power/wakeirq.c
@@ -12,14 +12,11 @@
 /**
  * dev_pm_attach_wake_irq - Attach device interrupt as a wake IRQ
  * @dev: Device entry
- * @irq: Device wake-up capable interrupt
  * @wirq: Wake irq specific data
  *
- * Internal function to attach either a device IO interrupt or a
- * dedicated wake-up interrupt as a wake IRQ.
+ * Internal function to attach a dedicated wake-up interrupt as a wake IRQ.
  */
-static int dev_pm_attach_wake_irq(struct device *dev, int irq,
-				  struct wake_irq *wirq)
+static int dev_pm_attach_wake_irq(struct device *dev, struct wake_irq *wirq)
 {
 	unsigned long flags;
 
@@ -65,7 +62,7 @@ int dev_pm_set_wake_irq(struct device *d
 	wirq->dev = dev;
 	wirq->irq = irq;
 
-	err = dev_pm_attach_wake_irq(dev, irq, wirq);
+	err = dev_pm_attach_wake_irq(dev, wirq);
 	if (err)
 		kfree(wirq);
 
@@ -196,7 +193,7 @@ int dev_pm_set_dedicated_wake_irq(struct
 	if (err)
 		goto err_free_name;
 
-	err = dev_pm_attach_wake_irq(dev, irq, wirq);
+	err = dev_pm_attach_wake_irq(dev, wirq);
 	if (err)
 		goto err_free_irq;
 
