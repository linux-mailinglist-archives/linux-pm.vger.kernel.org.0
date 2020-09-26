Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC49279643
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 04:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgIZClp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 22:41:45 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:8237 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgIZClo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 22:41:44 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id BCA244E1432;
        Sat, 26 Sep 2020 10:41:40 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] power: supply: fix spelling typo
Date:   Sat, 26 Sep 2020 10:41:07 +0800
Message-Id: <1601088070-12790-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUNPSh5JT0IfTRgZVkpNS0pLQ0NKS0tCTENVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORA6KRw6MD8sOAE2Lk1MCTpR
        ARAaFDBVSlVKTUtKS0NDSktKT0tJVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFIQk1MNwY+
X-HM-Tid: 0a74c8499a319376kuwsbca244e1432
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Modify the comment typo: "compliment" -> "complement".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/power/supply/ds2780_battery.c | 6 +++---
 drivers/power/supply/ds2781_battery.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index db3a254..dd57a47
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -160,7 +160,7 @@ static int ds2780_get_voltage(struct ds2780_device_info *dev_info,
 
 	/*
 	 * The voltage value is located in 10 bits across the voltage MSB
-	 * and LSB registers in two's compliment form
+	 * and LSB registers in two's complement form
 	 * Sign bit of the voltage value is in bit 7 of the voltage MSB register
 	 * Bits 9 - 3 of the voltage value are in bits 6 - 0 of the
 	 * voltage MSB register
@@ -188,7 +188,7 @@ static int ds2780_get_temperature(struct ds2780_device_info *dev_info,
 
 	/*
 	 * The temperature value is located in 10 bits across the temperature
-	 * MSB and LSB registers in two's compliment form
+	 * MSB and LSB registers in two's complement form
 	 * Sign bit of the temperature value is in bit 7 of the temperature
 	 * MSB register
 	 * Bits 9 - 3 of the temperature value are in bits 6 - 0 of the
@@ -241,7 +241,7 @@ static int ds2780_get_current(struct ds2780_device_info *dev_info,
 
 	/*
 	 * The current value is located in 16 bits across the current MSB
-	 * and LSB registers in two's compliment form
+	 * and LSB registers in two's complement form
 	 * Sign bit of the current value is in bit 7 of the current MSB register
 	 * Bits 14 - 8 of the current value are in bits 6 - 0 of the current
 	 * MSB register
diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index 130cbdf..3df3c82
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -168,7 +168,7 @@ static int ds2781_get_voltage(struct ds2781_device_info *dev_info,
 		return ret;
 	/*
 	 * The voltage value is located in 10 bits across the voltage MSB
-	 * and LSB registers in two's compliment form
+	 * and LSB registers in two's complement form
 	 * Sign bit of the voltage value is in bit 7 of the voltage MSB register
 	 * Bits 9 - 3 of the voltage value are in bits 6 - 0 of the
 	 * voltage MSB register
@@ -197,7 +197,7 @@ static int ds2781_get_temperature(struct ds2781_device_info *dev_info,
 		return ret;
 	/*
 	 * The temperature value is located in 10 bits across the temperature
-	 * MSB and LSB registers in two's compliment form
+	 * MSB and LSB registers in two's complement form
 	 * Sign bit of the temperature value is in bit 7 of the temperature
 	 * MSB register
 	 * Bits 9 - 3 of the temperature value are in bits 6 - 0 of the
@@ -242,7 +242,7 @@ static int ds2781_get_current(struct ds2781_device_info *dev_info,
 
 	/*
 	 * The current value is located in 16 bits across the current MSB
-	 * and LSB registers in two's compliment form
+	 * and LSB registers in two's complement form
 	 * Sign bit of the current value is in bit 7 of the current MSB register
 	 * Bits 14 - 8 of the current value are in bits 6 - 0 of the current
 	 * MSB register
-- 
2.7.4

