Return-Path: <linux-pm+bounces-28644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5713FAD8847
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458CE3BB123
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42623248897;
	Fri, 13 Jun 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PI26GMcL"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED12C159D;
	Fri, 13 Jun 2025 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807914; cv=none; b=kdGhlKz+yxcxyYHW1c+wrA/OGyjrwcEqRbS6TkjU7zzKrcK5dsus8pJGLwpwEREcPqTOe+NLUm6s7f9aEMf7kBJjFHhJjEz4k3fig5ODuj23y5jamV1IA1fEy+xv93YR+4GjFNlQA/H1qQWFE99R7XfB3ZCdaJtrKpuQFutRoSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807914; c=relaxed/simple;
	bh=lZ5Cbp5DZAEF1ajPrXS7A28WUePC9JCqK98EsVT52Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RerEMK9t8T2b1xaw0JeV2r15bpHAoDLqT2mwE9pKjcgDRCajgAXDTM71gQeTqb3Y9LSs0uw97ZjmqT8A58+vFQFVNKjzV2ve/wQpMFLZw/1DrdrEC8Xosbv+uhWCe9ujQ24p3zKcCWWmRx7lsdIJgh0nPhgbFjMwRUKiB/E6ev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PI26GMcL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cm5nfOLwCeFxhGh6hzuOZ8xBVvlCrscG0Xe15xpKW9c=; b=PI26GMcLESaU/Rq6ZOLhcjaEEm
	u7x6MiGIBM2iTttkS5dx/4b77jDs/cOVs/rV2GpxIGLJ1HwC/YNUbu5Wrzs95gmNproQx2GWey+hb
	5wX8MqUHHsKrdNfgMyFUueCk0aeTCtiHBjBmSKAhtDb3V4MF/Ndq3LdEeSVNzmAMpvSZ5doLG0zbo
	/cxr3kZSh/PQHVszPMwXgszTMQH2JLbS3WvvmIcp7AAT72RGvwrFRgYjsCIBgVOWyKMGCR8EfFJs8
	uvbecNriHmqpkKSh76EyMG1ep0MCUk07gK2L1Txg0PHPCL4v23c6kAxE9G//02kcLfRSiTOEYAHJP
	WS9SLaFQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQ0y8-002xeB-CT; Fri, 13 Jun 2025 11:45:05 +0200
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
Subject: [PATCH v2 05/10] PM: EM: Add an iterator and accessor for the performance domain.
Date: Fri, 13 Jun 2025 18:44:23 +0900
Message-ID: <20250613094428.267791-6-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613094428.267791-1-changwoo@igalia.com>
References: <20250613094428.267791-1-changwoo@igalia.com>
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
2.49.0


