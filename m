Return-Path: <linux-pm+bounces-29833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD7AEDAD3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 13:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB21F3AA5F7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329AC25C83A;
	Mon, 30 Jun 2025 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zo9lXDzh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4624467A;
	Mon, 30 Jun 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282727; cv=none; b=KV6AC8YgsitlEQgKz/PSzgRMsSmYiXC6+1ZIDLD7+ZJK+8So5uVgf3kaoWZT4E6s+nxWXpzEMHj3tGVUlup9V9WR+kaTuGT163VyTqx4TsZenGJMSci6jpGpq8ajxuzNgg3XySbUHoEINyOCvSz/Q392uB7U0EeAYcfaETl8xQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282727; c=relaxed/simple;
	bh=Kh5HTNvJ65doI+29MrGYbqQvRnFZKdq2N32MrSNK4zc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rYerWHK4CU56u+LKPdY5VU3+pyFq2h2Cq1owbqT8/DRLDoMb3gOlfIqptvTKTCZFsB+JzWwe6JN9OGkxag3a6oBM32ALi6IIlj3DynCxYDnFgP6BD0p+UR005jWxtQ4Lbpr5XLMr9Woia649jKXs2efpXmHmnzF467Af03Jjg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zo9lXDzh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751282725; x=1782818725;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Kh5HTNvJ65doI+29MrGYbqQvRnFZKdq2N32MrSNK4zc=;
  b=Zo9lXDzhWRFnR9drI6Bbmf8y1UZDX1Aq5ZcQHH9Sdr4zIUyoGM/2FxPJ
   px2GHoGCSec/UTUPz2z/0r0iX7jbTubDzo9EbVIbQkQ9h8/bWOOrKHM8b
   1quFwkCFIf+1Tf/yu9ahFfdr+w1Y9ws6QLQXFs1OWBHOa04BxeEFegE+6
   /p+bGhWHRw3XvYJUrwlHQzP9XWm8RpUyw7Dk5JEZN2F4Dtrzh8DlpyOyC
   YjNhAL+89abKIvpkBYu0TBUJWzo3plKFpMRM/8PWIi0XSe4WUYVpcXgxs
   3ztPsB7G9gdYGXoknrtNVr4Bp31uWNPbTi/N6R2NOqMQtwzxQG8U490qp
   A==;
X-CSE-ConnectionGUID: L+q5uhglSRiqn5RxEBsUKg==
X-CSE-MsgGUID: vNNwnK4hTDens1ipH0BWhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53366695"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53366695"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:25:25 -0700
X-CSE-ConnectionGUID: FbdjG4QNTuuypO0WXcN8jg==
X-CSE-MsgGUID: vNE4kJXnR8yEi/1m3UC8+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="177098724"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:25:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Jun 2025 14:25:19 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] platform/x86:intel/pmc: Move telemetry endpoint
 register handling
In-Reply-To: <20250625063145.624585-3-xi.pardee@linux.intel.com>
Message-ID: <a40aa7c1-084c-e49c-33ee-57088a58debe@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com> <20250625063145.624585-3-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-978402621-1751282719=:7079"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-978402621-1751282719=:7079
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Xi Pardee wrote:

> Move telemetry endpoint handling to pmc_core_get_telem_info(). This
> is a preparation patch to introduce a new table to obtain Low Power
> Mode substate requirement data for platforms starting from Panther
> Lake.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 51 +++++++++++++--------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 540cd2fb0673b..a1dd80bdbd413 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1399,36 +1399,23 @@ static u32 pmc_core_find_guid(struct pmc_info *li=
st, const struct pmc_reg_map *m
>   * +----+---------------------------------------------------------+
>   *
>   */
> -static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc,=
 struct pci_dev *pcidev)
> +static int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *=
pmc,
> +=09=09=09=09    struct telem_endpoint *ep)
>  {
> -=09struct telem_endpoint *ep;
>  =09const u8 *lpm_indices;
>  =09int num_maps, mode_offset =3D 0;
>  =09int ret, mode;
>  =09int lpm_size;
> -=09u32 guid;
> =20
>  =09lpm_indices =3D pmc->map->lpm_reg_index;
>  =09num_maps =3D pmc->map->lpm_num_maps;
>  =09lpm_size =3D LPM_MAX_NUM_MODES * num_maps;
> =20
> -=09guid =3D pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
> -=09if (!guid)
> -=09=09return -ENXIO;
> -
> -=09ep =3D pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
> -=09if (IS_ERR(ep)) {
> -=09=09dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %pe", ep)=
;
> -=09=09return -EPROBE_DEFER;
> -=09}
> -
>  =09pmc->lpm_req_regs =3D devm_kzalloc(&pmcdev->pdev->dev,
>  =09=09=09=09=09 lpm_size * sizeof(u32),
>  =09=09=09=09=09 GFP_KERNEL);
> -=09if (!pmc->lpm_req_regs) {
> -=09=09ret =3D -ENOMEM;
> -=09=09goto unregister_ep;
> -=09}
> +=09if (!pmc->lpm_req_regs)
> +=09=09return -ENOMEM;
> =20
>  =09mode_offset =3D LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
>  =09pmc_for_each_mode(mode, pmcdev) {
> @@ -1442,23 +1429,21 @@ static int pmc_core_get_lpm_req(struct pmc_dev *p=
mcdev, struct pmc *pmc, struct
>  =09=09=09if (ret) {
>  =09=09=09=09dev_err(&pmcdev->pdev->dev,
>  =09=09=09=09=09"couldn't read Low Power Mode requirements: %d\n", ret);
> -=09=09=09=09goto unregister_ep;
> +=09=09=09=09return ret;
>  =09=09=09}
>  =09=09=09++req_offset;
>  =09=09}
>  =09=09mode_offset +=3D LPM_REG_COUNT + LPM_MODE_OFFSET;
>  =09}
> -
> -unregister_ep:
> -=09pmt_telem_unregister_endpoint(ep);
> -
>  =09return ret;
>  }
> =20
> -static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev, int func)
> +static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
>  {
>  =09struct pci_dev *pcidev __free(pci_dev_put) =3D NULL;
> +=09struct telem_endpoint *ep;
>  =09unsigned int i;
> +=09u32 guid;
>  =09int ret;
> =20
>  =09pcidev =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
> @@ -1466,10 +1451,24 @@ static int pmc_core_ssram_get_lpm_reqs(struct pmc=
_dev *pmcdev, int func)
>  =09=09return -ENODEV;
> =20
>  =09for (i =3D 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
> -=09=09if (!pmcdev->pmcs[i])
> +=09=09struct pmc *pmc;
> +
> +=09=09pmc =3D pmcdev->pmcs[i];
> +=09=09if (!pmc)
>  =09=09=09continue;
> =20
> -=09=09ret =3D pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i], pcidev);
> +=09=09guid =3D pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
> +=09=09if (!guid)
> +=09=09=09return -ENXIO;
> +
> +=09=09ep =3D pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
> +=09=09if (IS_ERR(ep)) {
> +=09=09=09dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %pe", =
ep);
> +=09=09=09return -EPROBE_DEFER;
> +=09=09}
> +
> +=09=09ret =3D pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
> +=09=09pmt_telem_unregister_endpoint(ep);
>  =09=09if (ret)
>  =09=09=09return ret;
>  =09}
> @@ -1583,7 +1582,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struc=
t pmc_dev_info *pmc_dev_info)
>  =09=09pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
> =20
>  =09if (ssram) {
> -=09=09ret =3D pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func=
);
> +=09=09ret =3D pmc_core_get_telem_info(pmcdev, pmc_dev_info->pci_func);
>  =09=09if (ret)
>  =09=09=09goto unmap_regbase;
>  =09}
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-978402621-1751282719=:7079--

