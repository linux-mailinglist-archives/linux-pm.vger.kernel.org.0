Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F71F92B6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgFOJHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 05:07:48 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:21415 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgFOJHr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 05:07:47 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 5016E262647;
        Mon, 15 Jun 2020 17:07:44 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] drivers/thermal: Use kobj_to_dev() instead
Date:   Mon, 15 Jun 2020 17:07:35 +0800
Message-Id: <1592212056-31955-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUpMHR8aGkgZGEJMVkpOQklJSklLTU9OTEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6CCo*EDg0AQgVMw8KHBoU
        LS9PCS9VSlVKTkJJSUpJS01PQkJMVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFJS0lNNwY+
X-HM-Tid: 0a72b73c090c9375kuws5016e262647
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/thermal/thermal_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 drivers/thermal/thermal_sysfs.c

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb..3e92ff9
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -438,7 +438,7 @@ static umode_t thermal_zone_mode_is_visible(struct kobject *kobj,
 					    struct attribute *attr,
 					    int attrno)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct thermal_zone_device *tz;
 
 	tz = container_of(dev, struct thermal_zone_device, device);
@@ -464,7 +464,7 @@ static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
 					       struct attribute *attr,
 					       int attrno)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct thermal_zone_device *tz;
 	enum thermal_trip_type trip_type;
 	int count, passive = 0;
-- 
2.7.4

