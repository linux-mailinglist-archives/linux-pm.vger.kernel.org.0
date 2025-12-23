Return-Path: <linux-pm+bounces-39865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BFECD9624
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C39923016999
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ED1330D5D;
	Tue, 23 Dec 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsvvg4fI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D2331235;
	Tue, 23 Dec 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494750; cv=none; b=rtTuZMXucEUM057MU+WwH1EsP2xuk5W51mP3RYg3p5YilfI2blNGFdu8PEtxQuVtPi8s7F45yebgGi6r1O12t0Ks8Tzpvg+9YdGoeTMv/fRy1rn9vCJLoK1LEq511oV2L+vs9titdF2NXgrO3JZM8KZ1KB+/6lBTFYR9DAmsxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494750; c=relaxed/simple;
	bh=F0g3+2uTLV2NYZ/REdMbbdetXLTqblLF0qqtYqdEiCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRawg54Zu30JIMuX70hwsVPfpDOFlaS1vI4abL1h+pPUp7JuZ1kd/GjvCvbqy3D9dc6Ou6Tymx2OB7cePNDNPvtaSFPFyY4N7oK4Pyrd3W4ZFGx+T3H/M3aHvWOVkrmGE9ELyCetmL1l6D/JPsLDE1kYeMOpFcpY/E4PaJgHNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsvvg4fI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766494749; x=1798030749;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=F0g3+2uTLV2NYZ/REdMbbdetXLTqblLF0qqtYqdEiCg=;
  b=nsvvg4fI+9TGlij7zU1ddcyyU7N7DeKhvU66Rc1cMWecF2TRuGGVfuer
   MWeVvvyg8oEB9vctGkvWoqpO48Om7EaJWh8IdUnRXcSJTjZsNxkIArnlh
   qKMCU+hVlGv60oSOZyOKcwwgCj4PSdkmg7WpLR9vhQF1m0gc4irPQwasy
   KxcqBC3wwRiXEfeRYvq3YK/flGALcoadgQ4VcZjPT0RyoA8AhR/pJMu/g
   cMCTKYhIaVeqyT84FTzY0Oijo5p5fFh8Mx3oA0OKL9DPIq3+fovaQrVSK
   kIIXZDosyZtIakCdfiYSw5leLCfAY8gURshSVgswewf9m5X42hxqJA7zw
   Q==;
X-CSE-ConnectionGUID: h5pZ+ipOShitmhYoYLpy7A==
X-CSE-MsgGUID: 2ZHftbnZQnqcZJN/bZbP9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68280186"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68280186"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 04:59:09 -0800
X-CSE-ConnectionGUID: HALyF9cmSACtK+lKObQV5Q==
X-CSE-MsgGUID: Q2j3N71HQ5ygLfzSlpwgKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="199443077"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.124.220.160]) ([10.124.220.160])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 04:59:07 -0800
Message-ID: <ae43d146993e63dc91a1d764baa099ba7021771a.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel: intel_tcc_cooling: Add CPU models in
 the support list
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 23 Dec 2025 04:59:06 -0800
In-Reply-To: <CAJZ5v0gbZrbk5fWNF9iAvwfJo1aKBVF52++_s0HicRrKr4V2Zw@mail.gmail.com>
References: <20251218195150.3872795-1-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0gbZrbk5fWNF9iAvwfJo1aKBVF52++_s0HicRrKr4V2Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 12:08 +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 18, 2025 at 8:51=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Add Panther Lake, Wildcat Lake and Nova Lake CPU models in the
> > support
> > list.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0drivers/thermal/intel/intel_tcc_cooling.c | 4 ++++
> > =C2=A01 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/thermal/intel/intel_tcc_cooling.c
> > b/drivers/thermal/intel/intel_tcc_cooling.c
> > index f352ecafbedf..92de161e359a 100644
> > --- a/drivers/thermal/intel/intel_tcc_cooling.c
> > +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> > @@ -65,6 +65,10 @@ static const struct x86_cpu_id tcc_ids[]
> > __initconst =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_RAPTORLA=
KE, NULL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_RAPTORLA=
KE_P, NULL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_RAPTORLA=
KE_S, NULL),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_PANTHERLAKE_L=
, NULL),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_WILDCATLAKE_L=
, NULL),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_NOVALAKE, NUL=
L),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_NOVALAKE_L, N=
ULL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
> > =C2=A0};
> >=20
> > --
>=20
> Applied, but I'm not planning to send pull requests this week and
> next
> week, so it may become 6.20 material I'm afraid.

Not urgent.

Thanks,
Srinivas

>=20
> Thanks!

