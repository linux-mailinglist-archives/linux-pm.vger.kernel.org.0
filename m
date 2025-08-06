Return-Path: <linux-pm+bounces-31980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9729B1BEA5
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 04:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3843A3307
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 02:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44195192D8A;
	Wed,  6 Aug 2025 02:11:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D71805A
	for <linux-pm@vger.kernel.org>; Wed,  6 Aug 2025 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754446314; cv=none; b=ELX9BcAhF4jM4zPvx2Jx53YHJ/Wh8JNafM36oS6SzK5ISiERDrCifk7hYXcZVLvVUAjr4FEBi35+PNKy/8Ztg0Ll020P2KZilyEgt4xfiWNQJjjBSrEMLGDu7cd3zCmpDhSKcD/UlAExGnKw/825I33p058toNFveW3hwJYiOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754446314; c=relaxed/simple;
	bh=bYNr7ctTHzPYtXyY1hAaFAQ8K/4NyFGcYB6FtjF3+eI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nrWO/VTfAoL6BMBNG6QF7p7h8rGk20FrmVd9kPPoLLo5A7uOvDucWsPB+ioEKVezf9YrDWINGEWHK7Li5JSqKfHsgPpzH9fuIfg5DHw4B8kCQ/7gOqrbZ7HJP4Vtx1IWBM5MUVOQhas52/zBErN++m4gcHsibB68J++QdEObipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ffb7d7a2726911f0b29709d653e92f7d-20250806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9adc468c-1db1-4a82-838b-1d4cb2aadc7b,IP:0,U
	RL:0,TC:0,Content:24,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:49
X-CID-META: VersionHash:6493067,CLOUDID:5691a6e09359feff8a44437551bc1e41,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ffb7d7a2726911f0b29709d653e92f7d-20250806
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 670839292; Wed, 06 Aug 2025 10:06:43 +0800
From: Li Jun <lijun01@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	linux-pm@vger.kernel.org,
	lijun01@kylinos.cn
Subject: [PATCH v3] hibernate: init image_size depend on totalram_pages
Date: Wed,  6 Aug 2025 10:06:39 +0800
Message-Id: <20250806020639.315687-1-lijun01@kylinos.cn>
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
  First obtain the number of pages in 8GB of memory,
MEM_8G_PAGES,and then use 16GB and 32GB based on 8GB.
  When the number of memory pages is greater than MEM_8G_PAGES,
the current physical memory will definitely be greater than 8G.
if it is 16GB, the current image_size will be initialized to 1/5
of the totalram_mages().
  When the number of memory pages is greater than MEM_16G_PAGES,
the current physical memory will definitely be greater than 16GB.
if it is 32GB, the current image_size will be initialized to 1/10
of the totalram_mages().
   When the number of memory pages is greater than MEM_32G_PAGES,
the current physical memory will definitely be greater than 32GB,
if it is 64GB, the currentimage_size will be initialized to 1/20
of the totalram_mages().
   This way, when there are 16GB, 32GB or 64GB, the size of the
image size will be controlled to be slightly more than 3G.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/snapshot.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 501df0676a61..9b11c74592e9 100644
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


