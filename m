Return-Path: <linux-pm+bounces-33329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C7B3AB19
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1E7E4E00E5
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 19:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54C27B340;
	Thu, 28 Aug 2025 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sp4yRxEU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F81D6188;
	Thu, 28 Aug 2025 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756410961; cv=none; b=s3DxVcf6R5RFn+oNPGvyngUhcdzlidL+RxakbcnglST1TQsPpkBOBuRwZW54vz6GGn/rtchW0kxPDf6pT+xOALuhYSJN/pm/9pTUyfVsSK/YIAdo+Hh+ZVCXa7HoAksXlhGRSas60c3fIq/UVhfOgaBnLPxCV1iDqa1LC6DN+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756410961; c=relaxed/simple;
	bh=1xyQP78WXfSi+P8g7faHhe6ujQkhiM7bYcJIFYiBPzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjirYu844d9kRGNydTzkQKVjBAC88yfugis3vL8x7HQ/fmJGj6MYLvBXWuv6/nixJom3Pmb+gt1sABUGUiPk65yLuU+P+zvVzki50l+KDCPA4pyHZsLwXOXcBdWHuBGQmVS8ndtZe7/1BFpfZl0gnq/MW2mFifrGQBh/Urgsv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sp4yRxEU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756410959; x=1787946959;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1xyQP78WXfSi+P8g7faHhe6ujQkhiM7bYcJIFYiBPzA=;
  b=Sp4yRxEUMhjxIsm6PQPB6K7syayMIss5yxL6z+swpyymsQ1DGitNsVvb
   7i2Z9fZnqzUu7QToGoS9dMHvswl1fLFYwDi/EsbSacvagxWghF6fWgcuz
   jbOtwhQ3chOTggVTqFh1KbOGNsWVPNwfs/YE5jCpWZH8pSPCA+m2S0Nwh
   XipTCmJRCPyJTFCuy1D/3JXm3QCa4Qmo0KG4U8iS1uJspms6UvEesD4w7
   hfg6YnZH4v/ktdTfsCb3+KQE2oYsdu1iPd3ueJbDe9sLATzRILA7Ls4TH
   jdkhapDHjxixf9+A9iFnvOORJ4jVNe6GXJbIV/ByQa3lwUxa0LwBeavVx
   w==;
X-CSE-ConnectionGUID: PNPsmtokQ4iSz4rqGh0t7A==
X-CSE-MsgGUID: v95rAEGMSUi2XjhtsUCr7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58756371"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58756371"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 12:55:58 -0700
X-CSE-ConnectionGUID: Ikixw5MuQz66Is2udMTDRg==
X-CSE-MsgGUID: ED/qyII1Rkyyz9HR3K/kMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="201119791"
Received: from dwoodwor-mobl2.amr.corp.intel.com ([10.125.109.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 12:55:57 -0700
Message-ID: <d1c898fbb9b5095bc038d2393d350722627f3627.camel@linux.intel.com>
Subject: Re: [PATCH] selftests/thermel/intel/workload_hint: Mask unsupported
 types
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 28 Aug 2025 12:55:55 -0700
In-Reply-To: <CAJZ5v0hcwgmddSN=0eM+PxTNuE1dm=iRLBbYWF7PFcB8H2ztDA@mail.gmail.com>
References: <20250828192328.929742-1-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0hcwgmddSN=0eM+PxTNuE1dm=iRLBbYWF7PFcB8H2ztDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDIxOjM0ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBUaHUsIEF1ZyAyOCwgMjAyNSBhdCA5OjIz4oCvUE0gU3Jpbml2YXMgUGFuZHJ1dmFk
YQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+
IFRoZSB3b3JrbG9hZCBoaW50IG1heSBjb250YWluIHNvbWUgb3RoZXIgaGludHMgd2hpY2ggYXJl
IG5vdAo+ID4gZGVmaW5lZC4KPiA+IFNvIG1hc2sgb3V0IHVuc3VwcG9ydGVkIHR5cGVzLiBDdXJy
ZW50bHkgb25seSBsb3dlciA0IGJpdHMgb2YKPiA+IHdvcmtsb2FkCj4gPiB0eXBlIGhpbnRzIGFy
ZSBkZWZpbmVkLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhCj4g
PiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+Cj4gPiAtLS0KPiA+IMKgLi4u
L3NlbGZ0ZXN0cy90aGVybWFsL2ludGVsL3dvcmtsb2FkX2hpbnQvd29ya2xvYWRfaGludF90ZXN0
LmMgfCAzCj4gPiArKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0Cj4gPiBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RoZXJtYWwvaW50
ZWwvd29ya2xvYWRfaGludC93b3JrbG9hZF9oaW50Cj4gPiBfdGVzdC5jCj4gPiBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3RoZXJtYWwvaW50ZWwvd29ya2xvYWRfaGludC93b3JrbG9hZF9oaW50
Cj4gPiBfdGVzdC5jCj4gPiBpbmRleCBiYTU4NTg5YTExNDUuLjNlZTAxOGJjYTg5OSAxMDA2NDQK
PiA+IC0tLQo+ID4gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aGVybWFsL2ludGVsL3dvcmts
b2FkX2hpbnQvd29ya2xvYWRfaGludAo+ID4gX3Rlc3QuYwo+ID4gKysrCj4gPiBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3RoZXJtYWwvaW50ZWwvd29ya2xvYWRfaGludC93b3JrbG9hZF9oaW50
Cj4gPiBfdGVzdC5jCj4gPiBAQCAtMTMzLDYgKzEzMyw3IEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICoqYXJndikKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgaWYg
KHJldCA9PSAwKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHByaW50ZigiUG9sbCBUaW1lb3V0XG4iKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9IGVsc2Ugewo+ID4gKwo+IAo+IElzIHRoaXMgY2hhbmdlIGludGVudGlvbmFs
P8KgIExvb2tzIGxpa2UgaXQgaXMgbm90IG5lZWRlZC4KTm90IGludGVudGlvbmFsLiBXaWxsIHNl
bmQgdXBkYXRlLgoKVGhhbmtzLApTcmluaXZhcwoKPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKChsc2VlayhmZCwgMEwsIFNFRUtfU0VUKSkg
PCAwKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCB0byBzZXQKPiA+IHBvaW50
ZXIgdG8gYmVnaW5uaW5nXG4iKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4aXQoMSk7Cj4gPiBAQCAtMTQ0LDYgKzE0
NSw4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gc3NjYW5mKGluZGV4X3N0ciwg
IiVkIiwgJmluZGV4KTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHJldCA8IDApCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ICsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmRleCAmPSAweDBmOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaW5kZXgg
PiBXT1JLTE9BRF9UWVBFX01BWF9JTkRFWCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaW50ZigiSW52YWxpZCB3b3Jr
bG9hZCB0eXBlCj4gPiBpbmRleFxuIik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPiA+IC0tCj4gPiAyLjUwLjEKPiA+IAo+IAoK


