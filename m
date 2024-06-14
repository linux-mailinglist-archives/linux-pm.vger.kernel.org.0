Return-Path: <linux-pm+bounces-9174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F7D9088D4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1761C21A15
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4D193091;
	Fri, 14 Jun 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUC1wLJL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4218413A;
	Fri, 14 Jun 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358971; cv=none; b=d14QNXnV39iY4rKa/MicayJiVmbeputy9iUDLu9bB8NUPOVclgbh0MC9IQ2fLaSHOcFGjayIrM3yppmlA6pV5k+lvVYrg9v4Y1Rp6SGHZ9qlnJ+2FnaXH8Lbf5hVxI1Wr/5bD1LuHV34uU4rb3Y/+VnjDUKzcsXdI5yYTJ8xYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358971; c=relaxed/simple;
	bh=RAt2FpxSe0dP246gGXiIYFuF9qDssyyBjrsAwXDYzxg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o4GTDNrLjGCr1r3zn8og+facyJ3xyGosbIYRQp7r84vxje3B8//E3tFhu25ZZoHV6bZyl09bPtv+3GbMPmEJYTmU6oUiLuFpo5q5oXVwz+qbqw7U1vWl2AA6ClOmiyZwgkKrRMuj0PhoDQFZKrcfjiZmnVzxsJjxgKD5SKC4dQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUC1wLJL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718358969; x=1749894969;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RAt2FpxSe0dP246gGXiIYFuF9qDssyyBjrsAwXDYzxg=;
  b=SUC1wLJLlxy0/qbrYLziYq5x5g7Zr68hRXQwrvbdcKUIZ1rjJ0ObTlKu
   ETkTafCI1tge+bz1tptqBatvROy1ryzkqyv+75fyk9KE5/UiIc/irLiFS
   jDd0tWd3FgwoUiII+Xkmc7deXJ88F5g4VBLqOTPqTUp1ctfZULhz/YwYW
   3+7wGlYPR+be/c5CzEJdLs2pGhZH40GX+JUqINJN+nxjQHFVN4uZa95Sp
   bXIFsa0pgBhmmllqriMLF2l/3LU0R2iYANETSEEm8LLBXmv7HYIiLX+0S
   BsHdcuAwbf7mEGfhiuHDd7D5DglhFbIJ8N4SXUenSFOup5FX9sW/lQzsd
   g==;
X-CSE-ConnectionGUID: rBwfTv01QxG559ylgalOnQ==
X-CSE-MsgGUID: yPF0BR/NQc2S7zT81jomgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15466293"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15466293"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:55:58 -0700
X-CSE-ConnectionGUID: 0fZrfwT2TOeI24joKOR61w==
X-CSE-MsgGUID: MOgr1VoZTfKoMi1evd9Osg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40583267"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:55:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 12:55:48 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v7 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
In-Reply-To: <20240614-yoga-ec-driver-v7-4-9f0b9b40ae76@linaro.org>
Message-ID: <1f6ada87-ae52-dca8-96f2-0fe6f85a372a@linux.intel.com>
References: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org> <20240614-yoga-ec-driver-v7-4-9f0b9b40ae76@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-240991490-1718358948=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-240991490-1718358948=:1013
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 14 Jun 2024, Dmitry Baryshkov wrote:

> On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
> and battery status. Add the driver to read power supply status on the
> laptop.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/power/supply/Kconfig                    |   9 +
>  drivers/power/supply/Makefile                   |   1 +
>  drivers/power/supply/lenovo_yoga_c630_battery.c | 500 ++++++++++++++++++=
++++++
>  3 files changed, 510 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3e31375491d5..55ab8e90747d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -167,6 +167,15 @@ config BATTERY_LEGO_EV3
>  =09help
>  =09  Say Y here to enable support for the LEGO MINDSTORMS EV3 battery.
> =20
> +config BATTERY_LENOVO_YOGA_C630
> +=09tristate "Lenovo Yoga C630 battery"
> +=09depends on OF && EC_LENOVO_YOGA_C630
> +=09help
> +=09  This driver enables battery support on the Lenovo Yoga C630 laptop.
> +
> +=09  To compile the driver as a module, choose M here: the module will b=
e
> +=09  called lenovo_yoga_c630_battery.
> +
>  config BATTERY_PMU
>  =09tristate "Apple PMU battery"
>  =09depends on PPC32 && ADB_PMU
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index 58b567278034..8ebbdcf92dac 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_BATTERY_DS2782)=09+=3D ds2782_battery.o
>  obj-$(CONFIG_BATTERY_GAUGE_LTC2941)=09+=3D ltc2941-battery-gauge.o
>  obj-$(CONFIG_BATTERY_GOLDFISH)=09+=3D goldfish_battery.o
>  obj-$(CONFIG_BATTERY_LEGO_EV3)=09+=3D lego_ev3_battery.o
> +obj-$(CONFIG_BATTERY_LENOVO_YOGA_C630) +=3D lenovo_yoga_c630_battery.o
>  obj-$(CONFIG_BATTERY_PMU)=09+=3D pmu_battery.o
>  obj-$(CONFIG_BATTERY_QCOM_BATTMGR)=09+=3D qcom_battmgr.o
>  obj-$(CONFIG_BATTERY_OLPC)=09+=3D olpc_battery.o
> diff --git a/drivers/power/supply/lenovo_yoga_c630_battery.c b/drivers/po=
wer/supply/lenovo_yoga_c630_battery.c
> new file mode 100644
> index 000000000000..0209cdb5546f
> --- /dev/null
> +++ b/drivers/power/supply/lenovo_yoga_c630_battery.c
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2024, Linaro Ltd
> + * Authors:
> + *    Bjorn Andersson
> + *    Dmitry Baryshkov
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bits.h>

Add #include <linux/cleanup.h> for guard().

(I added it into patch 2/6 myself so you don't need to respin that=20
patch just because of it).

Once you've addressed the include and the note from Sebastian about=20
Kconfig dependencies, please add:

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-240991490-1718358948=:1013--

