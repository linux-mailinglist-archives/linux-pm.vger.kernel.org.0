Return-Path: <linux-pm+bounces-8398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97B8D41A9
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 01:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA2E1C21090
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 23:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186311CB31C;
	Wed, 29 May 2024 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yg+tCyZv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFB16E876
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024110; cv=none; b=TpLeUPvO3lrw+iKqNfyHJQ+l56AxFZ4OSp8KBAGPwK7aOPVHGNSTlzR/mdeZEv2rHJIo8ks4+7d3W5XnYtSF66DjLrXY6hrsdaEEiTgFvT9bOZU63mpCJYXrz3uTGve39nUlUPY0D4MTldC9rA3mlWjgiM44wV2rel0xqQ4u6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024110; c=relaxed/simple;
	bh=CCWh6NYRKHYzDC7XZv5BsVhTKdznZ4KQzj617z7Ck/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jh7U7t5EflqNRjNvMqYnLwNpe1EDqTj04kTiLEiMb6Ua4YXrlgHM8NADuIXob/Vze86zgq9+Se2TCtESKAe6eGzKYxtvuhi4rzAGwuPSKchFVyYLoijuIg4j5J7e+q6+bZYcJizVFD2pL7IUe0yP28Lydh2N0pNrvv1uO3miwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yg+tCyZv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717024108; x=1748560108;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=CCWh6NYRKHYzDC7XZv5BsVhTKdznZ4KQzj617z7Ck/Q=;
  b=Yg+tCyZvuo81VB63waQpgcCcQxxol5shOcfxmWAEGKXcExFUGwrTNd3C
   OTGpKJ5NDC32VJ0cnV/FBgtErCbWE2F6lYKy5JtbJ43/+DWyFhxzR0rTd
   wwKqG8mlwqS0Nk1U3yxlSR8I3a9F82L+U2NW0vb9LZ8+i1AuR/Rvr0+K6
   wN9QbizB9oYs4STG/dAFodxGTxh0hVgPDunsZCyJfjrO19DFHL2h+3oQx
   ugyrvS67iryucLE7qR4/ULSctW/5+pJ0jS3C0HpqUpcU/MNpIfEmcmeR9
   Wn8JCvbMmBdsnC4N1cozKYiKo2h0DtKST5MqZizf6Y/wEVPeDwvcja4CO
   g==;
X-CSE-ConnectionGUID: dnIOQOPfQnWDVciYavbaeQ==
X-CSE-MsgGUID: SimUPrtzQPu559wtx36fHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24879037"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208,223";a="24879037"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 16:08:27 -0700
X-CSE-ConnectionGUID: CRk1+L/kQeKT20requMVXw==
X-CSE-MsgGUID: 3xakXye3RrG+BJMb9GYKbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208,223";a="40064769"
Received: from gavinb-mobl.gar.corp.intel.com (HELO mpiske-mobl2.gar.corp.intel.com) ([10.213.75.20])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 16:08:24 -0700
Message-ID: <ca47b6f812175ea60f6ad615274223aa7fee295d.camel@linux.intel.com>
Subject: Re: intel_pstate_get_hwp_cap on wrong CPU
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 May 2024 16:08:19 -0700
In-Reply-To: <20240529155740.Hq2Hw7be@linutronix.de>
References: <20240529155740.Hq2Hw7be@linutronix.de>
Content-Type: multipart/mixed; boundary="=-j4e2AdDeO86OgoN1rdxp"
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-j4e2AdDeO86OgoN1rdxp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,


On Wed, 2024-05-29 at 17:57 +0200, Sebastian Andrzej Siewior wrote:
> Hi,
>=20
> this just popped up:
> > [ 6538.614568] unchecked MSR access error: RDMSR from 0x771 at rIP:

Please check if the attached change fixes?

Thanks,
Srinivas


> > 0xffffffff817d2250 (__rdmsr_on_cpu+0x20/0x50)
> > [ 6538.625714] Call Trace:
> > [ 6538.629156]=C2=A0 <TASK>
> > [ 6538.675067]=C2=A0 generic_exec_single+0x58/0x120
> > [ 6538.680236]=C2=A0 smp_call_function_single+0xbf/0x110
> > [ 6538.696333]=C2=A0 rdmsrl_on_cpu+0x46/0x60
> > [ 6538.700894]=C2=A0 intel_pstate_get_hwp_cap+0x1b/0x70
> > [ 6538.706420]=C2=A0 intel_pstate_update_limits+0x2a/0x60
> > [ 6538.712110]=C2=A0 acpi_processor_notify+0xb7/0x140
> > [ 6538.717479]=C2=A0 acpi_ev_notify_dispatch+0x3b/0x60
> > [ 6538.722910]=C2=A0 acpi_os_execute_deferred+0xf/0x20
> > [ 6538.728346]=C2=A0 process_one_work+0x13d/0x350
> > [ 6538.733342]=C2=A0 worker_thread+0x2c2/0x3d0
> > [ 6538.743066]=C2=A0 kthread+0xca/0x100
> > [ 6538.751844]=C2=A0 ret_from_fork+0x2c/0x40
> > [ 6538.761073]=C2=A0 ret_from_fork_asm+0x11/0x20
> > [ 6538.765993]=C2=A0 </TASK>
>=20
> > root@h:~# grep . /sys/devices/system/cpu/intel_pstate/*
> > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > /sys/devices/system/cpu/intel_pstate/min_perf_pct:36
> > /sys/devices/system/cpu/intel_pstate/no_turbo:0
> > /sys/devices/system/cpu/intel_pstate/num_pstates:4294967285
> ^ =3D> -EAGAIN
>=20
> > /sys/devices/system/cpu/intel_pstate/status:passive
> > /sys/devices/system/cpu/intel_pstate/turbo_pct:0
>=20
> > # cpupower frequency-info
> > analyzing CPU 0:
> > =C2=A0driver: intel_cpufreq
> =E2=80=A6
>=20
> from turbostat:
> > CPUID(0): GenuineIntel 0xf CPUID levels
> > CPUID(1): family:model:stepping 0x6:3f:4 (6:63:4) microcode 0x1a
> > CPUID(0x80000000): max_extended_levels: 0x80000008
> > CPUID(1): SSE3 MONITOR SMX EIST TM2 TSC MSR ACPI-TM HT TM
> > CPUID(6): APERF, TURBO, DTS, PTM, No-HWP, No-HWPnotify, No-
> > HWPwindow, No-HWPepp, No-HWPpkg, EPB
> > cpu4: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH
> > TURBO)
> > CPUID(7): No-SGX No-Hybrid
>=20
> This is v6.10.0-rc1.
>=20
> Sebastian
>=20


--=-j4e2AdDeO86OgoN1rdxp
Content-Disposition: attachment;
	filename="0001-cpufreq-intel_pstate-Fix-unchecked-HWP-MSR-access.patch"
Content-Type: text/x-patch;
	name="0001-cpufreq-intel_pstate-Fix-unchecked-HWP-MSR-access.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBmODVhODM1MDhlZjAyOWJjZWFmOTE5MmNiNjQ4ZDY2ZjMyYjYxZDAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogV2VkLCAyOSBNYXkgMjAyNCAxNTozMDo0OSAtMDcw
MApTdWJqZWN0OiBbUEFUQ0hdIGNwdWZyZXE6IGludGVsX3BzdGF0ZTogRml4IHVuY2hlY2tlZCBI
V1AgTVNSIGFjY2VzcwoKSFdQIE1TUiAweDc3MSBjYW4gYmUgb25seSByZWFkIG9uIGEgQ1BVIHdo
aWNoIHN1cHBvcnRzIEhXUCBhbmQgZW5hYmxlZC4KSGVuY2UgaW50ZWxfcHN0YXRlX2dldF9od3Bf
Y2FwKCkgY2FuIG9ubHkgYmUgY2FsbGVkIHdoZW4gaHdwX2FjdGl2ZSBpcwp0cnVlLgoKUmVwb3J0
ZWQtYnk6IFNlYmFzdGlhbiBSZWljaGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29t
PgpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBtLzIwMjQwNTI5MTU1NzQw
LkhxMkh3N2JlQGxpbnV0cm9uaXguZGUvCkZpeGVzOiBlODIxN2I0YmVjZTMgKCJjcHVmcmVxOiBp
bnRlbF9wc3RhdGU6IFVwZGF0ZSB0aGUgbWF4aW11bSBDUFUgZnJlcXVlbmN5IGNvbnNpc3RlbnRs
eSIpClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZh
ZGFAbGludXguaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyB8
IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jIGIvZHJpdmVycy9jcHVm
cmVxL2ludGVsX3BzdGF0ZS5jCmluZGV4IDRiOTg2YzA0NDc0MS4uNjVkM2Y3OTEwNGJkIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMKKysrIGIvZHJpdmVycy9jcHVm
cmVxL2ludGVsX3BzdGF0ZS5jCkBAIC0xMTUzLDcgKzExNTMsOCBAQCBzdGF0aWMgdm9pZCBpbnRl
bF9wc3RhdGVfdXBkYXRlX3BvbGljaWVzKHZvaWQpCiBzdGF0aWMgdm9pZCBfX2ludGVsX3BzdGF0
ZV91cGRhdGVfbWF4X2ZyZXEoc3RydWN0IGNwdWRhdGEgKmNwdWRhdGEsCiAJCQkJCSAgIHN0cnVj
dCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQogewotCWludGVsX3BzdGF0ZV9nZXRfaHdwX2NhcChj
cHVkYXRhKTsKKwlpZiAoaHdwX2FjdGl2ZSkKKwkJaW50ZWxfcHN0YXRlX2dldF9od3BfY2FwKGNw
dWRhdGEpOwogCiAJcG9saWN5LT5jcHVpbmZvLm1heF9mcmVxID0gUkVBRF9PTkNFKGdsb2JhbC5u
b190dXJibykgPwogCQkJY3B1ZGF0YS0+cHN0YXRlLm1heF9mcmVxIDogY3B1ZGF0YS0+cHN0YXRl
LnR1cmJvX2ZyZXE7Ci0tIAoyLjI1LjEKCg==


--=-j4e2AdDeO86OgoN1rdxp--

