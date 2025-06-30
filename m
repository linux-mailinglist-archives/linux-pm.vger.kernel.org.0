Return-Path: <linux-pm+bounces-29835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3DAEDAE7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 13:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5C016C4DC
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638F24167D;
	Mon, 30 Jun 2025 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQ1ZdniB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9F235056;
	Mon, 30 Jun 2025 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282916; cv=none; b=d0Gbggge3dwbxvCs6WPWt1AH9i90qZAkLMqNCHXKKmPYLAC4BWvmzgZ/QtDCySH1DJ4o9Z0L7rdFR9DFL114lllBlMHdEuW0G3DmcwwDPZjNGCsK2FlYsXMKvOEKtgzJP0Q77MR5YMHOb5ZirZiAIbXZHm0hz6ZVrh75167eR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282916; c=relaxed/simple;
	bh=N/h64xLzq0goVwy4KzgtSusObZRIiU7ReaUoXVaeSDo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z7UCg0qarbq8M9Ooz2YtrFFt7UChyyb5zCYQ2dMUJdcyj7m4BkZjR48iE6LqMoH2F01Jq2TZJFZI1b0HxusdMxy48cjgoBofpnOHUI0C6+p1KM0meBFOKfCVbJrOo6YopDd8iEEJ1d6dojch07g+Rhy8uF4V6w/lIhPSbgTn8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQ1ZdniB; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751282915; x=1782818915;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N/h64xLzq0goVwy4KzgtSusObZRIiU7ReaUoXVaeSDo=;
  b=TQ1ZdniBSblIp/R+6pu8+u31xPqP9IZrXbnSXfNCYoBI2pR5CMulFBqs
   R1c1YCaNWi2/D0CC/WPwJA7kR7vyaYtaZAFSZxof4f4MTBRVPPRv1RMS9
   64gYlPkxhUqh82iOQYM8CtWBwd+Ohn06GTggA5GLY6gTfeEA2YAJ49Q/p
   ZLYxmwvwo2HhK3BVJnJbIj4kuzfNCaY4So0wIuGmc4y92bxjZ9skq13Sc
   zshwS4uQAGTlAEGgAQBzdAK64A6LPt6tipGxGk25tlJ7LF+V7lNsJH9H1
   9R6rsZT1NyjOqWevCM+ezYc6+QqW8LrorPi/4LYIGq25+lqMihWxPxGFG
   w==;
X-CSE-ConnectionGUID: 4Z/I3u8fQOm7v3QAAxDNvQ==
X-CSE-MsgGUID: OK1atbnARGejJL952XVxdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53653676"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53653676"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:28:34 -0700
X-CSE-ConnectionGUID: eaWahnIQRcaM/8ajVbVPYw==
X-CSE-MsgGUID: V+LNQuoITJK5ORefNZtuNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153904593"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:28:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Jun 2025 14:28:29 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] platform/x86:intel/pmc: Enable SSRAM support for
 Panther Lake
In-Reply-To: <20250625063145.624585-6-xi.pardee@linux.intel.com>
Message-ID: <9fccdef1-aabd-730c-d031-99d8319fba11@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com> <20250625063145.624585-6-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1524790567-1751282909=:7079"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1524790567-1751282909=:7079
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Xi Pardee wrote:

> Enable Panther Lake platforms to achieve PMC information from
> Intel PMC SSRAM Telemetry driver and substate requirements data
> from telemetry region.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.h |  2 ++
>  drivers/platform/x86/intel/pmc/ptl.c  | 30 +++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index d8c7b28493055..cdb32f2203cff 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -301,6 +301,8 @@ enum ppfear_regs {
>  #define PTL_PMC_LTR_CUR_ASLT=09=09=090x1C28
>  #define PTL_PMC_LTR_CUR_PLT=09=09=090x1C2C
>  #define PTL_PCD_PMC_MMIO_REG_LEN=09=090x31A8
> +#define PTL_NUM_S0IX_BLOCKER=09=09=09106
> +#define PTL_BLK_REQ_OFFSET=09=09=0955
> =20
>  /* SSRAM PMC Device ID */
>  /* LNL */
> diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/=
intel/pmc/ptl.c
> index 394515af60d60..48be79b4e769f 100644
> --- a/drivers/platform/x86/intel/pmc/ptl.c
> +++ b/drivers/platform/x86/intel/pmc/ptl.c
> @@ -10,6 +10,17 @@
> =20
>  #include "core.h"
> =20
> +/* PMC SSRAM PMT Telemetry GUIDS */
> +#define PCDP_LPM_REQ_GUID 0x47179370
> +
> +/*
> + * Die Mapping to Product.
> + * Product PCDDie
> + * PTL-H   PCD-H
> + * PTL-P   PCD-P
> + * PTL-U   PCD-P
> + */
> +
>  static const struct pmc_bit_map ptl_pcdp_pfear_map[] =3D {
>  =09{"PMC_0",               BIT(0)},
>  =09{"FUSE_OSSE",           BIT(1)},
> @@ -515,6 +526,22 @@ static const struct pmc_reg_map ptl_pcdp_reg_map =3D=
 {
>  =09.lpm_live_status_offset =3D MTL_LPM_LIVE_STATUS_OFFSET,
>  =09.s0ix_blocker_maps =3D ptl_pcdp_blk_maps,
>  =09.s0ix_blocker_offset =3D LNL_S0IX_BLOCKER_OFFSET,
> +=09.num_s0ix_blocker =3D PTL_NUM_S0IX_BLOCKER,
> +=09.blocker_req_offset =3D PTL_BLK_REQ_OFFSET,
> +};
> +
> +static struct pmc_info ptl_pmc_info_list[] =3D {
> +=09{
> +=09=09.guid=09=3D PCDP_LPM_REQ_GUID,
> +=09=09.devid=09=3D PMC_DEVID_PTL_PCDH,
> +=09=09.map=09=3D &ptl_pcdp_reg_map,
> +=09},
> +=09{
> +=09=09.guid   =3D PCDP_LPM_REQ_GUID,
> +=09=09.devid  =3D PMC_DEVID_PTL_PCDP,
> +=09=09.map    =3D &ptl_pcdp_reg_map,
> +=09},
> +=09{}
>  };
> =20
>  #define PTL_NPU_PCI_DEV                0xb03e
> @@ -543,6 +570,9 @@ static int ptl_core_init(struct pmc_dev *pmcdev, stru=
ct pmc_dev_info *pmc_dev_in
>  }
> =20
>  struct pmc_dev_info ptl_pmc_dev =3D {
> +=09.pci_func =3D 2,
> +=09.telem_info =3D SUB_REQ_BLK,
> +=09.regmap_list =3D ptl_pmc_info_list,
>  =09.map =3D &ptl_pcdp_reg_map,
>  =09.suspend =3D cnl_suspend,
>  =09.resume =3D ptl_resume,
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1524790567-1751282909=:7079--

