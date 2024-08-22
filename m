Return-Path: <linux-pm+bounces-12706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB4395AFD9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B831F259EE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF616A955;
	Thu, 22 Aug 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="EOpbxSfF"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE4013A894;
	Thu, 22 Aug 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313890; cv=none; b=lpVpfWSCwDdp0+tiAWlPkGREI1K5qgP4k3rmAH3+Kn1GVyx7QLC6UDMKUSiTF0ccIxVAQHFjG7L463r4PRJaFC1kyG6T+WlaBNXXv4eAbLPJ/zHSMF+sW7ivn+uggUqf6V5HDmYbVkS2wYRkPA22MqCpQtZ1K5LNe+SSUdF+XAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313890; c=relaxed/simple;
	bh=mtfAH7WJEM4qDO5+7ui9nXqVX8myONOOKLzVM7sJlUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Ng/fxXHABzfQkGzhRgpgVgYgx7Tb+nRgPc96yulMkl0/7iORr/DSoaCfx+rv9rTdsysl/KC07G99S/IU1dDgN+Ywl6P5Zgu+pA8OfNLflOE7nd0IXMt7/3OcffwsMBqsRejsrfqP4WOhxSP1estszpz1I6KaXo5/XYr51XjSN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=EOpbxSfF reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=3r7uPPDvYh5rtQa6odadvQEmyUCgXOKh6UGtUbsk1l8=; b=E
	OpbxSfFjOn6V1TfmCpsRrzbgIZWEdD75VJT6LYrLYmSFz3y1rxzqXhTDuaDid4IG
	1L4aCrV1COhemJbP0R1k8AT/EJddWE4ryEJiIUho2XPQlWae8yDiUGFea0YCD8xs
	p1zHdGMhWuzTo2+7+uCjsldtpciJjJeCEM6Ek3T1/A=
Received: from 00107082$163.com ( [111.35.190.113] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Thu, 22 Aug 2024 16:03:45 +0800
 (CST)
Date: Thu, 22 Aug 2024 16:03:45 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	"Du, Xiaojian" <Xiaojian.Du@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, 
	"Limonciello, Mario" <Mario.Limonciello@amd.com>, 
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	"Huang, Ray" <Ray.Huang@amd.com>, 
	"Petkov, Borislav" <Borislav.Petkov@amd.com>, 
	"Huang, Shimmer" <Shimmer.Huang@amd.com>, 
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH RESENT] cpufreq: amd-pstate: add quirk for Ryzen 3000
 series processor
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZsbT3WIkz5kTpfXx@BLRRASHENOY1.amd.com>
References: <20240809060905.777146-1-perry.yuan@amd.com>
 <37587d44.95af.191373f195c.Coremail.00107082@163.com>
 <b9899fcf-2774-b270-900a-72c7e1f10dfa@amd.com>
 <DM4PR12MB5136B5BA5DEE9BE7A27F44B9F18F2@DM4PR12MB5136.namprd12.prod.outlook.com>
 <38b23ce.4a8c.191789c4356.Coremail.00107082@163.com>
 <ZsbT3WIkz5kTpfXx@BLRRASHENOY1.amd.com>
X-NTES-SC: AL_Qu2ZBv+avEAp4yCZY+kXn0oTju85XMCzuv8j3YJeN500oCTz4SQJRllqDFnZwOCSJiSxlj6YTzZT7d1YcrdnYqQpYCfYii+1FbmtL96X7aNO
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <700df4cb.6db3.191791cef04.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3XyPi8MZmvE0IAA--.3388W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwFDqmXAnVvaYAACsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLCAKCkkganVzdCB1cGdyYWRlIG15IEJJT1MsIG5vdyB0aGUgZXJyb3IgbWVzc2FnZSBpcyBn
b25lKHdpdGhvdXQgcXVpcmspLCBJIG9ubHkgaGF2ZSBmb2xsb3dpbmcgd2FybmluZzoKCltUaHUg
QXVnIDIyIDE1OjEyOjAyIDIwMjRdIGFtZF9wc3RhdGU6IFRoZSBDUFBDIGZlYXR1cmUgaXMgc3Vw
cG9ydGVkIGJ1dCBjdXJyZW50bHkgZGlzYWJsZWQgYnkgdGhlIEJJT1MuCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFBsZWFzZSBlbmFibGUgaXQgaWYgeW91ciBCSU9TIGhhcyB0aGUgQ1BQQyBv
cHRpb24uCgoKTm8gc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UgY2hhbmdlcyBub3RpY2VkIHlldDoK
CkNsZWFuIGtlcm5lbCBkZWIgcGFja2FnZSBidWlsZCB0aW1lIGlzIGFib3V0IHRoZSBzYW1lIGFz
IGJlZm9yZToKJCB0aW1lIG1ha2UgZGViLXBrZyAgLWo2CgpyZWFsCTM4bTUwLjk3N3MKdXNlcgky
MTdtNS45NzBzCnN5cwkxOW01NS4xNjRzCgoKQW5kIGFtZC1wc3RhdGUgc2VlbXMgd29ya2luZyAo
bW9yZSBhY2N1cmF0ZSB0aGFuIHF1aXJrcz8pOgoKJCBjYXQgIC9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2NwdWZyZXEvcG9saWN5MC8qYW1kKgoxNjYKZW5hYmxlZAoxNzQwMDAwCjM5MDUwMDAKMTc2
CgokIGNwdXBvd2VyIGZyZXF1ZW5jeS1pbmZvCmFuYWx5emluZyBDUFUgMDoKICBkcml2ZXI6IGFt
ZC1wc3RhdGUtZXBwCiAgQ1BVcyB3aGljaCBydW4gYXQgdGhlIHNhbWUgaGFyZHdhcmUgZnJlcXVl
bmN5OiAwCiAgQ1BVcyB3aGljaCBuZWVkIHRvIGhhdmUgdGhlaXIgZnJlcXVlbmN5IGNvb3JkaW5h
dGVkIGJ5IHNvZnR3YXJlOiAwCiAgbWF4aW11bSB0cmFuc2l0aW9uIGxhdGVuY3k6ICBDYW5ub3Qg
ZGV0ZXJtaW5lIG9yIGlzIG5vdCBzdXBwb3J0ZWQuCiAgaGFyZHdhcmUgbGltaXRzOiA1NTAgTUh6
IC0gMy45MSBHSHoKICBhdmFpbGFibGUgY3B1ZnJlcSBnb3Zlcm5vcnM6IHBlcmZvcm1hbmNlIHBv
d2Vyc2F2ZQogIGN1cnJlbnQgcG9saWN5OiBmcmVxdWVuY3kgc2hvdWxkIGJlIHdpdGhpbiA1NTAg
TUh6IGFuZCAzLjkxIEdIei4KICAgICAgICAgICAgICAgICAgVGhlIGdvdmVybm9yICJwb3dlcnNh
dmUiIG1heSBkZWNpZGUgd2hpY2ggc3BlZWQgdG8gdXNlCiAgICAgICAgICAgICAgICAgIHdpdGhp
biB0aGlzIHJhbmdlLgogIGN1cnJlbnQgQ1BVIGZyZXF1ZW5jeTogVW5hYmxlIHRvIGNhbGwgaGFy
ZHdhcmUKICBjdXJyZW50IENQVSBmcmVxdWVuY3k6IDMuOTAgR0h6IChhc3NlcnRlZCBieSBjYWxs
IHRvIGtlcm5lbCkKICBib29zdCBzdGF0ZSBzdXBwb3J0OgogICAgU3VwcG9ydGVkOiB5ZXMKICAg
IEFjdGl2ZTogbm8KCgpBbmQgdGhhbmtzIGZvciBhbGwgeW91ciBzdXBwb3J0ISEhCgpCVFcsIGFi
b3V0IHRoZSBxdWlya3MsIEkgc3RpbGwgdGhpbmsgdGhlIGRtaS1tYXRjaCBpcyBub3QgZW5vdWdo
LCAKQ1BVIGZhbWlseSBtb2RlbCBzaG91bGQgYWxzbyBiZSBjaGVja2VkIHRvIGRldGVybWluZSBh
IGFjY3VyYXRlIHN0YXRpYyBxdWlya19lbnRyeS4KIApEYXZpZAoKCgpBdCAyMDI0LTA4LTIyIDEz
OjU5OjU3LCAiR2F1dGhhbSBSLiBTaGVub3kiIDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPiB3cm90
ZToKPkhlbGxvIERhdmlkLAo+Cj5PbiBUaHUsIEF1ZyAyMiwgMjAyNCBhdCAwMTo0MzoxMlBNICsw
ODAwLCBEYXZpZCBXYW5nIHdyb3RlOgo+PiBIaSwgCj4+ID4KPj4gVGhhbmtzIGZvciB0aGUgaW5m
b3JtYXRpb24uICAgKEkgZGlkIGNoYW5nZSBteSBCSU9TJ3MgQ1BQQyBjb25maWcgZnJvbSAiYXV0
byIgdG8gImVuYWJsZSIsIGJ1dCBlcnJvciBtZXNzYWdlIHN0aWxsLikKPj4gQnV0IGFjY29yZGlu
ZyB0byAgIGFub3RoZXIgbWFpbCBmcm9tIGdhdXRoYW0uc2hlbm95QGFtZC5jb20sICBteSB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgbXkgQ1BVKEFNRCBSeXplbiAzIDMxMDAgNC1Db3JlIFByb2Nlc3Nv
cikgZG9lcyBub3QgaGF2ZSB0aGlzIENQUEMgZmVhdHVyZSwgIHdvdWxkIHVwZ3JhZGUgbXkgQklP
UyByZWFsbHkgaGVscD8KPj4gYGBgCj4KPlRvIGNsYXJpZnksCj4KPlRoZXJlIGFyZSB0d28gd2F5
cyBpbiB3aGljaCB0aGUgT1MgY2FuIGNvbW11bmljYXRlIGl0cyBDUFBDCj5yZXF1aXJlbWVudHMg
d2l0aCB0aGUgcGxhdGZvcm0gZmlybXdhcmUuCj4KPjEuIFZpYSB0aGUgZm9sbG93aW5nIENQUEMg
TVNScwo+Cj4jZGVmaW5lIE1TUl9BTURfQ1BQQ19DQVAxCQkweGMwMDEwMmIwCj4jZGVmaW5lIE1T
Ul9BTURfQ1BQQ19FTkFCTEUJCTB4YzAwMTAyYjEKPiNkZWZpbmUgTVNSX0FNRF9DUFBDX0NBUDIJ
CTB4YzAwMTAyYjIKPiNkZWZpbmUgTVNSX0FNRF9DUFBDX1JFUQkJMHhjMDAxMDJiMwo+I2RlZmlu
ZSBNU1JfQU1EX0NQUENfU1RBVFVTCQkweGMwMDEwMmI0Cj4KPjIuIFZpYSB0aGUgc2hhcmVkIG1l
bW9yeSBtZWNoYW5pc20uCj4KPgo+VGhlIHByZXNlbmNlIG9mIHRoZSBDUFBDIE1TUnMgaXMgaW5k
aWNhdGVkIHZpYSBYODZfRkVBVFVSRV9DUFBDIChDUFVJRAo+MHg4MDAwMDAwOC5FQlhbMjddKS4g
SWYgYXZhaWxhYmxlLCB0aGUgYW1kLXBzdGF0ZSBkcml2ZXIgcHJlZmVycyB0aGF0Cj5vdmVyIHRo
ZSBzaGFyZWQtbWVtb3J5IG1lY2hhbmlzbS4KPgo+U28gdGhlIHRoZSBmb2xsb3dpbmcgd2Fybmlu
ZyBhcmUgaW50ZW5kZWQgb25seSBmb3IgcGxhdGZvcm1zIHRoYXQgYXJlCj5rbm93biB0byBoYXZl
IHRoZSBNU1Igc3VwcG9ydCwgbm90IGZvciB0aGUgcGxhdGZvcm1zIHdoaWNoIGRvbid0IGhhdmUK
PnRoZSBNU1Igc3VwcG9ydC4KPgo+IlRoZSBDUFBDIGZlYXR1cmUgaXMgc3VwcG9ydGVkIGJ1dCBj
dXJyZW50bHkgZGlzYWJsZWQgYnkgdGhlIEJJT1MuCj5QbGVhc2UgZW5hYmxlIGl0IGlmIHlvdXIg
QklPUyBoYXMgdGhlIENQUEMgb3B0aW9uIgo+Cj5Zb3VyIHBsYXRmb3JtIGhhcyBDUFBDIGZlYXR1
cmUgKGV2aWRlbnQgZnJvbSB0aGUgZmFjdCB0aGF0IGFtZC1wc3RhdGUKPndvcmtlZCBmb3IgeW91
IHdpdGggdGhlIEJJT1MgcXVpcmsgcGF0Y2gpLCBhbmQgdGhlIGFtZC1wc3RhdGUgZHJpdmVyIGNh
bgo+d29yayBqdXN0IGFzIHdlbGwgdXNpbmcgdGhlIHNoYXJlZC1tZW1vcnkgbWVjaGFuaXNtICgy
IGFib3ZlKSBhcyBsb25nCj5hcyB5b3VyIEJJT1Mgc3VwcG9ydHMgQ1BQQyB2MyAod2hpY2ggYWR2
ZXJ0aXNlcyB0aGUgbm9taW5hbCBmcmVxdWVuY3kKPmluIGFkZGl0aW9uIHRvIHRoZSBub21pbmFs
IHBlcmYpLgo+Cj5UaGUgY3VycmVudCB2ZXJzaW9uIG9mIHRoZSBCSU9TIHRoYXQgeW91IGFyZSBy
dW5uaW5nIGRvZXNuJ3Qgc2VlbSB0bwo+c3VwcG9ydCBDUFBDIHYzLCB3aGljaCBpcyB3aHkgdGhl
IGFtZC1wc3RhdGUgZHJpdmVyIHdvbid0IHdvcmsKPm91dC1vZi1ib3guIFRoaXMgaXMgd2h5IFhp
YW9qaWFuIHJlY29tbWVuZGVkIHVwZ3JhZGluZyB0aGUgQklPUyB0byB0aGUKPmxhdGVzdCB2ZXJz
aW9uLgo+Cj4KPj4gCj4+IEFueXdheSwgSSB3aWxsIGdpdmUgQklPUyB1cGdyYWRpbmcgIGEgdHJ5
Lgo+Cj5QbGVhc2UgZG8hCj4KPj4gCj4+ID5JZiB0aGlzIGlzc3VlIGlzIGZpeGVkIGluIEJJT1Ms
IG5vIG5lZWQgdG8gbW9kaWZ5IHRoZSB1cHN0cmVhbSBrZXJuZWwgY29kZSwgcmlnaHQ/Cj4+IAo+
PiBJIHRoaW5rICwgZXZlbiB3aGVuIHVwZ3JhZGluZyBCSU9TIHdvdWxkIG5vdCBoZWxwLCB0aGUg
cXVpcmsganVzdCBmb3IgbXkgc3lzdGVtIGlzIG5vdCB3b3J0aCBiZSBpbiBrZXJuZWwgOikuLi4u
Li4KPj4KPgo+RmFpciBwb2ludC4gSG93ZXZlciwgaW4gY2FzZSB5b3UgcHJlZmVyIHRvIHVzZSBh
bWQtcHN0YXRlLCBrbm93IHRoYXQKPnRoaXMgaXMgb25lIHdheSBvZiBlbmFibGluZyBpdCwgaWYg
dGhlIEJJT1MgdXBncmFkZSBkb2Vzbid0IGhlbHAuCj4KPj4gCj4+IFRoYW5rcwo+PiBEYXZpZAo+
Cj4tLQo+VGhhbmtzIGFuZCBSZWdhcmRzCj5nYXV0aGFtLgo=

