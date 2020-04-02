Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA09919C50C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbgDBO5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:57:05 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:15630 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388785AbgDBO5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:57:04 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR3y6mclzqB;
        Thu,  2 Apr 2020 16:57:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839423; bh=fWZf0Q8vDlPNby4vOJe9G6yszXTLMk5ijtToPbvw+xE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=WSoJUufMMLcWNGXHPRSlgMb+yUru/5RLiGWzO8/s7Rwo6KV6Iqr3XcHObCIGu5F29
         J4dBVT5EeawGG7olri/r14ZDcKoaDtczUL8AvfVB4y4yUWs6zix1XxHZbAnlTH5qGk
         TVl/ksCHzNGrdcl/WO7TrS19mgvPTOtyNSn4VLUNKdS3j7aI6mGRoC+55HR534RKJZ
         snV1KtY00Cjh9PbBXsTp3SjXVEjJ/awEb10ciQwZ2q8Y6w673wb8TajpkL7776cdeG
         ofnqJg4lRXDebEa35jGYFkB+UfmfZyeuixpsHg87s/xnXD6x0kLQTB/S86eJ3r9OJ1
         6bfw7XxAiJNmw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:57:02 +0200
Message-Id: <4a8ac6700e1503a69146f3eefd7cb515d11bfc9f.1585837575.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/7] power: supply: core: fix HWMON temperature labels
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tempX_label files are swapped compared to what
power_supply_hwmon_temp_to_property() uses. Make them match.
While at it, make room for labeling other channels.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/power_supply_hwmon.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 75cf861ba492..83318a21fb52 100644
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
@@ -144,7 +149,14 @@ static int power_supply_hwmon_read_string(struct device *dev,
 					  u32 attr, int channel,
 					  const char **str)
 {
-	*str = channel ? "temp" : "temp ambient";
+	switch (type) {
+	case hwmon_temp:
+		*str = ps_temp_label[channel];
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.20.1

