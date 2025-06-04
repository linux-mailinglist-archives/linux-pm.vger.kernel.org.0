Return-Path: <linux-pm+bounces-28134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97822ACE636
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 23:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4402C7A7CB6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 21:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7B21421C;
	Wed,  4 Jun 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehC2BuyQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292351FC0FE;
	Wed,  4 Jun 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749073205; cv=none; b=Cd29wQrKilChEFoyXp0KSSWW2ZBq71msRKAChLdyQ9wiLBsELYR2idRz3jk/GGQesKz6KkxAUJeL1sSgcDmIDcEE+dG5Vv9a2aYIHiv9Yx5OqifLu8PD0hm/M4vR9Eb2wbjXrrytOvaDTkJ6/8sqDujGRtLaDFlmH5UFqcF1up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749073205; c=relaxed/simple;
	bh=YnxI2zZWfMQESoQGGqiVO4tFe0v0VC60qDivdYuSFLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHsKwxVruO4VnMYEU4SjIks0k+CmlwqwfcRYClhD8YRd/j9lW4IHA5HRYNn+KT+eE3NpBHdyLkgQVq/lDAjZaL6zGdyPuRR7bJvfEDfdPTnCiW0ycnHWCuHE9ZpseXRv7PUq0Xkmxba6HQn7DNGJ2O/RZkFghiq8SdFpbmIkpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehC2BuyQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749073203; x=1780609203;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YnxI2zZWfMQESoQGGqiVO4tFe0v0VC60qDivdYuSFLs=;
  b=ehC2BuyQ2hFAzATgvb5uawOcKhbnm+n5cB5F42/VETGdZwsdrdbxRaD/
   uL82HAqE3NJJEqV6IQpelbHv0OZNc76jQhDcGPwL3apAUoERlbowaCUvG
   7nx17SGzKjdXbLf9cgp+Jo86d9ds9IzJV4IPNUuMiipWpllD4ZH5DekgH
   W+oBiSqcpDiGc6w3HoHKNYsV9U86PNBdoxVYMS+0hJVT1mAnXniMeFDKi
   2dv+2UES9jw4i4Hcsp8uRhePHZLicPoKoyHxJR2+AblVfyPOcScX2hQTq
   cDE3Mb2dHrdrWw4B/E0+hVV6nDWYjggPzAdRCmTt/31cCtvgEcUEDQCrZ
   w==;
X-CSE-ConnectionGUID: T2P7GfUqRPWy1Fyh/1LT7g==
X-CSE-MsgGUID: 3zJpZAN2S8a39fLjvtHXHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62532603"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="62532603"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 14:40:02 -0700
X-CSE-ConnectionGUID: uvXubLf5RT22eAXK8bjhJA==
X-CSE-MsgGUID: c7hzUrA4QUOJTfDe58sVFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="145649682"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.221.157])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 14:40:02 -0700
Message-ID: <9cbc3ee82561859acbd6f4787c82f453f8a7afeb.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] thermal: intel: int340x: Add performance control
 for platform temperature control
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date: Wed, 04 Jun 2025 14:40:01 -0700
In-Reply-To: <CAJZ5v0hgK+B1j6=M+Sx1+jC4d1n3GZfcpLtZJ_j58xdMXweTPA@mail.gmail.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0hgK+B1j6=M+Sx1+jC4d1n3GZfcpLtZJ_j58xdMXweTPA@mail.gmail.com>
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

On Wed, 2025-06-04 at 22:55 +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 4, 2025 at 10:35=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Add additional attribute to control performance of platform
> > temperature
> > control feature. Two attributes are added:
>=20
> It would be good to explain why they are needed.

This is to give user space some influence in the aggressiveness of
control loops in the firmware. Firmware may be aggressive but  there
can be some tolerance based on current conditions like ambient
temperature or whether the laptop is placed not on lap. Similar to
current adaptive thermal controls changing temperature limits and power
limits, with the PTC these controls can be used.

>=20
> > gain: 0-7 levels, with 0 being most aggressive.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 =E2=80=93 graceful, favors=
 performance at the expense of
> > temperature
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 overshoots
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 =E2=80=93 aggressive, favo=
rs tight regulation over performance
> >=20
> > min_performance_level: A value from 0-255. Specifies minimum
> > Performance
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 level below which the there =
will be no throttling.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 - all levels of throttling=
 allowed including
> > survivability
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 actions.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 255 - no throttling allowed.
>=20
> The description of min_performance_level above doesn't seem to be
> consistent to me.=C2=A0 Specifically, the descriptions of the 0 and 255
> values appear to indicate that this really is about what kind of
> throttling can be applied.

At the end this is some power/frequency throttling to various sub
systems. 0 means that to meet temperature threshold, the power can be
lower than the lowest package power limit which is survivability mode.

>=20
> Also, I gather that the units of this number are arbitrary and it is
> not tied to anything specific.=C2=A0 I mean, 127 doesn't mean 50% of CPU
> performance, for instance.
It is unit-less. It may not scale linearly to assume any value to
percent.

Thanks,
Srinivas

>=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0Documentation/driver-api/thermal/intel_dptf.rst=C2=A0=C2=A0 | 10 =
++++++++++
> > =C2=A0.../platform_temperature_control.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15
> > ++++++++++++++-
> > =C2=A02 files changed, 24 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/driver-api/thermal/intel_dptf.rst
> > b/Documentation/driver-api/thermal/intel_dptf.rst
> > index ec5769accae0..794f5cce548e 100644
> > --- a/Documentation/driver-api/thermal/intel_dptf.rst
> > +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> > @@ -206,6 +206,16 @@ All these controls needs admin privilege to
> > update.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Update a new temperature tar=
get in milli degree celsius for
> > hardware to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use for the temperature cont=
rol.
> >=20
> > +``gain`` (RW)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A value in the range 0-7. Sets th=
e aggressiveness of
> > control loop.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 =E2=80=93 graceful, favors perf=
ormance at the expense of
> > temperature overshoots.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 =E2=80=93 aggressive, favors ti=
ght regulation over performance.
> > +
> > +``min_performance_level`` (RW)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Minimum Performance level below w=
hich the there will be no
> > throttling.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 - all levels of throttling allo=
wed including
> > survivability actions.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 256 - no throttling allowed.
> > +
> > =C2=A0Given that this is platform temperature control, it is expected
> > that a
> > =C2=A0single user-level manager owns and manages the controls. If
> > multiple
> > =C2=A0user-level software applications attempt to write different
> > targets, it
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.c
> > b/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.c
> > index 2d6504514893..6cd05783a52d 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.c
> > @@ -49,7 +49,7 @@ struct mmio_reg {
> > =C2=A0};
> >=20
> > =C2=A0#define MAX_ATTR_GROUP_NAME_LEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 32
> > -#define PTC_MAX_ATTRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 3
> > +#define PTC_MAX_ATTRS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 5
> >=20
> > =C2=A0struct ptc_data {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 offset;
> > @@ -57,6 +57,8 @@ struct ptc_data {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct attribute *ptc_attrs[=
PTC_MAX_ATTRS];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute temp=
erature_target_attr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute enab=
le_attr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute gain_attr=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute min_perfo=
rmance_level_attr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char group_name[MAX_ATTR_GRO=
UP_NAME_LEN];
> > =C2=A0};
> >=20
> > @@ -78,6 +80,8 @@ static u32 ptc_offsets[PTC_MAX_INSTANCES] =3D
> > {0x5B20, 0x5B28, 0x5B30};
> > =C2=A0static const char * const ptc_strings[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "temperature_target",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "enable",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "gain",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "min_performance_level",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
> > =C2=A0};
> >=20
> > @@ -177,6 +181,11 @@ PTC_SHOW(temperature_target);
> > =C2=A0PTC_STORE(temperature_target);
> > =C2=A0PTC_SHOW(enable);
> > =C2=A0PTC_STORE(enable);
> > +PTC_SHOW(gain);
> > +PTC_STORE(gain);
> > +PTC_SHOW(min_performance_level);
> > +PTC_STORE(min_performance_level);
> > +
> >=20
> > =C2=A0#define ptc_init_attribute(_name)\
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {\
> > @@ -193,9 +202,13 @@ static int ptc_create_groups(struct pci_dev
> > *pdev, int instance, struct ptc_data
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptc_init_attribute(temperatu=
re_target);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptc_init_attribute(enable);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptc_init_attribute(gain);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptc_init_attribute(min_performanc=
e_level);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ptc_attrs[index++] =3D=
 &data-
> > >temperature_target_attr.attr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ptc_attrs[index++] =3D=
 &data->enable_attr.attr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ptc_attrs[index++] =3D &dat=
a->gain_attr.attr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ptc_attrs[index++] =3D &dat=
a-
> > >min_performance_level_attr.attr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ptc_attrs[index] =3D N=
ULL;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(data->group_name, M=
AX_ATTR_GROUP_NAME_LEN,
> > --
> > 2.49.0
> >=20

