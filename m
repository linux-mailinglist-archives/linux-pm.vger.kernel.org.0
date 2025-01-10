Return-Path: <linux-pm+bounces-20196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00109A08F81
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE24E3AAD9A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FFE20DD46;
	Fri, 10 Jan 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlW9QK7B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031420C030;
	Fri, 10 Jan 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508661; cv=none; b=EaqLkoPdsSxTYVFiP9RaEIT8RankgBZgWl0ZCOTLLL25yJP/y5Lx+GgT4oBujAypChkH2Sk+MTGzf12VCY3oWiuoZm2uS89hkmwSPupWurhPLiWDDxLbJcYUk403HVV+uWx+YzP0Vx3+uw5wJtLJHqTSrTxwEpFmV5RwBt4kCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508661; c=relaxed/simple;
	bh=nhDM8oTjak/yiOseC8GrWVflQYmBjouZ/MAMXIV9aug=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qna4AVSfVshi47bdQYAzDdM8Zh+MnybY0jPetbMW2BN7MZyeUOCG3q1ObtKBsQ+ql75oJUSmuxD0XHblWJ0rEmyAHdI/zqXeXGhyHlqDb26lIHQ6iOKeyPIQe+iZu4RbRWiDujn57vJv4wIp5La7Nx4jHsUV6NJ/1Sp0PjMBDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlW9QK7B; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736508659; x=1768044659;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nhDM8oTjak/yiOseC8GrWVflQYmBjouZ/MAMXIV9aug=;
  b=FlW9QK7BWi49pRJwNeKf+kSd7+lRGv1Mf31lJ8N4G7r434bs1sH0gZq1
   b2bVXunGhLWj7wonxeoMorF7S1cQax+ppR9pU1FeSaPQgxRboki35+tRC
   HTiV6JPwdinzliSqdG2CzmXxoujyuWZtiUW3oWsU6XvuYzhdfzjg/Gfge
   oDE+3+S7SY7seNDxgLW/jakSZMpgEQ40kElsPuofNrTZ6MHTpPqdD92w+
   r3XgsdgO4FIKDinoD6/QXAT8RsTfN5HOo+f05hbBXYOO4NCL3sAvrs/dS
   llWjPIfvOHisa84+ZRWFtivD/83NO6nTrxM3ISsxW2GcRoFed60YC+iq8
   A==;
X-CSE-ConnectionGUID: U+cRFD61T9+2E8cUUkio4w==
X-CSE-MsgGUID: 0PAM8qxlSvudGcuNue+gdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="54339711"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="54339711"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 03:30:57 -0800
X-CSE-ConnectionGUID: VDL7BhMfQtiwaAyRJ2w93Q==
X-CSE-MsgGUID: jn3rzmYSTgSRB8AImm+w+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103592383"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO localhost) ([10.245.244.158])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 03:30:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Jan 2025 13:30:50 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/6] platform/x86/intel/pmc: Remove duplicate enum
In-Reply-To: <20250110002612.244782-3-xi.pardee@linux.intel.com>
Message-ID: <6524a3c0-bc7e-c78e-4d99-fc5d41d99196@linux.intel.com>
References: <20250110002612.244782-1-xi.pardee@linux.intel.com> <20250110002612.244782-3-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1476655922-1736508650=:1003"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1476655922-1736508650=:1003
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Jan 2025, Xi Pardee wrote:

> Remove duplicate enum PMC_IDX_SOC. PMC_IDX_SOC has the same value
> as PMC_IDX_MAIN. Replace it with PMC_IDX_MAIN to avoid confusion.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/platform/x86/intel/pmc/arl.c  | 2 +-
>  drivers/platform/x86/intel/pmc/core.h | 1 -
>  drivers/platform/x86/intel/pmc/lnl.c  | 2 +-
>  drivers/platform/x86/intel/pmc/mtl.c  | 2 +-
>  4 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/=
intel/pmc/arl.c
> index 05dec4f5019f3..ad976cc83ecae 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -693,7 +693,7 @@ static int arl_resume(struct pmc_dev *pmcdev)
> =20
>  int arl_core_init(struct pmc_dev *pmcdev)
>  {
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_SOC];
> +=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
>  =09int ret;
>  =09int func =3D 0;
>  =09bool ssram_init =3D true;
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index a1886d8e1ef3e..a0f6cc427ddca 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -430,7 +430,6 @@ struct pmc_dev {
> =20
>  enum pmc_index {
>  =09PMC_IDX_MAIN,
> -=09PMC_IDX_SOC =3D PMC_IDX_MAIN,
>  =09PMC_IDX_IOE,
>  =09PMC_IDX_PCH,
>  =09PMC_IDX_MAX
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/=
intel/pmc/lnl.c
> index be029f12cdf40..09b13df90d685 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -553,7 +553,7 @@ static int lnl_resume(struct pmc_dev *pmcdev)
>  int lnl_core_init(struct pmc_dev *pmcdev)
>  {
>  =09int ret;
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_SOC];
> +=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> =20
>  =09lnl_d3_fixup();
> =20
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/=
intel/pmc/mtl.c
> index 02949fed76e91..07687a3e436d5 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -992,7 +992,7 @@ static int mtl_resume(struct pmc_dev *pmcdev)
> =20
>  int mtl_core_init(struct pmc_dev *pmcdev)
>  {
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_SOC];
> +=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
>  =09int ret;
>  =09int func =3D 2;
>  =09bool ssram_init =3D true;
>=20
--8323328-1476655922-1736508650=:1003--

