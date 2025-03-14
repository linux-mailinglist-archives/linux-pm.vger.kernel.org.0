Return-Path: <linux-pm+bounces-24065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77375A613A4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 15:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B969D3BD2A2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC928DB3;
	Fri, 14 Mar 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnH9ZP7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E322338;
	Fri, 14 Mar 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962642; cv=none; b=Zxz7/0GQa1PFKU+dtqv3qX0il53Qt6owFEmabqZPfJX41cXJtG0/oaJMbmMetS8wK5L4V8yxAeoP8HuCHFxN3/R3rpodKbnMV0669WW4UZQk97EIt6WdtcHNFjKW2EwhUCocvK5wXvRfI/OKQpseI5xmdiixTG0ZKJk8WMkMfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962642; c=relaxed/simple;
	bh=a5PlPmBAYxkGhv4IUUNWaMcmFYlqqbR728KvzqefdRo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dSbhc098zaTs59ASoffNDaIf8wTBzeyyJPtLU6K9JYb8MJ9iwgfU6h5M61Dih3n2suGanYasm5UMIPcDt+TAaEommUQmUzopmCBrIbiHh9nu+cs1LLMrjGHK4zlA94XMSfWKBTsQLmcEuNnrmCojA8dIMFLgXl2JyqbuJlHOxPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnH9ZP7Y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741962641; x=1773498641;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=a5PlPmBAYxkGhv4IUUNWaMcmFYlqqbR728KvzqefdRo=;
  b=AnH9ZP7Y39i5knUTe0i/g3mfdvz7FZhLGXU/OBTDfFG0+G45DRjKoF2C
   RUYdhk1POxlR9cyKBBkp5eeEy7cUN0NhdOMbgxgSv3sPExGTYuIio3u+r
   BAce7JXjiOOLIIPV6CyFUT9ZV4Y+FJNzWGGlJ+CatgH545ZQt0HUrPr71
   vSMmazs2p/8ru9tvxZYxl0hsLuFYizaXhcvlAyqDqkTXZP0jYaxHy7hii
   PzmlttduLiVrzOP+3D2MzVKOtUJIaj+b4taJoNyzpRrYSQQCRDs4bSViC
   ldp+4Pq8cd0VIm6jzn3DsKEmHxYQuWQoNyhlbQcuDHdIrRutW2mCOQyDg
   Q==;
X-CSE-ConnectionGUID: E0RJljGDT5KVDh704EyeiA==
X-CSE-MsgGUID: 14DZlcIwQg28MTTN6y8opg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="53322752"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53322752"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:30:40 -0700
X-CSE-ConnectionGUID: J9i6mq9uSqmnzLVkPMV90w==
X-CSE-MsgGUID: vx2E6BZ6RxWJycm+CGUFWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="122239932"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.108.163])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 07:30:40 -0700
Message-ID: <ab3fb97f30656badde65c542c72885392bfd7762.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] thermal: intel: int340x: Add platform temperature
 control interface
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>, "lukasz.luba@arm.com"
	 <lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>, 
 "daniel.lezcano@linaro.org"
	 <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 14 Mar 2025 07:30:39 -0700
In-Reply-To: <ca935ccd07fb27a77a39fa797738e7a2e96abeb1.camel@intel.com>
References: <20250308183812.118311-1-srinivas.pandruvada@linux.intel.com>
	 <20250308183812.118311-2-srinivas.pandruvada@linux.intel.com>
	 <ca935ccd07fb27a77a39fa797738e7a2e96abeb1.camel@intel.com>
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

On Tue, 2025-03-11 at 05:56 +0000, Zhang, Rui wrote:
> On Sat, 2025-03-08 at 10:38 -0800, Srinivas Pandruvada wrote:
> > Platform Temperature Control is a dynamic control loop implemented
> > in
> > hardware to manage the skin or any board temperature of a device.
> > The
> > reported skin or board temperature is controlled by comparing to a
> > configured target temperature and adjusting the SoC (System on
> > Chip)
> > performance accordingly. The feature supports up to three platform
> > sensors.
> >=20
> > OEMs (Original Equipment Manufacturers) can configure this feature
> > through the BIOS and provide temperature input directly to the
> > hardware
> > via the Platform Environment Control Interface (PECI).
>=20
> Does this mean each PTC instance is bound to a certain skin/board
> sensor?
Yes.

>  And writing the "temperature_target" sysfs tells firmware the
> target temperature, as well as the target sensor that the temperature
> applies to?=C2=A0
Yes

> if yes, is there a way for userspace to know which sensor
> each PTC instance applies to?
No.
You can just change threshold up and down by observation only.

Thanks,
Srinivas

>=20
> > =C2=A0As a result,
> > this feature can operate independently of any OS-level control.
> >=20
> > The OS interface can be used to further fine-tune the default OEM
> > configuration. Here are some scenarios where the OS interface is
> > beneficial:
> > Verification of Firmware Control: Check if firmware-based control
> > is
> > enabled. If it is, thermal controls from the OS/user space can be
> > backed out.
> > Adjusting Target Limits: While OEMs can set an aggressive target
> > limit,
> > the OS can adjust this to a less aggressive limit based on
> > operating
> > modes or conditions.
> >=20
> > The hardware control interface is via a MMIO offsets via processor
> > thermal device. There are three instances of MMIO registers. All
> > are 64 bit registers
> >=20
> > Name: PLATFORM_TEMPERATURE_CONTROL
> > Offsets: 0x5B20, 0x5B28, 0x5B30
> >=20
> > All values have RW access
> >=20
> > Bits=C2=A0=C2=A0=C2=A0 Description
> > 7:0=C2=A0=C2=A0=C2=A0=C2=A0 TARGET_TEMP : Target temperature limit to w=
hich the control
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mechanism is regulating. Uni=
ts: 0.5C.
> > 8:8=C2=A0=C2=A0=C2=A0=C2=A0 ENABLE: Read current enable status of the f=
eature or enable
> > 	feature.
> > 11:9	GAIN: Sets the aggressiveness of control loop from 0 to 7
> > 	7 graceful, favors performance at the expense of
> > temperature
> > 	overshoots
> > 	0 aggressive, favors tight regulation over performance
> > 12:12	TEMPERATURE_OVERRIDE_EN
> > 	When set, hardware will use TEMPERATURE_OVERRIDE values
> > instead
> > 	of reading from corresponding sensor.
> > 15:13	RESERVED
> > 23:16	MIN_PERFORMANCE_LEVEL: Minimum Performance level below
> > which
> > the
> > 	there will be no throttling. 0 - all levels of throttling
> > allowed
> > 	including survivability actions. 255 - no throttling
> > allowed.
> > 31:24	TEMPERATURE_OVERRIDE: Allows SW to override the input
> > temperature.
> > 	hardware will use this value instead of the sensor
> > temperature.
> > 	Units: 0.5C.
> > 63:32	RESERVED
> >=20
> > Out of the above controls, only "enable" and "temperature_target"
> > is
> > exposed via sysfs.
> > There are three instances of this controls. So up to three
> > different
> > sensors can be controlled independently.
> >=20
> > Sysfs interface:
> > tree
> > /sys/bus/pci/devices/0000\:00\:04.0/platform_temperature_?_control/
> > /sys/bus/pci/devices/0000:00:04.0/platform_temperature_0_control/
> > =E2=94=9C=E2=94=80=E2=94=80 enable
> > =E2=94=9C=E2=94=80=E2=94=80 temperature_target
> > /sys/bus/pci/devices/0000:00:04.0/platform_temperature_1_control/
> > =E2=94=9C=E2=94=80=E2=94=80 enable
> > =E2=94=9C=E2=94=80=E2=94=80 temperature_target
> > /sys/bus/pci/devices/0000:00:04.0/platform_temperature_2_control/
> > =E2=94=9C=E2=94=80=E2=94=80 enable
> > =E2=94=9C=E2=94=80=E2=94=80 temperature_target
> >=20
> > Description of attributes:
> >=20
> > Enable: 1 for enable, 0 for disable. This attribute can be used to
> > read the current status. User space can write 0 or 1 to disable or
> > enable this feature respectively.
> > temperature_target: Target temperature limit to which hardware
> > will try to limit in milli degree C.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0.../thermal/intel/int340x_thermal/Makefile=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> > =C2=A0.../platform_temperature_control.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 181
> > ++++++++++++++++++
> > =C2=A0.../processor_thermal_device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +-
> > =C2=A0.../processor_thermal_device.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > =C2=A04 files changed, 199 insertions(+), 1 deletion(-)
> > =C2=A0create mode 100644
> > drivers/thermal/intel/int340x_thermal/platform_temperature_control.
> > c
> >=20
> > diff --git a/drivers/thermal/intel/int340x_thermal/Makefile
> > b/drivers/thermal/intel/int340x_thermal/Makefile
> > index fe3f43924525..184318d1792b 100644
> > --- a/drivers/thermal/intel/int340x_thermal/Makefile
> > +++ b/drivers/thermal/intel/int340x_thermal/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_INT340X_THERMAL)	+=3D
> > processor_thermal_device_pci_legacy.o
> > =C2=A0obj-$(CONFIG_INT340X_THERMAL)	+=3D processor_thermal_device_pci.o
> > =C2=A0obj-$(CONFIG_PROC_THERMAL_MMIO_RAPL) +=3D processor_thermal_rapl.=
o
> > =C2=A0obj-$(CONFIG_INT340X_THERMAL)	+=3D processor_thermal_rfim.o
> > +obj-$(CONFIG_INT340X_THERMAL)	+=3D platform_temperature_control.o
> > =C2=A0obj-$(CONFIG_INT340X_THERMAL)	+=3D processor_thermal_mbox.o
> > =C2=A0obj-$(CONFIG_INT340X_THERMAL)	+=3D processor_thermal_wt_req.o
> > =C2=A0obj-$(CONFIG_INT340X_THERMAL)	+=3D processor_thermal_wt_hint.o
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.
> > c
> > b/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.
> > c
> > new file mode 100644
> > index 000000000000..dd3ea7165800
> > --- /dev/null
> > +++
> > b/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.
> > c
> > @@ -0,0 +1,181 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * processor thermal device platform temperature controls
> > + * Copyright (c) 2025, Intel Corporation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include "processor_thermal_device.h"
> > +
> > +struct mmio_reg {
> > +	int bits;
> > +	u16 mask;
> > +	u16 shift;
> > +	u16 units;
> > +};
> > +
> > +#define MAX_ATTR_GROUP_NAME_LEN 32
> > +
> > +struct ptc_data {
> > +	u32 offset;
> > +	struct attribute_group ptc_attr_group;
> > +	struct attribute *ptc_attrs[3];
> > +	struct device_attribute temperature_target_attr;
> > +	struct device_attribute enable_attr;
> > +	char group_name[MAX_ATTR_GROUP_NAME_LEN];
> > +};
> > +
> > +static const struct mmio_reg ptc_mmio_regs[] =3D {
> > +	{ 8, 0xFF, 0, 500}, /* temperature_target, units 0.5C*/
> > +	{ 1, 0x01, 8, 0}, /* enable */
> > +	{ 3, 0x7, 9, 0}, /* gain */
> > +	{ 8, 0xFF, 16, 0}, /* min_performance_level */
> > +	{ 1, 0x1, 12, 0}, /* temperature_override_enable */
> > +	{ 8, 0xFF, 24, 500}, /* temperature_override, units 0.5C
> > */
> > +};
> > +
> > +/* Unique offset for each PTC instance */
> > +static u32 ptc_offsets[] =3D {0x5B20, 0x5B28, 0x5B30};
>=20
> I'd prefer to define PTC_MAX_INSTANCES earlier and use
> =C2=A0 static u32 ptc_offsets[PTC_MAX_INSTANCES] =3D {0x5B20, 0x5B28,
> 0x5B30};
> instead.
>=20
> thanks,
> rui


