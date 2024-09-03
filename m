Return-Path: <linux-pm+bounces-13448-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF74E96A56F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 19:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A921F25364
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F518DF62;
	Tue,  3 Sep 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Yzl8j0Zr"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0718734B;
	Tue,  3 Sep 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384684; cv=none; b=ijiWXyTzsAqBSkJCxEvgrpmKKosIB7UnurqXhTecpMRPxRVpHQ3WVyeIgArGXXnNKBxjzQ/I+lIhXCxWEVuo3mdgCnoXSrQtxUbK40meFIMNgocOcwZ0drQOdj8z9jjfD37pJN68B4k68Ae7N+Chfq7QU2tf7r8vaxKRJQSRfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384684; c=relaxed/simple;
	bh=ygh5b1A7bjawAXvXmNUVjuo5XKoXHyHx7oAuiSvs7uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=XR/GZj6uQJkxvJeThh4q8oOYKpDGpIr89JLkU49NeJJgyFP0Bz95YnlEPgPfntNCI0uPcfonm/2hww+87sU2V7yAbTbxFu0KjEg671rNWlVuUwqm4une4Z6gnsgOd0Gdk+OjEkPZPfM9FRijYflw7q5BPheQqODvFswbPR2qT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Yzl8j0Zr reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OalYsqwxA8flAvy+8A51VfWztd7+lMKCdc8ZRQCeFHo=; b=Y
	zl8j0Zr3FzfgQcrul423U8pQsCObZyUx7735CaC0AkkdwXqPp78Nd3IDqiYOGx5+
	NGNXm0KbPksTq76sfJuvAoGDx6v0Okj7b1ptDP5xRzLUUvXRCSFU4/NNDRteuQ1h
	C6OIHS3XKhMPbGZREgRJAZ4rnMLSmhrwPKZQQHJX4c=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Wed, 4 Sep 2024 01:30:59 +0800 (CST)
Date: Wed, 4 Sep 2024 01:30:59 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Greg KH" <gregkh@linuxfoundation.org>, pavel@ucw.cz, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pm: sleep: do not set is_prepared when no_pm_callbacks
 is set
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJZ5v0ifKFXk=odx-dZZZg4G-2+O_8rXRb7++TzPMfN4fFuGVg@mail.gmail.com>
References: <20240902125933.5742-1-00107082@163.com>
 <2024090347-latter-collide-772a@gregkh>
 <CAJZ5v0ifKFXk=odx-dZZZg4G-2+O_8rXRb7++TzPMfN4fFuGVg@mail.gmail.com>
X-NTES-SC: AL_Qu2ZB/+Tu04u7yOdYukXn0oTju85XMCzuv8j3YJeN500tCTQ+RgyZVRZGF3m+uuPGzqumzO8Xx5pzt1HQ5B8RJ5Bhs/hphdLaM6IjJXQDCh9
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5141ecf4.b921.191b8f091a6.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f5TUR9dmvnVOAA--.29715W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxVPqmXAnnH+EAAIsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDktMDMgMjA6MzI6MTQsICJSYWZhZWwgSi4gV3lzb2NraSIgPHJhZmFlbEBrZXJu
ZWwub3JnPiB3cm90ZToKPk9uIFR1ZSwgU2VwIDMsIDIwMjQgYXQgMTI6NDLigK9QTSBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4+Cj4+IE9uIE1vbiwgU2VwIDAy
LCAyMDI0IGF0IDA4OjU5OjMzUE0gKzA4MDAsIERhdmlkIFdhbmcgd3JvdGU6Cj4+ID4gV2hlbiBy
ZXN1bWUsIGEgcGFyZW50IGRldmljZSB3aXRoIG5vIHBtIGNhbGxiYWNrcwo+PiA+IHdvdWxkIGhh
dmUgImlzX3ByZXBhcmVkIiBhbmQgImRpcmVjdF9jb21wbGV0ZSIgYml0Cj4+ID4gc2V0LCBhbmQg
c2tpcCB0aGUgImZpYiIgY2hhbmNlIHRvIHVuc2V0ICJpc19wcmVwYXJlZCIKPj4gPiBpbiBkZXZp
Y2VfcmVzdW1lIGJlY2F1c2Ugb2YgdGhlIGRpcmVjdF9jb21wbGV0ZSBiaXQuCj4+ID4gVGhpcyB3
aWxsIHRyaWdnZXIgYSBrZXJuZWwgd2FybmluZyB3aGVuIHJlc3VtZSBpdHMgY2hpbGQKPj4gPiBG
b3IgZXhhbXBsZSwgd2hlbiBzdXNwZW5kIHN5c3RlbSB3aXRoIGFuIFVTQiB3ZWJjYW0KPj4gPiBv
cGVuZWQsIGZvbGxvd2luZyB3YXJuaW5nIHdvdWxkIHNob3cgdXAgZHVyaW5nIHJlc3VtZToKPj4g
Pgo+PiA+ICA+dXNiIDMtMS4xOiByZXNldCBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDQg
dXNpbmcgeGhjaV9oY2QKPj4gPiAgPi4uCj4+ID4gID5lcF84MTogUE06IHBhcmVudCAzLTEuMTox
LjEgc2hvdWxkIG5vdCBiZSBzbGVlcGluZwo+PiA+Cj4+ID4gVGhlIGRldmljZSBwYXJlbnRpbmcg
cmVsYXRpb25zaGlwcyBhcmU6Cj4+ID4gW3VzYiAzLTEuMV0gPDwgW3V2Y3ZpZGVvIDMtMS4xOjEu
MV0gPDwgW2VwXzgxXS4KPj4gPiBXaGVuIHJlc3VtZSwgc2luY2UgdGhlIHZpcnR1YWwgW3V2Y3Zp
ZGVvIDMtMS4xOjEuMV0gZGV2aWNlCj4+ID4gaGFzIG5vIHBtIGNhbGxiYWNrcywgaXQgd291bGQg
bm90IGNsZWFyICJpc19wcmVwYXJlZCIKPj4gPiBvbmNlIHNldC4gIFRoZW4sIHdoZW4gcmVzdW1l
IFtlcF84MV0sIHBtIG1vZHVsZSB3b3VsZAo+PiA+IHlpZWxkIGEgd2FybiBzZWVpbmcgW2VwXzgx
XSdzIHBhcmVudCBbdXZjdmlkZW8gMy0xLjE6MS4xXQo+PiA+IGhhdmluZyAiaXNfcHJlcGFyZWQi
Lgo+PiA+Cj4+ID4gRG8gbm90IHNldCAiaXNfcHJlcGFyZWQiIGZvciB2aXJ0dWFsIGRldmljZXMg
aGF2aW5nCj4+ID4gbm8gcG0gY2FsbGJhY2tzIGNhbiBjbGVhciB0aG9zZSBrZXJuZWwgd2Fybmlu
Z3MuCj4+ID4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29t
Pgo+PiA+IC0tLQo+PiA+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgMyArKy0KPj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBXaGF0
IGNvbW1pdCBpZCBkb2VzIHRoaXMgZml4Pwo+Cj5JdCBkb2Vzbid0IGZpeCBhbnl0aGluZywgaXQg
aXMgaW50cm9kdWNpbmcgYSBwb3RlbnRpYWwgaXNzdWUuCgpJIGFkbWl0IEkgb25seSBoYXZlIG15
IHN5c3RlbSB0byB0ZXN0IGFuZCBkb3NlIG5vdCBoYXZlIGEgd2hvbGUgcGljdHVyZSBpbiBtaW5k
LCAKYW5kIGFsc28gSSByZWFsbHkgZG8gbm90IHF1aXRlIHVuZGVyc3RhbmQgdGhlIG1vZHVsZSwg
Zm9yIG5vdy4KCkl0IHR1cm5lZCBvdXQgbXkgcmVhc29uaW5nIGluIHRoZSBjb21taXQgbWVzc2Fn
ZSBpcyBhbHNvIHF1aXRlIHdyb25nLCBhZnRlciBzb21lIGRlYnVnLCBJIHJlYWxpemVkCnRoYXQg
dGhlIGlzX3ByZXBhcmVkIHdvdWxkIGJlIGNsZWFyZWQgZXZlbnR1YWxseSwgYnV0IGFmdGVyIGVw
XzgxIHdhcyBhZGRlZC4gQW5kIAp0aGUgbmV3IGRldmljZSAiZXBfODEiIHdhcyBhZGRlZCBkdXJp
bmcgdXNiX3Jlc3VtZSwgd2hpbGUgImVwXzgxIidzIHBhcmVudCAidXZjdmlkZW8gMy0xLjE6MS4x
IgppcyBhbHNvIGluIGRldmljZV9yZXN1bWUgYnV0IHdhaXRpbmcgb24gImlmICghZHBtX3dhaXRf
Zm9yX3N1cGVyaW9yKGRldiwgYXN5bmMpKSIKdGhlIHdob2xlIGNhbGwgc3RhY2sgd2hlbiBhZGRp
bmcgdGhlIG5ldyAiZXAiIGRldmljZSBpcyBhcyBmb2xsb3c6CgoJICBkZXZpY2VfcG1fYWRkKzB4
ZGUvMHgxMzAKCSAgZGV2aWNlX2FkZCsweDNkMC8weDg3MAoJICB1c2JfY3JlYXRlX2VwX2RldnMr
MHg5Ni8weDEwMCBbdXNiY29yZV0KCSAgY3JlYXRlX2ludGZfZXBfZGV2cy5pc3JhLjArMHg1Mi8w
eDgwIFt1c2Jjb3JlXQoJICB1c2Jfc2V0X2ludGVyZmFjZSsweDJiOC8weDNjMCBbdXNiY29yZV0K
CSAgdXZjX3ZpZGVvX3N0YXJ0X3RyYW5zZmVyKzB4MWM2LzB4NjAwIFt1dmN2aWRlb10KCSAgX191
dmNfcmVzdW1lKzB4NjAvMHgxNTAgW3V2Y3ZpZGVvXQoJICB1c2JfcmVzdW1lX2ludGVyZmFjZS5p
c3JhLjArMHg0MS8weGUwIFt1c2Jjb3JlXQoJICB1c2JfcmVzdW1lX2JvdGgrMHgxMDMvMHgxODAg
W3VzYmNvcmVdCgkgID8gX19wZnhfdXNiX2Rldl9yZXN1bWUrMHgxMC8weDEwIFt1c2Jjb3JlXQoJ
ICB1c2JfcmVzdW1lKzB4MTUvMHg2MCBbdXNiY29yZV0KCSAgZHBtX3J1bl9jYWxsYmFjaysweDhi
LzB4MWUwCgkgIGRldmljZV9yZXN1bWUrMHg5Yy8weDIyMAoJICBhc3luY19yZXN1bWUrMHgxOS8w
eDMwCgkgIGFzeW5jX3J1bl9lbnRyeV9mbisweDMwLzB4MTMwCgkgIHByb2Nlc3Nfb25lX3dvcmsr
MHgxN2MvMHgzOTAKCSAgd29ya2VyX3RocmVhZCsweDI0NS8weDM1MAoJICA/IF9fcGZ4X3dvcmtl
cl90aHJlYWQrMHgxMC8weDEwCgkgIGt0aHJlYWQrMHhkZC8weDExMAoJICA/IF9fcGZ4X2t0aHJl
YWQrMHgxMC8weDEwCgkgIHJldF9mcm9tX2ZvcmsrMHgzMC8weDUwCgkgID8gX19wZnhfa3RocmVh
ZCsweDEwLzB4MTAKCSAgcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwCgkgIDwvVEFTSz4KCSAg
ZXBfODE6IFBNOiBwYXJlbnQgWzMtMS4xOjEuMV0gb2YgW05vIEJ1czplcF84MV0gc2hvdWxkIG5v
dCBiZSBzbGVlcGluZwoKQmFzZSBvbiB0aGlzIGNhbGwgc3RhY2ssIG15IHJlYWRpbmcgaXM6Cldo
ZW4gdXNiIGRldmljZSBzdGFydCB0byByZXN1bWUsIGl0IGNhbGwgdXZjX3Jlc3VtZSBkaXJlY3Rs
eSwgCmFuZCB0aGVuIHV2Y19yZXN1bWUgd291bGQgY3JlYXRlIGEgbmV3ICJlcCIgZGV2aWNlIGRp
cmVjdGx5LCAgaWdub3JpbmcgcG0ncyBkZXZpY2VfcmVzdW1lIGZvciB1dmNfdmlkZW8gZGV2aWNl
IHRvdGFsbHkgYW5kIHRyaWdnZXIgdGhlIHdhcm4sCgpNb3JlIGxpa2UgYSBjb3Jwb3JhdGlvbiBp
c3N1ZSBiZXR3ZWVuIHV2Yy12aWRlbyBkZXZpY2UgYW5kIFBNIG1vZHVsZS4KCgoKVGhhbmtzIHlv
dXIgdGltZSByZXZpZXdpbmcgdGhlIGlzc3VlL2NvZGUsIGFuZCBzb3JyeSBhYm91dCB0aG9zZSBu
b25zZW5zZSB3aWRlIGd1ZXNzZXMgaW4gY29tbWl0IG1lc3NhZ2UuCkRhdmlkCg==

