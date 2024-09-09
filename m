Return-Path: <linux-pm+bounces-13876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA58971140
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 10:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482B31F25543
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237B31B3723;
	Mon,  9 Sep 2024 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHSiitou"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2A1B1432;
	Mon,  9 Sep 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869240; cv=none; b=HGqUsveW2aUz/UOTX0H1qQ2MMdABfudxkRxuAY6HvDwvQ/DVX7ezsbSmM7Gnb5VdieOeif4YY4g+FGobDgPPEeiPGqzEJxFXxvz6CYwbFbZW+X/2BMArcK/yV6AWIQy6yB+BoXXFmrxbHihpCyUjVivhqQKKg0WQNzPdBwDqqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869240; c=relaxed/simple;
	bh=8n7w2jxs3cuC+YZ5jj/S+gSWv6BgQ0TufOwe9HT+bws=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=frHD1j7fTe+645B2P1u4aIpDNrUEtl6umxjT4REMQTolSm2Yas2CqWELPa+SOGWmtQfsBB70+7EL5I25QhDCl2dZTh+QxGwLQLCF8ptrtdfWavbRIv9GcnsKZ6T/m4Xj3b0NL0mOh8g51xIB503DcFA6gNE9Yr7phbqLn5ohMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHSiitou; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725869238; x=1757405238;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8n7w2jxs3cuC+YZ5jj/S+gSWv6BgQ0TufOwe9HT+bws=;
  b=AHSiitouaKaA+YJ1tzUEdOVqMrzAZhB2UYds3kQMvThBKQynuXizzpaE
   r4I/3Gv5C7MwHYTzeXtkjpYbfONysjcoG0kKjzIfrz1xx5QuFlcufyC5h
   /4+r8Y7eKBA+TqU7awJ+zYcmsB31H0oxP46dcA7yojNk7sdyxgwcc5Y7s
   +PqgLHV1ITq76Pb6pSLxxyUDWe/g2IohSj5MrlQYYzZtJKjhCKsLf11Hq
   oO3wwjidPxIfIMJGXIH819bd2BsVhaV+IU0Bp+Ymb4CODCR7Wy2dDsOaj
   v3d4F8Pyvbj6Gd1gNRA2FsmwK11eDiZgXaPP5f9jMuDFq6PcL2cvcKoeQ
   A==;
X-CSE-ConnectionGUID: wMI8fMNiRCCiJuDWfpbhug==
X-CSE-MsgGUID: V40bjHGiSV+DSaTQE1i6HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="13435943"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="13435943"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:07:17 -0700
X-CSE-ConnectionGUID: gMc8itF7STuB4QfxM72KEg==
X-CSE-MsgGUID: IzwnFM4iRGy2aALrsiDfXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71153740"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost) ([10.245.245.60])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:07:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Sep 2024 11:07:09 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86:intel/pmc: Ignore all LTRs during
 suspend
In-Reply-To: <20240906184016.268153-1-xi.pardee@linux.intel.com>
Message-ID: <15d08ff3-6787-7042-8afc-3a64f1ebc756@linux.intel.com>
References: <20240906184016.268153-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1125590955-1725869229=:1029"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1125590955-1725869229=:1029
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Sep 2024, Xi Pardee wrote:

> From: Xi Pardee <xi.pardee@intel.com>
>=20
> Add support to ignore all LTRs before suspend and restore the previous
> LTR values after suspend. This feature could be turned off with module
> parameter ltr_ignore_all_suspend.
>=20
> LTR value is a mechanism for a device to indicate tolerance to access
> the corresponding resource. When system suspends, the resource is not
> available and therefore the LTR value could be ignored. Ignoring all
> LTR values prevents problematic device from blocking the system to get
> to the deepest package state during suspend.
>=20
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
>=20
> v2:
> - Add more details to commit message
> - Fix format: ltr->LTR, S0IX->S0ix, space between name and email
>=20
> ---
>  drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  2 +
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 01ae71c6df59..0ec703af16a4 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_fil=
e *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
> =20
> +static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
> +{
> +=09unsigned int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
> +=09=09struct pmc *pmc;
> +=09=09u32 ltr_ign;
> +
> +=09=09pmc =3D pmcdev->pmcs[i];
> +=09=09if (!pmc)
> +=09=09=09continue;
> +
> +=09=09guard(mutex)(&pmcdev->lock);
> +=09=09pmc->ltr_ign =3D pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offse=
t);
> +
> +=09=09/* ltr_ignore_max is the max index value for LTR ignore register *=
/
> +=09=09ltr_ign =3D pmc->ltr_ign | GENMASK(pmc->map->ltr_ignore_max, 0);
> +=09=09pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, ltr_ign);
> +=09}
> +
> +=09/*
> +=09 * Ignoring ME during suspend is blocking platforms with ADL PCH to g=
et to
> +=09 * deeper S0ix substate.
> +=09 */
> +=09pmc_core_send_ltr_ignore(pmcdev, 6, 0);
> +}
> +
> +static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
> +{
> +=09unsigned int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
> +=09=09struct pmc *pmc;
> +
> +=09=09pmc =3D pmcdev->pmcs[i];
> +=09=09if (!pmc)
> +=09=09=09continue;
> +
> +=09=09guard(mutex)(&pmcdev->lock);
> +=09=09pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, pmc->ltr_ign)=
;
> +=09}
> +}
> +
>  static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
>  =09=09=09=09       const int lpm_adj_x2)
>  {
> @@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
>  module_param(warn_on_s0ix_failures, bool, 0644);
>  MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failure=
s");
> =20
> +static bool ltr_ignore_all_suspend =3D true;
> +module_param(ltr_ignore_all_suspend, bool, 0644);
> +MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend=
");
> +
>  static __maybe_unused int pmc_core_suspend(struct device *dev)
>  {
>  =09struct pmc_dev *pmcdev =3D dev_get_drvdata(dev);
> @@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct d=
evice *dev)
>  =09if (pmcdev->suspend)
>  =09=09pmcdev->suspend(pmcdev);
> =20
> +=09if (ltr_ignore_all_suspend)
> +=09=09pmc_core_ltr_ignore_all(pmcdev);
> +
>  =09/* Check if the syspend will actually use S0ix */
>  =09if (pm_suspend_via_firmware())
>  =09=09return 0;
> @@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct de=
vice *dev)
>  {
>  =09struct pmc_dev *pmcdev =3D dev_get_drvdata(dev);
> =20
> +=09if (ltr_ignore_all_suspend)
> +=09=09pmc_core_ltr_restore_all(pmcdev);
> +
>  =09if (pmcdev->resume)
>  =09=09return pmcdev->resume(pmcdev);
> =20
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index ea04de7eb9e8..e862ea88b816 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -372,6 +372,7 @@ struct pmc_info {
>   * @map:=09=09pointer to pmc_reg_map struct that contains platform
>   *=09=09=09specific attributes
>   * @lpm_req_regs:=09List of substate requirements
> + * @ltr_ign:=09=09Holds LTR ignore data while suspended
>   *
>   * pmc contains info about one power management controller device.
>   */
> @@ -380,6 +381,7 @@ struct pmc {
>  =09void __iomem *regbase;
>  =09const struct pmc_reg_map *map;
>  =09u32 *lpm_req_regs;
> +=09u32 ltr_ign;
>  };
> =20
>  /**
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1125590955-1725869229=:1029--

