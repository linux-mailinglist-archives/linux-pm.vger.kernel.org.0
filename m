Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E33BE43A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 10:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhGGIU6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 04:20:58 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:60844 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhGGIU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 04:20:58 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8DF12FB0CF;
        Wed,  7 Jul 2021 16:17:59 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P5175T139827079014144S1625645873824660_;
        Wed, 07 Jul 2021 16:18:00 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <90a70faef2d71da9e8ee3658958bed4f>
X-RL-SENDER: zhuguanghong@uniontech.com
X-SENDER: zhuguanghong@uniontech.com
X-LOGIN-NAME: zhuguanghong@uniontech.com
X-FST-TO: sre@kernel.org
X-RCPT-COUNT: 4
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhuguanghong <zhuguanghong@uniontech.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguanghong <zhuguanghong@uniontech.com>
Subject: [PATCH] POWER SUPPLY CLASS/SUBSYSTEM : add new status 'Full charging' can show that the battery is fully charged but still charging
Date:   Wed,  7 Jul 2021 16:17:51 +0800
Message-Id: <20210707081751.17021-1-zhuguanghong@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: zhuguanghong <zhuguanghong@uniontech.com>
---
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..0ddb84b7637f 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -78,6 +78,7 @@ static const char * const POWER_SUPPLY_STATUS_TEXT[] = {
 	[POWER_SUPPLY_STATUS_DISCHARGING]	= "Discharging",
 	[POWER_SUPPLY_STATUS_NOT_CHARGING]	= "Not charging",
 	[POWER_SUPPLY_STATUS_FULL]		= "Full",
+	[POWER_SUPPLY_STATUS_FULL_CHARGING]	= "Full charging",
 };
 
 static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index be203985ecdd..04844dbb18c4 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -37,6 +37,7 @@ enum {
 	POWER_SUPPLY_STATUS_DISCHARGING,
 	POWER_SUPPLY_STATUS_NOT_CHARGING,
 	POWER_SUPPLY_STATUS_FULL,
+	POWER_SUPPLY_STATUS_FULL_CHARGING,
 };
 
 /* What algorithm is the charger using? */
-- 
2.20.1



