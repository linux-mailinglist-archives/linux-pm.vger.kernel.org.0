Return-Path: <linux-pm+bounces-37579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B1C3E281
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 02:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8BD3AC9FD
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 01:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7A2E7F1E;
	Fri,  7 Nov 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ag2YoIxQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFE20C037;
	Fri,  7 Nov 2025 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480094; cv=none; b=nRJxFHUR22vPpwj/tYzL0NoY5x5fk/6FuvMoxEo7gKpcvTjR7bt9u81TMzpOBO4AyM+5MTaE0GIIPKRA11Q44kJdg72rvMoNk7JoG9g1Hrv4uCmHptw5QcOBDf6YHObuXPzgChIjaT6wNLrJB+Q5kkvvs9SFtiRlCdP72pBmRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480094; c=relaxed/simple;
	bh=v6zB7iF5EiKs73sB6PUObq4nGfpH3jYdCoelt/6miLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stEZEYS7xrTVrnKURSXTGac2FobvtonDU5UIqsaBMVj9ZguwF7g7f5hq/2bNTX6ZbzAN+aRoO3ibwGnYLJXbRgTPDGWmkH0i2ostCwtOHvJ4chz4BGMPCQ1hIp2WXDkeb/44NWfMDMw5gr6hMm5hUw7xVwOHdMQ7lVpgVWMmdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ag2YoIxQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762480092; x=1794016092;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=v6zB7iF5EiKs73sB6PUObq4nGfpH3jYdCoelt/6miLs=;
  b=ag2YoIxQ50k4fGsf79jKbSeX7fV319ARFCIGJJv8Vx8F/y16l3cUwORq
   kd3d2agyLnEZ/iEkovHSOdz2qzOyKASZdvVRXxA8vOttiOBnqvVq83iAm
   /OXfNCZKCasXm1niSzTUXZe/SRL6m/xJBKDL3KkQvYvKpfmXJvD7RcoPF
   8IGNTR1PY54zmTjQGLZHi401/QOS3akSRgAYSFSbrkHgFzKy9CrcPMl59
   8Y9P1U8bpTGkS0f1MwgvKQrzquEUaHFB89+/ZnpU9P4Mzgmtr/50mkWjV
   AgXiL7jPjnp5dUuVz+wXkBBNq4jQOPmQiLFf6zd+G8FkrQ6JUKo/FCVzd
   w==;
X-CSE-ConnectionGUID: zxsUaSvMQgafFaykqN0+jA==
X-CSE-MsgGUID: DifoU98DQ8+Nv/sGUIcwMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="67241706"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208,223";a="67241706"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 17:48:11 -0800
X-CSE-ConnectionGUID: /AutPi0LR1iLAUCfBEN1LA==
X-CSE-MsgGUID: OaLG+u0DTzeLtN74sO/HoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208,223";a="187864855"
Received: from dwesterg-mobl1.amr.corp.intel.com ([10.125.111.51])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 17:48:11 -0800
Message-ID: <8794c34dc127ee1bd3ed4d746ca7c1235ca3cb93.camel@linux.intel.com>
Subject: Re: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,  mmikowski@kfocus.org
Date: Thu, 06 Nov 2025 17:48:10 -0800
In-Reply-To: <20251106113137.5b83bb3f@kf-m2g5>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
	 <20250910113650.54eafc2b@kf-m2g5>
	 <dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
	 <20250910153329.10dcef9d@kf-m2g5>
	 <db92b8a310d88214e2045a73d3da6d0ffe8606f7.camel@linux.intel.com>
	 <20251106113137.5b83bb3f@kf-m2g5>
Content-Type: multipart/mixed; boundary="=-9Wrt8BcrBEO56xUhdjM+"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-9Wrt8BcrBEO56xUhdjM+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

Please again verify this change. This limits the scope.
Patch attached.

Thanks,
Srinivas

On Thu, 2025-11-06 at 11:31 -0600, Aaron Rainbolt wrote:
> On Thu, 06 Nov 2025 07:23:14 -0800
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > Hi Aaron,
> >=20
> > On Wed, 2025-09-10 at 15:33 -0500, Aaron Rainbolt wrote:
> > > On Wed, 10 Sep 2025 10:15:00 -0700
> > > srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> > > =C2=A0=20
> > > > On Wed, 2025-09-10 at 11:36 -0500, Aaron Rainbolt wrote:=C2=A0=20
> > > > > On Wed, 30 Apr 2025 16:29:09 +0200
> > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> > > > > > <srinivas.pandruvada@linux.intel.com> wrote:=C2=A0=C2=A0=C2=A0=
=20
> > > > > > >=20
> > > > > > > When turbo mode is unavailable on a Skylake-X system,
> > > > > > > executing
> > > > > > > the
> > > > > > > command:
> > > > > > > "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > > > > > > results in an unchecked MSR access error: WRMSR to 0x199
> > > > > > > (attempted to write 0x0000000100001300).=C2=A0=20
> > Please try the attached patch, if this address this issue.
>=20
> I can confirm that this patch does resolve the issue when applied to
> Kubuntu Focus's 6.14 kernel. CPU frequencies are available that
> require
> turbo boost, and `cat /sys/devices/system/cpu/intel_pstate` returns
> `0`. The logs from `dmesg` also indicate that turbo was disabled
> earlier in boot, but the warnings about turbo being disabled stop
> appearing later on, even when manipulating the `no_turbo` file:
>=20
> [=C2=A0=C2=A0 25.893012] intel_pstate: Turbo is disabled
> [=C2=A0=C2=A0 25.893019] intel_pstate: Turbo disabled by BIOS or unavaila=
ble on
> processor
> [=C2=A0=C2=A0 25.950587] NET: Registered PF_QIPCRTR protocol family
> [=C2=A0=C2=A0 26.599013] Realtek Internal NBASE-T PHY r8169-0-6c00:00: at=
tached
> PHY driver (mii_bus:phy_addr=3Dr8169-0-6c00:00, irq=3DMAC)
> [=C2=A0=C2=A0 26.725959] ACPI BIOS Error (bug): Could not resolve symbol
> [\_TZ.ETMD], AE_NOT_FOUND (20240827/psargs-332)
>=20
> [=C2=A0=C2=A0 26.725976] No Local Variables are initialized for Method [_=
OSC]
>=20
> [=C2=A0=C2=A0 26.725978] Initialized Arguments for Method [_OSC]:=C2=A0 (=
4 arguments
> defined for method invocation)
> [=C2=A0=C2=A0 26.725979]=C2=A0=C2=A0 Arg0:=C2=A0=C2=A0 0000000030ddf166 <=
Obj>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Buffer(16)
> 5D A8 3B B2 B7 C8 42 35
> [=C2=A0=C2=A0 26.725991]=C2=A0=C2=A0 Arg1:=C2=A0=C2=A0 0000000002bd3ac4 <=
Obj>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Integer
> 0000000000000001
> [=C2=A0=C2=A0 26.725996]=C2=A0=C2=A0 Arg2:=C2=A0=C2=A0 0000000033eb047e <=
Obj>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Integer
> 0000000000000002
> [=C2=A0=C2=A0 26.725999]=C2=A0=C2=A0 Arg3:=C2=A0=C2=A0 00000000de6cf5f1 <=
Obj>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Buffer(8)
> 00 00 00 00 05 00 00 00
>=20
> [=C2=A0=C2=A0 26.726010] ACPI Error: Aborting method \_SB.IETM._OSC due t=
o
> previous error (AE_NOT_FOUND) (20240827/psparse-529)
> [=C2=A0=C2=A0 26.726056] Consider using thermal netlink events interface
> [=C2=A0=C2=A0 26.769209] r8169 0000:6c:00.0 enp108s0: Link is Down
> [=C2=A0=C2=A0 26.857318] zram0: detected capacity change from 0 to 195035=
136
> [=C2=A0=C2=A0 26.864390] vboxdrv: Found 32 processor cores/threads
> [=C2=A0=C2=A0 26.873227] Adding 97517564k swap on /dev/zram0.=C2=A0 Prior=
ity:-2
> extents:1 across:97517564k SS
> [=C2=A0=C2=A0 26.880588] vboxdrv: TSC mode is Invariant, tentative freque=
ncy
> 2419194640 Hz
> [=C2=A0=C2=A0 26.880592] vboxdrv: Successfully loaded version 7.2.4 r1709=
95
> (interface 0x00340001)
> [=C2=A0=C2=A0 26.895725] intel_pstate: Turbo is disabled
> [=C2=A0=C2=A0 26.895730] intel_pstate: Turbo disabled by BIOS or unavaila=
ble on
> processor
> [=C2=A0=C2=A0 26.943715] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION:=
 0x20
> [=C2=A0=C2=A0 26.943746] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION=
: 0x1f
> [=C2=A0=C2=A0 26.943755] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
> [=C2=A0=C2=A0 26.943765] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
> [=C2=A0=C2=A0 26.944901] iwlwifi 0000:00:14.3: RFIm is deactivated, reaso=
n =3D 5
> [=C2=A0=C2=A0 27.045437] iwlwifi 0000:00:14.3: Registered PHC clock: iwlw=
ifi-
> PTP, with index: 0
> [=C2=A0=C2=A0 27.098590] VBoxNetFlt: Successfully started.
> [=C2=A0=C2=A0 27.101687] VBoxNetAdp: Successfully started.
> [=C2=A0=C2=A0 27.153602] bridge: filtering via arp/ip/ip6tables is no lon=
ger
> available by default. Update your scripts to load br_netfilter if you
> need this.
> [=C2=A0=C2=A0 27.851014] loop14: detected capacity change from 0 to 8
> [=C2=A0=C2=A0 27.895706] r8169 0000:6c:00.0: invalid VPD tag 0xff (size 0=
) at
> offset 0; assume missing optional EEPROM
> [=C2=A0=C2=A0 28.898015] intel_pstate: Turbo is disabled
> [=C2=A0=C2=A0 28.898021] intel_pstate: Turbo disabled by BIOS or unavaila=
ble on
> processor
> [=C2=A0=C2=A0 31.900781] intel_pstate: Turbo is disabled
> [=C2=A0=C2=A0 31.900788] intel_pstate: Turbo disabled by BIOS or unavaila=
ble on
> processor
> [=C2=A0=C2=A0 33.959448] Bluetooth: RFCOMM TTY layer initialized
> [=C2=A0=C2=A0 33.959456] Bluetooth: RFCOMM socket layer initialized
> [=C2=A0=C2=A0 33.959462] Bluetooth: RFCOMM ver 1.11
> [=C2=A0=C2=A0 36.903768] intel_pstate: Turbo is disabled
> [=C2=A0=C2=A0 36.903777] intel_pstate: Turbo disabled by BIOS or unavaila=
ble on
> processor
> [=C2=A0=C2=A0 38.054345] systemd-journald[883]:
> /var/log/journal/a9e8e3d2041547169b107e1e1a23f2ce/user-1000.journal:
> Journal file uses a different sequence number ID, rotating.
> [=C2=A0=C2=A0 39.799560] warning: `kded5' uses wireless extensions which =
will
> stop working for Wi-Fi 7 hardware; use nl80211
> [=C2=A0=C2=A0 40.884365] wlp0s20f3: authenticate with 18:ee:86:8b:16:a2 (=
local
> address=3D98:bd:80:8a:e9:27)
> [=C2=A0=C2=A0 40.885147] wlp0s20f3: send auth to 18:ee:86:8b:16:a2 (try 1=
/3)
> [=C2=A0=C2=A0 40.968595] wlp0s20f3: authenticate with 18:ee:86:8b:16:a2 (=
local
> address=3D98:bd:80:8a:e9:27)
> [=C2=A0=C2=A0 40.968603] wlp0s20f3: send auth to 18:ee:86:8b:16:a2 (try 1=
/3)
> [=C2=A0=C2=A0 40.980941] wlp0s20f3: authenticated
> [=C2=A0=C2=A0 40.981904] wlp0s20f3: associate with 18:ee:86:8b:16:a2 (try=
 1/3)
> [=C2=A0=C2=A0 41.042933] wlp0s20f3: RX AssocResp from 18:ee:86:8b:16:a2
> (capab=3D0x1431 status=3D0 aid=3D14)
> [=C2=A0=C2=A0 41.046917] wlp0s20f3: associated
>=20
> If you post the patch, I'm happy to add a `Tested-by` tag for it.
> Thank you for your help!
>=20
> > Thanks,
> > Srinivas
>=20
>=20


--=-9Wrt8BcrBEO56xUhdjM+
Content-Disposition: attachment;
	filename*0=0001-cpufreq-intel_pstate-Check-IDA-feature-only-during-M.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-cpufreq-intel_pstate-Check-IDA-feature-only-during-M.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAxNGE3MjI1ZGVhODZkZjBmMjg4Zjk0ZGYxNzRlM2QxZmNkMGExOGVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogVGh1LCA2IE5vdiAyMDI1IDE3OjM0OjA5IC0wODAw
ClN1YmplY3Q6IFtQQVRDSF0gY3B1ZnJlcTogaW50ZWxfcHN0YXRlOiBDaGVjayBJREEgZmVhdHVy
ZSBvbmx5IGR1cmluZyBNU1IKIDB4MTk5IHdyaXRlCgpDb21taXQgMGZiNWJlN2ZlYTk4ICgiY3B1
ZnJlcTogaW50ZWxfcHN0YXRlOiBVbmNoZWNrZWQgTVNSIGFjZWVzcyBpbgpsZWdhY3kgbW9kZSIp
IGludHJvZHVjZWQgYSBjaGVjayBmb3IgZmVhdHVyZSBYODZfRkVBVFVSRV9JREEgdG8gdmVyaWZ5
CnR1cmJvIG1vZGUgc3VwcG9ydC4gQWx0aG91Z2ggdGhpcyBpcyB0aGUgY29ycmVjdCB3YXkgdG8g
Y2hlY2sgZm9yIHR1cmJvCm1vZGUsIGl0IGNhdXNlcyBpc3N1ZXMgb24gc29tZSBwbGF0Zm9ybXMg
dGhhdCBkaXNhYmxlIHR1cmJvIGR1cmluZyBPUwpib290IGJ1dCBlbmFibGUgaXQgbGF0ZXIuIFdp
dGhvdXQgdGhpcyBmZWF0dXJlIGNoZWNrLCB1c2VycyB3ZXJlIGFibGUgdG8Kd3JpdGUgMCB0byAv
c3lzL2RldmljZXMvc3lzdGVtL2NwdS9pbnRlbF9wc3RhdGUvbm9fdHVyYm8gcG9zdC1ib290IHRv
CmdldCB0dXJibyBtb2RlIGZyZXF1ZW5jaWVzLgoKVG8gcmVzdG9yZSB0aGUgb2xkIGJlaGF2aW9y
IHdoaWxlIHN0aWxsIGFkZHJlc3NpbmcgdGhlIHVuY2hlY2tlZCBNU1IKaXNzdWUgb24gc29tZSBT
a3lsYWtlLVggc3lzdGVtcywgbGltaXQgdGhlIFg4Nl9GRUFUVVJFX0lEQSBjaGVjayB0byBvbmx5
CndoZW4gc2V0dGluZyBNU1IgMHgxOTkgVHVyYm8gRW5nYWdlIEJpdCAoYml0IDMyKS4KCkZpeGVz
OiAwZmI1YmU3ZmVhOTggKCJjcHVmcmVxOiBpbnRlbF9wc3RhdGU6IFVuY2hlY2tlZCBNU1IgYWNl
ZXNzIGluIGxlZ2FjeSBtb2RlIikKU2lnbmVkLW9mZi1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8
c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+Ci0tLQogZHJpdmVycy9jcHVmcmVx
L2ludGVsX3BzdGF0ZS5jIHwgOSArKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2ludGVs
X3BzdGF0ZS5jIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCmluZGV4IDQzZTg0N2U5
Zjc0MS4uMzhhOGU4NzdmMjIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0
YXRlLmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCkBAIC01OTgsOSArNTk4
LDYgQEAgc3RhdGljIGJvb2wgdHVyYm9faXNfZGlzYWJsZWQodm9pZCkKIHsKIAl1NjQgbWlzY19l
bjsKIAotCWlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9JREEpKQotCQlyZXR1
cm4gdHJ1ZTsKLQogCXJkbXNybChNU1JfSUEzMl9NSVNDX0VOQUJMRSwgbWlzY19lbik7CiAKIAly
ZXR1cm4gISEobWlzY19lbiAmIE1TUl9JQTMyX01JU0NfRU5BQkxFX1RVUkJPX0RJU0FCTEUpOwpA
QCAtMjAxNCw3ICsyMDExLDggQEAgc3RhdGljIHU2NCBhdG9tX2dldF92YWwoc3RydWN0IGNwdWRh
dGEgKmNwdWRhdGEsIGludCBwc3RhdGUpCiAJdTMyIHZpZDsKIAogCXZhbCA9ICh1NjQpcHN0YXRl
IDw8IDg7Ci0JaWYgKFJFQURfT05DRShnbG9iYWwubm9fdHVyYm8pICYmICFSRUFEX09OQ0UoZ2xv
YmFsLnR1cmJvX2Rpc2FibGVkKSkKKwlpZiAoUkVBRF9PTkNFKGdsb2JhbC5ub190dXJibykgJiYg
IVJFQURfT05DRShnbG9iYWwudHVyYm9fZGlzYWJsZWQpICYmCisJICAgIGNwdV9mZWF0dXJlX2Vu
YWJsZWQoWDg2X0ZFQVRVUkVfSURBKSkKIAkJdmFsIHw9ICh1NjQpMSA8PCAzMjsKIAogCXZpZF9m
cCA9IGNwdWRhdGEtPnZpZC5taW4gKyBtdWxfZnAoCkBAIC0yMTc5LDcgKzIxNzcsOCBAQCBzdGF0
aWMgdTY0IGNvcmVfZ2V0X3ZhbChzdHJ1Y3QgY3B1ZGF0YSAqY3B1ZGF0YSwgaW50IHBzdGF0ZSkK
IAl1NjQgdmFsOwogCiAJdmFsID0gKHU2NClwc3RhdGUgPDwgODsKLQlpZiAoUkVBRF9PTkNFKGds
b2JhbC5ub190dXJibykgJiYgIVJFQURfT05DRShnbG9iYWwudHVyYm9fZGlzYWJsZWQpKQorCWlm
IChSRUFEX09OQ0UoZ2xvYmFsLm5vX3R1cmJvKSAmJiAhUkVBRF9PTkNFKGdsb2JhbC50dXJib19k
aXNhYmxlZCkgJiYKKwkgICAgY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9JREEpKQog
CQl2YWwgfD0gKHU2NCkxIDw8IDMyOwogCiAJcmV0dXJuIHZhbDsKLS0gCjIuNDMuMAoK


--=-9Wrt8BcrBEO56xUhdjM+--

