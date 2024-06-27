Return-Path: <linux-pm+bounces-10091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B9919EFB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 08:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09147B20C1C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2EF21350;
	Thu, 27 Jun 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tGBQI9v6"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2E1CAAF;
	Thu, 27 Jun 2024 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468097; cv=none; b=SdKB2OKEWztC4ThvdyP0Iu93OA6uJ4/4jtjrjBf/vpU0fxTswZtdnjXosDtUKNjYKwDJXd6v5xFyEA701NJL+mpYq6FJj8L3smvGJjsvhL895YJ+kWlu7TtQ7GuWxzx3/zN8ajEGc03QnCuOXFw+f5CaO2Uce7rd2Jv5kwOLRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468097; c=relaxed/simple;
	bh=RhPz/nGQMnBBjqqWJlVCbcXTmZI5o9oEkrzVuT/z9ME=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Su1Qg53+klJClVAO+VrRavfpUiwM5TEjw6px/RqmO0hOA+74Bh9/PQOVXbQkFby5NJG43W2o1thAsVws+25SkgETg7Ragemm2PcyTafFC+arMpR8q8nB+qWqtWsj9wTrOvvXG2eMTPM7TlF47fvNlq6Q/3szNdJeLelPYyNxNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tGBQI9v6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45R61VBA129858;
	Thu, 27 Jun 2024 01:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719468091;
	bh=A0iKcaVRUVxaZBhJFTeVilsxreWWM2Ey9iU4761I1PQ=;
	h=From:To:CC:Subject:Date;
	b=tGBQI9v6+G1Gem83fpvvhsf8F9cAaiwuaZ1c1Uu3Tw8GAcao5Ziir7CyKKd+yOysx
	 axX/dsk++Ovk1wlYs9YuwlrdNGJ90+VaPJjMWACy70zDHFO2yTOGDdgmwQenyUKl71
	 Iy8w4jqx7Mu2ijEsr5zMLICtQfc8tvxw+O/DGOCQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45R61VG2119680
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 01:01:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 01:01:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 01:01:30 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45R61SQq061495;
	Thu, 27 Jun 2024 01:01:29 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mario
 Limonciello <mario.limonciello@amd.com>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V2] cpufreq: make cpufreq_boost_enabled return bool
Date: Thu, 27 Jun 2024 11:31:17 +0530
Message-ID: <20240627060117.1809477-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Since this function is supposed to return boost_enabled which is anyway
a bool type make sure that it's return value is also marked as bool.
This helps maintain better consistency in data types being used.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Changelog:
"return false" instead of 0 as per Mario's suggestion.

Link to previous patch:
https://lore.kernel.org/linux-pm/20240626084354.1762483-1-d-gole@ti.com/

---

 drivers/cpufreq/cpufreq.c | 2 +-
 include/linux/cpufreq.h   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 82c500389a40..709e7b1f9826 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2873,7 +2873,7 @@ int cpufreq_enable_boost_support(void)
 }
 EXPORT_SYMBOL_GPL(cpufreq_enable_boost_support);
 
-int cpufreq_boost_enabled(void)
+bool cpufreq_boost_enabled(void)
 {
 	return cpufreq_driver->boost_enabled;
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20f7e98ee8af..6f57de7de433 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -785,7 +785,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_boost_trigger_state(int state);
-int cpufreq_boost_enabled(void);
+bool cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
 bool policy_has_boost_freq(struct cpufreq_policy *policy);
 
@@ -1164,9 +1164,9 @@ static inline int cpufreq_boost_trigger_state(int state)
 {
 	return 0;
 }
-static inline int cpufreq_boost_enabled(void)
+static inline bool cpufreq_boost_enabled(void)
 {
-	return 0;
+	return false;
 }
 
 static inline int cpufreq_enable_boost_support(void)

base-commit: df9574a57d02b265322e77fb8628d4d33641dda9
-- 
2.34.1


