Return-Path: <linux-pm+bounces-26767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68AAAD2EE
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 03:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE431BC33AD
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 01:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120E18DB03;
	Wed,  7 May 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WhzpZPi3"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD53183CCA;
	Wed,  7 May 2025 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582471; cv=none; b=CJhfFxqLlORIvYC6RKmINe5JDoEGzOEW9Cm7hLd8RHFu7IrdSG1lF75yXJY0Dmw9Ae2YVuZDURGrTed2m1F5yiBG5xuIwgaFmgTuuDVM1Tq9fkeIIzU9FK7mjSWRPnSWhwTTqLQ5j4S8VhNIanY0IwWS/QldqucrPZFxyxRt2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582471; c=relaxed/simple;
	bh=P7JM0gIyoU74Uu8KloyAc1LYlSsNM9mutpET32qMuRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmNUc7oAbS2FNGSwI68gJXlgncnbn0BAsmigPs3DNsyGtUSUjzbl4olPxkJ802eTEs9Nfdb9iLpM4ECiECzpdXVZcu3vNhfALObHSMm9DVe9lyxkUwDw4QqE2uOPHz2NDoNCnHsGsUVletuA3vdfNv0DE85nB8SlDtoEycSLujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WhzpZPi3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pDb/PNle/XHSh3qkVS0xhpcBiGspbid8CIPz1xypFW4=; b=WhzpZPi3Qp01t9ERXtnXig9A2I
	iyiPcIQLy+2GL2vrmGWpMg0BAIzFLDenlx0sbie6rQxdiT/xXfiGlJxA2CF4j0GlrXAeaRiFAjfq7
	wEoTTrs7cprp+hlLnujqUU1Kav/hrnIddPizlYx6yLaVyBn/Qh02djJ8b5qkm7M/E51ZCBa3dd+nw
	F4dqfjd4QKbZoS6M1qXLk3JXlIB1cSiaTmOvYaGo93f9sKy7sWRCWQMLqc3uqWX8MqjmJJ8fyZifa
	xQmfL+zlb0KxoAvKPK3GzXni6sJCDEOEHnedG6aVYk9gb/Qs/gHUPlcDg0vrAeCwV+6MkfIiPUJVp
	PxKfSAmQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uCTp7-004UH1-H7; Wed, 07 May 2025 03:47:36 +0200
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
Subject: [PATCH v2] PM: EM: Add inotify support when the energy model is updated.
Date: Wed,  7 May 2025 10:47:28 +0900
Message-ID: <20250507014728.6094-1-changwoo@igalia.com>
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

Therefore, add inotify support (IN_MODIFY) when the energy model is updated.
With this inotify support, the directory of an updated performance domain
(e.g., /sys/kernel/debug/energy_model/cpu0) and its parent directory (e.g.,
/sys/kernel/debug/energy_model) are inotified. Therefore, a sched_ext
scheduler (or any userspace application) monitors the energy model change
in userspace using the regular inotify interface.

Note that accessing the energy model information from userspace has many
advantages over other alternatives, especially adding new BPF kfuncs. The
userspace has much more freedom than the BPF code (e.g., using external
libraries and floating point arithmetics), which may be infeasible (if not
impossible) in the BPF/kernel code.

[1] https://lwn.net/Articles/922405/
[2] https://github.com/sched-ext/scx/pull/1624

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---

ChangeLog v1 -> v2:
  - Change em_debug_update() to only inotify the directory of an updated
    performance domain (and its parent directory).
  - Move the em_debug_update() call outside of the mutex lock.
  - Update the commit message to clarify its motivation and what will be
    inotified when updated. 

 kernel/power/energy_model.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9b7e2b38c7a..590e90e8cb66 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -14,6 +14,7 @@
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
 #include <linux/energy_model.h>
+#include <linux/fsnotify.h>
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
 
@@ -156,9 +157,18 @@ static int __init em_debug_init(void)
 	return 0;
 }
 fs_initcall(em_debug_init);
+
+static void em_debug_update(struct device *dev)
+{
+	struct dentry *d;
+
+	d = debugfs_lookup(dev_name(dev), rootdir);
+	fsnotify_dentry(d, FS_MODIFY);
+}
 #else /* CONFIG_DEBUG_FS */
 static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
+static void em_debug_update(struct device *dev) {}
 #endif
 
 static void em_release_table_kref(struct kref *kref)
@@ -324,6 +334,8 @@ int em_dev_update_perf_domain(struct device *dev,
 	em_table_free(old_table);
 
 	mutex_unlock(&em_pd_mutex);
+
+	em_debug_update(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
-- 
2.49.0


