Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC61E19DF2D
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgDCUUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:20:37 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:35348 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgDCUUg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBq2x0Sz1vh;
        Fri,  3 Apr 2020 22:20:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945235; bh=q44ic6PpS5HegVJV8bApjvL5Ua5oyJ9Mja9QqVR2KlQ=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=EOlslryS4tsUMrgf2EBgKRtOIEpupr3plYDe1T8//jZPzFw9Dhb1ijd714LO/u+Mk
         02bFa8FJqZT38WuWolb7fOh0Row9qUAt2mgMzALLSAZ+cE+NWGLITYO29s4Ub0CyYw
         +tRO1qWAPB//biSshR/Xmit2aKLF771ZJBfkuN+ku+yfQTYdT0NB1r3eeiQ02EMH3m
         h02YqQNvxPuNgHGjwnIYQ5fHJ1mvmKvg+uJAopTZhLNrj70/YniIuqZiV5/ObXiH7Q
         0s7Vj7x4y77dcPvb12DPFyKz7+u9bmLnOH92rkCwFjhCnRwq5+g0pNWH+RL8lXwhMY
         APfRkJUdwIG7w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:34 +0200
Message-Id: <7ac1176497a246b59316efecef9912dcf9b1e48a.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 08/11] power: supply: core: hide unused HWMON labels
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

Currently HWMON emulation shows all labels (temp and ambient temp)
regardless if power supply supports reading the values. Check that at
least one property is enabled for each label.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v3: use a tabule for type checking instead of switch() sequence
---
 drivers/power/supply/power_supply_hwmon.c | 42 +++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 5621e72a39f0..1b473deaf391 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -103,6 +103,39 @@ static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
 	return type == hwmon_temp && attr == hwmon_temp_label;
 }
 
+struct hwmon_type_attr_list {
+	const u32 *attrs;
+	size_t n_attrs;
+};
+
+static const u32 ps_temp_attrs[] = {
+	hwmon_temp_input,
+	hwmon_temp_min, hwmon_temp_max,
+	hwmon_temp_min_alarm, hwmon_temp_max_alarm,
+};
+
+static const struct hwmon_type_attr_list ps_type_attrs[hwmon_max] = {
+	[hwmon_temp] = { ps_temp_attrs, ARRAY_SIZE(ps_temp_attrs) },
+};
+
+static bool power_supply_hwmon_has_input(
+	const struct power_supply_hwmon *psyhw,
+	enum hwmon_sensor_types type, int channel)
+{
+	const struct hwmon_type_attr_list *attr_list = &ps_type_attrs[type];
+	size_t i;
+
+	for (i = 0; i < attr_list->n_attrs; ++i) {
+		int prop = power_supply_hwmon_to_property(type,
+			attr_list->attrs[i], channel);
+
+		if (prop >= 0 && test_bit(prop, psyhw->props))
+			return true;
+	}
+
+	return false;
+}
+
 static bool power_supply_hwmon_is_writable(enum hwmon_sensor_types type,
 					   u32 attr)
 {
@@ -129,9 +162,12 @@ static umode_t power_supply_hwmon_is_visible(const void *data,
 	const struct power_supply_hwmon *psyhw = data;
 	int prop;
 
-
-	if (power_supply_hwmon_is_a_label(type, attr))
-		return 0444;
+	if (power_supply_hwmon_is_a_label(type, attr)) {
+		if (power_supply_hwmon_has_input(psyhw, type, channel))
+			return 0444;
+		else
+			return 0;
+	}
 
 	prop = power_supply_hwmon_to_property(type, attr, channel);
 	if (prop < 0 || !test_bit(prop, psyhw->props))
-- 
2.20.1

