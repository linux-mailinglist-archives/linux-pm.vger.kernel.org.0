Return-Path: <linux-pm+bounces-1637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E281F6F2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 11:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0901B21507
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864AE63DA;
	Thu, 28 Dec 2023 10:39:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3D6AA2;
	Thu, 28 Dec 2023 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BSAdRon039450;
	Thu, 28 Dec 2023 18:39:27 +0800 (+08)
	(envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T14bD0bQHz2QnGWT;
	Thu, 28 Dec 2023 18:32:56 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 28 Dec 2023 18:39:25 +0800
From: Di Shen <di.shen@unisoc.com>
To: <rafael@kernel.org>, <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <zhanglyra@gmail.com>, <orsonzhai@gmail.com>
Subject: [PATCH] thermal: core: export the governor register related API
Date: Thu, 28 Dec 2023 18:39:21 +0800
Message-ID: <20231228103921.23839-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 3BSAdRon039450

To enable users to register their own thermal governor, this patch
exports thermal_register_governor() and thermal_unregister_governor().
This change would not affect the registration of the default governor.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/thermal_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9c17d35ccbbd..56695988e20f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -167,6 +167,7 @@ int thermal_register_governor(struct thermal_governor *governor)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(thermal_register_governor);
 
 void thermal_unregister_governor(struct thermal_governor *governor)
 {
@@ -193,6 +194,7 @@ void thermal_unregister_governor(struct thermal_governor *governor)
 exit:
 	mutex_unlock(&thermal_governor_lock);
 }
+EXPORT_SYMBOL_GPL(thermal_unregister_governor);
 
 int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
 				   char *policy)
-- 
2.17.1


