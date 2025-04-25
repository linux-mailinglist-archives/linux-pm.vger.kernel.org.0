Return-Path: <linux-pm+bounces-26157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1BA9BE80
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 08:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8835A0925
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869261AF0B7;
	Fri, 25 Apr 2025 06:17:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E71714C0
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561865; cv=none; b=lkTzD6RJ1EIX0aNoviF+IJJYo6Hj5MpWKIVtvDMvdz/22aOT9jkWfKnFZEYhkcOmgqrCcn4pnwzxZx1zxiwGrsVhDg2he3p684mhvq+KIi8ToH3RgGApq95191F2qZXGp34OJEjnSgXLWplPCe9GqpnJQLvlWaWFh965SdFNm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561865; c=relaxed/simple;
	bh=Z1ot4WaBllUein2QX1WZkzBaY5bAwmNIbKKpQ7yD2Oo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MoY4139rKts/rxy0ztGJ09ut4g0KXSUOU8KkGe8F+R/LWf6+gpO9H6ics+EXVq1F93zt55Nvqhbw2uL3qjoBWiIEnuld9pu3BJRTW92WIBTJ1z4JiVxsLUblIIjkgL7v3hd6DGg+d3pCI/xx41VXEEiTTd8V7Rh2at6LFIDtpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f7713a3e219c11f0a216b1d71e6e1362-20250425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2df21aa1-0bbb-44cb-b064-568fccd422f0,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:2df21aa1-0bbb-44cb-b064-568fccd422f0,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:32191cdc1d7dae9c4e1f1cff1207c33c,BulkI
	D:2504251417327XO7H01S,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: f7713a3e219c11f0a216b1d71e6e1362-20250425
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1005154788; Fri, 25 Apr 2025 14:17:29 +0800
Message-ID: <d2e914982a06fc4886c5f5056291772ec4b73588.camel@kylinos.cn>
Subject: [PATCH] hibernate: add minimum image size in hibernation
From: lijun <lijun01@kylinos.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Date: Fri, 25 Apr 2025 14:17:27 +0800
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
Content-Transfer-Encoding: 7bit

From 73ea74f11c4e188b9642eae5ef2e47a9310e97bb Mon Sep 17 00:00:00 2001
From: Li Jun <lijun01@kylinos.cn>
Date: Fri, 25 Apr 2025 13:44:23 +0800
Subject: [PATCH] hibernate: add minimum image size in hibernation

When I want to complete S4 in a shorter amount of time,
so,add this config,and set the config to n,
the image_size = 2/5 * totalram_pages,in hibernate_image_size_init
PM: Allocated 2908160 kbytes in 0.10 seconds
PM: Wrote 3000464 kbytes in 4.13 seconds
PM: Read 3000464 kbytes in 5.67 seconds

and set the config to y:
the image_size = 0,in hibernate_image_size_init,
PM: Allocated 817872 kbytes in 1.76 seconds,
PM: Wrote 908368 kbytes in 1.16 seconds,
PM: Read 908368 kbytes in 1.82 seconds,

0.10 + 4.13 + 5.76 = 9.99
1.76 + 1.16 + 1.82 = 4.74

Reduced time by 53%, the test is in 8G mem,if the mem is 16G or more,
this config can reduce more time.

the image_size =0, just shrink more NR_SLAB_RECLAIMABLE,NR_ACTIVE_ANON,
NR_INACTIVE_ANON,NR_ACTIVE_FILE,NR_INACTIVE_FILE pages,S4 is still
normal,so add a shorter time option.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/Kconfig | 10 ++++++++++
 kernel/power/snapshot.c | 6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 54a623680019..fef014fc31b1 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -80,6 +80,16 @@ config HIBERNATION
 For more information take a look at
<file:Documentation/power/swsusp.rst>.
+config MINIMUM_HIBERNATION_IMAGE_SIZE
+ bool "Minimum Hibernation Image Size"
+ depends on HIBERNATION
+ default n
+ help
+ Enable create the smallest image in Hibernation
+ Set image_size = 0
+ shrink more temp memory
+ That may can reduces the s4 time.
+
 config HIBERNATION_SNAPSHOT_DEV
 bool "Userspace snapshot device"
 depends on HIBERNATION
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 4e6e24e8b854..dffd5645b875 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -138,7 +138,11 @@ unsigned long image_size;
 void __init hibernate_image_size_init(void)
 {
- image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+ #ifdef CONFIG_MINIMUM_HIBERNATION_IMAGE_SIZE
+ image_size = 0;
+ #else
+ image_size = ((totalram_pages() * 2) / 5) * PAGE_SIZE;
+ #endif
 }
 /*
--
2.34.1




