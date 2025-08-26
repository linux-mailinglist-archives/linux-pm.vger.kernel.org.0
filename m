Return-Path: <linux-pm+bounces-33105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0CBB35A61
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 12:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA271B215E1
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAF22405E1;
	Tue, 26 Aug 2025 10:47:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9230D32C8B
	for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205246; cv=none; b=Lg1i8OEdbFORRdhQWKWHZmxZmPvVNl80Pol7vR1vpsPir8VpNCEAj47jfC6F+M3Kstm5YJaLIctIJupuQB8sRSorPmXL4fDQUojgi0bEqQfSK4Aoe/eAgzvBUcHhL5ktmIpOKC4Z/5CcHB41SSsZQM4p487cXHF7TYJpMZ6FnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205246; c=relaxed/simple;
	bh=ksT4ZriV+2IJ2bEKpSmmHWDKOQOL08MRkP6UP8pN0JY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C8RFf8E9WCdMG4hflpXopqFoXZlutjE+WGUpXYnkRtgscKXpcHgKRsT3Pgu9PfE8gsVNwUcQnSkx6b0vck6g727nLNXGseqILyh0nUsIEQ2iu9iqn2w9PSwke0f8Tloc3mYhWF841EEM+CgeFf3Ri6aB1d/39VDsd/LPTXVK3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 04814e98826a11f0b29709d653e92f7d-20250826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ea8a388f-2451-4580-8a9a-d5e8c51de93c,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:7a89022271dec1ce84b5e24a3781cc87,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 04814e98826a11f0b29709d653e92f7d-20250826
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 398146729; Tue, 26 Aug 2025 18:47:10 +0800
From: Li Jun <lijun01@kylinos.cn>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	lijun01@kylinos.cn
Subject: [PATCH v4] hibernate: init image_size depend on totalram_pages
Date: Tue, 26 Aug 2025 18:46:50 +0800
Message-Id: <20250826104650.100200-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

  Some automatically loaded applications greedily occupy
memory, when total memory is 8GB, the image_size is 3GB,
when total memory is 16GB, the image_size is 6GB, when
total memory is 32GB, the image_size is 12GB. some
of these applications,user may not use them. They occupy
a large amount of image space, resulting in S4 time of
over 100 seconds or even more.
The experimental data is as follows:
TR11A2 loongarch 3A5000 Kylin-Desktop
image_size = 6723878912
1. hibernation 15S  wakeup 43S
2. hibernation 15S  wakeup 44S
3. hibernation 15S  wakeup 44S
image_size = 3361939456
1. hibernation 9S wakeup 38S
2. hibernation 8S wakeup 37S
3. hibernation 8S wakeup 38S
image_size = 0
1.hibernation 8S wakeup 34S
2.hibernation 6S wakeup 35S
3.hibernation 6S wakeup 34S

Record timestamp use tty and minicom.
hibernation time is from
[2025-06-03 13:51:30] [13235.652150][ 0]  PM: hibernation entry
to
[2025-06-03 13:51:36] [13241.599299][ 0]  PM: S|
wakeup time if from
[2025-06-03 13:52:20] Shut down slave cores done!
to
[2025-06-03 13:52:54] [13240.271609][ 3]  PM: hibernation exit

  When the current physical memory is 8G. the total number of RAM
pages is probably 7.7760GB,less than 8G a little，
the CNT_8GB >> 23 is 0,when the current physical memory is less
than 8G, the CNT_8GB is also 0,so the current image_size will be
initialized to 2/5 of the totalram_pages().
  When the current physical memory is 16G. the total number of RAM
pages is probably 15.7330GB,less than 16G a little，
the CNT_8GB >> 23 is 1,so the current image_size will be initialized
to 1/5 of the totalram_pages().
  When the current physical memory is 32G. the total number of RAM
pages must be greater probably 24GB, the CNT_8GB >> 23 is 000011,
so the current image_size will be initialized to 1/10 of the
totalram_pages().
  When the current physical memory is 64G. the total number of RAM
pages must be greater 56GB, the CNT_8GB >> 23 is 0000111,so the
current image_size will be initialized to 1/20 of the totalram_pages().
  When the current physical memory is 128G. the total number of RAM
pages may be greater 120GB, the CNT_8GB >> 23 is 0001111,so the
current image_size will be initialized to 1/40 of the totalram_pages().
  This way, when there are 16GB, 32GB or 64GB, the size of the
image size will be controlled to be slightly more than 3G.Just
shrink more NR_SLAB_RECLAIMABLE, NR_ACTIVE_ANON, NR_INACTIVE_ANON,
NR_ACTIVE_FILE, NR_INACTIVE_FILE pages,this may cause pages to be
flushed to swap during the "shrinking" of memory and restore will
spend some extra time,but this time compared to the additional
3GB or 9GB of image data from read-write compression and
decompression,this time is definitely less,may be this time is
consumed after hibernation exit or display screen is illuminated.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/snapshot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 501df0676a61..dad2e17b1a18 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -135,10 +135,13 @@ void __init hibernate_reserved_size_init(void)
  * try to create the smallest image possible.
  */
 unsigned long image_size;
+#define PAGE_SIZE_KB   (PAGE_SIZE >> 10)
 
 void __init hibernate_image_size_init(void)
 {
-	image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+	unsigned long CNT_8GB = (totalram_pages() * PAGE_SIZE_KB)>>23;
+
+	image_size = ((totalram_pages() * 2) / (5 * (CNT_8GB + 1))) * PAGE_SIZE;
 }
 
 /*
-- 
2.25.1


