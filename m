Return-Path: <linux-pm+bounces-27778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908E3AC74E7
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45D5A285BB
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A339EC8EB;
	Thu, 29 May 2025 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KNSiZvIs"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266313AA2F;
	Thu, 29 May 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477660; cv=none; b=WEEzlB4Ifz/YRVp/gAsk9Psrt8iva2b37gUPSFhDUsALlQN8EFkZA+i50rcibo3d9Nw5BakfvTBvBkJWCnQzIUoCfB/6jsCXVTFAz2jjg5jAVBDA70Ces3CBJ6G+oJJCQxdry6DC2qUSoJDSKnRAFe7zo6zvNMH4dSDkvs8shOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477660; c=relaxed/simple;
	bh=oXphYnvlY0+nEh9xNPWCHJQ+4m75zEIMbGD0n144zME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3FGlLx9YNjxn0ZygaP0C70YtBp2qgYDr0EpjBikygBxDXy92ceG4f6dzu/gBbHM8ULwp4dhD6ucY61m7ULJwhjqJjYQtFp7Th4PK/TiD0isbp+O8M8/8qqN0yPxvsVkQVaxz62ujH2YjW6BhBLg2324xDM6q5bYfcW/9T6KZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KNSiZvIs; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Qz1POfkhqnx5JYyDkFz+Zt8jRmnUywERG2QJlsPbBtY=; b=KNSiZvIs6ypOHr09TspWbso8wg
	NfrVGyrY4rr9vdxPCb5/m/a/IJN1qO2Xa2coOjYdVyalZ+R5sYCN+6npwQyXPkhF0lXTuiq4+G69n
	Xjxi1EElaJMkAY4zO0eNeIPWKnFIhwQ4MHRhDnv8ykD9ynMckzhdJHDBc0DjWqGyY44nABgjMUVJ9
	exxYEFAV9/JQv/lXa1qqHWzEWZ43Azrtxo3INVECCtEvl56hYqrp3iweAuH837Bppnd5NdjddQmeu
	kD2CefmSgcO8Tsdo2yUFTK1+ImooBHbfgI/HjXeXQ5stoGcZfB2FN0zp0BeMS7sQji7VwsKzQpd66
	vMJpChUg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQuR-00EZx8-PG; Thu, 29 May 2025 02:14:13 +0200
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
Subject: [PATCH 07/11] PM: EM: Add an iterator and accessor for the performance domain.
Date: Thu, 29 May 2025 09:13:11 +0900
Message-ID: <20250529001315.233492-8-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529001315.233492-1-changwoo@igalia.com>
References: <20250529001315.233492-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an iterator function (for_each_em_perf_domain) that iterates all the
performance domains in the global list. A passed callback function (cb) is
called for each performance domain.

Additionally, add a lookup function (em_perf_domain_get_by_id) that
searches for a performance domain by matching the ID in the global list.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 include/linux/energy_model.h | 16 +++++++++++++++-
 kernel/power/energy_model.c  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 2f5c73fcdfe5..26ed475cd3c4 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -341,6 +341,9 @@ struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
 	return rcu_dereference(pd->em_table)->state;
 }
 
+int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
+			    void *data);
+struct em_perf_domain *em_perf_domain_get_by_id(int id);
 #else
 struct em_data_callback {};
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
@@ -410,6 +413,17 @@ int em_update_performance_limits(struct em_perf_domain *pd,
 }
 static inline void em_adjust_cpu_capacity(unsigned int cpu) {}
 static inline void em_rebuild_sched_domains(void) {}
-#endif
+static inline
+int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
+			    void *data)
+{
+	return -EINVAL;
+}
+static inline
+struct em_perf_domain *em_perf_domain_get_by_id(int id)
+{
+	return NULL;
+}
+#endif /* CONFIG_ENERGY_MODEL */
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index f441c9c1b848..6ed847046a2f 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -979,6 +979,40 @@ void em_rebuild_sched_domains(void)
 	schedule_work(&rebuild_sd_work);
 }
 
+int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
+			    void *data)
+{
+	struct em_perf_domain *pd;
+
+	lockdep_assert_not_held(&em_pd_mutex);
+	guard(mutex)(&em_pd_list_mutex);
+
+	list_for_each_entry(pd, &em_pd_list, node) {
+		int ret;
+
+		ret = cb(pd, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct em_perf_domain *em_perf_domain_get_by_id(int id)
+{
+	struct em_perf_domain *pd;
+
+	lockdep_assert_not_held(&em_pd_mutex);
+	guard(mutex)(&em_pd_list_mutex);
+
+	list_for_each_entry(pd, &em_pd_list, node) {
+		if (pd->id == id)
+			return pd;
+	}
+
+	return NULL;
+}
+
 static int __init em_init(void)
 {
 	int result;
-- 
2.49.0


