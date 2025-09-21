Return-Path: <linux-pm+bounces-35111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7ECB8D450
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 05:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F5518A213B
	for <lists+linux-pm@lfdr.de>; Sun, 21 Sep 2025 03:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D8826CE2E;
	Sun, 21 Sep 2025 03:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B6cincJY"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB41248F64;
	Sun, 21 Sep 2025 03:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758424837; cv=none; b=tFzbbR6S+nGEILLhryHq9Uv0z0UOvSXEn0D8BwMlFdZW8X9dK3U/27WjDeejg4XIAfTz2R4em5+mLasAIIZKkhXDwX6j/axN6BGw9SSN739iNkFVtYfxCC6C0JaIsp2NzZXQpwedaQchUQWxAwVdi2XoeiG4Mu6kCCb6jGPKAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758424837; c=relaxed/simple;
	bh=y+FOHX/go9wekysNkMc1iPBG8Iy8ApZybO4toHO6X/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctTfgGLCmSsub60K+jaGe9e97ZYOxA3lu/SyY/keqkp9tsfRG+xktkqZIVQMCb7VPfd5GMg3V89+y3fWJ2H6cPC3/bI2GYtyfy8mDMzFSEPUjmmU4j6vkvT/aXOFDCdmHe1FL6P95FWBNhjD2PWpsA2kHoAj8MmkEOehJjqv0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B6cincJY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XzaDD1CcznY9UobS3SjpP6e1pWU64vfZ9Xs7KBz8zS4=; b=B6cincJYUySoF3WP5tE1SKk49n
	YwQb+Hk8fVC6Fa1w1t3IOx8bzcAvD6HyW4CnpxXR9rvXwrf3m/xoEdg3XLuTYwg1+OttWItT7SNmQ
	KKrUhwik/S9Ww5239Ubojk9JbvaK4vtIcY7lIGKWrpHhL4b21Nw2n753r/ay0BJDPZ291PY/RjT8K
	/8YL4TenyeZtJaod+y8OiZRnwJ6XcduUvjzI+xFwSaUbBhib7K6jaAPR9IrL+rLce6yqW7Gw+de/O
	N9FV+Z+ixQAboImBzOz1rXs5vYXjbv5lm6urf8JrO1q5gSUecR+nmMBNpvbIzid5AKDeiisvheMgw
	Sos6VYuA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v0Acm-00Ecjh-Rj; Sun, 21 Sep 2025 05:20:29 +0200
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
Subject: [PATCH RESEND v4 10/10] PM: EM: Notify an event when the performance domain changes
Date: Sun, 21 Sep 2025 12:19:28 +0900
Message-ID: <20250921031928.205869-11-changwoo@igalia.com>
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

Send an event to userspace when a performance domain is created or deleted,
or its energy model is updated.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/energy_model.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 740076d24479..fca32d1c6661 100644
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
@@ -350,6 +352,8 @@ int em_dev_update_perf_domain(struct device *dev,
 	em_table_free(old_table);
 
 	mutex_unlock(&em_pd_mutex);
+
+	em_notify_pd_updated(pd);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
@@ -697,6 +701,7 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
 	list_add_tail(&dev->em_pd->node, &em_pd_list);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_created(dev->em_pd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
@@ -719,6 +724,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	list_del_init(&dev->em_pd->node);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_deleted(dev->em_pd);
+
 	/*
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
-- 
2.51.0


