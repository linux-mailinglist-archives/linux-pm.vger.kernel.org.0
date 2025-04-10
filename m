Return-Path: <linux-pm+bounces-25107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF31A842FA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790CA1B84B26
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8035E284B49;
	Thu, 10 Apr 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8996L+9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AF283CBA;
	Thu, 10 Apr 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287812; cv=none; b=pStbLkrWdJ/J64lhetuPrFy2rX40jtzLptgEcVSzb4swXcAD4spuqOI/afxtVR0wPexoL0z0myNtbIcx5X874EOnsstHJdjWfAPeyIvhOXTFPH8cHkX1Duqn/S1VlWidOvWQQYP+Ymr68S4087D5qNqUDMFrp5TQowXric+3+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287812; c=relaxed/simple;
	bh=3ca8h9MZ3xBW+F4Zu0f/Ph0ZxenpfVFsPGdwInE9nF8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=n4esHyXXd9rLgg0kjwyxVxK7hka0ERiOrs9qPetk7x0LFvagcUYsoCLmEKDOzAN4ra/6umO+WSQ8RNX4XWnw9pGMDKcPGMyhE9AblKRbDwVyO6U8HMtlS7G62/4ul8byml4xh9raV+YqidG2YXXpfx0fPDRplMnD/cEz1Crrqwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8996L+9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744287810; x=1775823810;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3ca8h9MZ3xBW+F4Zu0f/Ph0ZxenpfVFsPGdwInE9nF8=;
  b=F8996L+9rSe3xT2aLH/cYf+vpACK/qz/ESX58clyNwQuduZSfoWTmI6Z
   coxZcHdYu65N9UmZiEMQqVbovt4dphPFt2l8iD/XP/xWIU86d7BCMc+JT
   uosNO03zX3enDRVxlw0eb3PZBu94D77sjgJUYsnY8me2eFBP+hgfGsjtQ
   wLkb9+zvelG3jcR77qINMi79hfiqCEMvps6Ev1DdtpVueMm730h60LzRW
   Al20E7Jf8O2CC+FSjsV7kl+JkP4OqqHao6WG72HCmC1/n/NiHo/XTs9yP
   NcJVHqtGNRBtFwFhNjz+LAeamf06IqWEoAELP7tjSAwc/LU+fr+mUE+vi
   w==;
X-CSE-ConnectionGUID: 2/xTFU8fS2+OBxmaE1f2yQ==
X-CSE-MsgGUID: K/J7qi4RS/agfI/d/9sKBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45692675"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45692675"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:23:29 -0700
X-CSE-ConnectionGUID: 06HL3J4oR9O4Xv6JMcCirA==
X-CSE-MsgGUID: uz6Rbv7tThqxKSaEIayKfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="133015394"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:23:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 10 Apr 2025 15:23:23 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/8] platform/x86:intel/pmc: Move PMC Core related
 functions
In-Reply-To: <20250409191056.15434-2-xi.pardee@linux.intel.com>
Message-ID: <dc012ad3-ec28-0959-426e-25ecc8b4f755@linux.intel.com>
References: <20250409191056.15434-1-xi.pardee@linux.intel.com> <20250409191056.15434-2-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-649719380-1744287598=:24458"
Content-ID: <b7f27180-2217-5c23-422f-0f6a3968aca7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-649719380-1744287598=:24458
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8e987042-8fc5-7b76-1a1d-9d83dd860395@linux.intel.com>

On Wed, 9 Apr 2025, Xi Pardee wrote:

> Move functions that implements PMC Core feature from core_ssram.c
> to core.c. This patch is a preparation step to introduce a new
> SSRAM Telemetry driver for the SSRAM device.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c       | 168 +++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h       |   9 +-
>  drivers/platform/x86/intel/pmc/core_ssram.c | 175 --------------------
>  3 files changed, 176 insertions(+), 176 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 7a1d11f2914f..a42dc62d70da 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1345,6 +1345,173 @@ static void pmc_core_dbgfs_register(struct pmc_de=
v *pmcdev)
>  =09}
>  }
> =20
> +static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_re=
g_map *map)
> +{
> +=09for (; list->map; ++list)
> +=09=09if (list->map =3D=3D map)
> +=09=09=09return list->guid;
> +
> +=09return 0;
> +}
> +
> +static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
> +{
> +=09struct telem_endpoint *ep;
> +=09const u8 *lpm_indices;
> +=09int num_maps, mode_offset =3D 0;
> +=09int ret, mode;
> +=09int lpm_size;
> +=09u32 guid;
> +
> +=09lpm_indices =3D pmc->map->lpm_reg_index;
> +=09num_maps =3D pmc->map->lpm_num_maps;
> +=09lpm_size =3D LPM_MAX_NUM_MODES * num_maps;
> +
> +=09guid =3D pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
> +=09if (!guid)
> +=09=09return -ENXIO;
> +
> +=09ep =3D pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, gui=
d, 0);
> +=09if (IS_ERR(ep)) {
> +=09=09dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
> +=09=09=09PTR_ERR(ep));

It seems I started to suggest changes into a move only patch (so those=20
suggestions below would be better to implement as separate patches).

Please use %pe.

> +=09=09return -EPROBE_DEFER;
> +=09}
> +
> +=09pmc->lpm_req_regs =3D devm_kzalloc(&pmcdev->pdev->dev,
> +=09=09=09=09=09 lpm_size * sizeof(u32),
> +=09=09=09=09=09 GFP_KERNEL);
> +=09if (!pmc->lpm_req_regs) {
> +=09=09ret =3D -ENOMEM;
> +=09=09goto unregister_ep;
> +=09}
> +
> +=09/*
> +=09 * PMC Low Power Mode (LPM) table
> +=09 *
> +=09 * In telemetry space, the LPM table contains a 4 byte header followe=
d
> +=09 * by 8 consecutive mode blocks (one for each LPM mode). Each block
> +=09 * has a 4 byte header followed by a set of registers that describe t=
he
> +=09 * IP state requirements for the given mode. The IP mapping is platfo=
rm
> +=09 * specific but the same for each block, making for easy analysis.
> +=09 * Platforms only use a subset of the space to track the requirements
> +=09 * for their IPs. Callers provide the requirement registers they use =
as
> +=09 * a list of indices. Each requirement register is associated with an
> +=09 * IP map that's maintained by the caller.
> +=09 *
> +=09 * Header
> +=09 * +----+----------------------------+----------------------------+
> +=09 * |  0 |      REVISION              |      ENABLED MODES         |
> +=09 * +----+--------------+-------------+-------------+--------------+
> +=09 *
> +=09 * Low Power Mode 0 Block
> +=09 * +----+--------------+-------------+-------------+--------------+
> +=09 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
> +=09 * +----+--------------+-------------+-------------+--------------+
> +=09 * |  2 |           LPM0 Requirements 0                           |
> +=09 * +----+---------------------------------------------------------+
> +=09 * |    |                  ...                                    |
> +=09 * +----+---------------------------------------------------------+
> +=09 * | 29 |           LPM0 Requirements 27                          |
> +=09 * +----+---------------------------------------------------------+
> +=09 *
> +=09 * ...
> +=09 *
> +=09 * Low Power Mode 7 Block
> +=09 * +----+--------------+-------------+-------------+--------------+
> +=09 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
> +=09 * +----+--------------+-------------+-------------+--------------+
> +=09 * | 60 |           LPM7 Requirements 0                           |
> +=09 * +----+---------------------------------------------------------+
> +=09 * |    |                  ...                                    |
> +=09 * +----+---------------------------------------------------------+
> +=09 * | 87 |           LPM7 Requirements 27                          |
> +=09 * +----+---------------------------------------------------------+
> +=09 *
> +=09 */

It would be better to have such a long comment above the function as now=20
it breaks the entire function badly in half.

> +=09mode_offset =3D LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
> +=09pmc_for_each_mode(mode, pmcdev) {
> +=09=09u32 *req_offset =3D pmc->lpm_req_regs + (mode * num_maps);
> +=09=09int m;
> +
> +=09=09for (m =3D 0; m < num_maps; m++) {
> +=09=09=09u8 sample_id =3D lpm_indices[m] + mode_offset;
> +
> +=09=09=09ret =3D pmt_telem_read32(ep, sample_id, req_offset, 1);
> +=09=09=09if (ret) {
> +=09=09=09=09dev_err(&pmcdev->pdev->dev,
> +=09=09=09=09=09"couldn't read Low Power Mode requirements: %d\n", ret);
> +=09=09=09=09devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);

Won't the error propagate and devm_ will take care of freeing? Why is it=20
done explictly here?

> +=09=09=09=09goto unregister_ep;
> +=09=09=09}
> +=09=09=09++req_offset;
> +=09=09}
> +=09=09mode_offset +=3D LPM_REG_COUNT + LPM_MODE_OFFSET;
> +=09}
> +
> +unregister_ep:
> +=09pmt_telem_unregister_endpoint(ep);
> +
> +=09return ret;
> +}

--=20
 i.

> +
> +static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
> +{
> +=09int ret, i;
> +
> +=09if (!pmcdev->ssram_pcidev)
> +=09=09return -ENODEV;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
> +=09=09if (!pmcdev->pmcs[i])
> +=09=09=09continue;
> +
> +=09=09ret =3D pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +
> +const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u1=
6 devid)
> +{
> +=09for (; list->map; ++list)
> +=09=09if (devid =3D=3D list->devid)
> +=09=09=09return list->map;
> +
> +=09return NULL;
> +}
> +
> +int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
> +=09=09     const struct pmc_reg_map *reg_map, int pmc_index)
> +{
> +=09struct pmc *pmc =3D pmcdev->pmcs[pmc_index];
> +
> +=09if (!pwrm_base)
> +=09=09return -ENODEV;
> +
> +=09/* Memory for primary PMC has been allocated in core.c */
> +=09if (!pmc) {
> +=09=09pmc =3D devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL)=
;
> +=09=09if (!pmc)
> +=09=09=09return -ENOMEM;
> +=09}
> +
> +=09pmc->map =3D reg_map;
> +=09pmc->base_addr =3D pwrm_base;
> +=09pmc->regbase =3D ioremap(pmc->base_addr, pmc->map->regmap_length);
> +
> +=09if (!pmc->regbase) {
> +=09=09devm_kfree(&pmcdev->pdev->dev, pmc);
> +=09=09return -ENOMEM;
> +=09}
> +
> +=09pmcdev->pmcs[pmc_index] =3D pmc;
> +
> +=09return 0;
> +}
> +
>  /*
>   * When supported, ssram init is used to achieve all available PMCs.
>   * If ssram init fails, this function uses legacy method to at least get=
 the
> @@ -1719,5 +1886,6 @@ static struct platform_driver pmc_core_driver =3D {
> =20
>  module_platform_driver(pmc_core_driver);
> =20
> +MODULE_IMPORT_NS("INTEL_PMT_TELEMETRY");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Intel PMC Core Driver");
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index 945a1c440cca..09aac6daabbd 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -24,6 +24,11 @@ struct telem_endpoint;
>  #define MAX_NUM_PMC=09=09=093
>  #define S0IX_BLK_SIZE=09=09=094
> =20
> +/* PCH query */
> +#define LPM_HEADER_OFFSET=091
> +#define LPM_REG_COUNT=09=0928
> +#define LPM_MODE_OFFSET=09=091
> +
>  /* Sunrise Point Power Management Controller PCI Device ID */
>  #define SPT_PMC_PCI_DEVICE_ID=09=09=090x9d21
>  #define SPT_PMC_BASE_ADDR_OFFSET=09=090x48
> @@ -485,7 +490,6 @@ extern const struct pmc_reg_map mtl_socm_reg_map;
>  extern const struct pmc_reg_map mtl_ioep_reg_map;
> =20
>  void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
> -int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
>  int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int igno=
re);
> =20
>  int pmc_core_resume_common(struct pmc_dev *pmcdev);
> @@ -497,6 +501,9 @@ void pmc_core_set_device_d3(unsigned int device);
>  int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
> =20
>  int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_d=
ev_info);
> +const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u1=
6 devid);
> +int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
> +=09=09     const struct pmc_reg_map *reg_map, int pmc_index);
> =20
>  extern struct pmc_dev_info spt_pmc_dev;
>  extern struct pmc_dev_info cnp_pmc_dev;
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platfo=
rm/x86/intel/pmc/core_ssram.c
> index 739569803017..e1a83425d802 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -14,7 +14,6 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
> =20
>  #include "core.h"
> -#include "../pmt/telemetry.h"
> =20
>  #define SSRAM_HDR_SIZE=09=090x100
>  #define SSRAM_PWRM_OFFSET=090x14
> @@ -24,142 +23,8 @@
>  #define SSRAM_IOE_OFFSET=090x68
>  #define SSRAM_DEVID_OFFSET=090x70
> =20
> -/* PCH query */
> -#define LPM_HEADER_OFFSET=091
> -#define LPM_REG_COUNT=09=0928
> -#define LPM_MODE_OFFSET=09=091
> -
>  DEFINE_FREE(pmc_core_iounmap, void __iomem *, if (_T) iounmap(_T))
> =20
> -static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_re=
g_map *map)
> -{
> -=09for (; list->map; ++list)
> -=09=09if (list->map =3D=3D map)
> -=09=09=09return list->guid;
> -
> -=09return 0;
> -}
> -
> -static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
> -{
> -=09struct telem_endpoint *ep;
> -=09const u8 *lpm_indices;
> -=09int num_maps, mode_offset =3D 0;
> -=09int ret, mode;
> -=09int lpm_size;
> -=09u32 guid;
> -
> -=09lpm_indices =3D pmc->map->lpm_reg_index;
> -=09num_maps =3D pmc->map->lpm_num_maps;
> -=09lpm_size =3D LPM_MAX_NUM_MODES * num_maps;
> -
> -=09guid =3D pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
> -=09if (!guid)
> -=09=09return -ENXIO;
> -
> -=09ep =3D pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, gui=
d, 0);
> -=09if (IS_ERR(ep)) {
> -=09=09dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
> -=09=09=09PTR_ERR(ep));
> -=09=09return -EPROBE_DEFER;
> -=09}
> -
> -=09pmc->lpm_req_regs =3D devm_kzalloc(&pmcdev->pdev->dev,
> -=09=09=09=09=09 lpm_size * sizeof(u32),
> -=09=09=09=09=09 GFP_KERNEL);
> -=09if (!pmc->lpm_req_regs) {
> -=09=09ret =3D -ENOMEM;
> -=09=09goto unregister_ep;
> -=09}
> -
> -=09/*
> -=09 * PMC Low Power Mode (LPM) table
> -=09 *
> -=09 * In telemetry space, the LPM table contains a 4 byte header followe=
d
> -=09 * by 8 consecutive mode blocks (one for each LPM mode). Each block
> -=09 * has a 4 byte header followed by a set of registers that describe t=
he
> -=09 * IP state requirements for the given mode. The IP mapping is platfo=
rm
> -=09 * specific but the same for each block, making for easy analysis.
> -=09 * Platforms only use a subset of the space to track the requirements
> -=09 * for their IPs. Callers provide the requirement registers they use =
as
> -=09 * a list of indices. Each requirement register is associated with an
> -=09 * IP map that's maintained by the caller.
> -=09 *
> -=09 * Header
> -=09 * +----+----------------------------+----------------------------+
> -=09 * |  0 |      REVISION              |      ENABLED MODES         |
> -=09 * +----+--------------+-------------+-------------+--------------+
> -=09 *
> -=09 * Low Power Mode 0 Block
> -=09 * +----+--------------+-------------+-------------+--------------+
> -=09 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
> -=09 * +----+--------------+-------------+-------------+--------------+
> -=09 * |  2 |           LPM0 Requirements 0                           |
> -=09 * +----+---------------------------------------------------------+
> -=09 * |    |                  ...                                    |
> -=09 * +----+---------------------------------------------------------+
> -=09 * | 29 |           LPM0 Requirements 27                          |
> -=09 * +----+---------------------------------------------------------+
> -=09 *
> -=09 * ...
> -=09 *
> -=09 * Low Power Mode 7 Block
> -=09 * +----+--------------+-------------+-------------+--------------+
> -=09 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
> -=09 * +----+--------------+-------------+-------------+--------------+
> -=09 * | 60 |           LPM7 Requirements 0                           |
> -=09 * +----+---------------------------------------------------------+
> -=09 * |    |                  ...                                    |
> -=09 * +----+---------------------------------------------------------+
> -=09 * | 87 |           LPM7 Requirements 27                          |
> -=09 * +----+---------------------------------------------------------+
> -=09 *
> -=09 */
> -=09mode_offset =3D LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
> -=09pmc_for_each_mode(mode, pmcdev) {
> -=09=09u32 *req_offset =3D pmc->lpm_req_regs + (mode * num_maps);
> -=09=09int m;
> -
> -=09=09for (m =3D 0; m < num_maps; m++) {
> -=09=09=09u8 sample_id =3D lpm_indices[m] + mode_offset;
> -
> -=09=09=09ret =3D pmt_telem_read32(ep, sample_id, req_offset, 1);
> -=09=09=09if (ret) {
> -=09=09=09=09dev_err(&pmcdev->pdev->dev,
> -=09=09=09=09=09"couldn't read Low Power Mode requirements: %d\n", ret);
> -=09=09=09=09devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);
> -=09=09=09=09goto unregister_ep;
> -=09=09=09}
> -=09=09=09++req_offset;
> -=09=09}
> -=09=09mode_offset +=3D LPM_REG_COUNT + LPM_MODE_OFFSET;
> -=09}
> -
> -unregister_ep:
> -=09pmt_telem_unregister_endpoint(ep);
> -
> -=09return ret;
> -}
> -
> -int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
> -{
> -=09int ret, i;
> -
> -=09if (!pmcdev->ssram_pcidev)
> -=09=09return -ENODEV;
> -
> -=09for (i =3D 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
> -=09=09if (!pmcdev->pmcs[i])
> -=09=09=09continue;
> -
> -=09=09ret =3D pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
> -=09=09if (ret)
> -=09=09=09return ret;
> -=09}
> -
> -=09return 0;
> -}
> -
>  static void
>  pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
>  {
> @@ -203,50 +68,11 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, =
void __iomem *ssram)
>  =09intel_vsec_register(pcidev, &info);
>  }
> =20
> -static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *l=
ist, u16 devid)
> -{
> -=09for (; list->map; ++list)
> -=09=09if (devid =3D=3D list->devid)
> -=09=09=09return list->map;
> -
> -=09return NULL;
> -}
> -
>  static inline u64 get_base(void __iomem *addr, u32 offset)
>  {
>  =09return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
>  }
> =20
> -static int
> -pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
> -=09=09 const struct pmc_reg_map *reg_map, int pmc_index)
> -{
> -=09struct pmc *pmc =3D pmcdev->pmcs[pmc_index];
> -
> -=09if (!pwrm_base)
> -=09=09return -ENODEV;
> -
> -=09/* Memory for primary PMC has been allocated in core.c */
> -=09if (!pmc) {
> -=09=09pmc =3D devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL)=
;
> -=09=09if (!pmc)
> -=09=09=09return -ENOMEM;
> -=09}
> -
> -=09pmc->map =3D reg_map;
> -=09pmc->base_addr =3D pwrm_base;
> -=09pmc->regbase =3D ioremap(pmc->base_addr, pmc->map->regmap_length);
> -
> -=09if (!pmc->regbase) {
> -=09=09devm_kfree(&pmcdev->pdev->dev, pmc);
> -=09=09return -ENOMEM;
> -=09}
> -
> -=09pmcdev->pmcs[pmc_index] =3D pmc;
> -
> -=09return 0;
> -}
> -
>  static int
>  pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
>  {
> @@ -329,4 +155,3 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev, int f=
unc)
>  =09return ret;
>  }
>  MODULE_IMPORT_NS("INTEL_VSEC");
> -MODULE_IMPORT_NS("INTEL_PMT_TELEMETRY");
>=20
--8323328-649719380-1744287598=:24458--

