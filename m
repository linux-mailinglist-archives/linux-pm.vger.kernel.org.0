Return-Path: <linux-pm+bounces-21617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82C9A2E2B8
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 04:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956F73A6EAC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 03:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65BE3D3B3;
	Mon, 10 Feb 2025 03:24:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B935957
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739157874; cv=none; b=cB2d956PRFOtpsxMD5sL0ZbKqsMJQ5KYqjDtIq9gFXsbupgoM1wZCIq6WnCraffO8bjUGeRFyOkRXcA9DerjsNU185x93DUpr5KvK7Qb8Rnj3FN4x7P+ccGU9y/3sGydyTBTUyQzBgJ12WJAaKtqiEEEeyjSOLosL9tiypMLtOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739157874; c=relaxed/simple;
	bh=mWPSWLKxlttTg/XMMTJVdprDJ3TUJU0SJMZoiJ+v9fo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Y6ndOMi04hgKIvzgdGgMD0Y/uytRa6mGgLcU8isjnPRHzyJOTlDDRr8r3MXgUYDPqxAUcC9XRpEbaQTu2hvodFCCUrVPmaj436mfsXfdSzbPhnezAR+EV/uA1OLNaPNNf0p/5qhGwk/ZwH07Iui1C9YlsCeJdqSIqvQ9TUW+aKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 83471be2e75e11efa216b1d71e6e1362-20250210
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_LANG, HR_MAILER_MTBG, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1e144746-a4b7-4d7d-a702-55cdaad375dc,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:1e144746-a4b7-4d7d-a702-55cdaad375dc,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b23c24fdd144446587354997e98b20b6,BulkI
	D:250210111234II7EJX71,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 83471be2e75e11efa216b1d71e6e1362-20250210
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1523249833; Mon, 10 Feb 2025 11:24:18 +0800
Message-ID: <0a6d5426-da47-b206-4ed8-dd556b54d802@kylinos.cn>
Date: Mon, 10 Feb 2025 11:24:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: lijun <lijun01@kylinos.cn>
Subject: hibernate: pageoffline may be first judged
To: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
 linux-pm@vger.kernel.org
Content-Language: en-US
Cc: lijun01@kylinos.cn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

From: Li Jun <lijun01@kylinos.cn>
Date: Mon, 10 Feb 2025 10:40:58 +0800
Subject: [PATCH] hibernate: pageoffline may be first judged

PageReserved and PageOffline should be first judged.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
  kernel/power/snapshot.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c9fb559a6399..dfbccddb28f1 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1328,10 +1328,10 @@ static struct page *saveable_highmem_page(struct 
zone *zone, unsigned long pfn)

     BUG_ON(!PageHighMem(page));

-   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
+   if (PageReserved(page) || PageOffline(page))
         return NULL;

-   if (PageReserved(page) || PageOffline(page))
+   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
         return NULL;

     if (page_is_guard(page))
@@ -1387,9 +1387,6 @@ static struct page *saveable_page(struct zone 
*zone, unsigned long pfn)

     BUG_ON(PageHighMem(page));

-   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
-       return NULL;
-
     if (PageOffline(page))
         return NULL;

@@ -1397,6 +1394,9 @@ static struct page *saveable_page(struct zone 
*zone, unsigned long pfn)
         && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
         return NULL;

+   if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
+       return NULL;
+
     if (page_is_guard(page))
         return NULL;

-- 
2.34.1


