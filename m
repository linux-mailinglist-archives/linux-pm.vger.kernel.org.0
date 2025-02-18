Return-Path: <linux-pm+bounces-22289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE9A3955B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 09:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D0F3B848F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830BE22D7BB;
	Tue, 18 Feb 2025 08:20:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309423C392
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866857; cv=none; b=askFVXp1JLjtuBEzjR8Y+vu2naTwUWYjdv0YCb/Sp7rqdkG6MdgFtTcss8SLC04mVn9wBZYQr7G8Y88KgTFzSk37onfmE8t+wbAcbBye9atwlJxO0E3i1s4iL/rZrB6/b+751bUyBu+5aTrBV5fk37JhT52fFsCyK+zulCI1Twk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866857; c=relaxed/simple;
	bh=102Btpjeeo8VtiQ8egZBR6cU+DVWsDztY76TtRhxvck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l0Np1dgvXs2Si5DghYlkKCAV7OL2wQcmwxy9Wg6+xJx5JRajk1PtsgLkPtPZoGkbJ8GLkcSrhAxUFjciyuZT50WWSrbTu1ayYNOnVFkhJPVhcHVrwXon91sUSE2xHuuhk1qPI6OjD21y3dEkRora9zxzgAxNcESqBR8fJdfHS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <rafael@kernel.org>, <pavel@kernel.org>, <len.brown@intel.com>,
	<linux-pm@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PM: EM: use kfree_rcu to simplify the code
Date: Tue, 18 Feb 2025 16:20:21 +0800
Message-ID: <20250218082021.2766-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BC-Mail-EX08.internal.baidu.com (172.31.51.48) To
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-02-18 16:20:28:477
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-02-18 16:20:28:493
X-FEAS-Client-IP: 10.127.64.38
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The callback function of call_rcu() just calls kfree(), so use
kfree_rcu() instead of call_rcu() + callback function.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/power/energy_model.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3874f0e..72655ef 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -161,14 +161,6 @@ static void em_debug_create_pd(struct device *dev) {}
 static void em_debug_remove_pd(struct device *dev) {}
 #endif
 
-static void em_destroy_table_rcu(struct rcu_head *rp)
-{
-	struct em_perf_table __rcu *table;
-
-	table = container_of(rp, struct em_perf_table, rcu);
-	kfree(table);
-}
-
 static void em_release_table_kref(struct kref *kref)
 {
 	struct em_perf_table __rcu *table;
@@ -176,7 +168,7 @@ static void em_release_table_kref(struct kref *kref)
 	/* It was the last owner of this table so we can free */
 	table = container_of(kref, struct em_perf_table, kref);
 
-	call_rcu(&table->rcu, em_destroy_table_rcu);
+	kfree_rcu(table, rcu);
 }
 
 /**
-- 
2.9.4


