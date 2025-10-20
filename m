Return-Path: <linux-pm+bounces-36528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16108BF3D75
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 00:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC7E488D76
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A32F1FD1;
	Mon, 20 Oct 2025 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="h8FRer9e"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41672F1FF1;
	Mon, 20 Oct 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998211; cv=none; b=ach63aWnp3qbUjxbWa3erAFPK6QJGlbPsCSCUXGMLrV7Oaq6Iw8pvIlgadGvWaC/tPO1ylHwTgvVOSLNQhlpQQyMjxLC+PrT3PuH0Rku2OtEB20aON1stgtnkK3bPGm9Z7/Vr2FFZg9sECjP0G2L5WditTVazVXjS+ocJEpzzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998211; c=relaxed/simple;
	bh=1yIg7dHF3CyRg844eO79zOv4yiU6/OVOg/B/vkwccnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npbc5PqbVnKAcjJOK8A6DtkIGoipBJFdRgzDUwD+eBel36r0sZdRHSfoM4nKMqNpXm9ldvRUq4GIiZCHAs7/Tbd67nZr4oJTFIpIeYwHWhORLIF0QbDOWDahE0oI0p8PZ9k80sEzIcxNeX+2B9ptDZeXHwesaqnupl9hJACKiXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=h8FRer9e; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gyg0WST9LZSc6E28J9ruwfqB7SqRNUl68LO52d7HJnk=; b=h8FRer9eNqbhodvcBqaUF5zW5N
	5WM1QIlZH0kSYWkoB4IR4T3UGxEBgmRU6EbGVEf/hhAa4kbHK6nT05AfQqhysiPeGfns1295X195Q
	rZL4cDKltvXoV9v03sTFrioj0L5yx7KGBm0nUu8of34f9RofOockCcp37wlZctzlcK54sEsA1UVvI
	SFIZXk4dpCKlOeaQCWdetA6Q7hOrHgINM9YLMJ6R1ZCOw7pamrm/lYgiFFjmYWeH5RohNJjVaQXIt
	EZtmy4ZuYGOOvgOfG9QDQmKKPJg+pNghH/hH7P6gDYWFhNAoEzB4E5A1/fmrs5FpyvMjDUYatsvHA
	RObcu+Qg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vAy4o-00CHZL-2m; Tue, 21 Oct 2025 00:10:03 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v6 05/10] PM: EM: Add an iterator and accessor for the performance domain
Date: Tue, 21 Oct 2025 07:09:09 +0900
Message-ID: <20251020220914.320832-6-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020220914.320832-1-changwoo@igalia.com>
References: <20251020220914.320832-1-changwoo@igalia.com>
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
 kernel/power/em_netlink.h   | 14 ++++++++++++++
 kernel/power/energy_model.c | 38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/kernel/power/em_netlink.h b/kernel/power/em_netlink.h
index acd186c92d6b..8114b018c73b 100644
--- a/kernel/power/em_netlink.h
+++ b/kernel/power/em_netlink.h
@@ -10,7 +10,21 @@
 #define _EM_NETLINK_H
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
+int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
+			    void *data);
+struct em_perf_domain *em_perf_domain_get_by_id(int id);
 #else
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
 #endif
 
 #endif /* _EM_NETLINK_H */
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 756debf5406a..9e35aba4b113 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -17,6 +17,8 @@
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
 
+#include "em_netlink.h"
+
 /*
  * Mutex serializing the registrations of performance domains and letting
  * callbacks defined by drivers sleep.
@@ -998,3 +1000,39 @@ void em_rebuild_sched_domains(void)
 	 */
 	schedule_work(&rebuild_sd_work);
 }
+
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_NET)
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
+#endif
-- 
2.51.1.dirty


