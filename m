Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9CC35AAAC
	for <lists+linux-pm@lfdr.de>; Sat, 10 Apr 2021 06:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhDJENH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Apr 2021 00:13:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16435 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhDJENH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Apr 2021 00:13:07 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FHM3z0GXFzqT93;
        Sat, 10 Apr 2021 12:10:39 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.196) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Sat, 10 Apr 2021 12:12:45 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <linqiheng@huawei.com>, Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] power: supply: Make some symbols static
Date:   Sat, 10 Apr 2021 12:12:46 +0800
Message-ID: <20210410041246.12791-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sparse tool complains as follows:

drivers/power/supply/surface_battery.c:700:1: warning:
 symbol 'dev_attr_alarm' was not declared. Should it be static?
drivers/power/supply/surface_battery.c:805:1: warning:
 symbol 'surface_battery_pm_ops' was not declared. Should it be static?

This symbol is not used outside of surface_battery.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/power/supply/surface_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index 4116dd839ecd..7efa431a62b2 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -697,7 +697,7 @@ static ssize_t alarm_store(struct device *dev, struct device_attribute *attr, co
 	return count;
 }
 
-DEVICE_ATTR_RW(alarm);
+static DEVICE_ATTR_RW(alarm);
 
 static struct attribute *spwr_battery_attrs[] = {
 	&dev_attr_alarm.attr,
@@ -802,7 +802,7 @@ static int __maybe_unused surface_battery_resume(struct device *dev)
 {
 	return spwr_battery_recheck_full(dev_get_drvdata(dev));
 }
-SIMPLE_DEV_PM_OPS(surface_battery_pm_ops, NULL, surface_battery_resume);
+static SIMPLE_DEV_PM_OPS(surface_battery_pm_ops, NULL, surface_battery_resume);
 
 static int surface_battery_probe(struct ssam_device *sdev)
 {

