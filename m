Return-Path: <linux-pm+bounces-2440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB854836229
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551441F269EF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F23A8EA;
	Mon, 22 Jan 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9H7FdXK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD93A8E4;
	Mon, 22 Jan 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923331; cv=none; b=lT1iHOJvzjONFelnuT4Yr3ipLmFam/JBTQckhqhdT3WjegSjA9hV2v0IkrTxtxDnjs2dFRpCZithD0f62kMAe9SvVrF5nS6O8dXM+GeHUTaWa0P7ody2Z1ST2GwVvGWGEMeYOiXRtjuaDhz/k4tTqMJeDAZ6Y1JP6kfkqwL1DDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923331; c=relaxed/simple;
	bh=xVnIrGZOCLzup2XEBBV5JwzzhP5mJTK483g5WLjKY3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VNMzlmRxAfkKHPCh0G2r7f2jrEfcbl0M6mciFs6zqFO+/h9q2xnyKX9weazxndIdQgDPTvtIPPl9SWPlRwgoLi996MQ4r0TvHqGsFkQQyErDLVYN5ZN0fYhlGXVZuobkZsAR+HYKUBFc5Svo5/mccYnUnaH54wyhQwwz0NtuFuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9H7FdXK; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705923329; x=1737459329;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xVnIrGZOCLzup2XEBBV5JwzzhP5mJTK483g5WLjKY3U=;
  b=T9H7FdXKvnRYmFgoKSWS+yQ7xF9tmcCB72p8BTXSXKPLV8t4zyw+NKyw
   fp1XaXHiPJDaXbYMSoEdkDb6ZaLS+YYMhmfJftD6As177T5hSHW8TO879
   LKRSfi7fX/IAWgElbAeK02KT8ZPuldCuDcfDsB5MKK2z/q/d0EyNYY2lH
   jlqP5eRCb79VKvrLwAv2HPYd3cnAOB1If0pqq8n3wvE9wmGHFC/U9LKmu
   sziDB5eQjJ5PNcXeWbzlTAi4m54XucMWNiqNcB6EK/Y0CxTWCvd3I0cvq
   Sh2muvjeEj6yb/2nBxt/7oqRn6a6QUzvxcw71d7xEiAxuMZ/9MxU2O29R
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="432345461"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="432345461"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:35:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="27630665"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:35:29 -0800
Message-ID: <c961bae053da7287bfce49b2c1c2e7e6c754710a.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Directly use stored ratios for
 max frequencies
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael@kernel.org, 
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2024 03:35:27 -0800
In-Reply-To: <6021639.lOV4Wx5bFT@kreacher>
References: <20240118120513.1018808-1-srinivas.pandruvada@linux.intel.com>
	 <6021639.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTAxLTIyIGF0IDExOjUzICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBUaHVyc2RheSwgSmFudWFyeSAxOCwgMjAyNCAxOjA1OjEzIFBNIENFVCBTcmluaXZh
cyBQYW5kcnV2YWRhCj4gd3JvdGU6Cj4gPiBBdm9pZCB1bm5lY2Vzc2FyeSBjYWxjdWxhdGlvbiBm
b3IgY29udmVydGluZyBmcmVxdWVuY3kgdG8KPiA+IHBlcmZvcm1hbmNlCj4gPiByYXRpbyBieSB1
c2luZyBhIHNjYWxpbmcgZmFjdG9yIGZvciB0aGUgbWF4aW11bSBub24gdHVyYm8gYW5kIHR1cmJv
Cj4gCgpbLi4uXQoKPiAtLS0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lz
b2NraUBpbnRlbC5jb20+Cj4gU3ViamVjdDogW1BBVENIIHYxXSBjcHVmcmVxOiBpbnRlbF9wc3Rh
dGU6IFJlZmluZSBjb21wdXRhdGlvbiBvZiBQLQo+IHN0YXRlIGZvciBnaXZlbiBmcmVxdWVuY3kK
PiAKPiBPbiBzeXN0ZW1zIHVzaW5nIEhXUCwgaWYgYSBnaXZlbiBmcmVxdWVuY3kgaXMgZXF1YWwg
dG8gdGhlIG1heGltdW0KPiB0dXJibwo+IGZyZXF1ZW5jeSBvciB0aGUgbWF4aW11bSBub24tdHVy
Ym8gZnJlcXVlbmN5LCB0aGUgSFdQIHBlcmZvcm1hbmNlCj4gbGV2ZWwKPiBjb3JyZXNwb25kaW5n
IHRvIGl0IGlzIGFscmVhZHkga25vd24gYW5kIGNhbiBiZSB1c2VkIGRpcmVjdGx5IHdpdGhvdXQK
PiBhbnkgY29tcHV0YXRpb24uCj4gCj4gQWNjb3JkaW5nbHksIGFkanVzdCB0aGUgY29kZSB0byB1
c2UgdGhlIGtub3duIEhXUCBwZXJmb3JtYW5jZSBsZXZlbHMKPiBpbgo+IHRoZSBjYXNlcyBtZW50
aW9uZWQgYWJvdmUuCj4gCj4gVGhpcyBhbHNvIGhlbHBzIHRvIGF2b2lkIGxpbWl0aW5nIENQVSBj
YXBhY2l0eSBhcnRpZmljaWFsbHkgaW4gc29tZQo+IGNhc2VzIHdoZW4gdGhlIEJJT1MgcHJvZHVj
ZXMgdGhlIEhXUF9DQVAgbnVtYmVycyB1c2luZyBhIGRpZmZlcmVudAo+IEUtY29yZS10by1QLWNv
cmUgcGVyZm9ybWFuY2Ugc2NhbGluZyBmYWN0b3IgdGhhbiBleHBlY3RlZCBieSB0aGUKPiBrZXJu
ZWwuCj4gCj4gRml4ZXM6IGY1YzhjZjJhNDk5MiAoImNwdWZyZXE6IGludGVsX3BzdGF0ZTogaHli
cmlkOiBVc2Uga25vd24KPiBzY2FsaW5nIGZhY3RvciBmb3IgUC1jb3JlcyIpCj4gQ2M6IDYuMSsg
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNi4xKwo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBK
LiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4KPiAtLS0KClRlc3RlZCBvbiB0
aGUgc3lzdGVtIHdoaWNoIHNob3dlZCB0aGUgaXNzdWUsIHRoaXMgcGF0Y2ggd29yayBmaW5lLgoK
VGhhbmtzLApTcmluaXZhcwoKPiDCoGRyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyB8wqDC
oCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiAtLS0tLS0tLS0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQo+IAo+IEluZGV4
OiBsaW51eC1wbS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMKPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4g
LS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCj4gKysrIGxp
bnV4LXBtL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYwo+IEBAIC01MjksNiArNTI5LDMw
IEBAIHN0YXRpYyBpbnQgaW50ZWxfcHN0YXRlX2NwcGNfZ2V0X3NjYWxpbmcKPiDCoH0KPiDCoCNl
bmRpZiAvKiBDT05GSUdfQUNQSV9DUFBDX0xJQiAqLwo+IMKgCj4gK3N0YXRpYyBpbnQgaW50ZWxf
cHN0YXRlX2ZyZXFfdG9faHdwX3JlbChzdHJ1Y3QgY3B1ZGF0YSAqY3B1LCBpbnQKPiBmcmVxLAo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgcmVsYXRpb24pCj4gK3sKPiArwqDC
oMKgwqDCoMKgwqBpZiAoZnJlcSA9PSBjcHUtPnBzdGF0ZS50dXJib19mcmVxKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gY3B1LT5wc3RhdGUudHVyYm9fcHN0YXRlOwo+
ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoZnJlcSA9PSBjcHUtPnBzdGF0ZS5tYXhfZnJlcSkKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGNwdS0+cHN0YXRlLm1heF9wc3Rh
dGU7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHN3aXRjaCAocmVsYXRpb24pIHsKPiArwqDCoMKgwqDC
oMKgwqBjYXNlIENQVUZSRVFfUkVMQVRJT05fSDoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIGZyZXEgLyBjcHUtPnBzdGF0ZS5zY2FsaW5nOwo+ICvCoMKgwqDCoMKgwqDC
oGNhc2UgQ1BVRlJFUV9SRUxBVElPTl9DOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gRElWX1JPVU5EX0NMT1NFU1QoZnJlcSwgY3B1LT5wc3RhdGUuc2NhbGluZyk7Cj4g
K8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gRElWX1JPVU5EX1VQ
KGZyZXEsIGNwdS0+cHN0YXRlLnNjYWxpbmcpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IGludGVs
X3BzdGF0ZV9mcmVxX3RvX2h3cChzdHJ1Y3QgY3B1ZGF0YSAqY3B1LCBpbnQgZnJlcSkKPiArewo+
ICvCoMKgwqDCoMKgwqDCoHJldHVybiBpbnRlbF9wc3RhdGVfZnJlcV90b19od3BfcmVsKGNwdSwg
ZnJlcSwKPiBDUFVGUkVRX1JFTEFUSU9OX0wpOwo+ICt9Cj4gKwo+IMKgLyoqCj4gwqAgKiBpbnRl
bF9wc3RhdGVfaHlicmlkX2h3cF9hZGp1c3QgLSBDYWxpYnJhdGUgSFdQIHBlcmZvcm1hbmNlCj4g
bGV2ZWxzLgo+IMKgICogQGNwdTogVGFyZ2V0IENQVS4KPiBAQCAtNTQ2LDYgKzU3MCw3IEBAIHN0
YXRpYyB2b2lkIGludGVsX3BzdGF0ZV9oeWJyaWRfaHdwX2FkanUKPiDCoMKgwqDCoMKgwqDCoMKg
aW50IHBlcmZfY3RsX3NjYWxpbmcgPSBjcHUtPnBzdGF0ZS5wZXJmX2N0bF9zY2FsaW5nOwo+IMKg
wqDCoMKgwqDCoMKgwqBpbnQgcGVyZl9jdGxfdHVyYm8gPSBwc3RhdGVfZnVuY3MuZ2V0X3R1cmJv
KGNwdS0+Y3B1KTsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IHNjYWxpbmcgPSBjcHUtPnBzdGF0ZS5z
Y2FsaW5nOwo+ICvCoMKgwqDCoMKgwqDCoGludCBmcmVxOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDC
oHByX2RlYnVnKCJDUFUlZDogcGVyZl9jdGxfbWF4X3BoeXMgPSAlZFxuIiwgY3B1LT5jcHUsCj4g
cGVyZl9jdGxfbWF4X3BoeXMpOwo+IMKgwqDCoMKgwqDCoMKgwqBwcl9kZWJ1ZygiQ1BVJWQ6IHBl
cmZfY3RsX3R1cmJvID0gJWRcbiIsIGNwdS0+Y3B1LAo+IHBlcmZfY3RsX3R1cmJvKTsKPiBAQCAt
NTU5LDE2ICs1ODQsMTYgQEAgc3RhdGljIHZvaWQgaW50ZWxfcHN0YXRlX2h5YnJpZF9od3BfYWRq
dQo+IMKgwqDCoMKgwqDCoMKgwqBjcHUtPnBzdGF0ZS5tYXhfZnJlcSA9IHJvdW5kZG93bihjcHUt
PnBzdGF0ZS5tYXhfcHN0YXRlICoKPiBzY2FsaW5nLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBlcmZfY3RsX3NjYWxpbmcpOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgY3B1LT5wc3RhdGUubWF4
X3BzdGF0ZV9waHlzaWNhbCA9Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBESVZfUk9VTkRfVVAocGVyZl9jdGxfbWF4X3BoeXMgKgo+IHBlcmZfY3RsX3Nj
YWxpbmcsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NhbGluZyk7Cj4gK8KgwqDCoMKgwqDCoMKgZnJlcSA9
IHBlcmZfY3RsX21heF9waHlzICogcGVyZl9jdGxfc2NhbGluZzsKPiArwqDCoMKgwqDCoMKgwqBj
cHUtPnBzdGF0ZS5tYXhfcHN0YXRlX3BoeXNpY2FsID0KPiBpbnRlbF9wc3RhdGVfZnJlcV90b19o
d3AoY3B1LCBmcmVxKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGNwdS0+cHN0YXRlLm1pbl9mcmVx
ID0gY3B1LT5wc3RhdGUubWluX3BzdGF0ZSAqCj4gcGVyZl9jdGxfc2NhbGluZzsKPiArwqDCoMKg
wqDCoMKgwqBmcmVxID0gY3B1LT5wc3RhdGUubWluX3BzdGF0ZSAqIHBlcmZfY3RsX3NjYWxpbmc7
Cj4gK8KgwqDCoMKgwqDCoMKgY3B1LT5wc3RhdGUubWluX2ZyZXEgPSBmcmVxOwo+IMKgwqDCoMKg
wqDCoMKgwqAvKgo+IMKgwqDCoMKgwqDCoMKgwqAgKiBDYXN0IHRoZSBtaW4gUC1zdGF0ZSB2YWx1
ZSByZXRyaWV2ZWQgdmlhCj4gcHN0YXRlX2Z1bmNzLmdldF9taW4oKSB0bwo+IMKgwqDCoMKgwqDC
oMKgwqAgKiB0aGUgZWZmZWN0aXZlIHJhbmdlIG9mIEhXUCBwZXJmb3JtYW5jZSBsZXZlbHMuCj4g
wqDCoMKgwqDCoMKgwqDCoCAqLwo+IC3CoMKgwqDCoMKgwqDCoGNwdS0+cHN0YXRlLm1pbl9wc3Rh
dGUgPSBESVZfUk9VTkRfVVAoY3B1LT5wc3RhdGUubWluX2ZyZXEsCj4gc2NhbGluZyk7Cj4gK8Kg
wqDCoMKgwqDCoMKgY3B1LT5wc3RhdGUubWluX3BzdGF0ZSA9IGludGVsX3BzdGF0ZV9mcmVxX3Rv
X2h3cChjcHUsIGZyZXEpOwo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgaW5saW5lIHZvaWQgdXBkYXRl
X3R1cmJvX3N0YXRlKHZvaWQpCj4gQEAgLTI1MjgsMTMgKzI1NTMsMTIgQEAgc3RhdGljIHZvaWQg
aW50ZWxfcHN0YXRlX3VwZGF0ZV9wZXJmX2xpbQo+IMKgwqDCoMKgwqDCoMKgwqAgKiBhYnN0cmFj
dCB2YWx1ZXMgdG8gcmVwcmVzZW50IHBlcmZvcm1hbmNlIHJhdGhlciB0aGFuIHB1cmUKPiByYXRp
b3MuCj4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoaHdwX2FjdGl2
ZSAmJiBjcHUtPnBzdGF0ZS5zY2FsaW5nICE9IHBlcmZfY3RsX3NjYWxpbmcpIHsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IHNjYWxpbmcgPSBjcHUtPnBzdGF0ZS5zY2FsaW5n
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IGZyZXE7Cj4gwqAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZyZXEgPSBtYXhfcG9saWN5X3BlcmYgKiBwZXJm
X2N0bF9zY2FsaW5nOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtYXhfcG9saWN5
X3BlcmYgPSBESVZfUk9VTkRfVVAoZnJlcSwgc2NhbGluZyk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoG1heF9wb2xpY3lfcGVyZiA9IGludGVsX3BzdGF0ZV9mcmVxX3RvX2h3cChj
cHUsCj4gZnJlcSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmcmVxID0gbWlu
X3BvbGljeV9wZXJmICogcGVyZl9jdGxfc2NhbGluZzsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbWluX3BvbGljeV9wZXJmID0gRElWX1JPVU5EX1VQKGZyZXEsIHNjYWxpbmcpOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtaW5fcG9saWN5X3BlcmYgPSBpbnRlbF9w
c3RhdGVfZnJlcV90b19od3AoY3B1LAo+IGZyZXEpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgcHJfZGVidWcoImNwdTolZCBtaW5fcG9saWN5X3BlcmY6JWQgbWF4
X3BvbGljeV9wZXJmOiVkXG4iLAo+IEBAIC0yOTA4LDE4ICsyOTMyLDcgQEAgc3RhdGljIGludCBp
bnRlbF9jcHVmcmVxX3RhcmdldChzdHJ1Y3QgYwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGNwdWZy
ZXFfZnJlcV90cmFuc2l0aW9uX2JlZ2luKHBvbGljeSwgJmZyZXFzKTsKPiDCoAo+IC3CoMKgwqDC
oMKgwqDCoHN3aXRjaCAocmVsYXRpb24pIHsKPiAtwqDCoMKgwqDCoMKgwqBjYXNlIENQVUZSRVFf
UkVMQVRJT05fTDoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGFyZ2V0X3BzdGF0
ZSA9IERJVl9ST1VORF9VUChmcmVxcy5uZXcsIGNwdS0KPiA+cHN0YXRlLnNjYWxpbmcpOwo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiAtwqDCoMKgwqDCoMKgwqBjYXNl
IENQVUZSRVFfUkVMQVRJT05fSDoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGFy
Z2V0X3BzdGF0ZSA9IGZyZXFzLm5ldyAvIGNwdS0+cHN0YXRlLnNjYWxpbmc7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoGRlZmF1bHQ6Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRhcmdldF9wc3RhdGUgPSBESVZfUk9VTkRf
Q0xPU0VTVChmcmVxcy5uZXcsIGNwdS0KPiA+cHN0YXRlLnNjYWxpbmcpOwo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiAtwqDCoMKgwqDCoMKgwqB9Cj4gLQo+ICvCoMKg
wqDCoMKgwqDCoHRhcmdldF9wc3RhdGUgPSBpbnRlbF9wc3RhdGVfZnJlcV90b19od3BfcmVsKGNw
dSwgZnJlcXMubmV3LAo+IHJlbGF0aW9uKTsKPiDCoMKgwqDCoMKgwqDCoMKgdGFyZ2V0X3BzdGF0
ZSA9IGludGVsX2NwdWZyZXFfdXBkYXRlX3BzdGF0ZShwb2xpY3ksCj4gdGFyZ2V0X3BzdGF0ZSwg
ZmFsc2UpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGZyZXFzLm5ldyA9IHRhcmdldF9wc3RhdGUg
KiBjcHUtPnBzdGF0ZS5zY2FsaW5nOwo+IEBAIC0yOTM3LDcgKzI5NTAsNyBAQCBzdGF0aWMgdW5z
aWduZWQgaW50IGludGVsX2NwdWZyZXFfZmFzdF9zCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgdXBk
YXRlX3R1cmJvX3N0YXRlKCk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqB0YXJnZXRfcHN0YXRlID0g
RElWX1JPVU5EX1VQKHRhcmdldF9mcmVxLCBjcHUtCj4gPnBzdGF0ZS5zY2FsaW5nKTsKPiArwqDC
oMKgwqDCoMKgwqB0YXJnZXRfcHN0YXRlID0gaW50ZWxfcHN0YXRlX2ZyZXFfdG9faHdwKGNwdSwg
dGFyZ2V0X2ZyZXEpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoHRhcmdldF9wc3RhdGUgPSBpbnRl
bF9jcHVmcmVxX3VwZGF0ZV9wc3RhdGUocG9saWN5LAo+IHRhcmdldF9wc3RhdGUsIHRydWUpOwo+
IMKgCj4gCj4gCj4gCgo=


