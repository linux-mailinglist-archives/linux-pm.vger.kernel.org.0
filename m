Return-Path: <linux-pm+bounces-27673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E876AC4619
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 04:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32781883E14
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 02:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F6145FE8;
	Tue, 27 May 2025 02:11:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9F2DCBF0
	for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748311904; cv=none; b=MvqfHKAv2TqgqYUhT4zPun4iFiFcBL7E6xVcF18Ved11rhmBekKRx6HMNpHbhVz5KebI8JMgSD4q+Jberghqzu39v0cAZv+UIpe43DdFkFdNKqkMSXAX9mhVlCTZkDVCYp5RcfVQW1HgBk/BpNFcKyiIFaUSXUUand1KMKW0Ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748311904; c=relaxed/simple;
	bh=pPkY3wTPgtFHNpMXLjKrHf31iUWlA6OJXCvOu03g1K4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEbazero4aOlb7reFDXxm96Aj2tNvZEBqGKBatO4p7B5G3yJKDFUokFvsReaSbbbxsmb/Ctcs2AQpWZY1+z0IUmAKP2w7m0Wmj9MixO38G5qB88lgFbX6rM7lUOrehcGIBUzh/itzx15YIqLEKYf1J8/739CzAEClz5xtQfumPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e9faace83a9f11f0b29709d653e92f7d-20250527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:322ac7ea-f6e9-47c7-9169-b7f16651112f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:322ac7ea-f6e9-47c7-9169-b7f16651112f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:7bf139965fd97f89e0fd01d5110d233c,BulkI
	D:250527101135X8LMC914,BulkQuantity:0,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e9faace83a9f11f0b29709d653e92f7d-20250527
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1081283879; Tue, 27 May 2025 10:11:34 +0800
Message-ID: <3766b8329169b5f39ff33a1893fe8d0ed92c1f6d.camel@kylinos.cn>
Subject: Re: [PATCH] hibernate: init minimum image size in hibernate
From: lijun <lijun01@kylinos.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Date: Tue, 27 May 2025 10:11:32 +0800
In-Reply-To: <CAJZ5v0iuxmo6=MxDBcy19AAH2D+cePsj3+sPtKb2UN58krX-pA@mail.gmail.com>
References: <0468b1df921c304755cf9c137bc8c44dc0082b44.camel@kylinos.cn>
	 <CAJZ5v0iuxmo6=MxDBcy19AAH2D+cePsj3+sPtKb2UN58krX-pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I conducted a test with 16GB of memory, the image_size = 2/5 *totalram_pages,
in hibernate_image_size_init,start timing form "echo disk > /sys/power/state"
to the desk display after resume, the time is 107 seconds.
the image_size = 0,in hibernate_image_size_init,the time is 63 seconds.
I opened a 50M file with vim ,display a movie and display a usb camera
in 4K, before hibernate. resume to the desk ,I didn't feel any delay in
response from these apps due to S4.

------------------------------
> On Thu, May 8, 2025 at 4:17 AM lijun <
> lijun01@kylinos.cn
> > wrote:
> > From c7240c0614f793e96ab6a18cc9b42e820360d979 Mon Sep 17 00:00:00 2001
> > From: Li jun <
> > lijun01@kylinos.cn
> > >
> > Date: Wed, 7 May 2025 17:58:22 +0800
> > Subject: [PATCH] hibernate: init minimum image size in hibernate
> > 
> > the image_size = 2/5 * totalram_pages,in hibernate_image_size_init
> > PM: Allocated 2908160 kbytes in 0.10 seconds
> > PM: Wrote 3000464 kbytes in 4.13 seconds
> > PM: Read 3000464 kbytes in 5.67 seconds
> > the image_size = 0,in hibernate_image_size_init,
> > PM: Allocated 817872 kbytes in 1.76 seconds,
> > PM: Wrote 908368 kbytes in 1.16 seconds,
> > PM: Read 908368 kbytes in 1.82 seconds,
> > 0.10 + 4.13 + 5.76 = 9.99
> > 1.76 + 1.16 + 1.82 = 4.74
> > Reduced time by 53%, the test is in 8G mem,if the mem is 16G or more,
> > this can reduce more time. the image_size =0, just shrink more
> > NR_SLAB_RECLAIMABLE, NR_ACTIVE_ANON, NR_INACTIVE_ANON, NR_ACTIVE_FILE,
> > NR_INACTIVE_FILE pages, S4 is still normal.
> > When the users use s4 first, they are unlikely to read document because
> > s4 take long time and then echo 0 > image_size, they may not use S4
> > anymore. but s4 is so great beacause it can save power and preserve
> > the working environment, especially for moblile devices.
> > So from the user's perspective, init image_size to 0 is more
> > user-friendly.
> 
> That's not as simple as it seems because your image write/read numbers
> above don't include the time needed to push user pages to swap and
> pull them in after hibernation and the rate at which they are swapped
> out and faulted in is way less than the image read/write speed.
> 
> What matters is the time it takes the system to get to the point when
> the user will be able to do work again after restoring its state from
> a hibernation image and if a lot of pages need to be faulted in, that
> may be much longer than the image reading time.
> 
> So reducing the default image size to 0 is not such a great idea after all.
> 
> > Signed-off-by: Li Jun <
> > lijun01@kylinos.cn
> > >
> > ---
> >  kernel/power/snapshot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 30894d8f0a78..4299a1e4205c 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -138,7 +138,7 @@ unsigned long image_size;
> > 
> >  void __init hibernate_image_size_init(void)
> >  {
> > -       image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> > +       image_size = 0;
> >  }
> > 
> >  /*
> > --
> > 2.25.1
> > 
> > 
> > 


