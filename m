Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3B749EB47
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbiA0Tob (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jan 2022 14:44:31 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:59312 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbiA0To2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jan 2022 14:44:28 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 9B092205483E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] power: supply: mp2629_charger: use platform_get_irq()
Organization: Open Mobile Platform
To:     Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>
CC:     Saravanan Sekar <sravanhome@gmail.com>
Message-ID: <618c2445-724f-8be5-47a6-c8739489f56f@omp.ru>
Date:   Thu, 27 Jan 2022 22:44:25 +0300
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

Calling platform_get_irq_optional() doesn't make sense if you then bail out
on any error it returns.  Switch to calling platform_get_irq() instead and
remove dev_err() call as platform_get_irq() already curses loudly on error.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Sebastian Reichel's
'linux-power-supply.git' repo.

 drivers/power/supply/mp2629_charger.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-power-supply/drivers/power/supply/mp2629_charger.c
===================================================================
--- linux-power-supply.orig/drivers/power/supply/mp2629_charger.c
+++ linux-power-supply/drivers/power/supply/mp2629_charger.c
@@ -580,11 +580,9 @@ static int mp2629_charger_probe(struct p
 	charger->dev = dev;
 	platform_set_drvdata(pdev, charger);
 
-	irq = platform_get_irq_optional(to_platform_device(dev->parent), 0);
-	if (irq < 0) {
-		dev_err(dev, "get irq fail: %d\n", irq);
+	irq = platform_get_irq(to_platform_device(dev->parent), 0);
+	if (irq < 0)
 		return irq;
-	}
 
 	for (i = 0; i < MP2629_MAX_FIELD; i++) {
 		charger->regmap_fields[i] = devm_regmap_field_alloc(dev,
