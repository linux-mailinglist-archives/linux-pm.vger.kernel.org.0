Return-Path: <linux-pm+bounces-20197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95560A08F96
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E8816497A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6120ADFF;
	Fri, 10 Jan 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/f12iKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8B1F5435;
	Fri, 10 Jan 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509111; cv=none; b=JR2ISmPwf4ugGT3NYXlDYny6JpQLcRh0l1GcCiUMdrT1dR3c6Uh+nwhkLP91ITlTEdWW3aYkA5Au4vun+El91lsaeDoDBc5Xwqz1rMSB13673eFPg3xYOXCy5SkcUTbTtlQW9Kavbe0mraGfgwcHiQH2szwx/iYLnctJin9msqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509111; c=relaxed/simple;
	bh=qu6Crl69sECqnF2kSGF63v+mZF11dtU/TdD7/EmZSjM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UguWmFqJfczYdJ8KgRnZVpB+tKB6nA6nhcCgfrm7GUSnU+NEYqVz/Vp9w4Ek0dTOqDL/TdRQBl09IU9APGI6uxz240AFJqKwmrAlsaIbu9xjGJeYnCGrwxbJ19jMeIJpLs/Zwh/1QjkErwUzlQqAamdZTqY363JQ9EL05/ljqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/f12iKD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736509109; x=1768045109;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qu6Crl69sECqnF2kSGF63v+mZF11dtU/TdD7/EmZSjM=;
  b=b/f12iKDNCdTbqeJo2ToDp+fXlHlxYp6U8YuDZ3No+s/6uvjxsulmK3Q
   CyXX6Z7tByHrP9/0Gdl7OQ+RYtvQTOah05TBNWKy9bfdv9F1PHAp+qqIP
   P9vxE86D0jyimfXhvD8oYixQtoT0wXlj+E8P7drWIvBpRlpfL5eveOewO
   iHOsTs9fH3XUu7KitxL1XsDmRFHCW3wxf4T9lGmYoSpLrEoJDiG54t4Fv
   yrlXjBrgH7w2gyw5tQgoQsXA7hFdikWFoyGmWkXmbTYih+iKQit1UKSsd
   0ii8jk2PemjZgsL02eq+0FcFEw2eGqG2q+8pXFHQw3ZhQhgj33+qRxav1
   Q==;
X-CSE-ConnectionGUID: 8qkPy/gsTv63ZtP+l6cMXQ==
X-CSE-MsgGUID: m8zpw61lQN+FsDIaAXL9XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="54340184"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="54340184"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 03:38:17 -0800
X-CSE-ConnectionGUID: cSXRxaFGSV67tS241Ll9Jw==
X-CSE-MsgGUID: 4LM4TvyUQhSGnO11Lszf2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103899079"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO localhost) ([10.245.244.158])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 03:38:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Jan 2025 13:38:10 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/6] platform/x86:intel/pmc: Create generic_core_init()
 for all platforms
In-Reply-To: <20250110002612.244782-4-xi.pardee@linux.intel.com>
Message-ID: <060937ad-7bd7-513b-5d0a-7dafcfd700b0@linux.intel.com>
References: <20250110002612.244782-1-xi.pardee@linux.intel.com> <20250110002612.244782-4-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1719440210-1736509090=:1003"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1719440210-1736509090=:1003
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Jan 2025, Xi Pardee wrote:

> Create a generic_core_init() function for all architectures to reduce
> duplicate code in each architecture file. Create an info structure
> to catch the variations between each architecture and pass it to the
> generic init function.
>=20
> Convert all architectures to call the generic core init function.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/adl.c  | 21 +++++--------
>  drivers/platform/x86/intel/pmc/arl.c  | 43 ++++++++-------------------
>  drivers/platform/x86/intel/pmc/cnp.c  | 21 +++++--------
>  drivers/platform/x86/intel/pmc/core.c | 42 ++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h | 22 ++++++++++++++
>  drivers/platform/x86/intel/pmc/icl.c  | 17 ++++-------
>  drivers/platform/x86/intel/pmc/lnl.c  | 18 +++++------
>  drivers/platform/x86/intel/pmc/mtl.c  | 42 ++++++++------------------
>  drivers/platform/x86/intel/pmc/spt.c  | 17 ++++-------
>  drivers/platform/x86/intel/pmc/tgl.c  | 31 +++++++++----------
>  10 files changed, 138 insertions(+), 136 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/=
intel/pmc/adl.c
> index e7878558fd909..ac37f4ece9c70 100644
> --- a/drivers/platform/x86/intel/pmc/adl.c
> +++ b/drivers/platform/x86/intel/pmc/adl.c
> @@ -311,20 +311,13 @@ const struct pmc_reg_map adl_reg_map =3D {
>  =09.pson_residency_counter_step =3D TGL_PSON_RES_COUNTER_STEP,
>  };
> =20
> +static struct pmc_dev_info adl_pmc_dev =3D {
> +=09.map =3D &adl_reg_map,
> +=09.suspend =3D cnl_suspend,
> +=09.resume =3D cnl_resume,
> +};
> +
>  int adl_core_init(struct pmc_dev *pmcdev)
>  {
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> -=09int ret;
> -
> -=09pmcdev->suspend =3D cnl_suspend;
> -=09pmcdev->resume =3D cnl_resume;
> -
> -=09pmc->map =3D &adl_reg_map;
> -=09ret =3D get_primary_reg_base(pmc);
> -=09if (ret)
> -=09=09return ret;
> -
> -=09pmc_core_get_low_power_modes(pmcdev);
> -
> -=09return 0;
> +=09return generic_core_init(pmcdev, &adl_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/=
intel/pmc/arl.c
> index ad976cc83ecae..dedf752237ca0 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -691,40 +691,23 @@ static int arl_resume(struct pmc_dev *pmcdev)
>  =09return cnl_resume(pmcdev);
>  }
> =20
> +static struct pmc_dev_info arl_pmc_dev =3D {
> +=09.func =3D 0,
> +=09.dmu_guid =3D ARL_PMT_DMU_GUID,
> +=09.regmap_list =3D arl_pmc_info_list,
> +=09.map =3D &arl_socs_reg_map,
> +=09.suspend =3D cnl_suspend,
> +=09.resume =3D arl_resume,
> +};
> +
>  int arl_core_init(struct pmc_dev *pmcdev)
>  {
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
>  =09int ret;
> -=09int func =3D 0;
> -=09bool ssram_init =3D true;
> -
> -=09arl_d3_fixup();
> -=09pmcdev->suspend =3D cnl_suspend;
> -=09pmcdev->resume =3D arl_resume;
> -=09pmcdev->regmap_list =3D arl_pmc_info_list;
> -
> -=09/*
> -=09 * If ssram init fails use legacy method to at least get the
> -=09 * primary PMC
> -=09 */
> -=09ret =3D pmc_core_ssram_init(pmcdev, func);
> -=09if (ret) {
> -=09=09ssram_init =3D false;
> -=09=09pmc->map =3D &arl_socs_reg_map;
> -
> -=09=09ret =3D get_primary_reg_base(pmc);
> -=09=09if (ret)
> -=09=09=09return ret;
> -=09}
> =20
> -=09pmc_core_get_low_power_modes(pmcdev);
> -=09pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
> -
> -=09if (ssram_init)=09{
> -=09=09ret =3D pmc_core_ssram_get_lpm_reqs(pmcdev);
> -=09=09if (ret)
> -=09=09=09return ret;
> -=09}
> +=09ret =3D generic_core_init(pmcdev, &arl_pmc_dev);
> +=09if (ret)
> +=09=09return ret;
> =20
> +=09arl_d3_fixup();
>  =09return 0;
>  }
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/=
intel/pmc/cnp.c
> index fc5193fdf8a88..6d268058e40b9 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -274,20 +274,13 @@ int cnl_resume(struct pmc_dev *pmcdev)
>  =09return pmc_core_resume_common(pmcdev);
>  }
> =20
> +static struct pmc_dev_info cnp_pmc_dev =3D {
> +=09.map =3D &cnp_reg_map,
> +=09.suspend =3D cnl_suspend,
> +=09.resume =3D cnl_resume,
> +};
> +
>  int cnp_core_init(struct pmc_dev *pmcdev)
>  {
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> -=09int ret;
> -
> -=09pmcdev->suspend =3D cnl_suspend;
> -=09pmcdev->resume =3D cnl_resume;
> -
> -=09pmc->map =3D &cnp_reg_map;
> -=09ret =3D get_primary_reg_base(pmc);
> -=09if (ret)
> -=09=09return ret;
> -
> -=09pmc_core_get_low_power_modes(pmcdev);
> -
> -=09return 0;
> +=09return generic_core_init(pmcdev, &cnp_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 3e7f99ac8c941..64b1c15e0c81d 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1344,6 +1344,48 @@ static void pmc_core_dbgfs_register(struct pmc_dev=
 *pmcdev)
>  =09}
>  }
> =20
> +/*
> + * When supported, ssram init is used to achieve all available PMCs.
> + * If ssram init fails, this function uses legacy method to at least get=
 the
> + * primary PMC.
> + */
> +int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_d=
ev_info)
> +{
> +=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> +=09bool ssram;
> +=09int ret;
> +
> +=09pmcdev->suspend =3D pmc_dev_info->suspend;
> +=09pmcdev->resume =3D pmc_dev_info->resume;
> +
> +=09ssram =3D pmc_dev_info->regmap_list !=3D NULL;
> +=09if (ssram) {
> +=09=09pmcdev->regmap_list =3D pmc_dev_info->regmap_list;
> +=09=09ret =3D pmc_core_ssram_init(pmcdev, pmc_dev_info->func);
> +=09=09if (ret) {
> +=09=09=09dev_warn(&pmcdev->pdev->dev,
> +=09=09=09=09 "ssram init failed, %d, using legacy init\n", ret);
> +=09=09=09ssram =3D false;
> +=09=09}
> +=09}
> +
> +=09if (!ssram) {
> +=09=09pmc->map =3D pmc_dev_info->map;
> +=09=09ret =3D get_primary_reg_base(pmc);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09pmc_core_get_low_power_modes(pmcdev);
> +=09if (pmc_dev_info->dmu_guid)
> +=09=09pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
> +
> +=09if (ssram)
> +=09=09return pmc_core_ssram_get_lpm_reqs(pmcdev);
> +
> +=09return 0;
> +}
> +
>  static const struct x86_cpu_id intel_pmc_core_ids[] =3D {
>  =09X86_MATCH_VFM(INTEL_SKYLAKE_L,=09=09spt_core_init),
>  =09X86_MATCH_VFM(INTEL_SKYLAKE,=09=09spt_core_init),
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index a0f6cc427ddca..80adae582ce5f 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -435,6 +435,27 @@ enum pmc_index {
>  =09PMC_IDX_MAX
>  };
> =20
> +/**
> + * struct pmc_dev_info - Structure to keep PMC device info
> + * @func:=09=09Function number of the primary PMC
> + * @dmu_guid:=09=09DMU GUID

Perhaps write DMU in open form as it's non-obvious acronym?

> + * @regmap_list:=09Pointer to a list of pmc_info structure that could be
> + *=09=09=09available for the platform. When set, this field implies
> + *=09=09=09SSRAM support.
> + * @map:=09=09Pointer to a pmc_reg_map struct that contains platform
> + *=09=09=09specific attributes of the primary PMC
> + * @suspend:=09=09Function to perform platform specific suspend
> + * @resume:=09=09Function to perform platform specific resume
> + */
> +struct pmc_dev_info {
> +=09u8 func;

I'd consider renaming func to pci_func because name "func" associates to=20
C functions.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> +=09u32 dmu_guid;
> +=09struct pmc_info *regmap_list;
> +=09const struct pmc_reg_map *map;
> +=09void (*suspend)(struct pmc_dev *pmcdev);
> +=09int (*resume)(struct pmc_dev *pmcdev);
> +};
> +
>  extern const struct pmc_bit_map msr_map[];
>  extern const struct pmc_bit_map spt_pll_map[];
>  extern const struct pmc_bit_map spt_mphy_map[];
> @@ -591,6 +612,7 @@ extern void pmc_core_set_device_d3(unsigned int devic=
e);
> =20
>  extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
> =20
> +int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_d=
ev_info);
>  int spt_core_init(struct pmc_dev *pmcdev);
>  int cnp_core_init(struct pmc_dev *pmcdev);
>  int icl_core_init(struct pmc_dev *pmcdev);
> diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/=
intel/pmc/icl.c
> index 71b0fd6cb7d84..0e4565dea0452 100644
> --- a/drivers/platform/x86/intel/pmc/icl.c
> +++ b/drivers/platform/x86/intel/pmc/icl.c
> @@ -50,18 +50,11 @@ const struct pmc_reg_map icl_reg_map =3D {
>  =09.etr3_offset =3D ETR3_OFFSET,
>  };
> =20
> +static struct pmc_dev_info icl_pmc_dev =3D {
> +=09.map =3D &icl_reg_map,
> +};
> +
>  int icl_core_init(struct pmc_dev *pmcdev)
>  {
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> -=09int ret;
> -
> -=09pmc->map =3D &icl_reg_map;
> -
> -=09ret =3D get_primary_reg_base(pmc);
> -=09if (ret)
> -=09=09return ret;
> -
> -=09pmc_core_get_low_power_modes(pmcdev);
> -
> -=09return ret;
> +=09return generic_core_init(pmcdev, &icl_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/=
intel/pmc/lnl.c
> index 09b13df90d685..2e6d4fddd2858 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -550,22 +550,20 @@ static int lnl_resume(struct pmc_dev *pmcdev)
>  =09return cnl_resume(pmcdev);
>  }
> =20
> +static struct pmc_dev_info lnl_pmc_dev =3D {
> +=09.map =3D &lnl_socm_reg_map,
> +=09.suspend =3D cnl_suspend,
> +=09.resume =3D lnl_resume,
> +};
> +
>  int lnl_core_init(struct pmc_dev *pmcdev)
>  {
>  =09int ret;
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> -
> -=09lnl_d3_fixup();
> =20
> -=09pmcdev->suspend =3D cnl_suspend;
> -=09pmcdev->resume =3D lnl_resume;
> -
> -=09pmc->map =3D &lnl_socm_reg_map;
> -=09ret =3D get_primary_reg_base(pmc);
> +=09ret =3D generic_core_init(pmcdev, &lnl_pmc_dev);
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09pmc_core_get_low_power_modes(pmcdev);
> -
> +=09lnl_d3_fixup();
>  =09return 0;
>  }
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/=
intel/pmc/mtl.c
> index 07687a3e436d5..3bc0b64d19141 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -990,39 +990,23 @@ static int mtl_resume(struct pmc_dev *pmcdev)
>  =09return cnl_resume(pmcdev);
>  }
> =20
> +static struct pmc_dev_info mtl_pmc_dev =3D {
> +=09.func =3D 2,
> +=09.dmu_guid =3D MTL_PMT_DMU_GUID,
> +=09.regmap_list =3D mtl_pmc_info_list,
> +=09.map =3D &mtl_socm_reg_map,
> +=09.suspend =3D cnl_suspend,
> +=09.resume =3D mtl_resume,
> +};
> +
>  int mtl_core_init(struct pmc_dev *pmcdev)
>  {
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
>  =09int ret;
> -=09int func =3D 2;
> -=09bool ssram_init =3D true;
> =20
> -=09mtl_d3_fixup();
> -
> -=09pmcdev->suspend =3D cnl_suspend;
> -=09pmcdev->resume =3D mtl_resume;
> -=09pmcdev->regmap_list =3D mtl_pmc_info_list;
> -
> -=09/*
> -=09 * If ssram init fails use legacy method to at least get the
> -=09 * primary PMC
> -=09 */
> -=09ret =3D pmc_core_ssram_init(pmcdev, func);
> -=09if (ret) {
> -=09=09ssram_init =3D false;
> -=09=09dev_warn(&pmcdev->pdev->dev,
> -=09=09=09 "ssram init failed, %d, using legacy init\n", ret);
> -=09=09pmc->map =3D &mtl_socm_reg_map;
> -=09=09ret =3D get_primary_reg_base(pmc);
> -=09=09if (ret)
> -=09=09=09return ret;
> -=09}
> -
> -=09pmc_core_get_low_power_modes(pmcdev);
> -=09pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
> -
> -=09if (ssram_init)
> -=09=09return pmc_core_ssram_get_lpm_reqs(pmcdev);
> +=09ret =3D generic_core_init(pmcdev, &mtl_pmc_dev);
> +=09if (ret)
> +=09=09return ret;
> =20
> +=09mtl_d3_fixup();
>  =09return 0;
>  }
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/=
intel/pmc/spt.c
> index ab993a69e33ee..ab5f66fcb0c30 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -134,18 +134,11 @@ const struct pmc_reg_map spt_reg_map =3D {
>  =09.pm_vric1_offset =3D SPT_PMC_VRIC1_OFFSET,
>  };
> =20
> +static struct pmc_dev_info spt_pmc_dev =3D {
> +=09.map =3D &spt_reg_map,
> +};
> +
>  int spt_core_init(struct pmc_dev *pmcdev)
>  {
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> -=09int ret;
> -
> -=09pmc->map =3D &spt_reg_map;
> -
> -=09ret =3D get_primary_reg_base(pmc);
> -=09if (ret)
> -=09=09return ret;
> -
> -=09pmc_core_get_low_power_modes(pmcdev);
> -
> -=09return ret;
> +=09return generic_core_init(pmcdev, &spt_pmc_dev);
>  }
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/=
intel/pmc/tgl.c
> index 4fec43d212d01..bc3cb949c672e 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -285,35 +285,36 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_devi=
ce *pdev)
>  =09ACPI_FREE(out_obj);
>  }
> =20
> -static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
> -{
> -=09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> -=09int ret;
> +static struct pmc_dev_info tgl_l_pmc_dev =3D {
> +=09.map =3D &tgl_reg_map,
> +=09.suspend =3D cnl_suspend,
> +=09.resume =3D cnl_resume,
> +};
> =20
> -=09if (pch_tp =3D=3D PCH_H)
> -=09=09pmc->map =3D &tgl_h_reg_map;
> -=09else
> -=09=09pmc->map =3D &tgl_reg_map;
> +static struct pmc_dev_info tgl_pmc_dev =3D {
> +=09.map =3D &tgl_h_reg_map,
> +=09.suspend =3D cnl_suspend,
> +=09.resume =3D cnl_resume,
> +};
> =20
> -=09pmcdev->suspend =3D cnl_suspend;
> -=09pmcdev->resume =3D cnl_resume;
> +static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_=
info *pmc_dev_info)
> +{
> +=09int ret;
> =20
> -=09ret =3D get_primary_reg_base(pmc);
> +=09ret =3D generic_core_init(pmcdev, pmc_dev_info);
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09pmc_core_get_low_power_modes(pmcdev);
>  =09pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
> -
>  =09return 0;
>  }
> =20
>  int tgl_l_core_init(struct pmc_dev *pmcdev)
>  {
> -=09return tgl_core_generic_init(pmcdev, PCH_LP);
> +=09return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
>  }
> =20
>  int tgl_core_init(struct pmc_dev *pmcdev)
>  {
> -=09return tgl_core_generic_init(pmcdev, PCH_H);
> +=09return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
>  }
>=20
--8323328-1719440210-1736509090=:1003--

