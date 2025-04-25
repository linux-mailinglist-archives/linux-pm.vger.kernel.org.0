Return-Path: <linux-pm+bounces-26179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D4A9C40E
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48511883E9F
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D42218821;
	Fri, 25 Apr 2025 09:44:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882F221540
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574247; cv=none; b=RKPPvQpT2S26d3YSsRVwZaiGAbrCHB5qCiRvwEOMTCr6/HSp6UoxkI36W2R9e7nW3n7qriIjArWC8MpZMSzrN3gNJhV639GGGoCLN4uHmzJD/3Ym/1R5G36VdjyP3R6IWr6FytajRPexxYZyfwKY2olcgolnAgZ8+s5ssQDzstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574247; c=relaxed/simple;
	bh=QCdgxGhx9eYfAWJm7Q3Jl8nBQnFPnKO84CNGfRST3eo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ufz5HnUm9uoGWZt3s6WIUwdKEiWu0VTiqdEwlyNr8mhbiYyPsqnBNNcliso5YlhxQogaG4JpgFamnqIteDRRylSXgl/YDWN4mtJvN+A3edG5PRx5IC+PlYaOhrOU2/zyHer0kretTcRwZEoJKIdiOhjhhCcxBKQOxLet0Z3mBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ceaedb1621b911f0a216b1d71e6e1362-20250425
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_7B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:9848c201-56f8-41f7-b913-943c906a7bf0,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:9848c201-56f8-41f7-b913-943c906a7bf0,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:2b767bada943c5241111929d2ffc11e2,BulkI
	D:250425174359FLRJHSIT,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ceaedb1621b911f0a216b1d71e6e1362-20250425
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 605796483; Fri, 25 Apr 2025 17:43:56 +0800
Message-ID: <b0a73fa2c20e367bbc0d2f011a976d8d1bac9b16.camel@kylinos.cn>
Subject: [PATCH v2] hibernate: add minimum image size in hibernation
From: lijun <lijun01@kylinos.cn>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, len.brown@intel.com, 
	linux-pm@vger.kernel.org, lijun01@kylinos.cn
Date: Fri, 25 Apr 2025 17:43:54 +0800
In-Reply-To: <aAsutyDMqqmuwURS@duo.ucw.cz>
References: <5aac0c93-2723-2ca1-cbfa-98f88b0c900c@kylinos.cn>
	 <CAJZ5v0iDeC-ieFEzzHP=Dpet5T5ssGRHqW-SvRUoSU4PCLR2Fw@mail.gmail.com>
	 <a55a3417634ae3ab546121d77af083cbf4fcdc3f.camel@kylinos.cn>
	 <CAJZ5v0how8gMN_mhqosNH4kB9uki2drA8RpdCPJVQVp+Kh70Bg@mail.gmail.com>
	 <d2e914982a06fc4886c5f5056291772ec4b73588.camel@kylinos.cn>
	 <aAsutyDMqqmuwURS@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From f0304eec49dfd1785ad944487676797e5e0c1f6a Mon Sep 17 00:00:00 2001
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
if set image_size in runtime, every time after reboot or poweron,
must set the image_size again by all other methods, if use config,
set the config =y, just init the image_size once.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 kernel/power/Kconfig | 10 ++++++++++
 kernel/power/snapshot.c | 6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index afce8130d8b9..7b70c66ef709 100644
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
index 405eddbda4fc..23dd7cab501e 100644
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
2.25.1



