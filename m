Return-Path: <linux-pm+bounces-13318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50D967FA9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62072282E10
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD363155A47;
	Mon,  2 Sep 2024 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="qMsesFWl"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3615442D;
	Mon,  2 Sep 2024 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259737; cv=none; b=S78lf3GwqDLXaOeE0BUir7uHza8vUi7/a7yskYplQEHy3oUboBmYR75zWI0MMn19FZW9ISZCDKiMZK2Jkxw6baPi91SkKXY2tTrGURrh6mhMi4jVsB+5d0oPC6LmhOyQXjixt/nEJLnJizQ/rjqwoCAXN/jmHvcA4gGiujrIiOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259737; c=relaxed/simple;
	bh=/ZUw6GQXPaP+AAz0tnorXY9Ln0hiw+td8+j/xEkumC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=MnIZqa18BKXu+QB86bzgzwI83lcCRzs9+Xz4W2V5C9fwVaKKnV1ukiM0wAAM9pIlBSBs+VQvWEoWQVufIIFyUIj8aGJvMJ1lhMhruMOludq+px9eEgKSLv+C7KchrwP/hisTeL/V5+njD4MeA5e3z3weER9nSJz/kvGGHafLcIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=qMsesFWl reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=SrBHmav9lOoEBuzcBvuLA44eLy2zxHuF9oWNXKAWU8Q=; b=q
	MsesFWlexH79FWsliWB49Z9hvq9DWdlEqJtqgW9zz4cn1y5/pg4WS7jHUuajaouN
	gVocWAw8XJfyTwsB8WX3p1/GzloLcun7Umo9IVaHg9h1MXqy4f4i5NAbiXacPdzE
	tBoQW8FYhon0UTwIW6T4AV760084OjT9MSti646rFM=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-109 (Coremail) ; Mon, 2 Sep 2024 14:47:45 +0800 (CST)
Date: Mon, 2 Sep 2024 14:47:45 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: add: move warn message out of mutex lock.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <2024090212-shuffling-gimmick-a2dc@gregkh>
References: <20240902054959.28073-1-00107082@163.com>
 <2024090212-shuffling-gimmick-a2dc@gregkh>
X-NTES-SC: AL_Qu2ZB/6etk4t4yebZ+kXn0oTju85XMCzuv8j3YJeN500uyTu2wscUE9MMXT54u+hFQ2BgCi5TTtByN1wXLF8cYnXcdeOPfHjoBOsbKUCeaXK
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <128c29b9.67bf.191b17d5148.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD331+SX9VmKZdQAA--.53675W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMx5OqmXAnkx39gAEs7
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksIAoKVGhhbmtzIGZvciByZXZpZXdpbmd+CkF0IDIwMjQtMDktMDIgMTQ6MzE6MzUsICJHcmVn
IEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gTW9uLCBTZXAgMDIs
IDIwMjQgYXQgMDE6NDk6NTlQTSArMDgwMCwgRGF2aWQgV2FuZyB3cm90ZToKPj4gZHBtX2xpc3Rf
bXR4IGRvZXMgbm90IHByb3RlY3QgYW55IGRhdGEgdXNlZCBieQo+PiBkZXZfd2FybiBmb3IgY2hl
Y2tpbmcgcGFyZW50J3MgcG93ZXIsIG1vdmUKPj4gZGV2X3dhcm4gb3V0IG9mIG11dGV4IGxvY2sg
YmxvY2sgbWFrZSB0aGUKPj4gbG9jayBtb3JlIGVmZmljaWVudCwgZXNwZWNpYWxseSB3aGVuIHRo
ZSB3YXJuCj4+IGlzIHRyaWdnZXJlZC4gVGhpcyBjYW4gaGFwcGVuIG9uIHNvbWUgSFcgd2hlbgo+
PiByZXN1bWUgZnJvbSBzdXNwZW5kIHdpdGggVVNCIGNhbWVyYSBvcGVuZWQ6Cj4KPlBsZWFzZSB3
cmFwIGNoYW5nZWxvZyBsaW5lcyBhdCA3MiBjb2x1bW5zIGlmIHBvc3NpYmxlLgo+Cj4+ICA+dXNi
IDMtMS4xOiByZXNldCBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDQgdXNpbmcgeGhjaV9o
Y2QKPj4gID4uLgo+PiAgPmVwXzgxOiBQTTogcGFyZW50IDMtMS4xOjEuMSBzaG91bGQgbm90IGJl
IHNsZWVwaW5nCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMu
Y29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMgfCAyICstCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4gCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIGIvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4u
Ywo+PiBpbmRleCA0YTY3ZTgzMzAwZTEuLjkzNGU1YmI2MWYxMyAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9iYXNlL3Bvd2VyL21haW4uYwo+PiArKysgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5j
Cj4+IEBAIC0xMzQsMTAgKzEzNCwxMCBAQCB2b2lkIGRldmljZV9wbV9hZGQoc3RydWN0IGRldmlj
ZSAqZGV2KQo+PiAgCXByX2RlYnVnKCJBZGRpbmcgaW5mbyBmb3IgJXM6JXNcbiIsCj4+ICAJCSBk
ZXYtPmJ1cyA/IGRldi0+YnVzLT5uYW1lIDogIk5vIEJ1cyIsIGRldl9uYW1lKGRldikpOwo+PiAg
CWRldmljZV9wbV9jaGVja19jYWxsYmFja3MoZGV2KTsKPj4gLQltdXRleF9sb2NrKCZkcG1fbGlz
dF9tdHgpOwo+PiAgCWlmIChkZXYtPnBhcmVudCAmJiBkZXYtPnBhcmVudC0+cG93ZXIuaXNfcHJl
cGFyZWQpCj4+ICAJCWRldl93YXJuKGRldiwgInBhcmVudCAlcyBzaG91bGQgbm90IGJlIHNsZWVw
aW5nXG4iLAo+PiAgCQkJZGV2X25hbWUoZGV2LT5wYXJlbnQpKTsKPj4gKwltdXRleF9sb2NrKCZk
cG1fbGlzdF9tdHgpOwo+Cj5JIGRvIG5vdCB1bmRlcnN0YW5kIGhvdyB0aGlzIGNoYW5nZSB3aWxs
IHJlbW92ZSB0aGUgb2ZmZW5kaW5nIGxvZwo+bWVzc2FnZS4gIEl0IHNob3VsZCBiZSBzYWZlIHRv
IGhvbGQgdGhlIGxvY2sgd2hpbGUgdGhlIGNoZWNrIGhhcHBlbnMgYW5kCj50aGUgbWVzc2FnZSBp
cyBwcmludGVkIG91dCwgeW91IHNob3VsZCBub3Qgc2VlIGFueSBmdW5jdGlvbmFsIGNoYW5nZSBh
dAo+YWxsLgo+Cj5TbyBhcmUgeW91IHN1cmUgdGhpcyBpcyBuZWVkZWQ/CgpUaGlzIHBhdGNoIGRv
ZXMgbm90IGZpeCBhbnl0aGluZywgdGhlIHdhcm5pbmcgaXMgc3RpbGwgdGhlcmUgYW5kIGluZGVl
ZCBubyBmdW5jdGlvbmFsIGNoYW5nZSBhdCBhbGwuCkl0IGlzIG1vcmUgb2YgYSBjb2RlIHJlZmFj
dG9yOiB3aGVuIEkgZm9sbG93IHRoZSBrZXJuZWwgd2FybiBvbiBteSBzeXN0ZW0gYW5kIGNoZWNr
IHRoZSBjb2RlLCBJIApmZWVsIGl0cyBiZXR0ZXIgdG8gbW92ZSBkZXZfd2FybiBvdXQgb2YgdGhl
IGxvY2sgc2VjdGlvbiBzaW5jZSB0aGUgbG9jayBpcyBub3QgbWVhbnQgdG8gcHJvdGVjdCBpdCwg
cmlnaHQ/CkFuZCBJIG1lbnRpb24gdGhlIHdhcm5pbmcgbWVzc2FnZSBpbiB0aGUgY29tbWl0IGxv
ZyBiZWNhdXNlIEkgdGhpbmsgaXQgd291bGQgbWFrZSB0aGUgbG9jay1ob2xkaW5nIHVubmVjZXNz
YXJpbHkKbG9uZ2VyIHdoZW4gdGhlIHdhcm5pbmcgZG8gaGFwcGVuLiAKCj4KPnRoYW5rcywKPgo+
Z3JlZyBrLWgK

