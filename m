Return-Path: <linux-pm+bounces-15100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6E298EDAE
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 13:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5507A1F22D9F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8FB153828;
	Thu,  3 Oct 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNjMm1OM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595213C3C2;
	Thu,  3 Oct 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954095; cv=none; b=qnjfCZCXhRgyg6Fr39bvnaUFlIG0Uv68uQ6ehvLrHK786QV8J57JIBStu1Sv37zioJY02gSb2mUh8+RNttMvpY2cZ1o2hDnc+o0UXPDywihuf17EGpmZM6YPq6u7BZHst2k7LBHE/7X3hQqDPiawv2eATriJnPBs7h7JOf0KEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954095; c=relaxed/simple;
	bh=+kSGnXkoPKavIBGRDvSzfj5Pdagy64X694bm9u+MYDE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZIphHMti1J6+VGPCUuMf3DqDB2ayg3KC/iky4bYPfhTWAcwdfsdD1kepvAZB860our5SvMGAPcHOietpTCiGXxwdvOmMNUDAtPgWrBnwdd64ZvcBFGDn6c27OLsgGCBOhO1D+62cb85+M3OwasUW4AmNTZgafy+mu4WfEcg2nSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNjMm1OM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727954094; x=1759490094;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+kSGnXkoPKavIBGRDvSzfj5Pdagy64X694bm9u+MYDE=;
  b=dNjMm1OMVQrmEXvHb4rt6Dhn9MIddiVypSiM0Zcbrw5ZXCl1qCdEBIR3
   GwGTCtMGNsiyLBw6kavn5i0kxUVEE1YYvlKdifFbav7I1uVDpDJVmYh2z
   75z4mPaPj+8UhJ4oujZRqH7EzmWx/PQrdpSVv5309LpnoDWyN1Jp0I5Wi
   SYdm7nWAIBlCYJ7lYcWaA3dOGaBZdcnd8rr4iKii/Kt6RFMY7sWyDasyu
   s49SPiQlFgfELYMibqDD81ZYF97Qsa/o8xK2YM9hroIjuiV5Q0lm6rmrk
   0Un5brUdGeC+rmaPahRwEnwOYIPExDcnlZ/3Jz1/CpOYutGIciAwpMrkG
   A==;
X-CSE-ConnectionGUID: zniEK7WpRfGs7zDuIfL9nw==
X-CSE-MsgGUID: N0cUdwsbQR6lsTlPKGrh3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="49666184"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="49666184"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:14:54 -0700
X-CSE-ConnectionGUID: CqugsmqbTOiLE5nN7WrH0Q==
X-CSE-MsgGUID: /d/Pn8ncQRmMxWn5ljdUhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="78734014"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.198])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 04:14:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 3 Oct 2024 14:14:47 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, david.e.box@intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pm@vger.kernel.org, rjw@rjwysocki.net
Subject: Re: [PATCH] platform/x86/intel/pmc: Disable C1 auto-demotion during
 suspend
In-Reply-To: <f621da34-32a7-c56e-2c99-54a5f03c7e6f@linux.intel.com>
Message-ID: <856e2489-d92a-4203-feae-b4f41af8ed04@linux.intel.com>
References: <20241001225901.135564-1-david.e.box@linux.intel.com> <f621da34-32a7-c56e-2c99-54a5f03c7e6f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-992593729-1727954088=:970"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-992593729-1727954088=:970
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 2 Oct 2024, Ilpo J=E4rvinen wrote:

> On Tue, 1 Oct 2024, David E. Box wrote:
>=20
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

> > @@ -220,6 +237,15 @@ int cnl_resume(struct pmc_dev *pmcdev)
> >  {
> >  =09pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> > =20
> > +=09if (!pm_suspend_via_firmware()) {
> > +=09=09int cpunum;
> > +
> > +=09=09for_each_online_cpu(cpunum) {
> > +=09=09=09pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, per_cpu(p=
kg_cst_config, cpunum));
> > +=09=09=09wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg=
_cst_config, cpunum));
>=20
> Is the set of onlined CPUs iterated by the suspend and resume handlers=20
> guaranteed to be the same?

I asked about this from more knowledgeable people than me and got a=20
response that during suspend/resume userspace cannot offline any CPUs so=20
it should be guaranteed to remain the same for resume.

--=20
 i.

--8323328-992593729-1727954088=:970--

