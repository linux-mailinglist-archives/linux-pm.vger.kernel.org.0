Return-Path: <linux-pm+bounces-13148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3154B964232
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1002841F7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1114918E342;
	Thu, 29 Aug 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8bj8y11"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFAE14B950;
	Thu, 29 Aug 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928604; cv=none; b=IyAu4qQd5P2rO8qTuzBM7tMIAsVxiOMXqDK8CQcit6USzlo1atNLQy2M3TKABOI0FBq1xTVo24aHzO77lUoueL+qo1gGSWPs0Et/Q6zA7rFWBrzGQDc6aKrAEfzwa2C0HK9uKwNV4LKwYGgCqAeupTMx6vXEJ9rNyHq3bzvBEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928604; c=relaxed/simple;
	bh=zhVfqPiUM+P743D4H7DjFZxEY87SP/S2JyLRZ7voctU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hkmMWF4yAkHT9e+Afcu5zz5J0oncMTo5GZIfL5F2fnL8Q/HS/aX/QoSasmq/i/UteoE49yzbFoKnW2ZE/A0RB9eSLxm3si7jDLNoTnQi1v15+ljSNAW5xwyWgE6kCZx7Ucgf5AqLI4kaOJ6kQ3PA34wKeZ5iDckgCctE3eTDS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8bj8y11; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724928603; x=1756464603;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zhVfqPiUM+P743D4H7DjFZxEY87SP/S2JyLRZ7voctU=;
  b=Z8bj8y115kVmMsI5VNPBXcSaa2s1U8NTGQiLzJApvffd+66EMIDV58QO
   /SXLUow1WTSCxZoL7HcZwg92E1HOWcKOnsk83gjSzMk7JEiC6pT9u22Tg
   efT/IptMahQDfIbZqRPmRC3XhT1PILn43hxhWKT33zEwSzSzcPVBp1kOf
   9+g+bWgF1698awAd9iem+njghoTK4phyHTyyUZ8J/mJ6BYnT+7BS5C8cc
   hnEzPovztGy4RUjai0ZAqAB92ozc4JBR/ax8MddY+YVsq0vf1nWw11llQ
   GbRcQGyTSCUkVdbex2AJheG0xFx3BkrbljA1RGUHpJu6XK5Vsu2n0TAdt
   g==;
X-CSE-ConnectionGUID: mwyRZ7mcRHW6pTsd+altBg==
X-CSE-MsgGUID: hkEnYTx0Qq+qOsKGalJL6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34167815"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34167815"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 03:50:02 -0700
X-CSE-ConnectionGUID: WMWq/P6tR/i6TY51Y1ETFQ==
X-CSE-MsgGUID: qJ8P+zFfQuSCSPCPC4eELg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="94275855"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 03:49:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 13:49:54 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/11] platform/x86:intel/pmc: Move PMC Core related
 functions
In-Reply-To: <20240828222932.1279508-2-xi.pardee@linux.intel.com>
Message-ID: <e4f44ead-b0a4-d42d-d3ba-85fa8f133305@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com> <20240828222932.1279508-2-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1690604502-1724928594=:1289"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1690604502-1724928594=:1289
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Aug 2024, Xi Pardee wrote:

> Move functions that implements PMC Core feature from core_ssram.c
> to core.c. This patch is a preparation step to introduce a new
> SSRAM Telemetry driver for the SSRAM device.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> ---
>  drivers/platform/x86/intel/pmc/core.c       | 168 +++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h       |   8 +
>  drivers/platform/x86/intel/pmc/core_ssram.c | 173 --------------------
>  3 files changed, 176 insertions(+), 173 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 01ae71c6df59..630ce2087552 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1604,6 +1604,173 @@ static const struct dev_pm_ops pmc_core_pm_ops =
=3D {
>  =09SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
>  };
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
> +=09int ret, mode, i;
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
> +=09mode_offset =3D LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
> +=09pmc_for_each_mode(i, mode, pmcdev) {
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
> +
> +int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
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
>  static const struct acpi_device_id pmc_core_acpi_ids[] =3D {
>  =09{"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
>  =09{ }
> @@ -1623,5 +1790,6 @@ static struct platform_driver pmc_core_driver =3D {
> =20
>  module_platform_driver(pmc_core_driver);
> =20
> +MODULE_IMPORT_NS(INTEL_PMT_TELEMETRY);
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Intel PMC Core Driver");
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index ea04de7eb9e8..9a1cc01f31d9 100644
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
> @@ -589,6 +594,9 @@ extern void pmc_core_punit_pmt_init(struct pmc_dev *p=
mcdev, u32 guid);
>  extern void pmc_core_set_device_d3(unsigned int device);
> =20
>  extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
> +extern const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *l=
ist, u16 devid);
> +extern int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
> +=09=09=09    const struct pmc_reg_map *reg_map, int pmc_index);
> =20
>  int spt_core_init(struct pmc_dev *pmcdev);
>  int cnp_core_init(struct pmc_dev *pmcdev);
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platfo=
rm/x86/intel/pmc/core_ssram.c
> index 1bde86c54eb9..0a2bfca5ff41 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -24,142 +24,8 @@
>  #define SSRAM_IOE_OFFSET=090x68
>  #define SSRAM_DEVID_OFFSET=090x70
> =20
> -/* PCH query */
> -#define LPM_HEADER_OFFSET=091
> -#define LPM_REG_COUNT=09=0928
> -#define LPM_MODE_OFFSET=09=091
> -
>  DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
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
> -=09int ret, mode, i;
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
> -=09pmc_for_each_mode(i, mode, pmcdev) {
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
> @@ -203,50 +69,11 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, =
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
>=20

--=20
 i.

--8323328-1690604502-1724928594=:1289--

