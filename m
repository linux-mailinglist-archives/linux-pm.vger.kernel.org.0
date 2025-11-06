Return-Path: <linux-pm+bounces-37534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55472C3C0A9
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 16:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D422E3B1946
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9BE26B971;
	Thu,  6 Nov 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjgpfyVn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349781EEA5D;
	Thu,  6 Nov 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442597; cv=none; b=mdAuTuE6pRpYtr+9rhFcNQ2ziLWqlX6GPJcvrEsQvPcyPE3ArVB9VSL2glbmzGOgzgROsOX/lUtbDBgSNylebO/dzCA7Fg41v3w3pkjawYG3M5UDJ92v4pGAGcz08/aS5tTKzu3b8yBwYHFMe1JmVhz+gl9Z3tzTPN5v0dzGf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442597; c=relaxed/simple;
	bh=8rLgUPOR8E20yMDM0k3KiaiNTkBo2G8LCQ43Qy2tGr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwCAyAcsG8I0EZYO2MDVLg895dvHcnqwplMcpxUbl1yft3Jyw3ZRdxMBo6ey4ahbk7pv+QlcFM7VrxIpAnoLc7gEmf5pZf9cOCQyuvCgy86SSywgc+/KDDfT1xjFW9k3O7qQCFIK+8WW2rADH8I5MMSlqnKLs/y3FJFQT61cwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjgpfyVn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762442595; x=1793978595;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=8rLgUPOR8E20yMDM0k3KiaiNTkBo2G8LCQ43Qy2tGr0=;
  b=fjgpfyVnH58Qn+mr4e7R54K85g/UEW1sfSwo2Y2ghnaQiWgm7tTOTAG6
   blHDOOgsuXFto66/Vy2qZz0/lY9KNVbATUI+GVTSv0w56kTo8nd/nZFq1
   OcqJepw/BPbxKUZBNPX0h7PyDS9jbhyESlJosqnmHfE/QYtGhJl9Tn9UT
   lxjjOApFgc4dYCCxEgf2iGk+DcdfTHWjgW4vfBp8bRpmxiFEdmKv4xY+N
   t6THs+HrT7YIgdjFRHJ6pJonwmNqWHqtXQd6DNaEpxG3BATZE5lTHVVvR
   OlUtn84B91wNo2aCunJl8yaLc4r5sqr9lzl2H7UGP9opsBPlCAOxaW3LB
   g==;
X-CSE-ConnectionGUID: P11XMnkRTfOQqs2J6FK1yg==
X-CSE-MsgGUID: 3zk2MINYQVSkeLR8NCnykQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68419838"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208,223";a="68419838"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:23:14 -0800
X-CSE-ConnectionGUID: GVB1ZkyuTUSZtamOqDBi4w==
X-CSE-MsgGUID: tivEWLwMRBWUdH7AlB1K/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208,223";a="187941968"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:23:15 -0800
Message-ID: <db92b8a310d88214e2045a73d3da6d0ffe8606f7.camel@linux.intel.com>
Subject: Re: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 	mmikowski@kfocus.org
Date: Thu, 06 Nov 2025 07:23:14 -0800
In-Reply-To: <20250910153329.10dcef9d@kf-m2g5>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
		<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
		<20250910113650.54eafc2b@kf-m2g5>
		<dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
	 <20250910153329.10dcef9d@kf-m2g5>
Content-Type: multipart/mixed; boundary="=-v2j8C3jhV+V4YO2nDGiS"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-v2j8C3jhV+V4YO2nDGiS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Wed, 2025-09-10 at 15:33 -0500, Aaron Rainbolt wrote:
> On Wed, 10 Sep 2025 10:15:00 -0700
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > On Wed, 2025-09-10 at 11:36 -0500, Aaron Rainbolt wrote:
> > > On Wed, 30 Apr 2025 16:29:09 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > =C2=A0=20
> > > > On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:=C2=A0=20
> > > > >=20
> > > > > When turbo mode is unavailable on a Skylake-X system,
> > > > > executing
> > > > > the
> > > > > command:
> > > > > "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > > > > results in an unchecked MSR access error: WRMSR to 0x199
> > > > > (attempted to write 0x0000000100001300).
Please try the attached patch, if this address this issue.

Thanks,
Srinivas

--=-v2j8C3jhV+V4YO2nDGiS
Content-Disposition: attachment;
	filename*0=0001-cpufreq-intel_pstate-Reevaluate-IDA-presence-on-no_t.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-cpufreq-intel_pstate-Reevaluate-IDA-presence-on-no_t.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA0MDVkMjdlODcxZjdiYzg1YTc4NmY4NDg3N2EzNWRhNTRjODEzYjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogV2VkLCA1IE5vdiAyMDI1IDA5OjU3OjAzIC0wODAw
ClN1YmplY3Q6IFtQQVRDSF0gY3B1ZnJlcTogaW50ZWxfcHN0YXRlOiBSZWV2YWx1YXRlIElEQSBw
cmVzZW5jZSBvbiBub190dXJibwogYXR0cmlidXRlIGNoYW5nZQoKSWYgaGFyZHdhcmUgZGlzYWJs
ZWQgSURBIChJbnRlbCBEeW5hbWljIEFjY2VsZXJhdGlvbiB0ZWNobm9sb2d5KSBmZWF0dXJlCmJl
Zm9yZSBPUyBib290LCB0dXJibyBtb2RlIHN1cHBvcnQgd2lsbCBiZSBkaXNhYmxlZCBwZXJtYW5l
bnRseS4gSW4gdGhpcwpjYXNlIENQVUlELjA2SDogRUFYWzFdIHJlcG9ydHMgMCBhbmQgYXR0cmli
dXRlCiIvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9pbnRlbF9wc3RhdGUvbm9fdHVyYm8iIHdpbGwg
c2hvdyAiMSIgYW5kIHN0YXR1cwpjYW4ndCBiZSBjaGFuZ2VkIHRvICIwIi4KCldoZW4gbm9fdHVy
Ym8gaXMgd3JpdHRlbiB3aXRoIDAsIGluIHRoaXMgY2FzZSBldmFsdWF0ZSBDUFVJRC4wNkg6IEVB
WFsxXQphZ2Fpbi4gSWYgdGhlIGZlYXR1cmUgc3RhdHVzIGlzIGNoYW5nZWQgdG8gMSBwb3N0IE9T
IGJvb3QgdGhlbiBhbGxvdyB0bwplbmFibGUgdHVyYm8gbW9kZS4KClNpZ25lZC1vZmYtYnk6IFNy
aW5pdmFzIFBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPgot
LS0KIGRyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyB8IDcgKysrKysrLQogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyBiL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUu
YwppbmRleCA0M2U4NDdlOWY3NDEuLjBlYzQ1YTYxMGI0NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9j
cHVmcmVxL2ludGVsX3BzdGF0ZS5jCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUu
YwpAQCAtNTk2LDEwICs1OTYsMTUgQEAgc3RhdGljIHZvaWQgaW50ZWxfcHN0YXRlX2h5YnJpZF9o
d3BfYWRqdXN0KHN0cnVjdCBjcHVkYXRhICpjcHUpCiAKIHN0YXRpYyBib29sIHR1cmJvX2lzX2Rp
c2FibGVkKHZvaWQpCiB7CisJdW5zaWduZWQgaW50IGVheCwgZWJ4LCBlY3gsIGVkeDsKIAl1NjQg
bWlzY19lbjsKIAotCWlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9JREEpKQor
CWVheCA9IDA7CisJY3B1aWQoNiwgJmVheCwgJmVieCwgJmVjeCwgJmVkeCk7CisJaWYgKCEoZWF4
ICYgQklUKDEpKSkgeworCQlwcl9pbmZvKCJUdXJibyBpcyBkaXNhYmxlZFxuIik7CiAJCXJldHVy
biB0cnVlOworCX0KIAogCXJkbXNybChNU1JfSUEzMl9NSVNDX0VOQUJMRSwgbWlzY19lbik7CiAK
LS0gCjIuNDMuMAoK


--=-v2j8C3jhV+V4YO2nDGiS--

