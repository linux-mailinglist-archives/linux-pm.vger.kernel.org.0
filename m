Return-Path: <linux-pm+bounces-43957-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMuaKx3trmnGKQIAu9opvQ
	(envelope-from <linux-pm+bounces-43957-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 16:54:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F123C2A3
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 16:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8D3330A7245
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4985E3DFC85;
	Mon,  9 Mar 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdGYZDhX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE23DAC13;
	Mon,  9 Mar 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071336; cv=none; b=ZnPXopDSdESiQOaGIyxSEAQpjTMG9jOgoyi4XfAXnAJzOyUwerl8HI0Pyzoz8VF4sAGQB5cBd8D152MLsTdTHEkxR9s1mEMRsjAZ+8bTIsJgR1fgE1OzMamTV8R7/oweshw1TMRhKztjKuEbVCVPmJtwwAWY2GcnDuPtELGi/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071336; c=relaxed/simple;
	bh=lubI6HsFSbUUMRyFA3LiWu77g1i3512iwiTFbEzKz+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U3ErlEasV9ftEtTKW9/kyefk13mHiLITHl8hA8DShJjbw2gEGJLJgtln5p1rc/aL7PMJ+nWKCLWB7P33IybJCRjC0onW2bi3m+8XQhgKHeUzzrbii6q4XR7klq2n8OAw3fQorkVFzCt89VN+Nw+AH7PzBe2t+gsdtDkmS/dvbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdGYZDhX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773071334; x=1804607334;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lubI6HsFSbUUMRyFA3LiWu77g1i3512iwiTFbEzKz+M=;
  b=SdGYZDhXZ+SLgv7o6WjHKZ4emDmnJMBzdPox1vePOe0/F8DQcPMlTPC3
   Eq+9/elBgds8DFc79XUf91TRNGG95sl+sWIiuFOf6VHMFY1qo+7yWkzBX
   5vcTIdhu8EJXkHTnvdqZSawbds72aKjeKKZnkTyOFDs2JcveHSATz6rtR
   S+qJvqstkafzzLWtKlMR6soOnD9sQ+k6tV9xI4rjV1PZXqSza0SRiQIFb
   aHhsV0fDhujQKzaM5aF7qdY54TfCAIByXeilTI5MJrjele06E4wDgfg+/
   +Rd2hawkEC37sRemZFTD1I3uv82CALZf4AdfFfEL5e9nGOhQLyrqG/R8R
   A==;
X-CSE-ConnectionGUID: WabmDERRRQee2otZSrg3Pg==
X-CSE-MsgGUID: AoPEXgzJQMGJIRGCPp6zAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84425744"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84425744"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:48:54 -0700
X-CSE-ConnectionGUID: jvQkVSMiTF27gDoJ7/l2rQ==
X-CSE-MsgGUID: EwIyU1wBRNmJ/xU4TE4YEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219767903"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:48:54 -0700
Message-ID: <80e78e2b4d1ef4158f0065b5e1fdb0dd5ef754f9.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel: int340x: Read DDR data rate for Nova
 Lake
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Mar 2026 08:48:54 -0700
In-Reply-To: <CAJZ5v0ju7V3EaUgwxpUZV2LN2YBaduEd4hpoOJsL-LRmSJ1pvA@mail.gmail.com>
References: <20260223190420.874853-1-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0ju7V3EaUgwxpUZV2LN2YBaduEd4hpoOJsL-LRmSJ1pvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3E4F123C2A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-43957-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAzLTA1IGF0IDE1OjQyICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBNb24sIEZlYiAyMywgMjAyNiBhdCA4OjA14oCvUE0gU3Jpbml2YXMgUGFuZHJ1dmFk
YQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+
IEFkZCBzdXBwb3J0IGZvciByZWFkaW5nIEREUiBkYXRhIHJhdGUgZnJvbSBQQ0kgY29uZmlnIG9m
ZnNldC4KPiA+IFRoZSByZWdpc3RlciBkZXRhaWxzIGFyZToKPiA+IENGRyBPZmZzZXQgOiAweEUw
Cj4gPiBCaXRzwqDCoMKgwqDCoMKgIDogMTE6Mgo+ID4gCj4gPiBERFIgRGF0YSByYXRlIGlzIGlu
IDMzLjMzIE1UUFMgdW5pdHMuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRy
dXZhZGEKPiA+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4KPiA+IC0tLQo+
ID4gwqAuLi4vaW50MzQweF90aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX3JmaW0uY8KgwqDCoMKg
IHwgMTYKPiA+ICsrKysrKysrKysrKysrKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdAo+ID4gYS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwv
aW50MzQweF90aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX3JmaW0uYwo+ID4gYi9kcml2ZXJzL3Ro
ZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX3JmaW0uYwo+ID4g
aW5kZXggMzE0ZmJjMWY0OTBmLi4yZTgzNGExNzU0NzEgMTAwNjQ0Cj4gPiAtLS0KPiA+IGEvZHJp
dmVycy90aGVybWFsL2ludGVsL2ludDM0MHhfdGhlcm1hbC9wcm9jZXNzb3JfdGhlcm1hbF9yZmlt
LmMKPiA+ICsrKwo+ID4gYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL3By
b2Nlc3Nvcl90aGVybWFsX3JmaW0uYwo+ID4gQEAgLTQwMiw2ICs0MDIsMTEgQEAgc3RhdGljIHNz
aXplX3QgcmZpX3Jlc3RyaWN0aW9uX3Nob3coc3RydWN0Cj4gPiBkZXZpY2UgKmRldiwKPiA+IMKg
wqDCoMKgwqDCoMKgIHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVsbHVcbiIsIHJlc3ApOwo+ID4g
wqB9Cj4gPiAKPiA+ICsgLyogZGRyX2RhdGFfcmF0ZSAqLwo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgbW1pb19yZWcgbnZsX2Rkcl9kYXRhX3JhdGVfcmVnID0geyAxLCAweEUwLAo+ID4gMTAsIDB4
M0ZGLCAyfTsKPiA+ICsKPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG1taW9fcmVnICpkZHJfZGF0
YV9yYXRlX3JlZzsKPiA+ICsKPiA+IMKgc3RhdGljIHNzaXplX3QgZGRyX2RhdGFfcmF0ZV9zaG93
KHN0cnVjdCBkZXZpY2UgKmRldiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0
ZSAqYXR0ciwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFyICpidWYpCj4gPiBAQCAtNDEwLDEwICs0MTUsMjAg
QEAgc3RhdGljIHNzaXplX3QgZGRyX2RhdGFfcmF0ZV9zaG93KHN0cnVjdAo+ID4gZGV2aWNlICpk
ZXYsCj4gPiDCoMKgwqDCoMKgwqDCoCB1NjQgcmVzcDsKPiA+IMKgwqDCoMKgwqDCoMKgIGludCBy
ZXQ7Cj4gPiAKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGRkcl9kYXRhX3JhdGVfcmVnKSB7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MTYgcmVnX3ZhbDsKPiA+ICsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaV9yZWFkX2NvbmZpZ193b3JkKHRvX3BjaV9kZXYo
ZGV2KSwKPiA+IGRkcl9kYXRhX3JhdGVfcmVnLT5vZmZzZXQsICZyZWdfdmFsKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlc3AgPSAocmVnX3ZhbCA+PiBkZHJfZGF0YV9yYXRl
X3JlZy0+c2hpZnQpICYKPiA+IGRkcl9kYXRhX3JhdGVfcmVnLT5tYXNrOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzcCA9IChyZXNwICogMzMzMykgLyAxMDA7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHJldF9yZXNwOwo+ID4gK8KgwqDCoMKgwqDC
oCB9Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCByZXQgPSBwcm9jZXNzb3JfdGhlcm1hbF9zZW5k
X21ib3hfcmVhZF9jbWQodG9fcGNpX2RldihkZXYpLAo+ID4gaWQsICZyZXNwKTsKPiA+IMKgwqDC
oMKgwqDCoMKgIGlmIChyZXQpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHJldDsKPiA+IAo+ID4gK3JldF9yZXNwOgo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHN5
c2ZzX2VtaXQoYnVmLCAiJWxsdVxuIiwgcmVzcCk7Cj4gPiDCoH0KPiA+IAo+ID4gQEAgLTQ2MSw2
ICs0NzYsNyBAQCBpbnQgcHJvY190aGVybWFsX3JmaW1fYWRkKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LAo+ID4gc3RydWN0IHByb2NfdGhlcm1hbF9kZXZpY2UgKnByb2MKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjYXNlIFBDSV9ERVZJQ0VfSURfSU5URUxfTlZMX0hfVEhFUk1BTDoK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFBDSV9ERVZJQ0VfSURfSU5U
RUxfTlZMX1NfVEhFUk1BTDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGx2cl9tbWlvX3JlZ3NfdGFibGUgPSBudmxfZGx2cl9tbWlvX3JlZ3M7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGRyX2RhdGFf
cmF0ZV9yZWcgPSAmbnZsX2Rkcl9kYXRhX3JhdGVfcmVnOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZWZhdWx0Ogo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkbHZyX21taW9fcmVnc190YWJsZSA9IGRsdnJfbW1pb19yZWdzOwo+
ID4gLS0KPiAKPiBBcHBsaWVkIGFzIDcuMSBtYXRlcmlhbCwgYnV0IEkgcmVhcnJhbmdlZCBpdCB0
byBhdm9pZCB1c2luZyBnb3RvIGFuZAo+IGRlY2xhcmUgbG9jYWwgdmFycyB3aGVyZSB0aGV5IGFy
ZSBuZWVkZWQsIHBsZWFzZSBzZWU6CgpMb29rcyBnb29kLgoKVGhhbmtzLApTcmluaXZhcwoKPiAK
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9yYWZhZWwv
bGludXgtcG0uZ2l0L3BhdGNoLz9pZD02ZDNlMmNlNmYxMDEwN2MyZTU4NzBlOWRjZTdjMmUxZDAz
YTZiZTcyCg==


