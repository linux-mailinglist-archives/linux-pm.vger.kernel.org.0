Return-Path: <linux-pm+bounces-38142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D43C66696
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 23:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC1A84EDD23
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71CC309F09;
	Mon, 17 Nov 2025 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjncsuN7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17862F549A
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417266; cv=none; b=YM0mKMtyvnP2NXXMPrwfgdQa+6gKV8gYe+96lS2byc5KbhfYGc+gFjN/Cc/fQKZ/CnzRbJ3dUDFXLk28DKGYqEFZ6mC8dq5IEXHksmrqrJ99uP5XgA3fCgPlCYhlGeqNYzPaLBPGevGU75jrWgDmJsGP6dFcGEB9vex4ZCCYZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417266; c=relaxed/simple;
	bh=PjAfbg6cB3xE01n+Ue8YhSgGuQicr2lvGXpv8o5n0WI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEnU0/Q8NpilQg/vqHrVLPsAeA1XmREGssRC65btn510HrDX3QRy+TgUTRPf4kIlb4xB4YZ7lWJoUwZD62JHXQvVOhg7h+bvFOvR+oIjzOL0tg8YGiT4tiVr0ph0JU4s0yDiwZBE0nFKuWGB/tZj8O5kwKAeiQBNgI9gRNXf2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjncsuN7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763417265; x=1794953265;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PjAfbg6cB3xE01n+Ue8YhSgGuQicr2lvGXpv8o5n0WI=;
  b=GjncsuN7Ft5LyJU7txPkUw9KJsHbYYQXBhPUCx5VAlKs6UkoqJ3KsA8+
   EofAWnJQ/C0DJugBV2rDBdBCasmUbKdYX0ISJL2x6aP6IzBJVm6W7nyve
   G/ilLHQHg4TKKyZd0SRCzgQzhZbt+L3og8vXLzOp+mb3mdek4cbXruaaY
   zde8IwNs6nqG978zv5OsGGu+BJhYQIAAZyM4G5Xx5oI808zW+2vnAlAHK
   7Mvs8JL1P19rA/PzgDgBDaQXkJgCFCtXWzMZmAZS5rzn4T7XhGAJbPrzP
   4ObdEnVrfqzB1FdRFUf/i8vFsMr4h1EWVCCYs07AZ7M28mA1lhmW+ROMJ
   A==;
X-CSE-ConnectionGUID: 87RfNZ9lRQqBPVEvJD0pTw==
X-CSE-MsgGUID: jItFXq6fQjOr21cjy9BirA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65521606"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="65521606"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 14:07:44 -0800
X-CSE-ConnectionGUID: VfpSmDKXQpyGRoPHuNKxGQ==
X-CSE-MsgGUID: DSs14cXBS72sNQADGcZuww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="190365917"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 14:07:45 -0800
Message-ID: <62c63a985c63eb73941d7edecc088f909aebb114.camel@linux.intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for NOVALAKE
 processors
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Kaushlendra Kumar
	 <kaushlendra.kumar@intel.com>
Cc: linux-pm@vger.kernel.org
Date: Mon, 17 Nov 2025 14:07:44 -0800
In-Reply-To: <CAJZ5v0gXS0TgAF6AqboN_NKGXxx7onsK8QRv7eCVQFStkQXJXQ@mail.gmail.com>
References: <20251028101814.3482508-1-kaushlendra.kumar@intel.com>
	 <CAJZ5v0gXS0TgAF6AqboN_NKGXxx7onsK8QRv7eCVQFStkQXJXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 13:31 +0100, Rafael J. Wysocki wrote:
> On Tue, Oct 28, 2025 at 11:20=E2=80=AFAM Kaushlendra Kumar
> <kaushlendra.kumar@intel.com> wrote:
> >=20
> > Add RAPL support for Intel NOVALAKE and NOVALAKE_L processors using
> > the core defaults configuration.
>=20
> Srinivas, any concerns?
>=20
No. Except in the subject say "Nova Lake" instead of "NOVALAKE" to be
compatible with existing style.

Thanks,
Srinivas


> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
> > =C2=A0drivers/powercap/intel_rapl_common.c | 2 ++
> > =C2=A0drivers/powercap/intel_rapl_msr.c=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A02 files changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index c7e7f9bf5313..8ea55e167b1a 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1284,6 +1284,8 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_EMERALDR=
APIDS_X,=C2=A0=C2=A0=C2=A0
> > &rapl_defaults_spr_server),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_LUNARLAK=
E_M,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > &rapl_defaults_core),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_PANTHERL=
AKE_L,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > &rapl_defaults_core),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_NOVALAKE,=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > &rapl_defaults_core),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_NOVALAKE_L,=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > &rapl_defaults_core),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_ARROWLAK=
E_H,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > &rapl_defaults_core),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_ARROWLAK=
E,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > &rapl_defaults_core),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_ARROWLAK=
E_U,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > &rapl_defaults_core),
> > diff --git a/drivers/powercap/intel_rapl_msr.c
> > b/drivers/powercap/intel_rapl_msr.c
> > index 4ed06c71a3ac..7421648917d1 100644
> > --- a/drivers/powercap/intel_rapl_msr.c
> > +++ b/drivers/powercap/intel_rapl_msr.c
> > @@ -151,6 +151,8 @@ static const struct x86_cpu_id
> > pl4_support_ids[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_ARROWLAK=
E_U, NULL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_ARROWLAK=
E_H, NULL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_PANTHERL=
AKE_L, NULL),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_NOVALAKE, NUL=
L),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_NOVALAKE_L, N=
ULL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
> > =C2=A0};
> >=20
> > --
> > 2.34.1
> >=20
> >=20

