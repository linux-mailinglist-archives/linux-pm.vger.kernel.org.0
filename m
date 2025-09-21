Return-Path: <linux-pm+bounces-35102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15753B8D414
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 05:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A1616B25D
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 03:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283923B632;
	Sun, 21 Sep 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U2oh9fMP"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07919D8AC;
	Sun, 21 Sep 2025 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758424802; cv=none; b=UN47qUyeRxdtyBTMXOFsuSbmVCyDRvKgHjMUQng4MPvF8l0RwfUxPKQ4lzso9Rf2MFRZYCftXgzCMrxXafYmg52eoAClg7DYJCnG3ssz9rW1cNjbxL5FcccWRShbtxCoIYLnBCFDJWiEDipx3r+M46OmfRyoEszCBXP/mPH7SE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758424802; c=relaxed/simple;
	bh=++DyOH7ugH24cdWoPjX9APMDPkk9z7CzN6Vn9Y7tBDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYUmt7GUWnEiJrdnyg4BiFbvfVnnTmjyA/Wcd61pvzd2YHWA7zb+Qo/7skWzDTEUKUPnz00BWxv/uOcIQj7KwmBD5oW9X/u51LRWFDtpLUVHTOZ/jhYNZT5lft5xVLBobZb45qzAZTIv8gzzwh8L1Cq+r8myUXTae9agsTlX3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U2oh9fMP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tGdlpJHxujfBfzqdZKtnvcATGt39HpMaCyzFMXZeR7w=; b=U2oh9fMPqXZII/pckcGc+0Yznb
	sa6Ippk12xdmDxZm6AGmQZmpMe3Ru8NpsHUbVwRSQAwS19pktlq95GSnI++6ET4YfshcsLfm57lFK
	5pZbzgwlkISA4AQ/cN/6ZA6P8VIC8O9vpxCUQPmskMaJWdrYxFLdl211B8GfzmNvSGqkX7lCwAHn4
	GBNxK5EzuW5KIF0Ap9dFOPjlPsmfcXeVgqVaT7/cuZtr0KTSo9ljE5/M+e1c2GmfeuGqFmkZSnWVP
	9M3ZosaVdXC1RXlIlly+zxM8g5o9elsckL3Mdqbsc4M5HwDGr6+MDQmqFupHVE41wDiyEGlnkubJZ
	ob9DQxrQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v0AcC-00Ech4-1y; Sun, 21 Sep 2025 05:19:53 +0200
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
Subject: [PATCH RESEND v4 03/10] PM: EM: Add an iterator and accessor for the performance domain
Date: Sun, 21 Sep 2025 12:19:21 +0900
Message-ID: <20250921031928.205869-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921031928.205869-1-changwoo@igalia.com>
References: <20250921031928.205869-1-changwoo@igalia.com>
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
index 43aa6153dc57..21279e779188 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -344,6 +344,10 @@ struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
 	return rcu_dereference(pd->em_table)->state;
 }
 
+int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
+			    void *data);
+struct em_perf_domain *em_perf_domain_get_by_id(int id);
+
 #else
 struct em_data_callback {};
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
@@ -420,6 +424,17 @@ int em_update_performance_limits(struct em_perf_domain *pd,
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
index 8998a7f4910a..740076d24479 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -1000,3 +1000,37 @@ void em_rebuild_sched_domains(void)
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


