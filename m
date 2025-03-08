Return-Path: <linux-pm+bounces-23686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB46A57D4E
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 19:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C274A3B434F
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299B1F5855;
	Sat,  8 Mar 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRYzsWPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EE1EB5C5;
	Sat,  8 Mar 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741459207; cv=none; b=XqrSFBsVqvQ9zaK09kK3J03BDZU54nl5sC+8yAZquH2TpQOchsXbo0PjoAivLbg/E8+TbYmv9OM8AAndSz1C9FBZ/gOZx5+x5YBJvgUxJ5jo+yqbOuXq49sOQdUy/ba20p0yOjxRxiklzTcYYh+vQoO9sbx6EPSOcfakUhmf7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741459207; c=relaxed/simple;
	bh=AeP9zcQrnv3yrFX198BR3DSSfFDFET1rz7YI3ou3jRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUiDae0dhHH+YDLD4pMYaTxH5ydwCK5NUEChrZdtkrBqVQEUgkWSfcD8JHEoHoXk6C6MEKP9qp00nH7g92lAVmqsc39OPAgzb7M4J+ZJohdDGHVfmlv6tdHB1IfVIACnEcTZdQ9anBrT6gRRnibtf2d0P9VPng8S2KKeD9rU30c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRYzsWPb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741459207; x=1772995207;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AeP9zcQrnv3yrFX198BR3DSSfFDFET1rz7YI3ou3jRs=;
  b=FRYzsWPbvSbDOK5AGESOWzqOAy8VaCuVRUnORylH9sJ220ZNjuObcmPW
   lMk8Dx5Mqku4SsVDwG87uYrsje32iDz/q+nST3yVBO1NfRspmQUmCARIY
   AnCzjpkHVYg9X0weY4k+PUt7yrVVI+FOeRBIvFle7Xwmt0gh/O4MN7zUe
   TyxELkEvNtXnIRrvtxjk5bJ+0prCdkuKcRpJhLjZ53Y4oqisPBe5/3YTB
   BAfZpygxXyKt9s02cVJM7xkNz5WfDvsF1FhVdH+MQF4hjinh41oAkW43d
   jQeyOtxdc8ehP0pQ3bqMx/G64wcwbXCvOUNu+e9M6KsLeEdWsa03fN3qc
   w==;
X-CSE-ConnectionGUID: wbV3GtXTTUuf4wk1GuAGPg==
X-CSE-MsgGUID: ssEN4dyaS8mrV97RT8sllg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="53475696"
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="53475696"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:40:06 -0800
X-CSE-ConnectionGUID: 1o+6TBW4RY29u5yBIjXZUQ==
X-CSE-MsgGUID: vVdWuiO5SNCVRnutjOfuYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,232,1736841600"; 
   d="scan'208";a="119343147"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.110.230])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 10:40:06 -0800
Message-ID: <5f70e7004b4e00d689703eb73175460b1dab9614.camel@linux.intel.com>
Subject: Re: [PATCH 0/3] Platform Temperature Control interface
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com, daniel.lezcano@linaro.org, rafael@kernel.org, 
	lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Sat, 08 Mar 2025 10:40:05 -0800
In-Reply-To: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
References: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
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
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-03-08 at 10:38 -0800, Srinivas Pandruvada wrote:
> Platform Temperature Control is a dynamic control loop implemented in
> hardware to manage the skin or any board temperature of a device. The
> reported skin or board temperature is controlled by comparing to a
> configured target temperature and adjusting the SoC (System on Chip)
> performance accordingly.
>=20
> This series supports optional controls from the user space.
>=20
Missed cc to linux-pm@vger.kernel.org to resent again.

Thanks,
Srinivas

> Srinivas Pandruvada (3):
> =C2=A0 thermal: intel: int340x: Add platform temperature control interfac=
e
> =C2=A0 thermal: intel: int340x: Enable platform temperature control
> =C2=A0 thermal: int340x: processor_thermal: Platform temperature control
> =C2=A0=C2=A0=C2=A0 documentation
>=20
> =C2=A0.../driver-api/thermal/intel_dptf.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 15 ++
> =C2=A0.../thermal/intel/int340x_thermal/Makefile=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0.../platform_temperature_control.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 181
> ++++++++++++++++++
> =C2=A0.../processor_thermal_device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +-
> =C2=A0.../processor_thermal_device.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0.../processor_thermal_device_pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> =C2=A06 files changed, 218 insertions(+), 3 deletions(-)
> =C2=A0create mode 100644
> drivers/thermal/intel/int340x_thermal/platform_temperature_control.c
>=20


