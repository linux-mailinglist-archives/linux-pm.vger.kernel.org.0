Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 498E719DB83
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404383AbgDCQXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:23:53 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:20928 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404382AbgDCQXe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 12:23:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v4xJ3NsszwF;
        Fri,  3 Apr 2020 18:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585931012; bh=ytAv1RGisXEVnnR7xx1RoYPw9sNMYqF3J9qpj0xDcU4=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Cod8sd6UiT3mgAim0MFcpfiA4927isjQZJuRXamZ6mEPh8E9OzhhWENCXp3bgEm19
         XougCDk3g4z2sCP1qsCVXiX73x3aG7bNRnl9sZpPpUXXBK1zs8AJFnLTu9sitolo2T
         4xycthdS/Utm2n74TjYJz2/G6p0qxKTulCmeUXmQ0R4altfOX6fje/NnkzkcqamNTl
         HAWv+LoZsBSazHjmmWAOLtSHQsFNSqewxTEPfu7XCEbGaLga74mVgyS8sRLrUq7pea
         56138xNn+zasecF6lgEFXI33T8+8AnZjM0+OqVdHBvi+7gO5dXAf+xdhJJgpy/SHmt
         eBRbqFFagwwLw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 18:23:32 +0200
Message-Id: <ae82abf9da86542f5657a8c37106bcdae5011927.1585929579.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/8] power: supply: core: tabularize HWMON temperature
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
---
 drivers/power/supply/power_supply_hwmon.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 67b6ee60085e..48c73994732c 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -43,6 +43,11 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
 	}
 }
 
+static const char *const ps_temp_label[] = {
+	"temp",
+	"ambient temp",
+};
+
 static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
 {
 	if (channel) {
@@ -144,8 +149,20 @@ static int power_supply_hwmon_read_string(struct device *dev,
 					  u32 attr, int channel,
 					  const char **str)
 {
-	*str = channel ? "temp ambient" : "temp";
-	return 0;
+	if (channel < 0)
+		return -EINVAL;
+
+	switch (type) {
+	case hwmon_temp:
+		if (channel >= ARRAY_SIZE(ps_temp_label))
+			return -EINVAL;
+		*str = ps_temp_label[channel];
+		return 0;
+	default:
+		break;
+	}
+
+	return -EINVAL;
 }
 
 static int
-- 
2.20.1

