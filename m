Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4269E29238D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgJSIWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 04:22:48 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:47180 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgJSIWr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 04:22:47 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 9809F482893;
        Mon, 19 Oct 2020 16:22:43 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drivers/thermal: optimize the for circle to run a bit fast
Date:   Mon, 19 Oct 2020 01:22:35 -0700
Message-Id: <20201019082235.41773-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTExPS0NMHR1LH0lLVkpNS0hLQk5MTUhDSk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kyo6NSo4ET8uKzEuESgPNgsL
        HBgwCQxVSlVKTUtIS0JOTE1PSU1MVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSUpDQzcG
X-HM-Tid: 0a753ff41b2193bakuws9809f482893
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Function thermal_zone_device_register, in the for circle, if the
first if branch set the count bit in tz->trips_disabled, there is
no need to set in the other if branch again.
This change is to make the code run a bit fast and readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/thermal/thermal_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c6d74bc1c90b..03577794eea3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1446,10 +1446,14 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		goto release_device;
 
 	for (count = 0; count < trips; count++) {
-		if (tz->ops->get_trip_type(tz, count, &trip_type))
+		if (tz->ops->get_trip_type(tz, count, &trip_type)) {
 			set_bit(count, &tz->trips_disabled);
-		if (tz->ops->get_trip_temp(tz, count, &trip_temp))
+			continue;
+		}
+		if (tz->ops->get_trip_temp(tz, count, &trip_temp)) {
 			set_bit(count, &tz->trips_disabled);
+			continue;
+		}
 		/* Check for bogus trip points */
 		if (trip_temp == 0)
 			set_bit(count, &tz->trips_disabled);
-- 
2.28.0

