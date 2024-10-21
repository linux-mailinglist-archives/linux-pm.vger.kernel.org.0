Return-Path: <linux-pm+bounces-16090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A39A67AF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 14:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98969B2249D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E91EF939;
	Mon, 21 Oct 2024 12:12:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C41DA314;
	Mon, 21 Oct 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512775; cv=none; b=CR/Atc5eWTIToSxUrQj9OqFL4A3KfufEqkro7VvmHnPTp6OT9XbQp7NnldEIzU7gAoe4O/eOjD8tP7WVZe8d+W9zSOzokcf7g4U8RIQYaN94hPk7sj2rcQQ+05BCm9YvA8ZLBQgXoZ0qpNzVyYyTLkenMra2mi4LSeX46ubfpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512775; c=relaxed/simple;
	bh=knWulEp3Y8VsTxmNEmN7lvDWgNciIS+AGlFK3WZJVTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MCWlIVK/SSX69zX90Hym1AIKpuzjNFQbuvcAT5/S7mE09sLnK1uUAr/VZcAW7eVZ9mheuTmy5fm4zERaPKe40l3TlvXBOThUumDC5XV8ln20Apvst6gu2n+lRLAjcpqeOUv72bGXuREhxIubQAPEyIbFOQo926G23O1zYQkI3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 9sRJT4PMSSK/gjHv2KG29Q==
X-CSE-MsgGUID: aHGXw6PQQguRCuSVron6Qw==
X-IronPort-AV: E=Sophos;i="6.11,220,1725292800"; 
   d="scan'208";a="99300552"
From: ZhengShaobo <zhengshaobo1@xiaomi.com>
To: Lukasz Luba <lukasz.luba@arm.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: zhuzhangwei <chuci@xiaomi.com>, dingchongchong
	<dingchongchong@xiaomi.com>, chendejun <chendejun@xiaomi.com>, zhengshaobo1
	<zhengshaobo1@xiaomi.com>
Subject: [PATCH] thermal: gov_power_allocator: Granted power set to max when nobody request power
Date: Mon, 21 Oct 2024 20:11:38 +0800
Message-ID: <20241021121138.422-1-zhengshaobo1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bj-mbx09.mioffice.cn (10.237.8.129) To BJ-MBX15.mioffice.cn
 (10.237.8.135)

From: zhengshaobo1 <zhengshaobo1@xiaomi.com>

When total_req_power is 0, divvy_up_power() will set granted_power to 0,
and cdev will be limited to the lowest performance. If our polling delay
is set to 200ms, it means that cdev cannot perform better within 200ms
even if cdev has a sudden load. This will affect the performance of cdev
and is not as expected.

For this reason, if nobody requests power, then set the granted power to
the max_power.

Signed-off-by: zhengshaobo1 <zhengshaobo1@xiaomi.com>
---
 drivers/thermal/gov_power_allocator.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1b2345a697c5..4301516c0938 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -356,11 +356,19 @@ static void divvy_up_power(struct power_actor *power, int num_actors,
 	u32 extra_power = 0;
 	int i;
 
-	/*
-	 * Prevent division by 0 if none of the actors request power.
-	 */
-	if (!total_req_power)
-		total_req_power = 1;
+	if (!total_req_power) {
+		/*
+		 * Nobody requested anything, just give everybody
+		 * the maximum power
+		 */
+		for (i = 0; i < num_actors; i++) {
+			struct power_actor *pa = &power[i];
+
+			pa->granted_power = pa->max_power;
+		}
+
+		return;
+	}
 
 	for (i = 0; i < num_actors; i++) {
 		struct power_actor *pa = &power[i];
-- 
2.43.0


