Return-Path: <linux-pm+bounces-36020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C0BD6DA7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 02:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDDB422A3D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5C15B0EC;
	Tue, 14 Oct 2025 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JhKbuU29"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA202E63C;
	Tue, 14 Oct 2025 00:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400706; cv=none; b=muUmOOQD0gMdONd/eafnR50khn1cZ/T7YTROWhBHJAhhLH8+FqT1PFE7x0QDtzkBYlkyXuRsgsuQHqWN/HhJKBWBFEmcVZaxnMTTQNppXOmSGRuJls5cM+Fxy2l8o5KapadSyAFH1cNP9Qt5Bonsx93FYYBeVDri03w7JQRMTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400706; c=relaxed/simple;
	bh=/4jHAXXsE6z0esH6njaFLFzCZF6GLER/C4lS3jif4/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtHWvNFYE/InP9wHaAjoFIemHoyXI6SjLssSEao8qihmqYxikoZja1naYUuJfpKN8/EAE/alTNVT/58tHuiABnvH39r3NRIHfgYIeTQJtsPkg2SWUsS1vY4qnrGg7XybIRxOg6m6JJKUrOOaBVuHD4oXWyY9oIak7WK6baiAYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JhKbuU29; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rTY551GlcEu5wlZKVwikaNPYgNimBgZh0bFw9SyMiUE=; b=JhKbuU29H6tWdvIh+ML3GKSFEq
	3qjrmhvBFath50j4A1sXDebXhfz+6I4wBGazApsH+p4wDjEFlHvuo396IQqAspNPrKRnYw0JH/SS6
	qIh23sH/omK7NOF84LG2WjdxXK3HjoEPUFjrePIzAfeVE2re14oX0Fcakoh9rvZ2UhABZcP+BcHzR
	wdYv+I3RQ2iBmfqyt14QVLtDSlWK0OjblBsA6VXoWAZDznh0c1AupDHo4qgJ0b4IS9Zc0ojlJ9WSg
	iGY+nVmWK+OcqGT/xfBHY85K/nkeqoDW1r07UUKcsiApa+psOy1cZj74j7eBTxrCZ7GAUI7TCt3WK
	2lrG/xmQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8Sdc-009A1O-77; Tue, 14 Oct 2025 02:11:37 +0200
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
Subject: [PATCH v5 05/10] PM: EM: Add an iterator and accessor for the performance domain
Date: Tue, 14 Oct 2025 09:10:50 +0900
Message-ID: <20251014001055.772422-6-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014001055.772422-1-changwoo@igalia.com>
References: <20251014001055.772422-1-changwoo@igalia.com>
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
 kernel/power/energy_model.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index 756debf5406a..43a243f9cfa2 100644
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
@@ -998,3 +1000,37 @@ void em_rebuild_sched_domains(void)
 	 */
 	schedule_work(&rebuild_sd_work);
 }
+
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
-- 
2.51.0


