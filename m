Return-Path: <linux-pm+bounces-32906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93423B31824
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 14:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004E116FD77
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB242FB994;
	Fri, 22 Aug 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyGVDa/y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738062FB61F;
	Fri, 22 Aug 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866627; cv=none; b=G/0F/nZYOT/8g6ZGx9MTS3pIrCK0mgPsF5dMZLamk2bYvUgpA2FyDMDO9rty12dxoZiemKadeQItsjWJmB6Rqt3IQ6DbCgmreGr9xtZzzz7PXtQjb/UgVPLPn9+CEV6AhE7z4epdCOL7Cfl3sHj0+8rnHMS3ysappoNULWSRrq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866627; c=relaxed/simple;
	bh=Uu7zeUy3LSgXwtCG5DSemJUstJY3Hjvk5y4aCu4KEPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN/DgwA+a4zFk8Qsj+b2qtqrUX2MSOE07OCyJ13o97LPX9quDPug04x3ywQn6GzWKhmemvb0ir1ZFybZIQpmBMiT6bs503mTCvrFT/sHF48LDdI4QMTIWb7igqFZjA442zu1zF5eSLF7+PI4UzWhK8NGK7KEMs7JcYyXkCy4Dt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyGVDa/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB272C113D0;
	Fri, 22 Aug 2025 12:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755866626;
	bh=Uu7zeUy3LSgXwtCG5DSemJUstJY3Hjvk5y4aCu4KEPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XyGVDa/yOjNEr0f/f6Zljb3CwTADIT0D3FIH5h1RjhfcNWKWAVgxQyNlA13ZgCKwa
	 Uigzt9T4V4huCt6cH5DdXTVp1zKjyJyWTR6gszB8atdbeIi3jsFJHyl47BHzQuTYcE
	 q3wLEbw9VrQBH2pUaa1gR3ydByahcBR89qGBp8VtDGNJRB1nbExnRqKfSDD+2m1i9L
	 xQF1nCrbQrRG4jb/GA9JIQPetmzTGgr9oGyN0OqZVnpUhT1m1++GkeXjmfZ7czE6Oj
	 8xpUyHc01wIOouRMVUtmxz3Gclp+kvaaWNbXVzzz8JN/v88WLpYGxmVKDJqERprLkB
	 CbbncmcVDvWNA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61d99c87d32so1017002eaf.1;
        Fri, 22 Aug 2025 05:43:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGiw64dunyAMx6TjiLS7sEf+PIDaBihZlkOT/6ZuoatwMPGNmmseB/GPkB5ZQqCN/yjthdcjAq+yvJOys=@vger.kernel.org, AJvYcCVoTW1EK0EcxTlKDfNASJM5cUBs14qTb7SbdrzA8nUxagkfSv45pvIfYyffIPydu7BYn5EmjYKPP8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgyW+853gReoHguKWDOQP3+pWuKwXj2+uK7msGczJeuPrQhdB
	/5GybulQs84gmhIMRIdNkTrOQCxgXY+ZvNecr20Os26TcHlMWOxRV+8ZGV4nEFm8GXUhZ28YA40
	uL5PK3j7pNSFONzAfmdpOyKah+WVucZ8=
X-Google-Smtp-Source: AGHT+IFMmem59JLbPdfkQ1UgYoJL5ctCEHvVETuCVKE+0gxTuyQO7ap/oaLsLqbsmAjE86p9RuWyLbx36b83Ypy4toY=
X-Received: by 2002:a05:6808:4fe7:b0:437:7578:9c45 with SMTP id
 5614622812f47-437852bafd6mr1595888b6e.43.1755866625182; Fri, 22 Aug 2025
 05:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813185530.635096-1-srinivas.pandruvada@linux.intel.com> <20250813185530.635096-2-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250813185530.635096-2-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 14:43:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-1ot-uXn8tzpYo+fXDjcD2Jj+LrpZgVqG+J6DsT0muA@mail.gmail.com>
X-Gm-Features: Ac12FXw9xA0OH0ZZ9nUP934W7IrbwYYvfCPzaqrEpIqXR_LAxasoDRAKoXTZW24
Message-ID: <CAJZ5v0h-1ot-uXn8tzpYo+fXDjcD2Jj+LrpZgVqG+J6DsT0muA@mail.gmail.com>
Subject: Re: [PATCH 1/5] thermal: intel: int340x: Add support for power slider
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 8:55=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add support for system wide energy performance preference using a SoC
> slider interface defined via processor thermal PCI device MMIO space.
>
> Using Linux platform-profile class API, register a new platform profile.
> Provide three platform power profile choices:
> "performance", "balanced" and "low-power".
>
> Profile sysfs is located at:
> /sys/class/platform-profile/platform-profile-*
> where attribute "name" is presented as "SoC Power Slider".
>
> At boot by default the slider is set to balanced mode. This profile is
> changed by user space based on user preference via power profile daemon
> or directly writing to the "profile" sysfs attribute.
>
> Add a CPU model specific processor thermal device feature
> PROC_THERMAL_FEATURE_SOC_POWER_SLIDER. When enabled for a CPU model,
> slider interface is registered.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

LGTM overall, a few minor nits below.

> ---
>  drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
>  .../thermal/intel/int340x_thermal/Makefile    |   1 +
>  .../processor_thermal_device.c                |  10 +
>  .../processor_thermal_device.h                |   4 +
>  .../processor_thermal_soc_slider.c            | 171 ++++++++++++++++++
>  5 files changed, 187 insertions(+)
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_therm=
al_soc_slider.c
>
> diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/ther=
mal/intel/int340x_thermal/Kconfig
> index 4c699f0896b5..4ced7bdcd62c 100644
> --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> @@ -12,6 +12,7 @@ config INT340X_THERMAL
>         select ACPI_THERMAL_LIB
>         select INTEL_SOC_DTS_IOSF_CORE
>         select INTEL_TCC
> +       select ACPI_PLATFORM_PROFILE
>         select PROC_THERMAL_MMIO_RAPL if POWERCAP
>         help
>           Newer laptops and tablets that use ACPI may have thermal sensor=
s and
> diff --git a/drivers/thermal/intel/int340x_thermal/Makefile b/drivers/the=
rmal/intel/int340x_thermal/Makefile
> index 184318d1792b..436be34b21a9 100644
> --- a/drivers/thermal/intel/int340x_thermal/Makefile
> +++ b/drivers/thermal/intel/int340x_thermal/Makefile
> @@ -14,5 +14,6 @@ obj-$(CONFIG_INT340X_THERMAL) +=3D processor_thermal_mb=
ox.o
>  obj-$(CONFIG_INT340X_THERMAL)  +=3D processor_thermal_wt_req.o
>  obj-$(CONFIG_INT340X_THERMAL)  +=3D processor_thermal_wt_hint.o
>  obj-$(CONFIG_INT340X_THERMAL)  +=3D processor_thermal_power_floor.o
> +obj-$(CONFIG_INT340X_THERMAL)  +=3D processor_thermal_soc_slider.o
>  obj-$(CONFIG_INT3406_THERMAL)  +=3D int3406_thermal.o
>  obj-$(CONFIG_ACPI_THERMAL_REL) +=3D acpi_thermal_rel.o
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 29fcece48cad..4aea5c9baae9 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -432,8 +432,18 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
>                 }
>         }
>
> +       if (feature_mask & PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) {
> +               ret =3D proc_thermal_soc_power_slider_add(pdev, proc_priv=
);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to add soc power effi=
ciency slider\n");

Maybe dev_info()?  I'm not sure if this failure is serious enough for dev_e=
rr().

> +                       goto err_rem_wlt;
> +               }
> +       }
> +
>         return 0;
>
> +err_rem_wlt:
> +       proc_thermal_wt_hint_remove(pdev);
>  err_rem_rfim:
>         proc_thermal_rfim_remove(pdev);
>  err_rem_ptc:
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index 49398794124a..ba3f64742f2f 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -69,6 +69,7 @@ struct rapl_mmio_regs {
>  #define PROC_THERMAL_FEATURE_POWER_FLOOR       0x40
>  #define PROC_THERMAL_FEATURE_MSI_SUPPORT       0x80
>  #define PROC_THERMAL_FEATURE_PTC       0x100
> +#define PROC_THERMAL_FEATURE_SOC_POWER_SLIDER  0x200
>
>  #if IS_ENABLED(CONFIG_PROC_THERMAL_MMIO_RAPL)
>  int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_devi=
ce *proc_priv);
> @@ -127,4 +128,7 @@ int proc_thermal_mmio_add(struct pci_dev *pdev,
>  void proc_thermal_mmio_remove(struct pci_dev *pdev, struct proc_thermal_=
device *proc_priv);
>  int proc_thermal_ptc_add(struct pci_dev *pdev, struct proc_thermal_devic=
e *proc_priv);
>  void proc_thermal_ptc_remove(struct pci_dev *pdev);
> +
> +int proc_thermal_soc_power_slider_add(struct pci_dev *pdev, struct proc_=
thermal_device *proc_priv);
> +
>  #endif
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> new file mode 100644
> index 000000000000..c492ee937dc7
> --- /dev/null
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Processor Thermal Device Interface for Reading and Writing
> + * SoC Power Slider Values from User Space.
> + *
> + * Operation:
> + * The SOC_EFFICIENCY_SLIDER_0_0_0_MCHBAR register is accessed
> + * using the MMIO (Memory-Mapped I/O) interface with an MMIO offset of 0=
x5B38.
> + * Although this register is 64 bits wide, only bits 7:0 are used,
> + * and the other bits remain unchanged.
> + *
> + * Bit definitions
> + *
> + * Bits 2:0 (Slider value):
> + * The SoC optimizer slider value indicates the system wide energy perfo=
rmance
> + * hint. The slider has no specific units and ranges from 0 (highest
> + * performance) to 6 (highest energy efficiency). Value of 7 is reserved=
.
> + * Bits 3 : Reserved
> + * Bits 6:4 (Offset)
> + * Offset allows the SoC to automatically switch slider position in rang=
e
> + * [slider value (bits 2:0) + offset] to improve power efficiency based =
on
> + * internal SoC algorithms.
> + * Bit 7 (Enable):
> + * If this bit is set, the SoC Optimization sliders will be processed by=
 the
> + * SoC firmware.
> + *
> + * Copyright (c) 2025, Intel Corporation.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/pci.h>
> +#include <linux/platform_profile.h>
> +#include "processor_thermal_device.h"
> +
> +#define SOC_POWER_SLIDER_OFFSET        0x5B38
> +
> +enum power_slider_preference {
> +       SOC_POWER_SLIDER_PERFORMANCE,
> +       SOC_POWER_SLIDER_BALANCE,
> +       SOC_POWER_SLIDER_POWERSAVE,
> +};
> +
> +#define SOC_SLIDER_VALUE_MINIMUM       0x00
> +#define SOC_SLIDER_VALUE_MAXIMUM       0x06
> +#define SOC_SLIDER_VALUE_BALANCE       0x03

I would sort these by value, lowest to highest.

> +
> +static u8 slider_values[] =3D {
> +       [SOC_POWER_SLIDER_PERFORMANCE] =3D SOC_SLIDER_VALUE_MINIMUM,
> +       [SOC_POWER_SLIDER_BALANCE] =3D SOC_SLIDER_VALUE_BALANCE,
> +       [SOC_POWER_SLIDER_POWERSAVE] =3D SOC_SLIDER_VALUE_MAXIMUM,
> +};
> +
> +/* Convert from platform power profile option to SoC slider value */
> +static int convert_profile_to_power_slider(enum platform_profile_option =
profile)
> +{
> +       switch (profile) {
> +       case PLATFORM_PROFILE_LOW_POWER:
> +               return slider_values[SOC_POWER_SLIDER_POWERSAVE];
> +       case PLATFORM_PROFILE_BALANCED:
> +               return slider_values[SOC_POWER_SLIDER_BALANCE];
> +       case PLATFORM_PROFILE_PERFORMANCE:
> +               return slider_values[SOC_POWER_SLIDER_PERFORMANCE];
> +       default:
> +               return -EOPNOTSUPP;

I would use break here.

> +       }
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +/* Convert to platform power profile option from SoC slider values */
> +static int convert_power_slider_to_profile(u8 slider)
> +{
> +       if (slider =3D=3D slider_values[SOC_POWER_SLIDER_PERFORMANCE])
> +               return PLATFORM_PROFILE_PERFORMANCE;
> +       if (slider =3D=3D slider_values[SOC_POWER_SLIDER_BALANCE])
> +               return PLATFORM_PROFILE_BALANCED;
> +       if (slider =3D=3D slider_values[SOC_POWER_SLIDER_POWERSAVE])
> +               return PLATFORM_PROFILE_LOW_POWER;
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +#define SLIDER_MASK            GENMASK_ULL(2, 0)
> +#define SLIDER_ENABLE_BIT      7

I'd move these up to where the other symbols are defined.

> +
> +static void set_soc_power_profile(struct proc_thermal_device *proc_priv,=
 int slider)
> +{
> +       u64 val;
> +
> +       val =3D readq(proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);

I would define a macro or static inline for the proc_priv->mmio_base +
SOC_POWER_SLIDER_OFFSET computation.  It has enough characters and it
is used enough times to get a separate wrapper IMV.

> +       val &=3D ~SLIDER_MASK;
> +       val |=3D FIELD_PREP(SLIDER_MASK, slider);
> +       val |=3D BIT(SLIDER_ENABLE_BIT);

The two statements above can be combined.

> +       writeq(val, proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
> +}
> +
> +/* profile get/set callbacks are called with a profile lock, so no need =
for local locks */
> +
> +static int power_slider_platform_profile_set(struct device *dev,
> +                                            enum platform_profile_option=
 profile)
> +{
> +       struct proc_thermal_device *proc_priv;
> +       int slider;
> +
> +       proc_priv =3D dev_get_drvdata(dev);
> +       if (!proc_priv)
> +               return -EOPNOTSUPP;
> +
> +       slider =3D convert_profile_to_power_slider(profile);
> +       if (slider < 0)
> +               return slider;
> +
> +       set_soc_power_profile(proc_priv, slider);
> +
> +       return 0;
> +}
> +
> +static int power_slider_platform_profile_get(struct device *dev,
> +                                            enum platform_profile_option=
 *profile)
> +{
> +       struct proc_thermal_device *proc_priv;
> +       int slider, ret;
> +       u64 val;
> +
> +       proc_priv =3D dev_get_drvdata(dev);
> +       if (!proc_priv)
> +               return -EOPNOTSUPP;
> +
> +       val =3D readq(proc_priv->mmio_base + SOC_POWER_SLIDER_OFFSET);
> +       slider =3D FIELD_GET(SLIDER_MASK, val);
> +
> +       ret =3D convert_power_slider_to_profile(slider);
> +       if (ret < 0)
> +               return ret;
> +
> +       *profile =3D ret;
> +
> +       return 0;
> +}
> +
> +static int power_slider_platform_profile_probe(void *drvdata, unsigned l=
ong *choices)
> +{
> +       set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +       set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +       set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +
> +       return 0;
> +}
> +
> +static const struct platform_profile_ops power_slider_platform_profile_o=
ps =3D {
> +       .probe =3D power_slider_platform_profile_probe,
> +       .profile_get =3D power_slider_platform_profile_get,
> +       .profile_set =3D power_slider_platform_profile_set,
> +};
> +
> +int proc_thermal_soc_power_slider_add(struct pci_dev *pdev, struct proc_=
thermal_device *proc_priv)
> +{
> +       struct device *ppdev;
> +
> +       set_soc_power_profile(proc_priv, slider_values[SOC_POWER_SLIDER_B=
ALANCE]);
> +
> +       ppdev =3D devm_platform_profile_register(&pdev->dev, "SoC Power S=
lider", proc_priv,
> +                                              &power_slider_platform_pro=
file_ops);
> +
> +       return PTR_ERR_OR_ZERO(ppdev);
> +}
> +EXPORT_SYMBOL_NS_GPL(proc_thermal_soc_power_slider_add, "INT340X_THERMAL=
");
> +
> +MODULE_IMPORT_NS("INT340X_THERMAL");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Processor Thermal Power Slider Interface");
> --

