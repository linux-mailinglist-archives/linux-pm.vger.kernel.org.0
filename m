Return-Path: <linux-pm+bounces-28210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7FAD0962
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 23:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165AF7A4DED
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8422FE0E;
	Fri,  6 Jun 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTYc1iFO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D484039;
	Fri,  6 Jun 2025 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749244743; cv=none; b=PHvvX54bo5IQ5LUm0NW2cB+AMgxVYjHnjRsKR8US4ZwEKEepGxQQhpoLHzGaYCZHP2St1+5aoLoDaFpp9bhxXoBoalXYtzgKfHZ+8BmFeoSqIf/RZ7+ChUePea8zkMYcYFxGlxj8jkjaUn8Q1W0ADyvBMMSbpXmE5KDnO6V8acs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749244743; c=relaxed/simple;
	bh=hVazHZdWHt4jxCMZncRecOf9Qm+Sc+rUksZ9g0Z+26U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hw4obKYyB6Dl1NfSeofyQrc9KWxnjtmR3JEG2p/FcKKX935nb56TH33hBsyOl/SGcthd3b0pi4b38/PUDxI3PDR2FFUj23sTHjPxa+/ymUBQKGLm3CQaE6dYwDWwKEIt/kzLkFKnWkpCQQcDhJcQWilPR+5ROtAve8IPkvupvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTYc1iFO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749244742; x=1780780742;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hVazHZdWHt4jxCMZncRecOf9Qm+Sc+rUksZ9g0Z+26U=;
  b=nTYc1iFODbYmYGTllltuxulD6zIcVtufT4fI1Y7T2jFqzt/zumertlct
   y+5qiCNT/sLdh312Ty8fZokNplst9fjxhXeWNZ6IUtc+egpYtA+XLhUmj
   OU6qpNhuHExuyFA/OZOdKWpMfWxkslCeh2vaqWFff/obyZkhlu5g+9+v4
   LN6qRKFIC7Wdes/XlWBJjsGlc+u9xA5IeOsklIFlaazS0on7bEGTYK/J1
   teEEGppFxyNfzmdVGy+R9FAYxK7DvC/HkisFs3WH/GA/wLhAsfpGM+PPm
   x34/h/UUTERdIFoTx5Vix6Y5FcfdH8JNuAEAxy2CDEnmFFqhKrdIpPhY3
   g==;
X-CSE-ConnectionGUID: RK6ULsqTTuua6TVqKpm/kQ==
X-CSE-MsgGUID: 0DTBgi35Sv2qaBR/CVDC+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68846442"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="68846442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 14:19:01 -0700
X-CSE-ConnectionGUID: rrNVKOJiQYOt6a9MxwqOOA==
X-CSE-MsgGUID: 6bWTXIu0SiOlxIT0tYFB8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="151075622"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.222.223])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 14:19:00 -0700
Message-ID: <1c48e672c98c079b36ebe7ef8f2e313866c66972.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] thermal: intel: int340x: Allow temperature override
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>, "lukasz.luba@arm.com"
	 <lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>, 
 "daniel.lezcano@linaro.org"
	 <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 06 Jun 2025 14:19:00 -0700
In-Reply-To: <0fcd95bc6e9b300caa7d3029c9c43e9b5de6627e.camel@intel.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
		 <20250604203518.2330533-2-srinivas.pandruvada@linux.intel.com>
		 <545fae8be782943a92d9df1c4a3ff90b7a865c76.camel@intel.com>
		 <63d616ac8bb1dbac9eebf10953886a5ce3274940.camel@linux.intel.com>
	 <0fcd95bc6e9b300caa7d3029c9c43e9b5de6627e.camel@intel.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-06 at 07:22 +0000, Zhang, Rui wrote:
> On Thu, 2025-06-05 at 10:20 -0700, srinivas pandruvada wrote:
> > > > =C2=A0
> > > > =C2=A0int proc_thermal_ptc_add(struct pci_dev *pdev, struct
> > > > proc_thermal_device *proc_priv)
> > > > =C2=A0{
> > > > @@ -230,10 +289,13 @@ int proc_thermal_ptc_add(struct pci_dev
> > > > *pdev,
> > > > struct proc_thermal_device *proc_
> > > > =C2=A0
> > > > =C2=A0		for (i =3D 0; i < PTC_MAX_INSTANCES; i++) {
> > > > =C2=A0			ptc_instance[i].offset =3D
> > > > ptc_offsets[i];
> > > > +			ptc_instance[i].pdev =3D pdev;
> > > > =C2=A0			ptc_create_groups(pdev, i,
> > > > &ptc_instance[i]);
> > > > =C2=A0		}
> > > > =C2=A0	}
> > > > =C2=A0
> > > > +	ptc_create_debugfs();
> > > > +
> > >=20
> > > should we create the debugfs only when PROC_THERMAL_FEATURE_PTC
> > > is
> > > set?
> >=20
> > This function is only called when
> > =C2=A0if (feature_mask & PROC_THERMAL_FEATURE_PTC) {
> > }
> >=20
> >=20
> right, then the
> =C2=A0=C2=A0 if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_PTC)
> check in proc_thermal_ptc_add() is redundant.
Yes.

>=20
>=20
> BTW, in proc_thermal_mmio_add() and proc_thermal_mmio_remove(), we
>=20
> 1. call the rapl/ptc/rfim/wt_req/wt_hint .add() functions with the
> feature mask check in proc_thermal_mmio_add()
>=20
> 2. call the .remove() functions without the feature mask check in
> failure
> cases in proc_thermal_mmio_add().
The current functions in the upstream code are for:
	proc_thermal_rfim_remove(pdev);
This is already protected inside as it has to check each feature.

	proc_thermal_rapl_remove();

This is by virtue of rapl_mmio_priv.control_type is NULL on error, so
the above function will return.

proc_thermal_ptc_remove() is also protected by the flag. But you are
right for the debugfs part added with this patch, which should be
inside the flag check.


>=20
> 3. call the .remove() functions with feature mask check in
> proc_thermal_mmio_remove()
>=20
> This is inconsistent. If you agree, I'd like to propose a cleanup
> patch
> to make them work in a unified way.
You can make a cleanup patch to be consistent.

Thanks,
Srinivas



>=20
> thanks,
> rui

