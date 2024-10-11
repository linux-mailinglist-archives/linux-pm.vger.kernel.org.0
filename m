Return-Path: <linux-pm+bounces-15513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F2999832
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 02:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CA11F23DBC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B210E9;
	Fri, 11 Oct 2024 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nimq0txL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25604A06;
	Fri, 11 Oct 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607397; cv=none; b=EMcISk5DFHkYHIPmG9+/+ziY7l9J2MgYjCY3Zy/mD6Sp0d0apVbgZdvg9kSXusP722t+EdrouxTr1CiaAcNjwJuNwelz8o3ooSF+eAcUTKvXQfjFoyswf1av+mzqd+LjAS0mS6g+221rF/MIvgKLNlfLKr60whtoJvnGzFAfc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607397; c=relaxed/simple;
	bh=iYJp4eSJQ2KXVkFhqdy/nUnZerhnl4mJAolctJnsTZM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Yj1OlTm6tNCWMjDU5qm7QCNyK6DRkUzHFvVtThRnKBOHOJgktv1RcSRTmnDQP6EBSFnzsjOzbVf+nbmnn/wbLSFZeWgvRxQpj9S9LVghQQZ6WXr9Uh1SrQFGiUD873NFGlpu4KCUrmX14ssXr7fst7u23lYsPyg+tPINbmL9LB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nimq0txL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728607396; x=1760143396;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=iYJp4eSJQ2KXVkFhqdy/nUnZerhnl4mJAolctJnsTZM=;
  b=nimq0txLdOqxzx1KA247/MN6hG+LciJSohU7VH2FVUKsfanJrJe4/+13
   bH3CgI2eaIieoZ2hFBL/f5rFYpcJnd/NsM9txz7xW+FiGuOxPVab1BOTW
   HYjPr3H0wTzDk5+juO/uJ4eV4vigEZ6drrG2FjOQV3ZU9MGTmm70GLg4P
   /11P3nbQzwIzLGHFJydTi1aWznE577GEF7XYnKUe7J1XdSUtNisBvpCiA
   YITF7pRaoTIULCZVDNVZEzYSqytrSjzj+qTBrGPeML/jvLnJcPmnc/SE5
   qrG4+a36TuEZ5Lpeh3dGXlozAS6/cpVlp2pbW8uINe1ZgSwpatoGgaUab
   Q==;
X-CSE-ConnectionGUID: 5lXIWfJbT7+baCYoMZRcoQ==
X-CSE-MsgGUID: z5CI+BQjTl+O+Zk+g0RLUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31894997"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="31894997"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 17:43:13 -0700
X-CSE-ConnectionGUID: QPUvuqsQS9qkQTJ75zErMg==
X-CSE-MsgGUID: KuTpH3KmQba8LVTxIi+t2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76850489"
Received: from msangele-mobl.amr.corp.intel.com (HELO [10.124.223.138]) ([10.124.223.138])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 17:43:13 -0700
Content-Type: multipart/mixed; boundary="------------k7TWJbYEKR9d03TLeEKm4CLy"
Message-ID: <edb18687-9cd7-439e-b526-0eda6585e386@intel.com>
Date: Thu, 10 Oct 2024 17:43:12 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
 x86@kernel.org, linux-pm@vger.kernel.org, hpa@zytor.com,
 peterz@infradead.org, thorsten.blum@toblux.com, yuntao.wang@linux.dev,
 tony.luck@intel.com, len.brown@intel.com, srinivas.pandruvada@intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241009072001.509508-1-rui.zhang@intel.com>
 <f568dbbc-ac60-4c25-80d1-87e424bd649c@intel.com>
 <CAJZ5v0gHn9iOPZXgBPA7O0zcN=S89NBP4JFsjpdWbwixtRrqqQ@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAJZ5v0gHn9iOPZXgBPA7O0zcN=S89NBP4JFsjpdWbwixtRrqqQ@mail.gmail.com>

This is a multi-part message in MIME format.
--------------k7TWJbYEKR9d03TLeEKm4CLy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

How about something like the completely untested attached patch?

IMNHO, it improves on what was posted here because it draws a parallel
with an AMD erratum and also avoids writes to APIC_TMICT that would get
ignored anyway.
--------------k7TWJbYEKR9d03TLeEKm4CLy
Content-Type: text/x-patch; charset=UTF-8; name="deadline1.patch"
Content-Disposition: attachment; filename="deadline1.patch"
Content-Transfer-Encoding: base64

U3ViamVjdDogeDg2L2FwaWM6IEFsd2F5cyBleHBsaWNpdGx5IGRpc2FybSBUU0MtZGVhZGxp
bmUgdGltZXIKCk5ldyBwcm9jZXNzb3JzIGhhdmUgYmVjb21lIHBpY2tpZXIgYWJvdXQgdGhl
IGxvY2FsIEFQSUMgdGltZXIgc3RhdGUKYmVmb3JlIGVudGVyaW5nIGxvdyBwb3dlciBtb2Rl
cy4gVGhlc2UgbG93IHBvd2VyIG1vZGVzIGFyZSB1c2VkIChmb3IKZXhhbXBsZSkgd2hlbiB5
b3UgY2xvc2UgeW91ciBsYXB0b3AgbGlkIGFuZCBzdXNwZW5kLiBJZiB5b3UgcHV0IHlvdXIK
bGFwdG9wIGluIGEgYmFnIGluIHRoaXMgdW5uZWNlc3NhcmlseS1oaWdoLXBvd2VyIHN0YXRl
LCBpdCBpcyBsaWtlbHkKdG8gZ2V0IHF1aXRlIHRvYXN0eSB3aGlsZSBpdCBxdWlja2x5IHN1
Y2tzIHRoZSBiYXR0ZXJ5IGRyeS4KClRoZSBwcm9ibGVtIGJvaWxzIGRvd24gdG8gc29tZSBD
UFVzJyBpbmFiaWxpdHkgdG8gcG93ZXIgZG93biB1bnRpbCB0aGUKa2VybmVsIGZ1bGx5IGRp
c2FibGVzIHRoZSBsb2NhbCBBUElDIHRpbWVyLiBUaGUgY3VycmVudCBrZXJuZWwgY29kZQp3
b3JrcyBpbiBvbmUtc2hvdCBhbmQgcGVyaW9kaWMgbW9kZXMgYnV0IGRvZXMgbm90IHdvcmsg
Zm9yIGRlYWRsaW5lCm1vZGUuIERlYWRsaW5lIG1vZGUgaGFzIGJlZW4gdGhlIHN1cHBvcnRl
ZCBhbmQgcHJlZmVycmVkIG1vZGUgb24KSW50ZWwgQ1BVcyBmb3Igb3ZlciBhIGRlY2FkZSBh
bmQgdXNlcyBhbiBNU1IgdG8gZHJpdmUgdGhlIHRpbWVyCmluc3RlYWQgb2YgYW4gQVBJQyBy
ZWdpc3Rlci4KCkRpc2FibGUgdGhlIFRTQyBEZWFkbGluZSB0aW1lciBpbiBsYXBpY190aW1l
cl9zaHV0ZG93bigpIGJ5IHdyaXRpbmcgdG8KTVNSX0lBMzJfVFNDX0RFQURMSU5FIHdoZW4g
aW4gVFNDLWRlYWRsaW5lIG1vZGUuIEFsc28gYXZvaWQgd3JpdGluZwp0byB0aGUgaW5pdGlh
bC1jb3VudCByZWdpc3RlciAoQVBJQ19UTUlDVCkgd2hpY2ggaXMgaWdub3JlZCBpbgpUU0Mt
ZGVhZGxpbmUgbW9kZS4KCk5vdGU6IFRoZSBBUElDX0xWVFR8PUFQSUNfTFZUX01BU0tFRCBv
cGVyYXRpb24gc2hvdWxkIHRoZW9yZXRpY2FsbHkgYmUKZW5vdWdoIHRvIHRlbGwgdGhlIGhh
cmR3YXJlIHRoYXQgdGhlIHRpbWVyIHdpbGwgbm90IGZpcmUgaW4gYW55IG9mIHRoZQp0aW1l
ciBtb2Rlcy4gQnV0IG1pdGlnYXRpbmcgQU1EIGVycmF0dW0gNDExWzFdIGFsc28gcmVxdWly
ZXMgY2xlYXJpbmcKb3V0IEFQSUNfVE1JQ1QuIFNvbGVseSBzZXR0aW5nIEFQSUNfTFZUX01B
U0tFRCBpcyBhbHNvIGluZWZmZWN0aXZlIGluCnByYWN0aWNlIG9uIEludGVsIEx1bmFyIExh
a2Ugc3lzdGVtcywgd2hpY2ggaXMgdGhlIG1vdGl2YXRpb24gZm9yIHRoaXMKY2hhbmdlLgoK
MS4gNDExIFByb2Nlc3NvciBNYXkgRXhpdCBNZXNzYWdlLVRyaWdnZXJlZCBDMUUgU3RhdGUg
V2l0aG91dCBhbiBJbnRlcnJ1cHQgaWYgTG9jYWwgQVBJQyBUaW1lciBSZWFjaGVzIFplcm8g
LSBodHRwczovL3d3dy5hbWQuY29tL2NvbnRlbnQvZGFtL2FtZC9lbi9kb2N1bWVudHMvYXJj
aGl2ZWQtdGVjaC1kb2NzL3JldmlzaW9uLWd1aWRlcy80MTMyMl8xMGhfUmV2X0dkLnBkZiAK
CQkJCQkJCQkJCQkJCQkgICAgLy8KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hcGlj
L2FwaWMuYyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL2FwaWMuYwppbmRleCA2NTEzYzUzYzk0
NTllLi41NDM2YTQwODMwNjVkIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9h
cGljLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpYy5jCkBAIC00NDAsNyArNDQw
LDE5IEBAIHN0YXRpYyBpbnQgbGFwaWNfdGltZXJfc2h1dGRvd24oc3RydWN0IGNsb2NrX2V2
ZW50X2RldmljZSAqZXZ0KQogCXYgPSBhcGljX3JlYWQoQVBJQ19MVlRUKTsKIAl2IHw9IChB
UElDX0xWVF9NQVNLRUQgfCBMT0NBTF9USU1FUl9WRUNUT1IpOwogCWFwaWNfd3JpdGUoQVBJ
Q19MVlRULCB2KTsKLQlhcGljX3dyaXRlKEFQSUNfVE1JQ1QsIDApOworCisJLyoKKwkgKiBT
ZXR0aW5nIEFQSUNfTFZUX01BU0tFRCBzaG91bGQgYmUgZW5vdWdoIHRvIHRlbGwgdGhlCisJ
ICogaGFyZHdhcmUgdGhhdCB0aGlzIHRpbWVyIHdpbGwgbmV2ZXIgZmlyZS4gQnV0IEFNRAor
CSAqIGVycmF0dW0gNDExIGFuZCBzb21lIEludGVsIENQVSBiZWhhdmlvciBjaXJjYSAyMDI0
CisJICogc2F5IG90aGVyd2lzZS4gVGltZSBmb3IgYmVsdCBhbmQgc3VzcGVuZGVycyBwcm9n
cmFtbWluZywKKwkgKiBtYXNrIHRoZSB0aW1lciBhbmQgemVybyB0aGUgY291bnRlciByZWdp
c3RlcnM6CisJICovCisJaWYgKHYgJiBBUElDX0xWVF9USU1FUl9UU0NERUFETElORSkKKwkJ
d3Jtc3JsKE1TUl9JQTMyX1RTQ19ERUFETElORSwgMCk7CisJZWxzZQorCQlhcGljX3dyaXRl
KEFQSUNfVE1JQ1QsIDApOworCiAJcmV0dXJuIDA7CiB9CiAK

--------------k7TWJbYEKR9d03TLeEKm4CLy--

