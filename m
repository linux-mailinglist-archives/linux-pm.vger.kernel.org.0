Return-Path: <linux-pm+bounces-8555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C08FA939
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 06:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE302837B6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1B13D2AA;
	Tue,  4 Jun 2024 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdMAT8XX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3104C6E;
	Tue,  4 Jun 2024 04:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717475486; cv=none; b=UUoaf7jJqCEiK51aSfcJ/vEOqFoT2ify4z6Iiq8HqGYSRcJoDZMm0oLI7w9RtJCVGJS/NAnAd/zLEXcd9OywTXeIcE56JXX8ejpWFeVdXDyRp+WGs4qbjK/oOMzTYel212DtVYLYXoJVj8bLaroO+joBssN/eBHUYDM8c0ywEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717475486; c=relaxed/simple;
	bh=ZOIhYMK45qMAdlxWSgbaH5uMu9B2w0q6QufDWFxPaYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLVVHCIGlV8dWgQbNMUa88Hr1F98NqOgVpeaKQIxBnygHf4a7sSrH78QuAXTI2AlYhRYiSktfeCt52v5ObwnwjALFn7YffsnaFHitlBBWGqW54Pm1EZJwe9D75W14EI445odXbCnwPTDHjXzZnkX8g4EoVR7lpnjv5pqXH0QVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdMAT8XX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717475485; x=1749011485;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=ZOIhYMK45qMAdlxWSgbaH5uMu9B2w0q6QufDWFxPaYo=;
  b=mdMAT8XXdixP6su3nn77gqzdO2TB0h6dTEvIN8eGFXs/RNbDOPTDnH2y
   SPWRegI2I3QwfNzSy3Oi6pY22d4RKQoHDb+urowp0ZkQPQgml0OLNiRnp
   1MEpmO6tyXCZYxwdax6MOVtsVfJWUk7jxIjyTZuxkCUNCo76WwqXDedcx
   MKsZYopgXysdEiHwJc/XEo+qLhOah3keVuyP/IGCkYtzU6WsIBNHeEpKD
   84XUshDXvvCIm+dVrfbslg6Ls9809ief9krHqjk8sutwqLzl2eWLSprBP
   l2NiMQPQIrrBbefgwI3oYPvSpxbwkzPMhTaGDq+7WyHDwAFQTM/q6WWrU
   A==;
X-CSE-ConnectionGUID: kNg2+DwCQWWLGEePQS/lVw==
X-CSE-MsgGUID: xzTL6kKfSCSNXRYEh0N9+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17823698"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="diff'?scan'208";a="17823698"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 21:31:24 -0700
X-CSE-ConnectionGUID: jHw8XOoWT56vplntm1N45Q==
X-CSE-MsgGUID: AKzgQc4XQHm+3U/nPmkM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="diff'?scan'208";a="42039354"
Received: from lduvvuri-mobl4.gar.corp.intel.com ([10.213.76.60])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 21:31:15 -0700
Message-ID: <1da736da33a61de92314934ecf7fa0420d6d6b81.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Mon, 03 Jun 2024 21:31:05 -0700
In-Reply-To: <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
	 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
	 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
	 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
	 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
	 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
	 <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
	 <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
	 <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
Content-Type: multipart/mixed; boundary="=-1DKVhCk43lRzjNd4C31L"
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-1DKVhCk43lRzjNd4C31L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-06-03 at 11:47 -0700, srinivas pandruvada wrote:
> On Mon, 2024-06-03 at 20:32 +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 3, 2024 at 7:44=E2=80=AFPM Xi Ruoyao <xry111@xry111.site>
> > wrote:
> > >=20
> > > On Mon, 2024-06-03 at 10:11 -0700, srinivas pandruvada wrote:
> > > > On Mon, 2024-06-03 at 21:12 +0800, Xi Ruoyao wrote:
> > > > > On Sun, 2024-06-02 at 16:11 -0700, srinivas pandruvada wrote:
> > > > >=20
> > > > > /* snip */
> > > > >=20
> > > > > > What is the output of:
> > > > > > grep . /sys/devices/system/cpu/intel_pstate/*
> > > > > >=20
> > > > > > Also
> > > > > > rdmsr 0x771
> > > > > > rdmsr 0x774
> > > > > >=20
> > > > > >=20
> > > > > > Try these three patches. Don't worry about the commit
> > > > > > description
> > > > > > for
> > > > > > this issue.
> > > > >=20
> > > > > Unfortunately they still do not fix the issue for me.
> > > > >=20
> > > > > The outputs of grep and rdmsr commands are initially:
> > > > >=20
> > > > > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> > > > > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > > > > /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> > > > > /sys/devices/system/cpu/intel_pstate/no_turbo:1
> > > > > /sys/devices/system/cpu/intel_pstate/num_pstates:41
> > > > > /sys/devices/system/cpu/intel_pstate/status:active
> > > > > /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> > > > > rdmsr 0x771: 10d1f2c
> > > > > rdmsr 0x774: 1f04
> > > > >=20
> > > > > But it then changes to:
> > > > >=20
> > > > > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> > > > > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > > > > /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> > > > > /sys/devices/system/cpu/intel_pstate/no_turbo:1
> > > > > /sys/devices/system/cpu/intel_pstate/num_pstates:41
> > > > > /sys/devices/system/cpu/intel_pstate/status:active
> > > > > /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> > > > > rdmsr 0x771: 10c1f2c
> > > > > rdmsr 0x774: 1f04
> > > > >=20
> > > > > It seems only the output of rdmsr 0x771 has changed.=C2=A0 And if
> > > > > I
> > > > > read
> > > > > the
> > > > > SDM correctly it's a "Most_Efficient_Performance" change.
> > > > That is fine.
> > > >=20
> > > > We don't have any notifications either via ACPI or via HWP
> > > > interrupt.
> > > > I think it was working by chance before this change as by the
> > > > cpufreq
> > > > core is trying to set policy, the turbo is enabled by the
> > > > firmware.
> > > >=20
> > > > What is this laptop make and model?
> > >=20
> > > It's a Hasee X5-2021S5H.
> > >=20
> > > Hasee is known for producing some laptops very cheap but often
> > > having
> > > "minor" issues.=C2=A0 So I guess the firmware is doing some stupid
> > > thing.
> > >=20
> > > But turbo works just fine on Windows 11 so it'd be better if we
> > > could
> > > make it work for Linux too.
> >=20
> > In principle, there are two things that can be done about this.
> >=20
> > First, MSR_IA32_MISC_ENABLE_TURBO_DISABLE on this system can be
> > ignored altogether, but that would require adding a quirk.
> >=20
> > Second, a delayed work can be added to check the MSR long enough
> > after
> > initialization and update global.turbo_disabled if it is 1.=C2=A0
> > However,
> > that would require some code surgery.
>=20
Something like the attached which does same way as user space no_turbo
update.

Thanks,
Srinivas

> I was about to send this suggestion.
>=20
> For the first one we can always program the HWP_REQ.max to
> HWP_CAP.max
> and=C2=A0 let hardware do the clipping. But this is not friendly to
> passive
> mode. But display of scalig_max_freq still should reflect the
> reality.
>=20
>=20
> Thanks,
> Srinivas
>=20
> >=20
>=20
>=20


--=-1DKVhCk43lRzjNd4C31L
Content-Disposition: attachment; filename="delayed_turbo_check.diff"
Content-Type: text/x-patch; name="delayed_turbo_check.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwppbmRleCA2NWQzZjc5MTA0YmQuLjhkNjFmZjI2MWM2MSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCisrKyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwpAQCAtMTMwNSw3ICsxMzA1LDcgQEAgc3RhdGljIHNzaXplX3Qg
c3RvcmVfbm9fdHVyYm8oc3RydWN0IGtvYmplY3QgKmEsIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAq
YiwKIAlpZiAobm9fdHVyYm8gPT0gZ2xvYmFsLm5vX3R1cmJvKQogCQlnb3RvIHVubG9ja19kcml2
ZXI7CiAKLQlpZiAoZ2xvYmFsLnR1cmJvX2Rpc2FibGVkKSB7CisJaWYgKFJFQURfT05DRShnbG9i
YWwudHVyYm9fZGlzYWJsZWQpKSB7CiAJCXByX25vdGljZV9vbmNlKCJUdXJibyBkaXNhYmxlZCBi
eSBCSU9TIG9yIHVuYXZhaWxhYmxlIG9uIHByb2Nlc3NvclxuIik7CiAJCWNvdW50ID0gLUVQRVJN
OwogCQlnb3RvIHVubG9ja19kcml2ZXI7CkBAIC0xNzYyLDcgKzE3NjIsNyBAQCBzdGF0aWMgdTY0
IGF0b21fZ2V0X3ZhbChzdHJ1Y3QgY3B1ZGF0YSAqY3B1ZGF0YSwgaW50IHBzdGF0ZSkKIAl1MzIg
dmlkOwogCiAJdmFsID0gKHU2NClwc3RhdGUgPDwgODsKLQlpZiAoUkVBRF9PTkNFKGdsb2JhbC5u
b190dXJibykgJiYgIWdsb2JhbC50dXJib19kaXNhYmxlZCkKKwlpZiAoUkVBRF9PTkNFKGdsb2Jh
bC5ub190dXJibykgJiYgIVJFQURfT05DRShnbG9iYWwudHVyYm9fZGlzYWJsZWQpKQogCQl2YWwg
fD0gKHU2NCkxIDw8IDMyOwogCiAJdmlkX2ZwID0gY3B1ZGF0YS0+dmlkLm1pbiArIG11bF9mcCgK
QEAgLTE5MjcsNyArMTkyNyw3IEBAIHN0YXRpYyB1NjQgY29yZV9nZXRfdmFsKHN0cnVjdCBjcHVk
YXRhICpjcHVkYXRhLCBpbnQgcHN0YXRlKQogCXU2NCB2YWw7CiAKIAl2YWwgPSAodTY0KXBzdGF0
ZSA8PCA4OwotCWlmIChSRUFEX09OQ0UoZ2xvYmFsLm5vX3R1cmJvKSAmJiAhZ2xvYmFsLnR1cmJv
X2Rpc2FibGVkKQorCWlmIChSRUFEX09OQ0UoZ2xvYmFsLm5vX3R1cmJvKSAmJiAhUkVBRF9PTkNF
KGdsb2JhbC50dXJib19kaXNhYmxlZCkpCiAJCXZhbCB8PSAodTY0KTEgPDwgMzI7CiAKIAlyZXR1
cm4gdmFsOwpAQCAtMzEwMiw2ICszMTAyLDI5IEBAIHN0YXRpYyB2b2lkIGludGVsX3BzdGF0ZV9k
cml2ZXJfY2xlYW51cCh2b2lkKQogCWludGVsX3BzdGF0ZV9kcml2ZXIgPSBOVUxMOwogfQogCitz
dGF0aWMgdm9pZCBjaGVja190dXJib193b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQoreworCWJvb2wgbm9fdHVyYm87CisJCisJbm9fdHVyYm8gPSB0dXJib19pc19kaXNhYmxl
ZCgpOworCisJaWYgKG5vX3R1cmJvKQorCQlyZXR1cm47CisKKwkvKiBTYW1lIHByb2Nlc3Npbmcg
YXMgc3lzZnMgbm9fdHVyYm8gdXBkYXRlICovCisJbXV0ZXhfbG9jaygmaW50ZWxfcHN0YXRlX2Ry
aXZlcl9sb2NrKTsKKworCVdSSVRFX09OQ0UoZ2xvYmFsLnR1cmJvX2Rpc2FibGVkLCBub190dXJi
byk7CisJV1JJVEVfT05DRShnbG9iYWwubm9fdHVyYm8sIG5vX3R1cmJvKTsKKworCWludGVsX3Bz
dGF0ZV91cGRhdGVfbGltaXRzX2Zvcl9hbGwoKTsKKwlhcmNoX3NldF9tYXhfZnJlcV9yYXRpbyhm
YWxzZSk7CisKKwltdXRleF91bmxvY2soJmludGVsX3BzdGF0ZV9kcml2ZXJfbG9jayk7Cit9CisK
K0RFQ0xBUkVfREVMQVlFRF9XT1JLKHR1cmJvX3dvcmssIGNoZWNrX3R1cmJvX3dvcmtfaGFuZGxl
cik7CisKIHN0YXRpYyBpbnQgaW50ZWxfcHN0YXRlX3JlZ2lzdGVyX2RyaXZlcihzdHJ1Y3QgY3B1
ZnJlcV9kcml2ZXIgKmRyaXZlcikKIHsKIAlpbnQgcmV0OwpAQCAtMzExNCw2ICszMTM3LDkgQEAg
c3RhdGljIGludCBpbnRlbF9wc3RhdGVfcmVnaXN0ZXJfZHJpdmVyKHN0cnVjdCBjcHVmcmVxX2Ry
aXZlciAqZHJpdmVyKQogCWdsb2JhbC50dXJib19kaXNhYmxlZCA9IHR1cmJvX2lzX2Rpc2FibGVk
KCk7CiAJZ2xvYmFsLm5vX3R1cmJvID0gZ2xvYmFsLnR1cmJvX2Rpc2FibGVkOwogCisJaWYgKGds
b2JhbC50dXJib19kaXNhYmxlZCkKKwkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ0dXJib193b3Jr
LCBIWik7CisKIAlhcmNoX3NldF9tYXhfZnJlcV9yYXRpbyhnbG9iYWwudHVyYm9fZGlzYWJsZWQp
OwogCiAJaW50ZWxfcHN0YXRlX2RyaXZlciA9IGRyaXZlcjsK


--=-1DKVhCk43lRzjNd4C31L--

