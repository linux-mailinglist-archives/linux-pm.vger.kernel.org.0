Return-Path: <linux-pm+bounces-32112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0CB1FD23
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 01:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CEB16856A
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 23:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87D82D8DC2;
	Sun, 10 Aug 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZQg2RqdV"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577E2D876D;
	Sun, 10 Aug 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754868897; cv=none; b=nbSi93MMQn7RQH96HNEnqdBRG3WUtdo8biWJ72dD6R1Cn7HbiSPH/bgkR9+DkUszbnLjh2laKPEjvxmR5VdD1BKF8vJwVw3C0IrZouWpp0fn3tPc8CwBe4UYpnKEwdw6NKSUA3+FVV75cgoe9uGBLkujR2ygzUcfP432CYpqow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754868897; c=relaxed/simple;
	bh=tH/5vvG+nJo42vQ0Dn/dK3z7XDWN7KkPYZ8gO/iweCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyXUqYX05UUFo08ZDhGixGAi7PsJJaesnIN4XumaY3E7uz9mZWppDi6D5vA5+qEw3e8+TXiRiuBO47eKNqR5GbyK0tzUi/R05MGOeM3fvp+A8nQYLVxvK4IXWQZAou+g7fnzGhLmTCkCYKxRBW9F8MjZFM82OZMkdmW8N4WF8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZQg2RqdV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/sQxHmfDttCLi7HgkpNucR8JfcipNG5wNYUUdmrAhWU=; b=ZQg2RqdVj5r97ts0jOxMAkMTRv
	xuyZoogVTffSJyVYXQ1jHZYZS6EApaiVym9pUKcE/LUzKolFhS4Stw81RccUSUdyrO3t8KiuQyzoV
	ZhaNmp+tEHuEp7ln59uafqZVrwKzGqAtkFjmLv8Ap1o+wOf1g7yNDCmWZ78sZH70E7sa/+/ivdV5I
	pjS7uveAfOZw9UqwKoC4OhUIQHMYcz7pu90GYFbV4J4R9P7KJhYqmVle4lH3h2sYyfGSwJNyQsq1M
	jYQ/mLzdJJ3tRhQZBhWGYGkvVun4BkWEoPfi2BnOkB8jZ5nmL7+fxAjcsltvmAtsoxcXFsL9vaFAM
	ls6zsM5Q==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulFYv-00CWBm-0A; Mon, 11 Aug 2025 01:34:50 +0200
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
Subject: [PATCH RESEND v3 10/10] PM: EM: Notify an event when the performance domain changes.
Date: Mon, 11 Aug 2025 08:33:47 +0900
Message-ID: <20250810233347.81957-11-changwoo@igalia.com>
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
2.50.1


