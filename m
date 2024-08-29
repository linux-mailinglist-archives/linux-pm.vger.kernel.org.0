Return-Path: <linux-pm+bounces-13149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8088F964237
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D2284699
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96718E367;
	Thu, 29 Aug 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUBtup7i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99D14B950;
	Thu, 29 Aug 2024 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928646; cv=none; b=Kf/MAwj5V0dB29JBTqd+a0oGCE1ChcH11KsQpzzX/kD11LSTw07Hm5805U8zD81FEmimzD+U0PT/8hpCvIWFjC8LV/vH+MFSdj7xVY/OiT2PjAZuJCnHpo8Z66Nu/ZU8+O4IvdN1PIXdusazIh6YYaUyQfQzO61uX0YtlRZorM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928646; c=relaxed/simple;
	bh=yGRVnYALB9IW/xRHyrNF2n6TJAQrxrxanVCfpk6uUMw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Sg6KI8Qf6a/edxkI1JjMWcqNABkXUz/xebwbVfWiYmGhwGf3qnVj0BcueHHVUT/b+CYCJIiQZGSiF0iLUEq+Q4eSPwTCuPCloq0Y04EeTOWeiniroWh9a0xOF0hZFccdxjlPR3FKaTIvPwVrolCkAeunlzu2tF+BTKz1i9MmM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUBtup7i; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724928645; x=1756464645;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yGRVnYALB9IW/xRHyrNF2n6TJAQrxrxanVCfpk6uUMw=;
  b=BUBtup7iKT9tB4Vbmuw+vMnw3XjGGl0jKOv5djXa2wjvJ7TYC+jRfkQv
   HlBfqnJGXRP4NsepyiJVosQ8KHjJnZBE5SK+QcdbbJD359vx0KRU+hv7M
   iVZwmZuIqVyf3F0+FnNev02gKj3+XwB01Sh68psVl4x6dYJVXR3G519IJ
   GX65FIYFuKi9UuY/H8u8/qIX07Ny5rLrvQDhSsD489726K7gJK8ZX25wB
   gKj1DUsY6Vq3pWCrVI2vF0btZcIdk3tuZwEOFhsPhCc8TvRkJAUIq/zte
   W8/yZ6KHM62C9SRF4UwUEqX+kcD5r1FyEnn92/VVgoh+evIpki9u7HiD6
   g==;
X-CSE-ConnectionGUID: 2qqx2uLLRCefOr+CoB/ckw==
X-CSE-MsgGUID: 29Nn4rGDSa6Kjzun2FrM0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23086733"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23086733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 03:50:44 -0700
X-CSE-ConnectionGUID: BLpriJjuTCGf46ZNfLkEBw==
X-CSE-MsgGUID: wg+vnCiOQ02pMvjGpRy9/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="64031957"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 03:50:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 13:50:37 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 02/11] platform/x86:intel/pmc: Rename core_ssram to
 ssram_telemetry
In-Reply-To: <20240828222932.1279508-3-xi.pardee@linux.intel.com>
Message-ID: <8c9ae29f-cde8-1fb7-bea3-c1b0a4b31c63@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com> <20240828222932.1279508-3-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-557959830-1724928637=:1289"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-557959830-1724928637=:1289
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Aug 2024, Xi Pardee wrote:

> Rename core_ssram.c to ssram_telemetry.c. This patch is a
> preparation step to introduce a new SSRAM Telemetry driver
> for the SSRAM device.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/platform/x86/intel/pmc/Makefile                         | 2 +-
>  .../platform/x86/intel/pmc/{core_ssram.c =3D> ssram_telemetry.c}  | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/platform/x86/intel/pmc/{core_ssram.c =3D> ssram_telemetry=
=2Ec} (100%)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x=
86/intel/pmc/Makefile
> index 389e5419dadf..4dd9fa93f873 100644
> --- a/drivers/platform/x86/intel/pmc/Makefile
> +++ b/drivers/platform/x86/intel/pmc/Makefile
> @@ -3,7 +3,7 @@
>  # Intel x86 Platform-Specific Drivers
>  #
> =20
> -intel_pmc_core-y=09=09=09:=3D core.o core_ssram.o spt.o cnp.o \
> +intel_pmc_core-y=09=09=09:=3D core.o ssram_telemetry.o spt.o cnp.o \
>  =09=09=09=09=09   icl.o tgl.o adl.o mtl.o arl.o lnl.o
>  obj-$(CONFIG_INTEL_PMC_CORE)=09=09+=3D intel_pmc_core.o
>  intel_pmc_core_pltdrv-y=09=09=09:=3D pltdrv.o
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platfo=
rm/x86/intel/pmc/ssram_telemetry.c
> similarity index 100%
> rename from drivers/platform/x86/intel/pmc/core_ssram.c
> rename to drivers/platform/x86/intel/pmc/ssram_telemetry.c
>=20

--8323328-557959830-1724928637=:1289--

