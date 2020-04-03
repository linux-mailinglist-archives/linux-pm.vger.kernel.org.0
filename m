Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6656819DF23
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgDCUUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:20:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:6373 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbgDCUUf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:35 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBm4Y0HzwF;
        Fri,  3 Apr 2020 22:20:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945232; bh=8lunpxS98lM0f3PoyUteDz8Xwp4fV51FcDnCqkylrZA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Iyc0obibgawtZkWUWAKT3QtXps6e0EkHwuuOe0/HzZabBKfljWUBGOjUg5nO84hb4
         xscPRpuTcyt2UYGEqFNbwhcwwCkP8sRwEXpZuM3keOTBwQw2DXmhOiUaaQfLGLymWp
         qZ9AXgb6ZyNmy+opgTV1kLK8kAwSli8epThhipPumDl90KQkeTQ44eH6k2xXlTytbZ
         Z7f1s4NJXBXIvYoDGOImyyYMi7UQvARsjDNuHli3lknqjBWZglekfsCd0D6bVk61eC
         Cn9msf8VmW+gHpCYy2pgT++GVrunHRlDaQGEqnR4D3xHg0PrLBpcVos2hBaEvvDzST
         gAH7rGJP3bqBw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:32 +0200
Message-Id: <16ca50739c664b3fa373306f3c08882d9d4cf55d.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 04/11] power: supply: core: reduce
 power_supply_show_usb_type() parameters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reduce power_supply_show_usb_type() parameter count by folding
power_supply_desc dereference into the function.  This makes following
patch making usb_types const easier.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/power_supply_sysfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4eae60b..51de3f47b25d 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -78,8 +78,7 @@ static const char * const power_supply_scope_text[] = {
 };
 
 static ssize_t power_supply_show_usb_type(struct device *dev,
-					  enum power_supply_usb_type *usb_types,
-					  ssize_t num_usb_types,
+					  const struct power_supply_desc *desc,
 					  union power_supply_propval *value,
 					  char *buf)
 {
@@ -88,8 +87,8 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 	bool match = false;
 	int i;
 
-	for (i = 0; i < num_usb_types; ++i) {
-		usb_type = usb_types[i];
+	for (i = 0; i < desc->num_usb_types; ++i) {
+		usb_type = desc->usb_types[i];
 
 		if (value->intval == usb_type) {
 			count += sprintf(buf + count, "[%s] ",
@@ -163,8 +162,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 			      power_supply_type_text[value.intval]);
 		break;
 	case POWER_SUPPLY_PROP_USB_TYPE:
-		ret = power_supply_show_usb_type(dev, psy->desc->usb_types,
-						 psy->desc->num_usb_types,
+		ret = power_supply_show_usb_type(dev, psy->desc,
 						 &value, buf);
 		break;
 	case POWER_SUPPLY_PROP_SCOPE:
-- 
2.20.1

