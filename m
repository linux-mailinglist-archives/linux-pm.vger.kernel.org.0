Return-Path: <linux-pm+bounces-24867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A45A7D1E2
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 04:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639743ABE43
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 02:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37B20FAAC;
	Mon,  7 Apr 2025 02:04:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF629A5
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991447; cv=none; b=fhoTDa6t2oEd1fbEJB14G1iX5kD52swYxJQ8UNwSig4E4Vpr/ttAlVLFypX5y8eIhh+zOnIpW8lw1FnLj58Vyn88R496dhgllQoTszFf8ac9QQFO/2DiAF7IYYGgsS9FzTKSL1OLzF4Kthbec6oSRW5M36E3LKPTPfZdQlQz9Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991447; c=relaxed/simple;
	bh=e4PPSIiDWVvnlfAiBt4X3u5AR4kYdFUUquE3AFRX9y0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i8Me2SJfiRp6xoN2xsZYruW8R73IDvoq2E/Vym5U6eW+Q7HDxgSlrhWc7HBN0eEGZ5giMxX6wUKpPUoPKf/bokg2Z9BxBwQeWmzeXLHGi6ZiNqkbmWAieAUVxjI/coB3hwLZoFhb1lCwDHMhVHoZXaw8X9ZdirfAj+WEtuRUabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c6e917e135411f0a216b1d71e6e1362-20250407
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b01e8074-50ce-4216-89f1-556b4ff5b4c5,IP:10,
	URL:0,TC:0,Content:6,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:13
X-CID-INFO: VERSION:1.1.45,REQID:b01e8074-50ce-4216-89f1-556b4ff5b4c5,IP:10,UR
	L:0,TC:0,Content:6,EDM:0,RT:0,SF:-3,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:13
X-CID-META: VersionHash:6493067,CLOUDID:04f2cc315d588f95dbda1cb3b838949b,BulkI
	D:250407100352BHNPW0GQ,BulkQuantity:0,Recheck:0,SF:19|24|45|64|66|72|78|80
	|81|82|83|102|841,TC:nil,Content:4|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 8c6e917e135411f0a216b1d71e6e1362-20250407
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2084065488; Mon, 07 Apr 2025 10:03:50 +0800
Message-ID: <138b6de424cd6b60fe0cfc0a3b7a3c5cd189a79f.camel@kylinos.cn>
Subject: =?gb2312?Q?reply-to=A3=BA=5BPATCH?= v3] hibernate: pageoffline may
 be first judged
From: lijun <lijun01@kylinos.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Date: Mon, 07 Apr 2025 10:03:37 +0800
In-Reply-To: <CAJZ5v0how8gMN_mhqosNH4kB9uki2drA8RpdCPJVQVp+Kh70Bg@mail.gmail.com>
References: <5aac0c93-2723-2ca1-cbfa-98f88b0c900c@kylinos.cn>
	 <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com>
	 <a55a3417634ae3ab546121d77af083cbf4fcdc3f.camel@kylinos.cn>
	 <CAJZ5v0how8gMN_mhqosNH4kB9uki2drA8RpdCPJVQVp+Kh70Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yes, that is what i want to say.  I would like to seek your advice，
is it still possible that the page is not forbideen page and is
not free, but the page is  reserved or offline?.




> On Thu, Apr 3, 2025 at 4:03 AM lijun <
> lijun01@kylinos.cn
> > wrote:
> > From: Li Jun <
> > lijun01@kylinos.cn
> > >
> > 
> > 
> > 
> > Date: Mon, 10 Feb 2025 10:40:58 +0800
> > Subject: [PATCH v3] hibernate: pageoffline may be first judged
> > 
> > 'PageReserved' and 'PageOffline' have weights greater
> > than 'is_forbidden' and 'is_free'.so,PageReserved
> > and PageOffline should be first judged.
> > just as the page is free,but is reserved.
> > 
> > the ordering of checks in 'for_each_populated_zone(zone)'
> > It means that hundreds of thousands or even millions of
> > pages need to be judged, reducing the judgment of one
> > statement may save some time.
> 
> So this is regarded as a possible optimization.
> 
> My understanding of it is as follows:
> 
> Since PageReserved(page) and PageOffline(page) are simpler than the
> other checks in saveable_highmem_page(), checking them first is
> likely
> to reduce overhead somewhat, or at least it would not make a
> measurable difference.
> 
> Is this what you wanted to say?
> 
> > Signed-off-by: Li Jun <
> > lijun01@kylinos.cn
> > >
> > ---
> >  kernel/power/snapshot.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index c9fb559a6399..dfbccddb28f1 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -1328,10 +1328,10 @@ static struct page
> > *saveable_highmem_page(struct zone *zone, unsigned long pfn)
> > 
> >     BUG_ON(!PageHighMem(page));
> > 
> > -   if (swsusp_page_is_forbidden(page)
> > ||  swsusp_page_is_free(page))
> > +   if (PageReserved(page) || PageOffline(page))
> >         return NULL;
> > 
> > -   if (PageReserved(page) || PageOffline(page))
> > +   if (swsusp_page_is_forbidden(page)
> > ||  swsusp_page_is_free(page))
> >         return NULL;
> > 
> >     if (page_is_guard(page))
> > @@ -1387,9 +1387,6 @@ static struct page *saveable_page(struct zone
> > *zone, unsigned long pfn)
> > 
> >     BUG_ON(PageHighMem(page));
> > 
> > -   if (swsusp_page_is_forbidden(page) ||
> > swsusp_page_is_free(page))
> > -       return NULL;
> > -
> >     if (PageOffline(page))
> >         return NULL;
> > 
> > @@ -1397,6 +1394,9 @@ static struct page *saveable_page(struct zone
> > *zone, unsigned long pfn)
> >         && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
> >         return NULL;
> > 
> > +   if (swsusp_page_is_forbidden(page) ||
> > swsusp_page_is_free(page))
> > +       return NULL;
> > +
> >     if (page_is_guard(page))
> >         return NULL;
> > 
> > --
> > 2.34.1
> > 
> > 


