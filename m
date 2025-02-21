Return-Path: <linux-pm+bounces-22650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DFA3F64A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 14:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DD6188FF12
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795961487DD;
	Fri, 21 Feb 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n5Jc+zMl"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D81A270;
	Fri, 21 Feb 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145704; cv=none; b=uj9xXvl5tNOY91jaxljUDF8hYyLDvP9cdrYbLQwIcZzminEIe1sCA98us1BdSo92tLDvjk8VgXzlzGNycc/5kyPylyZ4b4gEyq0SHsInTmB3d0dUyDJXjzkfZULxIvsd2EeRqZ3sLOER5/PyJUUp5ApWNbC2mYf5j6pJF5iPl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145704; c=relaxed/simple;
	bh=B6ACiyqUmdJ3f0CK1Bz6D1FrPp3Fk9b1LVvxEfP6MlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=f5pTJMDLaYIVHHNijflq6VeTGkb683io6ioalyUJJEnjHsQgojz04cT673j8ekwoUxIsd6VsBpaW+qzg9RqM6o4V2iYG0SnGvpl/UumEx53KmeAo7Wky3vgjq2PwKbClY6JLVdPqAPojrbMQkshQ+Waf5j9zGs37aMiYJUbbbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n5Jc+zMl; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51LDmJSd310356
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 07:48:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740145699;
	bh=UnGyoGH3aP4gWm3gHznPmZAXQdBZeSQP1kktMPQL60U=;
	h=From:Date:Subject:To:CC;
	b=n5Jc+zMlw3Edf307MwOVBRbHmFZVFhPNMZzFOptpab+g2rb1EUjI0jeDIin5NCRTp
	 cq+rbYPm5KAz1FXqXE+0FZwOTxzCNqHstbSH2dbq6VKGbfpSy0BuxtI059xxtCbKt8
	 JNlDD6/ya8t4Ezatg4X40rJiC/mNKs/GuxUBFd1E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51LDmJgo021262
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Feb 2025 07:48:19 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Feb 2025 07:48:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Feb 2025 07:48:19 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51LDmI0p025205;
	Fri, 21 Feb 2025 07:48:19 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
Date: Fri, 21 Feb 2025 19:18:10 +0530
Subject: [PATCH RFC] pmdomain: core: add support for writeble power domain
 state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250221-pm-debug-v1-1-e5bd815f7ca4@ti.com>
X-B4-Tracking: v=1; b=H4sIABmEuGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyND3YJc3ZTUpNJ0XQMLI5OURGMDC0uDNCWg8oKi1LTMCrBR0UpBbs5
 KsbW1AKg67fhfAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <vigneshr@ti.com>, <d-gole@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740145698; l=4252;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=B6ACiyqUmdJ3f0CK1Bz6D1FrPp3Fk9b1LVvxEfP6MlM=;
 b=ej04aZpNVUf9YX27lSMlljoXu1ffQiHy+9ygkhsQmRtDcySOs4KmVbyKDNVnSf1VUjoMTcqz+
 KfRntcTpPuBCfn6lRA9D8GcNeIriheGSOhoALr0E0arU2KNRU/6MMfk
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add support for writeable power domain states from debugfs.

Defining GENPD_ALLOW_WRITE_DEBUGFS will enable writeable pd_state
node in debugfs.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
This has turn out to be really helpful when debugging SCMI protocol
for power domain management.

Reference has been taken from clock framework which provides similar
CLOCK_ALLOW_WRITE_DEBUGFS, which helps to test clocks from debugfs.
---
 drivers/pmdomain/core.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9b2f28b34bb5..6aba0c672da0 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1298,6 +1298,60 @@ late_initcall_sync(genpd_power_off_unused);
 
 #ifdef CONFIG_PM_SLEEP
 
+#ifdef GENPD_ALLOW_WRITE_DEBUGFS
+/*
+ * This can be dangerous, therefore don't provide any real compile time
+ * configuration option for this feature.
+ * People who want to use this will need to modify the source code directly.
+ */
+static int genpd_state_set(void *data, u64 val)
+{
+
+	struct generic_pm_domain *genpd = data;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	if (val == 1) {
+		genpd->power_on(genpd);
+		genpd->status = GENPD_STATE_ON;
+	} else if (val == 0) {
+		genpd->power_off(genpd);
+		genpd->status = GENPD_STATE_OFF;
+	}
+
+	genpd_unlock(genpd);
+	return 0;
+}
+
+#define pd_state_mode	0644
+
+static int genpd_state_get(void *data, u64 *val)
+{
+
+	struct generic_pm_domain *genpd = data;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	if (genpd->status == GENPD_STATE_OFF)
+		*val = 0;
+	else
+		*val = 1;
+
+	genpd_unlock(genpd);
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(pd_state_fops, genpd_state_get,
+			 genpd_state_set, "%llu\n");
+
+#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
+
 /**
  * genpd_sync_power_off - Synchronously power off a PM domain and its parents.
  * @genpd: PM domain to power off, if possible.
@@ -3639,6 +3693,11 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
 	if (genpd->set_performance_state)
 		debugfs_create_file("perf_state", 0444,
 				    d, genpd, &perf_state_fops);
+#ifdef GENPD_ALLOW_WRITE_DEBUGFS
+	debugfs_create_file("pd_state", 0644, d, genpd,
+			    &pd_state_fops);
+#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
+
 }
 
 static int __init genpd_debug_init(void)
@@ -3653,6 +3712,24 @@ static int __init genpd_debug_init(void)
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
 		genpd_debug_add(genpd);
 
+#ifdef GENPD_ALLOW_WRITE_DEBUGFS
+	pr_warn("\n");
+	pr_warn("********************************************************************\n");
+	pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
+	pr_warn("**                                                                **\n");
+	pr_warn("**  WRITEABLE POWER DOMAIN STATE DEBUGFS SUPPORT HAS BEEN ENABLED **\n");
+	pr_warn("**  IN THIS KERNEL                                                **\n");
+	pr_warn("** This means that this kernel is built to expose pd operations   **\n");
+	pr_warn("** such as enabling, disabling, etc.                              **\n");
+	pr_warn("** to userspace, which may compromise security on your system.    **\n");
+	pr_warn("**                                                                **\n");
+	pr_warn("** If you see this message and you are not debugging the          **\n");
+	pr_warn("** kernel, report this immediately to your vendor!                **\n");
+	pr_warn("**                                                                **\n");
+	pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE           **\n");
+	pr_warn("********************************************************************\n");
+#endif /* GENPD_ALLOW_WRITE_DEBUGFS */
+
 	return 0;
 }
 late_initcall(genpd_debug_init);

---
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20250221-pm-debug-0824da30890f

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>


