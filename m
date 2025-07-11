Return-Path: <linux-pm+bounces-30661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E62B01077
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ECB765E77
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840A919FA8D;
	Fri, 11 Jul 2025 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZIvqrJ9H"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC412141987;
	Fri, 11 Jul 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195264; cv=none; b=i5OKjw6UQpdqoCbXlFf8lUm95DgH5Hh5r1Vt3WitP4y529DrXjixdW66Iamyy38B1tYS2GYfi4ms1xWqychdVvJZ2Uv4UffMdS549kDGm/NPet3i+90TrAHCA+dY3ygHxviJBRM/qSuRH+oel9eKq6KV8VPmYdyuZ9UP5at4B+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195264; c=relaxed/simple;
	bh=CSolf0jBOXS5NB4nXpcpm4XgLXu5ES6UWlXb/raa5Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcwtyrX00DB39s5rzcgYDiZYjfVAtmsAwZEtJFo5FodcvraYzL365B8zR5sDZ4D5Sq1LqJThZWQPAha1Uz8irw12nm26Q7+iBlien6690wg9zXZa8tsMBF75zV0XS979r3gDEoUsz81ctBM3jAo+KC2H3fl5KZ+cagZsVbxJRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZIvqrJ9H; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TxVY9oGT+pZdbf2gjYB9WLnvsRz4IlcdJ5TO+IaTQes=; b=ZIvqrJ9Hg3Vex5MI3qVIuGP+QA
	XElMyv4humyH4K+F3TMiPoJfs/0eJyZ/rZbeDLt/vxQ8Nc/m7zLy7Pt/dD/xHDOHV/b2Smja6oXDF
	m/THG88h4hB9M2vYPX9NSUvZ/RbsCcvU21woxT3ZxSrE26msJhjKBYBcqXkBGtU5H1CaVrc1y6bWn
	fH04h+MfcNFAymuQTyppxKK04vPiJJhGeWsTt5UIcdPXrfvJr7z0epuQvPrB53M82Br/SavPyXCcr
	DrRXJDl0jRADPmmhO57yRgEqWIWr08zWbQFA3NnjCzc+lDiSkRyKaE9vodOZQBiRCMYSvJJ4506fz
	G5J1xFNA==;
Received: from [59.10.240.225] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ua21n-00FAog-Jn; Fri, 11 Jul 2025 02:54:16 +0200
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
Subject: [PATCH v3 10/10] PM: EM: Notify an event when the performance domain changes.
Date: Fri, 11 Jul 2025 09:53:10 +0900
Message-ID: <20250711005310.20740-11-changwoo@igalia.com>
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
2.50.0


