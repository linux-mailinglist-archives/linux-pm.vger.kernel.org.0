Return-Path: <linux-pm+bounces-41051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E754D39115
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 22:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065923027D88
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jan 2026 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1972EB5A6;
	Sat, 17 Jan 2026 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="qdPOGE2B"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328A2EAB61
	for <linux-pm@vger.kernel.org>; Sat, 17 Jan 2026 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768684226; cv=none; b=YZV5etyTKjpL70s7mhxwX+9iWk8oGLJaH3FVZJuhOSta8AX303WRbKyxYYJp0QPD5+a5O2Ch9T/Pb7P0pSGBYjvtFwfugRzkHqZ3+Qbz8vBN995p4Nw4GPbyV5qFgNYCA5K7v2QQcHYSIttIf3vEBGWERqIsY6XzunnZMKdFXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768684226; c=relaxed/simple;
	bh=YpT/BPd8Y61sKHa2Mvbw6/FM1KBH+VQoatUnX2vBHR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn45plnAdV2g+2137XUfdwoVdMjyfoRVtbixZZBs1W7YWySkZ/NlGsu2iwlVXzJrkdy7wLvkRPbdkw8DwyCXe9RUsznjbCR3TPiD8U7fXR92HFJJ8t3pF+rWsC9kMJq474OH066QfvbbcEADELRayGBpoV2q1wGuTZiAU2BIrGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=qdPOGE2B; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1768684211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nhdEGm3g/qNY/ixZE/izgcRF9w5r47dc5v3DpaxVaqE=;
	b=qdPOGE2BGBqky1mMypjk5UaclmBdoDju5KUGDZcWGBUU0cUFpdolnvqFAan2HAg1sKsdEz
	4wgbvlP1WIozCria+ZJSwrm5EnDheJOHavADjNixIHDBO6a5S+FcbNuCJQITr0xtzTkz6T
	QdmoOEFv0bG30+Yi3BX6MjI5tNRp1yQvnLkf76+3YpQOR7crHr5z9oB+qm1BQDxeOi7Rdp
	E3TQ/tVxCjyZlxKtrG6YD39pcQAbFQQM6li9ET7QsUUISJXv6n+qW92sZD2J48hDHKQq0h
	kRM9kPvHU3HTnmEsJs+V9KfwxVzE9ZSrZvh+2YmmjQl3WRPcJXYd0R8RAiV0bA==
From: Val Packett <val@packett.cool>
To: Sebastian Reichel <sre@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Val Packett <val@packett.cool>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: qcom_battmgr: Recognize "LiP" as lithium-polymer
Date: Sat, 17 Jan 2026 18:09:24 -0300
Message-ID: <20260117210941.6219-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
for the battery chemistry type, but only all-uppercase "LIP" was being
recognized. Add the CamelCase variant to the check to fix the "Unknown
battery technology" warning.

Fixes: 202ac22b8e2e ("power: supply: qcom_battmgr: Add lithium-polymer entry")
Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/power/supply/qcom_battmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index c8028606bba0..80e701c66434 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1240,7 +1240,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
 	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
 	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
-	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
+	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN) ||
+	    (!strncmp(chemistry, "LiP", BATTMGR_CHEMISTRY_LEN)))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
 
 	pr_err("Unknown battery technology '%s'\n", chemistry);
-- 
2.51.2


