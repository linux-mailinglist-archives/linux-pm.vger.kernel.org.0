Return-Path: <linux-pm+bounces-24721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DFAA78A46
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43436165537
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707622356BC;
	Wed,  2 Apr 2025 08:45:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359123313E
	for <linux-pm@vger.kernel.org>; Wed,  2 Apr 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583505; cv=none; b=eHMsedzwJjfly01qDQwg0hp/c46WD0EWI9EYmhqGhhEiKUVyXTo3+A9rk9TYyNc8dYOVotUwkTVcj8w3NcBFXSsunbDTlDUoniF4wFREpW9OmVGw5n/m/o6z2pMdWvcNSBLunWdblR2uYDm6YuefNaWBDaQ9zGprtuYwucpsbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583505; c=relaxed/simple;
	bh=nwtBRp2joDju3SN75mqUIC8GRzEch9WrDK0H/hEXQ2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vt9pR/PKGS06udRrUr4xnTKJ3McocvprklNU4njWCmzze4w8XPEFjVD5vX47Q/xys394t6C7Fv/rScir+Lwb0Q7PH/NQ1dLc3gi9fooc/LMDlYMLB7evkmber1xY6N2F5HqRUlYv0+oR2DloOz+6e7pJTa7fD+/OmMlu5kWCoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c0b5e3c40f9e11f0a216b1d71e6e1362-20250402
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_7B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:22410d5a-e305-4cb9-abfe-cf3596656845,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:22410d5a-e305-4cb9-abfe-cf3596656845,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:1cbbc91cc2095b29ac8d1df1304963aa,BulkI
	D:250402164458QLU9ROZU,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c0b5e3c40f9e11f0a216b1d71e6e1362-20250402
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 440909361; Wed, 02 Apr 2025 16:44:56 +0800
Message-ID: <32aa0d9b94c4f5ee92cb07cc95dcf21a61b41ad8.camel@kylinos.cn>
Subject: [PATCH v2] hibernate: pageoffline may be first judged
From: lijun <lijun01@kylinos.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, 
	lijun01@kylinos.cn
Date: Wed, 02 Apr 2025 16:44:53 +0800
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



