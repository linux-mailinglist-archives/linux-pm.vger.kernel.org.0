Return-Path: <linux-pm+bounces-27036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E1AB2F0C
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 07:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6203AD478
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5221A3BD8;
	Mon, 12 May 2025 05:33:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1854758
	for <linux-pm@vger.kernel.org>; Mon, 12 May 2025 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747028005; cv=none; b=AI0V0gKs9ao1th69PFBzSpdX6jb5Nl6BQaBGzO2a2mqLmBCoI/MSeBr9qgk2ouChwY4JFMLpTxHEPHww3OzscJ9brHFLqXfmYrlYCsewBYif055HKPaIBf517dyflZ7uKBjogRHXUXu/WdAjNuea+R8aSgRJulQ02gtjFpU+CjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747028005; c=relaxed/simple;
	bh=9Huq3alpPn5QRTywrEfFaFpO9a0WXea5iq6slW6yLUg=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=iBYjD7CjEFvpgEpeHpZHDOBYG187a7LIQlLsM5VlcOivWTJDJFvtaGSHrZQw1q+NC/t/s8pHavgoU0Xcpad8p6M7y6hbHRRxA8xkg0/m06JSTIX4UU6A3zjo8tXNIMlWIsGpH0CjWNLI0PzC/5LZECuOQTuoiKMEFDIX13CAMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9451e08a2ef211f0b29709d653e92f7d-20250512
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_7B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b8f8601a-7459-4ec2-bd71-fe52fcdea5ee,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:b8f8601a-7459-4ec2-bd71-fe52fcdea5ee,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:66471f44e707eafd3be9d88089e0b5c8,BulkI
	D:250512132758NJPJR82I,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 9451e08a2ef211f0b29709d653e92f7d-20250512
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2131273282; Mon, 12 May 2025 13:33:05 +0800
Message-ID: <69bbdab1c8b6518ebd8c63d194a05b3b4d69f7ed.camel@kylinos.cn>
Subject: [PATCH] hiberbate: init image_size depend on totalram_pages
From: lijun <lijun01@kylinos.cn>
To: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Cc: lijun01@kylinos.cn
Date: Mon, 12 May 2025 13:33:01 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From 64fa0c94aae28a4fe7563a18b0b41e6c40fb4529 Mon Sep 17 00:00:00 2001
From: Li Jun <lijun01@kylinos.cn>
Date: Mon, 12 May 2025 10:39:27 +0800
Subject: [PATCH] hiberbate: init image_size depend on totalram_pages

Some automatically loaded applications greedily occupy
memory, when total memory is 8GB, the image_size is 3GB,
when total memory is 16GB, the image_size is 6GB, when
total memory is 32GB, the image_size is 12GB, and some
of these applications,user may not use them, which is
not conducive to s4.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/snapshot.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2af36cfe35cd..5dedc459176c 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -135,10 +135,20 @@ void __init hibernate_reserved_size_init(void)
  * try to create the smallest image possible.
  */
 unsigned long image_size;
-
+#define 8G_MEM 8388608 // KB
+#define 8G_MEM_PAGES   8G_MEM / PAGE_SIZE
+#define 16G_MEM_PAGES  8G_MEM_PAGES * 2
+#define 32G_MEM_PAGES  8G_MEM_PAGES * 4
 void __init hibernate_image_size_init(void)
 {
-	image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+	if (totalram_pages() >= 32G_MEM_PAGES)
+		image_size = ((totalram_pages() * 1) / 20) * PAGE_SIZE;
+	else if (totalram_pages() >= 16G_MEM_PAGES)
+		image_size = ((totalram_pages() * 1) / 10) * PAGE_SIZE;
+	else if (totalram_pages() >= 8G_MEM_PAGES)
+		image_size = ((totalram_pages() * 1) / 5) * PAGE_SIZE;
+	else
+		image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
 }
 
 /*
-- 
2.25.1



