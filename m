Return-Path: <linux-pm+bounces-27782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED3AC74EE
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1614A89F6
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF741A3142;
	Thu, 29 May 2025 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kEgaKK/Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886D219E8;
	Thu, 29 May 2025 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477691; cv=none; b=LUtzCBzfRZ6eVXxWbzw97TeH/MDVouBsiwwW5TMYQTP5zUri/aUP8oaCYQZ4pBU2kXS+YXTpxw9UMViI7VOVFlXEeQ5yS/0zD7wWlB5bRFCRMTapHUhMkB9r89NOqqcaXkBWW1fPT6fRn4TF6YSdReslVnu9MQTCkX5VEdrnTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477691; c=relaxed/simple;
	bh=jcSTdB8cYTgK7fXz9q7Lo3F6qxZZiKZrm/tD702Jhbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg+FriAaDgssYgEkw8U4yp8ObVOTjKd0JXl75UZdSwg6YBgFR3L8AecT2Wx6P53cyxjDSHzqbpsdooXLTreboMZq00IOI7w5DeJfwaWzF+gyyF40a7OhfCw/lDJP1Yw6tw3YTn0aiux3YhVuvL1CGffw2Qa+ULjKLHOfYM4Vkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kEgaKK/Q; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sJHUUz+5d/oc9AFid9FJLsG4+QoSnBTtVC2wDx4OwSA=; b=kEgaKK/QRe4PmNcW+bdMI++Y56
	TsYxIf0T0clOK4nlwWGsFxvC9d9rTqiWHICY50sIW/FO4UuaN6t1Q6cLE5daiUcxDQ/wz7BtTTRkL
	qSTm+q/ZUPydRjzPspDQ4b1dvHX2zYxgNeCIrlBzltJqERvXXVYyUmtbYjCtOlBaAtHV+GXE8RG5n
	ZO1Lqc5q9LXHB5Id8nGSo3GYkIIp00uGNW98PG1eiUZNLDcWHyTn9yivvOmmCHojcAnbUQrzRRkSw
	LRiiAxOqhqYeyQfGrsvPfCrFlMnPBXOZ0KeKkYMVtLL2Jam4I3hBhR41By3p+vAzg0872HvNlDmOj
	0BRUi/xA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQuw-00EZy4-2f; Thu, 29 May 2025 02:14:43 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH 11/11] PM: EM: Notify an event when the performance domain changes.
Date: Thu, 29 May 2025 09:13:15 +0900
Message-ID: <20250529001315.233492-12-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529001315.233492-1-changwoo@igalia.com>
References: <20250529001315.233492-1-changwoo@igalia.com>
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
 kernel/power/energy_model.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 6ed847046a2f..5764821faef3 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -352,6 +352,8 @@ int em_dev_update_perf_domain(struct device *dev,
 	em_table_free(old_table);
 
 	mutex_unlock(&em_pd_mutex);
+
+	em_notify_pd_update(pd);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
@@ -675,6 +677,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	list_add_tail(&dev->em_pd->node, &em_pd_list);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_create(dev->em_pd);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
@@ -697,6 +701,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	list_del_init(&dev->em_pd->node);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_delete(dev->em_pd);
+
 	/*
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
-- 
2.49.0


