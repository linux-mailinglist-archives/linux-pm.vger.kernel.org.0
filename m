Return-Path: <linux-pm+bounces-34511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B8EB53BA5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 20:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF721882585
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9D2DC769;
	Thu, 11 Sep 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgiOvA8c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74D2DC767
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615881; cv=none; b=fSIzk+20TpwKYUcBN2Yu+ehnIZVCRUS5B4ZJTc2mfJEyoL8WTHw90/0lg91eBbzqqsCZitBYwkh+zhalbyq0ty32DZ3ilC4XCi8zYIN1Gh7r4dMg4DAUr238NyFUxN4R9WcXLLWV5sdrmsF93YWmihieyawqWIsR2daofwaxKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615881; c=relaxed/simple;
	bh=GA/Ds7n40YC/8z7ccNQteANoy47w92onxQVDqNX7s08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Byc0XAHDnZeD1L3Z28vfyOqFswQS9CSb12l/E0k4vXn5G3+zzRecFYnvoRQnsi4MFrRsOs/E1v6wv7oDr9jVJcyk6sUEhK4+WN+vpZfSdCwAmW9/CSKuuhwsDVDAJ1BN3o12oPoQwg+j5fzzqBj5sGn/RpHF8LFv1hQlxp/LJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgiOvA8c; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757615880; x=1789151880;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GA/Ds7n40YC/8z7ccNQteANoy47w92onxQVDqNX7s08=;
  b=TgiOvA8cCP9klIKaaimJkns4nWhjZwJTu3VCWDtvcQajtj6FrNg4Ota2
   zWnVnEhE7cHyitvXiP9nPziKsUfsoh5Oi6mkLZ5zd6pXpArawEtBS/kkC
   w9GzKf5h/sWnVcvDoWXEcyIEdp1m3BPcFh9u4ZdBGSwqz2KjkEOwHVpam
   Ug85D7620NP7FjCEGIMb5+SJHR58sbgPgrs0G/BU76SocOnAc4Jo5x5rs
   ej/U7wsrZpL2OdadMPkrdBZp34V0SZSs+SVZGWnHo/At4RoXeU6W/LyR7
   /VEycDysr+wO+LJelUHc2Lm3XNjG2UGEs1N2GUYYjXkLwCuHt9HJKSbS/
   w==;
X-CSE-ConnectionGUID: jXsTiscTRKegI/xNxHGEIw==
X-CSE-MsgGUID: P6SycLIUTKGbULCRJNevGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71384158"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="71384158"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:38:00 -0700
X-CSE-ConnectionGUID: ge2S2iBaRXiKIVlOi7quZA==
X-CSE-MsgGUID: nr3BiCxcSwigvS//FV3QlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173827764"
Received: from spandruv-desk2.jf.intel.com (HELO [10.98.25.49]) ([10.98.25.49])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 11:37:59 -0700
Message-ID: <b88dc0fc6604bd18d1658c0d16aa10a2f43eb054.camel@linux.intel.com>
Subject: Re: Sometimes I only see 3 RAPL (out of 4) Counters
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Kenneth Crudup
 <kenny@panix.com>,  "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date: Thu, 11 Sep 2025 11:37:59 -0700
In-Reply-To: <CAJZ5v0i4gNcir8sDunPbpSP367tN=PvrsrP61puv954XEtMBKQ@mail.gmail.com>
References: <8ce4578e-6913-4dbe-9573-433e69925bc1@panix.com>
	 <CAJZ5v0i4gNcir8sDunPbpSP367tN=PvrsrP61puv954XEtMBKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 11:42 +0200, Rafael J. Wysocki wrote:
> +Srinivas & Rui
>=20
> On Thu, Sep 11, 2025 at 2:20=E2=80=AFAM Kenneth Crudup <kenny@panix.com>
> wrote:
> >=20
> > I have a Dell XPS-9320, with a i7-1280P (family: 0x6, model: 0x9a,
> > stepping: 0x3) CPU. Sometimes I'll only see 3 RAPL counters instead
> > of
> > the normal 4. (It used to happen a lot more often, BTW):
> >=20

That is because sometimes the counter for PP1 (GFX ..) is 0 during boot
and then the PMU code will ignore that. This happens when the counter
is sampled before GPU is not even started. So this is a race condition.


Thanks,
Srinivas


> > ----
> > gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | fgrep
> > fixed
> > 2025-09-08T12:09:05.915989-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> > 2025-09-09T08:52:19.098522-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-09-09T17:25:24.377784-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-09-09T17:50:09.334140-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-09-10T16:42:13.259270-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> > 2025-09-10T16:46:36.322016-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-09-02T13:05:02.632218-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-09-02T14:07:19.683466-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-09-02T14:20:43.602483-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-09-04T13:13:38.636326-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-09-05T09:21:50.147180-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-08-29T10:57:14.419740-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-08-17T11:52:55.733943-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-08-19T07:52:30.696326-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-08-19T07:55:49.083600-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-08-20T10:53:54.601680-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-08-20T11:00:09.560496-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > 2025-08-20T11:12:30.580414-07:00 xps-9320 kernel: [=C2=A0=C2=A0=C2=A0 T=
1] RAPL
> > PMU: API
> > unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> > ----
> >=20
> > ... and it's always(?) the GPU RAPL:
> >=20
> > ----
> > gunzip --force --stdout /var/log/syslog* | fgrep -i rapl | cut -d\]
> > -f2-
> > > sort -f | uniq -c
> > grep: (standard input): binary file matches
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 intel_rapl_common: Found RAPL d=
omain core
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36=C2=A0 intel_rapl_common: Found RAPL d=
omain package
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 intel_rapl_common: Found RAPL d=
omain psys
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0 intel_rapl_common: Found RAPL d=
omain uncore
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 intel_rapl_msr: PL4 support det=
ected.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=C2=A0 RAPL PMU: API unit is 2^-3=
2 Joules, 3 fixed counters,
> > 655360
> > ms ovfl timer
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0 RAPL PMU: API unit is 2^-32 Jou=
les, 4 fixed counters,
> > 655360
> > ms ovfl timer
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 RAPL PMU: hw unit of domain pac=
kage 2^-14 Joules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 RAPL PMU: hw unit of domain pp0=
-core 2^-14 Joules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=C2=A0 RAPL PMU: hw unit of domain pp1=
-gpu 2^-14 Joules
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18=C2=A0 RAPL PMU: hw unit of domain psy=
s 2^-14 Joules
> > ----
> >=20
> > A reboot fixes it up again (and that's if I even notice), but what
> > would
> > cause this to happen? What's the effect of it missing the RAPL
> > counter, BTW?
> >=20
> > LMK if you need more info,
> >=20
> > -Kenny
> >=20
> > --
> > Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting,
> > Orange
> > County CA
> >=20
> >=20

