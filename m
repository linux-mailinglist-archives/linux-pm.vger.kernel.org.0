Return-Path: <linux-pm+bounces-32621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3BB2BF2D
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6AE1BC453F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF0322A38;
	Tue, 19 Aug 2025 10:40:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB827A44A
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600048; cv=none; b=qEgqHNMu9LMWwtpDI0QhDL/0oNMBqwkXHXpFq3i1p00vo5dY3zDPPdkwba/8i5EaMiE57mSF44hwxCXdkwecgYZPKZjAYPjrdHiWyCEQ377eav/R1WgpMOy58vT14/AtxBEGbXjLc9x86+dLHXE6j/zD8zTn9q/qkgrSTIJQ/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600048; c=relaxed/simple;
	bh=iBVJKwC8x06fAWvB/4YcQy04qw+WBogtsLchFZtJXRA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QL6MF8jStCzGjR4jvTnVhgql2KuEEmfmNmGNFtcbVp04DHuIumP6hVd87tq/v9heNOPaBdFjtGmsxOR84V8UN7q5Iad8GgsUf+KGszzPUEJTifNgepqTSsHLsjMEjXVVI+JJKkiBsnbkAvMQUPnj0yu+cNipqI7/P+qp/agEXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f45d09027ce811f0b29709d653e92f7d-20250819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9cef7b59-c786-4575-8598-7bf1c7741a0c,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:8a3a32ef4db83327b379ab111ff2dce3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f45d09027ce811f0b29709d653e92f7d-20250819
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1936804193; Tue, 19 Aug 2025 18:40:42 +0800
From: Li Jun <lijun01@kylinos.cn>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	lijun01@kylinos.cn
Subject: [PATCH] power: snapshot: fix: correct 'leave' to 'leaf' in memory bitmap docs
Date: Tue, 19 Aug 2025 18:40:38 +0800
Message-Id: <20250819104038.1596952-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes just fix spell error, no functional
improve.

-The term "leaf nodes" is the correct spelling.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 9b11c74592e9..6a216f3f7d8e 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -374,7 +374,7 @@ static void *chain_alloc(struct chain_allocator *ca, unsigned int size)
  *
  * One radix tree is represented by one struct mem_zone_bm_rtree. There are
  * two linked lists for the nodes of the tree, one for the inner nodes and
- * one for the leave nodes. The linked leave nodes are used for fast linear
+ * one for the leaf nodes. The linked leaf nodes are used for fast linear
  * access of the memory bitmap.
  *
  * The struct rtree_node represents one node of the radix tree.
-- 
2.25.1


