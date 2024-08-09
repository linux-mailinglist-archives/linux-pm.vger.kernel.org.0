Return-Path: <linux-pm+bounces-12045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429794D0CF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 15:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5661C21C7E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E35193086;
	Fri,  9 Aug 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="LjjwMlUb"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67045174EE4;
	Fri,  9 Aug 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208794; cv=none; b=LCxPL0DKhbZM9eXnoheXA3FT9doohf6eXVnFX8LGEDEcvDswMc7sAg8woWU7zVQqKRDEt76lXoXq6m98DDbhXN2eSuh8bXN0WOqUy0jZtEXTm4uYmfPaZ42WIbMPK2Zud0e4U53hrPC0hpS7J/kVBG5u+bOb/3RLHUD5F2XObHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208794; c=relaxed/simple;
	bh=tQSdVQmZRAO91IjiwENF8c+lBxYJt1wmfSDB3MblAN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=n7rnbHqfflYrE9bHpLurmGy4mXoKlyF+nWOeOKnHkuWSBM3vC60374Vk1+xtddAN6qC+nieSeQD6V3qM5V9KMLtxCXXySYSFbFuwDHLj3tFZglH2pmsPSl0zss+7RMLTINZPY76byAynCAqOfqZyQnw3Em/dTu7F4woPhhH4PjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=LjjwMlUb reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=PwRO6xu/5qD/YQ99cS1voguK/ixceHMQFOsO5djNgFc=; b=L
	jjwMlUbJ/aTWUusiCWY48veOK5o7w2HbfPVybM9+aJ9JULmmcc7M5VbbJG6KItVa
	zA1hI+gTXwccdmZDDVsjZGZDd+FzggCQlrNBA8O1HdR1jb+WO/cnoQ4O9wB/9BqK
	jdFluBFwcoPvPZ8tNXraCpumGzgQu13PvRz2FpXNow=
Received: from 00107082$163.com ( [111.35.189.52] ) by
 ajax-webmail-wmsvr-40-116 (Coremail) ; Fri, 9 Aug 2024 21:06:07 +0800 (CST)
Date: Fri, 9 Aug 2024 21:06:07 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Perry Yuan" <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com, 
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com, 
	Borislav.Petkov@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, 
	Li.Meng@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re:[PATCH RESENT] cpufreq: amd-pstate: add quirk for Ryzen 3000
 series processor
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240809060905.777146-1-perry.yuan@amd.com>
References: <20240809060905.777146-1-perry.yuan@amd.com>
X-NTES-SC: AL_Qu2ZAf6bt08t4SibZ+kXn0oTju85XMCzuv8j3YJeN500pSTr3D8scVZ4LELz8OykEAu2mTGIcQFN8+ZYf6dFcaw7u0kPdV1+k96dY1sQZaXW
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <37587d44.95af.191373f195c.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H4FAFLZmXdITAA--.16127W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0ho2qmWXzmETUwAKsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGksIAoKQXQgMjAyNC0wOC0wOSAxNDowOTowNSwgIlBlcnJ5IFl1YW4iIDxwZXJyeS55dWFuQGFt
ZC5jb20+IHdyb3RlOgo+VGhlIFJ5emVuIDMwMDAgc2VyaWVzIHByb2Nlc3NvcnMgaGF2ZSBiZWVu
IG9ic2VydmVkIGxhY2tpbmcgdGhlCj5ub21pbmFsX2ZyZXEgYW5kIGxvd2VzdF9mcmVxIHBhcmFt
ZXRlcnMgaW4gdGhlaXIgQUNQSSB0YWJsZXMuIFRoaXMKPmFic2VuY2UgY2F1c2VzIGlzc3VlcyB3
aXRoIGxvYWRpbmcgdGhlIGFtZC1wc3RhdGUgZHJpdmVyIG9uIHRoZXNlCj5zeXN0ZW1zLiBJbnRy
b2R1Y2VzIGEgZml4IHRvIHJlc29sdmUgdGhlIGRlcGVuZGVuY3kgaXNzdWUKPmJ5IGFkZGluZyBh
IHF1aXJrIHNwZWNpZmljYWxseSBmb3IgdGhlIFJ5emVuIDMwMDAgc2VyaWVzLgo+Cj5SZXBvcnRl
ZC1ieTogRGF2aWQgV2FuZyA8MDAxMDcwODJAMTYzLmNvbT4KPlNpZ25lZC1vZmYtYnk6IFBlcnJ5
IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4KPi0tLQo+IGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0
YXRlLmMgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAxIGZpbGUgY2hhbmdl
ZCwgMzAgaW5zZXJ0aW9ucygrKQo+Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1w
c3RhdGUuYyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMKPmluZGV4IDY4YzYxNmI1NzJm
Mi4uYjM5MzY1Yjk4MGI5IDEwMDY0NAo+LS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUu
Ywo+KysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYwo+QEAgLTE0Miw2ICsxNDIsMTEg
QEAgc3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWlya19hbWRfN2s2MiA9IHsKPiAJLmxvd2Vz
dF9mcmVxID0gNTUwLAo+IH07Cj4gCj4rc3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWlya19h
bWRfbXRzID0gewo+Kwkubm9taW5hbF9mcmVxID0gMzYwMCwKPisJLmxvd2VzdF9mcmVxID0gNTUw
LAo+K307Cj4rCj4gc3RhdGljIGludCBfX2luaXQgZG1pX21hdGNoZWRfN2s2Ml9iaW9zX2J1Zyhj
b25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCAqZG1pKQo+IHsKPiAJLyoqCj5AQCAtMTU4LDYgKzE2
MywyMSBAQCBzdGF0aWMgaW50IF9faW5pdCBkbWlfbWF0Y2hlZF83azYyX2Jpb3NfYnVnKGNvbnN0
IHN0cnVjdCBkbWlfc3lzdGVtX2lkICpkbWkpCj4gCXJldHVybiAwOwo+IH0KPiAKPitzdGF0aWMg
aW50IF9faW5pdCBkbWlfbWF0Y2hlZF9tdHNfYmlvc19idWcoY29uc3Qgc3RydWN0IGRtaV9zeXN0
ZW1faWQgKmRtaSkKPit7Cj4rCS8qKgo+KwkgKiBtYXRjaCB0aGUgYnJva2VuIGJpb3MgZm9yIHJ5
emVuIDMwMDAgc2VyaWVzIHByb2Nlc3NvciBzdXBwb3J0IENQUEMgVjIKPisJICogYnJva2VuIEJJ
T1MgbGFjayBvZiBub21pbmFsX2ZyZXEgYW5kIGxvd2VzdF9mcmVxIGNhcGFiaWxpdGllcwo+Kwkg
KiBkZWZpbml0aW9uIGluIEFDUEkgdGFibGVzCj4rCSAqLwo+KwlpZiAoY3B1X2ZlYXR1cmVfZW5h
YmxlZChYODZfRkVBVFVSRV9aRU4yKSkgewo+KwkJcXVpcmtzID0gZG1pLT5kcml2ZXJfZGF0YTsK
PisJCXByX2luZm8oIk92ZXJyaWRpbmcgbm9taW5hbCBhbmQgbG93ZXN0IGZyZXF1ZW5jaWVzIGZv
ciAlc1xuIiwgZG1pLT5pZGVudCk7Cj4rCQlyZXR1cm4gMTsKPisJfQo+Kwo+KwlyZXR1cm4gMDsK
Pit9Cj4gc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIGFtZF9wc3RhdGVfcXVpcmtz
X3RhYmxlW10gX19pbml0Y29uc3QgPSB7Cj4gCXsKPiAJCS5jYWxsYmFjayA9IGRtaV9tYXRjaGVk
XzdrNjJfYmlvc19idWcsCj5AQCAtMTY4LDYgKzE4OCwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGRtaV9zeXN0ZW1faWQgYW1kX3BzdGF0ZV9xdWlya3NfdGFibGVbXSBfX2luaXRjb25zdCA9IHsK
PiAJCX0sCj4gCQkuZHJpdmVyX2RhdGEgPSAmcXVpcmtfYW1kXzdrNjIsCj4gCX0sCj4rCXsKPisJ
CS5jYWxsYmFjayA9IGRtaV9tYXRjaGVkX210c19iaW9zX2J1ZywKPisJCS5pZGVudCA9ICJBTUQg
Unl6ZW4gMzAwMCIsCj4rCQkubWF0Y2hlcyA9IHsKPisJCQlETUlfTUFUQ0goRE1JX1BST0RVQ1Rf
TkFNRSwgIkI0NTBNIE1PUlRBUiBNQVggKE1TLTdCODkpIiksCj4rCQkJRE1JX01BVENIKERNSV9C
SU9TX1JFTEVBU0UsICIwNi8xMC8yMDIwIiksCj4rCQkJRE1JX01BVENIKERNSV9CSU9TX1ZFUlNJ
T04sICI1LjE0IiksCj4rCQl9LAo+KwkJLmRyaXZlcl9kYXRhID0gJnF1aXJrX2FtZF9tdHMsCj4r
CX0sCj4gCXt9Cj4gfTsKPiBNT0RVTEVfREVWSUNFX1RBQkxFKGRtaSwgYW1kX3BzdGF0ZV9xdWly
a3NfdGFibGUpOwo+LS0gCj4yLjM0LjEKCgpJIHRyaWVkIHRoaXMgcGF0Y2ggb24gNi4xMS4wLXJj
Miwgc2FkbHkgdGhpcyBjb25maWcgZG9lcyBub3QgbWF0Y2ggbXkgc3lzdGVtIChCSU9TKS4KQWZ0
ZXIgc29tZSBjb3JyZWN0aW9uLCBJIGNvbmZpcm0gZm9sbG93aW5nIGNvbmZpZ3VyYXRpb24gbWF0
Y2hlcyBteSBCSU9TOgoKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBhbWRfcHN0
YXRlX3F1aXJrc190YWJsZVtdIF9faW5pdGNvbnN0ID0gewogICAgICAgIHsKICAgICAgICAgICAg
ICAgIC5jYWxsYmFjayA9IGRtaV9tYXRjaGVkXzdrNjJfYmlvc19idWcsCkBAIC0xNjgsNiArMTkw
LDE2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBhbWRfcHN0YXRlX3F1aXJr
c190YWJsZVtdIF9faW5pdGNvbnN0ID0gewogICAgICAgICAgICAgICAgfSwKICAgICAgICAgICAg
ICAgIC5kcml2ZXJfZGF0YSA9ICZxdWlya19hbWRfN2s2MiwKICAgICAgICB9LAorICAgICAgIHsK
KyAgICAgICAgICAgICAgIC5jYWxsYmFjayA9IGRtaV9tYXRjaGVkX210c19iaW9zX2J1ZywKKyAg
ICAgICAgICAgICAgIC5pZGVudCA9ICJBTUQgUnl6ZW4gMzAwMCIsCisgICAgICAgICAgICAgICAu
bWF0Y2hlcyA9IHsKKyAgICAgICAgICAgICAgICAgICAgICAgRE1JX01BVENIKERNSV9QUk9EVUNU
X05BTUUsICJNUy03Qjg5IiksCisgICAgICAgICAgICAgICAgICAgICAgIERNSV9NQVRDSChETUlf
QklPU19SRUxFQVNFLCAiNS4xNCIpLAorICAgICAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0go
RE1JX0JJT1NfVkVSU0lPTiwgIjIuODAiKSwKKyAgICAgICAgICAgICAgIH0sCisgICAgICAgICAg
ICAgICAuZHJpdmVyX2RhdGEgPSAmcXVpcmtfYW1kX210cywKKyAgICAgICB9LAogICAgICAgIHt9
CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShkbWksIGFtZF9wc3RhdGVfcXVpcmtzX3RhYmxlKTsK
CkFuZCB3aXRoIHRoaXMgY2hhbmdlLCBteSBzeXN0ZW0gYm9vdHMgd2l0aCBubyBhbWRfcHN0YXRl
IGVycm9yLiAKVGhlIG9sZCB3YXJuaW5nIGFuZCBhIG5ldyBpbmZvIHNob3cgdXAgdGhvdWdoLCBJ
IGd1ZXNzIHRoYXQgaXMgYWNjZXB0YWJsZT8KCltGcmkgQXVnICA5IDE5OjM1OjI5IDIwMjRdIGFt
ZF9wc3RhdGU6IFRoZSBDUFBDIGZlYXR1cmUgaXMgc3VwcG9ydGVkIGJ1dCBjdXJyZW50bHkgZGlz
YWJsZWQgYnkgdGhlIEJJT1MuCiAgICAgICAgICAgICAgICAgICAgICAgICAgIFBsZWFzZSBlbmFi
bGUgaXQgaWYgeW91ciBCSU9TIGhhcyB0aGUgQ1BQQyBvcHRpb24uCltGcmkgQXVnICA5IDE5OjM1
OjI5IDIwMjRdIGFtZF9wc3RhdGU6IE92ZXJyaWRpbmcgbm9taW5hbCBhbmQgbG93ZXN0IGZyZXF1
ZW5jaWVzIGZvciBBTUQgUnl6ZW4gMzAwMAoKClRoaXMgcGF0Y2ggY29uZnVzZXMgbWUgYSBsaXR0
bGUsCkkgZG8gbm90IHNlZSBhbnkgYm91bmQgYmV0d2VlbiBDUFUgaWRlbnRpdHkgIkFNRCBSeXpl
biAzMDAwIiBhbmQgbXkgQklPUyBETUlzLAogaXQgbWFrZSBubyBzZW5zZSB0byBtZSB0byBpbmZl
ciB0aGUgQ1BVIGlkZW50aXR5IGp1c3QgYnkgc29tZSBCSU9TIERNSXMuIApXaGF0IGlmIGFub3Ro
ZXIgQU1EIENQVSB3aXRoIGRpZmZlcmVudCBjcHUgZnJlcXVlbmN5IHJhbmdlIGluc3RhbGxlZCBv
biB0aGUgc2FtZSBCSU9TIGFzIG1pbmU/CihJIGd1ZXNzIGN1cnJlbnQgYXNzdW1wdGlvbiBpcyB0
aGF0IG15IEJJT1MgaXMgd2F5IHRvbyBvbGQgYW5kIHdlaXJkLCB0aGUgcG9zc2liaWxpdHkgb2Yg
IndoYXQgaWYiIG1lbnRpb25lZCBhYm92ZSBpcyB2ZXJ5IGxvdz8pCgoKQW55d2F5LCBhZnRlciBw
YXRjaGluZyBteSBzeXN0ZW0gd2l0aCBhIHByb3BlciBxdWlyaywKSSBkb3NlIG5vdCBub3RpY2Ug
YW55IHNpZ25pZmljYW50IENQVSBwZXJmb3JtYW5jZSBjaGFuZ2VzLCAgeWV0LiAoTXkga2VybmVs
IGJ1aWxkIHRpbWUgZG9zZSBub3QgY2hhbmdlIG11Y2gsIGF0IGxlYXN0KQpBbmQgaXQgc2VlbXMg
dG8gbWUgdGhhdCB0aGUgYW1kX3BzdGF0ZSBtb2R1bGUgaXMgYWN0aXZlOgoKJCBscyAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAvKmFtZCogLWwKLXItLXItLXItLSAxIHJv
b3Qgcm9vdCA0MDk2IEF1ZyAgOSAyMDo0NiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVx
L3BvbGljeTAvYW1kX3BzdGF0ZV9oaWdoZXN0X3BlcmYKLXItLXItLXItLSAxIHJvb3Qgcm9vdCA0
MDk2IEF1ZyAgOSAyMDo0NiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHVmcmVxL3BvbGljeTAv
YW1kX3BzdGF0ZV9od19wcmVmY29yZQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgQXVnICA5
IDIwOjQ2IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvcG9saWN5MC9hbWRfcHN0YXRl
X2xvd2VzdF9ub25saW5lYXJfZnJlcQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYgQXVnICA5
IDIwOjQ2IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdWZyZXEvcG9saWN5MC9hbWRfcHN0YXRl
X21heF9mcmVxCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5NiBBdWcgIDkgMjA6NDYgL3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvY3B1ZnJlcS9wb2xpY3kwL2FtZF9wc3RhdGVfcHJlZmNvcmVfcmFu
a2luZwoKICQgY3B1cG93ZXIgZnJlcXVlbmN5LWluZm8gICMgd2hlbiBteSBzeXN0ZW0gaXMgaWRs
ZQphbmFseXppbmcgQ1BVIDA6CiAgZHJpdmVyOiBhbWQtcHN0YXRlLWVwcAogIENQVXMgd2hpY2gg
cnVuIGF0IHRoZSBzYW1lIGhhcmR3YXJlIGZyZXF1ZW5jeTogMAogIENQVXMgd2hpY2ggbmVlZCB0
byBoYXZlIHRoZWlyIGZyZXF1ZW5jeSBjb29yZGluYXRlZCBieSBzb2Z0d2FyZTogMAogIG1heGlt
dW0gdHJhbnNpdGlvbiBsYXRlbmN5OiAgQ2Fubm90IGRldGVybWluZSBvciBpcyBub3Qgc3VwcG9y
dGVkLgogIGhhcmR3YXJlIGxpbWl0czogNTUwIE1IeiAtIDMuOTEgR0h6CiAgYXZhaWxhYmxlIGNw
dWZyZXEgZ292ZXJub3JzOiBwZXJmb3JtYW5jZSBwb3dlcnNhdmUKICBjdXJyZW50IHBvbGljeTog
ZnJlcXVlbmN5IHNob3VsZCBiZSB3aXRoaW4gNTUwIE1IeiBhbmQgMy45MSBHSHouCiAgICAgICAg
ICAgICAgICAgIFRoZSBnb3Zlcm5vciAicG93ZXJzYXZlIiBtYXkgZGVjaWRlIHdoaWNoIHNwZWVk
IHRvIHVzZQogICAgICAgICAgICAgICAgICB3aXRoaW4gdGhpcyByYW5nZS4KICBjdXJyZW50IENQ
VSBmcmVxdWVuY3k6IFVuYWJsZSB0byBjYWxsIGhhcmR3YXJlIAogIGN1cnJlbnQgQ1BVIGZyZXF1
ZW5jeTogNTUwIE1IeiAoYXNzZXJ0ZWQgYnkgY2FsbCB0byBrZXJuZWwpCiAgYm9vc3Qgc3RhdGUg
c3VwcG9ydDoKICAgIFN1cHBvcnRlZDogeWVzCiAgICBBY3RpdmU6IG5vCgokIGNwdXBvd2VyIGZy
ZXF1ZW5jeS1pbmZvICAjIHdoZW4gbXkgc3l0ZW0gaXMgYnVzeSBidWlsZGluZyBrZXJuZWwKYW5h
bHl6aW5nIENQVSAwOgogIGRyaXZlcjogYW1kLXBzdGF0ZS1lcHAKICBDUFVzIHdoaWNoIHJ1biBh
dCB0aGUgc2FtZSBoYXJkd2FyZSBmcmVxdWVuY3k6IDAKICBDUFVzIHdoaWNoIG5lZWQgdG8gaGF2
ZSB0aGVpciBmcmVxdWVuY3kgY29vcmRpbmF0ZWQgYnkgc29mdHdhcmU6IDAKICBtYXhpbXVtIHRy
YW5zaXRpb24gbGF0ZW5jeTogIENhbm5vdCBkZXRlcm1pbmUgb3IgaXMgbm90IHN1cHBvcnRlZC4K
ICBoYXJkd2FyZSBsaW1pdHM6IDU1MCBNSHogLSAzLjkxIEdIegogIGF2YWlsYWJsZSBjcHVmcmVx
IGdvdmVybm9yczogcGVyZm9ybWFuY2UgcG93ZXJzYXZlCiAgY3VycmVudCBwb2xpY3k6IGZyZXF1
ZW5jeSBzaG91bGQgYmUgd2l0aGluIDU1MCBNSHogYW5kIDMuOTEgR0h6LgogICAgICAgICAgICAg
ICAgICBUaGUgZ292ZXJub3IgInBvd2Vyc2F2ZSIgbWF5IGRlY2lkZSB3aGljaCBzcGVlZCB0byB1
c2UKICAgICAgICAgICAgICAgICAgd2l0aGluIHRoaXMgcmFuZ2UuCiAgY3VycmVudCBDUFUgZnJl
cXVlbmN5OiBVbmFibGUgdG8gY2FsbCBoYXJkd2FyZQogIGN1cnJlbnQgQ1BVIGZyZXF1ZW5jeTog
My44OSBHSHogKGFzc2VydGVkIGJ5IGNhbGwgdG8ga2VybmVsKQogIGJvb3N0IHN0YXRlIHN1cHBv
cnQ6CiAgICBTdXBwb3J0ZWQ6IHllcwogICAgQWN0aXZlOiBubwoKCkZZSQpBbmQgdGhhbmtzIGZv
ciB5b3VyIHN1cHBvcnQgdGFpbG9yaW5nIGZvciBteSBzeXN0ZW1+IQpEYXZpZAoKIAoKCg==

