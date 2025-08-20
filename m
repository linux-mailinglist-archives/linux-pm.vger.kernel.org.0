Return-Path: <linux-pm+bounces-32726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D921BB2E2FA
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D972E165A26
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98E33438D;
	Wed, 20 Aug 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHC6r6DO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB72E8B6B
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709723; cv=none; b=es1931EoM9Kwh/ILO4qTw+TmTG7IfgoxNczf0B3GMdSVuYSsvdYBQbMfHApHoYeO8zNGxuT2JLBWTQw5Fgl1o1F4NMsqXch1Cnu/HDSvO6hOB6lW5tOY8cWD1vajeidAP0v4cDt5GtCm1+GJoRbPZDIHfoECMsNBi92zZmlRkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709723; c=relaxed/simple;
	bh=x+EKNtxAQ9l756DwgKUb8ijSUB9O0+FhQZsF9FKRz9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R38Ku5yWK7t07Cn06neslRJY39RNA7v1gg8Ql1RO8aFT/3HkCVc3ya2LfKLSuiTpT4tzOf5mvHmSiASnJg/53ol0iL2bWCDmKEjQXB18UDqapLwePibEYNFibE/MyAqhH/akf5/R9on7upvvZoPf9SFzNWW5bP90EuqvU8LBGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHC6r6DO; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6083cc69so379677b3.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755709720; x=1756314520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O/XUuLfoY6+gYrAj9zQedluwYe3BaTFEGX9Jgs2SqNQ=;
        b=AHC6r6DO2zclTxiVz4PwnKL0Ffp70TBgwsl3f1IWETI1G5bGo2vh1CqPdflNrYjnEF
         XBSv/g+WPithrqRvinGyxhLm63AnE4cObC4M4d7OEktyiHUiotQ83Z0ZhBGuJ5G4vAjQ
         bF/RaBrz9xqpvHhkRdvfrKe9yFotjV3AFxPPpAr6ibosPtIIZnT1qGl/0pu37Z7xINS2
         wGjqTfMcC1eeBlI/omZypBJpVm8/tTWdcN+JzEYvM4Qt2gECWwFhbdxegCOTBbah0Nj3
         Nc+5cO0l6VFkDwgCIU2BGjCzuQXgnoFed6DlPiyMRy5XqwAWThYovS2S1sxCTohQuA/v
         36Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755709720; x=1756314520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/XUuLfoY6+gYrAj9zQedluwYe3BaTFEGX9Jgs2SqNQ=;
        b=sEyQQ4uTX71wbHaxpZ+9zme5JLurbmqQ9jNOy26tR1LwbAPMEMK1sdUsh1XFX4gMRZ
         c9E+e8VFznYMz8nHwlSrKst1QRZx1U/QhEUuzTLSTvoCrV1J1I2Kk7NMmdmBPh9n8DTX
         JQOL8ZFW4FvEGKgl/au+FdLf5lTIzXw4wZY5Eq+lLE+0ubyBjCoR9KuBVe83qOsHJwTQ
         mnoeqsRWQujWOpfTihTofTauV3H2Mn4SY+PQHcH8A+KM2Pb8qDW+WJDMg7pw/S1OAETT
         uK8y0igpDJ/8m6deNmz/4qqdBetA9HCDUtw/i4RWMBlwvUQ53o4R6OQZTLWgbPY24Gxz
         ebgg==
X-Forwarded-Encrypted: i=1; AJvYcCXbQ/1H04T1U1RHipwSFT8wIaE+uCS4fFjEiHEDWohkxwZ5/D6SJ31WMDc/FCgXkD3m5uIxPjLQHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fnUfWBF5yJVLBGYiyTA2xzC219kCJozGv2hDQ5jADqf/vnOS
	bKn5GIIEMvpyyPWpZ2EQZgddTwYg6Xb5Y9hQSJfvDpKPO8q3Yd0yCxlPCy0PXE69VBlqdBd0RS4
	FMRIRav0Oxu0k0l1E6vg1Wyk35QvLT4imWQe1fftq5w==
X-Gm-Gg: ASbGncsOLH5Y/l8+xu2fw9XPLcK/gQRyKvtqL7ZyIpMCOMLMqBQx++BPNnyFvFgECdE
	kek/BPiwmSduyw6EE3FQvcnW+Ragu6rnM5M1VVb7YWjPAFH9uOh7ZjRMx1MRwmPlYdfnNBvDvjm
	llOWQ0bICkrwWilRgV5YDFWToCURxmheJw5JI8a3ILx4KariXfuKDVkoWwGggUU6g4UwtxKqagD
	Zef9L+4gzLxzsrE66o=
X-Google-Smtp-Source: AGHT+IGlGXuOvnfP3Ir6OS8al6ga3AfydhvhjdXrQHZJuSnSmrgoAV/zsSysQENVrVYRVpQFRldeApRViDFlFkTu4k8=
X-Received: by 2002:a05:690c:d88:b0:71a:f22:28fa with SMTP id
 00721157ae682-71fb3239be7mr40732987b3.39.1755709719218; Wed, 20 Aug 2025
 10:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250820085609eucas1p2938d69999f4d7c9654d5d2a12a20c906@eucas1p2.samsung.com>
 <20250820-apr_14_for_sending-v12-0-4213ccefbd05@samsung.com> <20250820-apr_14_for_sending-v12-1-4213ccefbd05@samsung.com>
In-Reply-To: <20250820-apr_14_for_sending-v12-1-4213ccefbd05@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 19:08:02 +0200
X-Gm-Features: Ac12FXw84idZj0dYShW-KZlBsFf_YLd_YtGHUpuugnHlBqwWFxkTq5CDVHjf0G4
Message-ID: <CAPDyKFqeOUwTbZEUFmHS2Onyj5LZ1b26vGgC4=UHUOxhwbzjRw@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] drm/imagination: Use pwrseq for TH1520 GPU power management
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Drew Fustini <fustini@kernel.org>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 10:56, Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> Update the Imagination PVR DRM driver to leverage the pwrseq framework
> for managing the complex power sequence of the GPU on the T-HEAD TH1520
> SoC.
>
> To cleanly separate platform-specific logic from the generic driver,
> this patch introduces an `init` callback to the `pwr_power_sequence_ops`
> struct. This allows for different power management strategies to be
> selected at probe time based on the device's compatible string.
>
> A `pvr_device_data` struct, associated with each compatible in the
> of_device_id table, points to the appropriate ops table (manual or
> pwrseq).
>
> At probe time, the driver now calls the `->init()` op. For pwrseq-based
> platforms, this callback calls `devm_pwrseq_get("gpu-power")`, deferring
> probe if the sequencer is not yet available. For other platforms, it
> falls back to the existing manual clock and reset handling. The runtime
> PM callbacks continue to call the appropriate functions via the ops
> table.
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/imagination/pvr_device.c |  22 +---
>  drivers/gpu/drm/imagination/pvr_device.h |  22 ++++
>  drivers/gpu/drm/imagination/pvr_drv.c    |  27 ++++-
>  drivers/gpu/drm/imagination/pvr_power.c  | 174 ++++++++++++++++++++++++-------
>  drivers/gpu/drm/imagination/pvr_power.h  |  15 +++
>  5 files changed, 201 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
> index 8b9ba4983c4cb5bc40342fcafc4259078bc70547..294b6019b4155bb7fdb7de73ccf7fa8ad867811f 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c
> @@ -23,6 +23,7 @@
>  #include <linux/firmware.h>
>  #include <linux/gfp.h>
>  #include <linux/interrupt.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> @@ -121,21 +122,6 @@ static int pvr_device_clk_init(struct pvr_device *pvr_dev)
>         return 0;
>  }
>
> -static int pvr_device_reset_init(struct pvr_device *pvr_dev)
> -{
> -       struct drm_device *drm_dev = from_pvr_device(pvr_dev);
> -       struct reset_control *reset;
> -
> -       reset = devm_reset_control_get_optional_exclusive(drm_dev->dev, NULL);
> -       if (IS_ERR(reset))
> -               return dev_err_probe(drm_dev->dev, PTR_ERR(reset),
> -                                    "failed to get gpu reset line\n");
> -
> -       pvr_dev->reset = reset;
> -
> -       return 0;
> -}
> -
>  /**
>   * pvr_device_process_active_queues() - Process all queue related events.
>   * @pvr_dev: PowerVR device to check
> @@ -618,6 +604,9 @@ pvr_device_init(struct pvr_device *pvr_dev)
>         struct device *dev = drm_dev->dev;
>         int err;
>
> +       /* Get the platform-specific data based on the compatible string. */
> +       pvr_dev->device_data = of_device_get_match_data(dev);
> +
>         /*
>          * Setup device parameters. We do this first in case other steps
>          * depend on them.
> @@ -631,8 +620,7 @@ pvr_device_init(struct pvr_device *pvr_dev)
>         if (err)
>                 return err;
>
> -       /* Get the reset line for the GPU */
> -       err = pvr_device_reset_init(pvr_dev);
> +       err = pvr_dev->device_data->pwr_ops->init(pvr_dev);
>         if (err)
>                 return err;
>
> diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
> index 7cb01c38d2a9c3fc71effe789d4dfe54eddd93ee..0c970255f90805a569d7d19e35ec5f4ca7f02f7a 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.h
> +++ b/drivers/gpu/drm/imagination/pvr_device.h
> @@ -37,6 +37,9 @@ struct clk;
>  /* Forward declaration from <linux/firmware.h>. */
>  struct firmware;
>
> +/* Forward declaration from <linux/pwrseq/consumer.h> */
> +struct pwrseq_desc;
> +
>  /**
>   * struct pvr_gpu_id - Hardware GPU ID information for a PowerVR device
>   * @b: Branch ID.
> @@ -57,6 +60,14 @@ struct pvr_fw_version {
>         u16 major, minor;
>  };
>
> +/**
> + * struct pvr_device_data - Platform specific data associated with a compatible string.
> + * @pwr_ops: Pointer to a structure with platform-specific power functions.
> + */
> +struct pvr_device_data {
> +       const struct pvr_power_sequence_ops *pwr_ops;
> +};
> +
>  /**
>   * struct pvr_device - powervr-specific wrapper for &struct drm_device
>   */
> @@ -98,6 +109,9 @@ struct pvr_device {
>         /** @fw_version: Firmware version detected at runtime. */
>         struct pvr_fw_version fw_version;
>
> +       /** @device_data: Pointer to platform-specific data. */
> +       const struct pvr_device_data *device_data;
> +
>         /** @regs_resource: Resource representing device control registers. */
>         struct resource *regs_resource;
>
> @@ -148,6 +162,14 @@ struct pvr_device {
>          */
>         struct reset_control *reset;
>
> +       /**
> +        * @pwrseq: Pointer to a power sequencer, if one is used.
> +        *
> +        * Note: This member should only be accessed when
> +        * IS_ENABLED(CONFIG_POWER_SEQUENCING) is true.
> +        */

This looks like something that should be taken care of by the pwrseq interface?

Ideally there should be stub functions, when CONFIG_POWER_SEQUENCING
is unset, right?

> +       struct pwrseq_desc *pwrseq;
> +
>         /** @irq: IRQ number. */
>         int irq;
>
> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
> index b058ec183bb30ab5c3db17ebaadf2754520a2a1f..af830e565646daf19555197df492438ef48d5e44 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1480,15 +1480,37 @@ static void pvr_remove(struct platform_device *plat_dev)
>         pvr_power_domains_fini(pvr_dev);
>  }
>
> +static const struct pvr_device_data pvr_device_data_manual = {
> +       .pwr_ops = &pvr_power_sequence_ops_manual,
> +};
> +
> +#if IS_ENABLED(CONFIG_POWER_SEQUENCING)

Ditto.

> +static const struct pvr_device_data pvr_device_data_pwrseq = {
> +       .pwr_ops = &pvr_power_sequence_ops_pwrseq,
> +};
> +#endif
> +
>  static const struct of_device_id dt_match[] = {
> -       { .compatible = "img,img-rogue", .data = NULL },
> +#if IS_ENABLED(CONFIG_POWER_SEQUENCING)

Ditto.

I don't see anything wrong with allowing the driver to probe with the
compatible below.

When it then tries to hook up a pwrseq handle and fails, then the
probe function should fail. Right?

> +       {
> +               .compatible = "thead,th1520-gpu",
> +               .data = &pvr_device_data_pwrseq,
> +       },
> +#endif
> +       {
> +               .compatible = "img,img-rogue",
> +               .data = &pvr_device_data_manual,
> +       },
>
>         /*
>          * This legacy compatible string was introduced early on before the more generic
>          * "img,img-rogue" was added. Keep it around here for compatibility, but never use
>          * "img,img-axe" in new devicetrees.
>          */
> -       { .compatible = "img,img-axe", .data = NULL },
> +       {
> +               .compatible = "img,img-axe",
> +               .data = &pvr_device_data_manual,
> +       },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
> @@ -1513,4 +1535,5 @@ MODULE_DESCRIPTION(PVR_DRIVER_DESC);
>  MODULE_LICENSE("Dual MIT/GPL");
>  MODULE_IMPORT_NS("DMA_BUF");
>  MODULE_FIRMWARE("powervr/rogue_33.15.11.3_v1.fw");
> +MODULE_FIRMWARE("powervr/rogue_36.52.104.182_v1.fw");
>  MODULE_FIRMWARE("powervr/rogue_36.53.104.796_v1.fw");
> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
> index 187a07e0bd9adb2f0713ac2c8e091229f4027354..58e0e812894de19c834e1dfca427208b343eaa1c 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -18,6 +18,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#if IS_ENABLED(CONFIG_POWER_SEQUENCING)
> +#include <linux/pwrseq/consumer.h>
> +#endif
>  #include <linux/reset.h>
>  #include <linux/timer.h>
>  #include <linux/types.h>
> @@ -234,6 +237,132 @@ pvr_watchdog_init(struct pvr_device *pvr_dev)
>         return 0;
>  }
>
> +static int pvr_power_init_manual(struct pvr_device *pvr_dev)
> +{
> +       struct drm_device *drm_dev = from_pvr_device(pvr_dev);
> +       struct reset_control *reset;
> +
> +       reset = devm_reset_control_get_optional_exclusive(drm_dev->dev, NULL);
> +       if (IS_ERR(reset))
> +               return dev_err_probe(drm_dev->dev, PTR_ERR(reset),
> +                                    "failed to get gpu reset line\n");
> +
> +       pvr_dev->reset = reset;
> +
> +       return 0;
> +}
> +
> +static int pvr_power_on_sequence_manual(struct pvr_device *pvr_dev)
> +{
> +       int err;
> +
> +       err = clk_prepare_enable(pvr_dev->core_clk);
> +       if (err)
> +               return err;
> +
> +       err = clk_prepare_enable(pvr_dev->sys_clk);
> +       if (err)
> +               goto err_core_clk_disable;
> +
> +       err = clk_prepare_enable(pvr_dev->mem_clk);
> +       if (err)
> +               goto err_sys_clk_disable;
> +
> +       /*
> +        * According to the hardware manual, a delay of at least 32 clock
> +        * cycles is required between de-asserting the clkgen reset and
> +        * de-asserting the GPU reset. Assuming a worst-case scenario with
> +        * a very high GPU clock frequency, a delay of 1 microsecond is
> +        * sufficient to ensure this requirement is met across all
> +        * feasible GPU clock speeds.
> +        */
> +       udelay(1);
> +
> +       err = reset_control_deassert(pvr_dev->reset);
> +       if (err)
> +               goto err_mem_clk_disable;
> +
> +       return 0;
> +
> +err_mem_clk_disable:
> +       clk_disable_unprepare(pvr_dev->mem_clk);
> +
> +err_sys_clk_disable:
> +       clk_disable_unprepare(pvr_dev->sys_clk);
> +
> +err_core_clk_disable:
> +       clk_disable_unprepare(pvr_dev->core_clk);
> +
> +       return err;
> +}
> +
> +static int pvr_power_off_sequence_manual(struct pvr_device *pvr_dev)
> +{
> +       int err;
> +
> +       err = reset_control_assert(pvr_dev->reset);
> +
> +       clk_disable_unprepare(pvr_dev->mem_clk);
> +       clk_disable_unprepare(pvr_dev->sys_clk);
> +       clk_disable_unprepare(pvr_dev->core_clk);
> +
> +       return err;
> +}
> +
> +const struct pvr_power_sequence_ops pvr_power_sequence_ops_manual = {
> +       .init = pvr_power_init_manual,
> +       .power_on = pvr_power_on_sequence_manual,
> +       .power_off = pvr_power_off_sequence_manual,
> +};
> +
> +#if IS_ENABLED(CONFIG_POWER_SEQUENCING)

Again, this should not be needed. Instead, the call to
devm_pwrseq_get() should return an error from a stub function if
CONFIG_POWER_SEQUENCING is not set, right?

The similar should apply to pwrseq_power_on|off(), right?

> +static int pvr_power_init_pwrseq(struct pvr_device *pvr_dev)
> +{
> +       struct device *dev = from_pvr_device(pvr_dev)->dev;
> +
> +       pvr_dev->pwrseq = devm_pwrseq_get(dev, "gpu-power");
> +       if (IS_ERR(pvr_dev->pwrseq)) {
> +               /*
> +                * This platform requires a sequencer. If we can't get it, we
> +                * must return the error (including -EPROBE_DEFER to wait for
> +                * the provider to appear)
> +                */
> +               return dev_err_probe(dev, PTR_ERR(pvr_dev->pwrseq),
> +                                    "Failed to get required power sequencer\n");
> +       }
> +
> +       return 0;
> +}
> +
> +static int pvr_power_on_sequence_pwrseq(struct pvr_device *pvr_dev)
> +{
> +       return pwrseq_power_on(pvr_dev->pwrseq);
> +}
> +
> +static int pvr_power_off_sequence_pwrseq(struct pvr_device *pvr_dev)
> +{
> +       return pwrseq_power_off(pvr_dev->pwrseq);
> +}
> +
> +const struct pvr_power_sequence_ops pvr_power_sequence_ops_pwrseq = {
> +       .init = pvr_power_init_pwrseq,
> +       .power_on = pvr_power_on_sequence_pwrseq,
> +       .power_off = pvr_power_off_sequence_pwrseq,
> +};
> +#else /* IS_ENABLED(CONFIG_POWER_SEQUENCING) */
> +static int pvr_power_sequence_stub(struct pvr_device *pvr_dev)
> +{
> +       WARN_ONCE(1, "pwrseq support not enabled in kernel config\n");
> +       return -EOPNOTSUPP;
> +}
> +
> +const struct pvr_power_sequence_ops pvr_power_sequence_ops_pwrseq = {
> +       .init = pvr_power_sequence_stub,
> +       .power_on = pvr_power_sequence_stub,
> +       .power_off = pvr_power_sequence_stub,
> +};
> +#endif /* IS_ENABLED(CONFIG_POWER_SEQUENCING) */

Yeah, this looks really messy to me.

If there is something missing in the pwrseq interface to make this
simpler, let's add that instead of having to keep this if/def hacks
around.

[...]

Other than the if/def hacks, I think this looks good to me!

Kind regards
Uffe

