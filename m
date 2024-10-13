Return-Path: <linux-pm+bounces-15580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E33099B7D0
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2024 02:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE2CB21D53
	for <lists+linux-pm@lfdr.de>; Sun, 13 Oct 2024 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2017FE;
	Sun, 13 Oct 2024 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNVYLfmx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC961EC2;
	Sun, 13 Oct 2024 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728780017; cv=none; b=B2WA6tcmuMGx20tmUnBcWroqgO/3VFWg3AfOj0M1iOpJaJPQsIpxPU7slmj8cWnTBiSop6jekjv8J07LPHKaDDg5l5v4KmSTynQ+h2MOvG2+YUhjw28viyvsh7uUAhpLAGNKZ8mS09lNCuCJpwdHEefqkFuC/mPqE4sB9X/3kKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728780017; c=relaxed/simple;
	bh=EdDY7m4DSdswW+hjUfbZCCBQaNAxJNHZsjvDGFbAhfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cHuOviYnZH6AJ0bjSASLMCJDcj+h2FQoMESSQ+x1Ts/lNZ6Cdsw94tukl1/YKFVr28/JhcrzUHxXRvrp1Y/i9ynWYr2L3FoDcSzlBIWwYCpV0AeJwuVUxmY9rDEpxX4V8MdHzB2jUXwcUDmyOOcZGqv02tfsPjepME/UZZNVTDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNVYLfmx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728780016; x=1760316016;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EdDY7m4DSdswW+hjUfbZCCBQaNAxJNHZsjvDGFbAhfQ=;
  b=bNVYLfmxJQzjhp3lELjLqOlkcwbt9kGPHOasG7sgcRHua1vhu94RbLcI
   lK7ApBKXt91BkZpG0APn8smaqvAkyNiTaYi6W4ns/jsQb7D9Q9Fh0/LW2
   MDCfOER+9RaL6zqsc5ZNmualBtVbRFJzWOM7QMJX1L0qy/kKjtl/s5OE3
   aD2y/V74vYPwFrgZK4eCjbAHZavRmAoFIYIjnTGyxIcnmBlh+p4H4mk50
   5wU2ACNu4214S+WZiEioSoYwtwn2U+Gx7htOvWQ8XbBNnHTZc6k+V+ukF
   ym0V7WckMkgqDSioIGNRUJv4t1p6cPTl7Rnf7CALUhRD9YX/11MOwND9R
   Q==;
X-CSE-ConnectionGUID: jdL12EFlRK2YvEUFzLbM7A==
X-CSE-MsgGUID: 2fw2EvjQQvqEqV7FrtfHDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31032851"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31032851"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 17:40:14 -0700
X-CSE-ConnectionGUID: GmzJtsU7RcC5+XsB/hf7Ew==
X-CSE-MsgGUID: nDCzEvJTSg6scgpDQcja+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="81865735"
Received: from bjrankin-mobl3.amr.corp.intel.com ([10.124.220.147])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 17:40:13 -0700
Message-ID: <ab13c87c800fe03d5045ae3fb7442a7f050be9ba.camel@linux.intel.com>
Subject: Re: [PATCH V2 2/2] platform/x86/intel/pmc: Disable C1 auto-demotion
 during suspend
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, rjw@rjwysocki.net, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Cc: ricardo.neri-calderon@linux.intel.com
Date: Sat, 12 Oct 2024 17:40:11 -0700
In-Reply-To: <20241011003640.1613812-2-david.e.box@linux.intel.com>
References: <20241011003640.1613812-1-david.e.box@linux.intel.com>
	 <20241011003640.1613812-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

+Ricardo

On Thu, 2024-10-10 at 17:36 -0700, David E. Box wrote:
> On some platforms, aggressive C1 auto-demotion may lead to failure to
> enter
> the deepest C-state during suspend-to-idle, causing high power
> consumption.
> To prevent this, disable C1 auto-demotion during suspend and re-
> enable on
> resume.
>=20
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>=20

[...]


> =C2=A0void cnl_suspend(struct pmc_dev *pmcdev)
> =C2=A0{
> +	if (!pm_suspend_via_firmware()) {
> +		preempt_disable();
> +		disable_c1_auto_demote(NULL);
> +		smp_call_function(disable_c1_auto_demote, NULL, 0);
> +		preempt_enable();
> +	}
>=20
As suggested by Ricardo using the following will work avoiding separate
local CPU call. Preemption will be disabled, no need separate call.
Also cpu_online_mask can't be changed during these callbacks.

if (!pm_suspend_via_firmware())
	on_each_cpu(disable_c1_auto_demote, NULL, true);

I think you need wait=3Dtrue. I have seen on some occasions you will miss
msr write as we called mwait before before async calls finished.=20


Thanks,
Srinivas

> +
> =C2=A0	/*
> =C2=A0	 * Due to a hardware limitation, the GBE LTR blocks PC10
> =C2=A0	 * when a cable is attached. To unblock PC10 during suspend,
> @@ -218,6 +264,13 @@ void cnl_suspend(struct pmc_dev *pmcdev)
> =C2=A0
> =C2=A0int cnl_resume(struct pmc_dev *pmcdev)
> =C2=A0{
> +	if (!pm_suspend_via_firmware()) {
> +		preempt_disable();
> +		restore_c1_auto_demote(NULL);
> +		smp_call_function(restore_c1_auto_demote, NULL, 0);
> +		preempt_enable();
> +	}
> +
> =C2=A0	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
> =C2=A0
> =C2=A0	return pmc_core_resume_common(pmcdev);


