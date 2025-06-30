Return-Path: <linux-pm+bounces-29834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AB1AEDADA
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 13:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6BA3AFD9B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 11:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FFE25DB1D;
	Mon, 30 Jun 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja9mBBKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EF25CC5B;
	Mon, 30 Jun 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282749; cv=none; b=DLj8JIgBZhdu7t0ovCxAxIKXSCg3VeOl6yIrAkwnjPPjho2IQlWOSIj2Zji8pArzybyoZkrnsZl5AvZxDqrRDL15nFbmAFHqrT6ZDAz9jELqecm6ZqPPMY2T+BpK1SGdQ/SZhj+D3w/CT2QJaQxpYo1YSSuHowHoqdG1XY6TaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282749; c=relaxed/simple;
	bh=u3TUGTWaflV6RbwNMGOJc1lex47uG8vXxUvt9JwXxc0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SMemxfMgudBQ6DEPAn3nGgnlJFsiWcgFA3H2zytRZyOSXcEZn+VhaWRvgXbUYv2ma8CUfteiLWll5JIvgIeuu3R73zXoQsFB2ORwdILtitS1OQwRrfknDuKRDXmBvoyQCQGY3rGtgxgWSZWa8lzVfBP600V7YKeU7t8BGJUjfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja9mBBKR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751282748; x=1782818748;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=u3TUGTWaflV6RbwNMGOJc1lex47uG8vXxUvt9JwXxc0=;
  b=ja9mBBKRcNjE1+g13ZWb342kSjG4YzmtqcQEK9S4tRc7uKcomIwTkAXP
   CtrdxP8FQaZK62Jm9UrxzAz87XTLZK431jsNL9U/CAtxja7EM5Jgpk6u1
   By4kadlQgvyamPjSZQEFCNIqg+RzA/P9oxmCliHHAYkUDS6Ru+8LO6NfH
   vZEAVQchnVjzmudKSl8fueUrFW80oVF3Rkl0jdoZShqoTzNReugqaVOZD
   vINMq9cUCERoKIVSl92ajJRfrFRvRgF+xrMMBxLKRdw7UWCOvd2UNQjuM
   uRTgInP32+IrchMNFub+HnR4yyfO/8DbhYVwFOauh1NiWZ0Z6MJ8j3/VK
   g==;
X-CSE-ConnectionGUID: qhWIDnO+SHy/51kcXFNWHA==
X-CSE-MsgGUID: dq9qDaaARBCHsUzXpDaj7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53366733"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53366733"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:25:47 -0700
X-CSE-ConnectionGUID: jci0W735S6e4fSvEfuoSqA==
X-CSE-MsgGUID: MyzQQzpZTUyCMFut/SMZrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="177098810"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:25:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Jun 2025 14:25:41 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] platform/x86:intel/pmc: Enable SSRAM support for
 Lunar Lake
In-Reply-To: <20250625063145.624585-2-xi.pardee@linux.intel.com>
Message-ID: <36b3528e-9110-f027-4dff-4a3dfc38364e@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com> <20250625063145.624585-2-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1026149854-1751282741=:7079"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1026149854-1751282741=:7079
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Jun 2025, Xi Pardee wrote:

> Enable Lunar Lake platforms to achieve PMC information from
> Intel PMC SSRAM Telemetry driver and substate requirements data
> from telemetry region.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/lnl.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/=
intel/pmc/lnl.c
> index da513c234714b..e08a77c778c2c 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -13,6 +13,10 @@
> =20
>  #include "core.h"
> =20
> +#define SOCM_LPM_REQ_GUID=090x15099748
> +
> +static const u8 LNL_LPM_REG_INDEX[] =3D {0, 4, 5, 6, 8, 9, 10, 11, 12, 1=
3, 14, 15, 16, 20};
> +
>  static const struct pmc_bit_map lnl_ltr_show_map[] =3D {
>  =09{"SOUTHPORT_A",=09=09CNP_PMC_LTR_SPA},
>  =09{"SOUTHPORT_B",=09=09CNP_PMC_LTR_SPB},
> @@ -528,6 +532,16 @@ static const struct pmc_reg_map lnl_socm_reg_map =3D=
 {
>  =09.lpm_live_status_offset =3D MTL_LPM_LIVE_STATUS_OFFSET,
>  =09.s0ix_blocker_maps =3D lnl_blk_maps,
>  =09.s0ix_blocker_offset =3D LNL_S0IX_BLOCKER_OFFSET,
> +=09.lpm_reg_index =3D LNL_LPM_REG_INDEX,
> +};
> +
> +static struct pmc_info lnl_pmc_info_list[] =3D {
> +=09{
> +=09=09.guid=09=3D SOCM_LPM_REQ_GUID,
> +=09=09.devid=09=3D PMC_DEVID_LNL_SOCM,
> +=09=09.map=09=3D &lnl_socm_reg_map,
> +=09},
> +=09{}
>  };
> =20
>  #define LNL_NPU_PCI_DEV=09=090x643e
> @@ -557,6 +571,8 @@ static int lnl_core_init(struct pmc_dev *pmcdev, stru=
ct pmc_dev_info *pmc_dev_in
>  }
> =20
>  struct pmc_dev_info lnl_pmc_dev =3D {
> +=09.pci_func =3D 2,
> +=09.regmap_list =3D lnl_pmc_info_list,
>  =09.map =3D &lnl_socm_reg_map,
>  =09.suspend =3D cnl_suspend,
>  =09.resume =3D lnl_resume,
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1026149854-1751282741=:7079--

