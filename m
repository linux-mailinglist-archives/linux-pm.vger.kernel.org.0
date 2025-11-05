Return-Path: <linux-pm+bounces-37477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB09C374BD
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 19:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F04E4E3F5D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88400283FD8;
	Wed,  5 Nov 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAMHAa8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702027E06C
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367225; cv=none; b=KZ19q9PGzHo/BK7NnZIlNigLEkn8JYi5P1ydk8sZBUuAllxMgW0B0DwNkGGxuud8xIfnFSzFmWzma+k2Eywalq/+WhUWPlv37WepQEQzupsRtboVIDAP7nYSogCYaO/hSSkwDZZpn82kpHHAzrQNd9ufra7KU7fyT82T4495IlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367225; c=relaxed/simple;
	bh=uXdwPX+sqwNaiMNWlx1OGxjphxNRGZBzbCCFWA8AB1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pveAFMKFRLg/3emXtzX/1GyqT1BlH7hEKC+QM2qBg8m5+FEmvez626DKJJdG5geGRBZ3dNktQJLqlFdb9BsdcTxXN4rNjBT1J1PbmEK0trJi7lOnFluLMhXG7dUff0H9B17kqclTnTCqEBOvFQiXJKCIqiLb0e5Ezy5Q8VROfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAMHAa8S; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762367223; x=1793903223;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=uXdwPX+sqwNaiMNWlx1OGxjphxNRGZBzbCCFWA8AB1Q=;
  b=NAMHAa8SqoYhM3wiFZm5IFuLIHrD8ZD+kCeVLRpEu9U0A3y8+2lMyFRS
   3pKNZsMiM8fEJ6cFhB5oNmAl/9yz97wjYH1wgAI5M5NrveE3UL0G1s2+z
   CB9pTUUItRk879aw9h+PvnXDPJ2FGdBelfEeBr4UuQVZefeYDEngE4XPE
   yenRcL2Q+7uC1keSIiAM/r4Wl3aKwKau4mikiZQXCLTx8IfekH7Q5C6oR
   apb5lzz9cA+SvvoSgjfQPPyY2KFDdECXKhi0qRZM+HMsj8R7oCZDNZbgK
   AgYNC6/fI2U5bX1Ezg+LyEywMYC9ZO5CIwS7zo81xLWrsL6aH2D4rCKwM
   A==;
X-CSE-ConnectionGUID: 1kxP6oeWRQ6c6XVGGtGVpw==
X-CSE-MsgGUID: ZJPP+uhyQgKpH+684E1kyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64406563"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208,223";a="64406563"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:27:02 -0800
X-CSE-ConnectionGUID: 4Nee4X9MQamXTCuLgQ78mw==
X-CSE-MsgGUID: Q5MvtlIdS3yvy0ltE+N/Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208,223";a="192594309"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:27:02 -0800
Message-ID: <ea04e2c8d6f31354bbd96835498c3384cbccea44.camel@linux.intel.com>
Subject: Re: Disabling  Intel turbo on non IDA featured processor generally
 correct?
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org, ez2blost@yahoo.com
Date: Wed, 05 Nov 2025 10:27:01 -0800
In-Reply-To: <5615342.jMkzrH9lRO@linux.fritz.box>
References: <2764104.vuYhMxLoTh@localhost.localdomain>
	 <356b1c77ef385158d062ad2ecebfa275dc663017.camel@linux.intel.com>
	 <5615342.jMkzrH9lRO@linux.fritz.box>
Content-Type: multipart/mixed; boundary="=-zwuTUIE9zIpeCjPXys6B"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-zwuTUIE9zIpeCjPXys6B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-11-05 at 15:55 +0100, Thomas Renninger wrote:
> On Mittwoch, 5. November 2025 14:06:42 Mitteleurop=C3=A4ische Normalzeit
> srinivas=20
> pandruvada wrote:
> > Hi Thomas,
> >=20
> > The BIOS shipped with system disabled turbo on boot and user had to
> > manually force via the sysfs. With the new change that is not an
> > option.
>=20
> User (adding EZ, sorry for missing you out on initial post)
> claims that cpuid shows:
> So I ran the cpuid commend and it returned:
> Thermal and Power Management Features (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 digital thermometer=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D true
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Intel Turbo Boost Technology=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D true
> =C2=A0...
>=20
> Not sure whether this really is the same bit and whether this is
> prove that=20
> IDA feature bit has been switched by Linux OS (by
> SMI/firmware?)Fixes: 0fb5be7fea98 ("cpufreq: intel_pstate: Unchecked
> MSR aceess in legacy mode") after=20
> initializing?
>=20
> IDA cpufeature bit is not set in /proc/cpuinfo
>=20
> EZ probably can do the one or other msr read/write if you need
> someone tests.
>=20
If the BIOS does it correctly there is a way to know as the limits can
be dynamic.

Here probably we need to reevaluate again. Try the attached change and
check if this brings back the old hack.

Thanks,
Srinivas


> Good luck,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thomas
> >=20
> > We are trying to contact the manufacturer, but no solution yet.
>=20
> That is appreciated!

--=-zwuTUIE9zIpeCjPXys6B
Content-Disposition: attachment;
	filename*0=0001-cpufreq-intel_pstate-Reevaluate-IDA-presence-on-no_t.pat;
	filename*1=ch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-cpufreq-intel_pstate-Reevaluate-IDA-presence-on-no_t.patch";
	charset="UTF-8"

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


--=-zwuTUIE9zIpeCjPXys6B--

