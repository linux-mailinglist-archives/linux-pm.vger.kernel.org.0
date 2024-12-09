Return-Path: <linux-pm+bounces-18827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69AD9E9755
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 14:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEE1161D7A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C67233135;
	Mon,  9 Dec 2024 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEXG0QTk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F735941;
	Mon,  9 Dec 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751479; cv=none; b=nQJ7Q4WugzOZYvgInJnMRZGodzaKCZmcIsCCsdJcZmpOB7qtJSt1DC7Z4qsoBNHCM3lI+DjW68E2oM5vPeldibBQzA9uGszNN0/jawsG+3NWKzcMnbRTF8uHXr6D5J+ibN/xfeN0pU+KjdUfSwZlxTK2Mug0qypqMRYcOm0jXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751479; c=relaxed/simple;
	bh=wh2cRpDp/x5Re8AZy/zAw/ldLobDy/iV9CnKRs5U0qk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=msFIpxopqPY7d1DD4tWVNkKuenEYtpRzz8O2aNsqXvxsZ3Z+68MGNEzN1Hq6RB9cteaVCDhPj9XOZjIaPEc+Mv73yunAScC3KA1aClZ0izosOfTo5r358LjJPwHHZX8VehrNdjk82IzJJX9J0DXtfLf/6C0MCUs2uPr5Ap57miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEXG0QTk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733751478; x=1765287478;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wh2cRpDp/x5Re8AZy/zAw/ldLobDy/iV9CnKRs5U0qk=;
  b=hEXG0QTkjJb2eVlXKNFK7yGWPmBhAzQAhvwyKnF+uaMsLAU6Qh/T2kb9
   tNaiVRwzbUX/tCXac0y7m7dBWuRcggffx2HBkrLl+LBdUmjiWea+1teIH
   M+YKK4ikHmnHAanQbxWFfPMD/ORm1BYeJINg9sq0IFJNUjj9UeDE1IYfb
   Ir22+dFaXqqtK8kj7OfDuFYPZU5gvCS/Y5S9NgRuB4DHGy+aulk1lrvZ4
   jd8n8DXyPkIC4LOQLuLWovTSssxr8hFzTmBq9ZkrKIdSoMc0wUiCnXwCo
   //8Jc605HJoWcRZyO+hKqWOgfDkh6S6rMWY7jCi3NrG2Hf+rswPaZ+Uzb
   g==;
X-CSE-ConnectionGUID: 7tqPg4uuTe6pUkacQ/2SWw==
X-CSE-MsgGUID: Kc4N+JVATCKt1TksdhR4FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34192623"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34192623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:37:57 -0800
X-CSE-ConnectionGUID: +UlGSEflSwWNmxwHSutZ0w==
X-CSE-MsgGUID: jaqE9uXuSyiOHHDm6oFhUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="118312478"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.121])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:37:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Dec 2024 15:37:52 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/x86:intel/pmc: Make tgl_core_generic_init()
 static
In-Reply-To: <20241207053607.14806-2-xi.pardee@linux.intel.com>
Message-ID: <b78177bf-8bb6-885f-62b4-10b783ccd49f@linux.intel.com>
References: <20241207053607.14806-1-xi.pardee@linux.intel.com> <20241207053607.14806-2-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1432341798-1733751472=:938"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1432341798-1733751472=:938
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Dec 2024, Xi Pardee wrote:

> Make tgl_core_generic_init() a static function as the function has no
> callers outside of tgl.c. Remove the prototype in core.h and reorder
> the code in tgl.c.
>=20
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.h |  1 -
>  drivers/platform/x86/intel/pmc/tgl.c  | 22 +++++++++++-----------
>  2 files changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index b9d3291d0bf2c..a1886d8e1ef3e 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -597,7 +597,6 @@ int cnp_core_init(struct pmc_dev *pmcdev);
>  int icl_core_init(struct pmc_dev *pmcdev);
>  int tgl_core_init(struct pmc_dev *pmcdev);
>  int tgl_l_core_init(struct pmc_dev *pmcdev);
> -int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp);
>  int adl_core_init(struct pmc_dev *pmcdev);
>  int mtl_core_init(struct pmc_dev *pmcdev);
>  int arl_core_init(struct pmc_dev *pmcdev);
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/=
intel/pmc/tgl.c
> index e0580de180773..4fec43d212d01 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -285,17 +285,7 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_devic=
e *pdev)
>  =09ACPI_FREE(out_obj);
>  }
> =20
> -int tgl_l_core_init(struct pmc_dev *pmcdev)
> -{
> -=09return tgl_core_generic_init(pmcdev, PCH_LP);
> -}
> -
> -int tgl_core_init(struct pmc_dev *pmcdev)
> -{
> -=09return tgl_core_generic_init(pmcdev, PCH_H);
> -}
> -
> -int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
> +static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
>  {
>  =09struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
>  =09int ret;
> @@ -317,3 +307,13 @@ int tgl_core_generic_init(struct pmc_dev *pmcdev, in=
t pch_tp)
> =20
>  =09return 0;
>  }
> +
> +int tgl_l_core_init(struct pmc_dev *pmcdev)
> +{
> +=09return tgl_core_generic_init(pmcdev, PCH_LP);
> +}
> +
> +int tgl_core_init(struct pmc_dev *pmcdev)
> +{
> +=09return tgl_core_generic_init(pmcdev, PCH_H);
> +}
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1432341798-1733751472=:938--

