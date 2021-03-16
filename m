Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7866833CE24
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 07:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhCPGyd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 02:54:33 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:47306 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCPGyF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 02:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=nE5EzAm2XjoMPFmk0d
        QnsxrzEQUfap6jHGH0saZ6ois=; b=GXfj+Xp7+E9ZVvmk181KABMCb3+D3beo2q
        z2s7BrAJXmwmxqNSFYXPjtfqGCwwXwuHb+3oKKoa5Z7WAS59AqZWYwFSHgfo4a9Y
        BLABumgXqxzpqJ3TNXRMa3ocdSljTiaPuDqTw3j5T7Mywpc9Tm1lmXUw66M2dBzu
        4l+qOtgrY=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp2 (Coremail) with SMTP id GtxpCgC3xej_VVBgqgy5AA--.2332S2;
        Tue, 16 Mar 2021 14:53:59 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, dongjian <dongjian@yulong.com>
Subject: [PATCH] power-supply: use kobj_to_dev()
Date:   Tue, 16 Mar 2021 14:54:12 +0800
Message-Id: <1615877652-31829-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: GtxpCgC3xej_VVBgqgy5AA--.2332S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW3JFWxCryfWry5GF4DJwb_yoW8uF1kpF
        Z5Ja4YyrW8WrWDWw45Xr4DZa43Kr1vk34fCr97Kw1Sk3s7Jr90gFZ8JFy5Aw15Zr95CFsa
        qryvkry7AFWfGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFUDJUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiqAdX3Vc7T8Nq1AAAs7
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: dongjian <dongjian@yulong.com>

Use kobj_to_dev() instead of open-coding it

Signed-off-by: dongjian <dongjian@yulong.com>
---
 drivers/power/supply/ds2781_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index 3df3c82..05b859b 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -626,7 +626,7 @@ static ssize_t ds2781_read_param_eeprom_bin(struct file *filp,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2781_device_info *dev_info = to_ds2781_device_info(psy);
 
@@ -639,7 +639,7 @@ static ssize_t ds2781_write_param_eeprom_bin(struct file *filp,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2781_device_info *dev_info = to_ds2781_device_info(psy);
 	int ret;
@@ -671,7 +671,7 @@ static ssize_t ds2781_read_user_eeprom_bin(struct file *filp,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2781_device_info *dev_info = to_ds2781_device_info(psy);
 
@@ -685,7 +685,7 @@ static ssize_t ds2781_write_user_eeprom_bin(struct file *filp,
 				struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2781_device_info *dev_info = to_ds2781_device_info(psy);
 	int ret;
-- 
1.9.1

