Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632E619DB7F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404409AbgDCQXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:23:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:16700 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbgDCQXd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 12:23:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v4xH1Vr3zGl;
        Fri,  3 Apr 2020 18:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585931011; bh=8lunpxS98lM0f3PoyUteDz8Xwp4fV51FcDnCqkylrZA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=fFBoOCiZ3YnSg5A6zUE339EV7k7+8yHYKQWCFtzyFZ0tvOtnw0RyquTHs97P3VKXK
         gmvevHujRta48yTH8VpBv2ePoL4FPhMmpyAJatiMkfrKSYM4EzsjeHnxZzN/ZOYDuA
         D1pDHuQfAct9TqwXTXU1hOJ/ZiVECVgfl3k1q1sywZ4eIy5tVQ/xJuNZbJl2SOGE54
         IRXSLlKm8L4sT2uKmkO7xlV2Nu3hZZVvgtNpxvOjBzCy6nig0Z17RXvva9cdaUXpaD
         pXt4JtxVWF73hhUmS4MhsCjHLIxnEqkXhBgMhNHj7DzsHvoM9wJosdA8iZXhejPRHO
         WHy7Rh7pi44hQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 18:23:29 +0200
Message-Id: <cdf9c0b02acdee77721039d4e7557e0e232d837d.1585929579.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/8] power: supply: core: reduce
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

