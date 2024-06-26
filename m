Return-Path: <linux-pm+bounces-10031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A003917B34
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D961E281CF1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BCA161935;
	Wed, 26 Jun 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I9sqf/Hy"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F115FA73;
	Wed, 26 Jun 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391451; cv=none; b=frxhsbuUdm5HxL6Eh1kMX6UAugq/FnDjDSQvW8BCt6JS/bRUKptXjEbhHJFola0IwHg9ElYyaUxxFDMQFdVzZvVobJWZ12lIir5VqknvCIIPyo0/nd3d0Sy49MhLVakswgEoNdBMoq+ju9OhraykRm2NnwI9XkrmpZMoSO3YgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391451; c=relaxed/simple;
	bh=nqHzRpq/ZwTphph7XvKasqvlrolR3laeA11meI6qRnY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VGbsz6ytqJfwmFlLJVMaDqMqyb0xbdAstjqd22OBHzShtjITaXBaDYcTlGxZhNAkPiTLgMAmoBUvoPmYA3ETrZAetORp1Ik63tOOhNnCdE0gE4z81PtF1H7mqU2XX/NO3axGb0JCL6Pq20eXosbxGSMwlWsQvUyB7BSHYpZ5Sfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I9sqf/Hy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45Q8i2b2080352;
	Wed, 26 Jun 2024 03:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719391442;
	bh=VHjH/7YezNR75vLtgn6dRbkrKJ/z+LItV5LyONiIbC4=;
	h=From:To:CC:Subject:Date;
	b=I9sqf/HySE39f8beG7lN3mwtj21HKUBsAB6WD+w/CxPCMQmsj2RKq52m2oa9G31Cx
	 xpqlqXP1GA9Pce7j5Ouew7v2eWeEzjh0abF41a4UczabIFBBE+XacYBkddZSr4oawP
	 NyrZIRIZlNHxIRSRsrw1QSZg3xaaBYH8bhq0azVk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45Q8i1aY009628
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 03:44:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 03:44:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 03:44:01 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45Q8hxDO034650;
	Wed, 26 Jun 2024 03:44:00 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mario
 Limonciello <mario.limonciello@amd.com>,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH] cpufreq: make cpufreq_boost_enabled return bool
Date: Wed, 26 Jun 2024 14:13:54 +0530
Message-ID: <20240626084354.1762483-1-d-gole@ti.com>
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

No functional changes, just noticed this as I was reviewing the patch,
"cpufreq: Allow drivers to advertise boost enabled"

 drivers/cpufreq/cpufreq.c | 2 +-
 include/linux/cpufreq.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e678ea7b0891..5704036f294a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2874,7 +2874,7 @@ int cpufreq_enable_boost_support(void)
 }
 EXPORT_SYMBOL_GPL(cpufreq_enable_boost_support);
 
-int cpufreq_boost_enabled(void)
+bool cpufreq_boost_enabled(void)
 {
 	return cpufreq_driver->boost_enabled;
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20f7e98ee8af..523f81b7e2aa 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -785,7 +785,7 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_boost_trigger_state(int state);
-int cpufreq_boost_enabled(void);
+bool cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
 bool policy_has_boost_freq(struct cpufreq_policy *policy);
 
@@ -1164,7 +1164,7 @@ static inline int cpufreq_boost_trigger_state(int state)
 {
 	return 0;
 }
-static inline int cpufreq_boost_enabled(void)
+static inline bool cpufreq_boost_enabled(void)
 {
 	return 0;
 }

base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
-- 
2.34.1


