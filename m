Return-Path: <linux-pm+bounces-28650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF83AD885E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CA1189E6A4
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163A2E2EE5;
	Fri, 13 Jun 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VNo5+tQG"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826B2E175B;
	Fri, 13 Jun 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807940; cv=none; b=Pmn63Vum14/mUlYAonMGgPbWId4pbD36VvqZMQaD1nRSZTydz7EWYM+4DgixTRDmeCpPMpAIgXU680gStTJKhVhSe2mlgs4NLaKuZvEvGy+Yp3dtfg3f488CNX1RZfZOFID/aVjs3g00fe8gAKMhBOye/CE4h0p6yY1D9waHxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807940; c=relaxed/simple;
	bh=2FudhAI9UWkcztWjvNL8C1SXNVOscvCku0Qp53bjWpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mw0p2xEdk/FKqPF/DGNObvSiy4XpUXg7gVyFJThIXPneLphcASM0QxmxZZqG0MCy+Qi8BF4fLkLtcFzK7QHvYatA8cQwsjINSUgGnWCxCttRf62UZEQ+EvsXAmHVqy6IJlp90FJ3vztGi05NEw0tzOpKB8oz7yGKm4FWIysfxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VNo5+tQG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=68O/6enx02DdtYXCqP3EiTv8qCX7nFwxWLKHvVg5lTo=; b=VNo5+tQGwmDnCmPm57hu9Y9Tn5
	TWSVm9Uzg6frtYGFtGZ35RmfYqNh2L8ekLC6AHPJ8GjduT/WkBhoKbH4fIp3h/3VmIYh1l9RwSt4I
	jJ+VZBZadBQ+ANjeZMD4rqNzZZgxlMkrkvprVR7vpwvanHci5ovqpJinzEbIB7VfAQZtfukzt4S/r
	jMTiv5z1Q2lGSk5VzLSJcV+GKgMDq/wf0L7F6/Dw5gRTrPM2ycbb2H5nSbfAIOmkbptwoEgdll/aG
	62pKiwE5Iuoa3PiGPeoiSDmE1wXrk0kJ72sfYlg7DNIH0ZTWz6xfuT5X/d/Z69V3jZ7zoevfTGbWG
	7PFsqnEw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQ0yZ-002xfb-6m; Fri, 13 Jun 2025 11:45:32 +0200
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
Subject: [PATCH v2 10/10] PM: EM: Notify an event when the performance domain changes.
Date: Fri, 13 Jun 2025 18:44:28 +0900
Message-ID: <20250613094428.267791-11-changwoo@igalia.com>
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

Send an event to userspace when a performance domain is created or deleted,
or its energy model is updated.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/energy_model.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index f125262a93c9..c72ac1585f59 100644
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
@@ -673,6 +677,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	list_add_tail(&dev->em_pd->node, &em_pd_list);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_created(dev->em_pd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
@@ -695,6 +700,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	list_del_init(&dev->em_pd->node);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_deleted(dev->em_pd);
+
 	/*
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
-- 
2.49.0


