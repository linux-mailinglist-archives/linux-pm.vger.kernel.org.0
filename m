Return-Path: <linux-pm+bounces-37544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC67C3CEDB
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 18:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C351B4263F6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A634FF5D;
	Thu,  6 Nov 2025 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQQ5kOPO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED334F246;
	Thu,  6 Nov 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451085; cv=none; b=qeoBQuj8h/CJucHovB/4zZh9cLmu5bvNebFgOia3OUPFlcqU6BtS534ShllMoUhuC5lO8t/nFd3RuNE5BCXLUFZt96qJQnDC4FCB/aXUpYHjwWTTC9nRGm9Bm21cVvlwTcFrbzdGF5dqzVUCx1ZG+/J1tJ0FVeduxLh/APmKGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451085; c=relaxed/simple;
	bh=VfLMnWVZDg6b+wtxUN7DNTsuv1mesxfWQJqFSKOfyKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KAbhEGe+GqhTA8yVV6CD1WpUkhYnCXgcxdQW334UD5KD0OO8WCyGvEajcif1dGMfx0+A9bFfvN8ed4pmzzn/VCr1hY6VNKsPSLidl04b+d8S6UKN8whyl4Y2nNAb7cxlptMTNELW9P1xq6iXTfZnMGuNp8F46kAAuVVwbruHOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQQ5kOPO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762451083; x=1793987083;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VfLMnWVZDg6b+wtxUN7DNTsuv1mesxfWQJqFSKOfyKM=;
  b=LQQ5kOPOkk6E9QeEOpLX0Yt+DSN3sn+yBSWsuf+BLNbyPNzO22kKg0iR
   6wl+Q+J7p08FJ1oRnqBL4l/hFOxzXXSldOocc1YyWfFh0jO9jx2xkJToc
   heqM6JLc+4AjyV64f8qenZSGdEfyOmbdYAFiGZei1lBO6nFj3QRa8rOWS
   czk8uz/zuQLPHeXwLF+VVcYIhOS3c6u+mOBU6paMPc0bfy5JRDpns+7pJ
   3oQOrcBMgR0/FVG92Lrt8bTubdvhMMlH4meH7JOdjNGeZokhgRwCkVOSS
   k/ZsXT2motXKSSMdLhno9u6wbSbfD3vGDfWi2m0IW1rwOAWkKDL7CW7tX
   A==;
X-CSE-ConnectionGUID: Si/qL2JAQW+sSUCVo8870Q==
X-CSE-MsgGUID: rIDJ2LFDT868tKhdfbUEkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="82002160"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="82002160"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 09:44:42 -0800
X-CSE-ConnectionGUID: IVchUY7wSMS80ui52sSxaA==
X-CSE-MsgGUID: D28/gahHSPKuJiii/5ATmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187074453"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 09:44:42 -0800
Message-ID: <851e605992395b78490a97e7a6d771eb0c232848.camel@linux.intel.com>
Subject: Re: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 	mmikowski@kfocus.org
Date: Thu, 06 Nov 2025 09:44:41 -0800
In-Reply-To: <20251106113137.5b83bb3f@kf-m2g5>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
		<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
		<20250910113650.54eafc2b@kf-m2g5>
		<dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
		<20250910153329.10dcef9d@kf-m2g5>
		<db92b8a310d88214e2045a73d3da6d0ffe8606f7.camel@linux.intel.com>
	 <20251106113137.5b83bb3f@kf-m2g5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

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

Thanks for test. I am waiting for some other reporters from Suse to
confirm.
I will add your tested by tag.


- Srinivas

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

