Return-Path: <linux-pm+bounces-24736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3361AA799DD
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 04:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D151890831
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDF777104;
	Thu,  3 Apr 2025 02:03:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256876F31E
	for <linux-pm@vger.kernel.org>; Thu,  3 Apr 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743645837; cv=none; b=SU9yjtqqMTfMYtsrNl4eB9DM4bzExzTL4WpxOnYct3mwTF3mojBSKOf1k4W0qKo/y1rBdjdsGcVljSrNAU+Zl12kRKSMmw1vGB+GAvwXNjGnj1+fStfoYt3+0VPqWrhfJs8Ei1fFt1azDLMbaoRm0lppjUlyPyJTHG34df/VKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743645837; c=relaxed/simple;
	bh=ub07IwzVZSOOHR3k3VZpcYa+SGk7iEbL6wpLB853U0k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7HhpkHAV5N3G5Y6HIV3IWASae5Ci3kt5MLHZ4FH5A8TDQ+HixuwYFeJSUjqSzwJ6pnKCEcfA8/OFrFkbw7vGN/XJa4H+hDgL8qfV7bn9eEJICeRCC+qx25PvSVObhyjidq4JigfGIX0vrnQwaKC4mkzGLFJZi20Mx1ccjRZ74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dc5dce20102f11f0a216b1d71e6e1362-20250403
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6207a43b-dec1-4e44-9720-e243fd8dfff3,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.1.45,REQID:6207a43b-dec1-4e44-9720-e243fd8dfff3,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:6493067,CLOUDID:e1804c5d401b3972a6dbdab34522c6f2,BulkI
	D:2504031003419SSOZW4E,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: dc5dce20102f11f0a216b1d71e6e1362-20250403
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 889566836; Thu, 03 Apr 2025 10:03:39 +0800
Message-ID: <a55a3417634ae3ab546121d77af083cbf4fcdc3f.camel@kylinos.cn>
Subject: [PATCH v3] hibernate: pageoffline may be first judged
From: lijun <lijun01@kylinos.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Date: Thu, 03 Apr 2025 10:03:36 +0800
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
Subject: [PATCH v3] hibernate: pageoffline may be first judged

'PageReserved' and 'PageOffline' have weights greater
than 'is_forbidden' and 'is_free'.so,PageReserved
and PageOffline should be first judged.
just as the page is free,but is reserved.

the ordering of checks in 'for_each_populated_zone(zone)'
It means that hundreds of thousands or even millions of
pages need to be judged, reducing the judgment of one
statement may save some time.

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



