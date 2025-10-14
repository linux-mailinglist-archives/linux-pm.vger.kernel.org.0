Return-Path: <linux-pm+bounces-36025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 177ECBD6DEA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 02:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7204919A0526
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B24335C7;
	Tue, 14 Oct 2025 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fMFnHTbe"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB24086A;
	Tue, 14 Oct 2025 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400739; cv=none; b=VfEPi7WH8KwWJ4PUBkyQwo1CE/8RoCEsLqoXymcYexz2/WdPNK/LnLANs69Bwl0R6NrVOP3r/K521yerVL1bWOn2cQzcEo6LEcFk1n0TuXm4XT4GT10zAlY7JSnY5rBxidBFoGQtd1szOYj+Xbl0pPtoUN2znH0silRHKCy8yBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400739; c=relaxed/simple;
	bh=lBfJGD9vPAbkBHzVdKJoFEgWZ+a3EijfTwd7BO0hgfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrC7Ep3CBh7bGqhMYDPSornh2J4w5QSXLrAIbwX/+Fy/NT9FUiyx1p/om5dwjAGjKhLRYOHEVAsUMhBqbU7uljtLF223eUR8qFLwwyRkm7Vnz1BJo6yH1E6lwyqUFr2poLbW8GkZiipRiYvqmGKvDjVJmw15KUGPu/LDAD8ThdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fMFnHTbe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JirnQ7lX6Pekhu8u3oHRBRn+9V7t+JwCPP9RGW/kYxc=; b=fMFnHTbeUFMNwEvTyz525K2doP
	b6yyhec0cf1uT7amehASwDieV7D3l/U40ZM/zzjGY8sVxJM0T3KU2WLzY8uTtPvfTJNwScfrSzVRO
	i7DzYh2aPENhikPNw+VTGE0cnpPuKhD9JbBS3vKGdSLrVsbsk9aqXbvehvAfiOo/BWKWOh7y4G2R1
	4jeZd7z3QxIptMHNpIPALtqTBxtqnwjM++eAcV6RmdxCLjoMqvRrdpmIHbgiQpCfZjvIj55CZ0Rv+
	a6q/HTNgDFkhItlC82/Ofw3VVlAFJ1vef3B/Fxrolb6khVWfJ9/zfhd/VYZlpI7zYq2AdeoZV5KB8
	HepV8V8Q==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v8Se8-009A3C-Sg; Tue, 14 Oct 2025 02:12:10 +0200
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
Subject: [PATCH v5 10/10] PM: EM: Notify an event when the performance domain changes
Date: Tue, 14 Oct 2025 09:10:55 +0900
Message-ID: <20251014001055.772422-11-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014001055.772422-1-changwoo@igalia.com>
References: <20251014001055.772422-1-changwoo@igalia.com>
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
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 43a243f9cfa2..92c12b5983ed 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -352,6 +352,8 @@ int em_dev_update_perf_domain(struct device *dev,
 	em_table_free(old_table);
 
 	mutex_unlock(&em_pd_mutex);
+
+	em_notify_pd_updated(pd);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
@@ -696,6 +698,7 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
 	list_add_tail(&dev->em_pd->node, &em_pd_list);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_created(dev->em_pd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
@@ -718,6 +721,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	list_del_init(&dev->em_pd->node);
 	mutex_unlock(&em_pd_list_mutex);
 
+	em_notify_pd_deleted(dev->em_pd);
+
 	/*
 	 * The mutex separates all register/unregister requests and protects
 	 * from potential clean-up/setup issues in the debugfs directories.
-- 
2.51.0


