Return-Path: <linux-pm+bounces-13157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D799643CC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 14:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466A11C249EE
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16731194C77;
	Thu, 29 Aug 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjDKgMjx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB2192B88;
	Thu, 29 Aug 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933016; cv=none; b=UgOiuZ0knvxVgYBMMZoNVgpDU9Z/teFZ1abc8PA4+NPlKn9P/UYoNosOlGbFjvAfrs4c6n1NwoiQaCpQ1CFvrUX9f5eXLcVYsthVawfvz4LiVcuOgnvUcJbHDnZsLu2wHw46+wZBC1cUU3wsoW3TvCeqKVPBrFBV3bNkvY1GBUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933016; c=relaxed/simple;
	bh=IZu0ezfAqrlGYypi0oswKKT4bRIdSOLZlmQ//QTeWM4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e8ywitcyvBPncnQCZUw40PGUVh4MZT3pfx38N5eGra7ITi3x58byX56THDWLRcyIuSAlp6HgWYBqyx4CYByV6uG780hFrtxeMCN64f8S0S/8GQKMqbYSkPDURsnkXO1t69AGAK6TQs34ijJizSSbHUZzdqnyKCfNp+Xom2OYlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjDKgMjx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724933016; x=1756469016;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IZu0ezfAqrlGYypi0oswKKT4bRIdSOLZlmQ//QTeWM4=;
  b=hjDKgMjxmRo7Of+y+7BMBWBQzx9/Y22fjaMuI6KYnaqdYvQzoZmhWGPn
   NdYD9kEi8Zh0j+yemlY8ZsRjHWwqqdy3K3A3tepFHpFsqhNVHIfqpVOTx
   sefppKmpgxblG2yVKicBSpGSYsLZ7V9M2QJB7DQALNd71XMA2p0n3/DKU
   cpQkkPMVsoyBv4Zl5COuj7Ua0GMF85qMqnSze2zumAzyWpJk7c0wNs4NA
   9UbOFnpIVit/JP0XqlnMyOXaMiK7L4vg064aJ1h9AJuYsqH6IUgk0HKjV
   b2tyoILsK62Edsj5pycgHYw2j2Suel/D8f1vnfuCYSknjWlxkNt+uHPiu
   w==;
X-CSE-ConnectionGUID: zOWGR4tcSFiS9wjfcthAOg==
X-CSE-MsgGUID: CVOwf/6tTtCGODJbfms5Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="48905411"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="48905411"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:03:35 -0700
X-CSE-ConnectionGUID: 7FwVc+yURE6ZohX2Qpwzxw==
X-CSE-MsgGUID: H2jlWaERT3KJGDiMafy/Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63180382"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:03:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 15:03:26 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 09/11] platform/x86:intel/pmc: Add Lunar Lake SSRAM
 devid
In-Reply-To: <20240828222932.1279508-10-xi.pardee@linux.intel.com>
Message-ID: <d2309960-af61-c49f-ab6a-3dd926581b40@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com> <20240828222932.1279508-10-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-650360988-1724933006=:1289"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-650360988-1724933006=:1289
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Aug 2024, Xi Pardee wrote:

> Enable SSRAM device Lunar Lake support by adding Lunar Lake SSRAM
> devid to Intel SSRAM Telemetry driver.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.h            | 3 +++
>  drivers/platform/x86/intel/pmc/ssram_telemetry.c | 1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index 2d62a71ec100..25974f9d329e 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -300,6 +300,9 @@ enum ppfear_regs {
>  #define PMC_DEVID_MTL_IOEP=090x7ecf
>  #define PMC_DEVID_MTL_IOEM=090x7ebf
> =20
> +/* LNL */
> +#define PMC_DEVID_LNL_SOCM=090xa87f
> +
>  extern const char *pmc_lpm_modes[];
> =20
>  struct pmc_bit_map {
> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/p=
latform/x86/intel/pmc/ssram_telemetry.c
> index 1c6cc95bfefa..025013b051c7 100644
> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> @@ -165,6 +165,7 @@ static int intel_pmc_ssram_telemetry_probe(struct pci=
_dev *pcidev, const struct
>  static const struct pci_device_id intel_pmc_ssram_telemetry_pci_ids[] =
=3D {
>  =09{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_MTL_SOCM) },
>  =09{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS) },
> +=09{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_LNL_SOCM) },
>  =09{ }
>  };
>  MODULE_DEVICE_TABLE(pci, intel_pmc_ssram_telemetry_pci_ids);
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-650360988-1724933006=:1289--

