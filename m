Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C9E1F744D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jun 2020 09:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFLHFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 03:05:12 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:46516 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFLHFL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2020 03:05:11 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 03:05:11 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 0A2A2261424;
        Fri, 12 Jun 2020 14:56:14 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers\power\supply: use kobj_to_dev
Date:   Fri, 12 Jun 2020 14:55:54 +0800
Message-Id: <1591944954-14411-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkJIShgYHhoeH0kYVkpOQkpCT09CTE9ISk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCo6Izo5Cjg4AQs8UU0cGR1R
        Ez1PCQhVSlVKTkJKQk9PQkxPTU1IVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTFlXWQgBWUFKTk9JNwY+
X-HM-Tid: 0a72a7508f5f9375kuws0a2a2261424
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/power/supply/power_supply_sysfs.c

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index bc79560..af0cad2
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -343,7 +343,7 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 					   struct attribute *attr,
 					   int attrno)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct power_supply *psy = dev_get_drvdata(dev);
 	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
 	int i;
-- 
2.7.4

