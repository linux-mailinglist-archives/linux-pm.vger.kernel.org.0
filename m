Return-Path: <linux-pm+bounces-24719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0407A78A2B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7261701CC
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B79234970;
	Wed,  2 Apr 2025 08:38:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7423373E
	for <linux-pm@vger.kernel.org>; Wed,  2 Apr 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583103; cv=none; b=EdNYfAUpEUzofqXBfIOFKKgmzsaVjg+0MoYht6L9zF4o/TOHQTwGVah3uw4jeNxhEy1zvPgnC4gbLfzpMV+y27fe4BIQyEODoIHe7vqP47gegxQqiDieizzVcGRHcKlD5arcBS9d3s5yGvi/sytmDvj3MGixU4INOFYp5vTR3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583103; c=relaxed/simple;
	bh=qtSuzhmVhvRzbOw8VTijwTnqmQZH6Jd9PsnwtVnEqvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ay1YhmjCa1eSa3P9LlB4sk3/dP4ZLIhDbuULrpTAb8lq5cyA3GqyH8oF3jgr0hSTYTLU7Xud1iUMqTi6vOBeI7e0LyXVrqSzKoOCKY4YudFN7hQ3/jMecmZ9NzMcm93kfCJELvOzSFoceRdjYXO9SWpfN1i1TsYyfX+eNgdz4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d0135bea0f9d11f0a216b1d71e6e1362-20250402
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM
	HR_CTE_7B, HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_CHARSET, HR_SJ_HAN, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d33f0e34-c67f-4167-9701-556ddbd000f7,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:18
X-CID-INFO: VERSION:1.1.45,REQID:d33f0e34-c67f-4167-9701-556ddbd000f7,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
	release,TS:18
X-CID-META: VersionHash:6493067,CLOUDID:dbda879dfcd18b76f2aab31aba0329b7,BulkI
	D:250402163813WE61A1GL,BulkQuantity:0,Recheck:0,SF:16|19|24|44|66|78|81|82
	|83|102,TC:nil,Content:0|52,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: d0135bea0f9d11f0a216b1d71e6e1362-20250402
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 558978828; Wed, 02 Apr 2025 16:38:12 +0800
Message-ID: <08ec8325a38106cebd68431519c9fbf418431d7e.camel@kylinos.cn>
Subject: =?gb2312?Q?=BB=D8=B8=B4=A3=BA=5BPATCH=5D?= hibernate: pageoffline
 may be first judged
From: lijun <lijun01@kylinos.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, 
	lijun01@kylinos.cn
Date: Wed, 02 Apr 2025 16:36:28 +0800
In-Reply-To: <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com>
References: <5aac0c93-2723-2ca1-cbfa-98f88b0c900c@kylinos.cn>
	 <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From e5b2d7aa9b66cac66314165fee12999f432b29d8 Mon Sep 17 00:00:00 2001
From: Li Jun <lijun01@kylinos.cn>
Date: Mon, 10 Feb 2025 10:40:58 +0800
Subject: [PATCH v2] hibernate: pageoffline may be first judged

'PageReserved' and 'PageOffline' have weights greater
than 'is_forbidden' and 'is_free'.so,PageReserved
and PageOffline should be first judged.
just as the page is free,but is reserved.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/snapshot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c9fb559a6399..dfbccddb28f1 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1328,10 +1328,10 @@ static struct page
*saveable_highmem_page(struct zone *zone, unsigned long pfn)
 
    BUG_ON(!PageHighMem(page));
 
-   if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page))
+   if (PageReserved(page) || PageOffline(page))
        return NULL;
 
-   if (PageReserved(page) || PageOffline(page))
+   if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page))
        return NULL;
 
    if (page_is_guard(page))
@@ -1387,9 +1387,6 @@ static struct page *saveable_page(struct zone
*zone, unsigned long pfn)
 
    BUG_ON(PageHighMem(page));
 
-   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
-       return NULL;
-
    if (PageOffline(page))
        return NULL;
 
@@ -1397,6 +1394,9 @@ static struct page *saveable_page(struct zone
*zone, unsigned long pfn)
        && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
        return NULL;
 
+   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
+       return NULL;
+                                                                      
                                                                       
                                                                       
                         
    if (page_is_guard(page))
        return NULL;
 
-- 
2.34.1


