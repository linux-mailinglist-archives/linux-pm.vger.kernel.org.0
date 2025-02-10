Return-Path: <linux-pm+bounces-21616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C1DA2E289
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 04:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59082165703
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83DB53363;
	Mon, 10 Feb 2025 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcEobmTx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614B208D7;
	Mon, 10 Feb 2025 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739157257; cv=none; b=Cs0/nXF9MjQrUoY/XXlelROYOYfBFqGNHvmNSoYRx+eLqojrTCWVxfX/D4B4mK7/VoIdhsDI6eOtZZHXX3tAAW5V6L+LtuvfrxRdrWHw7ndee90Z88DPJ8fXKLj/0ZyWsuDWyBMngQ8cCDAhJXdvVERAYIHDgpRLXTVnGUkHTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739157257; c=relaxed/simple;
	bh=+hRLk3wq1Ach6bYXBDtHx/lK25WdCHLmAdZQfxFj3yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aLYPHs251tgk4BLaug9WSekDNANsctcHm5GbMxNBS7ryBdrRWUMOYXIHNhdAgVurSIj+RGHf2W/AWDclwmsv95ewfSim6fD/8163KsvyivbXvFZYlypTw4GxeMymgzvco3ki1tcsqC1L1klkXZALIxePtNsRIfJrS73D0LbEpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcEobmTx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739157255; x=1770693255;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+hRLk3wq1Ach6bYXBDtHx/lK25WdCHLmAdZQfxFj3yk=;
  b=OcEobmTx/u3oXtsOfqaN7i0W8TlALOfjrx3yT9TC/Lo7B8eWwLflr6q9
   lCzuFRFcmDZQ9KCK8pUBxRosbeQF+YbhEpBrWZ/2hjbw2ash+kuUfR7w+
   yfkoj1EL4K19eRkm7G6bBKfgmHz8ZuJNd+BiP1L68xhMHgJMXQfdaS28p
   5VCaDQwODIW0wqDujTVRvZtnN5UUpceJjyLxnig69nReo4MkYBpbZP6EX
   m2Sjwm/poadpITGmyLHCkT1H1HamKngnDvKQhrlSp/Nj+wfcQuIz6nCUw
   HH5lhlhPKB5eNwk30TmwZqXtgjPh0SA5vmPodrVH/snZ36pnOj7VXprjx
   w==;
X-CSE-ConnectionGUID: wOwpdDUTRaKkiP6zh4mP3Q==
X-CSE-MsgGUID: BHdbCZnxQ+GmBnuzIMLrHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="51117623"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="51117623"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 19:14:15 -0800
X-CSE-ConnectionGUID: orA5tfXlQx+pmgar41fSVg==
X-CSE-MsgGUID: ux1F5B2rS3OwlXeMPZJYrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117272119"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 19:14:15 -0800
Message-ID: <73fa23f76f5de138307ec9733bab14408baee78c.camel@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Make it possible to avoid
 enabling CAS
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,  Zhang Rui <rui.zhang@intel.com>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>
Date: Sun, 09 Feb 2025 19:14:14 -0800
In-Reply-To: <CAJZ5v0jytAtj_rDSz52OznCNV5Wo3hb0bjXCUR+ox99YdSxJ_Q@mail.gmail.com>
References: <2781262.mvXUDI8C0e@rjwysocki.net>
	 <CAJZ5v0jytAtj_rDSz52OznCNV5Wo3hb0bjXCUR+ox99YdSxJ_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTAyLTA3IGF0IDEzOjU1ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBNb24sIEphbiAyNywgMjAyNSBhdCAzOjA34oCvUE0gUmFmYWVsIEouIFd5c29ja2kg
PHJqd0Byand5c29ja2kubmV0Pgo+IHdyb3RlOgo+ID4gCj4gPiBGcm9tOiBSYWZhZWwgSi4gV3lz
b2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+Cj4gPiAKPiA+IENhcGFjaXR5LWF3YXJl
IHNjaGVkdWxpbmcgKENBUykgaXMgZW5hYmxlZCBieSBkZWZhdWx0IGJ5Cj4gPiBpbnRlbF9wc3Rh
dGUgb24KPiA+IGh5YnJpZCBzeXN0ZW1zIHdpdGhvdXQgU01ULCBidXQgaW4gc29tZSB1c2FnZSBz
Y2VuYXJpb3MgaXQgbWF5IGJlCj4gPiBtb3JlCj4gPiBhdHRyYWN0aXZlIHRvIHBsYWNlIHRhc2tz
IGZvciBtYXhpbXVtIENQVSBwZXJmb3JtYW5jZSByZWdhcmRsZXNzIG9mCj4gPiB0aGUKPiA+IGV4
dHJhIGNvc3QgaW4gdGVybXMgb2YgZW5lcmd5LCB3aGljaCBpcyB0aGUgY2FzZSBvbiBzdWNoIHN5
c3RlbXMKPiA+IHdoZW4KPiA+IENBUyBpcyBub3QgZW5hYmxlZCwgc28gaW50cm9kdWNlIGEgY29t
bWFuZCBsaW5lIG9wdGlvbiB0byBmb3JiaWQKPiA+IGludGVsX3BzdGF0ZSB0byBlbmFibGUgQ0FT
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lz
b2NraUBpbnRlbC5jb20+Cj4gCj4gU3Jpbml2YXMsCj4gCj4gQW55IGNvbmNlcm5zIG9yIGNvbW1l
bnRzPwo+IAoKTm8uCgogICAgQWNrZWQtYnk6U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMu
cGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+Cgo+ID4gLS0tCj4gPiDCoERvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0IHzCoMKgwqAgMyArKysKPiA+IMKgRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9pbnRlbF9wc3RhdGUucnN0wqDCoCB8wqDCoMKgIDMg
KysrCj4gPiDCoGRyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCA5ICsrKysrKysrKwo+ID4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDE1IGluc2VydGlvbnMoKykKPiA+IAo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQKPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0Cj4gPiBAQCAtMjI5NSw2ICsyMjk1LDkgQEAKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGVyX2NwdV9w
ZXJmX2xpbWl0cwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgQWxsb3cgcGVyLWxvZ2ljYWwtQ1BVIFAtU3RhdGUgcGVyZm9ybWFuY2UKPiA+IGNv
bnRyb2wgbGltaXRzIHVzaW5nCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjcHVmcmVxIHN5c2ZzIGludGVyZmFjZQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5vX2Nhcwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEbyBub3QgZW5hYmxlIGNhcGFj
aXR5LWF3YXJlIHNjaGVkdWxpbmcKPiA+IChDQVMpIG9uCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh5YnJpZCBzeXN0ZW1zCj4gPiAKPiA+IMKg
wqDCoMKgwqDCoMKgIGludHJlbWFwPcKgwqDCoMKgwqDCoCBbWDg2LTY0LEludGVsLUlPTU1VLEVB
UkxZXQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBv
bsKgwqDCoMKgwqAgZW5hYmxlIEludGVycnVwdCBSZW1hcHBpbmcKPiA+IChkZWZhdWx0KQo+ID4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9pbnRlbF9wc3RhdGUucnN0Cj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2ludGVsX3BzdGF0ZS5yc3QKPiA+IEBA
IC02OTYsNiArNjk2LDkgQEAKPiA+IMKgwqDCoMKgwqDCoMKgIFVzZSBwZXItbG9naWNhbC1DUFUg
UC1TdGF0ZSBsaW1pdHMgKHNlZSBgQ29vcmRpbmF0aW9uIG9mIFAtCj4gPiBzdGF0ZQo+ID4gwqDC
oMKgwqDCoMKgwqAgTGltaXRzYF8gZm9yIGRldGFpbHMpLgo+ID4gCj4gPiArYGBub19jYXNgYAo+
ID4gK8KgwqDCoMKgwqDCoCBEbyBub3QgZW5hYmxlIGNhcGFjaXR5LWF3YXJlIHNjaGVkdWxpbmcg
KENBUykgd2hpY2ggaXMKPiA+IGVuYWJsZWQgYnkKPiA+ICvCoMKgwqDCoMKgwqAgZGVmYXVsdCBv
biBoeWJyaWQgc3lzdGVtcy4KPiA+IAo+ID4gwqBEaWFnbm9zdGljcyBhbmQgVHVuaW5nCj4gPiDC
oD09PT09PT09PT09PT09PT09PT09PT0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9w
c3RhdGUuYwo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCj4gPiBAQCAt
OTM2LDYgKzkzNiw4IEBACj4gPiDCoMKgwqDCoMKgwqDCoCBOVUxMLAo+ID4gwqB9Owo+ID4gCj4g
PiArc3RhdGljIGJvb2wgbm9fY2FzIF9fcm9fYWZ0ZXJfaW5pdDsKPiA+ICsKPiA+IMKgc3RhdGlj
IHN0cnVjdCBjcHVkYXRhICpoeWJyaWRfbWF4X3BlcmZfY3B1IF9fcmVhZF9tb3N0bHk7Cj4gPiDC
oC8qCj4gPiDCoCAqIFByb3RlY3RzIGh5YnJpZF9tYXhfcGVyZl9jcHUsIHRoZSBjYXBhY2l0eV9w
ZXJmIGZpZWxkcyBpbgo+ID4gc3RydWN0IGNwdWRhdGEsCj4gPiBAQCAtMTA0MSw2ICsxMDQzLDEw
IEBACj4gPiAKPiA+IMKgc3RhdGljIHZvaWQgaHlicmlkX2luaXRfY3B1X2NhcGFjaXR5X3NjYWxp
bmcoYm9vbCByZWZyZXNoKQo+ID4gwqB7Cj4gPiArwqDCoMKgwqDCoMKgIC8qIEJhaWwgb3V0IGlm
IGVuYWJsaW5nIGNhcGFjaXR5LWF3YXJlIHNjaGVkdWxpbmcgaXMKPiA+IHByb2hpYml0ZWQuICov
Cj4gPiArwqDCoMKgwqDCoMKgIGlmIChub19jYXMpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm47Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCAvKgo+ID4gwqDCoMKgwqDC
oMKgwqDCoCAqIElmIGh5YnJpZF9tYXhfcGVyZl9jcHUgaXMgc2V0IGF0IHRoaXMgcG9pbnQsIHRo
ZSBoeWJyaWQKPiA+IENQVSBjYXBhY2l0eQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIHNjYWxpbmcg
aGFzIGJlZW4gZW5hYmxlZCBhbHJlYWR5IGFuZCB0aGUgZHJpdmVyIGlzIGp1c3QKPiA+IGNoYW5n
aW5nIHRoZQo+ID4gQEAgLTM4MzUsNiArMzg0MSw5IEBACj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAo
IXN0cmNtcChzdHIsICJub19od3AiKSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBub19od3AgPSAxOwo+ID4gCj4gPiArwqDCoMKgwqDCoMKgIGlmICghc3RyY21wKHN0ciwgIm5v
X2NhcyIpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm9fY2FzID0gdHJ1ZTsK
PiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghc3RyY21wKHN0ciwgImZvcmNlIikpCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yY2VfbG9hZCA9IDE7Cj4gPiDCoMKgwqDC
oMKgwqDCoCBpZiAoIXN0cmNtcChzdHIsICJod3Bfb25seSIpKQo+ID4gCj4gPiAKPiA+IAo+ID4g
Cj4gCgo=


