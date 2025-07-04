Return-Path: <linux-pm+bounces-30098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17BAF85E9
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 05:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7AF1C48539
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 03:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C9157A72;
	Fri,  4 Jul 2025 03:11:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12C4B5AE
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751598664; cv=none; b=oH1t3ngvl3zbhRb7lkoyFpTkc7SsO+VtXwJckepeBysNFgJmW/7FSNRdjox2FTPhLdQ5IEJK0TMmQ0T9CQgI5/w9NJiHSj8U9ylDjObjFWkQjY525OFxjK3iw/NHIzPWe6skBhIHUDeMmjeKAIX7pFx9h/eW+4nivmBx56h/uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751598664; c=relaxed/simple;
	bh=K30BTXU53SZZGNnGr/SkgXeIoTv3QpR/iRqx6QVW8x4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DW04gDSJaxtxhgCDgZD04ua9l04+3IWkQJA9a1FMm4QZCmjTWaFVRQbhtLpbdOLkKKz8RfahBl7B+D0yGDhfIleScaBx01xB5tLtTprijULCePzQMgyyL1Wgr8oCPtFvxiYtKEmey6HwqF5sU3dMW8JJBwTR76Ki8phnB5Yw0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 804647e6588411f0b29709d653e92f7d-20250704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:92dbfcae-bb57-494d-95f3-ddbfd744ba23,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:e03142c8c5cc306353aeb9ad4a2ed233,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 804647e6588411f0b29709d653e92f7d-20250704
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 419832793; Fri, 04 Jul 2025 11:10:55 +0800
From: Li Jun <lijun01@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	linux-pm@vger.kernel.org,
	lijun01@kylinos.cn
Subject: [PATCH v3] hibernate: init image_size depend on totalram_pages
Date: Fri,  4 Jul 2025 11:10:52 +0800
Message-Id: <20250704031052.1291545-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some automatically loaded applications greedily occupy
memory, when total memory is 8GB, the image_size is 3GB,
when total memory is 16GB, the image_size is 6GB, when
total memory is 32GB, the image_size is 12GB. some
of these applications,user may not use them. They occupy
a large amount of image space, resulting in S4 time of
over 100 seconds or even more. Limit the size of image_size
to control the time of hibernation and wake-up,making S4
more user-friendly.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/snapshot.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2af36cfe35cd..27ea4f398f22 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -135,10 +135,21 @@ void __init hibernate_reserved_size_init(void)
  * try to create the smallest image possible.
  */
 unsigned long image_size;
+#define MEM_8G			(8 * 1024 * 1024)//KB
+#define MEM_8G_PAGES	(MEM_8G / (PAGE_SIZE / 1024))
+#define MEM_16G_PAGES	(2 * MEM_8G_PAGES)
+#define MEM_32G_PAGES	(4 * MEM_8G_PAGES)
 
 void __init hibernate_image_size_init(void)
 {
-	image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+	if (totalram_pages() >= MEM_32G_PAGES)
+		image_size = ((totalram_pages() * 1) / 20) * PAGE_SIZE;
+	else if (totalram_pages() >= MEM_16G_PAGES)
+		image_size = ((totalram_pages() * 1) / 10) * PAGE_SIZE;
+	else if (totalram_pages() >= MEM_8G_PAGES)
+		image_size = ((totalram_pages() * 1) / 5) * PAGE_SIZE;
+	else
+		image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
 }
 
 /*
-- 
2.25.1


