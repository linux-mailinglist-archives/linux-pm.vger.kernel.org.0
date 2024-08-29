Return-Path: <linux-pm+bounces-13150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644D964247
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBFE1C2130A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1728A18FDB3;
	Thu, 29 Aug 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceSLsW7A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E6E18F2F8;
	Thu, 29 Aug 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928771; cv=none; b=DsupZe3cxLftdqv0Xr1y/j0Twl92CniVedA4TkFCGOWPqsu2iDjueryANAuk018niNp62DY6xNrF5Heb+ETbYzu8by1u7fGlSiK4lM9RaininyZMUtWgw381LISWJfYyx3LVp5XcZijnN6CN2g1hdxn7ucbQEiAocOYqwAj4Y/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928771; c=relaxed/simple;
	bh=9e0EgEjghx+KCVxSZh0mW8KbQbXh3XSmX/PZhqp/HH0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fPBr3jVYMRMP1dQNLt/G9PUhLvnqVVsMUYiFG8gj/dyVNSg7vt1u0ezDPaij4PR54Jx9SnnbOdequimI6olBmbr41zGRj4AKm0vUG95nwES+pX9Qrv1npHC4fXDzDWOEtvolmftT1y8AKJA6vk0Ib4jU4zWmYRKfI07oNRVkz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceSLsW7A; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724928769; x=1756464769;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9e0EgEjghx+KCVxSZh0mW8KbQbXh3XSmX/PZhqp/HH0=;
  b=ceSLsW7ADFgagXYDiYkG7FH8cY0DlTRjEkeifXeGQXohOr9haXOkN0Kb
   jY5KfxhSAqfIUdaYsrh/T22uRT93H2UxbkSTwRA/JvYz03Ikx7gy53BKa
   CafghzgqntIfKfKAoGfL5XCgmGIu1eP4pJTDOC8rSyYZqz5IDhB0ocRvt
   LIUW0D4QGOKZibHdU8pX97MTPl/G4orNbC1zqxOfcLpdKt4Lp5nch1BbW
   Xtg+AJZkTvOXkzZ/pawBU4D1gC28d3ZRMJD6Rla6xLFLU0zE3EfbBKmYa
   5NYw7Hqig3U5fVBrmt9XskSBq6hhVIX9uPXCvQdf5X9pEV1OuC53ogNmG
   g==;
X-CSE-ConnectionGUID: vxQiMcUtQHiaTZZPb1Btag==
X-CSE-MsgGUID: aMFZXXM6SBqspo64wRgk5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34916543"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34916543"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 03:52:46 -0700
X-CSE-ConnectionGUID: 0tzgNbKxR3KzRSlf76YiOQ==
X-CSE-MsgGUID: PIU6N0GNRmK4w/D8a9Q4UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="67686165"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 03:52:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 13:52:35 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/11] platform/x86:intel/pmc: Move PMC devid to
 core.h
In-Reply-To: <20240828222932.1279508-4-xi.pardee@linux.intel.com>
Message-ID: <e7f3cb98-977e-b4fa-4631-9043873d6806@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com> <20240828222932.1279508-4-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-48011346-1724928755=:1289"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-48011346-1724928755=:1289
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Aug 2024, Xi Pardee wrote:

> Move PMC devid definition for each PMC of Arrow Lake and Meteor
> Lake platforms to core.h. This patch is a preparation step to
> introduce a new SSRAM Telemetry driver which will be using the
> PMC devid.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c  |  9 +++------
>  drivers/platform/x86/intel/pmc/core.h | 10 ++++++++++
>  drivers/platform/x86/intel/pmc/mtl.c  |  9 +++------
>  3 files changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/=
intel/pmc/arl.c
> index e10527c4e3e0..870da98ceb41 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -650,23 +650,20 @@ const struct pmc_reg_map arl_pchs_reg_map =3D {
>  =09.etr3_offset =3D ETR3_OFFSET,
>  };
> =20
> -#define PMC_DEVID_SOCS 0xae7f
> -#define PMC_DEVID_IOEP 0x7ecf
> -#define PMC_DEVID_PCHS 0x7f27
>  static struct pmc_info arl_pmc_info_list[] =3D {
>  =09{
>  =09=09.guid=09=3D IOEP_LPM_REQ_GUID,
> -=09=09.devid=09=3D PMC_DEVID_IOEP,
> +=09=09.devid=09=3D PMC_DEVID_MTL_IOEP,
>  =09=09.map=09=3D &mtl_ioep_reg_map,
>  =09},
>  =09{
>  =09=09.guid=09=3D SOCS_LPM_REQ_GUID,
> -=09=09.devid=09=3D PMC_DEVID_SOCS,
> +=09=09.devid=09=3D PMC_DEVID_ARL_SOCS,
>  =09=09.map=09=3D &arl_socs_reg_map,
>  =09},
>  =09{
>  =09=09.guid=09=3D PCHS_LPM_REQ_GUID,
> -=09=09.devid=09=3D PMC_DEVID_PCHS,
> +=09=09.devid=09=3D PMC_DEVID_ARL_PCHS,
>  =09=09.map=09=3D &arl_pchs_reg_map,
>  =09},
>  =09{}
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index 9a1cc01f31d9..6763e59180a4 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -290,6 +290,16 @@ enum ppfear_regs {
>  #define LNL_PPFEAR_NUM_ENTRIES=09=09=0912
>  #define LNL_S0IX_BLOCKER_OFFSET=09=09=090x2004
> =20
> +/* SSRAM PMC Device ID*/

Missing space.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> +/* ARL */
> +#define PMC_DEVID_ARL_SOCS=090xae7f
> +#define PMC_DEVID_ARL_PCHS=090x7f27
> +
> +/* MTL */
> +#define PMC_DEVID_MTL_SOCM=090x7e7f
> +#define PMC_DEVID_MTL_IOEP=090x7ecf
> +#define PMC_DEVID_MTL_IOEM=090x7ebf
> +
>  extern const char *pmc_lpm_modes[];
> =20
>  struct pmc_bit_map {
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/=
intel/pmc/mtl.c
> index c7d15d864039..908b5f8bb6e5 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -947,23 +947,20 @@ const struct pmc_reg_map mtl_ioem_reg_map =3D {
>  =09.lpm_reg_index =3D MTL_LPM_REG_INDEX,
>  };
> =20
> -#define PMC_DEVID_SOCM=090x7e7f
> -#define PMC_DEVID_IOEP=090x7ecf
> -#define PMC_DEVID_IOEM=090x7ebf
>  static struct pmc_info mtl_pmc_info_list[] =3D {
>  =09{
>  =09=09.guid=09=3D SOCP_LPM_REQ_GUID,
> -=09=09.devid=09=3D PMC_DEVID_SOCM,
> +=09=09.devid=09=3D PMC_DEVID_MTL_SOCM,
>  =09=09.map=09=3D &mtl_socm_reg_map,
>  =09},
>  =09{
>  =09=09.guid=09=3D IOEP_LPM_REQ_GUID,
> -=09=09.devid=09=3D PMC_DEVID_IOEP,
> +=09=09.devid=09=3D PMC_DEVID_MTL_IOEP,
>  =09=09.map=09=3D &mtl_ioep_reg_map,
>  =09},
>  =09{
>  =09=09.guid=09=3D IOEM_LPM_REQ_GUID,
> -=09=09.devid=09=3D PMC_DEVID_IOEM,
> +=09=09.devid=09=3D PMC_DEVID_MTL_IOEM,
>  =09=09.map=09=3D &mtl_ioem_reg_map
>  =09},
>  =09{}
>=20
--8323328-48011346-1724928755=:1289--

