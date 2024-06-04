Return-Path: <linux-pm+bounces-8554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB58FA911
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 06:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85211288E90
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590077A1E;
	Tue,  4 Jun 2024 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDaeMHzc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88638B;
	Tue,  4 Jun 2024 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474262; cv=none; b=M7ltltlPhSEVXHgiqr91ieod25rgPEaV83r74VLDyVf4yHvw5n5iaO/sZfXNaE2HnE7v83eCbN5GIXlDzr0HeKegbIzWzxULRDr39Z/MrMt+GNly/RIyQoi/WetwDZxzOmBWC3z8I7ebBdWyJsrZnD0XdcaucKN85rqLpBrjLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474262; c=relaxed/simple;
	bh=V4KluvoWkwV2P4uaGIEl7A5QHSvGKNicvM2NHo8q6Wo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VE69VzVFDc51VBN4uU88J3A8AFRHsqzT53fr3AsHttjIBeuiO5V5FtvUElG4JUXNk8LYsm3hMd+GJ/psvwjysEKGXYFWlxYo/0nXozcxcMp/W3fq8WA7kQ+jliP7EoOxnJDkowPeDBKYMPuZkCcQ+XO8Qglf5VftXwDTioKFEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDaeMHzc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717474260; x=1749010260;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=V4KluvoWkwV2P4uaGIEl7A5QHSvGKNicvM2NHo8q6Wo=;
  b=mDaeMHzcRSKiyV3ZMCq4Znp/oZBr41AaQXwERojr7wFL9VAlFTtDlpvw
   oFNU+/IEJJDmgH4lvZMrj0xlVJ5Xnm7/jmNPxYE7LR06BgSDtFHhotUUZ
   OynGYg4Yg+TKiFgnqMMxYg6woMJow0ppqk7dIRwS3fkm+lrn69acFmCiU
   iJzQalCj3iVIjJsTJAPCD39B7yalN/3AzLN6vr6lAG1TipUIkI/XbA80U
   wTO7CsOC6JJKzUXFuqJb5VIYSRtP3dX9rAipg4XoFzYgl543Kq/lHyvtf
   yrWf5TBnQhwyLonFCArJWWIYtQBEMLLiWQNuI9iDaUzSgRAG5ppOH1VuB
   A==;
X-CSE-ConnectionGUID: JyLduJcbTIyhydBGr+e52g==
X-CSE-MsgGUID: GfdPJbhKQ52i5GXI8hu0Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13745901"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="diff'?scan'208";a="13745901"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 21:10:59 -0700
X-CSE-ConnectionGUID: gvVzj0xYSHaordRM41UEIw==
X-CSE-MsgGUID: 3ND538SvSgGxEQ7O0M+T1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="diff'?scan'208";a="42178678"
Received: from lduvvuri-mobl4.gar.corp.intel.com ([10.213.76.60])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 21:10:52 -0700
Message-ID: <96e2cf88d11233c8e6fdc5378fc18956584e5692.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Mon, 03 Jun 2024 21:10:36 -0700
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
Content-Type: multipart/mixed; boundary="=-RZpSQ4b5F/nRSN0sX4ln"
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-RZpSQ4b5F/nRSN0sX4ln
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
Try the attached diff for this case.

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


--=-RZpSQ4b5F/nRSN0sX4ln
Content-Disposition: attachment; filename="delayed_turbo_check.diff"
Content-Type: text/x-patch; name="delayed_turbo_check.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwppbmRleCA2NWQzZjc5MTA0YmQuLjQwYThmOWQ4NmI1OSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCisrKyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwpAQCAtMzEwMiw2ICszMTAyLDIwIEBAIHN0YXRpYyB2b2lkIGlu
dGVsX3BzdGF0ZV9kcml2ZXJfY2xlYW51cCh2b2lkKQogCWludGVsX3BzdGF0ZV9kcml2ZXIgPSBO
VUxMOwogfQogCitzdGF0aWMgdm9pZCBjaGVja190dXJib193b3JrX2hhbmRsZXIoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQoreworCWdsb2JhbC50dXJib19kaXNhYmxlZCA9IHR1cmJvX2lzX2Rp
c2FibGVkKCk7CisKKwlpZiAoZ2xvYmFsLnR1cmJvX2Rpc2FibGVkKQorCQlyZXR1cm47CisKKwln
bG9iYWwubm9fdHVyYm8gPSBnbG9iYWwudHVyYm9fZGlzYWJsZWQ7CisJaW50ZWxfcHN0YXRlX3Vw
ZGF0ZV9saW1pdHNfZm9yX2FsbCgpOworCWFyY2hfc2V0X21heF9mcmVxX3JhdGlvKGZhbHNlKTsK
K30KKworREVDTEFSRV9ERUxBWUVEX1dPUksodHVyYm9fd29yaywgY2hlY2tfdHVyYm9fd29ya19o
YW5kbGVyKTsKKwogc3RhdGljIGludCBpbnRlbF9wc3RhdGVfcmVnaXN0ZXJfZHJpdmVyKHN0cnVj
dCBjcHVmcmVxX2RyaXZlciAqZHJpdmVyKQogewogCWludCByZXQ7CkBAIC0zMTE0LDYgKzMxMjgs
OSBAQCBzdGF0aWMgaW50IGludGVsX3BzdGF0ZV9yZWdpc3Rlcl9kcml2ZXIoc3RydWN0IGNwdWZy
ZXFfZHJpdmVyICpkcml2ZXIpCiAJZ2xvYmFsLnR1cmJvX2Rpc2FibGVkID0gdHVyYm9faXNfZGlz
YWJsZWQoKTsKIAlnbG9iYWwubm9fdHVyYm8gPSBnbG9iYWwudHVyYm9fZGlzYWJsZWQ7CiAKKwlp
ZiAoZ2xvYmFsLnR1cmJvX2Rpc2FibGVkKQorCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnR1cmJv
X3dvcmssIEhaKTsKKwogCWFyY2hfc2V0X21heF9mcmVxX3JhdGlvKGdsb2JhbC50dXJib19kaXNh
YmxlZCk7CiAKIAlpbnRlbF9wc3RhdGVfZHJpdmVyID0gZHJpdmVyOwo=


--=-RZpSQ4b5F/nRSN0sX4ln--

