Return-Path: <linux-pm+bounces-33503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D8B3D681
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 04:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9449178F37
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 02:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F995218AC4;
	Mon,  1 Sep 2025 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PxcNI5nS"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBD21507F;
	Mon,  1 Sep 2025 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692074; cv=none; b=r/Q0mL6AsAqEv9NyaQgDw+o2zB+fB6JKk4IFoChqiJewU523CbqHpOVOJ45Go1lP90YhuAed64jCnklDDR033dV/gDxnSKA7REMJDCGuv2Nh6YZYNmXpgpGWLe9n6Pp8/BxqG6+mffaa+vz6WjPD33i+ZW5LzcqQnxt8l+KoIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692074; c=relaxed/simple;
	bh=Q/z7LI47wr9pn1YEATow99dNBdZHfjMqq5CdG8/pbJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBVfm4CO4ij21KJFpfiXysJdO9wXvXkXJ0do5soT2PRTmtFbudWskYml0szRPS35rwXfrsr2XLPGgQ5VT8Ya+ayLddxBtlbIvAqx1tbCqlTSPOhdQVOkw6M3Tt0kOSWfhCj+nwEWHBkbkEqgo7us0cVcymt5AyB6YbYYnu/zdNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PxcNI5nS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dfYbmrCczlNVG1eBqr4LEnZbYXkxcRDqXj5cgSmNT+c=; b=PxcNI5nSAmQGBfHf6v0tSJlQPU
	eiVG/sM8fLz44IrfC9lM/bWwWyFFrwR+6nc+V/wRt9iW+EUaWOoxQ0G2omjf3u6i7Wd0bnlm0m2r3
	K0vCuXgL22VhD9txcGAWYFGqFuFR5lY8a96uW6VdNSq6MVJCYxlpmbyTfJ11KiV9Tm3vndM42hvaZ
	+bWhxpTTJKja068uM1mTDNnfM7by9gVJ2zN/JCGPMeaY7SCf7g7rt7carBBGr3ZXda3lynm9/JwUM
	hcL6pOUDQrQ1WPmQe82ph1MfRnNFxmOsDbO2b9/NfBKS5FIfXykD6/IJti6N7ghC+uoijqoEVl9MV
	9iyLkGtg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ustqz-0054Vm-SV; Mon, 01 Sep 2025 04:01:06 +0200
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
Subject: [PATCH v4 10/10] PM: EM: Notify an event when the performance domain changes
Date: Mon,  1 Sep 2025 11:00:03 +0900
Message-ID: <20250901020003.86415-11-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901020003.86415-1-changwoo@igalia.com>
References: <20250901020003.86415-1-changwoo@igalia.com>
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
2.51.0


