Return-Path: <linux-pm+bounces-27631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF422AC3803
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 04:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDD171FB1
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 02:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD91161302;
	Mon, 26 May 2025 02:34:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEED29A2
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748226891; cv=none; b=iYWD3Da2u67OvYy5XKB7jebZMd4b0bJc6sEf6Pe1Jfm+6cF1idNUzZARUWRHZ0ceQre2TiV706pGxyqSaYdb5zjkKRKjuQwKSogv0eIuz/+AOvvNF0zody3g+6LvseXeuJWRu/v7ehE1wOMTbfMZp9eswXTGO1CEoN9iRXlIqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748226891; c=relaxed/simple;
	bh=SrNi+2ycLc1EEQjrN693vQsGm7g9zfcuyoO8KpzGjkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p8h2xl9uiSKhlYM4apadjPflwsYSdyUR1v/l2XOyshzkixsotx02bCuhY/8bUM5Y78AH7ek8WwvW6EXjA0MmFs9MIHuGGcOjwMzyIB366gCurS7PuBW7eHZUbFUk7BuBQQbWQlU9YqnvLfBjGL52eTtL46JBfIoCKKVRcdV6VQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f52ce84a39d911f0b29709d653e92f7d-20250526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1ec6f895-abcb-4786-b291-65f3a2320889,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:1ec6f895-abcb-4786-b291-65f3a2320889,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:d575c2aeef53df7c5396502eb7c7b755,BulkI
	D:2505261034351UE7SWFA,BulkQuantity:0,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: f52ce84a39d911f0b29709d653e92f7d-20250526
X-User: lijun01@kylinos.cn
Received: from [192.168.31.86] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 323761607; Mon, 26 May 2025 10:34:33 +0800
Message-ID: <423f2db0f9f9e45ce138d730fdae1f691dd2534d.camel@kylinos.cn>
Subject: =?gb2312?Q?re=A3=BA=5BPATCH=5D?= hibernate: init minimum image size
 in hibernate
From: lijun <lijun01@kylinos.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Date: Mon, 26 May 2025 10:34:30 +0800
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
Content-Transfer-Encoding: 7bit

I conducted a test with 16GB of memory, the image_size = 2/5 *
totalram_pages,in
hibernate_image_size_init,start timing form "echo disk >
/sys/power/state"
to the desk display after resume, the time is 107 seconds.
the image_size = 0,in hibernate_image_size_init,the time is 63 seconds.
I opened a 50M file with vim ,display a movie and display a usb camera
in 4K,
before hibernate. resume to the desk ,I didn't feel any delay in
response
from these apps due to S4.



-----------
> That's not as simple as it seems because your image write/read
> numbers
> 
> above don't include the time needed to push user pages to swap and
> 
> pull them in after hibernation and the rate at which they are swapped
> 
> out and faulted in is way less than the image read/write speed.


