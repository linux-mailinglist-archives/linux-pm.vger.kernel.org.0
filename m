Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED1519DF22
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 22:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgDCUUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 16:20:36 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:27349 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgDCUUg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 16:20:36 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48vBBn5f29z1th;
        Fri,  3 Apr 2020 22:20:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585945233; bh=fseErXmDkX64tuP/VBZQqH12qqnxX3YPVLXIds6NfEI=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Sev2Is24W31jAIfgP5RNxcie7xoiBgYEQAISAsqZb786EeHIUZdwjd79Onl0SQlC9
         EQmva5mmbOl7sqAx3Cyz4TFQgJ3mi7nywa2MXxDu4n3oNQRzDE0YwjJwFQFkvrtyoC
         ZZgS+1ecAXQxq3HGlNXTtCEhIe4W4j4rq2Rg5gMJAQ2iB9GJ+G6zxG3rqQhZo04Vb6
         s8ZygMtiiGeEyk58liLxFrTldf4xWaWCy2+H8QrfG5i/fWGWdUagPzyJ7DG64wtUxU
         EnRiYnmdM2erixluvcbLtazWXrp1oRf1R+RoFRolLefaxGenwrRld+wQqD6S9aNq2X
         J/5yHFO/HrKJA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 22:20:33 +0200
Message-Id: <4c33741ba56d3c7830827c140bccf13621e59232.1585944770.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 06/11] power: supply: core: fix HWMON temperature labels
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

Cc: stable@vger.kernel.org
Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: split parameter checking to separate patch
---
 drivers/power/supply/power_supply_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 75cf861ba492..67b6ee60085e 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -144,7 +144,7 @@ static int power_supply_hwmon_read_string(struct device *dev,
 					  u32 attr, int channel,
 					  const char **str)
 {
-	*str = channel ? "temp" : "temp ambient";
+	*str = channel ? "temp ambient" : "temp";
 	return 0;
 }
 
-- 
2.20.1

