Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE01C19DF31
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgDCUUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:20:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:29625 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbgDCUUg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBp3KTDz1vW;
        Fri,  3 Apr 2020 22:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945234; bh=st442Vea3rx7okupetdaDNbMLKhGLcbOOTUyYMwJJxU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ijfTS3sJW7Y6snZhLxrF6L9qpgGvMgFWOcy9O8so3V9kYbdMVbUANF9ysVpxfHLzc
         Qkx6EXmGGBe7gPzXbyd6rDyuGQepGLGNa2xtpphdGtAUwwGuNWM18cydh+syS5Jy7e
         SFcUmySB9GfeMpPL8uUYGfH654UvaP+VGcAEwH0cuTRrsQ4NSEZeOfp4J9PKGvipoJ
         x2ZVZvX1dsQ9m+BNxQw/iyWnceD0/CRO5ZKEplihQwZddInqYfX2Rg3s2fb3zT3T6w
         KeKyHR4QibDSJUy/Ak6MRBhb8t5XQJyEgwuvFwwb60CFL12HiRziHQlhUd1Eqc1LXY
         QwFQNOfetxi6g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:33 +0200
Message-Id: <29b5043db9a51ef7a0cb6e3a8c69c91e36045cd6.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 07/11] power: supply: core: tabularize HWMON temperature
 labels
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

Rework power_supply_hwmon_read_string() to check it's parameters.
This allows to extend it later with labels for other types of
measurements.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: split from fix temperature labels
v3: remove power_supply_hwmon_read_string() parameter checks
    as it is internal API (suggested by Guenter Roeck)
---
 drivers/power/supply/power_supply_hwmon.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 67b6ee60085e..5621e72a39f0 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -13,6 +13,11 @@ struct power_supply_hwmon {
 	unsigned long *props;
 };
 
+static const char *const ps_temp_label[] = {
+	"temp",
+	"ambient temp",
+};
+
 static int power_supply_hwmon_in_to_property(u32 attr)
 {
 	switch (attr) {
@@ -144,7 +149,14 @@ static int power_supply_hwmon_read_string(struct device *dev,
 					  u32 attr, int channel,
 					  const char **str)
 {
-	*str = channel ? "temp ambient" : "temp";
+	switch (type) {
+	case hwmon_temp:
+		*str = ps_temp_label[channel];
+		break;
+	default:
+		unreachable();
+	}
+
 	return 0;
 }
 
-- 
2.20.1

