Return-Path: <linux-pm+bounces-15041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914898CBAD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 05:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9101C21FCE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 03:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731714285;
	Wed,  2 Oct 2024 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7hqeUSL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4310A1F;
	Wed,  2 Oct 2024 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841083; cv=none; b=JGU0OhYFPQgoGbDQympWFwB2hwD4PAhPUH9XxLYRaMVQ7dWEG91QyHFp6awkEQTmxJxC3Odzj6j0iLiwi4WfwFPa8CCjeE+OHZkbeFZgCgfeMev8BBYZi+/Iz5RirvGsctsfstJx4zZyXJ6VOCDA2vXoQvUO7ImigTLvkkUp8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841083; c=relaxed/simple;
	bh=RDqxHX8PrONYcMMaJBTcc23hGfzdiYoekBhB7Nbi8Ts=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSnhsEkJsPGKVAE1b+kHxUwT0Ti1V9krvBK5pFfRPhmbE1YgbN3x4fBXeu7HcIvLhbkCvxdI9xnAdOBpjy7QogsbkwuP/KK5rJT7nqHxUMqhXZzWZbT4S1O4zxJwKVwfQ+4Fex23cm8Zumz+kIZUjEpggT9LlUCHUcr8TW7hOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7hqeUSL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727841082; x=1759377082;
  h=message-id:subject:from:reply-to:to:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RDqxHX8PrONYcMMaJBTcc23hGfzdiYoekBhB7Nbi8Ts=;
  b=b7hqeUSLV2tVwdQA3g/dffBg9mhxoxTrayLAhuEvRcSRBDkfPwogq2bg
   eieJ76NjdPN2iuok2IfWFs+V3FyODBvpP3e71tMZ8fL9xFSrL25SXV1tm
   2ctPOU1W/PQ80nJb3ZvzrhEIgYsUNZ2MjZoZWt2dpgVdyvXLdsaf8NV++
   5mn83vjLOM92WPm5vY+yOuLWbrlMelUlRLTVtdgnwP5K4qs62eGa0uvPS
   Yqr00FV/swgkcX44TUXFaC5emPjyCeckbrdx02+6sYe9axzXfMAIbj00h
   //lsEoo/Vr3Q8bjXdXe7Wi30tZCF3tf8PY22wqzNP9wffH2LC+vQPC01b
   g==;
X-CSE-ConnectionGUID: wa2TOJl2TbmBalsf8mZkmw==
X-CSE-MsgGUID: KstMFsteQHqtQy//vAriDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27133621"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="27133621"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 20:51:22 -0700
X-CSE-ConnectionGUID: JIhGbguMSVmv0PMxBbbZ3Q==
X-CSE-MsgGUID: H8yzb9WATZKBP7gkh4rORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="73998799"
Received: from iherna2-mobl4.amr.corp.intel.com ([10.125.109.6])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 20:51:21 -0700
Message-ID: <678862b3ff8417f85fb0490ed23c5e814687caa4.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/pmc: Disable C1 auto-demotion during
 suspend
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Mario Limonciello <mario.limonciello@amd.com>, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net
Date: Tue, 01 Oct 2024 20:51:20 -0700
In-Reply-To: <996d51a3-80c5-4a56-8e17-baa87efed5ac@amd.com>
References: <20241001225901.135564-1-david.e.box@linux.intel.com>
	 <996d51a3-80c5-4a56-8e17-baa87efed5ac@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-01 at 22:11 -0500, Mario Limonciello wrote:
> On 10/1/2024 17:58, David E. Box wrote:
> > On some platforms, aggressive C1 auto-demotion may lead to failure to e=
nter
> > the deepest C-state during suspend-to-idle, causing high power consumpt=
ion.
> > To prevent this, disable C1 auto-demotion during suspend and re-enable =
on
> > resume.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > =C2=A0 drivers/platform/x86/intel/pmc/arl.c |=C2=A0 3 +--
> > =C2=A0 drivers/platform/x86/intel/pmc/cnp.c | 28 ++++++++++++++++++++++=
+++++-
> > =C2=A0 drivers/platform/x86/intel/pmc/lnl.c |=C2=A0 3 +--
> > =C2=A0 drivers/platform/x86/intel/pmc/mtl.c |=C2=A0 3 +--
> > =C2=A0 4 files changed, 30 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/pmc/arl.c
> > b/drivers/platform/x86/intel/pmc/arl.c
> > index e10527c4e3e0..05dec4f5019f 100644
> > --- a/drivers/platform/x86/intel/pmc/arl.c
> > +++ b/drivers/platform/x86/intel/pmc/arl.c
> > @@ -687,9 +687,8 @@ static void arl_d3_fixup(void)
> > =C2=A0 static int arl_resume(struct pmc_dev *pmcdev)
> > =C2=A0 {
> > =C2=A0=C2=A0	arl_d3_fixup();
> > -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> > =C2=A0=20
> > -	return pmc_core_resume_common(pmcdev);
> > +	return cnl_resume(pmcdev);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 int arl_core_init(struct pmc_dev *pmcdev)
> > diff --git a/drivers/platform/x86/intel/pmc/cnp.c
> > b/drivers/platform/x86/intel/pmc/cnp.c
> > index 513c02670c5a..5b8b3ac7f061 100644
> > --- a/drivers/platform/x86/intel/pmc/cnp.c
> > +++ b/drivers/platform/x86/intel/pmc/cnp.c
> > @@ -7,7 +7,8 @@
> > =C2=A0=C2=A0 * All Rights Reserved.
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 */
> > -
> > +#define DEBUG
>=20
> Did you mean to pull this out before submitting?

Yep. Thanks.

>=20
> > +#include <linux/suspend.h>
> > =C2=A0 #include "core.h"
> > =C2=A0=20
> > =C2=A0 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> > @@ -206,8 +207,24 @@ const struct pmc_reg_map cnp_reg_map =3D {
> > =C2=A0=C2=A0	.etr3_offset =3D ETR3_OFFSET,
> > =C2=A0 };
> > =C2=A0=20
> > +
> > +static DEFINE_PER_CPU(u64, pkg_cst_config);
> > +
> > =C2=A0 void cnl_suspend(struct pmc_dev *pmcdev)
> > =C2=A0 {
> > +	if (!pm_suspend_via_firmware()) {
> > +		u64 val;
> > +		int cpunum;
> > +
> > +		for_each_online_cpu(cpunum) {
> > +			rdmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL,
> > &val);
> > +			per_cpu(pkg_cst_config, cpunum) =3D val;
> > +			val &=3D ~NHM_C1_AUTO_DEMOTE;
> > +			wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL,
> > val);
> > +			pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> > val);
> > +		}
> > +	}
> > +
> > =C2=A0=C2=A0	/*
> > =C2=A0=C2=A0	 * Due to a hardware limitation, the GBE LTR blocks PC10
> > =C2=A0=C2=A0	 * when a cable is attached. To unblock PC10 during suspen=
d,
> > @@ -220,6 +237,15 @@ int cnl_resume(struct pmc_dev *pmcdev)
> > =C2=A0 {
> > =C2=A0=C2=A0	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> > =C2=A0=20
> > +	if (!pm_suspend_via_firmware()) {
> > +		int cpunum;
> > +
> > +		for_each_online_cpu(cpunum) {
> > +			pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> > per_cpu(pkg_cst_config, cpunum));
> > +			wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL,
> > per_cpu(pkg_cst_config, cpunum));
> > +		}
> > +	}
> > +
> > =C2=A0=C2=A0	return pmc_core_resume_common(pmcdev);
> > =C2=A0 }
> > =C2=A0=20
> > diff --git a/drivers/platform/x86/intel/pmc/lnl.c
> > b/drivers/platform/x86/intel/pmc/lnl.c
> > index e7a8077d1a3e..be029f12cdf4 100644
> > --- a/drivers/platform/x86/intel/pmc/lnl.c
> > +++ b/drivers/platform/x86/intel/pmc/lnl.c
> > @@ -546,9 +546,8 @@ static void lnl_d3_fixup(void)
> > =C2=A0 static int lnl_resume(struct pmc_dev *pmcdev)
> > =C2=A0 {
> > =C2=A0=C2=A0	lnl_d3_fixup();
> > -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> > =C2=A0=20
> > -	return pmc_core_resume_common(pmcdev);
> > +	return cnl_resume(pmcdev);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 int lnl_core_init(struct pmc_dev *pmcdev)
> > diff --git a/drivers/platform/x86/intel/pmc/mtl.c
> > b/drivers/platform/x86/intel/pmc/mtl.c
> > index 91f2fa728f5c..fc6a89b8979f 100644
> > --- a/drivers/platform/x86/intel/pmc/mtl.c
> > +++ b/drivers/platform/x86/intel/pmc/mtl.c
> > @@ -988,9 +988,8 @@ static void mtl_d3_fixup(void)
> > =C2=A0 static int mtl_resume(struct pmc_dev *pmcdev)
> > =C2=A0 {
> > =C2=A0=C2=A0	mtl_d3_fixup();
> > -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> > =C2=A0=20
> > -	return pmc_core_resume_common(pmcdev);
> > +	return cnl_resume(pmcdev);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 int mtl_core_init(struct pmc_dev *pmcdev)
>=20


