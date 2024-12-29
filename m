Return-Path: <linux-pm+bounces-19826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968C9FDF9E
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13E916114A
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8EA17B401;
	Sun, 29 Dec 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrmCUG61"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A3AD23;
	Sun, 29 Dec 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735485829; cv=none; b=pjvC4xOpGBqWX2X9ZKZJ7kXZmCz3AWyILrSq3bAT5WZUYt1DWC5afSgZRyE15x7gpQneO060jKBa1hESpu+FT4kjfubOgMchExrt/yhVIXdfr8w3pyopS/qivpo1BUhNJNZIJrOtjeMUqcfy/+WREJE0LNtWKaH8d3Lvszoy05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735485829; c=relaxed/simple;
	bh=PuJekdX68TX7mA2SJ6up2wHPfgvi8OZ4Elzfk1Ke76o=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q6Sw1scx4haYmPZE4uzycrmqz3hY1EBIDJ7H+HhF/476JfmBG4Yoor9QtvuiGE+vCMsmMQTHDDEzcrIYvhT2y0jhIXO4Vk3f2BCU8z+YikUE8sB/eBgxm9KcaWlTICvmdGk04xnQzm07zhbkG3TEUMmJPA+ldb5CfqLrcuoMrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrmCUG61; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735485828; x=1767021828;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PuJekdX68TX7mA2SJ6up2wHPfgvi8OZ4Elzfk1Ke76o=;
  b=JrmCUG61bxNVzEWg78Typ/izVktt4+OtyH75QMeZ6H7m2zPai67nIC/T
   9Qxj/0gNiTO9VQOB8e5G3SZ6SBoNwB22mmDCYgnC+OcqWOeZACJ7G1cQu
   T6SqRiVFBtb0Adr8uIRiREzVz9ahRAULb2K0hEtC2BN7lf0VqRpr4Pr4g
   DCxmxaWnmWsL1Dr0NWF9NJZn25X1lwn+GeoXbB2jk80pQZW8ANTyk1cC+
   uWGibmyKx5o4K+txkJXZxZeHcVyiSyH9W7JOMBa7oCLhjd7AlrVLtSiyl
   z5ifInEvQMPDx9bjK87bBSpuJgk4CAkHrOGRu7wHjqJuyT/qNQEXd2qPT
   g==;
X-CSE-ConnectionGUID: cpZp+h3bRbugqdsksr57ow==
X-CSE-MsgGUID: L90Hs7AJQfq6Ys4QBwhwuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35508527"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="35508527"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 07:23:47 -0800
X-CSE-ConnectionGUID: CcuwxvBFQSO8n7iy6tTh1w==
X-CSE-MsgGUID: 8j4FFGCtQ0eM22xN2664/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137926102"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 07:23:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 29 Dec 2024 17:23:40 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
    david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] platform/x86:intel/pmc: Create generic_core_init()
 for all platforms
In-Reply-To: <0810bc98-ea48-4d30-bfb1-bd009ee485de@linux.intel.com>
Message-ID: <e3628ae8-317b-82e7-7545-38ba51dd4481@linux.intel.com>
References: <20241219235543.236592-1-xi.pardee@linux.intel.com> <20241219235543.236592-3-xi.pardee@linux.intel.com> <5f694390-079a-13e6-5c93-38b938125044@linux.intel.com> <0810bc98-ea48-4d30-bfb1-bd009ee485de@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1986260294-1735485820=:922"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1986260294-1735485820=:922
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 20 Dec 2024, Xi Pardee wrote:
> On 12/20/2024 3:52 AM, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 19 Dec 2024, Xi Pardee wrote:
> >=20
> > > Create a generic_core_init() function for all architecture to reduce
> > > duplicate code in each architecture file. Create an info structure
> > > to catch the variations between each architecture and pass it to the
> > > generic init function.
> > >=20
> > > Convert all architectures to call the generic core init function.
> > >=20
> > > Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> > This looks much better!
> >=20
> > > ---
> > >   drivers/platform/x86/intel/pmc/adl.c  | 21 ++++--------
> > >   drivers/platform/x86/intel/pmc/arl.c  | 47 ++++++++----------------=
---
> > >   drivers/platform/x86/intel/pmc/cnp.c  | 21 ++++--------
> > >   drivers/platform/x86/intel/pmc/core.c | 45 ++++++++++++++++++++++++=
+
> > >   drivers/platform/x86/intel/pmc/core.h | 25 ++++++++++++++
> > >   drivers/platform/x86/intel/pmc/icl.c  | 18 ++++------
> > >   drivers/platform/x86/intel/pmc/lnl.c  | 24 +++++---------
> > >   drivers/platform/x86/intel/pmc/mtl.c  | 45 +++++++-----------------=
-
> > >   drivers/platform/x86/intel/pmc/spt.c  | 18 ++++------
> > >   drivers/platform/x86/intel/pmc/tgl.c  | 31 +++++++++---------
> > >   10 files changed, 145 insertions(+), 150 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/pmc/adl.c
> > > b/drivers/platform/x86/intel/pmc/adl.c
> > > index e7878558fd909..ac37f4ece9c70 100644
> > > --- a/drivers/platform/x86/intel/pmc/adl.c
> > > +++ b/drivers/platform/x86/intel/pmc/adl.c

> > > diff --git a/drivers/platform/x86/intel/pmc/arl.c
> > > b/drivers/platform/x86/intel/pmc/arl.c
> > > index 05dec4f5019f3..137a1fdfee715 100644
> > > --- a/drivers/platform/x86/intel/pmc/arl.c
> > > +++ b/drivers/platform/x86/intel/pmc/arl.c
> > > @@ -691,40 +691,19 @@ static int arl_resume(struct pmc_dev *pmcdev)
> > >   =09return cnl_resume(pmcdev);
> > >   }
> > >   +static struct pmc_dev_info arl_pmc_dev =3D {
> > > +=09.func =3D 0,
> > > +=09.ssram =3D true,
> > > +=09.dmu_guid =3D ARL_PMT_DMU_GUID,
> > > +=09.regmap_list =3D arl_pmc_info_list,
> > > +=09.map =3D &arl_socs_reg_map,
> > > +=09.fixup =3D arl_d3_fixup,
> > I think the fixups should be left to be called from the per architectur=
e
> > init funcs.
>=20
> Will rename the fixup field to platform_specifc (more explanation at the =
end).

> > > diff --git a/drivers/platform/x86/intel/pmc/core.h
> > > b/drivers/platform/x86/intel/pmc/core.h
> > > index a1886d8e1ef3e..82be953db9463 100644
> > > --- a/drivers/platform/x86/intel/pmc/core.h
> > > +++ b/drivers/platform/x86/intel/pmc/core.h
> > > @@ -436,6 +436,30 @@ enum pmc_index {
> > >   =09PMC_IDX_MAX
> > >   };
> > >   +/**
> > > + * struct pmc_dev_info - Structure to keep pmc device info
> > > + * @func:=09=09Function number of the primary pmc
> > Capitalize "PMC" in the comments.
> Will change it.
> >=20
> > > + * @ssram:=09=09Bool shows if platform has ssram support
> > > + * @dmu_guid:=09=09DMU GUID
> > > + * @regmap_list:=09Pointer to a list of pmc_info structure that coul=
d be
> > > + *=09=09=09available for the platform
> > > + * @map:=09=09Pointer to a pmc_reg_map struct that contains platform
> > > + *=09=09=09specific attributes of the primary pmc
> > > + * @fixup:=09=09Function to perform platform specific fixup
> > > + * @suspend:=09=09Function to perform platform specific suspend
> > > + * @resume:=09=09Function to perform platform specific resume
> > > + */
> > > +struct pmc_dev_info {
> > > +=09u8 func;
> > > +=09bool ssram;
> > > +=09u32 dmu_guid;
> > > +=09struct pmc_info *regmap_list;
> > > +=09const struct pmc_reg_map *map;
> > > +=09void (*fixup)(void);
> > > +=09void (*suspend)(struct pmc_dev *pmcdev);
> > > +=09int (*resume)(struct pmc_dev *pmcdev);
> > > +};

> > > -=09return tgl_core_generic_init(pmcdev, PCH_H);
> > > +=09return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
> > >   }
> > >=20
> > It might be also worth to consider what is stored into those
> > X86_MATCH_VFM()s so that the simple init functions could be removed
> > entirely but it could be done in another patch on top of this one.
>
> Right now we store the init function pointer for each architecture in
> X86_MATCH_VFM()
> structure. We could change it to be a pointer to the pmc_dev_info structu=
re
> instead. Most
> of the per architecture init function call the generic_init function dire=
ctly
> except for TGL
> init function. The TGL case can be handled by adding a new callback funct=
ion
> pointer field named
> platform_specific and this field can also be used to replace the fixup fi=
eld.

To preserve generality, the function pointer should be a real replacement=
=20
of the generic init function (if non-NULL), not some platform specific=20
hook is called from one point of the generic init function.

If the init function is NULL, just call the generic init function=20
directly.

If not NULL, that per platform replacement function in can then do the=20
fixup like it currently does (and whatever extra is needed) and call the=20
generic init function.

--=20
 i.

--8323328-1986260294-1735485820=:922--

