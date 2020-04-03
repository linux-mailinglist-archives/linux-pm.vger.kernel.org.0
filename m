Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A03D19DB77
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 18:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404390AbgDCQXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 12:23:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:21872 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404374AbgDCQXd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 12:23:33 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48v4xJ0Dn5zqB;
        Fri,  3 Apr 2020 18:23:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585931012; bh=fseErXmDkX64tuP/VBZQqH12qqnxX3YPVLXIds6NfEI=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=cvcB6fRGkOZ95vWWooSHpXFLGj53m6WseMTpjM79hEvtg8CL+V9uyE/GWq3xqp+YI
         QPHzdF5hXCCicdhEopQRtsKEJrR3LaKtjcOF4/GbRhI6SLXHWX37e0NSN06Htkjujh
         iG87RvngSpY69OX+eTUQN4gm2VYBRFG3N13pCe5tcGiIrD4DugG2Qes9f1EgNZgrY8
         FRvhIvQR6Xl0Xf/yF/IEKq1grz2+IFUo6uPpkdP8Rv1Hyf6rNyGcdBrrRogLFQVYDE
         eIoaYWaBwVHIH74aIJBLL6s8moyJZ4pboAyqVMJDqzrceXvkpbO5cOMZPqaBI47SC9
         97fQa353pZd9g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 03 Apr 2020 18:23:31 +0200
Message-Id: <f6ab03acc5118cee8cd77ed8ae11a881c3ce2a1e.1585929579.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585929579.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/8] power: supply: core: fix HWMON temperature labels
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
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

