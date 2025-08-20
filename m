Return-Path: <linux-pm+bounces-32666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AABB2D178
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 03:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EF61C26F36
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 01:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F33238C16;
	Wed, 20 Aug 2025 01:34:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CB21019C
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653641; cv=none; b=g0LJP9Zem65SJZxpVEu7gr2yxLGqcZz7DfZ8j02IDu7uHT2ePCftEe/4XmhYGEo29T/xwhoO1Eh4G1C79puqiFpzTmeNCUszoKRPABA9IYZcoQm5CUEvYWq0NlJ5HF4z3NHmi0ysTNX6QWEc/SGVVGBXiTHJAxea6NYdy4d370s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653641; c=relaxed/simple;
	bh=wHNcdWctv3AeISRebMAsEkvP9yl7XgY0c+2QHK7MRzA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=e6ro1y9gjbxJXqDErVSHg8Rk9FYYHZeaFst6+B42sEWivn41N+SQ+9fq9dsgKKPt53bGtc2wIpPSUclPWM5WhyhhQZo3il4diQdp2duAN4sH532kwN0vRXa1JxtrH7TVYOaSDZzd6j6CxYlHVQYyeEG8gFGrMca6XM4kVpdif+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b79a07b87d6511f0b29709d653e92f7d-20250820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a38d40f4-b484-4611-9fd6-f35679b2c6d2,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:76879da139d665bb98317a9ee1113b90,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b79a07b87d6511f0b29709d653e92f7d-20250820
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1646894924; Wed, 20 Aug 2025 09:33:47 +0800
From: Li Jun <lijun01@kylinos.cn>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	lijun01@kylinos.cn
Subject: [PATCH v3] hibernate: init image_size depend on totalram_pages
Date: Wed, 20 Aug 2025 09:33:43 +0800
Message-Id: <20250820013343.1683850-1-lijun01@kylinos.cn>
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
over 100 seconds or even more.When the users use s4 first,
they feel the awakening time is so long,they may not use S4
anymore. but s4 is so great beacause it can save power and
preserve the working environment, especially for moblile
devices.so limit the size of image_size to control the time
of hibernation and wake-up,making more users love S4.
  First obtain the number of pages in 8GB of memory,
MEM_8G_PAGES,and then use 16GB and 32GB based on 8GB.
  When the number of totalram_pages() is greater than MEM_8G_PAGES,
the current physical memory will definitely be greater than 8G.
if it is 16GB, the current image_size will be initialized to 1/5
of the totalram_pages().
  When the number of totalram_pages() is greater than MEM_16G_PAGES,
the current physical memory will definitely be greater than 16GB.
if it is 32GB, the current image_size will be initialized to 1/10
of the totalram_pages().
   When the number of totalram_pages() is greater than MEM_32G_PAGES,
the current physical memory will definitely be greater than 32GB,
if it is 64GB, the currentimage_size will be initialized to 1/20
of the totalram_mages().
   This way, when there are 16GB, 32GB or 64GB, the size of the
image size will be controlled to be slightly more than 3G.Just
shrink more NR_SLAB_RECLAIMABLE, NR_ACTIVE_ANON, NR_INACTIVE_ANON,
NR_ACTIVE_FILE, NR_INACTIVE_FILE pages, S4 is still normal.

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


