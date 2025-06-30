Return-Path: <linux-pm+bounces-29828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EFEAED9DB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E62D189AE04
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74584217F29;
	Mon, 30 Jun 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGt7OTNr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64A1C862D;
	Mon, 30 Jun 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279423; cv=none; b=io0ZrNe3UVxMXOADbSccyXSL71KOn0wToly8V2rBdPHMulhZ72+4p8EWJh2m8aUfbvMKjQGKYC02bmI2tw6NgAg9jYl0SiVrvsjuxxnMmd8pGRLitFkE2CDfRXZjH0chM+iMHsFWoVkNBozTb5QA4umkdtRR/GP0TeKapX80cIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279423; c=relaxed/simple;
	bh=D8Rid0bcVc5Pr2IELERjxtYwzLWTo01IYXtAN+LRJfk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cnhBKie74PaZn+bbmpQiZLiFN306odAjV1FJAFHKel2/9cppI700zrWE864nfJGda3azp3BsgmhlrTODNaHCvw7qFBOIIQzVJDUEFlw/3H25x9s6Llu0Ly/GSgvfOzvXAV3rCjl3dDOmzyFkteNFztKCagKXWeMNkH005l9M/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGt7OTNr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751279422; x=1782815422;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=D8Rid0bcVc5Pr2IELERjxtYwzLWTo01IYXtAN+LRJfk=;
  b=KGt7OTNrtG30Fej/UFoP4sKRBX/z24BCki2qyy0JjUqaKt2z07Uw6mxj
   +fpfoqSm5tEojlxtqhLx5ygoGO7ijUNFhL87t46aNB9IcoNgI4uVSa/o5
   dKZZ0YJ6L6Tbibh5HlIDSpz+5Ddv9MGSHKnt7BzHx5sGk7U3kFSaGzBMY
   vQdldMqTZ6GwIZzAxBTL+OdxiZmQfAeGF7eT0HJqCHplDu77sSbMM3/me
   +OcTkthhlt07Oe4de77ZTZHGavwhQtAG45ktLWCbdOpwqIl0qzDnyokJc
   w+Y6TWQLD62AM/NtDw0PrSiURbsl574FxjI1YtDec/q3NH0QgQ0ANO7A4
   A==;
X-CSE-ConnectionGUID: gJstAsThTiqtlOd5D22reQ==
X-CSE-MsgGUID: 43qohBGYSK6FLYYIWg5GDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="78940308"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="78940308"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:30:21 -0700
X-CSE-ConnectionGUID: xV/uDRqjS7atOjXTMdnVmA==
X-CSE-MsgGUID: k9O9eEo4TdmfRaK2YxefHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153050589"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 03:30:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Jun 2025 13:30:12 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: Mario Limonciello <mario.limonciello@amd.com>, 
    Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, 
    "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, 
    Huang Rui <ray.huang@amd.com>, 
    "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Viresh Kumar <viresh.kumar@linaro.org>, 
    "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
    "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
    "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v11 00/13] Add support for AMD hardware feedback
 interface
In-Reply-To: <20250609200518.3616080-1-superm1@kernel.org>
Message-ID: <5b312c44-346b-0499-962e-5a80a787e031@linux.intel.com>
References: <20250609200518.3616080-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1730005503-1751279366=:7079"
Content-ID: <16e53ef6-1677-69e6-f234-6f14e754d788@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1730005503-1751279366=:7079
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8943e6f1-0a75-8515-3884-25951a634d31@linux.intel.com>

On Mon, 9 Jun 2025, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification of tasks.
>=20
> Threads are classified during runtime into enumerated classes.
> Currently, the driver supports 3 classes (0 through 2). These classes
> represent thread performance/power characteristics that may benefit from
> special scheduling behaviors. The real-time thread classification is
> consumed by the operating system and is intended to be used to inform the=
 scheduler
> of where the thread should be placed for optimal performance or energy ef=
ficiency.
>=20
> The thread classification can be used to helps to select CPU from a ranki=
ng table
> that describes an efficiency and performance ranking for each classificat=
ion from
> two dimensions. This is not currently done in this series, but is intende=
d for future
> follow ups after the plumbing is laid down.
>=20
> The ranking data provided by the ranking table are numbers ranging from 0=
 to 255,
> where a higher performance value indicates higher performance capability =
and a higher
> efficiency value indicates greater efficiency. All the CPU cores are rank=
ed into
> different class IDs. Within each class ranking, the cores may have differ=
ent ranking
> values. Therefore, picking from each classification ID will later allow t=
he scheduler
> to select the best core while threads are classified into the specified w=
orkload class.
>=20
> This series was originally submitted by Perry Yuan [1] but he is now doin=
g a different
> role and he asked me to take over.
>=20
> Link: https://lore.kernel.org/all/cover.1724748733.git.perry.yuan@amd.com=
/
>=20
> v10->v11:
>  * rebase on v6.16-rc1
>  * Adjust for Randy's and Ingo's feedback
>=20
> Mario Limonciello (5):
>   MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
>   cpufreq/amd-pstate: Disable preferred cores on designs with workload
>     classification
>   platform/x86/amd: hfi: Set ITMT priority from ranking data
>   platform/x86/amd: hfi: Add debugfs support
>   x86/itmt: Add debugfs file to show core priorities
>=20
> Perry Yuan (8):
>   Documentation: x86: Add AMD Hardware Feedback Interface documentation
>   x86/msr-index: define AMD heterogeneous CPU related MSR
>   platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
>   platform/x86: hfi: parse CPU core ranking data from shared memory
>   platform/x86: hfi: init per-cpu scores for each class
>   platform/x86: hfi: add online and offline callback support
>   platform/x86: hfi: add power management callback
>   x86/process: Clear hardware feedback history for AMD processors
>=20
>  Documentation/arch/x86/amd-hfi.rst    | 133 +++++++
>  Documentation/arch/x86/index.rst      |   1 +
>  MAINTAINERS                           |   9 +
>  arch/x86/include/asm/msr-index.h      |   5 +
>  arch/x86/kernel/itmt.c                |  23 ++
>  arch/x86/kernel/process_64.c          |   4 +
>  drivers/cpufreq/amd-pstate.c          |   6 +
>  drivers/platform/x86/amd/Kconfig      |   1 +
>  drivers/platform/x86/amd/Makefile     |   1 +
>  drivers/platform/x86/amd/hfi/Kconfig  |  18 +
>  drivers/platform/x86/amd/hfi/Makefile |   7 +
>  drivers/platform/x86/amd/hfi/hfi.c    | 551 ++++++++++++++++++++++++++

I don't have objections to this series. But as discussed before, not all=20
features are provided by this series and follow-up series will be=20
required to provide what are documented as features (perhaps more than=20
one).

The pdx86 side seems pretty conflict free as this is new code. If e.g. x86=
=20
wants to merge this due to this series touching existing code there=20
(besides the minor cpufreq bits), it would be fine with me,

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.
--8323328-1730005503-1751279366=:7079--

