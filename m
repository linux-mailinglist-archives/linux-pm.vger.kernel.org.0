Return-Path: <linux-pm+bounces-13151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31F96425C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC572860D1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC1418FC65;
	Thu, 29 Aug 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kiq+dDi3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5B18F2F9;
	Thu, 29 Aug 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928871; cv=none; b=dJDcwzOCEkLamecbU+Bd77HtDpPgp1IfqGSogUTI1FIlndfpRe6fLtByRzJoTeAZinxgY23p1SoZtjSIuvExSalVWr3lFZGVlfI2scfCqX6G2g16kAZiE5UtHgYJ3/3VVWSxJ8hcG8QZEQaOtawqBkQCvUrQ4r+qN15ub/+VTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928871; c=relaxed/simple;
	bh=yTXKpdTr4O4p6Hr5Fbd1/Fg3x6RSY5v7OLIpb7xcel4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UeBBKEzbMySKrMVM4oCzdTO1rZEkAkTsvL9FsTQ7LMMENDTrWVsd2XVdFuUYwnLl3k92umnM43mpEIj89dkQEZ01dTPDL1lPdWyqZKddTJoxQxxahQWomdWSmdZILujUq0L9AUZ4nBSsYWC4S2UI06eCN8cSxE/1GNDiNE5OzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kiq+dDi3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724928870; x=1756464870;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yTXKpdTr4O4p6Hr5Fbd1/Fg3x6RSY5v7OLIpb7xcel4=;
  b=Kiq+dDi3/afJ4ozQ1Govz2PMnHldplbqsZZIyu/UWGrVyoWJsBjrAk/2
   ni8YGS3Me6R6dAG9fI1nZl6AgQG7yFx7xviUJuDy/h3es5yhj5Z6Q3xyh
   8g2zKMm7HmU1dUEBmHG5hAdbEnSCc6sW/ecY0u8lgHjNTXp2BvAUMxZqJ
   l3CvXHgZWf7id72GYnvZ5N2ju5b7Op2dMw6fVfLCZA6Mag1g4V2ntcyuo
   zesye7o1VWHCisrGNIgEGJbYX4tULXJH/frY+mPYjD4dasLyyZgN8XSUZ
   +sC1rgh98d3FPqFcmH5cnroLi9dm7Gda7+SjpdpPEK0xXsv30edCHVnnf
   w==;
X-CSE-ConnectionGUID: Q+79ifJYTy65nLqZYTSsSg==
X-CSE-MsgGUID: OMZgaVv1QFuKwmiYynxgng==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23087062"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23087062"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 03:54:30 -0700
X-CSE-ConnectionGUID: QQCczAdcQfq3tXp/gbUbyQ==
X-CSE-MsgGUID: FJ2x0EENQy2lWfvaR0rD0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="64032615"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 03:54:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 13:54:22 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] platform/x86:intel/pmc: Convert index variables
 to be unsigned
In-Reply-To: <20240828222932.1279508-5-xi.pardee@linux.intel.com>
Message-ID: <7880c5cb-3b32-0956-30ce-b25fe537de07@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com> <20240828222932.1279508-5-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1845205492-1724928862=:1289"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1845205492-1724928862=:1289
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Aug 2024, Xi Pardee wrote:

> Convert the index variables type to be unsigned to avoid confusion
> and error.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/platform/x86/intel/pmc/core.c            | 5 +++--
>  drivers/platform/x86/intel/pmc/core.h            | 2 +-
>  drivers/platform/x86/intel/pmc/ssram_telemetry.c | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 630ce2087552..8984041f35f4 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1716,7 +1716,8 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmc=
dev, struct pmc *pmc)
> =20
>  int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
>  {
> -=09int ret, i;
> +=09unsigned int i;
> +=09int ret;
> =20
>  =09if (!pmcdev->ssram_pcidev)
>  =09=09return -ENODEV;
> @@ -1743,7 +1744,7 @@ const struct pmc_reg_map *pmc_core_find_regmap(stru=
ct pmc_info *list, u16 devid)
>  }
> =20
>  int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
> -=09=09     const struct pmc_reg_map *reg_map, int pmc_index)
> +=09=09     const struct pmc_reg_map *reg_map, unsigned int pmc_index)
>  {
>  =09struct pmc *pmc =3D pmcdev->pmcs[pmc_index];
> =20
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index 6763e59180a4..5af1d41a83f7 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -606,7 +606,7 @@ extern void pmc_core_set_device_d3(unsigned int devic=
e);
>  extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
>  extern const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *l=
ist, u16 devid);
>  extern int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
> -=09=09=09    const struct pmc_reg_map *reg_map, int pmc_index);
> +=09=09=09    const struct pmc_reg_map *reg_map, unsigned int pmc_index);
> =20
>  int spt_core_init(struct pmc_dev *pmcdev);
>  int cnp_core_init(struct pmc_dev *pmcdev);
> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/p=
latform/x86/intel/pmc/ssram_telemetry.c
> index 0a2bfca5ff41..4b21d9cf310a 100644
> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> @@ -75,7 +75,7 @@ static inline u64 get_base(void __iomem *addr, u32 offs=
et)
>  }
> =20
>  static int
> -pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
> +pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32=
 offset)
>  {
>  =09struct pci_dev *ssram_pcidev =3D pmcdev->ssram_pcidev;
>  =09void __iomem __free(pmc_core_iounmap) *tmp_ssram =3D NULL;
>=20
--8323328-1845205492-1724928862=:1289--

