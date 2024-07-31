Return-Path: <linux-pm+bounces-11726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CBD9423C6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 02:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6546C1F2475D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 00:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFED73D6D;
	Wed, 31 Jul 2024 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="n2QdBGJs"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C106A41;
	Wed, 31 Jul 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385567; cv=none; b=DIkel5MncCWzgaloYaL3HIqb5rrE78NxSQPaWRaHzhItRLWQ1fJZv+ExLefjnlYxr1oFzM6cMGkroSwtqx3RCi0aDk9Larn6s4lc4atNctDBUP1it0f8FGEFKhJgCAXVU31CpHMAg38mLzGNoIuQ435GIyYk8lH4HvzyrzNIQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385567; c=relaxed/simple;
	bh=IhKVSeDpEIR0WfU3acxx40BZ/jtCd8w63O+9vmbWxPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hBjH+p9JcWbQwitCR25ZfZjAGeZDIAarO0jwwqg06/G/tfpYuYr7XzVeRO9qB5y4Jm/Xx6aye4GkPfumslY4NNGK79XXEgGaMYw8eUYV7yXOs3LvGp5V1EAhBryMP80buLgSQEr2bUGcJ19xWrZY+0KxTaIVigU2ZSXf0BxdIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=n2QdBGJs reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=CdXm5ndIlLZn9vyVZfUjhbWrsMIGQ3uIrPZHyi3mqmA=; b=n
	2QdBGJsxbBBJkQpbxoP8I43gWEDGguDX4dzVr5q+kvOS0nuoJTendYBbcjo03Aap
	/5KRf0b2CJD/7xOghaPCs3bzOet+Rhx4WkudkQStcv9asTkYiWYWzU5NrKQM4XoJ
	0OmVACctIx/1iW+h2P7tDRvazLkRSrKT4WyqVjCpIo=
Received: from 00107082$163.com ( [111.35.189.52] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Wed, 31 Jul 2024 08:25:01 +0800
 (CST)
Date: Wed, 31 Jul 2024 08:25:01 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Xiaojian Du" <xiaojidu@amd.com>
Cc: perry.yuan@amd.com, Alexander.Deucher@amd.com, Li.Meng@amd.com, 
	Mario.Limonciello@amd.com, Xiaojian.Du@amd.com, Xinmei.Huang@amd.com, 
	gautham.shenoy@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	viresh.kumar@linaro.org
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <1d5f4859-6810-355f-3e0e-ed1c9e53c3f4@amd.com>
References: <20240730140111.4491-1-00107082@163.com>
 <1d5f4859-6810-355f-3e0e-ed1c9e53c3f4@amd.com>
X-NTES-SC: AL_Qu2ZAP+Tuk0r5ySRYukZnEYQheY4XMKyuPkg1YJXOp80uCTi6BovcnldDFHX6Ou0Gw2zth6cayd0+tZ3V41fQKtzo5BJhSeNYiA8SSi1pA5r
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2c2569aa.47a.191062d0d40.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v0RehKlmZxRqAA--.62075W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQQtqmVOB302nwACsQ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgRHUsIAoKVGhhbmtzIGZvciB0aGUgcXVpY2sgcmVzcG9uc2UKCkF0IDIwMjQtMDctMzEgMDE6
NDM6NDcsICJYaWFvamlhbiBEdSIgPHhpYW9qaWR1QGFtZC5jb20+IHdyb3RlOgo+SGnCoCBEYXZp
ZCwKPgo+Q1BQQyBmZWF0dXJlIGlzIGVuYWJsZWQgYnkgZGVmYXVsdCBpbiBCSU9TIGZvciBuZXcg
WkVOWCBhcmNoIENQVSwgYW5kIAo+YW1kLXBzdGF0ZSBkcml2ZXIgaXMgZW5hYmxlZCBpbiBuZXcg
bGludXgga2VybmVsLgo+Cj5Gb3IgeW91ciBzeXN0ZW0gLHdoeSBDUFBDIGlzIGRpc2FibGVkLCBp
cyBpdCBmb3IgZGVidWcgb3Igc29tZSBzcGVjaWFsIGNhc2U/CgogSSBkbyBub3QgaGF2ZSBhbnkg
c3BlY2lhbCBwdXJwb3NlLCBpdCBpcyBqdXN0IHRoZSBkZWZhdWx0IEJJT1Mgc2V0dXAgZm9yIG15
IG9sZCBzeXN0ZW0uCgo+Cj5JZiB5b3Ugd2FudCB0byB1c2UgbGVnYWN5IGFjcGkgY3B1IGRyaXZl
ciwgeW91IGNhbiBkaXNhYmxlIGFtZC1wc3RhdGUgCj5kcml2ZXIgbW9kdWxlIGluIHlvdXIgbGlu
dXgga2VybmVsIGNvbmZpZyBmaWxlIGFuZCBjb21waWxlIGEgbmV3IGtlcm5lbC4KPgo+PiBUaG9z
ZSB3YXJuaW5nIG1lc3NhZ2Ugd2FzIGludHJvZHVjZWQgYnkgY29tbWl0Ogo+PiAgIGJmZjdkMTNj
MTkwYWQ5OGNmNGY4NzcxODliMDIyYzc1ZGY0Y2IzODMgKCJjcHVmcmVxOiBhbWQtcHN0YXRlOiBh
ZGQgZGVidWcgbWVzc2FnZSB3aGlsZSBDUFBDIGlzIHN1cHBvcnRlZCBhbmQgZGlzYWJsZWQgYnkg
U0JJT1MpCj4+ICwgd2hpY2ggbWFrZSBzZW5zZS4KPj4KPj4gVGhvc2UgZXJyb3IgbWVzc2FnZSB3
YXMgaW50cm9kdWNlZCBieSBjb21taXQ6Cj4+ICAgOGY4YjQyYzFmY2M5MzlhNzNiNTQ3YjE3MmE5
ZmZjYjY1ZWY0YmY0NyAoImNwdWZyZXE6IGFtZC1wc3RhdGU6IG9wdGltaXplIHRoZSBpbml0aWFs
IGZyZXF1ZW5jeSB2YWx1ZXMgdmVyaWZpY2F0aW9uIikKPj4gLCB3aGVuIENQUEMgaXMgZGlzYWJs
ZWQgYnkgQklPUywgdGhpcyBlcnJvciBtZXNzYWdlIGRvZXMgbm90IG1ha2Ugc2Vuc2UsIGFuZCB0
aGUgZXJyb3IgcmV0dXJuLWNvZGUgd291bGQgYWJvcnQgdGhlIGRyaXZlciByZWdpc3RlcmF0aW9u
LAo+PiBidXQgdGhpcyBiZWhhdmlvciBjb3VsZCBiZSBoYW5kbGVkIGVhcmxpZXIgd2hlbiBkZXRl
Y3RpbmcgQ1BQQyBmZWF0dXJlLgo+Pgo+PiBJIGZlZWwgZm9sbG93aW5nIGNoYW5nZXMgd291bGQg
bWFrZSBhIGNsZWFuIGZpeDogZG8gbm90IHJlZ2lzdGVyIGFtZF9wc3RhdGUgZHJpdmVyIHdoZW4g
Q1BQQyBkaXNhYmxlZCBieSBCSU9TLgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2Ft
ZC1wc3RhdGUuYyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMKPj4gaW5kZXggNjhjNjE2
YjU3MmYyLi5iMDZmYWVhNThmZDQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQt
cHN0YXRlLmMKPj4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYwo+PiBAQCAtMTgz
Nyw4ICsxODM3LDYgQEAgc3RhdGljIGJvb2wgYW1kX2NwcGNfc3VwcG9ydGVkKHZvaWQpCj4+ICAg
ICAgICAgICAqIElmIHRoZSBDUFBDIGZlYXR1cmUgaXMgZGlzYWJsZWQgaW4gdGhlIEJJT1MgZm9y
IHByb2Nlc3NvcnMgdGhhdCBzdXBwb3J0IE1TUi1iYXNlZCBDUFBDLAo+PiAgICAgICAgICAgKiB0
aGUgQU1EIFBzdGF0ZSBkcml2ZXIgbWF5IG5vdCBmdW5jdGlvbiBjb3JyZWN0bHkuCj4+ICAgICAg
ICAgICAqIENoZWNrIHRoZSBDUFBDIGZsYWcgYW5kIGRpc3BsYXkgYSB3YXJuaW5nIG1lc3NhZ2Ug
aWYgdGhlIHBsYXRmb3JtIHN1cHBvcnRzIENQUEMuCj4+IC0gICAgICAgICogTm90ZTogYmVsb3cg
Y2hlY2tpbmcgY29kZSB3aWxsIG5vdCBhYm9ydCB0aGUgZHJpdmVyIHJlZ2lzdGVyYXRpb24gcHJv
Y2VzcyBiZWNhdXNlIG9mCj4+IC0gICAgICAgICogdGhlIGNvZGUgaXMgYWRkZWQgZm9yIGRlYnVn
Z2luZyBwdXJwb3Nlcy4KPgo+QXMgeW91IHNlZSwgaXQgaXMgZm9yIGRlYnVnIHB1cnBvc2UsIGlu
IHNvbWUgY29ybmVyIGNhc2UsIGlmIENQUEMgCj5mZWF0dXJlIGlzIGRpc2FibGVkLCB0aGlzIGRl
YnVnIGluZm8gd2lsbCBoZWxwIHRvIGd1aWRlIHVzZXIgdG8gCj4qcmUtZW5hYmxlKiBpdC4KPgo+
VGFyZ2V0IHN5c3RlbSwgaW5jbHVkaW5nIENQVStiYXNlYm9hcmQrQklPUywgaXMgc3VwcG9zZWQg
dG8gZW5hYmxlIGFuZCAKPnVzZSBDUFBDIGZlYXR1cmUgZm9yIGJldHRlciBQZXJmb3JtYW5jZSBw
ZXIgV2F0dC4KCkkgYWdyZWUgdGhhdCB0aGUgd2FybmluZyBndWlkZSBtYWtlcyB0b3RhbCBzZW5z
ZSwgIGJ1dCAgdGhlICAqZXJyb3JzKiBkb2VzIG5vdCwgd2h5IGJvdGhlciB0cnlpbmcgYW5kIHJl
cG9ydCBlcnJvciB3aGVuIHRoZSBmZWF0dXJlIGlzIGRpc2FibGVkIGJ5IEJJT1MuCgoKPgo+PiAg
ICAgICAgICAgKi8KPj4gICAgICAgICAgaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFU
VVJFX0NQUEMpKSB7Cj4+ICAgICAgICAgICAgICAgICAgaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQo
WDg2X0ZFQVRVUkVfWkVOMSkgfHwgY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9aRU4y
KSkgewo+PiBAQCAtMTg1Niw2ICsxODU0LDcgQEAgc3RhdGljIGJvb2wgYW1kX2NwcGNfc3VwcG9y
dGVkKHZvaWQpCj4+ICAgICAgICAgIGlmICh3YXJuKQo+PiAgICAgICAgICAgICAgICAgIHByX3dh
cm5fb25jZSgiVGhlIENQUEMgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgYnV0IGN1cnJlbnRseSBkaXNh
YmxlZCBieSB0aGUgQklPUy5cbiIKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiUGxlYXNlIGVuYWJsZSBpdCBpZiB5b3VyIEJJT1MgaGFzIHRoZSBDUFBDIG9wdGlv
bi5cbiIpOwo+PiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+TWF5YmUgbmVlZCBhIHBh
aXIgb2YgY3VybHkgYnJhY2UgYWZ0ZXIgdGhpcyAiaWYod2FybikiIGZvciB5b3VyIGNoYW5nZS4K
Pj4gICAgICAgICAgcmV0dXJuIHRydWU7Cj4+ICAgfQo+Pgo+Pgo+Pgo+PiBUaGFua3MKPj4gRGF2
aWQKPj4K

