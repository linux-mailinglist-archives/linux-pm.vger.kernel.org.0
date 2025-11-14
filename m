Return-Path: <linux-pm+bounces-38075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C180C5EDF2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 19:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FCA3A23EA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1B027E066;
	Fri, 14 Nov 2025 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiA6dr/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178329C327;
	Fri, 14 Nov 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145168; cv=none; b=dQcl4vnDG0oKnupWifsVb1QEG2BV0KTO5I1DowcxzZxALd9gr1KYSk1uzVmdDkjA2VJwUFI2xeLo5g5jcfFaqG40SHLbLJNjYoMNNZPcselCzoL7DVwNBRTHvlgHmiCLrBXR9dcp3F4oyRRgZaNHNhi7U/l6E4yaY8op63ITG9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145168; c=relaxed/simple;
	bh=Wf4h6pFsP6mFAf6Cy1RKCuZ8Gr9fv62cI/lhg3hso1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+MQxvJgY5K+i1HZ2lDgMfRv3TokaVzdSXYROIN4gMYcLXMgNYSJkBEgE/Q4P9s4R0wmvEXgrbl3oHwGLXyWuF96kokE+GGAzSy4fTY1KxCbN1l98khzYLwfZ+8vHZNxl7rb49k1eSSs46tcs4ZbTRLzCIRfxC4xNSCxoqHc7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiA6dr/J; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763145167; x=1794681167;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Wf4h6pFsP6mFAf6Cy1RKCuZ8Gr9fv62cI/lhg3hso1U=;
  b=hiA6dr/JZ0KEq+Y7dUEZx0oXp4GZfyxQvLR6UDf4JvKrFFxcHVugv5QP
   YVl2LE5dFsMyukSlSpJoG7lS7+1/4ZJjpQHe6chmU5zFSFs1mYka1Y3Vm
   bwO9TUgxMw8CM/7x97+A6RmnweCTRlTgA0nbo/xhHOL/ZuqoIrD2RM47j
   yDcTlOoOtBAa+7+ZwHTw00NWEoWNug/gY4tIDl9+psvbr8alTYH/J8vbt
   TGG8V3eURvFtYzwfJ72bkREhZLCWN9hQpS/PJZWOD1NsaPeKGeJ/W9DP3
   ZYul+2MB2qHrwtZqv5NUA6y5t57QpssGRIVubHckG524KTXeREsl6tWnu
   w==;
X-CSE-ConnectionGUID: zVhbHbSmSp+lgMMX2vJiwg==
X-CSE-MsgGUID: Nacohq6YRpywHlCxo58a8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="69093867"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="69093867"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 10:32:46 -0800
X-CSE-ConnectionGUID: WnIXzOTISZ6Rh+Dw3n8biQ==
X-CSE-MsgGUID: PGUXWTbQR0uvojLbm8zCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="190099591"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 10:32:45 -0800
Message-ID: <af62f3301bea0b7c17c777002bc2e63ba705dd30.camel@linux.intel.com>
Subject: Re: [PATCH v2] Documentation: thermal: Add documentation for
 thermal throttle
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, corbet@lwn.net, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org
Date: Fri, 14 Nov 2025 10:32:45 -0800
In-Reply-To: <CAJZ5v0i7fb58CUGwcPcbEXTqDeM5Hm7rRHVvgcr-W4ut8091gQ@mail.gmail.com>
References: <20251113212104.221632-1-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0i7fb58CUGwcPcbEXTqDeM5Hm7rRHVvgcr-W4ut8091gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 17:27 +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 13, 2025 at 10:21=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Add documentation for Intel thermal throttling reporting events.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > v2:
> > =C2=A0- Addressed comments from Rafael
> > =C2=A0- Limit line lengths ~80 columns
> >=20
> > =C2=A0Documentation/admin-guide/thermal/index.rst=C2=A0=C2=A0 |=C2=A0 1=
 +
> > =C2=A0.../admin-guide/thermal/thermal_throttle.rst=C2=A0 | 92
> > +++++++++++++++++++
> > =C2=A02 files changed, 93 insertions(+)
> > =C2=A0create mode 100644 Documentation/admin-
> > guide/thermal/thermal_throttle.rst
> >=20
> > diff --git a/Documentation/admin-guide/thermal/index.rst
> > b/Documentation/admin-guide/thermal/index.rst
> > index 193b7b01a87d..2e0cafd19f6b 100644
> > --- a/Documentation/admin-guide/thermal/index.rst
> > +++ b/Documentation/admin-guide/thermal/index.rst
> > @@ -6,3 +6,4 @@ Thermal Subsystem
> > =C2=A0=C2=A0=C2=A0 :maxdepth: 1
> >=20
> > =C2=A0=C2=A0=C2=A0 intel_powerclamp
> > +=C2=A0=C2=A0 thermal_throttle
> > diff --git a/Documentation/admin-guide/thermal/thermal_throttle.rst
> > b/Documentation/admin-guide/thermal/thermal_throttle.rst
> > new file mode 100644
> > index 000000000000..cac2bc3176ce
> > --- /dev/null
> > +++ b/Documentation/admin-guide/thermal/thermal_throttle.rst
> > @@ -0,0 +1,92 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Intel thermal throttle events reporting
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > +
> > +Introduction
> > +------------
> > +
> > +Intel processors have built in automatic and adaptive thermal
> > monitoring
> > +mechanisms that force the processor to reduce its power
> > consumption in order
> > +to operate within predetermined temperature limits.
> > +
> > +Refer to section "THERMAL MONITORING AND PROTECTION" in the
> > "Intel=C2=AE 64 and
> > +IA-32 Architectures Software Developer=E2=80=99s Manual Volume 3 (3A, =
3B,
> > 3C, & 3D):
> > +System Programming Guide" for more details.
> > +
> > +In general, there are two mechanisms to control the core
> > temperature of the
> > +processor. They are called "Thermal Monitor 1 (TM1) and Thermal
> > Monitor 2 (TM2)".
> > +
> > +The status of the temperature sensor that triggers the thermal
> > monitor (TM1/TM2)
> > +is indicated through the "thermal status flag" and "thermal status
> > log flag" in
> > +the MSR_IA32_THERM_STATUS for core level and
> > MSR_IA32_PACKAGE_THERM_STATUS for
> > +package level.
> > +
> > +Thermal Status flag, bit 0 =E2=80=94 When set, indicates that the
> > processor core
> > +temperature is currently at the trip temperature of the thermal
> > monitor and that
> > +the processor power consumption is being reduced via either TM1 or
> > TM2, depending
> > +on which is enabled. When clear, the flag indicates that the core
> > temperature is
> > +below the thermal monitor trip temperature. This flag is read
> > only.
> > +
> > +Thermal Status Log flag, bit 1 =E2=80=94 When set, indicates that the
> > thermal sensor has
> > +tripped since the last power-up or reset or since the last time
> > that software
> > +cleared this flag. This flag is a sticky bit; once set it remains
> > set until
> > +cleared by software or until a power-up or reset of the processor.
> > The default
> > +state is clear.
> > +
> > +It is possible that when user reads MSR_IA32_THERM_STATUS or
> > +MSR_IA32_PACKAGE_THERM_STATUS, TM1/TM2 is not active. In this
> > case,
> > +"Thermal Status flag" will read "0" and the "Thermal Status Log
> > flag" will be set
> > +to show any previous "TM1/TM2" activation. But since it needs to
> > be cleared by
> > +the software, it can't show the number of occurrences of "TM1/TM2"
> > activations.
> > +
> > +Hence, Linux provides counters of how many times the "Thermal
> > Status flag" was
> > +set. Also presents how long the "Thermal Status flag" was active
> > in milliseconds.
> > +Using these counters, users can check if the performance was
> > limited because of
> > +thermal events. It is recommended to read from sysfs instead of
> > directly reading
> > +MSRs as the "Thermal Status Log flag" is reset by the driver to
> > implement rate
> > +control.
> > +
> > +Sysfs Interface
> > +---------------
> > +
> > +Thermal throttling events are presented for each CPU under
> > +"/sys/devices/system/cpu/cpuX/thermal_throttle/", where "X" is the
> > CPU number.
> > +
> > +All these counters are read-only. They can't be reset to 0. So,
> > they can potentially
> > +overflow after reaching the maximum 64 bit unsigned integer.
> > +
> > +``core_throttle_count``
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This shows number of times "Therm=
al Status flag" changed
> > from 0 to 1 for this
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU since OS boot and thermal vec=
tor is initialized. This
> > is a 64 bit counter.
> > +
> > +``package_throttle_count``
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This shows number of times "Therm=
al Status flag" changed
> > from 0 to 1 for the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 package containing this CPU since=
 OS boot and thermal
> > vector is initialized.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package status is broadcast to al=
l CPUs; all CPUs in the
> > package increment
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this count. This is a 64-bit coun=
ter.
> > +
> > +``core_throttle_max_time_ms``
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This shows the maximum amount of =
time for which "Thermal
> > Status flag"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has been set to 1 for this CPU at=
 the core level since OS
> > boot and thermal
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vector is initialized.
> > +
> > +``package_throttle_max_time_ms``
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This shows the maximum amount of =
time for which "Thermal
> > Status flag"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has been set to 1 for the package=
 containing this CPU since
> > OS boot and
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thermal vector is initialized.
> > +
> > +``core_throttle_total_time_ms``
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This shows the cumulative time fo=
r which "Thermal Status
> > flag" has been
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set to 1 for this CPU for core le=
vel since OS boot and
> > thermal vector
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is initialized.
> > +
> > +``package_throttle_total_time_ms``
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This shows the cumulative time fo=
r which "Thermal Status
> > flag" has been set
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to 1 for the package containing t=
his CPU since OS boot and
> > thermal vector is
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initialized.
> > +
> > --
>=20
> Applied as 6.19 material with some adjustments:
> - The new file name is intel_thermal_throttle.rst
> - The subject has been edited to mention Intel
> - There are some minor edits in the document
>=20
> Please check in the bleeding-edge branch if it still looks good.

Looks good.

Thanks,
Srinivas

>=20
> Thanks!

