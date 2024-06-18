Return-Path: <linux-pm+bounces-9423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFC90C90F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D181C22B56
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25FB69D3C;
	Tue, 18 Jun 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLVcSc/R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377E1CD1F;
	Tue, 18 Jun 2024 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705481; cv=none; b=uYbMww/cQXPXp8JKdHG0/fjT8+edk6H5meM7qikdEK7e2bYRLiRQS4iplYE5kz3x6szcaFnpoK3JHpEQx88LJ38camVKQBRXh78i05x+NVLoBxh4Jarh4ou88IuXp3pm631p9blyWRgs7v3gJPB/toHDOFsvMy0AHDB/JJXK/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705481; c=relaxed/simple;
	bh=+esyxqS3tdZvSJCjCtk3Ip0cCeIIF02j8XzN7jQXpCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKzPoE0h5QpQ859WEPm3J+gcMNsHfx0o4wUvk5sKfJvALBPgXaXKVY9U6sNQfKdGsAWZfxqjmtY40dH15g+Eh7tNzXRLvRlSiIiNiY8PBGNyY7JGijU8hVHwL5nW6SGXWqFKmxsRIWtzC0OCyafzkPJn9KPx+TG1629Bk90qBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLVcSc/R; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718705480; x=1750241480;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+esyxqS3tdZvSJCjCtk3Ip0cCeIIF02j8XzN7jQXpCE=;
  b=BLVcSc/R0mBRRnCYoBokBRDsXMxUwAJj1jjyLO747cG8pPyt9dD2WeRQ
   aCz7/kO43DySHul0ErOXSnFdgDVEFZqQlTYTQJKGeMmlxVVNFHiM90/eU
   5VXTmynWaqfJ8nN6b5A8R+N/zGkFJaD4ea3Pjjb2jQUTK4cR2fo1p/4Nv
   oNUnyaVlQug7ObhfoMhj7Qysm+bDgEbhes1yp3IoIgmMXSzUiqthPA1Nz
   tEQli9hVOF+Yweh/nB7fjwbrwwLjKvRcj2U7T/00p9SRrNpZDWvvq7McZ
   317WYfJ/pC49LMLJOi5rQSke5TJt629fOV+iXjjung2LudZrhEwG+qMRp
   A==;
X-CSE-ConnectionGUID: Glxd7KxnQ6SUpWjPwbMyFA==
X-CSE-MsgGUID: 0nNApkh4Rq+mil0AX1PwlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15714895"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15714895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:11:20 -0700
X-CSE-ConnectionGUID: htgZpYJCTTOqlbAAaObr5A==
X-CSE-MsgGUID: xX2xh0RNTDSoGE7mDmEVmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="78957802"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 03:11:20 -0700
Message-ID: <12e498226b33c6cb30e40dac6a11652f29ef48ea.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Support highest performance
 change interrupt
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Date: Tue, 18 Jun 2024 03:11:18 -0700
In-Reply-To: <20240618090836.GBZnFOlFurqQiLeI7a@fat_crate.local>
References: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
	 <20240618035122.438822-3-srinivas.pandruvada@linux.intel.com>
	 <20240618090836.GBZnFOlFurqQiLeI7a@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQm9yaXNsYXYsCgpPbiBUdWUsIDIwMjQtMDYtMTggYXQgMTE6MDggKzAyMDAsIEJvcmlzbGF2
IFBldGtvdiB3cm90ZToKPiBPbiBNb24sIEp1biAxNywgMjAyNCBhdCAwODo1MToyMVBNIC0wNzAw
LCBTcmluaXZhcyBQYW5kcnV2YWRhIHdyb3RlOgo+ID4gK8KgwqDCoMKgwqDCoMKgc3RhdHVzX21h
c2sgPSBIV1BfR1VBUkFOVEVFRF9QRVJGX0NIQU5HRV9TVEFUVVM7Cj4gPiArwqDCoMKgwqDCoMKg
wqBpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hXUF9ISUdIRVNUX1BFUkZfQ0hBTkdFKSkK
PiAKPiBzL2Jvb3RfY3B1X2hhcy9jcHVfZmVhdHVyZV9lbmFibGVkL2cKCkkgd2lsbCBjaGFuZ2Ug
aW4gVjIKCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzX21hc2sgfD0g
SFdQX0hJR0hFU1RfUEVSRl9DSEFOR0VfU1RBVFVTOwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDC
oHJkbXNybF9zYWZlKE1TUl9IV1BfU1RBVFVTLCAmdmFsdWUpOwo+ID4gLcKgwqDCoMKgwqDCoMKg
aWYgKCEodmFsdWUgJiAweDAxKSkKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghKHZhbHVlICYgc3Rh
dHVzX21hc2spKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4g
PiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoHNwaW5fbG9ja19pcnFzYXZlKCZod3Bfbm90aWZ5X2xv
Y2ssIGZsYWdzKTsKPiA+IEBAIC0xNjY4LDE3ICsxNjc1LDI1IEBAIHN0YXRpYyB2b2lkCj4gPiBp
bnRlbF9wc3RhdGVfZGlzYWJsZV9od3BfaW50ZXJydXB0KHN0cnVjdCBjcHVkYXRhICpjcHVkYXRh
KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYW5jZWxfZGVsYXllZF93b3Jr
X3N5bmMoJmNwdWRhdGEtCj4gPiA+aHdwX25vdGlmeV93b3JrKTsKPiA+IMKgfQo+ID4gwqAKPiA+
ICsjZGVmaW5lIEhXUF9HVUFSQU5URUVEX1BFUkZfQ0hBTkdFX1JFUSBCSVQoMCkKPiA+ICsjZGVm
aW5lIEhXUF9ISUdIRVNUX1BFUkZfQ0hBTkdFX1JFUcKgwqDCoCBCSVQoMikKPiA+ICsKPiA+IMKg
c3RhdGljIHZvaWQgaW50ZWxfcHN0YXRlX2VuYWJsZV9od3BfaW50ZXJydXB0KHN0cnVjdCBjcHVk
YXRhCj4gPiAqY3B1ZGF0YSkKPiA+IMKgewo+ID4gLcKgwqDCoMKgwqDCoMKgLyogRW5hYmxlIEhX
UCBub3RpZmljYXRpb24gaW50ZXJydXB0IGZvciBndWFyYW50ZWVkCj4gPiBwZXJmb3JtYW5jZSBj
aGFuZ2UgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoC8qIEVuYWJsZSBIV1Agbm90aWZpY2F0aW9uIGlu
dGVycnVwdCBmb3IgcGVyZm9ybWFuY2UgY2hhbmdlCj4gPiAqLwo+ID4gwqDCoMKgwqDCoMKgwqDC
oGlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFdQX05PVElGWSkpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1NjQgaW50ZXJydXB0X21hc2sgPQo+ID4gSFdQX0dVQVJB
TlRFRURfUEVSRl9DSEFOR0VfUkVROwo+ID4gKwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzcGluX2xvY2tfaXJxKCZod3Bfbm90aWZ5X2xvY2spOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBJTklUX0RFTEFZRURfV09SSygmY3B1ZGF0YS0+aHdwX25vdGlm
eV93b3JrLAo+ID4gaW50ZWxfcHN0YXRlX25vdGlmeV93b3JrKTsKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgY3B1bWFza19zZXRfY3B1KGNwdWRhdGEtPmNwdSwKPiA+ICZod3Bf
aW50cl9lbmFibGVfbWFzayk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNw
aW5fdW5sb2NrX2lycSgmaHdwX25vdGlmeV9sb2NrKTsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaWYKPiA+IChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFdQX0hJ
R0hFU1RfUEVSRl9DSEFOR0UpKWEKPiAKPiBEaXR0by4KCldpbGwgY2hhbmdlIGluIHYyLgoKClRo
YW5rcywKU3Jpbml2YXMKCg==


