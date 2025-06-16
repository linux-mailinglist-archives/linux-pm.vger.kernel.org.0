Return-Path: <linux-pm+bounces-28785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B09ADA913
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923601884ED9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F091EF36B;
	Mon, 16 Jun 2025 07:14:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B774227454
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058087; cv=none; b=tYLXhrC8pr7TbzvmAc2enZbx7ktg74idg0Q/8BQAMLmpOUhzFy3+VPFQa8v7RmebV2RZ/8WmrJWPANh1B8le+DBTT+SoNHC57g/dt8PX2bpvZ+e15CIOvEJ6qE97TpysI+68G1pZuJyJmUlP1iW95pp9YvYtA1QaToOmcEscDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058087; c=relaxed/simple;
	bh=TmKwm0n8v7mGAAwud2x/AldoeK+uMB/jbVH4eOoZO94=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=UKHY5DrBTZtiOOuLwAvMCutYoiZJA4GfTvvBf9kclYMJ3Frm+9eZUqgTMmw707hoav/NauxTyPWUxGLpRxYlMI18TN0Davl6pQDcFuPZ5N8zHubZHEQ4gFTavLx5eki0d2Uf3zq+4IpJJwOixWPAThaKXsg+DOrGcxhqpxQGkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCXJLVSxE9o8jwKAw--.2478S2;
	Mon, 16 Jun 2025 15:14:26 +0800 (CST)
Received: from huangshaobo2075$phytium.com.cn (
 [240e:469:647:4461:10d3:4a77:6f9f:99d2] ) by ajax-webmail-mail (Coremail) ;
 Mon, 16 Jun 2025 15:14:18 +0800 (GMT+08:00)
Date: Mon, 16 Jun 2025 15:14:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6buE5bCR5rOi?= <huangshaobo2075@phytium.com.cn>
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, deepthi@linux.vnet.ibm.com,
	khilman@kernel.org
Subject: Subject: [cpuidle] Limitation: cannot model asymmetric C-state
 latencies on big.LITTLE SoCs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250327(ab59d9cc) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: W3SqWmZvb3Rlcl90eHQ9MTQyNDozODM=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d7534c.5492.1977796c43a.Coremail.huangshaobo2075@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwA3zyhMxE9oj1RVAA--.9604W
X-CM-SenderInfo: xkxd0wpvkd0uzrsqlko6sk53xlxphulrpou0/1tbiAQADCmhPIu4C
	zAAAst
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=huangshaob
	o2075@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFyfJF4ftF15Gw18uFyUJrb_yoWrWr4fp3
	W8J3W8Aw1UKa17JrZagw18AryUG3yUGr17J3Wxt3yqywsxJrn0qrnxKFZ7J3Wjga4Yyr4D
	t3W7XrZ0qr1UtrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

RnJvbTogaHVhbmdzaGFvYm8yMDc1QHBoeXRpdW0uY29tLmNuClRvOiBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmcKQ2M6IHJhZmFlbEBrZXJuZWwub3JnLCBsZW5iQGtlcm5lbC5vcmcsIGRlZXB0aGlA
bGludXgudm5ldC5pYm0uY29tLCBraGlsbWFuQGtlcm5lbC5vcmcKU3ViamVjdDogW2NwdWlkbGVd
IExpbWl0YXRpb246IGNhbm5vdCBtb2RlbCBhc3ltbWV0cmljIEMtc3RhdGUgbGF0ZW5jaWVzIG9u
IGJpZy5MSVRUTEUgU29DcwoKSGksCgpJJ20gd29ya2luZyBvbiBhbiBBUk02NCBwbGF0Zm9ybSB3
aXRoIGEgYmlnLkxJVFRMRSBDUFUgdG9wb2xvZ3kuIFdoaWxlIHBhcnNpbmcgdGhlIEFDUEkgdGFi
bGVzLApJIG5vdGljZWQgdGhhdCB0aGUgQy1zdGF0ZSBsYXRlbmN5IGFuZCByZXNpZGVuY3kgdmFs
dWVzIGRpZmZlciBiZXR3ZWVuIHRoZSBiaWcgYW5kIExJVFRMRSBjb3JlcywKYXMgZXhwZWN0ZWQu
CgpIb3dldmVyLCBJIGZvdW5kIHRoYXQgdGhlIGN1cnJlbnQgY3B1aWRsZSBmcmFtZXdvcmsgb25s
eSBhbGxvd3MgYSBzaW5nbGUgZ2xvYmFsIGBjcHVpZGxlX2RyaXZlcmAsCmFuZCBhbGwgQ1BVcyBz
aGFyZSB0aGUgc2FtZSBgY3B1aWRsZV9kcml2ZXItPnN0YXRlc1tdYCBhcnJheS4gQXMgYSByZXN1
bHQsIG9ubHkgdGhlIGZpcnN0IGNvcmUgdG8KaW5pdGlhbGl6ZSAodXN1YWxseSBhIExJVFRMRSBj
b3JlKSBzZXRzIHVwIHRoZSBDLXN0YXRlcywgYW5kIHRoZSBzYW1lIHZhbHVlcyBhcmUgYXBwbGll
ZCB0byBhbGwgY29yZXMsCmluY2x1ZGluZyB0aGUgYmlnIG9uZXMuIFRoaXMgbGVhZHMgdG8gaW5j
b3JyZWN0IGlkbGUgYmVoYXZpb3Igb24gYXN5bW1ldHJpYyBwbGF0Zm9ybXMuCgpJIGJlbGlldmUg
dGhpcyBiZWhhdmlvciB3YXMgaW50cm9kdWNlZCBieSBjb21taXQgNDZiY2ZhZDdhODE5CigiY3B1
aWRsZTogU2luZ2xlL0dsb2JhbCByZWdpc3RyYXRpb24gb2YgaWRsZSBzdGF0ZXMiKS4KCkkgdW5k
ZXJzdGFuZCB0aGlzIGRlc2lnbiB3YXMgaW50cm9kdWNlZCBpbiAyMDExIHRvIHNpbXBsaWZ5IGNw
dWlkbGUgYW5kIHJlZHVjZSBtZW1vcnkgdXNhZ2U6Cmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDEx
LzQvMjUvODMKCkhvd2V2ZXIsIG9uIHRvZGF5J3MgaGV0ZXJvZ2VuZW91cyBTb0NzLCB0aGlzIGds
b2JhbCBtb2RlbCBubyBsb25nZXIgc3VmZmljZXMuIEZvciBwcm9wZXIgbW9kZWxpbmcsCndlIG5l
ZWQgc3VwcG9ydCBmb3IgcGVyLWNsdXN0ZXIgb3IgcGVyLWNvcmUgY3B1aWRsZSBkcml2ZXJzLCBv
ciBhdCBsZWFzdCBzb21lIG1lY2hhbmlzbSB0byBhbGxvdwpkaWZmZXJlbnQgaWRsZSBzdGF0ZSBw
YXJhbWV0ZXJzIHBlciBDUFUuCgpIYXMgdGhlcmUgYmVlbiBhbnkgZGlzY3Vzc2lvbiBvciB3b3Jr
IHRvd2FyZCBsaWZ0aW5nIHRoaXMgbGltaXRhdGlvbj8KClRoYW5rcywKClNoYW9ibyBIdWFuZwoN
Cg0K5L+h5oGv5a6J5YWo5aOw5piO77ya5pys6YKu5Lu25YyF5ZCr5L+h5oGv5b2S5Y+R5Lu25Lq6
5omA5Zyo57uE57uH5omA5pyJLOWPkeS7tuS6uuaJgOWcqOe7hOe7h+WvueivpemCruS7tuaLpeac
ieaJgOacieadg+WIqeOAguivt+aOpeaUtuiAheazqOaEj+S/neWvhizmnKrnu4/lj5Hku7bkurrk
uabpnaLorrjlj68s5LiN5b6X5ZCR5Lu75L2V56ys5LiJ5pa557uE57uH5ZKM5Liq5Lq66YCP6Zyy
5pys6YKu5Lu25omA5ZCr5L+h5oGv44CCDQpJbmZvcm1hdGlvbiBTZWN1cml0eSBOb3RpY2U6IFRo
ZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBtYWlsIGlzIHNvbGVseSBwcm9wZXJ0eSBv
ZiB0aGUgc2VuZGVyJ3Mgb3JnYW5pemF0aW9uLlRoaXMgbWFpbCBjb21tdW5pY2F0aW9uIGlzIGNv
bmZpZGVudGlhbC5SZWNpcGllbnRzIG5hbWVkIGFib3ZlIGFyZSBvYmxpZ2F0ZWQgdG8gbWFpbnRh
aW4gc2VjcmVjeSBhbmQgYXJlIG5vdCBwZXJtaXR0ZWQgdG8gZGlzY2xvc2UgdGhlIGNvbnRlbnRz
IG9mIHRoaXMgY29tbXVuaWNhdGlvbiB0byBvdGhlcnMu


