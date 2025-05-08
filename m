Return-Path: <linux-pm+bounces-26860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3957FAAF113
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 04:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46EC5004AF
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5F7261E;
	Thu,  8 May 2025 02:17:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375814207F
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670652; cv=none; b=gzMTcgw5m+CCktkTWtbMXppe4b668zDmPKDARvSOTvwnheN82xCCLiWC/oKuin6YKkNYY+9EKS8twoE4+jWAnNUzozCld0460nh1OCZHhoyKV6RauGGcwYRVjRAsGu3BSa2SbRzdrt5u0OZccea5yA1xvyoYKUS5JgPUH0LZlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670652; c=relaxed/simple;
	bh=MMJPHYrUge7nlNmJe+jC6dASGmtWRmF7wFEy3nnoRt4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=iygVOMuuzn/kNRoMgqtgtaoKSAvpYTKkuOFRMcYkBZM0Cqdh9HIIwyCgVO8earN9Pa7MF0dpLkZOwiOiww23LmY+TW7ZdbrWimo/aMVHgRKpEKaGg51UAHvJjLL3fQEUSv2P6X9nMrpN3iecqh/1yBLbvqFTqVOMifQ6aHk1X7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8dec1fc82bb211f0b29709d653e92f7d-20250508
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_7B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, OB_FP, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2f84c593-1b3e-411e-9c70-699b9cfdf32f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:2f84c593-1b3e-411e-9c70-699b9cfdf32f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:fde39593ec97bc9403edca0f13de260b,BulkI
	D:250508101528X9F4XQKM,BulkQuantity:2,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 8dec1fc82bb211f0b29709d653e92f7d-20250508
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2132356260; Thu, 08 May 2025 10:17:13 +0800
Message-ID: <0468b1df921c304755cf9c137bc8c44dc0082b44.camel@kylinos.cn>
Subject: [PATCH] hibernate: init minimum image size in hibernate
From: lijun <lijun01@kylinos.cn>
To: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Cc: lijun01@kylinos.cn
Date: Thu, 08 May 2025 10:16:58 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From c7240c0614f793e96ab6a18cc9b42e820360d979 Mon Sep 17 00:00:00 2001
From: Li jun <lijun01@kylinos.cn>
Date: Wed, 7 May 2025 17:58:22 +0800
Subject: [PATCH] hibernate: init minimum image size in hibernate

the image_size = 2/5 * totalram_pages,in hibernate_image_size_init
PM: Allocated 2908160 kbytes in 0.10 seconds
PM: Wrote 3000464 kbytes in 4.13 seconds
PM: Read 3000464 kbytes in 5.67 seconds
the image_size = 0,in hibernate_image_size_init,
PM: Allocated 817872 kbytes in 1.76 seconds,
PM: Wrote 908368 kbytes in 1.16 seconds,
PM: Read 908368 kbytes in 1.82 seconds,
0.10 + 4.13 + 5.76 = 9.99
1.76 + 1.16 + 1.82 = 4.74
Reduced time by 53%, the test is in 8G mem,if the mem is 16G or more,
this can reduce more time. the image_size =0, just shrink more
NR_SLAB_RECLAIMABLE, NR_ACTIVE_ANON, NR_INACTIVE_ANON, NR_ACTIVE_FILE,
NR_INACTIVE_FILE pages, S4 is still normal.
When the users use s4 first, they are unlikely to read document because
s4 take long time and then echo 0 > image_size, they may not use S4
anymore. but s4 is so great beacause it can save power and preserve
the working environment, especially for moblile devices.
So from the user's perspective, init image_size to 0 is more
user-friendly.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 30894d8f0a78..4299a1e4205c 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -138,7 +138,7 @@ unsigned long image_size;
 
 void __init hibernate_image_size_init(void)
 {
-	image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+	image_size = 0;
 }
 
 /*
-- 
2.25.1




