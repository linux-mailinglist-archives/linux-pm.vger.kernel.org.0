Return-Path: <linux-pm+bounces-13975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91FA974617
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 00:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181081C2595E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 22:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937641ABEC7;
	Tue, 10 Sep 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Upi1Q7Nj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FD1A76BE;
	Tue, 10 Sep 2024 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008113; cv=none; b=Yv/p0OZZjqfRyUVNoPOc+M48qHyEJ1qPHpk72DSKsHcX/cJ96rgPrtPplpuKnXlpbqyRRjCgNU9OxVghHtXkdqNJdN/B1xcoEpFYrfFFN0uojWN3edRVLXKV691pXCqIiRj4k4Z/cabgwaiDZzo3T5z9Fj70g2Hvc23b3EI7KE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008113; c=relaxed/simple;
	bh=B1Kb/1rBdk2gLp8tm/lvvMzs9HyFUXE3S9g6+iuVpc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAd1i6hwVoZyqW4/g1DOto6/m6pteRuM09Q4pEEVji8OGpmbtFwdOQTOTfHMW1EwVThQcK3wA8/KNzlems2LuxEnoBIvuQepFeVTxG2kVTFeHUnW5kRMztRG+DW8rNmFevaTXQ8uMJJnyQuiuLhCIuf4a6RwgsNft8AMmt75tkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Upi1Q7Nj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726008112; x=1757544112;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=B1Kb/1rBdk2gLp8tm/lvvMzs9HyFUXE3S9g6+iuVpc4=;
  b=Upi1Q7NjAvcDvZDEwXoequTnuZTv86PhsGoMHZFVf3oU27jNpkhHIzv7
   XpRHkh6phlOMAJ2P3GPJVpO9aXtyeti82gHEEmPoRf3GI0is9ixoPdKPv
   J3S2JvYN0VMOAlowWQyfBkGex76e0MayNeajw5v1uYlf/UjRWQdJcjHrb
   o/sqZDI+a6oLhnpkVQ179Woowm5hdG6lI2mD6F3dcsv0AOMJvg81mAP8e
   R6iKTgj5YgPpg4Kibkyq/RcJVcciyeEocBnflUdnZoXLMEJTHuoIc0Ag2
   t0MRY612/Fs6vE/e053XPgXSSA76uw3TjOF0gyx+3l4FuBj8mVf1/4Lzu
   g==;
X-CSE-ConnectionGUID: Bh31K0V+THCUn3qnpYXo/w==
X-CSE-MsgGUID: AWb8FvRJQ0CRWeAcooxxlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24605089"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208,217";a="24605089"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:41:48 -0700
X-CSE-ConnectionGUID: ZrEyXTNUSMer2wLf5e1QYg==
X-CSE-MsgGUID: 8JhJUdHuTuKEJwaXVZ+bWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208,217";a="67409985"
Received: from ehanks-mobl1.amr.corp.intel.com ([10.124.223.166])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:41:47 -0700
Message-ID: <031a8e46189d4f32812ada587cf7432c80fdf664.camel@linux.intel.com>
Subject: Re: [PATCH] PM: tools: sleepgraph: Correct the home link
From: Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net, 
	skhan@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 10 Sep 2024 15:41:46 -0700
In-Reply-To: <20240908095722.7683-1-0xff07@gmail.com>
References: <20240908095722.7683-1-0xff07@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gU3VuLCAyMDI0LTA5LTA4IGF0IDE3OjU3ICswODAwLCBZby1KdW5nIChMZW8pIExpbiB3cm90
ZToKPiBUaGUgMDEub3JnL3BtLWdyYXBoIGxpbmsgaW4gdGhlIHNsZWVwZ3JhcGgucHkgbm8gbG9u
Z2VyIHBvaW50IHRvIHRoZQo+IHBtLWdyYXBoIGhvbWUgcGFnZS4gUmVwbGFjZSBpdCB3aXRoIHRo
ZSBob21lIHBhZ2UgbGluayBpbiB0aGUgUkVBRE1FLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFlvLUp1
bmcgKExlbykgTGluIDwweGZmMDdAZ21haWwuY29tPgo+IC0tLQo+IMKgdG9vbHMvcG93ZXIvcG0t
Z3JhcGgvc2xlZXBncmFwaC5weSB8IDcgKysrKy0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIv
cG0tZ3JhcGgvc2xlZXBncmFwaC5weSBiL3Rvb2xzL3Bvd2VyL3BtLQo+IGdyYXBoL3NsZWVwZ3Jh
cGgucHkKPiBpbmRleCBlZjg3ZTYzYzA1YzcuLmY5NTA2MWQ2MDY5ZiAxMDA3NTUKPiAtLS0gYS90
b29scy9wb3dlci9wbS1ncmFwaC9zbGVlcGdyYXBoLnB5Cj4gKysrIGIvdG9vbHMvcG93ZXIvcG0t
Z3JhcGgvc2xlZXBncmFwaC5weQo+IEBAIC0xOCw3ICsxOCw3IEBACj4gwqAjCj4gwqAjIExpbmtz
Ogo+IMKgI8KgwqDCoMKgwqDCoCBIb21lIFBhZ2UKPiAtI8KgwqDCoMKgwqDCoMKgwqAgaHR0cHM6
Ly8wMS5vcmcvcG0tZ3JhcGgKPiArI8KgwqDCoMKgwqDCoMKgwqAKPiBodHRwczovL3d3dy5pbnRl
bC5jb20vY29udGVudC93d3cvdXMvZW4vZGV2ZWxvcGVyL3RvcGljLXRlY2hub2xvZ3kvb3Blbi9w
bS1ncmFwaC9vdmVydmlldy5odG1sCj4gwqAjwqDCoMKgwqDCoMKgIFNvdXJjZSByZXBvCj4gwqAj
wqDCoMKgwqDCoMKgwqDCoCBnaXRAZ2l0aHViLmNvbTppbnRlbC9wbS1ncmFwaAo+IMKgIwo+IEBA
IC0yNzUzLDggKzI3NTMsOSBAQCBjbGFzcyBUaW1lbGluZToKPiDCoMKgwqDCoMKgwqDCoMKgZGVm
IGNyZWF0ZUhlYWRlcihzZWxmLCBzdiwgc3RhbXApOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYobm90IHN0YW1wWyd0aW1lJ10pOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzZWxmLmh0bWwgKz0gJzxkaXYgY2xhc3M9InZlcnNpb24iPjxhCj4gaHJlZj0iaHR0
cHM6Ly8wMS5vcmcvcG0tZ3JhcGgiPiVzIHYlczwvYT48L2Rpdj4nIFwKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCUgKHN2LnRpdGxlLCBzdi52ZXJzaW9u
KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZWxmLmh0bWwgKz0gJzxkaXYgY2xh
c3M9InZlcnNpb24iPjxhCj4gaHJlZj0iaHR0cHM6Ly93d3cuaW50ZWwuY29tL2NvbnRlbnQnK1wK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICcvd3d3L3VzL2VuL2RldmVsb3Blci90
b3BpYy10ZWNobm9sb2d5L29wZW4vcG0tCj4gZ3JhcGgvb3ZlcnZpZXcuaHRtbCI+JXMgdiVzPC9h
PjwvZGl2PicgXAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJSAoc3YudGl0bGUs
IHN2LnZlcnNpb24pCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiBzdi5sb2dt
c2cgYW5kIHN2LnRlc3Rsb2c6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc2VsZi5odG1sICs9ICc8YnV0dG9uIGlkPSJzaG93dGVzdCIKPiBjbGFzcz0i
bG9nYnRuIGJ0bmZtdCI+bG9nPC9idXR0b24+Jwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgc3YuZG1lc2dsb2c6CkhpLCB5ZWEgSSBtYWRlIHRoaXMgY2hhbmdlIGluIHRoZSBn
aXRodWIgc291cmNlIGFmdGVyIHRoZSByZWxlYXNlIG9mCnZlcnNpb24gNS4xMiBhbmQgaGF2ZW4n
dCBwdXNoZWQgaXQgb3ZlciB0byB0aGUga2VybmVsIHNvdXJjZQp5ZXQuwqBUaGFua3MgZm9yIHRo
ZSBoZWFkcyB1cC4KCkdpdmUgbWUgYSBkYXkgb3IgdHdvIGFuZCBJJ2xsIHN1Ym1pdCBhbiB1cGRh
dGVkIHZlcnNpb24gb2YgdGhpcyBwYXRjaAp3aGljaCBpbmNsdWRlcyBhbGwgdGhlIG90aGVyIGNo
YW5nZXMgc2luY2UgNS4xMiBzbyB0aGV5IGNhbiBiZSBmdWxseSBpbgpzeW5jLgoK


