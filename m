Return-Path: <linux-pm+bounces-34394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F1B51EB0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 19:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE6956701F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188D2316910;
	Wed, 10 Sep 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt4H8NEG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94405314B89;
	Wed, 10 Sep 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524514; cv=none; b=ThlsdLPK0JGcWkZ9YhBrOTVYMPLToyhH02cJP6eM5eHsOO7c9p9zVZDGrn37Ibl1dR25SFqS+oFz4JgLuZQceVbvN7sggXi8Yu1TDi+t+t40nvpPKjjEMbZBEd10mnPq+gHFoPJS91FkvdG/ctBLKbtRuwB1TXHLKJIrdkzcrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524514; c=relaxed/simple;
	bh=GSzpQXrVsGOkg9n0qjibU8nmSrVRvwep/b24SJElML0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=moDuRP8n8W1Zo4Ueygsh50FxvKNRBaSi06ERRWegVA36E9Sty6vGV3bsC6I4E0Px2P1V0bt9NhGRv9rXnmN4c8d4ECAXudsJ9QtJuouyr6kV45p8Vcdi6nd7Ne+VAjGI2IZ9tPgF2kvkPtwsLDIFwcxLaWPSakYFTAjkS9ug94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt4H8NEG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757524511; x=1789060511;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GSzpQXrVsGOkg9n0qjibU8nmSrVRvwep/b24SJElML0=;
  b=Rt4H8NEGRTmLF2Lv7vX7giFJ4TAcydUiyGKKq0286mG9k16yJZm1wCqC
   yThkn1sZq7C4VDRq4G199yAId+cyUyWxWq720cAZvSspMALUeQdDkcFps
   7yJrnihPobuIe2fVHs+o6A6v/zNeUOP4O2tDus2jIY/UNRMVRHZx5VSUm
   m9fAUotDQDMVQhOeulXWdeDEnm8mBgiBzgPxTx2n4BaZKlZV9rUeruAkk
   P6ecuECKy0HMWigZX6p/dZlg1Ih3jnHJ0CkHe1cleBQ21UoGKWn0H8WyR
   eHQQ2yxvAesJj5aUU7hC6qfpM/w6njT++mIJbhY6vS7znYKE7s/NliCM4
   w==;
X-CSE-ConnectionGUID: zr9FqOkmQ4ezvIReYoBdJw==
X-CSE-MsgGUID: cGe9EZ6KQ0C7QBG4UwPoVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="85288843"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="85288843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 10:15:10 -0700
X-CSE-ConnectionGUID: nNE5Qo01SxGRSP+zTcxmuQ==
X-CSE-MsgGUID: q8OXQ+HCTaiG0w0DZwOrAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="177480945"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 10:15:10 -0700
Message-ID: <dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
Subject: Re: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>, "Rafael J. Wysocki"
	 <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, mmikowski@kfocus.org
Date: Wed, 10 Sep 2025 10:15:00 -0700
In-Reply-To: <20250910113650.54eafc2b@kf-m2g5>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
		<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
	 <20250910113650.54eafc2b@kf-m2g5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-10 at 11:36 -0500, Aaron Rainbolt wrote:
> On Wed, 30 Apr 2025 16:29:09 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>=20
> > On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >=20
> > > When turbo mode is unavailable on a Skylake-X system, executing
> > > the
> > > command:
> > > "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > > results in an unchecked MSR access error: WRMSR to 0x199
> > > (attempted to write 0x0000000100001300).
> > >=20
> > > This issue was reproduced on an OEM (Original Equipment
> > > Manufacturer) system and is not a common problem across all
> > > Skylake-X systems.
> > >=20
> > > This error occurs because the MSR 0x199 Turbo Engage Bit (bit 32)
> > > is set when turbo mode is disabled. The issue arises when
> > > intel_pstate fails to detect that turbo mode is disabled. Here
> > > intel_pstate relies on MSR_IA32_MISC_ENABLE bit 38 to determine
> > > the
> > > status of turbo mode. However, on this system, bit 38 is not set
> > > even when turbo mode is disabled.
> > >=20
> > > According to the Intel Software Developer's Manual (SDM), the
> > > BIOS
> > > sets this bit during platform initialization to enable or disable
> > > opportunistic processor performance operations. Logically, this
> > > bit
> > > should be set in such cases. However, the SDM also specifies that
> > > "OS and applications must use CPUID leaf 06H to detect processors
> > > with opportunistic processor performance operations enabled."
> > >=20
> > > Therefore, in addition to checking MSR_IA32_MISC_ENABLE bit 38,
> > > verify that CPUID.06H:EAX[1] is 0 to accurately determine if
> > > turbo
> > > mode is disabled.
> > >=20
> > > Fixes: 4521e1a0ce17 ("cpufreq: intel_pstate: Reflect current
> > > no_turbo state correctly") Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> Cc: stable@vger.kernel.org
> > > ---
> > > =C2=A0drivers/cpufreq/intel_pstate.c | 3 +++
> > > =C2=A01 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c index f41ed0b9e610..ba9bf06f1c77
> > > 100644 --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -598,6 +598,9 @@ static bool turbo_is_disabled(void)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 misc_en;
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu_feature_enabled(X86_FE=
ATURE_IDA))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return true;
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdmsrl(MSR_IA32_MISC_ENABL=
E, misc_en);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!(misc_en & MSR_IA=
32_MISC_ENABLE_TURBO_DISABLE);
> > > --=C2=A0=20
> >=20
> > Applied as a fix for 6.15-rc, thanks!
> >=20
>=20
> FYI, this seems to have broken turbo boost on some Clevo systems with
> an Intel Core i9-14900HX CPU. These CPUs obviously support turbo
> boost,
> and kernels without this commit have turbo boost working properly,
> but
> after this commit turbo boost is stuck disabled and cannot be
> enabled by writing to /sys/devices/system/cpu/intel_pstate/no_turbo.
> I
> made a bug report about this against Ubuntu's kernel at [1], which is
> the only report I know that is able to point to this commit as having
> broken things. However, it looks like an Arch Linux user [2] and a
> Gentoo user [3] are running into the same thing.
>=20

As the bug report suggested, the system boots with no turbo, it must be
forcefully turned ON by writing to this attribute.
I wonder if there is a BIOS option to turn ON turbo on this system?

This processor itself is capable of up to 5.8 GHz turbo.


I will try to find contact at Clevo.

We can try to reduce scope of this change to non HWP only where there
is unchecked MSR issue.

Thanks,
Srinivas

> [1]
> https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2122531
>=20
> [2] https://bbs.archlinux.org/viewtopic.php?id=3D305564
>=20
> [3]
> https://forums.gentoo.org/viewtopic-p-8866128.html?sid=3De97619cff0d9c79c=
2eea2cfe8f60b0d3


