Return-Path: <linux-pm+bounces-27720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F1AC6310
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F7E3A43A5
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA531FDE01;
	Wed, 28 May 2025 07:33:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D201367
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417586; cv=none; b=GiDs8j5anFB6ZcBxLLpCXrJC9xUBocxqfSbaJ+pi43TY1L+OVF4UHW1XCHys6+1E2gUQ3qiT25TIx7ysKOwgMOyl2L1CDCURWJif4opBtl6tEHKwH7KfB5MdrEQCFMR5MF5AgksxVMmxJpm2o8lcSWBvQb+Pmn1QuAIRB0WF3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417586; c=relaxed/simple;
	bh=fs7V2EMais1uvsQsiiv8UFl+UXbpQ8gTK8jxn0sDoiQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=o/3WovMVlPwcOXKXqUugdxQotd7/afmsjgWb5X9VqaZQj8tdJY4PCDJ4UHMGc08akcdbgpdrYQsuCufbr8MMDVkFU1s7VGidTmO19EOZk/svE+KaicBk96xXOrbzsN4y1BkcTqBl0+JqmXaA2731XP74hBGV/lnCX+KnDa6yN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f96941c03b9511f0b29709d653e92f7d-20250528
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_7B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2eb0e39e-344f-40a3-b65c-8a86e03b0f1c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:2eb0e39e-344f-40a3-b65c-8a86e03b0f1c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:f575bee11e2aee58bdc56fcac521d48c,BulkI
	D:250528151521F34SETM6,BulkQuantity:5,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: f96941c03b9511f0b29709d653e92f7d-20250528
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1727375738; Wed, 28 May 2025 15:32:56 +0800
Message-ID: <f63c67bee0e0ae498236cff4374feae2a624d410.camel@kylinos.cn>
Subject: [PATCH v2] hiberbate: init image_size depend on totalram_pages
From: lijun <lijun01@kylinos.cn>
To: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Cc: lijun01@kylinos.cn
Date: Wed, 28 May 2025 15:32:34 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From cd88cf1ef77c48a85dd54eea696f8936553bd757 Mon Sep 17 00:00:00 2001
From: Li Jun <lijun01@kylinos.cn>
Date: Mon, 12 May 2025 10:39:27 +0800
Subject: [PATCH v2] hiberbate: init image_size depend on totalram_pages

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
 kernel/power/snapshot.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2af36cfe35cd..197976d75879 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -135,10 +135,20 @@ void __init hibernate_reserved_size_init(void)
  * try to create the smallest image possible.
  */  
 unsigned long image_size;
-
+#define MEM_8G 8388608 // KB
+#define MEM_8G_PAGES   MEM_8G / PAGE_SIZE
+#define MEM_16G_PAGES  MEM_8G_PAGES * 2
+#define MEM_32G_PAGES  MEM_8G_PAGES * 4
 void __init hibernate_image_size_init(void)
 {
-   image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+   if (totalram_pages() >= MEM_32G_PAGES)
+       image_size = ((totalram_pages() * 1) / 20) * PAGE_SIZE;
+   else if (totalram_pages() >= MEM_16G_PAGES)
+       image_size = ((totalram_pages() * 1) / 10) * PAGE_SIZE;
+   else if (totalram_pages() >= MEM_8G_PAGES)
+       image_size = ((totalram_pages() * 1) / 5) * PAGE_SIZE;
+   else
+       image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
 }
 
 /*
-- 
2.25.1
   


