Return-Path: <linux-pm+bounces-22597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26851A3EC3E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89387001AC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 05:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F681F9406;
	Fri, 21 Feb 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQhmuFeP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A14207F;
	Fri, 21 Feb 2025 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116360; cv=none; b=pRSk/QF39EI812tCiyW3uCjmcEARvKGRUWOOcaXakhSuUv2+8EJgNaNrZAtb+n4feinZDmUGaUfHT52GelrOPXgsHrW3iUectQiQ2pvISbXAYlfLisMowMqr6ykYkXEyJ4EzwhLYc/46qB4FF4G1L4ZjNXBdXT9HMbOPSzU/Ee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116360; c=relaxed/simple;
	bh=fK8Z+IZ0pHC7+G1nepcVxclbQi7OboQCTZuLxnZ0GvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFcYXsxYpiHBE+uh80KKz6FlPBTZdXpVH+QoYJ/M3wab4ALwELLuIGdILRhmvq9ShuL+F4L+hwHca27JZc8PR9w9JSpW5j/SqvvXmdVN9vZtemkAHfic4O6vx++jSnhM3pw5IJNnDCZkvWUyps4QMgN1EV43acvNe0kFet/UrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQhmuFeP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740116358; x=1771652358;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fK8Z+IZ0pHC7+G1nepcVxclbQi7OboQCTZuLxnZ0GvY=;
  b=PQhmuFePZ9PHZ4hP3P3xB3HZ/u3w8r1G3xJYlRpqOXkKMe6Gt98Jj+wv
   2xlOKXOo/Gv94ed46X1Wl326jonUnMzisQ5nS0vACQzz62v+Q5rWJnFBu
   BZn86s1uzvImKZaKdA+VEcd/pBSQcE/eT0XT1MQv6s1dZlTJAVfhljwwD
   zDtX9dLJoQ2BeZ39hZiKUYx935eCMzayjuHn8zywzDlyqrYSPhYHx5act
   gdM8INR4frJ7GAfC8bMquXC5mwmFFikFCXdnwo1IQcuBtkZdVgOCJDQKr
   LJRUEbvcc4EPqwuceOUN+bsAr33z77hYRe7dAtNsxYpvBVyca4Vw9ODkQ
   Q==;
X-CSE-ConnectionGUID: +HjFcfd9QYiDg+Q4HShiqQ==
X-CSE-MsgGUID: wk9sQoelRAak2IfqGY0Tlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41045924"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="41045924"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 21:39:15 -0800
X-CSE-ConnectionGUID: XpdX+/24Rt+nrlXK5Vbfpw==
X-CSE-MsgGUID: 2rTsZrk3SjGmTazUIIK4pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="120382132"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 21:39:14 -0800
Message-ID: <df4fd1434a72f520e34afce386e10890bb4ae073.camel@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Relocate platform preference
 check
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,  Zhang Rui <rui.zhang@intel.com>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>
Date: Thu, 20 Feb 2025 21:39:14 -0800
In-Reply-To: <CAJZ5v0jF_oLkzqEJuc9NX_j1+javyU8HF0JU8FiFgNaCks+RdA@mail.gmail.com>
References: <2776745.mvXUDI8C0e@rjwysocki.net>
	 <CAJZ5v0jF_oLkzqEJuc9NX_j1+javyU8HF0JU8FiFgNaCks+RdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDIwOjMwICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBGcmksIEZlYiA3LCAyMDI1IGF0IDE6NDjigK9QTSBSYWZhZWwgSi4gV3lzb2NraSA8
cmp3QHJqd3lzb2NraS5uZXQ+Cj4gd3JvdGU6Cj4gPiAKPiA+IEZyb206IFJhZmFlbCBKLiBXeXNv
Y2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4KPiA+IAo+ID4gTW92ZSB0aGUgaW52b2Nh
dGlvbiBvZiBpbnRlbF9wc3RhdGVfcGxhdGZvcm1fcHdyX21nbXRfZXhpc3RzKCkKPiA+IGJlZm9y
ZQo+ID4gY2hlY2tpbmcgd2hldGhlciBvciBub3QgSFdQIGlzIGVuYWJsZWQgYmVjYXVzZSBpdCBk
b2VzIG5vdCBkZXBlbmQKPiA+IG9uCj4gPiBhbnkgY29kZSBydW5uaW5nIGJlZm9yZSBpdCBleGNl
cHQgZm9yIHRoZSB2ZW5kb3IgY2hlY2sgYW5kIGlmIENQVQo+ID4gcGVyZm9ybWFuY2Ugc2NhbGlu
ZyBpcyBnb2luZyB0byBiZSBjYXJyaWVkIG91dCBieSB0aGUgcGxhdGZvcm0sIGFsbAo+ID4gb2YK
PiA+IHRoZSBjb2RlIHRoYXQgcnVucyBiZWZvcmUgdGhhdCBmdW5jdGlvbiAoYWdhaW4sIGV4Y2Vw
dCBmb3IgdGhlCj4gPiB2ZW5kb3IKPiA+IGNoZWNrKSBpcyByZWR1bmRhbnQuCj4gPiAKPiA+IFRo
aXMgaXMgbm90IGV4cGVjdGVkIHRvIGFsdGVyIGFueSBmdW5jdGlvbmFsaXR5IGV4Y2VwdCBmb3Ig
dGhlCj4gPiBvcmRlcmluZwo+ID4gb2YgbWVzc2FnZXMgcHJpbnRlZCBieSBpbnRlbF9wc3RhdGVf
aW5pdCgpIHdoZW4gaXQgaXMgZ29pbmcgdG8KPiA+IHJldHVybiBhbgo+ID4gZXJyb3IgYmVmb3Jl
IGF0dGVtcHRpbmcgdG8gcmVnaXN0ZXIgdGhlIGRyaXZlci4KPiA+IAo+ID4gU2lnbmVkLW9mZi1i
eTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPgo+IAo+IFNy
aW5pdmFzLCBJJ20gd29uZGVyaW5nIGlmIHlvdSBoYXZlIGFueSBjb25jZXJucyByZWdhcmRpbmcg
dGhpcyBvbmU/Ck5vbmUuCgpBY2tlZC1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMu
cGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+CgpUaGFua3MsClNyaW5pdmFzCgoKPiAKPiA+IC0t
LQo+ID4gwqBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfMKgwqAgMTggKysrKysrKysr
LS0tLS0tLS0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pCj4gPiAKPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYwo+ID4g
KysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCj4gPiBAQCAtMzY4OCw2ICszNjg4
LDE1IEBACj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9
IFg4Nl9WRU5ET1JfSU5URUwpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTk9ERVY7Cj4gPiAKPiA+ICvCoMKgwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoMKgwqDC
oCAqIFRoZSBJbnRlbCBwc3RhdGUgZHJpdmVyIHdpbGwgYmUgaWdub3JlZCBpZiB0aGUgcGxhdGZv
cm0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGZpcm13YXJlIGhhcyBpdHMgb3duIHBvd2VyIG1hbmFn
ZW1lbnQgbW9kZXMuCj4gPiArwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKgwqAgaWYg
KGludGVsX3BzdGF0ZV9wbGF0Zm9ybV9wd3JfbWdtdF9leGlzdHMoKSkgewo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfaW5mbygiUC1zdGF0ZXMgY29udHJvbGxlZCBieSB0aGUg
cGxhdGZvcm1cbiIpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
Tk9ERVY7Cj4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgIGlkID0g
eDg2X21hdGNoX2NwdShod3Bfc3VwcG9ydF9pZHMpOwo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGlk
KSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaHdwX2ZvcmNlZCA9IGludGVs
X3BzdGF0ZV9od3BfaXNfZW5hYmxlZCgpOwo+ID4gQEAgLTM3NDMsMTUgKzM3NTIsNiBAQAo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlZmF1bHRfZHJpdmVyID0gJmludGVsX2Nw
dWZyZXE7Cj4gPiAKPiA+IMKgaHdwX2NwdV9tYXRjaGVkOgo+ID4gLcKgwqDCoMKgwqDCoCAvKgo+
ID4gLcKgwqDCoMKgwqDCoMKgICogVGhlIEludGVsIHBzdGF0ZSBkcml2ZXIgd2lsbCBiZSBpZ25v
cmVkIGlmIHRoZSBwbGF0Zm9ybQo+ID4gLcKgwqDCoMKgwqDCoMKgICogZmlybXdhcmUgaGFzIGl0
cyBvd24gcG93ZXIgbWFuYWdlbWVudCBtb2Rlcy4KPiA+IC3CoMKgwqDCoMKgwqDCoCAqLwo+ID4g
LcKgwqDCoMKgwqDCoCBpZiAoaW50ZWxfcHN0YXRlX3BsYXRmb3JtX3B3cl9tZ210X2V4aXN0cygp
KSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9pbmZvKCJQLXN0YXRlcyBj
b250cm9sbGVkIGJ5IHRoZSBwbGF0Zm9ybVxuIik7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPiA+IC3CoMKgwqDCoMKgwqAgfQo+ID4gLQo+ID4gwqDC
oMKgwqDCoMKgwqAgaWYgKCFod3BfYWN0aXZlICYmIGh3cF9vbmx5KQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PVFNVUFA7Cj4gPiAKPiA+IAo+ID4gCj4gPiAK
PiA+IAoK


