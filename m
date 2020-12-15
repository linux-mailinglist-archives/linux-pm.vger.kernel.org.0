Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC012DA52A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 02:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgLOBBD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 20:01:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9176 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbgLOBBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 20:01:03 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cw0K836Pqz15dSh;
        Tue, 15 Dec 2020 08:59:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 15 Dec 2020 09:00:14 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: ds2780: Switch to using the new API kobj_to_dev()
Date:   Tue, 15 Dec 2020 09:00:24 +0800
Message-ID: <1607994024-32199-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

fixed the following coccicheck:
drivers/power/supply/ds2780_battery.c:627:60-61: WARNING opportunity for
kobj_to_dev()
drivers/power/supply/ds2780_battery.c:672:60-61: WARNING opportunity for
kobj_to_dev()
drivers/power/supply/ds2780_battery.c:640:60-61: WARNING opportunity for
kobj_to_dev()
drivers/power/supply/ds2780_battery.c:685:60-61: WARNING opportunity for
kobj_to_dev()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/power/supply/ds2780_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index dd57a47..2b8c90d 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -624,7 +624,7 @@ static ssize_t ds2780_read_param_eeprom_bin(struct file *filp,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
 
@@ -637,7 +637,7 @@ static ssize_t ds2780_write_param_eeprom_bin(struct file *filp,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
 	int ret;
@@ -669,7 +669,7 @@ static ssize_t ds2780_read_user_eeprom_bin(struct file *filp,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
 
@@ -682,7 +682,7 @@ static ssize_t ds2780_write_user_eeprom_bin(struct file *filp,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
 	int ret;
-- 
2.7.4

