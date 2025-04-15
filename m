Return-Path: <linux-pm+bounces-25418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3ABA890D0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 02:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0FD17D50B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6903596B;
	Tue, 15 Apr 2025 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KBzPZGZp"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF11EAC6;
	Tue, 15 Apr 2025 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677770; cv=none; b=n7EV+3Cc7kJrOrAkjjLp0LGN2evBuBndrNSEHU7Xvl2TEUXHeFL76eej4PcRED8lyocdIFePReBWA6J9/EcX1tvBcbq733Vtudn22zZqIA5NhHu35HglU3fiB7pwG+cRfMOHN+tGWMi3vW4pilhLz6Y0U+nHIavSdRgKNaUYduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677770; c=relaxed/simple;
	bh=nGynln/ocoUUV/PmrwKyagaq/IHKy2efVyhUloonyrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpzlLt9d4EoeseD15T6H6r2yN29tKs+8hk4327EOqrJ8XqLZW/NnuLkuaBKLySK8mEXF29ga385ysYwv9Zo3b9e33d35Gbv9zpEhtyAoNy/FWxff1TJvV8juDn8xxK3gPpbphF17OrvxHpsEccx+gwMJbfVhJOLPsjH7p2Dgk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KBzPZGZp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GTcSulGa4U4GJQg7JsQS1InA2iNEMcZQ7oS2hj6dG8o=; b=KBzPZGZpyfQH237ipVzQT4zLXh
	gUjRfxOFl4OdIHiueLdXFcV1bVNEnfkONNH3wj9/gbd6NhKU09qJWQBQckRXk4RJ9i2qiYtCunaAB
	xUV+sC1UfoRxXeSTfe9vznBW1Zq52rlDXE8lfrPqELSmaLAuETOyL0y24O2X4QoD2jA2jqNbuiTys
	bWNjB2bmQUTHxbOtbjkEhBHtnN0GwUazO7O2t+mO/GrCHaVjPkXv0zofm0qvglC1hSoa25j9jQEpP
	FrlUDyj6ikP0gu1i3klP2ImtrpvRjx6fE3rPwktKRqYNFLnYFqTdSHrAW/2JfaSXLUHxCz3ZBmYvk
	tH9iEOdA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u4UNi-00GkET-BK; Tue, 15 Apr 2025 02:42:31 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH] PM: EM: Add inotify support when the energy model is updated.
Date: Tue, 15 Apr 2025 09:42:15 +0900
Message-ID: <20250415004215.48757-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sched_ext schedulers [1] currently access the energy model through the
debugfs to make energy-aware scheduling decisions [2]. The userspace part
of a sched_ext scheduler feeds the necessary (post-processed) energy-model
information to the BPF part of the scheduler.

However, there is a limitation in the current debugfs support of the energy
model. When the energy model is updated (em_dev_update_perf_domain), there
is no way for the userspace part to know such changes (besides polling the
debugfs files).

Therefore, add inotify support (IN_MODIFY) when the energy model is
updated. With this inotify support, the sched_ext scheduler can monitor the
energy model change in userspace using the regular inotify interface and
feed the updated energy model information to make energy-aware scheduling
decisions.

[1] https://lwn.net/Articles/922405/
[2] https://github.com/sched-ext/scx/pull/1624

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/energy_model.c | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9b7e2b38c7a..0c06e0278df6 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -14,6 +14,7 @@
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
 #include <linux/energy_model.h>
+#include <linux/fsnotify.h>
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
 
@@ -156,9 +157,53 @@ static int __init em_debug_init(void)
 	return 0;
 }
 fs_initcall(em_debug_init);
+
+static void em_debug_update_ps(struct em_perf_domain *em_pd, int i,
+			       struct dentry *pd)
+{
+	static const char *names[] = {
+		"frequency",
+		"power",
+		"cost",
+		"performance",
+		"inefficient",
+	};
+	struct em_perf_state *table;
+	unsigned long freq;
+	struct dentry *d, *cd;
+	char name[24];
+	int j;
+
+	rcu_read_lock();
+	table = em_perf_state_from_pd(em_pd);
+	freq = table[i].frequency;
+	rcu_read_unlock();
+
+	snprintf(name, sizeof(name), "ps:%lu", freq);
+	d = debugfs_lookup(name, pd);
+
+	for (j = 0; j < ARRAY_SIZE(names); j++) {
+		cd = debugfs_lookup(names[j], d);
+		if (!cd)
+			return;
+		fsnotify_dentry(cd, FS_MODIFY);
+		cond_resched();
+	}
+}
+
+static void em_debug_update(struct device *dev)
+{
+	struct dentry *d;
+	int i;
+
+	d = debugfs_lookup(dev_name(dev), rootdir);
+	for (i = 0; i < dev->em_pd->nr_perf_states; i++)
+		em_debug_update_ps(dev->em_pd, i, d);
+}
 #else /* CONFIG_DEBUG_FS */
 static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
+static void em_debug_update(struct device *dev) {}
 #endif
 
 static void em_release_table_kref(struct kref *kref)
@@ -323,6 +368,8 @@ int em_dev_update_perf_domain(struct device *dev,
 
 	em_table_free(old_table);
 
+	em_debug_update(dev);
+
 	mutex_unlock(&em_pd_mutex);
 	return 0;
 }
-- 
2.49.0


