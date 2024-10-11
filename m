Return-Path: <linux-pm+bounces-15530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0643C999B44
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 05:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730B41F239C3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 03:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44371C9B60;
	Fri, 11 Oct 2024 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="An+xQQ48"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3863D;
	Fri, 11 Oct 2024 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618609; cv=none; b=HfehvnQSXzdEvFtGxDfxnhNbYr/6uhZ8uz6ZiI2Uwrm3+iZ5Zb3ozHEBw/Zx1XLVs10L7NJ/9JM+HQfHZt6JV2gV8fnHCx0VrVhL8u00pTqR91yShE7J2P/TVYJO5pfO3gwgRGtXdF4eNA82xkEoxixRZakOdo/xiRZGJG/9edE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618609; c=relaxed/simple;
	bh=8u6AC/iyGTJ5VGfZXeiEazhAzoeC1NovR7kibpmhlus=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0wqnJuxlQs9PjBGXEYZHBQFI4oF8lmaF9wOCyKW0vy6VPcRO1hlWRLHsGin4hN/qSXKHMEmBre6fIjXGU9KuCO3AzxoQx8pWrhBldlx3MHil5lzgMMUL/QYjiVXvejHB4/lNzNz1eYsFj1jFZiHGsHampahrD7/lZZKiq0Sncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=An+xQQ48; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728618608; x=1760154608;
  h=message-id:subject:from:reply-to:to:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8u6AC/iyGTJ5VGfZXeiEazhAzoeC1NovR7kibpmhlus=;
  b=An+xQQ48q3JHJlQVWFFlAOX/fN+paJ73Sw/DwFmljIn4KdyWku0UKITq
   bmfjqH/geXbEqDaJ5/hH104P3rri4UeitjIj7oAQVXCARFzIshlTtNrHp
   ABJmBdm29G0BJm57xNSCF1NbZghthQaoKn++Zd6EQjCgnc8kzyvML2XXR
   n89tv5c95aFOiYkOHxP09skCjVtcWjtmHmwQgyKursIM0WOSiHMbvZhLe
   neXF5gW5uykoDEKHFYVs1NvVwgABtVqDmoRaY/3gqT0F2Uf6vdyB1kPV7
   xQOrEWL4zmTSD4uX0ROeQXgcWmmt9+uJbc3DF/6A8azQ2t9fs/2PjLqFB
   w==;
X-CSE-ConnectionGUID: 2qe0NwxGTHSyx5u8HMdwFA==
X-CSE-MsgGUID: 3UgEO7sHRoSWR+T01rZChA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31707572"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="31707572"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 20:50:08 -0700
X-CSE-ConnectionGUID: 4XMye2RGRoyduzG03AMOtA==
X-CSE-MsgGUID: 5y+isoFJS8SNGAgr3BpcWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76792177"
Received: from cmdeoliv-mobl.amr.corp.intel.com ([10.125.111.90])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 20:50:06 -0700
Message-ID: <c9410dd42e01c1ba26fbb43f97a8777f1c95b9af.camel@linux.intel.com>
Subject: Re: [PATCH V2 2/2] platform/x86/intel/pmc: Disable C1 auto-demotion
 during suspend
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, rjw@rjwysocki.net, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Thu, 10 Oct 2024 20:50:05 -0700
In-Reply-To: <c4513e7857b15ec9146a7b75d00e99987787ced4.camel@linux.intel.com>
References: <20241011003640.1613812-1-david.e.box@linux.intel.com>
	 <20241011003640.1613812-2-david.e.box@linux.intel.com>
	 <c4513e7857b15ec9146a7b75d00e99987787ced4.camel@linux.intel.com>
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

On Thu, 2024-10-10 at 19:09 -0700, srinivas pandruvada wrote:
> On Thu, 2024-10-10 at 17:36 -0700, David E. Box wrote:
> > On some platforms, aggressive C1 auto-demotion may lead to failure to
> > enter
> > the deepest C-state during suspend-to-idle, causing high power
> > consumption.
> > To prevent this, disable C1 auto-demotion during suspend and re-
> > enable on
> > resume.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >=20
> > V2 - Remove #define DEBUG
> > =C2=A0=C2=A0 - Move refactor of cnl_resume() to separate patch
> > =C2=A0=C2=A0 - Use smp_call_function() to disable and restore C1_AUTO_D=
EMOTE
> > =C2=A0=C2=A0 - Add comment that the MSR is per core, not per package.
> > =C2=A0=C2=A0 - Add comment that the online cpu mask remains unchanged d=
uring
> > =C2=A0=C2=A0=C2=A0=C2=A0 suspend due to frozen userspace.
> >=20
> > =C2=A0drivers/platform/x86/intel/pmc/cnp.c | 53
> > ++++++++++++++++++++++++++++
> > =C2=A01 file changed, 53 insertions(+)
> >=20
> > diff --git a/drivers/platform/x86/intel/pmc/cnp.c
> > b/drivers/platform/x86/intel/pmc/cnp.c
> > index 513c02670c5a..f12d4f0f9e93 100644
> > --- a/drivers/platform/x86/intel/pmc/cnp.c
> > +++ b/drivers/platform/x86/intel/pmc/cnp.c
> > @@ -8,6 +8,8 @@
> > =C2=A0 *
> > =C2=A0 */
> > =C2=A0
> > +#include <linux/smp.h>
> > +#include <linux/suspend.h>
> > =C2=A0#include "core.h"
> > =C2=A0
> > =C2=A0/* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> > @@ -206,8 +208,52 @@ const struct pmc_reg_map cnp_reg_map =3D {
> > =C2=A0	.etr3_offset =3D ETR3_OFFSET,
> > =C2=A0};
> > =C2=A0
> > +
> > +/*
> > + * Disable C1 auto-demotion
> > + *
> > + * Aggressive C1 auto-demotion may lead to failure to enter the
> > deepest C-state
> > + * during suspend-to-idle, causing high power consumption. To
> > prevent this, we
> > + * disable C1 auto-demotion during suspend and re-enable on resume.
> > + *
> > + * Note that, although MSR_PKG_CST_CONFIG_CONTROL has 'package' in
> > its name, it
> > + * is actually a per-core MSR on client platforms, affecting only a
> > single CPU.
> > + * Therefore, it must be configured on all online CPUs. The online
> > cpu mask is
> > + * unchanged during the phase of suspend/resume as user space is
> > frozen.
> > + */
> > +
> > +static DEFINE_PER_CPU(u64, pkg_cst_config);
> > +
> > +static void disable_c1_auto_demote(void *unused)
> > +{
> > +	int cpunum =3D smp_processor_id();
> > +	u64 val;
> > +
> > +	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> > +	per_cpu(pkg_cst_config, cpunum) =3D val;
> > +	val &=3D ~NHM_C1_AUTO_DEMOTE;
> > +	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, val);
> > +	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
> Do you want to leave pr_debug?

Thought it could be useful but it can be removed.

>=20
> > +}
> > +
> > +static void restore_c1_auto_demote(void *unused)
> > +{
> > +	int cpunum =3D smp_processor_id();
> > +
> > +	pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum,
> > +		 per_cpu(pkg_cst_config, cpunum));
> > +	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config,
> > cpunum));
> > +}
> > +
> > =C2=A0void cnl_suspend(struct pmc_dev *pmcdev)
> > =C2=A0{
> > +	if (!pm_suspend_via_firmware()) {
> > +		preempt_disable();
> Why do you need this?

To ensure that the cpu doesn't change between the next two calls.

David

>=20
>=20
> Thanks,
> Srinivas
>=20
> > +		disable_c1_auto_demote(NULL);
> > +		smp_call_function(disable_c1_auto_demote, NULL, 0);
> > +		preempt_enable();
> > +	}
> > +
> > =C2=A0	/*
> > =C2=A0	 * Due to a hardware limitation, the GBE LTR blocks PC10
> > =C2=A0	 * when a cable is attached. To unblock PC10 during suspend,
> > @@ -218,6 +264,13 @@ void cnl_suspend(struct pmc_dev *pmcdev)
> > =C2=A0
> > =C2=A0int cnl_resume(struct pmc_dev *pmcdev)
> > =C2=A0{
> > +	if (!pm_suspend_via_firmware()) {
> > +		preempt_disable();
> > +		restore_c1_auto_demote(NULL);
> > +		smp_call_function(restore_c1_auto_demote, NULL, 0);
> > +		preempt_enable();
> > +	}
> > +
> > =C2=A0	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> > =C2=A0
> > =C2=A0	return pmc_core_resume_common(pmcdev);
>=20


