Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145473B2AA0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhFXIqp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 04:46:45 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:41144 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhFXIqn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Jun 2021 04:46:43 -0400
X-Greylist: delayed 83890 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2021 04:46:42 EDT
X-QQ-mid: bizesmtp50t1624524257ta18clmb
Received: from localhost.localdomain (unknown [182.148.13.245])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 24 Jun 2021 16:44:10 +0800 (CST)
X-QQ-SSF: 0100000000200040B000C00A0000000
X-QQ-FEAT: xmzaef4TE3dqfPHTY6rIfJftWpkKueIDu/WqMf26cgfyC/b5K/dtv/pEvB+6r
        Bwb5YTL6rLnF8bVParl8V4ki8yek1K2AMKr3OnW3FX7qEk7T3JJkNwfFqIJ0E2iNdgddKw5
        FbJ5EcoWgELyKlFGQnjWH02S/vlDgnYyITkG4TjXfSb4H4LVWzGa87dezlG5HFR0CywEkn+
        IpnximnNSWT9IEJrYCtPMH7t85n1WcWQhiS/AruO7xChmc21JBKmxbaI67S9aGiGQy8/DWg
        pWKXr+n5yAGdQoyKHYYm+2GgcV38eweRUB79dY58cgIGgNR5LG2o3fFNjN78zW8BlWbpFv5
        Apd3rlWKYfRi0GdvoA=
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, wjc@cdjrlc.com,
        linux-pm@vger.kernel.org
Subject: [PATCH] powercap: Replace symbolic permissions with octal permissions
Date:   Thu, 24 Jun 2021 16:44:03 +0800
Message-Id: <20210624084403.1163-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Resolve following checkpatch issue,
Replace symbolic permissions with octal permissions

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
 drivers/powercap/powercap_sys.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index f0654a932b37..e706548c59bb 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -223,46 +223,46 @@ static int seed_constraint_attributes(void)
 
 	for (i = 0; i < MAX_CONSTRAINTS_PER_ZONE; ++i) {
 		ret = create_constraint_attribute(i, "power_limit_uw",
-					S_IWUSR | S_IRUGO,
+					0644,
 					&constraint_attrs[i].power_limit_attr,
 					show_constraint_power_limit_uw,
 					store_constraint_power_limit_uw);
 		if (ret)
 			goto err_alloc;
 		ret = create_constraint_attribute(i, "time_window_us",
-					S_IWUSR | S_IRUGO,
+					0644,
 					&constraint_attrs[i].time_window_attr,
 					show_constraint_time_window_us,
 					store_constraint_time_window_us);
 		if (ret)
 			goto err_alloc;
-		ret = create_constraint_attribute(i, "name", S_IRUGO,
+		ret = create_constraint_attribute(i, "name", 0444,
 				&constraint_attrs[i].name_attr,
 				show_constraint_name,
 				NULL);
 		if (ret)
 			goto err_alloc;
-		ret = create_constraint_attribute(i, "max_power_uw", S_IRUGO,
+		ret = create_constraint_attribute(i, "max_power_uw", 0444,
 				&constraint_attrs[i].max_power_attr,
 				show_constraint_max_power_uw,
 				NULL);
 		if (ret)
 			goto err_alloc;
-		ret = create_constraint_attribute(i, "min_power_uw", S_IRUGO,
+		ret = create_constraint_attribute(i, "min_power_uw", 0444,
 				&constraint_attrs[i].min_power_attr,
 				show_constraint_min_power_uw,
 				NULL);
 		if (ret)
 			goto err_alloc;
 		ret = create_constraint_attribute(i, "max_time_window_us",
-				S_IRUGO,
+				0444,
 				&constraint_attrs[i].max_time_window_attr,
 				show_constraint_max_time_window_us,
 				NULL);
 		if (ret)
 			goto err_alloc;
 		ret = create_constraint_attribute(i, "min_time_window_us",
-				S_IRUGO,
+				0444,
 				&constraint_attrs[i].min_time_window_attr,
 				show_constraint_min_time_window_us,
 				NULL);
@@ -366,9 +366,9 @@ static void create_power_zone_common_attributes(
 					&dev_attr_max_energy_range_uj.attr;
 	if (power_zone->ops->get_energy_uj) {
 		if (power_zone->ops->reset_energy_uj)
-			dev_attr_energy_uj.attr.mode = S_IWUSR | S_IRUSR;
+			dev_attr_energy_uj.attr.mode = 0600;
 		else
-			dev_attr_energy_uj.attr.mode = S_IRUSR;
+			dev_attr_energy_uj.attr.mode = 0400;
 		power_zone->zone_dev_attrs[count++] =
 					&dev_attr_energy_uj.attr;
 	}
-- 
2.31.1



