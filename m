Return-Path: <linux-pm+bounces-30656-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF7B0106C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595C13AEA8D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A114B06C;
	Fri, 11 Jul 2025 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OlA5hLBo"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6515383A;
	Fri, 11 Jul 2025 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195236; cv=none; b=fIRnaFh/usgR0KgTSsEc96kDThVgoiQQ+jVA/0BZGv4grvopssk4nE7HOVAo6R/UViUCTKrHBaY7F/x1klCyinm9/23yC8bre8J+2eSh8Pwn35yAm1VQ44jbO6v0IeuR0qbJJe+nr+6W9pVYxxY2VNrGGB1YQjbCkmhgz+XW9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195236; c=relaxed/simple;
	bh=jJFbpYkqy/73E55orbSOkvpZKd5oXEt4d72vTkDPWw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcBlBKoxj3diixfQ1Ljb0+vLzsTKsBplIMIOj1s0DdkKNycqz8p6I1oUWSAPt4y89YdNsbQoAveail6q91098ImEYBNqq3CaSqDCbNkdgUFGvg7YQjNXxAKWUm7EUpxvoyc1d9PRAztkU3dF9C/tmKUDObrQ1DUBuWsOBmIFBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OlA5hLBo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=90fpkRptMwqv5G71uZtM9Sdw0kmNk4iO7k1dGUX2nEA=; b=OlA5hLBocSgnIcc0xONkuLCU+f
	dxgESMiix3yuzx1IRavrN7tMVJBH5qm3r+R/3dhSGnc8hewirBuitvLa+NYMKY3DqyFXHRyd9rNRS
	gWc+0N1GdKSZBUIBKlninYvAXdvXN7Q1CilV1iQiiCJN62onhYmbyg5rxPGnUKGFInqi506ubBUBK
	zx77m3bxtqx+lxrOX8yP7wbv33RqCuSBX/83ywLF+eRYf0sGfa9ORdmU7yJTCkR5zRerb1aXnScQC
	jsachZDKHN5hYhsXM4UaUp2P9KZcYZFS7AsKb7TZzULK4nE8N+l+BnleW0uRhdRwfxM8Vu3byA5A7
	pC+zOv2w==;
Received: from [59.10.240.225] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ua21L-00FAn5-V1; Fri, 11 Jul 2025 02:53:49 +0200
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
Subject: [PATCH v3 05/10] PM: EM: Add an iterator and accessor for the performance domain.
Date: Fri, 11 Jul 2025 09:53:05 +0900
Message-ID: <20250711005310.20740-6-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711005310.20740-1-changwoo@igalia.com>
References: <20250711005310.20740-1-changwoo@igalia.com>
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
 include/linux/energy_model.h | 15 +++++++++++++++
 kernel/power/energy_model.c  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 2f5c73fcdfe5..ce70e664fcd4 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -341,6 +341,10 @@ struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
 	return rcu_dereference(pd->em_table)->state;
 }
 
+int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
+			    void *data);
+struct em_perf_domain *em_perf_domain_get_by_id(int id);
+
 #else
 struct em_data_callback {};
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
@@ -410,6 +414,17 @@ int em_update_performance_limits(struct em_perf_domain *pd,
 }
 static inline void em_adjust_cpu_capacity(unsigned int cpu) {}
 static inline void em_rebuild_sched_domains(void) {}
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
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 6e5e70dbec88..f125262a93c9 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -976,3 +976,37 @@ void em_rebuild_sched_domains(void)
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
2.50.0


