Return-Path: <linux-pm+bounces-32107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB4CB1FD1C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 01:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01B318988D6
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 23:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF92D8396;
	Sun, 10 Aug 2025 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ioQzHc79"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0532D8383;
	Sun, 10 Aug 2025 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754868871; cv=none; b=ehg6PVC1uvtvyXRiNR6pNVOv8q13g8KNTcRf0RCdfqqzNtyj0ZvRLef2TEyhyuzov3tqVPZhAJ9CtF7N6dOMh6dpYa5nQaPiUd1ITdbR4ov1rNAYU3kDtVQeu+KYLrZl3+7qqMwbKqxVY8ljI8DcYa0vWZJhc8jKP0HtZ3CYPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754868871; c=relaxed/simple;
	bh=+E8p1LPAxIi35xQjjyrVIbHLLESyNjX0YAOV8iDtAdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyE0Gk12saZfWm1WQs+OlQBJ+SIYsK5LiGf5iqrGPXsd3X73H/29Wcrbt5k0zXg0h5C+8Bf1QtJeOUW7LgWotQuhMkvSzBUgi9sA5nuQgXAL/2QQmXbLAHyM9wsZYAZNycmCtIpFJA2Pxe/tvXwjJT4tYVTrC1o4VCTlXWPcn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ioQzHc79; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XSF8RjyBVZ6UX7DL/VCIElBWNCH7oHr3sUBcfJ43jro=; b=ioQzHc79QvS0zwtpyOYY1LPS2Q
	w1hanXEmOGUn+t5n9qIOrrFO8bk77caf5R3J/a6ad6P3uwuUWiakRijtwmrJB2Mbjw7SxAnjVPTht
	cq8vhhoqrd76GzzUfHL3dy7TMLGK6iJ+drnHuIO1dB5IK80Ad4H9vIM69f0feliJ48V0Ida0yKvND
	CFafxY2ITSGw6WDqTejcXE3tpSKvoiWKBOquvuHTV5U0MrWB8JswaoIRpqL4F9cAo/aD3/ziIRcM1
	8fIeY+3bePeQcsCJqA24QFiglmvrfVNNklT+Jar9J7bVoR5ueDEWQcVEu+5auTr8MXi0HD82mjVpK
	dNvQ/p8Q==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulFYT-00CWAD-VO; Mon, 11 Aug 2025 01:34:23 +0200
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
Subject: [PATCH RESEND v3 05/10] PM: EM: Add an iterator and accessor for the performance domain.
Date: Mon, 11 Aug 2025 08:33:42 +0900
Message-ID: <20250810233347.81957-6-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810233347.81957-1-changwoo@igalia.com>
References: <20250810233347.81957-1-changwoo@igalia.com>
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
2.50.1


