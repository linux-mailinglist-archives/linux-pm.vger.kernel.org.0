Return-Path: <linux-pm+bounces-31471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15785B1389D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 12:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323161700F7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C122A7E0;
	Mon, 28 Jul 2025 10:10:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC892E36E2
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697434; cv=none; b=lOb87QhnLQvZ0k6/ql56gQiYnUdT5Usmx+pZKQWHBm4m2+jFCY2AR3bLaE8GpJFXU3vY5WVcWHGLTauqYUamzB4gPYAhJzNyp96FRoKRqYdHRdW6JmYRS4PiHoPCKVdCpE4EOwMP2pELZRr47AQwojSump6uF7r8Jqxz8O/3+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697434; c=relaxed/simple;
	bh=v2/CN8TF3Pyc17s2PvKxHbCCSObkGecVd+EjWotYymc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AQp63grvO5uqCl+mJC8k1DNUV5YjBaikN6fY+gtuusLUTh8jnLsvlBV8mJzJZJ6KkHKRa06Y7GKNiOJ5zjej9dcw38zV7ZoZFSUkytjPYCXHx6IxGUufSsXW81UaOoW8z7jueuYMwDNt4c1msU4CvHm7EbpzkfDyGBzjP3mnQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 112ad7da6b9b11f0b29709d653e92f7d-20250728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:dafa57f8-bb25-4f90-b9b5-07e389e68366,IP:0,U
	RL:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:6493067,CLOUDID:5503dde7954d22b086e0c77d380a5201,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 112ad7da6b9b11f0b29709d653e92f7d-20250728
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 688030236; Mon, 28 Jul 2025 18:10:20 +0800
Message-ID: <0d1bb2ad63e47e8cc4dcc178d9661f35bb6e30bb.camel@kylinos.cn>
Subject: =?gb2312?Q?Re=A3=BA=5BPATCH?= v2] hiberbate: init image_size depend
 on totalram_pages
From: lijun <lijun01@kylinos.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	lijun01@kylinos.cn
Date: Mon, 28 Jul 2025 18:10:10 +0800
In-Reply-To: <CAJZ5v0grKkaPpCCCx+jHy4gDL0qN6pDmeyRkhP2=7A9gA3USuQ@mail.gmail.com>
References: <f63c67bee0e0ae498236cff4374feae2a624d410.camel@kylinos.cn>
	 <CAJZ5v0grKkaPpCCCx+jHy4gDL0qN6pDmeyRkhP2=7A9gA3USuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

   I am very sorry for the mistake I made in version v2. I have made
the necessary
modifications and have already sent version v3. 
   I will first obtain the number of pages in 8GB of memory,
MEM_8G_PAGES,and
then use 16GB and 32GB based on 8GB.
When the number of memory pages is greater than MEM_8G_PAGES, 
the current physical memory will definitely be greater than 8G.
If it is 16GB, the current image_size will be initialized to 1/5 of the
totalram_mages(). 
When the number of memory pages is greater than MEM_16G_PAGES, the
current physical memory
will definitely be greater than 16GB. If it is 32GB, the current
image_size will be initialized
 to 1/10 of the totalram_mages().When the number of memory pages is
greater than MEM_32G_PAGES, 
the current physical memory will definitely be greater than 32GB, If it
is 64GB, the currentimage_size
will be initialized to 1/20 of the totalram_mages().
This way, when there are  16GB ,32GB or 64GB, the size of the image
size will be controlled to
be slightly more than 3G.

-----------------------------------------
On Wed, May 28, 2025 at 9:33 AM lijun wrote:
>
> From cd88cf1ef77c48a85dd54eea696f8936553bd757 Mon Sep 17 00:00:00
2001
> From: Li Jun
> Date: Mon, 12 May 2025 10:39:27 +0800
> Subject: [PATCH v2] hiberbate: init image_size depend on
totalram_pages
>
> Some automatically loaded applications greedily occupy
> memory, when total memory is 8GB, the image_size is 3GB,
> when total memory is 16GB, the image_size is 6GB, when
> total memory is 32GB, the image_size is 12GB. some
> of these applications,user may not use them. They occupy
> a large amount of image space, resulting in S4 time of
> over 100 seconds or even more. Limit the size of image_size
> to control the time of hibernation and wake-up,making S4
> more user-friendly.
>
> Signed-off-by: Li Jun
> ---
> kernel/power/snapshot.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 2af36cfe35cd..197976d75879 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -135,10 +135,20 @@ void __init hibernate_reserved_size_init(void)
> * try to create the smallest image possible.
> */
> unsigned long image_size;
> -
> +#define MEM_8G 8388608 // KB

This could be written as (8 * 1024 * 1024) if I'm not mistaken.

> +#define MEM_8G_PAGES MEM_8G / PAGE_SIZE

But PAGE_SIZE is in bytes.

> +#define MEM_16G_PAGES MEM_8G_PAGES * 2
> +#define MEM_32G_PAGES MEM_8G_PAGES * 4
> void __init hibernate_image_size_init(void)
> {
> - image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> + if (totalram_pages() >= MEM_32G_PAGES)
> + image_size = ((totalram_pages() * 1) / 20) * PAGE_SIZE;
> + else if (totalram_pages() >= MEM_16G_PAGES)
> + image_size = ((totalram_pages() * 1) / 10) * PAGE_SIZE;
> + else if (totalram_pages() >= MEM_8G_PAGES)
> + image_size = ((totalram_pages() * 1) / 5) * PAGE_SIZE;
> + else
> + image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;

Can you please describe this magic a bit?

> }
>
> /*
> --


