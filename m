Return-Path: <linux-pm+bounces-13152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5E964283
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 13:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D346FB21C14
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 11:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425E19066B;
	Thu, 29 Aug 2024 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJRUA0Lj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777418C93E;
	Thu, 29 Aug 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929348; cv=none; b=Bj/3bFtTawPlLfONxzPiBMfaMN42+Mr5zk1freX0x3fOCgo+ZnKZITWZ9RaL8KhLVQHyio77IJjv/wkfQYULtgV1I57CLmHL0BZ1hX/60TwjRgdvfA3jvrdaW41Tf+klGAMfAqngKNdcNB4z3gsnvUyfDO7MPdJ5mbABCEfulM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929348; c=relaxed/simple;
	bh=W0z2/bWZRJUf1adVeJGT+JY63YbhpGAWpXa3+iV2Wco=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UcTMrpFtdAMncsbWPEd1kRAze+6TvsGwDAl/6Eny9USxs/4jJaKA15BOhc9gh3AN5kuFQEo86ZdDMxDnavQuWXK7gLZ8Cmgbe2ji6DlfL3hfbaCn0aE3E0QwnYYJS+80NWNOlrvh6blHpXUwXzPs1tDdPnhXyAiSKVw4mryiPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJRUA0Lj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724929347; x=1756465347;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W0z2/bWZRJUf1adVeJGT+JY63YbhpGAWpXa3+iV2Wco=;
  b=LJRUA0LjPLbrhnQD+djOgOStQQI/t89bfB0F9sUb1GKq7L7s7dCM76cw
   f4bVYzPI01bhm3nPiSNEFtoSKEAf+zBUhOTraWf8xxeH6+kphpWi7vhla
   m2yjiEZo3gQAlzyPdWzE9ojojhJKjkCk9rJ0ubfyXlLQqEvB3rWCsRwsU
   qj9tg/BH3/00Vr41zkyEeET27k+FiX9XlbiwTInTgeX2bEpNHeq0W0uH6
   o3kLxA+/RDb/FvonD38aK2QdDQULdVC2nSiuQ4HIMO7FTH5gKVgfRfb+R
   TwgrlQWVtmdyItX40EIsf2J3+axhGRNgja0VNDEuaSf9q6nW6D7C5/zuw
   A==;
X-CSE-ConnectionGUID: 32vfMSoHRzu9k0seGN2uHw==
X-CSE-MsgGUID: Bn+/zanjRy+d3Ipn60qvaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34081915"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34081915"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:02:26 -0700
X-CSE-ConnectionGUID: 6ZdcXHwkQ46u4hh0RRUjBA==
X-CSE-MsgGUID: 5PLjQjJ4RaSMM5BCn5pbfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68208348"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:02:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 14:02:19 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 05/11] platform/x86:intel/pmc: Remove unneeded h file
 inclusion
In-Reply-To: <20240828222932.1279508-6-xi.pardee@linux.intel.com>
Message-ID: <8bda80eb-c0b8-c9c7-5c18-bb06701a69cb@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com> <20240828222932.1279508-6-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2113534642-1724929339=:1289"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2113534642-1724929339=:1289
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Aug 2024, Xi Pardee wrote:

In the subject:

h file -> header

> telemetry.h header file is not needed in arl.c or mtl.c. Remove
> them to avoid confusion.

I'd also note this is cross directory/driver include, so perhaps something=
=20
along these lines:

telemetry.h from PMT is not needed in arl.c or mtl.c so remove
the cross-driver include.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c | 1 -
>  drivers/platform/x86/intel/pmc/mtl.c | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/=
intel/pmc/arl.c
> index 870da98ceb41..0460715c58f4 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -10,7 +10,6 @@
> =20
>  #include <linux/pci.h>
>  #include "core.h"
> -#include "../pmt/telemetry.h"
> =20
>  /* PMC SSRAM PMT Telemetry GUID */
>  #define IOEP_LPM_REQ_GUID=090x5077612
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/=
intel/pmc/mtl.c
> index 908b5f8bb6e5..e7f5b650902d 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -10,7 +10,6 @@
> =20
>  #include <linux/pci.h>
>  #include "core.h"
> -#include "../pmt/telemetry.h"
> =20
>  /* PMC SSRAM PMT Telemetry GUIDS */
>  #define SOCP_LPM_REQ_GUID=090x2625030
>=20

--8323328-2113534642-1724929339=:1289--

