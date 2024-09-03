Return-Path: <linux-pm+bounces-13446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA796A50D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 19:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3261C23ACA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183B18BC33;
	Tue,  3 Sep 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="OSfpEssx"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934956F315;
	Tue,  3 Sep 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383402; cv=none; b=d5NHA4P9xRnvS7mEPRI+ZKku2VPRBI7ERoLUtLZSUySrdSE7b2+yCxlQcBDINlOjYqzMD9mmg0dlUPjP5pTt+/NHJscKfDBsyyJohwV5lf1rSYKCGRFpG8IWVZE4A175G8iE8CN1q3lKSRWCUqbRkW9YLE3GA6zcCznavihbuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383402; c=relaxed/simple;
	bh=03XIixYXaT/4wFoC3iJ/FtR2unQwfW7uyjxow3lM7GY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=D1Diy+66hf/HnkouqyDV3f3ObDFNFVZwHc+zJ7KEew1RlRPoHFDVWKNGGYKNv8toOuq9XpCmSxX0EFGa8RtAd2cI6O5hIlCrWDU9k2S9VgLpaO27y2cGZgsR3DIyLnzXIZzq5KG47/7Xz7kR9SYcqQET2+ODv31YaLh4rQmKUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=OSfpEssx reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Dhd7TmibVshGQou9elx6m0Up6wd6tS7+YdhneHG5h84=; b=O
	SfpEssxh0qUFQ1Pde+CiW5wHdW6rRlc3xW3EIBBxaetfcyhZCKabS/OM9Mq0UL6Y
	CMtlhBhpoCZSUs+RXuZwkAZb/S5R+lvLC1pIATMLn7widCppX8GsVxHwDvzOcclL
	/URjdNb0bxLZici0grt/q+oiuD17McDO8/2pfkASrw=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Wed, 4 Sep 2024 01:09:02 +0800 (CST)
Date: Wed, 4 Sep 2024 01:09:02 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pm: sleep: do not set is_prepared when no_pm_callbacks
 is set
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJZ5v0hMnnDjKJLMgcT_p1nnejyyAyaqaA_AF5t+_=PsSMfceQ@mail.gmail.com>
References: <20240902125933.5742-1-00107082@163.com>
 <CAJZ5v0hMnnDjKJLMgcT_p1nnejyyAyaqaA_AF5t+_=PsSMfceQ@mail.gmail.com>
X-NTES-SC: AL_Qu2ZB/+TvEsv5CeaZekXn0oTju85XMCzuv8j3YJeN500tCTQ+RgyZVRZGF3m+uuPGzqumzO8Xx5pzt1HQ5B8RJ6+Q5vbvqAG+77zcYFtMy2O
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <59eb3605.b8cd.191b8dc7a89.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3X9GvQtdmKrM1AA--.12492W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxVPqmXAnnH+EAADsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTA5LTAzIDIwOjMxOjA0LCAiUmFmYWVsIEouIFd5c29ja2kiIDxyYWZhZWxAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj5PbiBNb24sIFNlcCAyLCAyMDI0IGF0IDI6NTnigK9QTSBEYXZpZCBX
YW5nIDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToKPj4KPj4gV2hlbiByZXN1bWUsIGEgcGFyZW50
IGRldmljZSB3aXRoIG5vIHBtIGNhbGxiYWNrcwo+PiB3b3VsZCBoYXZlICJpc19wcmVwYXJlZCIg
YW5kICJkaXJlY3RfY29tcGxldGUiIGJpdAo+PiBzZXQsIGFuZCBza2lwIHRoZSAiZmliIiBjaGFu
Y2UgdG8gdW5zZXQgImlzX3ByZXBhcmVkIgo+PiBpbiBkZXZpY2VfcmVzdW1lIGJlY2F1c2Ugb2Yg
dGhlIGRpcmVjdF9jb21wbGV0ZSBiaXQuCj4KPlN1cmUsIGJ1dCBpc19wcmVwYXJlZCB3aWxsIGJl
IGNsZWFyZWQgaW4gZGV2aWNlX2NvbXBsZXRlKCkgQUZBSUNTLgoKWWVzLCB5b3UncmUgcmlnaHQu
IEkgbWFkZSBhIHdyb25nIHJlYXNvbmluZy4uLgoKPgo+PiBUaGlzIHdpbGwgdHJpZ2dlciBhIGtl
cm5lbCB3YXJuaW5nIHdoZW4gcmVzdW1lIGl0cyBjaGlsZAo+PiBGb3IgZXhhbXBsZSwgd2hlbiBz
dXNwZW5kIHN5c3RlbSB3aXRoIGFuIFVTQiB3ZWJjYW0KPj4gb3BlbmVkLCBmb2xsb3dpbmcgd2Fy
bmluZyB3b3VsZCBzaG93IHVwIGR1cmluZyByZXN1bWU6Cj4+Cj4+ICA+dXNiIDMtMS4xOiByZXNl
dCBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDQgdXNpbmcgeGhjaV9oY2QKPj4gID4uLgo+
PiAgPmVwXzgxOiBQTTogcGFyZW50IDMtMS4xOjEuMSBzaG91bGQgbm90IGJlIHNsZWVwaW5nCj4K
PlRoaXMgaXMgcHJpbnRlZCBpbiBkZXZpY2VfcG1fYWRkKCksIHNvIGFwcGFyZW50bHkgc29tZXRo
aW5nIG5ldyBoYXMKPmFwcGVhcmVkIHVuZGVyIHRoZSBwYXJlbnQgd2hpbGUgaXQncyBiZXR3ZWVu
ICJyZXN1bWUiIGFuZCAicHJlcGFyZSIuCgpZZXMsIGFmdGVyIHNvbWUgZGVidWcsIGl0IHR1cm5z
IG91dCAidXZjdmlkZW8gMy0xLjE6MS4xIiBjcmVhdGVkIGEgbmV3CiJlcF84MSIgd2hlbiAiZXBf
ODEiIHJlc3VtZWQKCj4KPlRoZSBwYXJlbnQgaXMgYWN0dWFsbHkgc3RpbGwgcmVnYXJkZWQgYXMg
InN1c3BlbmRlZCIgYmVjYXVzZSBhbnkKPnJlc3VtZSBjYWxsYmFja3MgaGF2ZSBub3QgYmVlbiBj
YWxsZWQgZm9yIGl0LCBidXQgbmV3IGNoaWxkcmVuIGNhbiBiZQo+YWRkZWQgdW5kZXIgaXQgYXQg
dGhpcyBwb2ludCBiZWNhdXNlIGRvaW5nIHNvIGRvZXMgbm90IGJyZWFrIHRoZQo+ZHBtX2xpc3Qg
b3JkZXJpbmcgYW5kIGFsbCBvZiBpdHMgYW5jZXN0b3JzIGhhdmUgYmVlbiBhbHJlYWR5IHJlc3Vt
ZWQuCj4KPj4gVGhlIGRldmljZSBwYXJlbnRpbmcgcmVsYXRpb25zaGlwcyBhcmU6Cj4+IFt1c2Ig
My0xLjFdIDw8IFt1dmN2aWRlbyAzLTEuMToxLjFdIDw8IFtlcF84MV0uCj4+IFdoZW4gcmVzdW1l
LCBzaW5jZSB0aGUgdmlydHVhbCBbdXZjdmlkZW8gMy0xLjE6MS4xXSBkZXZpY2UKPj4gaGFzIG5v
IHBtIGNhbGxiYWNrcywgaXQgd291bGQgbm90IGNsZWFyICJpc19wcmVwYXJlZCIKPj4gb25jZSBz
ZXQuICBUaGVuLCB3aGVuIHJlc3VtZSBbZXBfODFdLCBwbSBtb2R1bGUgd291bGQKPj4geWllbGQg
YSB3YXJuIHNlZWluZyBbZXBfODFdJ3MgcGFyZW50IFt1dmN2aWRlbyAzLTEuMToxLjFdCj4+IGhh
dmluZyAiaXNfcHJlcGFyZWQiLgo+Pgo+PiBEbyBub3Qgc2V0ICJpc19wcmVwYXJlZCIgZm9yIHZp
cnR1YWwgZGV2aWNlcyBoYXZpbmcKPj4gbm8gcG0gY2FsbGJhY2tzIGNhbiBjbGVhciB0aG9zZSBr
ZXJuZWwgd2FybmluZ3MuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdhbmcgPDAwMTA3MDgy
QDE2My5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYyB8IDMgKystCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIGIvZHJpdmVycy9iYXNlL3Bvd2Vy
L21haW4uYwo+PiBpbmRleCA5MzRlNWJiNjFmMTMuLmUyMTQ5Y2NmMmMzZSAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYwo+PiArKysgYi9kcml2ZXJzL2Jhc2UvcG93ZXIv
bWFpbi5jCj4+IEBAIC0xODgwLDcgKzE4ODAsOCBAQCBpbnQgZHBtX3ByZXBhcmUocG1fbWVzc2Fn
ZV90IHN0YXRlKQo+PiAgICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygmZHBtX2xpc3RfbXR4KTsK
Pj4KPj4gICAgICAgICAgICAgICAgIGlmICghZXJyb3IpIHsKPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgZGV2LT5wb3dlci5pc19wcmVwYXJlZCA9IHRydWU7Cj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGlmICghZGV2LT5wb3dlci5ub19wbV9jYWxsYmFja3MpCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZGV2LT5wb3dlci5pc19wcmVwYXJlZCA9IHRydWU7Cj4KPlRoaXMg
aXMgbm90IHRoZSB3YXkgdG8gYWRkcmVzcyB0aGUgaXNzdWUgSU1WLgo+Cj5wb3dlci5pc19wcmVw
YXJlZCBzZXQgbWVhbnMgdGhhdCB0aGUgZGV2aWNlIGlzIGluIGRwbV9wcmVwYXJlZF9saXN0Cj5h
bmQgSSB3b3VsZG4ndCBkZXBhcnQgZnJvbSB0aGF0IGV2ZW4gZm9yIGRldmljZXMgd2l0aG91dCBQ
TSBjYWxsYmFja3MuCj4KPj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFsaXN0X2VtcHR5
KCZkZXYtPnBvd2VyLmVudHJ5KSkKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBs
aXN0X21vdmVfdGFpbCgmZGV2LT5wb3dlci5lbnRyeSwgJmRwbV9wcmVwYXJlZF9saXN0KTsKPj4g
ICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoZXJyb3IgPT0gLUVBR0FJTikgewo+PiAtLQo+Cj5J
dCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIGEgcG93ZXIubm9fcG1fY2FsbGJhY2tzIGNoZWNrIGZv
ciB0aGUgcGFyZW50Cj50byBkZXZpY2VfcG1fYWRkKCksIGJ1dCB0aGlzIHdvdWxkIHN0aWxsIHN1
cHByZXNzIHRoZSB3YXJuaW5nIGlzIHNvbWUKPmNhc2VzIGluIHdoaWNoIGl0IHNob3VsZCBiZSBw
cmludGVkIChmb3IgZXhhbXBsZSwgdGhlIG5ldyBkZXZpY2Uncwo+cGFyZW50IGlzIGEgInZpcnR1
YWwiIGRldmljZSB3aXRob3V0IFBNIGNhbGxiYWNrcywgYnV0IGl0cyBncmFuZHBhcmVudAo+aXMg
YSByZWd1bGFyIGRldmljZSB0aGF0IGhhcyBQTSBjYWxsYmFja3MgYW5kIGlzIHN1c3BlbmRlZCku
Cj4KPlNvbWV0aGluZyBsaWtlIHRoZSBhdHRhY2hlZCBwYXRjaCAodW50ZXN0ZWQpIG1pZ2h0IHdv
cmssIHRob3VnaC4KCkkgdHJpZWQgdGhlIHBhdGNoIG9uIDYuMTEuMC1yYzYsIHRoZSB3YXJuIGlz
IGdvbmUgd2hlbiBJIG1hZGUgZm9sbG93aW5nIHRlc3Q6CgoxLiBvcGVuIHdlYmNhbSAodmlhIG9i
cywgZS5nLikKMi4gc3lzdGVtY3RsIHN1c3BlbmQKMy4gcmVzdW1lIHRoZSBzeXN0ZW0sIGFuZCBj
aGVjayBrZXJuZWwgbG9nCgooV291bGQgaXQgc2FmZSB0byB3YWxrIHRoZSBwYXJlbnQgbGluayB3
aXRob3V0IGFueSBkZXZpY2UgbG9jaz8gYW5kIEkgc3RpbGwgc3VnZ2VzdCBtb3ZpbmcKdGhvc2Ug
Y29kZSBvdXIgb2YgJmRwbV9saXN0X210eCBsb2NrKQoKVGhhbmtzCkRhdmlkLgo=

